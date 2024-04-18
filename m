Return-Path: <linux-kernel+bounces-150275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F0C8A9CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDFBFB25C14
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324B916E868;
	Thu, 18 Apr 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VIh0Zjpu"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E516D9B9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449844; cv=none; b=Dkqzt19LuWBgclWe1rPe23IQB8zNRuvaFgjmE1S93OudRzQGITW5NxZymQaZh3mesFk36LlsFynvLaQXI2ltwB4r9IJG6tg/OuDLbJ3Qx9swt/JcPFcbTDAKj0N5iaFl1PO42I0Q3awwMgTSIVUU/06nS2uJ1f7ibaFhYILnlE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449844; c=relaxed/simple;
	bh=RqJmpnpajyvLw+L+E8GifAX8vmrSQx9ohtd5V3Opzk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cth8CwQhpDWyzLepcUE0DaIPZrjfafkmCV+9P6TB7rBcYrfC1vJw9FoKFRYRzfTKd1+I0d+6RlmfqfbPTgbudbHSmZs+FoKaMkX4pwy9pe+E6UFs3Lcr4PYFIMS2zZb/7WM9FWRRwwGyR+cDwuz+P/WbKE0rWSskZIm4cUN8K3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VIh0Zjpu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-418c0d83d18so6902825e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713449841; x=1714054641; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A95n4qk+OzmeppmcDHJlgcxg2vp1t9jUT+VVZ3XCGv8=;
        b=VIh0ZjpubdYT8EUdT7vp6+ceLZj7zXZP0ens2wkRAk9ktY+BfwkVa9OuAEKQKbgLxn
         nJAvKbpJifHsXOgkCn+GXEQDULs04FKPVGamRbAm0TLlL2OmDumIwsdVg3ddirao0DMO
         uyeF6beZv4ddouW0sAc22EcOvv5452i3A5+yMQhdWUyXl+dHeC0M6a+hOyGcdAYuuBZA
         LHa+I4pLedZRVp9MxY5a1Rx6Z1Pphu9bsnghTEOyXpjPi/CfpXSsRP09MEF9emUaNtBV
         3nH4K6Fw+P6NL4ux3TiRhrNq/xDyTITPcBRkfWmEj2489jCYqT0VlpwEOJFl9jvA536z
         K3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449841; x=1714054641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A95n4qk+OzmeppmcDHJlgcxg2vp1t9jUT+VVZ3XCGv8=;
        b=XGcDEsDKo28K7Ej2JznV6inBdVLDfmOmGntWJu4UFBvCDDdO//zI8PtveZWZKAg8R+
         C02aBRriz6ULsievW9uaCijH0/FD+051HS0EOVGGI7PQqf/u7vHvCnoDtSMvw6cHiRzs
         +03YdjlFhZvidQwmYrQ/CE2RrF+0zK9NdxQUYCo4sE/56Mu/KE9yQB2CaizvphOOm7pj
         xTV3iMwOgAxvggg8GP1Ze/S+beKNAGXrtW2PGA2TGC93dD2i8F3ShP1jyhYafqXPaWuN
         pgiMBoFsDkCsh/vzom6BuyvUwJYCHKQyGs6SALk+KuVQwZj2vIJ1x+tP5EA2ZvRxU+dU
         zBiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw+x6KcqMUBQAMVQ0D9fwzfEvrJDSWt8fVPb/H/zUG1exvjpz0C0GwOjvZSuTqk6tGxVgfr+f8VH9WYAfy28C951Y7MgZSKdi/GTOX
X-Gm-Message-State: AOJu0YyN/zkZ4OeW1K/kFa6ToFfcBEzqc/Qdgsv/u/NBY8e9YLfeRg21
	IxqHCS4bLQQSlKOtE1Vf0W9RF6SADe9R+qMdI2rK78YQ6ljv4W6XTHjhwO75tXI=
X-Google-Smtp-Source: AGHT+IF4YULCsvWkwwwfg53QmQuiwnTv5bGuVI1fQmXCyyYK/3/4b6rzPvnr3zpMfDOh+P6uhyoMDA==
X-Received: by 2002:a05:600c:1d01:b0:418:f991:70f3 with SMTP id l1-20020a05600c1d0100b00418f99170f3mr368992wms.8.1713449841187;
        Thu, 18 Apr 2024 07:17:21 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id i9-20020a05600c354900b004180c6a26b4sm6267510wmq.1.2024.04.18.07.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:17:20 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 18 Apr 2024 16:16:55 +0200
Subject: [PATCH v3 07/17] dt-bindings: display: mediatek: dpi: add
 compatible for MT8365
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v3-7-53388f3ed34b@baylibre.com>
References: <20231023-display-support-v3-0-53388f3ed34b@baylibre.com>
In-Reply-To: <20231023-display-support-v3-0-53388f3ed34b@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Fabien Parent <fparent@baylibre.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=RqJmpnpajyvLw+L+E8GifAX8vmrSQx9ohtd5V3Opzk8=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmIStiiccS2/CHLvgvZSrpjPICthqNkoAqRcoDoW6S
 2gSyudmJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZiErYgAKCRArRkmdfjHURdNjD/
 9SlFNusJrPYkweUcHXLeozsIQWKFiZuo/9SIS9nySjCqGVF4stQP8TvKOQV2Hr556zdgKw52kw3ujV
 aa6XgY5nxnsuWanKvXkY6T1niKytAaHsN/rK/vt98+AumfpMLwc7pIhQ5XrwglNUx7PqMDK0UYx/ND
 BlFmdZcgbaXm6HY7SqZ1d/oidoqhDa4Wr+d+fLwiUJPC5qJ9rWkBAVJ5FuXD0rGVBbu9m+M7JG0+uw
 4b1c6n/GyfiDCOLCg6+aTgkVbzsjNxCVihXU9YI6B7QwHBfbYQECzhzopCcsRuwJckIR677Hpenj18
 7LbZwmbNBREmKXmfMCuB7AJIgaDK8eQp9sw28TxKUQwuyfGCRcGqYREcImDOGW0FmxdLD4b9Ot81eN
 /g8hlHrHs3nBgUBIIGcswvCj9oDqnkiF8Dvp2GU0Vkzn11iduL4bvivgYs0qIH8b2Z9vvK9s2BKdAm
 KiPQsS3+kUDnWgi4Mz7blpAttddVstOVX/DLRLJlsh8p+wuSxPQr0l0WvwervVe4+2ZGDbSAOE+aRP
 mkgoC1/LfOKKXNsGyHRoBguRRlX1+eRDO7PbNVWkxIGLESQOgKXpfkXpiX8VDlRQ2aTuEENrXN+ISu
 mUjkNdi1VEJcnQRE3vs3PzRbDQi7gBh3Vjaj2Kmwy9AfCJ5QYl98CcN6XBfQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add dt-binding documentation of dpi for MediaTek MT8365 SoC.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index e126486e8eac..75d0caa4ccdc 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -31,6 +31,10 @@ properties:
           - enum:
               - mediatek,mt6795-dpi
           - const: mediatek,mt8183-dpi
+      - items:
+          - enum:
+              - mediatek,mt8365-dpi
+          - const: mediatek,mt8192-dpi
 
   reg:
     maxItems: 1

-- 
2.25.1



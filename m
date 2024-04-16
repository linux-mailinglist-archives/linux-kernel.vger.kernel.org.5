Return-Path: <linux-kernel+bounces-147171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721578A707A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94ABB1C219EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EA11384B9;
	Tue, 16 Apr 2024 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JhNkY0GI"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829BD137C4E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282813; cv=none; b=RXksnDZx6NJ20l/JbTRa+ndDL6h6hLS3/N6fWwbk9Q/IlM8as6UcuOcXGxBfLgVzmNcxpkNDA+auB5Ftj2xkz2AlvXY9y6tA1fbX2zxqbxsU0pnB+QzsAyddrDUjXw+uSof4KxKHG+MNXIL8U5jP3JJjBQr0uSM9pYqfkc5IbTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282813; c=relaxed/simple;
	bh=YWP6Shg60EA2OeIESWvWTK3n/fUHPgAwJXUBa6PIbUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u1Ccqr+64D4oEKiEWyBEWG2lQdCEN5CPKTMalBXK4AOmhnfrUPwiMwd6+3Q/y5rUPhRAcSTd3++Dn5VkhOy7/3uY3cofkcHvyPzoIzsNwcY7HpCZdzINpVovUJDWdCCa+z07heU3PV4e/H+H9uhIHDwG5QaU1iOWZMH1DiEPTig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JhNkY0GI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a554afec54eso51268666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713282809; x=1713887609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlEeWD9RdnsW9I9f2pYuDWO+bMLMc/qQZCTcLBo8+zE=;
        b=JhNkY0GINCXXlEPOF0oZylLd4Lv0gzTOOeTXNREWlWT+1pkuF2F2re/y5jq+2omAkZ
         hMDd6RijMh7kRPhBCuA4sJHvFePKMGh0v1O8M6iYIO98Zq6EjXKsVRY/aCl0sG0AagMQ
         fVDb3yGX5FnxAJlRCeDKwx3D1Ccz1OreyzvZKCHaI1pS0PJcbaKycjfKBQs8oIZcfGNO
         Dv5SnbBzItlBHell2Vw88h6DxF/u+akxRNLzUNgSPIwMKe//tWy2WO3BFgkn9ZJeZNXn
         uAPauKApCnA68x26v/zgVG5Cc/e3V60SeC341fH/3RhWP1wXK18j+H3UhVCTWbFoDUpF
         SnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282809; x=1713887609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlEeWD9RdnsW9I9f2pYuDWO+bMLMc/qQZCTcLBo8+zE=;
        b=Vl9jytJcwq21kST78ELMiYeAoLEExsWs4ip1s402B60xoRFoh87QfKAOD8fTdPiMK/
         B4viTr07ogkh+e/SBDCygu/dgRcwOP7AtWEchIXpjao5KRdMQqJLnURGAQodjKuQbXPo
         280W6QAwwc1sVoZz5/CBN7+ICmCNLzdpI23iqRXTR4Lqyal+sKeNb5lz/TPhu2kHwwlt
         xxR6jr3v6OQvy7s99MuH93s1mXPKfazF4QjyetM3Xc9iJmJYnIhOBK00awenXwu4at0J
         nIh7j28t9yAbXIJs2Gcpd5AU5upkMVTh5f9q1RavKPevPtdNTO06LVmQCyOFAVjCw1IH
         Z+7g==
X-Forwarded-Encrypted: i=1; AJvYcCUnv7OToMU6iFLi+gmuVXtYwAiC40/PC4d+HW7lBOJHP/CwpzJ1Vd7OWLvaIVBVrOc32sUXvctd/kv6lEnIJoKfFuk8o4fSMpSp0EQJ
X-Gm-Message-State: AOJu0YweT99b9gQofZ7ULqyh6V/2OS2vB7z5MAM76YIPOX2eKEM98Zwg
	2yJ/qIbizXlCQNH3SPY69EZ/ViuMc2OI3FiRwDC+MhnYIN6d3pg9dh6wgf+Tfkg=
X-Google-Smtp-Source: AGHT+IGMWP9H9D4wzeHmwqDmsjpmBqo8fF0N4Tb8Pg/HmubZGeYeU7yYfzmd9JEPX/7zZD0PHDYCpQ==
X-Received: by 2002:a17:907:7295:b0:a46:bfe2:521f with SMTP id dt21-20020a170907729500b00a46bfe2521fmr11781457ejc.24.1713282809191;
        Tue, 16 Apr 2024 08:53:29 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170906174c00b00a52567ca1b6sm4156691eje.94.2024.04.16.08.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:28 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 16 Apr 2024 17:53:08 +0200
Subject: [PATCH v2 07/18] dt-bindings: display: mediatek: dpi: add
 compatible for MT8365
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v2-7-33ce8864b227@baylibre.com>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
In-Reply-To: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=851; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=YWP6Shg60EA2OeIESWvWTK3n/fUHPgAwJXUBa6PIbUc=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmHp7qJwFj8bEMicWa1Bd+Yv6HZMqP10hORk70wmm9
 Ht3VxpOJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZh6e6gAKCRArRkmdfjHURcT2EA
 CQ9k4lzES7KrQb47lreloJoMbPkvR8BDltlnR9VGr1Y3rPz/eF0yVklAOkRZkQgmivBuogIC2/FMW3
 3Mqpb2eIx+lAQ10nRe+izPrsgV1mRX2WnDQa2lRtyzHLhBLPg45ZHYCDvB8qAoFfKbc8ynT/rnsZAV
 9wGHe8w/DqyrVOfNu1M9wmJ5h46WJbQme2Ou+kGRWQZsDi+IbixOTgy7LzkMzkrf4eSrPjH2uyn1gt
 4H3ioqP4qOoXM+As4EGwF4x53sUiArvvyEW2D4M283Ozf+n3x7q4H/Bei+yc+Ip//Xja5v8l+2uFXy
 r9LTcfa4vMDDM7xAYZkKKTf3vy4HvrJbJKnD7T4itpL0ZD865d2dJM+ZvOaEXGke0eeQFYGLMccBpP
 n7NWDxz88lZZEjYrx/0nGR+fQmfjFRlknZJ2eFFwfIKvUtiBf0yKsNAL7/5k5yQx0KxtB8saq829hK
 mQUjGL4ZKGe/dGV7OMR1QRcFKKRMHBya93+5TrmW+D49qOGVGvzmiPysmJiOxXhySbyUsQsBDdrPme
 xdG/CnNLMBc5VEpKF/wVF9/dZgrURBCwWJCRySXAAptdcd52ED6yYKjjNlsF8zpdi5veP+b22s2owS
 hLBf9RV7LIM56p4qEDNzzg7TXLX/CEHbXzR9GdetcCOZ9n8wi/QYDGrF8BMg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add dt-binding documentation of dpi for MediaTek MT8365 SoC.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index e126486e8eac..ebb61bc4eab7 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -27,6 +27,7 @@ properties:
           - mediatek,mt8188-dp-intf
           - mediatek,mt8192-dpi
           - mediatek,mt8195-dp-intf
+          - mediatek,mt8365-dpi
       - items:
           - enum:
               - mediatek,mt6795-dpi

-- 
2.25.1



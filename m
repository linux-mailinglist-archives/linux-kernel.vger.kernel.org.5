Return-Path: <linux-kernel+bounces-150272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFAB8A9CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D83EB25972
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6828D16C6A1;
	Thu, 18 Apr 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bCNXAKyR"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999ED16C848
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449840; cv=none; b=Pf2XH5ryrnr6pWfAeahzhkoL+XII6wimqMyyOMv0+vIX0fYwln0iAG1FqH9a1a9Em/SUu0Pu6K39b88fSPHSMWtj7fVEmUcbgbJN8+0yTxRO8M4lwbcCVaJOCEcWpbJrrMnStQxKGwwJdJfW8ImLsD9BTdEUmC0Ofh6gWRpF2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449840; c=relaxed/simple;
	bh=zzCIaD8rTG1/kp/ZSileQtlNEnXTYcjPAL1DZHwA70o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BKCkf4mzRHXMDtv2319ef5txbm9qOr/ws5hvw2KJsjmYK+uAcszuHHyL5M8BDc+CJWNO/hXPtDBm/e96oadyS+SB8sUcNlw4IOhl3wIxsbW5ivw+EtbFGg4os2AyRnZoEweFSe0ZTzZAZTjPNY5zebSSQ845rHfEfCD56Juj3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bCNXAKyR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-418effbc70cso3842765e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713449836; x=1714054636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwD5iNVfbehYnKEJbnpi7hogz0EJMx8yqC29CXBFCDM=;
        b=bCNXAKyRycA8XabML1BimSpkDtB57zhUkKt+AaYAC1uXJh43hcPEZX6Drzgb4geGy4
         Fv/O3VyYM34++EX2eunixf1XMvJ9feSJaZhoa1924RH+BNe2rf3gPtoNypo2sP3SXBCu
         EUae+kj/Noshj0rsCtZER0Lbji/wBto0KAULAQuz18GCOd5TllYZjCUXcYFRNZgReRl/
         OlSPFd8f8JB33UF9J77WSPiGEHJEmPPn0AhchvcwbG3VRxuHJTBxV5pKf7YwzJVI0wT1
         eafHkrKYtDvyoPvTdriBVVdi3A92k4Y55LS0B4WPmYm9xBh25hpcTFSfBIHVo0LKgipH
         6a1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449836; x=1714054636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwD5iNVfbehYnKEJbnpi7hogz0EJMx8yqC29CXBFCDM=;
        b=l4szx+6V/udqCB1MBxFBrVhdkTf4E16dYd0taTgGc1nUfxdtl5884yajLrW/oG3cb5
         1ejH3Ewp09YhEUkYXMO88GBon17/cxQNgfjFbBc8xgMbJGWtLvIg9pCc2utLCIhxZHq5
         zBsA7hl0UUyMvQr8BuiZT3bMqTqpPvQ9O/mmlnM4oJsmBxhKpmNelLpVNSWa/2M+CWgL
         13zmRuuP6LZd837qhzhWAZ5jcz2Zwiibys8JUlGDVrelw75Xuy6WPx58/P4PfyDjmCxf
         tUJf8+Oeb+adVfu6/DRm70KuNwFf2xWPKYyh343ObDS7WZrvXme1BlYdXNlZ0nt4OERL
         6liA==
X-Forwarded-Encrypted: i=1; AJvYcCWpgTOydrgUakBvE7Yex8K8wDj8fOYdZ/daXqgEyfBVF2+fU7gu2Cn5XeNU+MXIGA83tpsFXfmtZgPFl34OBIk+6a74UAd94finXtLu
X-Gm-Message-State: AOJu0Yy9Pr/NvniHDTIAK04ivC6rzCPDNfVkh0dDGdHgDBrS3/DjQRnu
	DN83hvpIBYvNb8Ad4ULsQlwTa2BApcyevTumsM5ICm4mj4DlxkXhyONuXEDOT78=
X-Google-Smtp-Source: AGHT+IER62CdAE5/5oot4D2adTIVLRgUG/egF1vr5z7vePcV4RnBSZGtaXvV2hHCju1kll+OUBkpwA==
X-Received: by 2002:a05:600c:a12:b0:414:8abb:a96b with SMTP id z18-20020a05600c0a1200b004148abba96bmr2014596wmp.34.1713449836080;
        Thu, 18 Apr 2024 07:17:16 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id i9-20020a05600c354900b004180c6a26b4sm6267510wmq.1.2024.04.18.07.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:17:15 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 18 Apr 2024 16:16:52 +0200
Subject: [PATCH v3 04/17] dt-bindings: display: mediatek: dither: add
 compatible for MT8365 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v3-4-53388f3ed34b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=zzCIaD8rTG1/kp/ZSileQtlNEnXTYcjPAL1DZHwA70o=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmIStitcbsX009PW5cbVFw1hXuGllJFI83TYn8zPhf
 rz/CcdeJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZiErYgAKCRArRkmdfjHURWNHEA
 CaKphXLr+uLHFI1nnefySVhPPO7is8O4I83eRLO4ymwrkeRxbJehmGXVQBbDqnwu5zjiP9BmmbP4R/
 Y0EVmGTML8JP7vH36fZ6AdfyOiZv6PLmpmQa/J0q2jhqpqnrFAZR0Qi+jt5XK+iKNEiqgToAOL8+LD
 pTwpgqfioGAjnRQAGLOIK6EvuAhrH/20NKL/PupWSb70Q/S6OyFX0Y6mGMOTeuHUXF1ergSHLcL1HF
 0XxUf2EH6vfCheLvExdzBlo5HvULGi4cSriAWBcQhKE5sgMIva7bMRF4QuyFcbcu5GUQVR6AlYb4/z
 l5YxaiDyxWKJVUM/Sg3yiI2fkS8HEF4B1KZDsmzo2j+vE5oXK1KwU2XzU9Yj7B/OWv3XIgFbbD8N+d
 xoV7Z8mhSCPE1zhfOPI4r4p0Vvi8LnuoadKK+rZd3fcmVYmX8hIA6RJ61z+cea1rgTkyd5qfty2yh0
 FR2z0DLsOJtyX3TKVXcFcU/vhq4YrS5cZvaIvACh35XH7UUWxMvaPJtPEZYXWiNtmUUuBu6QQIzHsB
 JPEKRk9/8aySxzP1IjYviwc7nuwqUCWDHug+A4+0KuffSSISRMUM6ReUhGazF7tbJIscFuZVWcI3Nl
 MdCF7okXP0MmThxayji4DOb68QmXDGLOLn1ONLwyZZVH2md/eHgFjvBLh6xA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Document the display Dither on MT8365, which is compatible
with that of the MT8183.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
index 1588b3f7cec7..6fceb1f95d2a 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
@@ -30,6 +30,7 @@ properties:
               - mediatek,mt8188-disp-dither
               - mediatek,mt8192-disp-dither
               - mediatek,mt8195-disp-dither
+              - mediatek,mt8365-disp-dither
           - const: mediatek,mt8183-disp-dither
 
   reg:

-- 
2.25.1



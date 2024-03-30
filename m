Return-Path: <linux-kernel+bounces-125871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5439F892D4B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B61B21F29
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E8556759;
	Sat, 30 Mar 2024 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MurMGD+a"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F2054FAA
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831422; cv=none; b=lYuljAsRSO4OD/mcqd0QtDObmBhFhaSB7b/tl2IS1/prGnpxlGPHOYpKf7SFCOI17cHbnOe88WDBezERmrMAMFjUkNJ32NhnIG7JMuXXcETcw670/aQWsKeh05TFshhVRTqPeVrZjMMTZh58KiKENZgj/GnR5aOTWwim/K9IVxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831422; c=relaxed/simple;
	bh=Xx8KP882juDZyxUVOCDSGgYxDLvUN7i/bRZCWIrU9k0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EGYnmSnbvXH+N6205YoYTaGGV1sMnprH7GpJyqvVfaoox78YGAp4oxy5NIvR6jPNctisZjYENGlRuucmRVH1EryZb42n1NF4eFtPMkKDJhvoe7P6GTLcNuHbJ9zG/AipLM76/H+R+lj8ePcex8UbJzsTO9df+hWTR524r1zoJ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MurMGD+a; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-341b9f6fb2eso2079472f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831418; x=1712436218; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrZ4GhO9wf44T+ecEEcNLW7XVBn6abcNvXfy8r76/zw=;
        b=MurMGD+aYtEnQ+nCSFaWoyKbDwY5fX7035wHA+ULEXAEZVLKthC29dU6u1VByPm/Ap
         Ts+lASui0SX8IrzCHpPOfpyhCXKSHoJ9WIx5mVHIbtRfDePuXanIH5+um9xSzRjSeSzQ
         eYPeQgnPzDUPFaoMX+P88UI41EpTEVd0wC7LeIpJXiHVx2z1f/RQWS8/L7OE2sYwZ97b
         h0g7TIuCWrjxYqBNUXHRBnnpLMt9G+RDX9fedbRDTvIKx+FJyjHzOUFf5kN8GHU9hh7E
         MQwckRmBYXDFohKGQnRX94vqtgTMaybVjDzHOtQRS5XBiMVDq4EKMZqiRwJDPMXTvnYP
         j8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831418; x=1712436218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrZ4GhO9wf44T+ecEEcNLW7XVBn6abcNvXfy8r76/zw=;
        b=SmVSjYm6rW1F0MAU1nEtXK7cUbUfrjaP/yaNXrljDZkH4ErPvA2nNPlsTgRgF1X30T
         2PQFgBYWkteQ+hZGV3Gprsxzx9t7AYJllWS33rdhP1Cnp/5UeFhzd/z7DGFiYaJTSKMk
         rCH7kEqsl9V/yKo8gVx9o9zVkMkOmvGwBZNXZOPg028YInbKhdGr1RrNKKl9Hx14n2FK
         CPsoS7RDIGz9qshlg/ALdwyDPy0Tjo/Ngo2lF//4kAsX8n8ABh2O9Pj95h2T5dFOdQsO
         /22w9HfW7RflWF3lrebOmK9acRoPbwD0ZltVsxl7WWB36XuzCWX35NZm83QB0gK9Ov+G
         /B/w==
X-Forwarded-Encrypted: i=1; AJvYcCXnMgzX9SDCstFE8+plDFLpVoEr7y8WTg6o8TKkVYHLzNpit3ggVRhksKqBg4Hckvm58J0fDirJeAOk+g9obtaiKezNrHpxImw+Zq1Q
X-Gm-Message-State: AOJu0Yz2xPdCxcyBcnYw31e1QqhE2If3ZvqurVZ/GZ7BHNdLYpDcZDtU
	6eOx39xQNKgGrM8cyHEu23UgRYUWW1B7eov9BhzeT7zaGYC7A+/hkD40hnHZnfng//vmBECuu8s
	A
X-Google-Smtp-Source: AGHT+IE0PKWcklEiY/N3DN55kHettlS7ue1JIpmWZl/a0EdNno4I1Sh1h02er5fS9u4AqXd8tM05HQ==
X-Received: by 2002:adf:f645:0:b0:33e:c522:a071 with SMTP id x5-20020adff645000000b0033ec522a071mr4191961wrp.51.1711831418298;
        Sat, 30 Mar 2024 13:43:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b0033e7b05edf3sm7231299wrq.44.2024.03.30.13.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:43:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:43:18 +0100
Subject: [PATCH 07/11] drm/mediatek: ovl_adaptor: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-mediatek-v1-7-fd5c4b8d633e@linaro.org>
References: <20240330-b4-module-owner-drm-mediatek-v1-0-fd5c4b8d633e@linaro.org>
In-Reply-To: <20240330-b4-module-owner-drm-mediatek-v1-0-fd5c4b8d633e@linaro.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=851;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Xx8KP882juDZyxUVOCDSGgYxDLvUN7i/bRZCWIrU9k0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHlqtSIEZvgyYm0QNmdSoI/0Wde11KsnG/jUJ
 m7Cc1tVbx2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh5agAKCRDBN2bmhouD
 149aD/0UGMkv565y8FhNpp9HZfNQ34nUp3vU7wEYkdZOgitnzav09vI0i7+j+yW47eieNyoiE9y
 3+qIAbw4PT2fQ63Zm08uVzvJiTQSq3vQ5qfDgqWqcL58EbJBxZaWHMZRdeX+v5MTtkqAx/ahWsS
 /uzTY8BAgaOtMXkuvjnsAK09Mj0uY0iMXCuS50aS8bgTVV5Lz+XkAO4De99j+XB/SLetcPoHwmh
 Fw8sZDXVfJvQrnT8KeavVse4dsQQYaMAnADfsS+JFmqn+38zoDpM3trwMisX8g//g7smDvTp5z9
 hgvEJ3W4nnUzhoPK5UCux/ukE1TDZMx2TkQzCzsWacw/siMas8BedF9aEQLbwWisucG6Q6zJt40
 Bw+eoNNzya6MiljOu/7qB7XjlIEU2PzXI3OW+mp7wsne5CPK3sfyi3xV4ed4jebTOjKcrYy9tPA
 3NsOmpkXbPhwdRT6MRxHgCXjyJtL54cMp9a/xUivPijNbW7wrHweepjHL+8Jq+DKwJp7DYAkiJA
 02Sg83YMIfaaiyBsvHD8sQ1kXwEhmkTIC0y7IKFI67urmorvN3REG0tF8zznMdp+eUfn94KgNuJ
 CBMenub5TWPNVI3yF/8Fd4pSU1z+XD7xMZPv7NAjF2eeeFWyNo87r+hi4f0V65Cs9xn8xHp2J1r
 EFmG3PHwCdoDlMw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index 034d31824d4d..72fd5a095960 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -629,6 +629,5 @@ struct platform_driver mtk_disp_ovl_adaptor_driver = {
 	.remove_new	= mtk_disp_ovl_adaptor_remove,
 	.driver		= {
 		.name	= "mediatek-disp-ovl-adaptor",
-		.owner	= THIS_MODULE,
 	},
 };

-- 
2.34.1



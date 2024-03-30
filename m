Return-Path: <linux-kernel+bounces-125868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01106892D48
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BCCB22341
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273CB53E1E;
	Sat, 30 Mar 2024 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmCwlH9N"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC034F217
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831417; cv=none; b=VeihB7G5A8mK9b5C7RVZcHShba6NAUWyiwFZXqFWXetL2d3R/yIkvFmeyeAj+4f97/GxpuHjQKfRh6HSFiSrdnCbdBTzcOWuPwv6h0m5lWM1S/gjMuj0ciX9074Ufiv8Gcu9pcPS/aqGi+KEcftixCv6X8m5WLvELX08H1kIwKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831417; c=relaxed/simple;
	bh=fEKPyt5MKP0ErlDj1eUkq/Xkd/ayVcNlQIh45H48Y8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJ6KDoCAN1U/wWc6ROv7Dm+HE5SFDWnocJEdCyae7hV+qdFy1BxZX3sefrfYesIVY+qYzzp3jopVFWC78Rn8csFDDa0hJJcdU+WZ5KcPkaQX6JKxvya1Fso7IHkrPTdJGVYNqzHTIi3KSlLO2NWr3XZ680K6da3XeRxzaG/vF84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UmCwlH9N; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-341cf77b86bso2033277f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831414; x=1712436214; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2SriLcn9TJO3LgQJx20T2AIgEEtOSgbbLiOwdTXH8A=;
        b=UmCwlH9NF1CSUgeN27aSGvaMavz1hVsWN0WzBwQigy4gbafITMyO5pVcUf+Cq4LiGF
         tTnM1TF86LDEyyVqHTayKd2sEtpfZVlWfkdY6h1RqtgsQ5WamG1Q35W8kPHxYabbm5cj
         E4vbVsR+Hw5pnL5kkBS8Yk3TtFJhmtfkpGx2AKBHbeCRxNz9ReaX++uCBnQvEV5YKM+N
         7v8qh51OP1tHJtnClVajUjS8kkYrFCTCD7KBQmENibl9qgbrtq5UicCRbXuo3hvbn9Ci
         +roNxXcapuZlEpwAOK1XoB+EZSAObU6D/IXzXd4Wllr5qR4ym8AW+w+84cODPOvyaHwf
         T8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831414; x=1712436214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2SriLcn9TJO3LgQJx20T2AIgEEtOSgbbLiOwdTXH8A=;
        b=LZFGvX0Z7aH0DwRMu0HpwHoZ3ERuvAR/OxfjqViEmYE1vEWiTyKziwGNQHKb59APc/
         E0bdYjk/lFsH0WpYJ4IaHk5hiPIHKCVCbtKS7VSl5QV8SS9I16f8yHekXTjCrPWWM4PC
         2eVgEKjbwRd5WuI1TQTNaydxeA368lGeqefPbubEUr8tWw2QaYQU3U+LQggNamQzVQoF
         1669gvub8CZraXDgbucVSCDV5aAvQkhgEV2h1TwSki5Vejh0HBoLY+ywAWBpm5FXRWJ1
         BNLJtEIQfktcoDTYqKCyIYAerZlq5bSG8mNkcxreCn/n3MdpVtVtp9ubR8B3SdXij+bh
         LmnA==
X-Forwarded-Encrypted: i=1; AJvYcCVzejSZBF/800ls8AUay0r0ai3gAOCm+LDoKDzvXzSg7J0S+gcQKKu9pRve3IdFHdjsBnBlxHoQ4Dpal70ZDy72SR+8ilOxKff7vs5g
X-Gm-Message-State: AOJu0YxXAvnnFzrlYe8tNe3COljut+2PPXgJDn6bahzg3O+PlZxUYL82
	Z8ppSpvYKr3aO3DQ6t8XyT9/0AwBb+eE1jciJEcugKbrn/1nglw8p449LA56ebLBQKswxcpld8v
	l
X-Google-Smtp-Source: AGHT+IFvLt93H7dQNeEDZguMmmS4FNRGep53208CGmKxPVfo+bNUGLha89NjiS6FAQW3YrbqOBbHaw==
X-Received: by 2002:a5d:6188:0:b0:341:9a78:c008 with SMTP id j8-20020a5d6188000000b003419a78c008mr4014410wru.49.1711831413830;
        Sat, 30 Mar 2024 13:43:33 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b0033e7b05edf3sm7231299wrq.44.2024.03.30.13.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:43:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:43:15 +0100
Subject: [PATCH 04/11] drm/mediatek: gamma: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-mediatek-v1-4-fd5c4b8d633e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=857;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=fEKPyt5MKP0ErlDj1eUkq/Xkd/ayVcNlQIh45H48Y8g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHlngBYZ9rPEtMEx31DNrPcnol9e/jXK/FMCZ
 lDKDZ5jf7mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh5ZwAKCRDBN2bmhouD
 17gKD/9p5cCATU5vVXAAZCgUsG7dmcij8oCywqqHS3x1Qq0cqPf7gr0Zd/kpFMF1DdMssMO0dYX
 XK7W92I8IUSdDg22IuZWSH8ktqIHU1QzMdorcsI3oiZjH+6qojx5ap/zSkLg10eMaPFhuoCmQBP
 ds8yx6F1mVZKXmONhr5F1u+1P085CKvcOP02uc66hD0CFKL6yXENg87oZBt/dOVdcCBH0fKv7Hz
 InfN+dHnfxDrJYpHtgdeMgmJWcwcACXLkwTGy7TlO9mk5B+kuXdRWKOV9S37FnmU59Lp1Cro/bB
 mb/P6G+cwMdrwhTWf/lZ49Xpz36va0+Ddsc9/g4c1pwgmJtxg6jPyYTR9Oo4uf8MJ5QB1NEBZiX
 Rk2wDpM/nOzZ07aA+EF12Ij3jc+gcE4XWeq2kKkaDWIRZSAxB3hy9lVhSvMlQtAAcXa0KIX7GY7
 n0GxR5pdUlG9W59F7jKWb6epcbyTJFJ0eIORf2OC+UTxQtHmKBFcotReUBCMrKthgTkoymYiJIQ
 hG2DXYW9URO39vmMcIq/VK+wXSLn2i+5qYKEu3KCzSGG6vxU516hb3SLLe7JIQA2/4oAuKCSxmN
 0yIc8n+hOk313lvKKpKcYIVRR7aWzFLKid9WLShyO785eU/AlKBTQE9ptt2jQlK8vKJ+2kmpolU
 HQb4rLJV/rv9dIg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index c1bc8b00d938..572f0716a0f1 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -334,7 +334,6 @@ struct platform_driver mtk_disp_gamma_driver = {
 	.remove_new	= mtk_disp_gamma_remove,
 	.driver		= {
 		.name	= "mediatek-disp-gamma",
-		.owner	= THIS_MODULE,
 		.of_match_table = mtk_disp_gamma_driver_dt_match,
 	},
 };

-- 
2.34.1



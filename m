Return-Path: <linux-kernel+bounces-125850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581AC892D14
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118BA280941
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC67947F47;
	Sat, 30 Mar 2024 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJgpdSWh"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679EF3BBC2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830809; cv=none; b=rxaRj6gaSzXs8tSUxiAbQB7ps5HJUlVj0Wl2qcXkaPjCLZMsyuiZ2byzeCyfURKDHwRh/3IKG7HS/UNt0t/9yBsHCuKTYh2+2sVGES61oCOwXdc4s4jU0AHmoTLfSNtW5MIxt9w733zbifAGJKIoxutn8W84ZFkpZ/0oVg7T/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830809; c=relaxed/simple;
	bh=tldT1/fBoaq2haWADAIe5Xo4h0FdGGOuKzR2j/SWneg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wx/NGsYRZNUNw/F7dlKkTisrHur5LMGJyj8bynNBSS1XbIf1TZxkLyNAhIur+25VXMU5mvEFARBYbVFWR9z+CPrKcEgKgx9N737hIVBl3h51K9q36Z8wA9cmY1vwIFPj2txc3FBtMv/ragCiDxdWz1TPjvmsnZs/pWz/0B5ihTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xJgpdSWh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3417a3151c5so1936953f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711830806; x=1712435606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1D2GKKtgBLQaWU6UCZfIYuzr/yBjzb0mw3ATsAKHlc=;
        b=xJgpdSWhHd6DeXreFZ8gqL9MOM0guPWywTj0SZw4pT+ohhKEyHTVPtBfbkBzv/2hrI
         teM2QN+Wr+6kKF06KVy4C+Mto9AmIPLh20NB1/qlGfNI5P73rCGC8mlppQ1bAskBlVLz
         NELLAt/BOmcxPYNF8jrJfgG1wHrMj9mF1UDTCkaVRygr09Nv1Mhc9u9j7gtj3Qduk7qD
         Pa3QILAqqpnwjTfFFdnT2opeozU7tq9DlLaNtLjj8C7wmaCr0KtsxBMw+wauWG09QV7P
         DVArt+2f+0coqkSVxkJ4soPPKUmDz3mIiOHA0BSFfT/n1CYSkR3AnmJ/G7+nNu+6uRSM
         fyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711830806; x=1712435606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1D2GKKtgBLQaWU6UCZfIYuzr/yBjzb0mw3ATsAKHlc=;
        b=cRKC8o/Ob4E/96bt0DG4nrlx8l1u5DsSBdas6DiKdDDvBSpbUbYdFGFBIjt+sZwqEi
         jd373rw9WjWBbS/7RoJ81WjSZUPTau3WLhg9ZIJaqFWMGqt2zkeOmLBnyIx8CE7O89+C
         CY5AJBzYllxy50MnDsZzadYlukFrOkXNFBeYXm9LhoelTN9h1ipO7ICeaKEo5oTZvuNU
         3OlLBFKmwPAKwsgY+9Z39qOTC25QPZiw9LrF/ozPpdaUiUe/TeNtfTcIrijJdTkNjRAG
         QLxurAGS2VnjB622sikjlBFEyws636cc6vuwvLLidq4m12BoHIaza2SBZrOgcTuVo0rJ
         vrKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe2ShH+Sq+tScPcpSC16JXnmAO+ibnSsAKE07TycjrTU5yFVer31goO17X9chWlHrQqIM7HU9ITKUrwezgFhtGViiRn18gMHXjwdom
X-Gm-Message-State: AOJu0YwRpWlVebcbP1mjKK7hDNlLZkVpoamoFxhcMMXtxazx3vt5xcbA
	0Ptw9hdd9H/mZH7gEji1KujMFZlBT00VFxI2UOfrPNUi0IHyQzfiENmQR6DhzvU=
X-Google-Smtp-Source: AGHT+IGigQOgLeBcNolGJLhXejMHYggnr7rlgEmT1AFz4irqhKtcDbgROMKs7R/eC3QUNH6//jsQTg==
X-Received: by 2002:adf:e008:0:b0:341:cfd6:42af with SMTP id s8-20020adfe008000000b00341cfd642afmr3985234wrh.31.1711830805823;
        Sat, 30 Mar 2024 13:33:25 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f14-20020adfc98e000000b0033b48190e5esm7209315wrh.67.2024.03.30.13.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:33:25 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:33:08 +0100
Subject: [PATCH 04/11] drm/exynos: g2d: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-exynos-v1-4-3fa30e2c7e5a@linaro.org>
References: <20240330-b4-module-owner-drm-exynos-v1-0-3fa30e2c7e5a@linaro.org>
In-Reply-To: <20240330-b4-module-owner-drm-exynos-v1-0-3fa30e2c7e5a@linaro.org>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=834;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=tldT1/fBoaq2haWADAIe5Xo4h0FdGGOuKzR2j/SWneg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHcHRsjhC/8++OmeIDCP4tqjryqtoKoVzciO7
 VIxxbv5MdKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh3BwAKCRDBN2bmhouD
 10FzD/9sgSJFn88mos0b9+dalUSJHv9/5d+greBogCsP4KUY+UK0dNbKEwexYK8uQEtBpG330xH
 huJDju4xA/490ixgB/b325Mf93NmO9wVJ9eK2yrN3k009JCGCG3cqlW0n9R6rIebI4gRiguDoPI
 L1s/jRlM/3B9KOyLcmiVR5VBrPK6QWha7dt20PcXNt6mOV1TUXuQHyGAygx8bqLplJmJamkRb/Y
 rj74/B6p659THl2KY7ZPdEaX9hBGaQNAZepB9AkKFNHZsVbkIVJoOUNy9sf0gps7RWJa2n24DUo
 7VAyIDFCG6LjAn0oEZNv7Vz0hcaIMnGooe18HoTA65RAdmXqaEB1xYaBPnUIaF1B8kDGay3da3e
 E7zJt7Mf0960ZZzPNkI/tFcL/5eBuwD8wJBjB8vpt8LyHU+e9WLPFKvZetDMCjmoqoOvcyjaqDc
 UVGw2dKGlwqyRQQBxFr719wirWRcErjCIiGqtu0GG+TMIgbIjhF4dNu4YC0myPJhTj1ykyiktrY
 2emo+1ANcg2VffN1aXXBOXGuCahFvSszjngEtGW7NrZ7hsHBnCevoMuIj+wFl/mk9lw7vWMmVzx
 2y7TFr69ken47MR+fa4MNGHyDqFeNNP/OcSG6y/tynCpDs6UQhjxfALtFwRXjaQWI3xsmT+31vy
 HqAZTSebw1ndfOg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index f3138423612e..3a3b2c00e400 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1610,7 +1610,6 @@ struct platform_driver g2d_driver = {
 	.remove_new	= g2d_remove,
 	.driver		= {
 		.name	= "exynos-drm-g2d",
-		.owner	= THIS_MODULE,
 		.pm	= pm_ptr(&g2d_pm_ops),
 		.of_match_table = exynos_g2d_match,
 	},

-- 
2.34.1



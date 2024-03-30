Return-Path: <linux-kernel+bounces-125851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8647B892D16
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D661C216A8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4689E54F83;
	Sat, 30 Mar 2024 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BO8QUpvd"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA6452F70
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830810; cv=none; b=R5meoBZs2ASOiBe5HsEic8C/AvHfi9V7bR37qzdLT3grrMSZSd+a4uWoWuXyzGbxmHXeB52oGXOEWup1qLNntNHKmfiXrzrZLMdVv7sHRlwgT21YlRJklUqqc1HO9yOEHyD4xg64dEF5qWd3g1aA/InPnpTsd7U3uF/Z4JZulI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830810; c=relaxed/simple;
	bh=E6DDT3xCv3BWpcxdM1wHQ30TS7jHa8YzU1AqhlUDJAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gK5bNYrmt6lT0t+52/897Ut16CPWE0clQpCU3pUdZQi8kZ/a4cDvjMXmV+jz8TH5BIts/aR2cise7e1LZMOg8BlZbFHVbUpT+PpSsGUgR7P2TLiC+q4n80t6l8qZhuN4Viu2QY5ixhw7VET3Qijyz07tepP0ORb4/CnP7rO4FGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BO8QUpvd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-341c9926f98so1855985f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711830807; x=1712435607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzQehRS9oRLFJRnmwyStVfkjm/N5c+OaNPBVlQqmOSk=;
        b=BO8QUpvdw9DtX8nb+SIGhIo0/TJYiOoVl4UvLs+kW5BNyXQFu1hpWhHSt7BvmATMCS
         h4WdMFI5ANSyFt/DJc1EiEPw6G7hevSmya0uI/MiWNYPB9+7jeD+PqGMKt2t4+f8LsdW
         viOxRF1cDzIq7Mn0nGI9SWmEJiA+cpadvcjew1byzvlxtL4C/62eF5GwJPsdwSC4NgaI
         FY5YLgLP5r4vD53FQliTxQoFfpXuSLwkaaoWWpU4GRWoOJShZQEAZWhV1Fhry04jZ7oC
         tLHiB/u6siSUpWqHEIMUPwriSxFvYNQJQFPI9wpA/rLJgOGMMU6BMmffNVIEnDe51VT6
         vsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711830807; x=1712435607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzQehRS9oRLFJRnmwyStVfkjm/N5c+OaNPBVlQqmOSk=;
        b=sD5n4DDO+kZGI4vpAJL0fnTMBxdMXf+d8eo7TowTey0CxLPbpWGwbQHo/hBk7jIDSa
         hT1sYK/hUtfyyRDG04C7zQe+JpbLHIg/okzWGJMr7J8B+c8b509UNsTwVsjEmt826/fl
         FK0d1L7S/eJ0Ho/Og1zjK3tQPF3XUz8csFwBvsJu5FQIUiEwy7081XuWmZSyZtgB5YFd
         lTRCLcw39iJ5tmoapqTwsrf2XYoVspPF9QmZNnT+SWI3id5/n8TkfFQwmmhSaSbopr8F
         QagKrQDB+ngDK0nFDQJT/7mBlDMqcdf4f6+2V/XtnEA4+RJzNtRLDMq0w9KH8EOEPvMX
         yAEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDNF+oQwUUC7PbQAgbZtQRq/WpNvOa4tJZ4m+pulEWt2el1j63s2MCtjpHEdzb0GAcQSyiyKg8YhYW1LYUEN71kgw7FSXxgtnNRWSR
X-Gm-Message-State: AOJu0YxGs0EDamdLCpgPp9BDciUUQDOlvvyUz/SG/zMtn+g3K1F3fUtP
	ESvuXxc7+ldvDSZtEjGqEF2edybkKqJ9PONbdqsF5upC64epaaAX2Ug/NPGFR1Y=
X-Google-Smtp-Source: AGHT+IEJQXH3ynH/xKwS6TrPwsPJ2dWY81Swhh0Qq2irHiXazZOF2Ze9Wr7dZtzAxISlshV7KzjdkQ==
X-Received: by 2002:a5d:5104:0:b0:341:cfa4:6076 with SMTP id s4-20020a5d5104000000b00341cfa46076mr3412473wrt.25.1711830807311;
        Sat, 30 Mar 2024 13:33:27 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f14-20020adfc98e000000b0033b48190e5esm7209315wrh.67.2024.03.30.13.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:33:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:33:09 +0100
Subject: [PATCH 05/11] drm/exynos: gsc: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-exynos-v1-5-3fa30e2c7e5a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=833;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=E6DDT3xCv3BWpcxdM1wHQ30TS7jHa8YzU1AqhlUDJAs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHcIO9ZBnFNNFpw3uAPbxJndhdtUQzOsYdbxE
 j50xp4f1l6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh3CAAKCRDBN2bmhouD
 1/KMD/9FHfaV8wiiiiiJ1mjqYTJdBvq/BIpsWaTeXoxkWPLe1M2IYDUzyg+27O5UsrPtxFKoT1T
 VNW7L9euxWmfA2Q0rN4CmkFkdA3ZP6eSYN/DBVGUMolHO4xkyrxh7QikdsCCsqkjHf6ABWneObl
 9EAMgB6nZFyX10RisLHBAuMfgD2bsmX+cUGwywssrB2MVn7cFIayhk+aSVRQUD+VEH6ewxPtMDE
 QRclDdApO7xJv+KhpqY08t8CCW5oqDik6zbQ0kincfF0yxFqmulWie/SXXXljdqpqqcCe8LKxQv
 A21Hr7GtZ3oWOOo81UmqmuaEfd1awp5YteWoUlcRBaT1J0ulVTJouxrGNVYbVheo5Wg+uJrlSZX
 sxy/oEMLblWjLdO3btvKngry47PK2uSVuva30SbUCOgMthO7XBBd0AXSTyrm3LRbUlpIjvxMLFD
 cT8sJlEWahwYku3sdTVzLWdlK/N+w6p0HPPnYAiYF8by2fylwDH2pyl99oKJ8sk8TNrzY4FjOOJ
 vzd2XHTVFCFl3v6pSxngP/4H1RwVzaUZlGtkxMez7ikbAfNF32Qkz3kHRipjuYGTz2Dy9hjs68l
 KTTRkqQMFNpdo11JjL+fauTiGlXCyDWrE6jioKiIsTIZyrQ1ZZzdDZnPcVG/vXDx3S4O9kM0W9p
 64gNWiv2OETCS3A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 180507a47700..1b111e2c3347 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1423,7 +1423,6 @@ struct platform_driver gsc_driver = {
 	.remove_new	= gsc_remove,
 	.driver		= {
 		.name	= "exynos-drm-gsc",
-		.owner	= THIS_MODULE,
 		.pm	= &gsc_pm_ops,
 		.of_match_table = exynos_drm_gsc_of_match,
 	},

-- 
2.34.1



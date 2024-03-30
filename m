Return-Path: <linux-kernel+bounces-125856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 340BB892D21
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8B93B22257
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EB456B8B;
	Sat, 30 Mar 2024 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbmfWN+5"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CFC57322
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830818; cv=none; b=c0CFvV+dpp6x6wdYCzzg7XibdjBbq78Y2ZOWH4v+DgvyYHEl+f9N2Jk5SpWPO4ssBKiNm5GARRe2R567hInTRjvy0+KeQmax6BlsubtYcKch9Ob3kMQ7c+n4EhTV7bfcPnWnJbGJ/Jv8wPEp8adDX2efKKFhPgeeIxeITGZ8N7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830818; c=relaxed/simple;
	bh=MRyvhFqUHJTCwrqcUOctTIpVc2d3BqgjKqNWZ2ls3sM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bk8jUd6yh84QqPACaibtYrljZBllgx6Cjmwd1Z5ioVt3bcgkqeLnb38L268Jo1LivX7XPRBewkZ3sLt8StKELxdKgNejeDKRO/N7k6tgdv7dEuXp5V9RXyWTIfhSiNtWEZgDIX5JB5orY3gp8OGA2bZhH9Bv3zGEVcmMTc0Jyj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LbmfWN+5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ecb04e018so2218766f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711830815; x=1712435615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONzs374y2ZZQ1dydMn/i0qQ92QOrtMdVepJ+YZpfIxA=;
        b=LbmfWN+5w508+TEMQOuB/SF7XH9Ovn6GoX1loa/fv/alqZ1K4vK3ytFtXcnRqfrsi/
         nEIpfS/8+eluCRJQMdCpwJx2y3zlJXHbbnh9LbBgmgBMue50LzFpO9uTFPBXG6OoRsUE
         PXVj01hkezoM8TAx7CaEVVO76HUsMxaZ3Q+AUI/6tBUvjT3AiUDz/iqEMgaPYkaxNM0x
         /mo7oasXKtSnQIP564Uz86tCPCXfVGvC0/lMiARIpm0tlSIa+xU+RelD/4fMKsdCDv4f
         Jfw+Z06EbHcUC1ZJvZRyc1oVPgTe+dIkMSGRsw9h26odLQQG+Gnhq2IEjI3iwV1VAH/h
         xO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711830815; x=1712435615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONzs374y2ZZQ1dydMn/i0qQ92QOrtMdVepJ+YZpfIxA=;
        b=ut5Jk6CISDIm6wkuH4FylJfW5Wv+6FN69HkZ1G217ls5HWh6XUT/XXfswEv20sf8If
         hBpLhmZJbDlgYovxEgW5Dfq/6gWbYqe9P6ijWg1yPCU0D4bhWCFm7VnlqMo0pAKHqldj
         X7CUCUE7CQ5ccikkyHWuNod3EZCuyrMl5zcvzmAfRrvREQHGS6WETLLGQt0C2plpDMNh
         VY38VnMWMwS3cVX8X89xYXNOEtya+55/8ld6fhTqDWVgjvZAm5VoPIHCq7G0de8bSEL+
         eNPdIGf+m54U5mNiy8IZNuK4CKPyZHSkL80vIYnJG8lsN8vgW5Adx1m59L3yrE5jePDR
         jHkA==
X-Forwarded-Encrypted: i=1; AJvYcCUsnSt/iUzIp4KECRpBYPNJqE5KvVP/coHusA14IYY9FenNb0BHZvg8ZStulQppfHC8qNsK0POJsQmC3e9r51ThUwuXvXaTgV6r4HV4
X-Gm-Message-State: AOJu0YyddtKiGri9H0KQ8hsjnywq0dJSvPm4ZOTIgdl/PWozT7gUexWT
	xZWfFbRd1kmqDs1rvk9APouucrxaaW08CVbdzIzvt0Ga8JMiuh+SR6A8n37pvDY=
X-Google-Smtp-Source: AGHT+IFk9Y40VlFC3fq1m4LPmsbmadOu/r9RP0QX6ioImBx0Z4DDeukF3X61ng8xjtDRT4Kq9PpeFQ==
X-Received: by 2002:a05:6000:366:b0:33e:c389:69ff with SMTP id f6-20020a056000036600b0033ec38969ffmr3102277wrf.68.1711830815031;
        Sat, 30 Mar 2024 13:33:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f14-20020adfc98e000000b0033b48190e5esm7209315wrh.67.2024.03.30.13.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:33:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:33:14 +0100
Subject: [PATCH 10/11] drm/exynos: hdmi: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-exynos-v1-10-3fa30e2c7e5a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=818;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=MRyvhFqUHJTCwrqcUOctTIpVc2d3BqgjKqNWZ2ls3sM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHcMu3ioGpIwgAMlPdiGBxDZevzR2aeirZ0+c
 iaB36NGsjOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh3DAAKCRDBN2bmhouD
 1zA+D/9PczHqQtk5Gt8jztAK2kf8QbuSCt+Dws8ZWR/QbuQ4ui74Zz3JLDzhG8wFUv6EbWwbMbr
 c/7H5EvzVIzWvqmjQFBZ0g5IPxNbSm0g5MY5/SJLgwN8XJE+/QHEo8iCSDAp/YRqAlzIbP+ez3d
 FPrEusO8YhnH7UHZCCfXPAHy+bISnorGwlOeTMochJ1NseuvOxI38JDBiJBcJrhfjtoZvUgcuj7
 SgMBxKLUYayOlBRGYX4wZAquCFnWnsgVqmF8CdvVIjaXt30p6BNfhV6aD78yAOqJGRo5soetLmE
 l4ygzTlQPlKF85TYu3KcGNO8NnF6OdTadTaGhnFHtaSbwnQJ3sa9LIv0d3zED8XVYzFf26nWQTO
 v5tnHcPR3Ypygt2BRHM6jnFGRcgxeJfkIYcU6LHkF146LtCK+T841Nm9bWGJz2ZAj2IFaDtadXS
 oNHzeLB9cTmoNgonteLxocojXJy/wCoccYQ0AxjN/u0kASj1eVovGIDAcMpeWzFfB+fPmcmzbL4
 W1x8btFvmTnQ9aKDtfZTPGAg41oMPXR6VvwkwHIE6cxgWMAPIGRtRr2PCSK3xZz8E0yVv5/zZZU
 s7ACz21ewNS+C0tcGK7Jpfh7WrVgXkwyi1CC3bt3+dsXKJKl/FhZ/ZIrq8WHqGMQvigbEJtnmra
 vCiindfJ5PCitSQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index b1d02dec3774..5fdeec8a3875 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -2126,7 +2126,6 @@ struct platform_driver hdmi_driver = {
 	.remove_new	= hdmi_remove,
 	.driver		= {
 		.name	= "exynos-hdmi",
-		.owner	= THIS_MODULE,
 		.pm	= &exynos_hdmi_pm_ops,
 		.of_match_table = hdmi_match_types,
 	},

-- 
2.34.1



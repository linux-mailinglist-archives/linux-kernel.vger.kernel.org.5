Return-Path: <linux-kernel+bounces-125854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86674892D1D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA32C1C21623
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ACA57307;
	Sat, 30 Mar 2024 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jn0n2oRU"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF775645B
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830815; cv=none; b=hAxI9d7ujRYSA7EaDE8hWtfK1OL1jlnSAXVbEaD2lQ8JPikToKBcNNK7NLBPCxpk56IzIZpOXY+EJCoro8aluOe0quvtTJJ77+OOnUbZrJISoF7cPRT+G2vt5SUrAi+AUajn86VngqqYSS2Ogsg221jbSfmJSs7k05EzWrPmzFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830815; c=relaxed/simple;
	bh=HRewJKROx6Nn0LHgKE6EsT3R6rrYRmwDKHHjjo48+wQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tCH5BFkgev/3jgKMLu9prNJpASXEeft1rymYv8xrXEmP9m1xXtzfrJCDXndYUUyZPfkBZbd9QKagm+V5EXi7FivzXqDuI8/qmmeYnvsgSkNQTInFmkcImwol/mVnUH0TB+kYPtsR7aDTjpK+P+T5rgvk/I+g+A4AAZZPMqdKDN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jn0n2oRU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ecb04e018so2218746f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711830812; x=1712435612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okXcxozSlQaij09cQMnZFJDIm4akho99cwdDVwFRPRY=;
        b=Jn0n2oRUNIZXD7WE0CwHDr+cIfk5gGzqlDgEP5UYZLhZJ9VCckIwU7Ju60cuXPk1C8
         b++w0vKw/ZCK9HZ5WWhIsWs8zlfqbsqC0lRXDRiGVgXFwKdJTLSOAfJIhKrrEPNfubVv
         0Vr3wxV+ROJjyFG4D1cRK/zU35/Rol9EO7KlIPp330ATu+JnjZ3nIry14QAbQvoEBOqj
         gjhpr83Uw0X6vkhqt1FGQ0TCrF7d9FwDL2aSiFriGkhKSzivXrLmWdFKTuDyUgAKaXMh
         fR9aMbdr2askNCYG78HvPP6LdJcsdC2+d6qUP2w4xWWnkh4XKc5Lsuh/G14aOuWlYeWx
         xjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711830812; x=1712435612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okXcxozSlQaij09cQMnZFJDIm4akho99cwdDVwFRPRY=;
        b=FoQ93j61QNIORv50RddYAwHm3RUux31hBYWRjImUq0ybyXoq+kP9DA9JAM4sCqKVrZ
         0zjEFAs8Ipiw12cSQs6tVBdtcOfbb1b9GqfY+6xKa1SLM3kjW0IZYVLsupEM2NVaDZe2
         McfeST8AxrYB08fnLnjMR5e6NzvHGZ+cQE3GVCbN4WolH7P8OGScTim8c8DDC34wZUb9
         giITcZyVB5VcnECOp3tEkwArnWybohCZZK4JbANd8VDsqZquM/ObjBeG5e5VTUlK3dis
         J0bP5eI8/J7nffLFlPCEcA4I3hG4DBX3QWJJcCeI8qK9nlS3YRDxqZu1TT6Xfgod6fIG
         Mywg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ0udvZg0X57j6mu6oYNHJiuBG49SRcKfD7kKsQOdL0keqqASvx1y7GvRLmz2RJgKBsyjHX8wTNdJAFNXjHhHXwIY3Osc9Vrrxtx8l
X-Gm-Message-State: AOJu0Yyg196zRYoSFjBLTNapPK1Yv2y0cgLpWBOsoCzhhvN8aOVONNvE
	0YG4MnHEAqHr0W5o26Hfu/13bW8s972ToKBKWc9U3SKgiJUQ83itDQzUBj5+gkc=
X-Google-Smtp-Source: AGHT+IExwBRR6ELoyteAMM2AZW4w8CR/HrFou77porojhjA8ckvKqLMd9dECVHqm4WmsmgahTvhvmg==
X-Received: by 2002:a5d:634d:0:b0:33e:c679:da6 with SMTP id b13-20020a5d634d000000b0033ec6790da6mr3566287wrw.57.1711830811832;
        Sat, 30 Mar 2024 13:33:31 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f14-20020adfc98e000000b0033b48190e5esm7209315wrh.67.2024.03.30.13.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:33:31 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:33:12 +0100
Subject: [PATCH 08/11] drm/exynos: scaler: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-exynos-v1-8-3fa30e2c7e5a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=858;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=HRewJKROx6Nn0LHgKE6EsT3R6rrYRmwDKHHjjo48+wQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHcKOr3YLYD5+4yT9hehw4TZ/rfZQRMW7yGMm
 I+Cj48ZCm+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh3CgAKCRDBN2bmhouD
 13qjEACDMauB2fSHi3ELii/UYDCIxSdm7lIwe3GbeuuaNXy/BOVfJ4BLMuI4PiOt8ibSVGKdL2K
 yGFTyCeWRGyAF6LuHdAxx+HV1eBOd2OQViUyV2Vz5S26aI+ECWbIXfyGxikGT+ycKfgvWW1AxvV
 LnLO9Pv6LBQvinwTaJcooAofnMVt/9n8ObNek+tlc+9I3KZrrxlx9/3uhmeBNql6FOEZBNPTG/k
 SR+6KUfAQioPnUrbHLAg9D9K3dyot/GeqbNErdEtp9WVPwciM+0Jle321GAu3XgXpHNLhTLZ6SC
 B/1lrHE6Z5ZzNY9m3OgPWcnDYjOQW+9U3yzwyp3jupHWsRmIUerDXVPlhO4gIl9/dwYAVL6aRs1
 FkZZOp0VgLKXVlArf5k5yEmjAFmZKTpXh7LpuTMK79PrTxXxrxTEcTI47AcQ1XohYu4MqPxl8WF
 tT6ecMgM4/1sWJ37MlvEopkMXBJLjZzpypXCDuTl1/TWgrF2LFKkReFuhBZ4rQ9a66Yq/ubyHuJ
 RoO7FJK3k/VXksypzy6/jQfWk/iwgmHBhgnB1t5yqlY0Wt1xD8lL5xABe2SOk6lHIMhxniEIoqB
 nsJ+Z0HWrudEPjT0xhKr8+glFNJIWv+AO/6woNhwTDhjh1K0OG8VFXwblK+DdH5fT4UY1AzhBZI
 D/yO/PcM0tml27Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/exynos/exynos_drm_scaler.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
index 392f721f13ab..a9d469896824 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
@@ -722,7 +722,6 @@ struct platform_driver scaler_driver = {
 	.remove_new	= scaler_remove,
 	.driver		= {
 		.name	= "exynos-scaler",
-		.owner	= THIS_MODULE,
 		.pm	= pm_ptr(&scaler_pm_ops),
 		.of_match_table = exynos_scaler_match,
 	},

-- 
2.34.1



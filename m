Return-Path: <linux-kernel+bounces-125853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ADF892D1B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC621C2165C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2266A56B6A;
	Sat, 30 Mar 2024 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0tbKFtq"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1E54FA1
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830813; cv=none; b=SSVPUBMbi1ZWu7DdH2ZXCXRFpubxbFoBJrZgo1p+Hdd+zZ0C+nmKhsSAC2LPPK005QDaYKYpq+vYp2Fii+cR7eW8R08YYG96mFaSo+ZEVr2o4Vd4L2WnNVKE7SSjElSlZOzD9ev2LqvkAPLjGwqExYRrEkf/5y4pbseaZh98ntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830813; c=relaxed/simple;
	bh=b7itDapuTbhKWEZ7+JJg1uQGCmSRTmhv8Q+INR1UhUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tewpN+VsUM8zRy30AXRNeOsRan/l2AS1/j1QTWLJc/3XJkT6CmnzStXdxgX6dAHEN3s6NiLu1AMPIC8euF5HX7/im2V04ypx/AvJioBQJLNdhW91JPkASJYL9ZWS5QtaL1r4cgd2FVV0w+I1gsKuZesMcINcfEZEujvEYcNuXSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t0tbKFtq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-341cf28e013so1991016f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711830810; x=1712435610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgns3X2e/mAj3G7mz+2KMufeaerrm3z0CsboO9ch+As=;
        b=t0tbKFtqqG+AGs/iL/bbhZuHiZt89gtACYY0/on9hnjBE0J+s0QB3iv2OgcrHC595A
         LdpgPmrxPsA1pGayZQp0zZ2cs8M1cyrHrns8NKUYSClNPIaSq8JPxRyG7DfeYHJBaN/4
         mMFXZ33dT5es6ZlcdtiXcjhlE9CcuDzmmFg5mJC19kt8x3UpYSQL3yOmQgXnkdVQlA3U
         cHzbOvZZUwZSabn0hv7yJvA5S4gcMhesMRPrXhV4ndS19bseerStEBhVCgWwW4lrpSgO
         rz8m+IMjnn4dxlSC7WDR9HzMJowdqafCVlNiAXRdt6PXBhTQsy5EbBkm2sgCaVj8/pmp
         d7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711830810; x=1712435610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgns3X2e/mAj3G7mz+2KMufeaerrm3z0CsboO9ch+As=;
        b=Jo0Iwdm7bMy+lGSmYqyobGuh2gsHkQF9f7WrB5oK6rMVB0ySC7O9hWXggixLp2JjzO
         WFVAl6ECeMQlVQB3HmNYUqS4N2WcbAthlJZgjrkcL8pVM3ZGE7dN8xk/in1kvhTx+gvT
         3uJnbi0YmNpyxqc+pknvXASqa2WM1kPld1+XmgoeeXygKwhdWiJyjo/Q+YN12cSdxu/H
         ++cEyIUIarXOfdZdPWDw09U0OS2Fk3IUTLHCayMjN3PeyzMuzJBZsXw/HpzzMkALOp0f
         6uULOaOH8gthhaAWwSxmX7M8KiVra87f88SegdSSruKMRKs4+q1cCle5DjLvg7Gyarqf
         XY4g==
X-Forwarded-Encrypted: i=1; AJvYcCUDI3zAwqgXIY9rCCVXgVL+TA8yPUAUitlrKVVQwxkhb4jkp8R8LJm8+MDX/73dVVV+LzXmqgFF9Vwe/9YeJGKGizFQ4PpBBlgJo7gf
X-Gm-Message-State: AOJu0Yy62F5bp65MrG+fwBPOztL1egCxpE+r1PiXTlOwow7O1kLixt/f
	qZbWPDzxzYbZfkIS7+/3NRL4S8ERka4pU7pxq3b0oYCreo45xrzcnNgVMpexQKc=
X-Google-Smtp-Source: AGHT+IFLrQkDU/bMLyABLBx+NeiC4mD9du/wlWOPvKy6LIBGYBVwN0Wlbkn6XEeyvwFsLpS/wKix4A==
X-Received: by 2002:adf:f805:0:b0:343:3bb1:f527 with SMTP id s5-20020adff805000000b003433bb1f527mr3666695wrp.23.1711830810154;
        Sat, 30 Mar 2024 13:33:30 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f14-20020adfc98e000000b0033b48190e5esm7209315wrh.67.2024.03.30.13.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:33:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:33:11 +0100
Subject: [PATCH 07/11] drm/exynos: rotator: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-exynos-v1-7-3fa30e2c7e5a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=868;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=b7itDapuTbhKWEZ7+JJg1uQGCmSRTmhv8Q+INR1UhUo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHcJNBhLmfYjCszx+Ztm/tnXD/cwyaCqhecaf
 tNisLnBM0iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh3CQAKCRDBN2bmhouD
 175fD/9C1HU4uO8YaIAZY2YmDOs0uEKnc4s1i5hi6P2V8IoJQuV9WkQqXv1df18GkcjIPCoqC4s
 nmG29x/Tcq8Lv0wAEgNjPq1ba74J8tsnHsflYYCvxbqwX8CV+2Vm/xVjBuTfgwgtCyc6JvNHwx2
 AM2pEuHcS0QM0VvvsAA8EwjO7fZT52NKDJlOyo4YxcPt3oI+f3AvNwrgwD1hKFrMeACAGS0PlYZ
 dDvY5v5Ey2+oUyOb2mgithXQ9kFYFE8/q9AGxv9bpPNzmMxnbSa08PgJ60Mb6c3R8kckYQOWWXm
 4a4bVKyPpLN6vjA/P5MjQDYKqtwOqoUWEYKx5L8HwBDwRRmTjwXF+QB/3/pzPfWVQpuaf+UacPJ
 53vUK6bIXoSC/Dtd38JN/QgufoHStGBfew5ovwaSZrl0X+KVg7UNrHjP3KXga/Ehj5G+OGV5a6M
 Kjuwf0seNbCTUOrNd25s9nUNx+RHXZmyFu/ODEddzxrq3BwKbp+extr7IgccBkK2ufR1Iuk9+W2
 0b944jKcCA9gBBvjBzO7KT7H+jJ/C9v4uO303lYm/DsA/4MSV/Ab93SSr4lOp+f5XY+wkrodfG3
 ijnEuKiyhA6kxmn+raTly5nBhm04FgFaVsbfstJlX3sc6IKtNaApmHY/oiB+5CMy749zEVPbMfM
 sKC5tYVAimQnslg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/exynos/exynos_drm_rotator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_rotator.c b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
index 5f7516655b08..2eb0b701672f 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_rotator.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
@@ -454,7 +454,6 @@ struct platform_driver rotator_driver = {
 	.remove_new	= rotator_remove,
 	.driver		= {
 		.name	= "exynos-rotator",
-		.owner	= THIS_MODULE,
 		.pm	= pm_ptr(&rotator_pm_ops),
 		.of_match_table = exynos_rotator_match,
 	},

-- 
2.34.1



Return-Path: <linux-kernel+bounces-125849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C69892D11
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D641C2168F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FF0537F7;
	Sat, 30 Mar 2024 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AenR9MXx"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54CE4C629
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830808; cv=none; b=VphemXEo0YFwkQuMtJ5uj8NCbE4X3uzfVXIBM9u7Id+xgWDXIWIKAVgCSRXnpYpv+0ZMfe8/jV4kweh0ooRs4Xk3lYBgY4TKWV7S0cPbkRC0/5A2Kjbn1LVhekYW+n/aGLGzegs4eu8kSEhWqpC6/KtjCH7YvwTysRxe63i7KVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830808; c=relaxed/simple;
	bh=KoVaQPHwcBE53K4bT1O+VFU2Z1tadYOC4fUf9qvhKG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C4Xaaydb6GL5bVH8NmZQJl8ymrt1WyuJN/RndBbgAGiPpOKYFq6O4af+/LMk8vfF9HSTvs0iqwKyaIsTvZh9guz37gXL3QvTZg/cNMpErhYu7SbnqWveof4bsH6bgE/LD9JgHpRSiq4sNFrrJf5IwHa1i9sscaPt8hBCxZa1Joo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AenR9MXx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33edbc5932bso2141044f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711830804; x=1712435604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clpsgKia2XerUP4HrlmZlIy54Q7jyrtNTsV1ZOiogC4=;
        b=AenR9MXxeYKwrx9xbIq8UeBEJ/FqUM5DCk6wy5yIWLHYkCu7oMzPbffBUfgqTtgSjU
         Au2su//DvKUlpsmj3HQf8VEZppecnPOmiQE7NmC7zrJiB3o0lPvJNFu7k/L/rGk8iUqv
         7DortsmMfTlEfvi+G71i6Ehq52p5DTvO1fplpP/Ib4PHxbx3+q+9pK7sN5q9IT3YRGKa
         6EgOs/RiROidKA/JgFLlBXk7QPEi/7mwAmg39opeoWbjfGJ9QdLO85YOgzFmWp1zyOYi
         N0WInmdHktyELTdBVKzBKbthxfyq8abEPaZjJARg/owulvAat8RtVzZZFZz8j87kVPGE
         NnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711830804; x=1712435604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clpsgKia2XerUP4HrlmZlIy54Q7jyrtNTsV1ZOiogC4=;
        b=ucepREt9VEaqr37+MdpAGa3uKf8jDHDcqOyNa54YFb9FoImbrl9nCJbtvBJBRLd9xT
         R+SB0N/gmglMATPB4VaBpf23qiTejMTELI1w8fVGCsxNiv7t0vZRjsyNFivMS1qLCqnv
         O8u6+NShEzUKednFGwAHOXqzgBWNpQHKiXauT0R1nmce5gP1swHmlRD8ctvKkwr0OCIG
         Nc8+nJusDyDyhoablCepATdIa795Y6XGPWGLszDWOrdbIdPjqQnzB6qXP3IQbBe5Gk5y
         eJ1mFirwM7feDJffzTKTyAe1iumrA5ynxqJ2V5kRyUm0ImvgYvYhEjllBKrMnFuwH4a2
         99bw==
X-Forwarded-Encrypted: i=1; AJvYcCUoHrixq3oAB/nByDbEUO7kluPtufb9pnIb0WLDOHmvY8CrSYvpDHKkvLxxAEOnbtk2JNCZV5Ri4tUZ4wyK2PxGPxr+Kpgfyl+Lbd8T
X-Gm-Message-State: AOJu0YyaV9E+7/zPebM1uhXjUejl1ObaQvRBBWMTBhW1k8pgpwacXhST
	ISolqxZKmrJ32fwVHjoRFjVguWuMNNuqXkRmPWdotsyAepy18pBp5M+sXOOMI0M=
X-Google-Smtp-Source: AGHT+IG8cfxx8ygvJDe2F2vg6nC7yHE1iwGECA3+RNlyBj0C8IGiqTKwAh1xjipjjTdWA0R0u2LkqA==
X-Received: by 2002:a5d:5268:0:b0:341:bdd4:aedf with SMTP id l8-20020a5d5268000000b00341bdd4aedfmr3351086wrc.25.1711830804308;
        Sat, 30 Mar 2024 13:33:24 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f14-20020adfc98e000000b0033b48190e5esm7209315wrh.67.2024.03.30.13.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:33:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:33:07 +0100
Subject: [PATCH 03/11] drm/exynos: dsi: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-exynos-v1-3-3fa30e2c7e5a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=852;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=KoVaQPHwcBE53K4bT1O+VFU2Z1tadYOC4fUf9qvhKG8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHcGyRD2nb2Vdn95Ldfkr93QVk0HwYc7oj74z
 du1HvkV/5+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh3BgAKCRDBN2bmhouD
 1wHQD/oCjZnIWVTfsxCoRR2NKz5MjOixUCe2W3gvzTaphlnVtY49l4q0T2HhnMn5ndT3TuzkY3U
 rCsahA87PNsNHNpnTrPil7cPzmJygJ/PWZ8V0azkCFSJaede64TvYkZtYW7Rd19Y4//pkc/7T1a
 Hewc33f071/LmhhoBwsUuDt8CBvFR636Dbi6CAHUPCAnjRfzB5O4TI40JfNpmMXXZ9V97e6gDmA
 J6kuniX8LUIvZ+YxC9zM8QlINOqPwxrADOTTD4r2jyuwlC6E0ZDAFxgklRrgofOwKR8vzGnYYPs
 0IybqLGt8fh/KKnVFdem2zTWbg5ktwAyVx9I69XlT/KTGCRRrs6OOy26zDI1xVivaVwiUCNWgzz
 ECpUyZI32IfbWDqlJkS89JZFleOzJcdfx4X+ysWMiUnMZQfpMqRJpuYWD9kZKzWKCeak6xHUrxe
 lCp0RnuOS1qqrmuUaz1QaRNrPH5mmunKOoe4AQ0jlEahpeXtDtNKhq+aoDosWF+7PbylaRtFS7N
 HkVZOY59/7Gu6ABUaLnbgpVU5m+TRAzBALxu+alySkZxqN0Yc+QnFpa6PJWG8SNv/tn38zpqTgj
 v/YViY0E/UkGF84uyvScclSxF8QFW96x9kAsIv6iRtAqDfi7gbKtt5xra1wp7cbFlA6vWOFIJ5M
 f7t9EzT+L3WguBg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 2fe0e5f3f638..bf16deaae68b 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -184,7 +184,6 @@ struct platform_driver dsi_driver = {
 	.remove_new = samsung_dsim_remove,
 	.driver = {
 		   .name = "exynos-dsi",
-		   .owner = THIS_MODULE,
 		   .pm = &samsung_dsim_pm_ops,
 		   .of_match_table = exynos_dsi_of_match,
 	},

-- 
2.34.1



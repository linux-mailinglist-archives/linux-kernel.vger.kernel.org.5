Return-Path: <linux-kernel+bounces-125877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E6892D55
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1211F21FF1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC2943ADA;
	Sat, 30 Mar 2024 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snVPbYdb"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0C91119F
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831968; cv=none; b=rhLA+uQdTg32jOwPqsjT1vZSh1EuKNYZtc+zw9xW5fvClX6ji6O0XT5RTw+DckUXuoQlN77KLTHUD+ZqJmKLbjNJat2/E3eBBemwZAS9jT7Qwyc/V5KilO0OshX2NnPW9czW8a66ZuFJI40XJViUDxsNUCESkJWqi4BCOqnrp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831968; c=relaxed/simple;
	bh=ZHXSmuZq8kU0MzkmSkbqFjA1DNjvTNxyVGCX8cicNa0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ML33jg0HqLEHMjlqb3Ng666P+B6RPgRKkUTGelxGNjFtvp6NO/MbOASfLVHQ9DVE41pHdQA+H5MrAv0sRkmMgcu6cQtOB3JNPmWh2J832QyCVCZon/gsFGKAVHAJZ+TZQZCfjRpOzXwdPbn3MeKxG7/Q0D9pmxCAFuaKV49gj70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=snVPbYdb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34100f4f9a2so2089953f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831965; x=1712436765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ur6wj7Am1MhdI1MTeYGSKdLS/Zh7sDkgdWv9M5NMjj8=;
        b=snVPbYdbsyvriy31A4bI1652cRSNdo/OgD8ZkEu/0XtYuWeaCk7DK/NKi2tD5TYFPe
         qnMmi8iFlD8yxJH7jSmmeEaQBWqcD9Wz4AZgD8bsL7RALzEeG3gDd8dDjq1+4cS2iKAG
         b3ejRIzIGzegyDH9MqlggoD2Cp+B6BWpHo2n4EtWBXdeR8ofm9SeMhf57nbkJ3Leo4Ch
         WVdi9Z18Lw9fACdVzT3MU2ZYJNgye/g2gQgH+V6ARPKLJww4U7V4iDlQpaSmocqpZrnC
         4LkqV9ieRfpOuzaL58QAabl7qJy7xJHhKMILrpWN/9mPmYT0RzGzSv9z02iwj69x1Bcm
         xwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831965; x=1712436765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ur6wj7Am1MhdI1MTeYGSKdLS/Zh7sDkgdWv9M5NMjj8=;
        b=vzAZj2c3uQ6m+27a/MsziPOtvJpclqxUsORce01KMjgWBV6xk9fKiFLMWAVdb6+kSB
         TYGWIzLDWMzAR6d5nO7MWdnRiFHj5WIlj+ErBE7JKcZt84rU0CWD8jXuF7sl9DZIsaSo
         lc6ud3c7lxz6JjdVq+WMjUQiGUedKUiCHEmMusu6o2LnJSQXsrojjnifCuEqqvL/XEvl
         a/IleSI8dRQEW87zSUorVnAFBYUpqj4lSm9D22pSfrjAHw66TvVqocSvBuNFZLkwrIh6
         EtNrOT0SCYkVMDxUuNq+NoCcBSP7FOKZUx4DWGwyVs+393JtkfpurrdZMVrhdtjE5iCM
         SjuA==
X-Forwarded-Encrypted: i=1; AJvYcCULjnOqsphh2/IZcFClFo3iBiM+ee/zVUGBhK1/cAWXy0WAaiy8AXaQxzsJc2RAtJ6le2JxpZ/DY8sHCUSrk8n1oZeMZvzE2D/dKktp
X-Gm-Message-State: AOJu0Yx8uqxHjDFYvCy7ETvNEoBnX0GbpGXbaav72NFuXWKpFiZ52hzU
	/Id6YvkbQeru+y6NWNnG/uFWnWELUf0gY8N83kaVkEo+kySCluPPVzE8tIItAdc=
X-Google-Smtp-Source: AGHT+IHGeV8E/r8D99VT6rlf9tYE71QgG9MvULvj0tWUuJAxe/CbejwGsfVZwcwIlP7QPuju+VqMNg==
X-Received: by 2002:adf:f142:0:b0:341:7656:d358 with SMTP id y2-20020adff142000000b003417656d358mr3715366wro.38.1711831964745;
        Sat, 30 Mar 2024 13:52:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id i9-20020a0560001ac900b0033e41e1ad93sm7279868wry.57.2024.03.30.13.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:52:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] drm/etnaviv: drop driver owner assignment
Date: Sat, 30 Mar 2024 21:52:41 +0100
Message-Id: <20240330205241.92711-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 734412aae94d..87b31cfee41d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1995,7 +1995,6 @@ static const struct dev_pm_ops etnaviv_gpu_pm_ops = {
 struct platform_driver etnaviv_gpu_driver = {
 	.driver = {
 		.name = "etnaviv-gpu",
-		.owner = THIS_MODULE,
 		.pm = pm_ptr(&etnaviv_gpu_pm_ops),
 		.of_match_table = etnaviv_gpu_match,
 	},
-- 
2.34.1



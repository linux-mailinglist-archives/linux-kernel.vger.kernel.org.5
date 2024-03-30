Return-Path: <linux-kernel+bounces-125881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6139892D5F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8E21F22148
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4CE4C61F;
	Sat, 30 Mar 2024 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uz51BoBF"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946BF3D0C4
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711832253; cv=none; b=pbrZb0yceke/l2GlJIs3WQ+FK8rGdub1Y5rIUwTdINAQvphrnCK+WY7+cYDP1Nr/EjGSPyv2ViMjOjJh9isd76YhxHjuXGTA+DG0Rn1gbCl9h+6MmkD4hx0NpOmHwKN+Nixo6L81gkEQNf9Ptj0rMxoXv9I8FNO3y6gZWKFRtQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711832253; c=relaxed/simple;
	bh=SoT+RSUYbg69naQt78M3skUCTN/g3Z8WWrtSHzm3u6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IPEnLdyeAG/mb5FbiSNuJR2YgZFU238wLjlStyg9yeZdoXDJpOP4mfip0unSViwKlmu9hFtuIvLOXO/6T5MjryL3K76YBcQbtJ8h/aI6BgcC1O+6Yoxut0YTxluHrXLQfXu4xtWZ4pDt4UCPjphry6O//V8SJvFGjscmP9OCoWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uz51BoBF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33ddd1624beso1817547f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711832250; x=1712437050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4h+mExzuExAFnvHSQe+SRMmh7AbxjHaFk8xtImqtg8=;
        b=uz51BoBF88A+ipMQ03/rZBzlyPyNIkVwwZFaMf5v5TbT9qa87AzzGd7WYROqwZ4C0c
         WZxFdA3KPzt+yNLJ/n9iY6SUowFnflCMMhXN4NFbNx5V14dUFCfsZcXkyhJfhq5r1Jqe
         zRpDKHGEIf9PrNTtCTvKSUIyd5ZIyDOwGYkw8uSG9EE645+lUuxeymUcJdtudhq0G9Oe
         yO7/RyAei/1Yof+7E/VfKUz8XwGIk1uLzT6Iyp00DcMropmnWmWLN//kbZu0PKfbRvs7
         i0ofOvnORWDabSoB0CLdTS//swmTBrOOu51DBZhwDB05ftRlujuAhXXs0/ImADfpfsAp
         AhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711832250; x=1712437050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4h+mExzuExAFnvHSQe+SRMmh7AbxjHaFk8xtImqtg8=;
        b=C+YRVAXwJskwfvtzhIBYJS3PJ2fhcQHt9YttZrBjUChz8cKcTMM9GDYw3Ef3vGNMok
         HMUDNq9cSjX1rr6L2vuk8i1LwO1zOI5SdgYkvVgRqb06m7SKVeIl1y6jLr0b3br3AH/w
         8yuyAaSLL21WpjmAMRTpC8BX6JU+3i/vFpLCIvgAiECdf5Djch6/7WgjYVJnPH4UkDC3
         lYaPdbrA1sDL4zzu7PqZD+t6ltR33bA8XsIZCiGGrafjbIQgMVnFWM5zC8F4zvw06Wiq
         5ESft9KujSlOHN0IVaGZqfiMrTprbFZkS9HQsarbVYDb4KSqgAx67I5VLu2D/MXDKWRD
         JpBw==
X-Forwarded-Encrypted: i=1; AJvYcCXT0k/andSRTeDVS5qMed/opNpXgnNe1jnW1wbxPlISqs5s8fHtUoDssr+UnglgRNwf6lszria0MGZMwisfJDf1/FYgd7biLD72aJS8
X-Gm-Message-State: AOJu0YzWPwA7qIRoB1p9BjUgUmki8dWeNOOecOBVPZnDdX9+3fHno2gq
	RZK5Df9ER5YGNllpIDEjl/WSrvi/0ArZUuP5hQhyqsPECBcyYLmujCMnbt3zWd0=
X-Google-Smtp-Source: AGHT+IHrRVqigNTr3fU8x+o74S1SpMr+gA+rosmq6f26SYPprbSWdW+W/87/gdT0ZbaSY2Zb70cL7Q==
X-Received: by 2002:a5d:5408:0:b0:33e:c0f0:c159 with SMTP id g8-20020a5d5408000000b0033ec0f0c159mr6926742wrv.10.1711832249963;
        Sat, 30 Mar 2024 13:57:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b004154e48bcdesm6295786wmq.14.2024.03.30.13.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:57:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/6] drm/sti: hqvdp: drop driver owner assignment
Date: Sat, 30 Mar 2024 21:57:22 +0100
Message-Id: <20240330205722.93801-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330205722.93801-1-krzysztof.kozlowski@linaro.org>
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
 <20240330205722.93801-1-krzysztof.kozlowski@linaro.org>
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
 drivers/gpu/drm/sti/sti_hqvdp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
index 0fb48ac044d8..acbf70b95aeb 100644
--- a/drivers/gpu/drm/sti/sti_hqvdp.c
+++ b/drivers/gpu/drm/sti/sti_hqvdp.c
@@ -1414,7 +1414,6 @@ MODULE_DEVICE_TABLE(of, hqvdp_of_match);
 struct platform_driver sti_hqvdp_driver = {
 	.driver = {
 		.name = "sti-hqvdp",
-		.owner = THIS_MODULE,
 		.of_match_table = hqvdp_of_match,
 	},
 	.probe = sti_hqvdp_probe,
-- 
2.34.1



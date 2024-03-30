Return-Path: <linux-kernel+bounces-125844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 479C5892CFB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB820B225EF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21CF4597E;
	Sat, 30 Mar 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wiBspgw8"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BAA40C1F
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830503; cv=none; b=uta4GL4EJFoOQao6SlUNyom1brMx+spt0NTqNe6OTyHVfyUyhq0LenRQrRgRfbPeVFqWBKzHGULyDnV5XHlkWgo2K2jICtTZQXT7a2blMYig96DFhnchZK3pVV1/ABgxdAMOj7a8tfooWGNAfgVq0vqBfoQ+1Yo2ux+DW0dTChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830503; c=relaxed/simple;
	bh=Dw8kbw8h2DFPko+Sd3gZNGIu6ZzGL80t2fS7CA8Og8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z3Qag+Xd7alp7b4W5zy5OkUhmN1zX7YlXNZOTerSogb2qPOTzj5Xem6rncMCQ7nnjwggUcvrDDlZC+2lNBm+n4M+g5eyQRSokx1dVn6VoiSZf9qWi8FA4dVH0GFxMDjupMRD5SzuLcqIluCS5Dvtu1R+3g8T/UAYXAgbywsZigM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wiBspgw8; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d71765d3e1so21350741fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711830499; x=1712435299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VgjEC6mZVs3So/hqI3O+3ycA6ijS0e0kjizc/9UESu8=;
        b=wiBspgw8+cjZl/VWAhlTYKZrfQQ4dJ1aNWkYVvwAKnTQxlQQ/kuweuIQBLTFpeyAi9
         fdrU9xzXe3O6+yGPG8Eb3TAIeE13u23eq4VKW7zdqfVZPoBUT188XTyjykEQfnCaZBCI
         uFZd2fScoSJ4WWfQePEKz3s3Nu2L5lvij9RmjbZed7lEaMID7BZu5Kx0sOMTDOyTJ4h5
         /fXHtpz0z+qh7wahUGuqzzWZDgsDjBBwPvIfulmiEPlqfjKufB2RwCAVCnUXmtoPi/x+
         XUy7QBW2KJVlmCv810fzBupFiEacL3/3BsABCOToYEoUQNhPPv7BZqdP+PSaIUHy1q9V
         mc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711830499; x=1712435299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgjEC6mZVs3So/hqI3O+3ycA6ijS0e0kjizc/9UESu8=;
        b=odhjvVqOLj6HJvLZGNpVKqjU3ejYRhfhraQHy6rKJjhY9vpo1YW+munCdAXq7cq5f9
         kggNqCrDqIS9fmLTDCtvZg2MvtIiz4/YGc+ImpQCxlP7jReRy9HHzkXl5Qr4G7OEf+O7
         lvhRYgp+OoFC8Fnb8GbVhczCOsMgz9LNAtqV086coca71Y92lmV7dtsXcPUCFn9xTzNE
         z8QI3Rs/9sRwQ2rLl0xwNT5opTpiN5oDa+SKFpceE2l2CCvs4Ue1sRPccaQeDv/QnXzL
         5+pTSMYgu8eIhBssT5Kdvb1Ss01PPwkFsvwoDAb6qhZAiBbH7UT/ubJhrSK3rNIG2n0B
         EGpA==
X-Forwarded-Encrypted: i=1; AJvYcCXx//YBzEh/slIpaf0SoLBzunneW0e+secwnroOtrR/lPhMCaMOOXvy92yHqKxvfou6W04AdKZWsz04fKC/cqyePbUp8tfA3y0i3Zrs
X-Gm-Message-State: AOJu0YxF2sZVM+kf+1JLL+8RtCOqhnXU+L11V1iH5oLBzAgI7j7hMGAW
	KVYmqYHumhzH/jYc2InyYRgHT5v7UL3aTtXl3VNxXHiiZckKn6FaBuAlcmfMkjm0/uVXNcynr2h
	Z
X-Google-Smtp-Source: AGHT+IFaqdVLHxk3OG9Fric3iB9NG5ZmjFBedjjf2RCQQIV53J1zBua/CNpqD1diLQN+bzP8QmCXOg==
X-Received: by 2002:a05:651c:94:b0:2d6:b8d2:3712 with SMTP id 20-20020a05651c009400b002d6b8d23712mr3234554ljq.26.1711830499381;
        Sat, 30 Mar 2024 13:28:19 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b004146a1bf590sm12602084wmb.32.2024.03.30.13.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:28:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Russell King <linux@armlinux.org.uk>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] drm/armada: drop driver owner assignment
Date: Sat, 30 Mar 2024 21:28:16 +0100
Message-Id: <20240330202816.83973-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  The CRTC driver is registered in different file,
armada_drv.c, but that should be the same module and if the
values were different core would overwrite them anyway.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/armada/armada_crtc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index c78687c755a8..1e67c84525d7 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -1087,7 +1087,6 @@ struct platform_driver armada_lcd_platform_driver = {
 	.remove_new = armada_lcd_remove,
 	.driver = {
 		.name	= "armada-lcd",
-		.owner	=  THIS_MODULE,
 		.of_match_table = armada_lcd_of_match,
 	},
 	.id_table = armada_lcd_platform_ids,
-- 
2.34.1



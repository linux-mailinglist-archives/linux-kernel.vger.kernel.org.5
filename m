Return-Path: <linux-kernel+bounces-125842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE940892CF8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0A6282D3B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0F942A93;
	Sat, 30 Mar 2024 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKSI8rW7"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30A44D5B0
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830481; cv=none; b=HjDbKqqqynUD4isQAI3feuwv/+8ZK2bzQiuUjTJigP4zZ1rmHGohCoFutQn3SQjztRF93StNwW1fwoAMr7knFfcoKVNxiC6K1aBm/v7DiwFumNhbS8VCdFtajcK4xqptYRK15lMV8tLugse7jz0W8QQ+5nOFdi2nM0b75Es4MJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830481; c=relaxed/simple;
	bh=jXSfJ+U5Hn0uskStcwtcbYkNs4IP1prmZxWKlNMy+cI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aLcIev0tLQrt4I4SAteKmr24OrNwvbMM2o9p9zmA4oDoTWhG7+mHrVz04Qv4O+Ha1EGDUfs8L/PGNrH7WuiJdCMFedNCsNDfnmnjfZN27HvLytGas6dtxW9wYnSXrleIjBPV84RnW2tMt6iU0gbUYnVLebqS+dkWGQJWRfOWAuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dKSI8rW7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4154bf94fe4so11869755e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711830478; x=1712435278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VEUaT6J6FXID1oZan7ok4XZwZWXYAqZIH0eNgAaKUuw=;
        b=dKSI8rW7lH77tncAZKZCdtqL7LuDu/3pex5dxr9+E5lV8xKP5Wetif8Q2Hvw5p222/
         63zmrfIqQVkolFGKKJLNQ7CDQJ7o4CJvclRj/vdgQkMYpKR5klq2MXV5fIYLhTkoB9q0
         eFZ+A+HG/ZajY3gay3J1WmXqcbTCJwiKBO19DouJACnw7Hi47BHhpDiyM2KYMhklEfaA
         VQ6J8YLqZK2N4tlAlkVWtMYt1kkFWpm+ihmnvAkas3vNI6pRibukTR6D8M4/qHssYllR
         CwotZRscFiYPqnq7eN2V47LF9EJ3Cr6W1ONxHwlMnzQTw4imydLmYgCqTydc8VMTEfde
         rgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711830478; x=1712435278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEUaT6J6FXID1oZan7ok4XZwZWXYAqZIH0eNgAaKUuw=;
        b=oipivwMlf8ntyQs5r2iHeAkNiQliGXcOeLtLU33cwwZfMtSO8q1qr6Rti8V9yp98n1
         xWh1MvURpRQ0jkAEzWIeUBNLqvCWl/faoh9qyaVrLR9SNuAmw50M+XTRhgKsvSewekOi
         lHluhzH8ti6VMIpkMs7W2g6+YGqRkCIY0bN9gfHJBg7PLv9SzlBKZebngNkkDU8FwPlX
         M6qu1lyzb+A9ubC0NJW5VeaMyjudlbLdmIRwhclBW1x5MnruXxP38rkf/4w41/QLT7KT
         CsIrA77eSwpwhujbvdxIsOSwZYr2Pd3dvCFA8nFVR9Sc43XD3TkMVQSjlhJ9rTIiKqUW
         kYQw==
X-Forwarded-Encrypted: i=1; AJvYcCXImWRVuKEGi0MURVivkRAOQjs7Jz9hNZktbGk/Po6sdphW6Kgo42JUhX4Ym3KW+6RuImL2TJlXQatOIPWLelp/q9AuXJdqPtBEL0/C
X-Gm-Message-State: AOJu0YzGv+v7Jv1YTTn1T7lHuTVSoclK6lR7CvqYL1Ps/slBMoU8+SmO
	DjtRo/9Fc1NE7gC8X0F9wsNjqCoNGqdvF+IYarZmSwxq33slXiYya2NdwGNW2Kg=
X-Google-Smtp-Source: AGHT+IH9u1jbXm1D+cbxbpcnjqvR/sECjqitbMaUx4EQPajbJbh1hh8/lA8Akm+UYN+n59Vpp7Aj/w==
X-Received: by 2002:a05:600c:35ce:b0:414:64de:160a with SMTP id r14-20020a05600c35ce00b0041464de160amr3982003wmq.12.1711830478425;
        Sat, 30 Mar 2024 13:27:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b004146a1bf590sm12601295wmb.32.2024.03.30.13.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:27:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] drm/rockchip: cdn-dp: drop driver owner assignment
Date: Sat, 30 Mar 2024 21:27:54 +0100
Message-Id: <20240330202754.83907-1-krzysztof.kozlowski@linaro.org>
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
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index a855c45ae7f3..419542c66b53 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1259,7 +1259,6 @@ struct platform_driver cdn_dp_driver = {
 	.shutdown = cdn_dp_shutdown,
 	.driver = {
 		   .name = "cdn-dp",
-		   .owner = THIS_MODULE,
 		   .of_match_table = cdn_dp_dt_ids,
 		   .pm = &cdn_dp_pm_ops,
 	},
-- 
2.34.1



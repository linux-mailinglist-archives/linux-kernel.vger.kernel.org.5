Return-Path: <linux-kernel+bounces-92456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A93872064
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288301F25577
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E72E85C6C;
	Tue,  5 Mar 2024 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPPHXapv"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A885920;
	Tue,  5 Mar 2024 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645929; cv=none; b=SRoqkTMXcRWX9ha3KLmHwq4Sg6a+OKCPptvWBwNOczMxxUZOXqv/a+DSn6uLN3lPqA8A0eia1iXWIIjocNVyJ7uUCsW1IDc/XaX/HMopJyq4yC304KNIiYemJsFX2lub/WbnlhzBxKDZ3p9pneVLzNA1TyxN7SXNvbPGmmXtdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645929; c=relaxed/simple;
	bh=viXBDIqZFNOIsn5ae6yYM5O580OYMBch4pTlVqzBYyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t02T92AY4NQL2bkuFXhGHyqhmwHFBrIGs5uK0qEtENB2tb2ravaq+N+cWQppuQnBpfPPD2LCX9CT7cEZYUOW4rZHcxLp1d4bwBdL15p3FPhTbirC6n4QE+4JGxW5canAUVGaHihUjZBDwU2ybqgv5+npu541/knrJqXwQNMO2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPPHXapv; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6098a20ab22so35039227b3.2;
        Tue, 05 Mar 2024 05:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709645927; x=1710250727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nlldgESxqJCrJbyy2hwlc9rmU3P83nYDEwvz0WXxepU=;
        b=NPPHXapvirD9FW0pX0MDCrkI8JqimP+qzJQdwqdmlGa6iHckBTWM0NRD51/Dt5HHkS
         mZjNaUM/XDZS046DOdCU8cNTnY6IDxx8GKGH0qqoL6P7SZ1izAMYqXokzGWy2tii1Jv0
         aP2byR+ToRmU9mBt9feBe4WUn3GWgfdjS0M7Q597gdhzhGYA2GV4qqdod3jFnNc28/s5
         ScctfotkfNyMyLJyBkH6q6AIr3e209RTS5SnwK4FGFlj48bQQnxAh6m7IdihdL+yqpnI
         rJHeMe0T4mN4SW0fZGNp3rDvMlJLBrikpdKwNsTsW7EOGQNcengj7K4TNnfX/PuQXD8q
         QcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709645927; x=1710250727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlldgESxqJCrJbyy2hwlc9rmU3P83nYDEwvz0WXxepU=;
        b=JdZkPorRUP693eRG5uSSsusF6W0I/EC832DTNWavgzYCujdlyCo+w9091h4s3hiPge
         b2HM0ARW1tc7adUaGF8PTk0Dj5u8xdy79Fhcgi3I+GUo9+rA5NmHW3pobj05DHVnDTdK
         zp5yL9xphDx0BUcUefKIbjZWzwNhnYHEmHUZvTnClmCEm8M9KZul9NHRC8SOwVQb1jet
         sNeHj1d0kvWlW7LO6PcVh7bviBERK/GaBgFPWJ1ERorvKJTaJ9vA2t3dFMlv81t0PE9A
         toXLulX2nqHOUTV849QcQV5rNtwasNjjAABi7A3lnSs57KGkBP612QQtFR5qqFtUzWse
         5rpg==
X-Forwarded-Encrypted: i=1; AJvYcCWPkSAdrrr6BZE/e6d2Fo+UFrMZtD9WZvYCaGnPzxwTCHkUd5EJwEte7tO12d0pQ1LkMzpppLcecYFi6Pl1gT3uBNRc0sVTX6zg9bl0
X-Gm-Message-State: AOJu0YyDJVGHSCfDW3dZnblAUp0MR2IsiVcQqzz7OTlV5m9fln49ngcW
	Fw0U9v/y/+XsGhUQym85NazZKlRgVUzzEyyLLaIc+oXJEBoYXvRs
X-Google-Smtp-Source: AGHT+IGSNrtJRZhOzk9LQh+cnbTbqUjzM5uy3WTGTE/Me+dnfzS6CDMmxzKroB3zKChJKvELYULcQg==
X-Received: by 2002:a0d:eb52:0:b0:609:15e2:1e2c with SMTP id u79-20020a0deb52000000b0060915e21e2cmr12563901ywe.27.1709645926875;
        Tue, 05 Mar 2024 05:38:46 -0800 (PST)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id u11-20020ac8050b000000b0042dfa55a3d5sm5343796qtg.25.2024.03.05.05.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:38:46 -0800 (PST)
From: Abdel Alkuor <alkuor@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Abdel Alkuor <alkuor@gmail.com>
Cc: linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] leds: ncp5623: Add MS suffix to time defines
Date: Tue,  5 Mar 2024 08:38:17 -0500
Message-Id: <20240305133824.1551809-1-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make the time macro defines clearer, add MS as a suffix.

Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
---
 drivers/leds/rgb/leds-ncp5623.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/rgb/leds-ncp5623.c b/drivers/leds/rgb/leds-ncp5623.c
index b669c55c5483..2be4ff918516 100644
--- a/drivers/leds/rgb/leds-ncp5623.c
+++ b/drivers/leds/rgb/leds-ncp5623.c
@@ -22,8 +22,8 @@
 #define NCP5623_DIMMING_TIME_REG	NCP5623_REG(0x7)
 
 #define NCP5623_MAX_BRIGHTNESS		0x1f
-#define NCP5623_MAX_DIM_TIME		240 /* ms */
-#define NCP5623_DIM_STEP		8   /* ms */
+#define NCP5623_MAX_DIM_TIME_MS		240
+#define NCP5623_DIM_STEP_MS		8
 
 struct ncp5623 {
 	struct i2c_client *client;
@@ -92,8 +92,8 @@ static int ncp5623_pattern_set(struct led_classdev *cdev,
 
 	ncp->delay = 0;
 
-	if (pattern[0].delta_t > NCP5623_MAX_DIM_TIME ||
-	   (pattern[0].delta_t % NCP5623_DIM_STEP) != 0)
+	if (pattern[0].delta_t > NCP5623_MAX_DIM_TIME_MS ||
+	   (pattern[0].delta_t % NCP5623_DIM_STEP_MS) != 0)
 		return -EINVAL;
 
 	brightness_diff = pattern[0].brightness - ncp->current_brightness;
@@ -117,7 +117,7 @@ static int ncp5623_pattern_set(struct led_classdev *cdev,
 
 	ret = ncp5623_write(ncp->client,
 			    NCP5623_DIMMING_TIME_REG,
-			    pattern[0].delta_t / NCP5623_DIM_STEP);
+			    pattern[0].delta_t / NCP5623_DIM_STEP_MS);
 	if (ret)
 		return ret;
 
-- 
2.34.1



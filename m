Return-Path: <linux-kernel+bounces-18463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DC3825E04
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 04:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD3B284A47
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 03:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495F215BB;
	Sat,  6 Jan 2024 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB/W4Ec3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACEC15AC;
	Sat,  6 Jan 2024 03:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-781706de787so21414385a.0;
        Fri, 05 Jan 2024 19:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704510218; x=1705115018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=20TqVhAB8vPYJO1AMqhc8T0gziZeUwh10Ilg/gZn7uI=;
        b=PB/W4Ec3hpCZl80Re0dy7/HHBrRLka/QHwka5RoomoEshlhxWxX7zSJWeLA/40J6ju
         DSSU+qq/PUhflywFUhy/1mRyrAUYfhjLabYw8M60miUTCeaYuI5Htjb7p5NS5546wdp9
         Vr0n9IxL69DuDDBsgVuL9BE2RmxitxxyrFsrhs2qA7AHrszLrBe4IHu0c4Qql0hSgpWB
         jwVywUj8R0YDX68tAasgaopG6UlFSwePXSEeGt96Llj44MfMamIN0tmglgwHXka4AtQE
         roxNWtuvgyXe4NQpZ3III/DZzrrpACq3MC8g3b99MGbI22XiGT1nIATegwzVGIN3cchU
         jbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704510218; x=1705115018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20TqVhAB8vPYJO1AMqhc8T0gziZeUwh10Ilg/gZn7uI=;
        b=Sc14momfRNqvCiKPAkq0Va443KuuBWUtBZOkjfqvvLOR30dM8dBNoieuyZvLvH2V/t
         hbHZiJClIDKlpszquO6S4RtWkiFCWv8Io4ztjnhkkq50oSIH8GD29DRiytG9lmZ15RkO
         Sd6JLiFkfPZOp5aId1DgKxgYW5+L/Bcm3TPec/pVgWbYMsYO//rwcWYpspsyOi7vfu20
         2pYWqcUc0Tdznn5JAcn4cIOkmFKfeST4CjhPkyuZkeJK6Ih736IPJpwvNi5UcQwFH+2j
         lNkpZZxfQf/LogK4Juav5rh9+Zaf7psKAFmDOs/UqqKSeA9s/DMEMb2kiZeJHqAx+1iS
         6BjA==
X-Gm-Message-State: AOJu0YxsB2LyTEJcSetBBMc29DY1C1PfmretVslQKHBV4H8Ddi9OyVnT
	sCg5WgoKlH7+hLaGO6VwRVivynSkyWMQzg==
X-Google-Smtp-Source: AGHT+IE94xTURotlCM7KQ7XdufaVxlxs7ip3nJNa/HOlRmxOYIBR/ouDukkzrjCsflTDQCRfxVmR8A==
X-Received: by 2002:a05:620a:258f:b0:781:6e32:a894 with SMTP id x15-20020a05620a258f00b007816e32a894mr532104qko.39.1704510218160;
        Fri, 05 Jan 2024 19:03:38 -0800 (PST)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id v3-20020a05620a0a8300b007816e3ed3a5sm1026313qkg.51.2024.01.05.19.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 19:03:37 -0800 (PST)
From: Abdel Alkuor <alkuor@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>
Cc: Abdel Alkuor <alkuor@gmail.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (lm75) Fix tmp112 default config
Date: Fri,  5 Jan 2024 22:02:53 -0500
Message-Id: <20240106030254.384963-1-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set tmp112 conversion rate to 8 HZ and 12-bit mode.

Fixes: 35cd18048542 ("hwmon: (lm75) Aproximate sample times to data-sheet values")
Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
---
 drivers/hwmon/lm75.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index d3b0d8bf1654..e00750718536 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -269,8 +269,9 @@ static const struct lm75_params device_params[] = {
 		.resolutions = (u8 []) {9, 10, 11, 12 },
 	},
 	[tmp112] = {
-		.set_mask = 3 << 5,	/* 8 samples / second */
-		.clr_mask = 1 << 7,	/* no one-shot mode*/
+		.config_reg_16bits = true,
+		.set_mask = 0x60C0,	/* 12-bit mode, 8 samples / second */
+		.clr_mask = 1 << 15,	/* no one-shot mode*/
 		.default_resolution = 12,
 		.default_sample_time = 125,
 		.num_sample_times = 4,
-- 
2.34.1



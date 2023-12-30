Return-Path: <linux-kernel+bounces-13370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DA382041A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 10:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571DD1C20C09
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4624F2567;
	Sat, 30 Dec 2023 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2N0h2Jg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3CF2561
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-3bb9d54575cso4469475b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 01:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703927495; x=1704532295; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5u28Rp1tb71FYlh7pmJ9O9fHwq/HrI65yXbQ72B8Gc=;
        b=I2N0h2JgfMJOe02pKK+wPcJM3bV38yVCJ4bJST06KU7wSwjjPsyImekQL8rFbNyh1/
         eyZIejc+S2ISLBooBtpOjTKHG/ntadw/IGLj3LBnDf5neU0iA5ODtaGVKIRohLvzKuUw
         Z9UhNIpCOYziqCkKkqrOMbr5xI7YynFmfJvpyLZ9CmZ+6Hap3ZxCqL4GuhyBQHMjbsE6
         bDPUHz+kAb1UTEK/GVAx2pojCXQL+extbXmuOswmJTpcrdYMKGr7ZKTk5gfFUDnIfgKv
         Gygy4wDoLB52e6IafvrIjj5/0MDpt2eHDGHOgn+xww51sV6XgY9sSbgnFrNE+DbDS68z
         Y4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703927495; x=1704532295;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5u28Rp1tb71FYlh7pmJ9O9fHwq/HrI65yXbQ72B8Gc=;
        b=Rai3Sqwi5XDOiAFx/D70EFkCv3NsVNx4wXLBONFDaQDiIoGnHLtVSNXzmbF5rpBa+N
         jtKShbY/mN44jB8ojpduAF0cB9f+3yG7A6U/NHLhECtPWTbaK+FXhK158x0+MaHY6421
         9pyB3VxvZmw9zormv2l4K0SNdLZk4EPf65mpB+iZNsvzI2gwm3iA1ZdFxUAsxVwRw6Hz
         JRSIHLXwK6K/1z3/YoodBtqPXe2smvXwlpouRZXLpbcFhHHmqj4KSulbP9yVsxOAXyI8
         7Jn9T1Y4F/0axTjebBfEPjfkO1HoiBoaEa/q49mfOXpbKvdTtcglWXaTKQ7E9ib52LmK
         xIqw==
X-Gm-Message-State: AOJu0YyQVmolOHpv7p/4eF0TxoKa9K0kwzssmBNLG/c9ASAyW7Bzvs7c
	B4oyr0wOsTTjd+VVS8wkdekHobXyxki30kkK95M=
X-Google-Smtp-Source: AGHT+IHLxNsKzyXqI+LKwAPn7SSSKMKNg3JpsILPAgWv2lynkK/hKwnTFNYhMy+ffvpiTQ+Q4F4cLQ==
X-Received: by 2002:a05:6808:23c4:b0:3bb:dcf8:eb00 with SMTP id bq4-20020a05680823c400b003bbdcf8eb00mr2990982oib.11.1703927495286;
        Sat, 30 Dec 2023 01:11:35 -0800 (PST)
Received: from Harshit-PC.hsd1.ca.comcast.net (c-24-130-71-249.hsd1.ca.comcast.net. [24.130.71.249])
        by smtp.gmail.com with ESMTPSA id t40-20020a056a0013a800b006da2aad58adsm4019507pfg.176.2023.12.30.01.11.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Dec 2023 01:11:34 -0800 (PST)
From: Harshit Shah <harshitshah.opendev@gmail.com>
To: pgaj@cadence.com,
	alexandre.belloni@bootlin.com
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Harshit Shah <harshitshah.opendev@gmail.com>
Subject: [PATCH] i3c: master: cdns: Update maximum prescaler value for i2c clock
Date: Sat, 30 Dec 2023 14:41:23 +0530
Message-Id: <1703927483-28682-1-git-send-email-harshitshah.opendev@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

As per the Cadence IP document fixed the I2C clock divider value limit from
16 bits instead of 10 bits. Without this change setting up the I2C clock to
low frequencies will not work as the prescaler value might be greater than
10 bit number.

I3C clock divider value is 10 bits only. Updating the macro names for both.

Signed-off-by: Harshit Shah <harshitshah.opendev@gmail.com>
---
 drivers/i3c/master/i3c-master-cdns.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index bcbe8f9..c1627f3 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -76,7 +76,8 @@
 #define PRESCL_CTRL0			0x14
 #define PRESCL_CTRL0_I2C(x)		((x) << 16)
 #define PRESCL_CTRL0_I3C(x)		(x)
-#define PRESCL_CTRL0_MAX		GENMASK(9, 0)
+#define PRESCL_CTRL0_I3C_MAX		GENMASK(9, 0)
+#define PRESCL_CTRL0_I2C_MAX		GENMASK(15, 0)
 
 #define PRESCL_CTRL1			0x18
 #define PRESCL_CTRL1_PP_LOW_MASK	GENMASK(15, 8)
@@ -1233,7 +1234,7 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 		return -EINVAL;
 
 	pres = DIV_ROUND_UP(sysclk_rate, (bus->scl_rate.i3c * 4)) - 1;
-	if (pres > PRESCL_CTRL0_MAX)
+	if (pres > PRESCL_CTRL0_I3C_MAX)
 		return -ERANGE;
 
 	bus->scl_rate.i3c = sysclk_rate / ((pres + 1) * 4);
@@ -1246,7 +1247,7 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	max_i2cfreq = bus->scl_rate.i2c;
 
 	pres = (sysclk_rate / (max_i2cfreq * 5)) - 1;
-	if (pres > PRESCL_CTRL0_MAX)
+	if (pres > PRESCL_CTRL0_I2C_MAX)
 		return -ERANGE;
 
 	bus->scl_rate.i2c = sysclk_rate / ((pres + 1) * 5);
-- 
1.9.1



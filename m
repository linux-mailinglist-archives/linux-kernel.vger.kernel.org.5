Return-Path: <linux-kernel+bounces-60506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD0D8505D4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB891F2258B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FAA5D725;
	Sat, 10 Feb 2024 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXL/xbjE"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FA45D46D;
	Sat, 10 Feb 2024 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707587761; cv=none; b=hjzzCiGtD53/S6qGj0CdE/70sCwHrMZ/SB0G4H8OU4KOD4jsOuYyRfwFXZsoJIaHVnn/BP0Yxa1cQlXHn8xWbCRnGd4HyMUo/mwvM0torMKy0G8dJ44+ST+mj5GIYM1NGGLBMDtFd3CVZTFuHBKevA3Xe1Dp3x7t9ILGT49emEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707587761; c=relaxed/simple;
	bh=2kekeIV6CVCl/5dOex1gd4NoQsB/CSJ4YIqtUFj9eeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QmZSleZkUZIo6oPjee/jnDr5A2GIkleQBmNSWvo0ggvdthhcIORn1C3V9LgFvp+oZEHqWlvwgn4UMGGDMomk9GjMGZi5V1mhOZ1ekYrU7cKUKXOExsCRf1ZGT2BPRPhmP1cans0uP8i7Un7YQ9mKxwSAgHbSkf3P0MLZ/bdqqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXL/xbjE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a30e445602cso588664666b.0;
        Sat, 10 Feb 2024 09:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707587758; x=1708192558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXNiY/nOpUxXERDJEI/Sg1XpGwLPYihXCQijrmxJnI0=;
        b=iXL/xbjEfv8TRlPeN6VyJDTE9g67G9HmpccZ7ecXdTXkRykiU2zkC50rwjwJM7He1w
         UOH2mLHg57Eb541wGgSIR6z1vIwxTvGfb5w5D5YOR6x5kgz7fWWYYXi7vzkkQokmwmMD
         gSwuTdHxDrFmIbbhKpUAtKxuc+d7uJJExve5bIIpUH/YHgr7TcNVy7UOO78dQFSGT1j9
         3vsUobpP/DENUP72T9AHBHYddf9rk9RRbBVMV8qH3UU+6zbgz4CfucEkX4jhkForAF04
         Aav742saOWaO2QNK6ElEPGPO5DQm6wSbCYz+/uQITG1WiwlKxC6kg/lOI5Ik2kxlB4uL
         nNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707587758; x=1708192558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXNiY/nOpUxXERDJEI/Sg1XpGwLPYihXCQijrmxJnI0=;
        b=GHZlk4uWpjkWUoO1ZsKNcvGVa4hKU4Q4AUDVSmghK3Y49L5bTC3WVU3MMIn0P02AA7
         /+EP8cuCQGco5K3ZPL+Q0q+qfh+AQFU/SjH0+VSDaoIhiAppqkfKTVowObJz1ZgTGx4U
         f6XWIEo/N660/7uiQUA31VBH3TnfscER33XiTj08T2OGe8lAVhuxnEztcjY4SikVyUWv
         90gzmBS4rCj2IjfzC4ycYvnYXimnB46dsT2bH3UIcKzeCnOZEQpQ6f9nC2ljUfWMRfv/
         pOjfQuuJmelk9cqk1Aeta3eFVSLpkPlc8f4I1wbaxskpdrh6fo53nXxyzNwE6KRVQn4s
         Xl4A==
X-Forwarded-Encrypted: i=1; AJvYcCVRmqw0HtzAcIR1AHnB8QFNWxtY/P9orRcZs4e4kkcH8LN54Z00VLGoOSUY0F+0iSgbcs690ZxB6/1bkvjphp5JQ4AiT4NLlF8BcPWq
X-Gm-Message-State: AOJu0YwSILJsA6gJYmrP88q/jgLErrXY/i8s2Xotn3XFep58VHJwFLvY
	eKxD4HkbaMisNyHvNyJCTHdVI54kFm+mJ+EcgvxLdFr/kFBWoELeNG49AyQZ
X-Google-Smtp-Source: AGHT+IEPd2o0bs2HtuJlE0VqQ2TflOQIGDVIEhfxFiqe4tUnBCPXlr29IjNU9BpshKgmH4WwxpU6Nw==
X-Received: by 2002:a17:906:a857:b0:a3c:4d7a:3c48 with SMTP id dx23-20020a170906a85700b00a3c4d7a3c48mr851982ejb.3.1707587757762;
        Sat, 10 Feb 2024 09:55:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7h5fDQ+CYi5W+FM7mGI82XutYHJvKXCkEhzF3ONL/J/5w04EfPMsLir13QftPtLeqHSre/h+D18eU9XHm5KyFDlC7DmHs9kgsD00mjJ1xG8HOulrDo+Uq11d6QebcqCwLP91gba55nzQtprTu6wxM71c0cpPCmZfUUk9q0d5ufvpzc+ldpMWrPMCJa88Xp/rfFz4/yNGY6Dzs5jHqmNvzx/0=
Received: from xeon.. ([188.163.112.73])
        by smtp.gmail.com with ESMTPSA id go43-20020a1709070dab00b00a385535a02asm2001053ejc.171.2024.02.10.09.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 09:55:57 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Benjamin Bara <benjamin.bara@skidata.com>,
	Richard Leitner <richard.leitner@linux.dev>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] input: touchcreen: tsc2007: make interrupt optional
Date: Sat, 10 Feb 2024 19:55:30 +0200
Message-Id: <20240210175530.137361-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210175530.137361-1-clamor95@gmail.com>
References: <20240210175530.137361-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case tsc2007 is used as an ADC sensor there will be no interrupt
provided at all, so set up an interrupt only if one is present and
remove associated warning.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/input/touchscreen/tsc2007_core.c | 30 +++++++++++++-----------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index b3655250d4a7..f6bb12ebf97f 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -178,7 +178,8 @@ static void tsc2007_stop(struct tsc2007 *ts)
 	mb();
 	wake_up(&ts->wait);
 
-	disable_irq(ts->irq);
+	if (ts->irq)
+		disable_irq(ts->irq);
 }
 
 static int tsc2007_open(struct input_dev *input_dev)
@@ -189,7 +190,8 @@ static int tsc2007_open(struct input_dev *input_dev)
 	ts->stopped = false;
 	mb();
 
-	enable_irq(ts->irq);
+	if (ts->irq)
+		enable_irq(ts->irq);
 
 	/* Prepare for touch readings - power down ADC and enable PENIRQ */
 	err = tsc2007_xfer(ts, PWRDOWN);
@@ -253,8 +255,6 @@ static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
 
 	if (ts->gpiod)
 		ts->get_pendown_state = tsc2007_get_pendown_state_gpio;
-	else
-		dev_warn(dev, "Pen down GPIO is not specified in properties\n");
 
 	return 0;
 }
@@ -362,17 +362,19 @@ static int tsc2007_probe(struct i2c_client *client)
 			pdata->init_platform_hw();
 	}
 
-	err = devm_request_threaded_irq(&client->dev, ts->irq,
-					NULL, tsc2007_soft_irq,
-					IRQF_ONESHOT,
-					client->dev.driver->name, ts);
-	if (err) {
-		dev_err(&client->dev, "Failed to request irq %d: %d\n",
-			ts->irq, err);
-		return err;
-	}
+	if (ts->irq) {
+		err = devm_request_threaded_irq(&client->dev, ts->irq,
+						NULL, tsc2007_soft_irq,
+						IRQF_ONESHOT,
+						client->dev.driver->name, ts);
+		if (err) {
+			dev_err(&client->dev, "Failed to request irq %d: %d\n",
+				ts->irq, err);
+			return err;
+		}
 
-	tsc2007_stop(ts);
+		tsc2007_stop(ts);
+	}
 
 	/* power down the chip (TSC2007_SETUP does not ACK on I2C) */
 	err = tsc2007_xfer(ts, PWRDOWN);
-- 
2.40.1



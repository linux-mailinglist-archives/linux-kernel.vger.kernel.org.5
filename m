Return-Path: <linux-kernel+bounces-23131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F87A82A811
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B066283B71
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A225D304;
	Thu, 11 Jan 2024 07:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+cOTuN5"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1F3D2E5;
	Thu, 11 Jan 2024 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso3818518a12.2;
        Wed, 10 Jan 2024 23:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704957185; x=1705561985; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/uoyWbE2xaZf2TSvVNAEFtqD9eBBBq5P8ndHqpI2t7M=;
        b=X+cOTuN561JrstNhs/ITTxZKiDyVX6mTcQ7dlPOvB8cSFAPNmqQ9YPjpswtBpBroyB
         P+7n7xMjpd/3h4lQVYVmcEZj4v53vb+3whq53beeD6IwwBka45RltZsE9Vp41KnScPt8
         WblMEmBRwtKrQ6gvdqDWQpXcmoLil8PHjTpSd8MSwo40rAW0V7kDezmWSuxJuYHe8f7t
         Pq5AeWnrXDuVMKDTe0WoBLres/tgpA0llcZ84yrocOA727ZJEmUlX1wg8M2uCLXrveBY
         bJUreMPoaMtUqVhuoyigkOhEuUy5C+uzkXSbTz2hY6Fwtc4VXLuMKgjdcdHi19Pl4d+a
         v9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704957185; x=1705561985;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/uoyWbE2xaZf2TSvVNAEFtqD9eBBBq5P8ndHqpI2t7M=;
        b=gx0yp4mDRAm6W93TjK8YxfW8qe/gdvlFaywqTYRvLi1406wcJKc3/nOLWB4opYrSJk
         76RdNspNs9dOKT5/oBdagWbN+QrqpZHXX1JwximFr4vhE1KdthdjasM9Rlvoupcx5z+Y
         rlBhtCRoI2rSecoTVAtbUStMoPeo7Qdiud+2Pa7euIlznOlTstT3tshhKYmHRHUcBJzS
         F/OuMA+tyOqCO+8mXmdxYuQv0dZ+Ji3Sf/6EyGM7INs9ccoNDzFR/TR3w9PyLM1oM9g3
         RmBxdVErzYzV5/G8pb4yPJV4FBzjZ/f+86I/XdvV/PTXTv8Mkd1RPHnC0rFGdIkdE7QI
         x1yw==
X-Gm-Message-State: AOJu0Yx48v6fqwCuZq/h+lIP2eq5LsDbLemSsJvcJiarF+QPChFPGXZp
	mkOg0ogOPMh2v+3MW2iwNOy/Sfgp+aw=
X-Google-Smtp-Source: AGHT+IG7Hg4E09Ai9/gue83kmEihR6sBHD0356uYEBnLh79dcG4hDo0Nzw8cwjwJs+VAJGMn/z9sNg==
X-Received: by 2002:a05:6a20:3948:b0:19a:112e:89dc with SMTP id r8-20020a056a20394800b0019a112e89dcmr635621pzg.62.1704957184593;
        Wed, 10 Jan 2024 23:13:04 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:70e2:a0a5:5166:fbbf])
        by smtp.gmail.com with ESMTPSA id i63-20020a638742000000b005b458aa0541sm483482pge.15.2024.01.10.23.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 23:13:04 -0800 (PST)
Date: Wed, 10 Jan 2024 23:13:01 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: adafruit-seesaw - only report buttons that changed
 state
Message-ID: <ZZ-U_bmZpIdoYA6c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If a button has not changed its state when we poll the device the
driver does not need to report it. While duplicate events will be
filtered out by the input core anyway we can do it very cheaply
directly in the driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/adafruit-seesaw.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/adafruit-seesaw.c b/drivers/input/joystick/adafruit-seesaw.c
index 1b9279f024cc..5c775ca886a5 100644
--- a/drivers/input/joystick/adafruit-seesaw.c
+++ b/drivers/input/joystick/adafruit-seesaw.c
@@ -56,7 +56,7 @@
 #define SEESAW_GAMEPAD_POLL_MIN		8
 #define SEESAW_GAMEPAD_POLL_MAX		32
 
-static const unsigned long SEESAW_BUTTON_MASK =
+static const u32 SEESAW_BUTTON_MASK =
 	BIT(SEESAW_BUTTON_A) | BIT(SEESAW_BUTTON_B) | BIT(SEESAW_BUTTON_X) |
 	BIT(SEESAW_BUTTON_Y) | BIT(SEESAW_BUTTON_START) |
 	BIT(SEESAW_BUTTON_SELECT);
@@ -64,6 +64,7 @@ static const unsigned long SEESAW_BUTTON_MASK =
 struct seesaw_gamepad {
 	struct input_dev *input_dev;
 	struct i2c_client *i2c_client;
+	u32 button_state;
 };
 
 struct seesaw_data {
@@ -178,10 +179,20 @@ static int seesaw_read_data(struct i2c_client *client, struct seesaw_data *data)
 	return 0;
 }
 
+static int seesaw_open(struct input_dev *input)
+{
+	struct seesaw_gamepad *private = input_get_drvdata(input);
+
+	private->button_state = 0;
+
+	return 0;
+}
+
 static void seesaw_poll(struct input_dev *input)
 {
 	struct seesaw_gamepad *private = input_get_drvdata(input);
 	struct seesaw_data data;
+	unsigned long changed;
 	int err, i;
 
 	err = seesaw_read_data(private->i2c_client, &data);
@@ -194,8 +205,11 @@ static void seesaw_poll(struct input_dev *input)
 	input_report_abs(input, ABS_X, data.x);
 	input_report_abs(input, ABS_Y, data.y);
 
-	for_each_set_bit(i, &SEESAW_BUTTON_MASK,
-			 BITS_PER_TYPE(SEESAW_BUTTON_MASK)) {
+	data.button_state &= SEESAW_BUTTON_MASK;
+	changed = private->button_state ^ data.button_state;
+	private->button_state = data.button_state;
+
+	for_each_set_bit(i, &changed, fls(SEESAW_BUTTON_MASK)) {
 		if (!sparse_keymap_report_event(input, i,
 						data.button_state & BIT(i),
 						false))
@@ -253,6 +267,7 @@ static int seesaw_probe(struct i2c_client *client)
 	seesaw->input_dev->id.bustype = BUS_I2C;
 	seesaw->input_dev->name = "Adafruit Seesaw Gamepad";
 	seesaw->input_dev->phys = "i2c/" SEESAW_DEVICE_NAME;
+	seesaw->input_dev->open = seesaw_open;
 	input_set_drvdata(seesaw->input_dev, seesaw);
 	input_set_abs_params(seesaw->input_dev, ABS_X,
 			     0, SEESAW_JOYSTICK_MAX_AXIS,
-- 
2.43.0.275.g3460e3d667-goog


-- 
Dmitry


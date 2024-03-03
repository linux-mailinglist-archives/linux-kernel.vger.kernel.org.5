Return-Path: <linux-kernel+bounces-89872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7612086F6C1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D7C1C210E3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7107AE55;
	Sun,  3 Mar 2024 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNQVyipj"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A42C7A151;
	Sun,  3 Mar 2024 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709493662; cv=none; b=s1NvV1wExTa7aCB/F8vYogKG7dX5CF7kL7L1OiU+5sVTFU/FxZB3cwaNeBo86pLSZWE+uGQjuHPPOUkUy0OgHExLx5xSGZNdFHp0JElPlIqru7AfYZFr0aLhqulO99smXh8R1BvWXrfamq1C8m9CVE1YPjg4frhphk56kCiYJGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709493662; c=relaxed/simple;
	bh=fjLJl3cqq864oDm5SBt+fAr/J7DCTIM94MhguqKr5vM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0B8aPZkxU1tF3Y1GhRoIDB+B7m3w+pmHaaueuJOF9UZWnnLvSE8l96KvejTGqkAcGBt2gQi1xYuJ/LmeDtGHLhLEy1aQHmWQZRzBI3vqmxzvF/DAYOm7fT3pCd1HU+6AJy7qAEwbF+P8u3tpTjCwGu7h0RJy6HN8n5UUkwhriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNQVyipj; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d311081954so41257911fa.2;
        Sun, 03 Mar 2024 11:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709493659; x=1710098459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSWMAFm7064NyBCt1jab/mHpp/0m7wJq3xMDyIcOz9U=;
        b=WNQVyipj02/0C4kruJ0rbShXdrOo3bQK6w28HrqwrrBw5dUt1obNUqj7Xz7mVla0PX
         6EWRt1fru2xdBAe93N7HxaH7X8NjWsZaO+WAvdu0IhVG6FbK7/gYFhw/VWUrjTrjpeCE
         Cjn1VQFCqLc3CejOLG0uZBwLzl/Q3WMUdjXZ3Gcz1++zJZBO7oOhJdYdZ7u2/PvFed3e
         7H/JFYfyKG2g5Xuoqb/x44xgIIO/S0GkJkPF6ZRbX5Y34wkVlq8U8y8uWyqKap34FaE8
         0J+6UJ2cJUqCWMonyn6GBqo7v5xNLzm7yyjrR2pQx/CD0set5lQo89oG2ZfQKa1vMT0x
         Kt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709493659; x=1710098459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSWMAFm7064NyBCt1jab/mHpp/0m7wJq3xMDyIcOz9U=;
        b=gGabu4YsmcK3B7Tvx9R2RaGK1mYH6QodITg6ZKb3xai/t+x4XWjiBtlGuLk1yE8ycp
         Jy6hiYklW4Dk60Xe0X5H3GWaAtgowdUB+H+5lVoYCROKjUZ2hbF8idtLjpO/NhDhnMEz
         yv2MpkTt1JSvJyXGgZ4rSspik0LHtwAGTLgrLsjVEIfkDHBnHN+F1BRi/YhPIUKgxzty
         aucqxp2dUNssqfAyb5Ulk32pcRSr7oyrNdewW4oDJw3IYqgAOcFIXdoLd2zXuG9pTPmp
         sreyBF02kNYR5xeRMBmBCP7jW89Tz1De1zJLEdcKBFnl2Lb17RJftwvi8EFkCksQ1tGd
         XdVw==
X-Forwarded-Encrypted: i=1; AJvYcCXljUpM/kkceODB3BoId/zLghtmXJvAbnhdx2ufyYmyamuTmo1EB2AqVgRRqpon4kZnrAkGvaUVLHaCu5IkbirzApQ/g2dBTMYPPTal7YRGCChv69sA8Z3HzhdwAHpSkL0jGLi6CHx3itg=
X-Gm-Message-State: AOJu0YyTxv07G6Pi9LQdhDK6+4tU9C5qsHoCUwlzjf/LD9V8arGu2VgP
	hLfRH975YNp85zJnOHQQxlOrATOuhVkgkLCpcWw6pYWuDIhSeUC7EGuz0YnYpMQI4Q==
X-Google-Smtp-Source: AGHT+IHVxS+jGoxEdSVRi/KH7vQrwqm/vM05EU+EXeHogp8bytWihDhpCfUFzbKDVNGOr78j+i/Rwg==
X-Received: by 2002:a2e:3a10:0:b0:2d2:a7af:f017 with SMTP id h16-20020a2e3a10000000b002d2a7aff017mr4835156lja.49.1709493658514;
        Sun, 03 Mar 2024 11:20:58 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id y10-20020a2e9d4a000000b002d3c466adc7sm68438ljj.15.2024.03.03.11.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 11:20:58 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: mchehab@kernel.org
Cc: mcgrof@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 3/9] staging: media: av7110: Remove spaces between function name and opening parenthesis
Date: Sun,  3 Mar 2024 20:20:34 +0100
Message-Id: <20240303192040.8116-4-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240303192040.8116-1-bergh.jonathan@gmail.com>
References: <20240303192040.8116-1-bergh.jonathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the following code formatting issue:
 * Removes extra whitespace between function name and opening parenthesis

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/av7110/sp8870.c | 42 +++++++++++++--------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/media/av7110/sp8870.c b/drivers/staging/media/av7110/sp8870.c
index 2c30582191d4..1f6c02744b6c 100644
--- a/drivers/staging/media/av7110/sp8870.c
+++ b/drivers/staging/media/av7110/sp8870.c
@@ -50,21 +50,21 @@ static int debug;
 /* starting point for firmware in file 'Sc_main.mc' */
 #define SP8870_FIRMWARE_OFFSET 0x0A
 
-static int sp8870_writereg (struct sp8870_state* state, u16 reg, u16 data)
+static int sp8870_writereg(struct sp8870_state* state, u16 reg, u16 data)
 {
 	u8 buf [] = { reg >> 8, reg & 0xff, data >> 8, data & 0xff };
 	struct i2c_msg msg = { .addr = state->config->demod_address, .flags = 0, .buf = buf, .len = 4 };
 	int err;
 
-	if ((err = i2c_transfer (state->i2c, &msg, 1)) != 1) {
-		dprintk ("%s: writereg error (err == %i, reg == 0x%02x, data == 0x%02x)\n", __func__, err, reg, data);
+	if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
+		dprintk("%s: writereg error (err == %i, reg == 0x%02x, data == 0x%02x)\n", __func__, err, reg, data);
 		return -EREMOTEIO;
 	}
 
 	return 0;
 }
 
-static int sp8870_readreg (struct sp8870_state* state, u16 reg)
+static int sp8870_readreg(struct sp8870_state* state, u16 reg)
 {
 	int ret;
 	u8 b0 [] = { reg >> 8 , reg & 0xff };
@@ -72,7 +72,7 @@ static int sp8870_readreg (struct sp8870_state* state, u16 reg)
 	struct i2c_msg msg [] = { { .addr = state->config->demod_address, .flags = 0, .buf = b0, .len = 2 },
 			   { .addr = state->config->demod_address, .flags = I2C_M_RD, .buf = b1, .len = 2 } };
 
-	ret = i2c_transfer (state->i2c, msg, 2);
+	ret = i2c_transfer(state->i2c, msg, 2);
 
 	if (ret != 2) {
 		dprintk("%s: readreg error (ret == %i)\n", __func__, ret);
@@ -82,7 +82,7 @@ static int sp8870_readreg (struct sp8870_state* state, u16 reg)
 	return (b1[0] << 8 | b1[1]);
 }
 
-static int sp8870_firmware_upload (struct sp8870_state* state, const struct firmware *fw)
+static int sp8870_firmware_upload(struct sp8870_state* state, const struct firmware *fw)
 {
 	struct i2c_msg msg;
 	const char *fw_buf = fw->data;
@@ -91,7 +91,7 @@ static int sp8870_firmware_upload (struct sp8870_state* state, const struct firm
 	int tx_len;
 	int err = 0;
 
-	dprintk ("%s: ...\n", __func__);
+	dprintk("%s: ...\n", __func__);
 
 	if (fw->size < SP8870_FIRMWARE_SIZE + SP8870_FIRMWARE_OFFSET)
 		return -EINVAL;
@@ -117,19 +117,19 @@ static int sp8870_firmware_upload (struct sp8870_state* state, const struct firm
 		msg.flags = 0;
 		msg.buf = tx_buf;
 		msg.len = tx_len + 2;
-		if ((err = i2c_transfer (state->i2c, &msg, 1)) != 1) {
+		if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
 			printk("%s: firmware upload failed!\n", __func__);
-			printk ("%s: i2c error (err == %i)\n", __func__, err);
+			printk("%s: i2c error (err == %i)\n", __func__, err);
 			return err;
 		}
 		fw_pos += tx_len;
 	}
 
-	dprintk ("%s: done!\n", __func__);
+	dprintk("%s: done!\n", __func__);
 	return 0;
 };
 
-static void sp8870_microcontroller_stop (struct sp8870_state* state)
+static void sp8870_microcontroller_stop(struct sp8870_state* state)
 {
 	sp8870_writereg(state, 0x0F08, 0x000);
 	sp8870_writereg(state, 0x0F09, 0x000);
@@ -138,7 +138,7 @@ static void sp8870_microcontroller_stop (struct sp8870_state* state)
 	sp8870_writereg(state, 0x0F00, 0x000);
 }
 
-static void sp8870_microcontroller_start (struct sp8870_state* state)
+static void sp8870_microcontroller_start(struct sp8870_state* state)
 {
 	sp8870_writereg(state, 0x0F08, 0x000);
 	sp8870_writereg(state, 0x0F09, 0x000);
@@ -155,7 +155,7 @@ static int sp8870_read_data_valid_signal(struct sp8870_state* state)
 	return (sp8870_readreg(state, 0x0D02) > 0);
 }
 
-static int configure_reg0xc05 (struct dtv_frontend_properties *p, u16 *reg0xc05)
+static int configure_reg0xc05(struct dtv_frontend_properties *p, u16 *reg0xc05)
 {
 	int known_parameters = 1;
 
@@ -291,7 +291,7 @@ static int sp8870_set_frontend_parameters(struct dvb_frontend *fe)
 	return 0;
 }
 
-static int sp8870_init (struct dvb_frontend* fe)
+static int sp8870_init(struct dvb_frontend* fe)
 {
 	struct sp8870_state* state = fe->demodulator_priv;
 	const struct firmware *fw = NULL;
@@ -301,7 +301,7 @@ static int sp8870_init (struct dvb_frontend* fe)
 		return 0;
 	state->initialised = 1;
 
-	dprintk ("%s\n", __func__);
+	dprintk("%s\n", __func__);
 
 
 	/* request the firmware, this will block until someone uploads it */
@@ -350,11 +350,11 @@ static int sp8870_read_status(struct dvb_frontend *fe,
 
 	*fe_status = 0;
 
-	status = sp8870_readreg (state, 0x0200);
+	status = sp8870_readreg(state, 0x0200);
 	if (status < 0)
 		return -EIO;
 
-	signal = sp8870_readreg (state, 0x0303);
+	signal = sp8870_readreg(state, 0x0303);
 	if (signal < 0)
 		return -EIO;
 
@@ -368,7 +368,7 @@ static int sp8870_read_status(struct dvb_frontend *fe,
 	return 0;
 }
 
-static int sp8870_read_ber (struct dvb_frontend* fe, u32 * ber)
+static int sp8870_read_ber(struct dvb_frontend* fe, u32 * ber)
 {
 	struct sp8870_state* state = fe->demodulator_priv;
 	int ret;
@@ -403,13 +403,13 @@ static int sp8870_read_signal_strength(struct dvb_frontend* fe,  u16 * signal)
 
 	*signal = 0;
 
-	ret = sp8870_readreg (state, 0x306);
+	ret = sp8870_readreg(state, 0x306);
 	if (ret < 0)
 		return -EIO;
 
 	tmp = ret << 8;
 
-	ret = sp8870_readreg (state, 0x303);
+	ret = sp8870_readreg(state, 0x303);
 	if (ret < 0)
 		return -EIO;
 
@@ -421,7 +421,7 @@ static int sp8870_read_signal_strength(struct dvb_frontend* fe,  u16 * signal)
 	return 0;
 }
 
-static int sp8870_read_uncorrected_blocks (struct dvb_frontend* fe, u32* ublocks)
+static int sp8870_read_uncorrected_blocks(struct dvb_frontend* fe, u32* ublocks)
 {
 	struct sp8870_state* state = fe->demodulator_priv;
 	int ret;
-- 
2.40.1



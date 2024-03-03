Return-Path: <linux-kernel+bounces-89873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C76586F6C3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4CD1F20F12
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000677AE7C;
	Sun,  3 Mar 2024 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAwSjRjf"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1496D7A725;
	Sun,  3 Mar 2024 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709493664; cv=none; b=gBAf5ZUHZm9MoOjidNVAsQBqm/mF3fH7D+3WcjS2uRaBUi25bqHI1TJUD5Udyg2h7inJBhViFs4ftPNdoXufskQG+tiRFdAnCtlntnzWzzNnYXlq7c36Qu3bO2b0OW4u0QY2IZT4FGFpEqIDMThrQUZIibExJfD1lEg/YHGrAUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709493664; c=relaxed/simple;
	bh=+pDeDqWYQHPbRMFnvRN1azOZl2OlaoukQDC/kgYafw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t1kxnxeKCBDH38CtzVVPW0OER8sbFJ4XsusCo5/bXBxFhAhPgzLM5rXSTIw8kdFiEM82L1jCV410qgcwyzEPmiRbptWi796Co1kZI6r+Ga1AXJdTxVgzSXh5DWpvBq7aCYBx7HvwsI7gVvK0Dc6s1l6MGw3L/bu0zUQrfu9GsCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAwSjRjf; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d094bc2244so54199501fa.1;
        Sun, 03 Mar 2024 11:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709493660; x=1710098460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrOvp9WwUThyk7z9CwJba4kk8ujpOBp1PFvZQuMIxGQ=;
        b=NAwSjRjfi9txCTPaY72l84eGXKOEF+eKGW39nlk2HpPpCEdYyYhw/tHRSDw4QUZUoO
         bG/OuEmFKc/yBh+gtbb+11RyDVcHaPO3vNc280nw21DltTO33BAMn9fzWTD4WxMgXVVg
         RE2bCGD6oDeaudqeL+IanSP3rfclB7xhj23WsFBy+eUyHsXRhcBDgN/D05Cx+Rn7LKJl
         UK2OYeV8sArMqr09kU9WrbZrNtSdH39LvWXryrae7Ok7IfAo1uVdsHFPOAyKy/X4F43A
         7YukIgwckRK+boudyTtBFBadHl0SyseMm7HEldiBwkF3coIJ2rTedGNXR5Hzh7xcHa9u
         mzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709493660; x=1710098460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrOvp9WwUThyk7z9CwJba4kk8ujpOBp1PFvZQuMIxGQ=;
        b=DbA2k92KhhX+AdRhlxSSHHka7dOiSRWYI+ZxOUE7leH/2Iifxs5pqsSh/XrLwmT5qg
         5Ydy7UPMGqi4DTPuITJTz+qjhqahK6tQ1ezxSMM0wjKsPexVc1MpPngPkOJ6Q7r/UttO
         CWGm3GjiHhw3y/jiRKo3ZWgCtGVuJPxuRdUn3fCHKEzzfEKPVKwuaapwF7Mn+lHQ0nRV
         vKo+oOjw1Zemks0XrV35O6sN55+5LJLRrcizySB+U2hH1I8O+QK3LAUEB01kIarhFC3f
         dEolEPkrB534NVRusvYPs8HLiriPh2Ef8Y5JOsEQGj9uzN+XjDF5vYCOyf4z+TrDYLKv
         6Nbw==
X-Forwarded-Encrypted: i=1; AJvYcCW2RGnCQb98zXRI0z5RP4oWDuHQLqNlOHCXtJtB5Ia/NnwaeHSybsvp1a6pDqd2bH5DoADc0cO9DVrefLgq/1d6asMI/DNNOIh0kNK9ncwlDt7WjMm1o1LhDvxhl2BuGaoe2yAHKhvlycg=
X-Gm-Message-State: AOJu0Yx8RqMx1M8wma4ugmEQ5yRSsXrupQ8P3tF3/Hyu7tgTuibNS9hh
	YY87qQAvXGDDqwTgY5aWrJeAolgdCq+8ntsKMT70RUXZR8amtNn0
X-Google-Smtp-Source: AGHT+IGF9mbC5mPOBm2/SqbbaP7RNhqhC3ZmYgIGgjkAU2iMJDswrQDjFOPQblr5EODidg2vVntQ2Q==
X-Received: by 2002:a2e:88d6:0:b0:2d2:3e88:7c4f with SMTP id a22-20020a2e88d6000000b002d23e887c4fmr4853130ljk.43.1709493660194;
        Sun, 03 Mar 2024 11:21:00 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id y10-20020a2e9d4a000000b002d3c466adc7sm68438ljj.15.2024.03.03.11.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 11:20:59 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: mchehab@kernel.org
Cc: mcgrof@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 4/9] staging: media: av7110: Fix formatting of pointers to meet coding style guidelines
Date: Sun,  3 Mar 2024 20:20:35 +0100
Message-Id: <20240303192040.8116-5-bergh.jonathan@gmail.com>
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
 * Ensure "foo* bar" is formatted as "foo *bar" as per code style rules

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/av7110/sp8870.c | 60 +++++++++++++--------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/media/av7110/sp8870.c b/drivers/staging/media/av7110/sp8870.c
index 1f6c02744b6c..5857fc8b0962 100644
--- a/drivers/staging/media/av7110/sp8870.c
+++ b/drivers/staging/media/av7110/sp8870.c
@@ -28,9 +28,9 @@
 
 struct sp8870_state {
 
-	struct i2c_adapter* i2c;
+	struct i2c_adapter *i2c;
 
-	const struct sp8870_config* config;
+	const struct sp8870_config *config;
 
 	struct dvb_frontend frontend;
 
@@ -50,7 +50,7 @@ static int debug;
 /* starting point for firmware in file 'Sc_main.mc' */
 #define SP8870_FIRMWARE_OFFSET 0x0A
 
-static int sp8870_writereg(struct sp8870_state* state, u16 reg, u16 data)
+static int sp8870_writereg(struct sp8870_state *state, u16 reg, u16 data)
 {
 	u8 buf [] = { reg >> 8, reg & 0xff, data >> 8, data & 0xff };
 	struct i2c_msg msg = { .addr = state->config->demod_address, .flags = 0, .buf = buf, .len = 4 };
@@ -64,7 +64,7 @@ static int sp8870_writereg(struct sp8870_state* state, u16 reg, u16 data)
 	return 0;
 }
 
-static int sp8870_readreg(struct sp8870_state* state, u16 reg)
+static int sp8870_readreg(struct sp8870_state *state, u16 reg)
 {
 	int ret;
 	u8 b0 [] = { reg >> 8 , reg & 0xff };
@@ -82,7 +82,7 @@ static int sp8870_readreg(struct sp8870_state* state, u16 reg)
 	return (b1[0] << 8 | b1[1]);
 }
 
-static int sp8870_firmware_upload(struct sp8870_state* state, const struct firmware *fw)
+static int sp8870_firmware_upload(struct sp8870_state *state, const struct firmware *fw)
 {
 	struct i2c_msg msg;
 	const char *fw_buf = fw->data;
@@ -129,7 +129,7 @@ static int sp8870_firmware_upload(struct sp8870_state* state, const struct firmw
 	return 0;
 };
 
-static void sp8870_microcontroller_stop(struct sp8870_state* state)
+static void sp8870_microcontroller_stop(struct sp8870_state *state)
 {
 	sp8870_writereg(state, 0x0F08, 0x000);
 	sp8870_writereg(state, 0x0F09, 0x000);
@@ -138,7 +138,7 @@ static void sp8870_microcontroller_stop(struct sp8870_state* state)
 	sp8870_writereg(state, 0x0F00, 0x000);
 }
 
-static void sp8870_microcontroller_start(struct sp8870_state* state)
+static void sp8870_microcontroller_start(struct sp8870_state *state)
 {
 	sp8870_writereg(state, 0x0F08, 0x000);
 	sp8870_writereg(state, 0x0F09, 0x000);
@@ -150,7 +150,7 @@ static void sp8870_microcontroller_start(struct sp8870_state* state)
 	sp8870_readreg(state, 0x0D01);
 }
 
-static int sp8870_read_data_valid_signal(struct sp8870_state* state)
+static int sp8870_read_data_valid_signal(struct sp8870_state *state)
 {
 	return (sp8870_readreg(state, 0x0D02) > 0);
 }
@@ -226,7 +226,7 @@ static int configure_reg0xc05(struct dtv_frontend_properties *p, u16 *reg0xc05)
 	return 0;
 }
 
-static int sp8870_wake_up(struct sp8870_state* state)
+static int sp8870_wake_up(struct sp8870_state *state)
 {
 	// enable TS output and interface pins
 	return sp8870_writereg(state, 0xC18, 0x00D);
@@ -235,7 +235,7 @@ static int sp8870_wake_up(struct sp8870_state* state)
 static int sp8870_set_frontend_parameters(struct dvb_frontend *fe)
 {
 	struct dtv_frontend_properties *p = &fe->dtv_property_cache;
-	struct sp8870_state* state = fe->demodulator_priv;
+	struct sp8870_state *state = fe->demodulator_priv;
 	int  err;
 	u16 reg0xc05;
 
@@ -291,9 +291,9 @@ static int sp8870_set_frontend_parameters(struct dvb_frontend *fe)
 	return 0;
 }
 
-static int sp8870_init(struct dvb_frontend* fe)
+static int sp8870_init(struct dvb_frontend *fe)
 {
-	struct sp8870_state* state = fe->demodulator_priv;
+	struct sp8870_state *state = fe->demodulator_priv;
 	const struct firmware *fw = NULL;
 
 	sp8870_wake_up(state);
@@ -344,7 +344,7 @@ static int sp8870_init(struct dvb_frontend* fe)
 static int sp8870_read_status(struct dvb_frontend *fe,
 			      enum fe_status *fe_status)
 {
-	struct sp8870_state* state = fe->demodulator_priv;
+	struct sp8870_state *state = fe->demodulator_priv;
 	int status;
 	int signal;
 
@@ -368,9 +368,9 @@ static int sp8870_read_status(struct dvb_frontend *fe,
 	return 0;
 }
 
-static int sp8870_read_ber(struct dvb_frontend* fe, u32 * ber)
+static int sp8870_read_ber(struct dvb_frontend *fe, u32 *ber)
 {
-	struct sp8870_state* state = fe->demodulator_priv;
+	struct sp8870_state *state = fe->demodulator_priv;
 	int ret;
 	u32 tmp;
 
@@ -395,9 +395,9 @@ static int sp8870_read_ber(struct dvb_frontend* fe, u32 * ber)
 	return 0;
 }
 
-static int sp8870_read_signal_strength(struct dvb_frontend* fe,  u16 * signal)
+static int sp8870_read_signal_strength(struct dvb_frontend *fe,  u16 *signal)
 {
-	struct sp8870_state* state = fe->demodulator_priv;
+	struct sp8870_state *state = fe->demodulator_priv;
 	int ret;
 	u16 tmp;
 
@@ -421,9 +421,9 @@ static int sp8870_read_signal_strength(struct dvb_frontend* fe,  u16 * signal)
 	return 0;
 }
 
-static int sp8870_read_uncorrected_blocks(struct dvb_frontend* fe, u32* ublocks)
+static int sp8870_read_uncorrected_blocks(struct dvb_frontend *fe, u32 *ublocks)
 {
-	struct sp8870_state* state = fe->demodulator_priv;
+	struct sp8870_state *state = fe->demodulator_priv;
 	int ret;
 
 	*ublocks = 0;
@@ -453,7 +453,7 @@ static int switches;
 static int sp8870_set_frontend(struct dvb_frontend *fe)
 {
 	struct dtv_frontend_properties *p = &fe->dtv_property_cache;
-	struct sp8870_state* state = fe->demodulator_priv;
+	struct sp8870_state *state = fe->demodulator_priv;
 
 	/*
 	    The firmware of the sp8870 sometimes locks up after setting frontend parameters.
@@ -509,15 +509,15 @@ static int sp8870_set_frontend(struct dvb_frontend *fe)
 	return 0;
 }
 
-static int sp8870_sleep(struct dvb_frontend* fe)
+static int sp8870_sleep(struct dvb_frontend *fe)
 {
-	struct sp8870_state* state = fe->demodulator_priv;
+	struct sp8870_state *state = fe->demodulator_priv;
 
 	// tristate TS output and disable interface pins
 	return sp8870_writereg(state, 0xC18, 0x000);
 }
 
-static int sp8870_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings* fesettings)
+static int sp8870_get_tune_settings(struct dvb_frontend *fe, struct dvb_frontend_tune_settings *fesettings)
 {
 	fesettings->min_delay_ms = 350;
 	fesettings->step_size = 0;
@@ -525,9 +525,9 @@ static int sp8870_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend
 	return 0;
 }
 
-static int sp8870_i2c_gate_ctrl(struct dvb_frontend* fe, int enable)
+static int sp8870_i2c_gate_ctrl(struct dvb_frontend *fe, int enable)
 {
-	struct sp8870_state* state = fe->demodulator_priv;
+	struct sp8870_state *state = fe->demodulator_priv;
 
 	if (enable)
 		return sp8870_writereg(state, 0x206, 0x001);
@@ -535,18 +535,18 @@ static int sp8870_i2c_gate_ctrl(struct dvb_frontend* fe, int enable)
 		return sp8870_writereg(state, 0x206, 0x000);
 }
 
-static void sp8870_release(struct dvb_frontend* fe)
+static void sp8870_release(struct dvb_frontend *fe)
 {
-	struct sp8870_state* state = fe->demodulator_priv;
+	struct sp8870_state *state = fe->demodulator_priv;
 	kfree(state);
 }
 
 static const struct dvb_frontend_ops sp8870_ops;
 
-struct dvb_frontend* sp8870_attach(const struct sp8870_config* config,
-				   struct i2c_adapter* i2c)
+struct dvb_frontend *sp8870_attach(const struct sp8870_config *config,
+				   struct i2c_adapter *i2c)
 {
-	struct sp8870_state* state = NULL;
+	struct sp8870_state *state = NULL;
 
 	/* allocate memory for the internal state */
 	state = kzalloc(sizeof(struct sp8870_state), GFP_KERNEL);
-- 
2.40.1



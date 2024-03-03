Return-Path: <linux-kernel+bounces-89875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B26886F6C7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D3B1F210C6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1187BB0D;
	Sun,  3 Mar 2024 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="henVKb4W"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7045479DAE;
	Sun,  3 Mar 2024 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709493667; cv=none; b=tAgiEUJnMlvjIj+C4Ti1g8HpFrThvVM8yfvXILCDI2QOGdIQOCqrdaob+fVA6rG460Q1mMOCRjR6Wu8J4DujhNYk73Bpntfh/1OF6mpfgxHTTvNaTv5ufgTltsIH4khe0y5m96YI4ynw2ZaLxLrhIrAl1fgfi+W4S45ImA3/YNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709493667; c=relaxed/simple;
	bh=X0Khxf5YaXVdMDDwmG/XUxfZfA8wZ8bFlA2x/Ormcsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KbLdRL3hT5iQXsidgjRlBPzF1JFCs65JE+RG508Z4zp5uhtdWqEYaWJoc/03GzDpgJLncMuUfOMleWhtGpcN+hJodx8uX4EV7r7VnRwY5yvxry+QxLfWbNAWFaE2uEVsTHi1+AZCtnOYZ+slO2vz9BEY0QGqJXgS5exIV53ACLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=henVKb4W; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d220e39907so56273641fa.1;
        Sun, 03 Mar 2024 11:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709493664; x=1710098464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLhDnHzoGb7/T0BKuqDuN942/r+L3umotAQ2YW7CFP0=;
        b=henVKb4WqN1AupcCcZCPVQnB3IDRx2v3sryBbLPz7DJwAgBZmLyI47ew6RPC7u7AFY
         +5N6QsrsV8QDn+hoBSjp65fYYDFnkwz+5cJbLCRmXpqBG3imEw04lPc2vRlTGJ6sEqKE
         ptpRx4Kh6Hsz2JYfMsakvhq2hGIa923cccPm6UHjbk5spOLUlz9Ls2uKDB8fXjkzZVD/
         ybEmo6R6UoQz1+yv1qBYR2Zm//AAxUSX1JynMuzA64bmG7v/cVnUaiUD5LXu8g9hKSdY
         U+gi48uOyP4eJN5+wZQpxc8JvPGL2X9ieM2EBLcR91/pmX6PHL68JIhjpaSchLZd3owE
         zFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709493664; x=1710098464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLhDnHzoGb7/T0BKuqDuN942/r+L3umotAQ2YW7CFP0=;
        b=wRLkkGpV62I5zwatEnQ3Tflw0PbmTR3GK1XUcxkHz5fQpaXHPzm9vQrIDrPsVeRX4T
         ohuDEPbQqjqvz58E3V5Xy+s8gu2bB5WRFmZWPz9HDMw7Exx7zhBtQ1mR3EywiNWaUP2Q
         oIBkQec1XuD7GSec1+LhDqicCVbrqFtwAe+tTZQSE1g5yTiInPveOWfxYyAe8OidxPPZ
         KGwBnCUIwha0osjI6uulfhE8gtJmarsZTl4dzM9UhaanoHLEbdv5J2AeBBv68oBwvSyn
         2FuUxGCk70kwmczchR8KqfzvZTF3vq1sRrOyuLU3XdE+m3dpPmhj6GGnGKWvVwcUW9xM
         RW+A==
X-Forwarded-Encrypted: i=1; AJvYcCWkUluA5AGGoVjmIgSF8c3+79ADxZjxO4/o7ylfmdM8/P1bOVYUmNPmxLyQSQaGE4XYr1XbVHplrdbFNiA1q6lpNpKQwgU1w29Y6d9lpivTgFD4KANF359M2jCYkdSSAFDw/Tvf6VY4wmI=
X-Gm-Message-State: AOJu0YyQSqKIlSC0l+Uy4YNi3jmvxCpG2kOkNBh1rQbbFAiVodTf5D94
	Fd7mtCNWvW+ylnKqD9bVabVfl/p/PRRwYL6bVgYstEUm47kW/oJ8
X-Google-Smtp-Source: AGHT+IFBf0Wq4/vZycQOinhrIN/UFAicT5Yw1wgHBZJXk2ZLA4m6+2eQzssMdxkFqUu2ScAsvykm+g==
X-Received: by 2002:a2e:b0eb:0:b0:2d3:56df:ea4b with SMTP id h11-20020a2eb0eb000000b002d356dfea4bmr4129844ljl.41.1709493663618;
        Sun, 03 Mar 2024 11:21:03 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id y10-20020a2e9d4a000000b002d3c466adc7sm68438ljj.15.2024.03.03.11.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 11:21:03 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: mchehab@kernel.org
Cc: mcgrof@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 6/9] staging: media: av7110: Remove extra whitespace before opening '['s
Date: Sun,  3 Mar 2024 20:20:37 +0100
Message-Id: <20240303192040.8116-7-bergh.jonathan@gmail.com>
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

This patch makes the following change:
 * Removes extra whitespace before opening square brackets '['

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/av7110/sp8870.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/av7110/sp8870.c b/drivers/staging/media/av7110/sp8870.c
index 65795c5a01f9..a5a652c0b363 100644
--- a/drivers/staging/media/av7110/sp8870.c
+++ b/drivers/staging/media/av7110/sp8870.c
@@ -52,7 +52,7 @@ static int debug;
 
 static int sp8870_writereg(struct sp8870_state *state, u16 reg, u16 data)
 {
-	u8 buf [] = { reg >> 8, reg & 0xff, data >> 8, data & 0xff };
+	u8 buf[] = { reg >> 8, reg & 0xff, data >> 8, data & 0xff };
 	struct i2c_msg msg = { .addr = state->config->demod_address, .flags = 0, .buf = buf, .len = 4 };
 	int err;
 
@@ -67,9 +67,9 @@ static int sp8870_writereg(struct sp8870_state *state, u16 reg, u16 data)
 static int sp8870_readreg(struct sp8870_state *state, u16 reg)
 {
 	int ret;
-	u8 b0 [] = { reg >> 8 , reg & 0xff };
-	u8 b1 [] = { 0, 0 };
-	struct i2c_msg msg [] = { { .addr = state->config->demod_address, .flags = 0, .buf = b0, .len = 2 },
+	u8 b0[] = { reg >> 8 , reg & 0xff };
+	u8 b1[] = { 0, 0 };
+	struct i2c_msg msg[] = { { .addr = state->config->demod_address, .flags = 0, .buf = b0, .len = 2 },
 			   { .addr = state->config->demod_address, .flags = I2C_M_RD, .buf = b1, .len = 2 } };
 
 	ret = i2c_transfer(state->i2c, msg, 2);
-- 
2.40.1



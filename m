Return-Path: <linux-kernel+bounces-89870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E72686F6BD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A227D1C210F5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBD07A131;
	Sun,  3 Mar 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhRN/cHQ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F239679DB0;
	Sun,  3 Mar 2024 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709493658; cv=none; b=HQo5AU6dTVv4k0lUF8+swAwIsIVLirkzY3d901/UNAYqPT/+GiYvM9nupLxdFxOA4VIIuTYPaC9LSiXKRq8zURDErNtW/e6aoTHGWuQp/e90D9FPl/5Vp0bUSfIk5vaJvRmTNHmL96A3g/Fx7ryV2LPb7H7yh1iCuaRyNSB+ns8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709493658; c=relaxed/simple;
	bh=e3jkG39/MQTGX4+KXnyNp32ca12vDfkXIz0Uhjzrt4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hXiuX3mxHpAIr9T62dPCrHC5kNyDmUUUZq302WxHLxx9eXRlLifWasWl7LJAW/tm+fdz/EnpRFoJwdqYdQN78ZBiE05ehHmg2BjDD8EomJ/cRbiLcgDE7V189NA+fJvWDqlsX+baVZ17hia4Kxrs4X6osOLa7sRUq8nrqWSeXeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhRN/cHQ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d382a78c38so10937281fa.1;
        Sun, 03 Mar 2024 11:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709493655; x=1710098455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtWCQrC9j37ooCM7Gh68I6DWbQnrPcqv9tFDtfEFLtM=;
        b=MhRN/cHQgjItArs7bmAIxwbUIZNXigYC/AJ4HvzChLlW2hnooFp+yrdHarcgBtOv90
         pt26ysUULgUp8eyBB1e+03K+JOLMaZmREibKJAp7MQ605wshyIYNo71Wo/ZtlJI1o9fe
         yfXhwphu1aFIcPHbO9H9jL9wGQaw2IVv8DR+qLitf03bM9zNpexEBwQ3r0YLsrNujhxp
         +O+6sI6QcbrCvsrVCn04/2lT7q/m6cvKem5Jqp26q+7khOn9kSOM7plcd4RzLx4ZbmRF
         CdeVQV0OC3NMIOGJSdndDHIWDc0YfzmJRquI8LAc5+K5h8zfuJ07mE3OiJzaI5WFSz5g
         RR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709493655; x=1710098455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtWCQrC9j37ooCM7Gh68I6DWbQnrPcqv9tFDtfEFLtM=;
        b=ST7pKBcDLDwa8MU+4MySWucLPZ+vlF0IArWrR2Rc8uDRpRQVsyL4cUZConm07Elo2y
         HXHJLBzVbNaACCj1foOvhcluUchWHjgyku77psOpyD8+0RyA/xj/gxJf77B201o8PQ9P
         +y/z7WT1bLPhsjzTIHNw1GuWjCp56CAKQO5Vt4Hb3oXIk6flf1WW0EM09AyNBdai/zob
         yqA1tVEwxyZzx/fy9xIls7hpzh4WH9Zulu+/T2D6DD12QXynb1wwSwCPxGGpuy8vifZZ
         J5P78QF9DElF7jCzjKdys5aWy6iPzR228lO+M9vO5pSeryRxQSmMitgPh7tZ9MlFgCZy
         mn3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUm6kZGQFnPEI5jUGaBBVC+Bp9mBLAZ2ocHoZ+RUoD/A5AiBoSPCvMIxwbZRKHwhyqAm4JMC/XYDPSnHNh/ZFiqaUquQ/BkBXx1FwtWHza5eemiuOJ+r/oFjcrqwMMNrDWWF5VZa2kHW/0=
X-Gm-Message-State: AOJu0YybFJhWpNEshgCTLDhspNIgyrx8U6iU1k8w0SxOkIbzv7u7SQfH
	vChZMYuI7jucno2oMRSYjoFPOTX5+UBN76IzbgUSd8Joe8ZEaMJ5
X-Google-Smtp-Source: AGHT+IEUZlhp9TKb+6k0Am/Sy+zZ2uIxRoBnY61fu9pVrtqAb2D5S1+DDQO5q6cO14Jzpc8DVbZbHw==
X-Received: by 2002:a2e:7801:0:b0:2d2:ccb0:c6c7 with SMTP id t1-20020a2e7801000000b002d2ccb0c6c7mr4914035ljc.8.1709493654953;
        Sun, 03 Mar 2024 11:20:54 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id y10-20020a2e9d4a000000b002d3c466adc7sm68438ljj.15.2024.03.03.11.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 11:20:54 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: mchehab@kernel.org
Cc: mcgrof@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 1/9] staging: media: av7110: Fix formatting problem where trailing statements should be on a new line
Date: Sun,  3 Mar 2024 20:20:32 +0100
Message-Id: <20240303192040.8116-2-bergh.jonathan@gmail.com>
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
 * Ensures trailing statements are always on a new line as per kernel
   code style guidelines

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/av7110/sp8870.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/av7110/sp8870.c b/drivers/staging/media/av7110/sp8870.c
index abf5c72607b6..83685443976d 100644
--- a/drivers/staging/media/av7110/sp8870.c
+++ b/drivers/staging/media/av7110/sp8870.c
@@ -248,7 +248,8 @@ static int sp8870_set_frontend_parameters(struct dvb_frontend *fe)
 	// set tuner parameters
 	if (fe->ops.tuner_ops.set_params) {
 		fe->ops.tuner_ops.set_params(fe);
-		if (fe->ops.i2c_gate_ctrl) fe->ops.i2c_gate_ctrl(fe, 0);
+		if (fe->ops.i2c_gate_ctrl)
+			fe->ops.i2c_gate_ctrl(fe, 0);
 	}
 
 	// sample rate correction bit [23..17]
@@ -296,7 +297,8 @@ static int sp8870_init (struct dvb_frontend* fe)
 	const struct firmware *fw = NULL;
 
 	sp8870_wake_up(state);
-	if (state->initialised) return 0;
+	if (state->initialised)
+		return 0;
 	state->initialised = 1;
 
 	dprintk ("%s\n", __func__);
@@ -549,7 +551,8 @@ struct dvb_frontend* sp8870_attach(const struct sp8870_config* config,
 
 	/* allocate memory for the internal state */
 	state = kzalloc(sizeof(struct sp8870_state), GFP_KERNEL);
-	if (state == NULL) goto error;
+	if (state == NULL)
+		goto error;
 
 	/* setup the state */
 	state->config = config;
@@ -557,7 +560,8 @@ struct dvb_frontend* sp8870_attach(const struct sp8870_config* config,
 	state->initialised = 0;
 
 	/* check if the demod is there */
-	if (sp8870_readreg(state, 0x0200) < 0) goto error;
+	if (sp8870_readreg(state, 0x0200) < 0)
+		goto error;
 
 	/* create dvb_frontend */
 	memcpy(&state->frontend.ops, &sp8870_ops, sizeof(struct dvb_frontend_ops));
-- 
2.40.1



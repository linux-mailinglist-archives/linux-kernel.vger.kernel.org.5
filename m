Return-Path: <linux-kernel+bounces-89876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588DE86F6C9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B8928127C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9182879DBC;
	Sun,  3 Mar 2024 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpMQKHrW"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D68D7BAEE;
	Sun,  3 Mar 2024 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709493668; cv=none; b=uOi9Bt/mjKyDkejS46H3ew2XH6aLhkmpkj24ESBr6c6J0p8/bC1VRvRCg17i3ZV4HsWXHG+IQMiuB78Vsd+NN+ykl85yzGywYL/d552u/+im+JQ3WgyOomjziPe9sIkjzTmyH2pTDA3OgIAGo64dThe+pT3dubOkF2zUGSuvM0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709493668; c=relaxed/simple;
	bh=zDiok/ntB/JOcjhEI7yW0JyPvlcBaaiS3RcM2NlU7p4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ox9qBYI+HxtN2JpKdRBz4oiqHsRUsALKn6YqxE7JUnV1cE6MztG3fvEkpVYzwsUY8n4dNsc/uiWZOQhmyoa9aodoQnJMrGYEvxr1Za/qXgRyefTTeH4YUWKXyJqdDSqIiA2tobMif0e0MYJokGziVszgghFma2OKNfMg3nbRGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpMQKHrW; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d29111272eso58721531fa.0;
        Sun, 03 Mar 2024 11:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709493665; x=1710098465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRnBtGKy4pYvIH9MCoR04B6/MZ+fpULUo8TNXf7ZwKo=;
        b=BpMQKHrWOc0bC7fyz3feZ9uiPw+GD6hzGUZYlyGwhsc/IqBkeVb1DeWX7kWcW3uIvu
         0tXZISE26x47CbuaSnsPpp98pGyM+vnlBWrVc6sWcCyDzFkZLFDY3YcoTlEYVoM7jqBn
         r6kcKWJV2DW88C7e1TawOqjm2VHxpE7r6NZR5LSAKjC1LSsqGbTUwX5Ih6BQcLwyOlVW
         u0DIGuSqKjFL+1HqTPRCtWyGcQwXdi7SsZ6zJRfYmLhZXAjGLofAFLgjeYYrlrWCQsoQ
         hr3/v+EvQMelDyaUSKjzx/wUK9U9QyvLORldFNP+OLhajhypo/pdsh4xTfLIM/XhfMS/
         jMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709493665; x=1710098465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRnBtGKy4pYvIH9MCoR04B6/MZ+fpULUo8TNXf7ZwKo=;
        b=HGL/uRWEZx3dvf7ife1kAtkwOovPY9rCN0W4/gvqBb42i1pwAXkZ5r8Ld+604Hlbrj
         fNP1ZlgG33Y+M/wuBdB+22eRffwKuUOoE58YYrMhOFVQFS7vLLaRCnVBqqQjO24gFBfu
         AyYD9ateFP5XCSVX/VnIaF6pUUPWz4hz+txrzyQDh+ggvcsqzFMnxQdQbBgHXPwpuhVp
         3OHVIz2RiBGHICwMSxUC/RtZCMZ/pLMj9YFUDddz5xWhjqt/pi5MNda6E/eeyVICtDSk
         8oP417DJUZhJdZLF4qgMy0aSfLLR/J1MmrOBP/sshvocmwt0RtqOi3oIQddlE3g6S7el
         WnSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKtUHlQSxSpg+I9CAtACQ7b1m+GI9wLdv6Sr7bajDsXbNZcfe1KND5sp9HOJ5IiRuqwktQ8Y9x0BDzUEwJsKMcvRtPEWhAsH4PP8b7CQGgf7qPuOrJMbIPDJvRAvW8iVmZiyRgKO7g+nY=
X-Gm-Message-State: AOJu0YyWqS+b2uRAhd6FZF06zTxjEDVeG5+vLYEHJnLsq5onZQyXzldS
	mNK6D3eWiW9+BZagXAB7hHu14Q+LPItxl/AcL4qbKH8GzkXULel8
X-Google-Smtp-Source: AGHT+IGotyxZDKaHw9Su+5u5K69zrdBaB+cftkhkl91JEmoQdP9wxH+33rEZTClqQ3TZdmOCOIcAxg==
X-Received: by 2002:a05:651c:1043:b0:2d2:a440:d704 with SMTP id x3-20020a05651c104300b002d2a440d704mr4921495ljm.24.1709493665209;
        Sun, 03 Mar 2024 11:21:05 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id y10-20020a2e9d4a000000b002d3c466adc7sm68438ljj.15.2024.03.03.11.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 11:21:04 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: mchehab@kernel.org
Cc: mcgrof@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 7/9] staging: media: av7110: Remove extra whitespace before ','
Date: Sun,  3 Mar 2024 20:20:38 +0100
Message-Id: <20240303192040.8116-8-bergh.jonathan@gmail.com>
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

This patch fixes the following code style issue:
 * Removes extra whitespace before comma ',' in parameter list

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/av7110/sp8870.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/av7110/sp8870.c b/drivers/staging/media/av7110/sp8870.c
index a5a652c0b363..8afddf61e52b 100644
--- a/drivers/staging/media/av7110/sp8870.c
+++ b/drivers/staging/media/av7110/sp8870.c
@@ -67,7 +67,7 @@ static int sp8870_writereg(struct sp8870_state *state, u16 reg, u16 data)
 static int sp8870_readreg(struct sp8870_state *state, u16 reg)
 {
 	int ret;
-	u8 b0[] = { reg >> 8 , reg & 0xff };
+	u8 b0[] = { reg >> 8, reg & 0xff };
 	u8 b1[] = { 0, 0 };
 	struct i2c_msg msg[] = { { .addr = state->config->demod_address, .flags = 0, .buf = b0, .len = 2 },
 			   { .addr = state->config->demod_address, .flags = I2C_M_RD, .buf = b1, .len = 2 } };
-- 
2.40.1



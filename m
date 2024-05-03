Return-Path: <linux-kernel+bounces-168215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CE98BB53E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340331C2239D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7539E54277;
	Fri,  3 May 2024 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUotV8Of"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9042EB1D;
	Fri,  3 May 2024 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770664; cv=none; b=pwC8v3+EZz9YUjqdlANi8snedAAXbT2g+klQDCXc6juOiVaM0vyzQDRgsFr85egcQe92TYDnT9q4p/Z8IVEZAPXjATLNjaZjdeqTsr/xSDJFTIlv6GMs/JKW/DNBrYEVyFPBqGHfiV//bEifOtbKJBkTpO2jyTnhBVGzYe++m7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770664; c=relaxed/simple;
	bh=fT8B95NRJxqic4ZvNvr5JKZtgUDAm//fNrBmj/4//Lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ov1D74aLAtspvfSff/EZUEVElZsfgb4ua56/9Fb1BLYniwbSaQ6+XmskttfE+RoAEgLIGnggUG9W8+1GHxsCfGIflKLgtMhoGV4dpQypqF8Yc6SQ8mMDBLmsW2erC54kVR2aHh6T1UAVOf+C09YhnH1Q+abc5LHsLkou0oX7Pu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUotV8Of; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a17fcc6bso10832766b.1;
        Fri, 03 May 2024 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714770661; x=1715375461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXa9fPa1AxHYExyv0RgoVDFXes46QUKMk33/XZTly4I=;
        b=KUotV8OfQTg0C/eTfcvIQ9gQnvudHYGJmMB2ZFCmgxAuiTaO1txs3D32d5153Apj9+
         9VHSneigfp8IoetZMOuq8tp4MlqVqqacoh/LZrtF6DkBCSqQSk2/droSUy0NJYzc1icG
         2iIroconWnvTGzM4VSGpKue4nbA6y+CPaZ20LWE/b2A3E77MxQqDpYEDvBp98nusHywk
         /TfgfuDpb/HBrDYtOuIjpd81zcyzFU8FzxdI3JB5WPNtO2V8u9JfpeldT8PslngZIZhE
         yldpFV0F6lnZnnXgfzZcDr9BLdir0K5BM0E2ZMUwNdByU1JbX7cOaAtyCsrsJ0BlL0qk
         TKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714770661; x=1715375461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXa9fPa1AxHYExyv0RgoVDFXes46QUKMk33/XZTly4I=;
        b=lIgUgdKJ4PJa82+AFXGLSe2VznTUPlDyJ2AZ2h2+Yusv+eOFzBggB1DFaWgBur6l27
         Vhsu41/f/ySXsMIuzsI/0lQ5+dYlDB34i3Tn3Bc06+eWCn6WZ4foeLE5AP95w1Sm0A1E
         58M+Fo5uNktrHYMxZxwDGYVXipG4QuiLtvOkpe6Bg5MkGebOanbz9JE348p9TgIvjNE3
         2iNqVBj5J+xVLvnMPZiKyxMWayI8ipOzVi6J/JYgO0NQOe6JHEDEPnTwnhdTlHOHdVo7
         AhWlW+ra/gQj0rDe3PB7PzV2qsCAEk2HV4wFruFc8O93H4KmufycINrWtMkItdyWwH8W
         JEsA==
X-Forwarded-Encrypted: i=1; AJvYcCVj26yWpQ6SkxMtmAH0CTw+doPZ9J3J5Y6IdpRqWILHU/aFX2mqKA+zoGXU+Z6X7HDIYQ0bSVsJPLq0xouyZ3vn6DpAtiHWKhbeXAz2fXPcdGm6iOuzah9sRK1WJZc6D/NHbw7vZylyjRIF
X-Gm-Message-State: AOJu0YzNrcz4i++vs4im5da1xtRgZgHfIIYX5Y0ZPo1U/5kBDuO8HNwR
	5NcQQHR6KGq16nJ/7zEuJzzrWgH8GGykpBEcaK45XdyPHd8gWIE1
X-Google-Smtp-Source: AGHT+IE7qqgvE0fP2T/+O+VL8NFjFrS9LATJ6wFJOuDSRRWMoIk8xtI2DU7KT+zaZLoloRufqZBusg==
X-Received: by 2002:a17:907:1109:b0:a59:9f3e:b1ca with SMTP id qu9-20020a170907110900b00a599f3eb1camr953896ejb.55.1714770660765;
        Fri, 03 May 2024 14:11:00 -0700 (PDT)
Received: from 58b9ec80ce2f.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id jy9-20020a170907762900b00a598646f173sm1475948ejc.191.2024.05.03.14.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:11:00 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	l.rubusch@gmail.com
Subject: [PATCH v2 2/4] crypto: atmel-i2c - rename read function
Date: Fri,  3 May 2024 21:10:52 +0000
Message-Id: <20240503211054.1231-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240503211054.1231-1-l.rubusch@gmail.com>
References: <20240503211054.1231-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the memory read function name more specific to the read memory zone.
The Atmel SHA204 chips provide config, otp and data zone. The implemented
read function in fact only reads some fields in zone config. The function
renaming allows for a uniform naming scheme when reading from other memory
zones.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/crypto/atmel-i2c.c | 6 +++---
 drivers/crypto/atmel-i2c.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/atmel-i2c.c b/drivers/crypto/atmel-i2c.c
index 83a9093ef..a0d0d4f2a 100644
--- a/drivers/crypto/atmel-i2c.c
+++ b/drivers/crypto/atmel-i2c.c
@@ -51,7 +51,7 @@ static void atmel_i2c_checksum(struct atmel_i2c_cmd *cmd)
 	*__crc16 = cpu_to_le16(bitrev16(crc16(0, data, len)));
 }
 
-void atmel_i2c_init_read_cmd(struct atmel_i2c_cmd *cmd)
+void atmel_i2c_init_read_config_cmd(struct atmel_i2c_cmd *cmd)
 {
 	cmd->word_addr = COMMAND;
 	cmd->opcode = OPCODE_READ;
@@ -68,7 +68,7 @@ void atmel_i2c_init_read_cmd(struct atmel_i2c_cmd *cmd)
 	cmd->msecs = MAX_EXEC_TIME_READ;
 	cmd->rxsize = READ_RSP_SIZE;
 }
-EXPORT_SYMBOL(atmel_i2c_init_read_cmd);
+EXPORT_SYMBOL(atmel_i2c_init_read_config_cmd);
 
 void atmel_i2c_init_random_cmd(struct atmel_i2c_cmd *cmd)
 {
@@ -301,7 +301,7 @@ static int device_sanity_check(struct i2c_client *client)
 	if (!cmd)
 		return -ENOMEM;
 
-	atmel_i2c_init_read_cmd(cmd);
+	atmel_i2c_init_read_config_cmd(cmd);
 
 	ret = atmel_i2c_send_receive(client, cmd);
 	if (ret)
diff --git a/drivers/crypto/atmel-i2c.h b/drivers/crypto/atmel-i2c.h
index a442b47a4..275297a82 100644
--- a/drivers/crypto/atmel-i2c.h
+++ b/drivers/crypto/atmel-i2c.h
@@ -178,7 +178,7 @@ void atmel_i2c_flush_queue(void);
 
 int atmel_i2c_send_receive(struct i2c_client *client, struct atmel_i2c_cmd *cmd);
 
-void atmel_i2c_init_read_cmd(struct atmel_i2c_cmd *cmd);
+void atmel_i2c_init_read_config_cmd(struct atmel_i2c_cmd *cmd);
 void atmel_i2c_init_random_cmd(struct atmel_i2c_cmd *cmd);
 void atmel_i2c_init_genkey_cmd(struct atmel_i2c_cmd *cmd, u16 keyid);
 int atmel_i2c_init_ecdh_cmd(struct atmel_i2c_cmd *cmd,
-- 
2.25.1



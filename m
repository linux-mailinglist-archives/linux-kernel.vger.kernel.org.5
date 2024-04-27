Return-Path: <linux-kernel+bounces-160813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61BC8B4326
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91798283F74
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827B8364AE;
	Sat, 27 Apr 2024 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHr9c1uO"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB7C2209B;
	Sat, 27 Apr 2024 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176891; cv=none; b=BMlhYqGQvuGwfqBN9e+JGbJwZwHb3SGMR1K9Xu4FuXY15XqV4IamBoYzQenf4plnCkMwVEycXZBEtuybqq7ifBumxiizOGS4h1EZ6dg5gVFK7VcgOx1V9yJJi2MhkpTfT83uERznzuwfoeOZfVyEjVzPWbazTfwR6ntuRJErdk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176891; c=relaxed/simple;
	bh=JdzNbIvVqD/QrFrLzFnmNm9W8IVuhY0tE9Bmz1oYMNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YK2CrzXDoQyH+jn3sPDyZAGxpvHc8nC8v/9sobCiGqOf0dFbQg5C2Bi1s0j4s8Qj4unM/1lQGpjDsbssn7Vz4KizmSXXg4RWU9ra0Z1Ngsdp/G7KH58VcMQX1/GltHrhtJPtKUFVEGXyBxM1A99z483s995s0rd6Nt/Crk08lFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHr9c1uO; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34665dd7744so1934461f8f.1;
        Fri, 26 Apr 2024 17:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714176888; x=1714781688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSzv/RCJzppzAC4C+b83eofnfT5GR7S5SL9rHV9w/O8=;
        b=RHr9c1uOr6lv8bC8gUUPTvV/17kTt0++mP5s4Vm3XQLpEGgt5JFsZ4ehMK/0cWl8yz
         27auZZmHHH9arCYflrGo5L4YLXuMGlvNqM07G2drW88IU3XvSOhVygOJo1Y/eTAnoSoA
         ahL+Y14EPiR5Ue2ILf7R4derw7iIHryq1FlmZUE0RgtDGj9yk04/GO2d2TCqIoKxLl6e
         LUT9UJxSHibzldcFBfyuaSHp9W0hU9bueX1keFgVUTFE/fmYY8cDT8eYHyePQ2xTRqZT
         dZeW9Jq02ALlTHWUx2Ik+VQPudd0DK5COrfFQCtYh+k4vl6X5S736aBxB3dSLkyQtb1N
         zesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714176888; x=1714781688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSzv/RCJzppzAC4C+b83eofnfT5GR7S5SL9rHV9w/O8=;
        b=Yi8KkCG/ZYEUP/PNqyXmNPiOWk/OpcWjP7vz83iGUAqxWugwTMSJz2hGnkd0OuPjzy
         jjXmlV+Cvafa42sL6dAnTG1wuj4K4cwaI+JZ6081IVpneaIzag6D4HS0LwB7uhK24smF
         nS2EATcb3fezQRVU+/ZvMBtXnN1oWIjO4hTDm2tAQeaZvU5k3rMlHZnwuUuigTqmRtDj
         9MOQ6lJtLzy+sO1vitZY4EcnBRvzlVHTy00Jazz5HafdF9ryf0RZwn4o5mnl4G56KLxv
         GlHjZONDUZYmWLxaHZ91i102Pj5ISStRcTAcS5VmwptpkrujyhKi9uYXCYgRV4NFTDIG
         LUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPdGkhG/x6V+y/CgRPLKP8hkCqTHp/FfifCiHZBn7Kjq51zZ6HNtlAHRKp5Pd55EQfpWe5LttHhEcLwlCB0BHRBkc7/9lzl2fTwI67ClbMn6yFJhSUBRlYMbEWrKEIvvW99jR312goQZCq
X-Gm-Message-State: AOJu0YxL/fYo2mrm+FcBPBSzIVWlxfE+pBWQng6YmH1sIeppOgs9Kjmi
	wEgl21MBIUX3iKrOJK8CbVGcRR9oEHOVY0l8J/W/tyafhiRtbkFK
X-Google-Smtp-Source: AGHT+IEKIj9pmQpXucrDUMYp8RecMPEtyhDpIpgqsoHkis1PjldSBsCQNKMv1RrV73/RMo+znB9Xyw==
X-Received: by 2002:a05:6000:c85:b0:346:a7:4acb with SMTP id dp5-20020a0560000c8500b0034600a74acbmr2729552wrb.62.1714176888692;
        Fri, 26 Apr 2024 17:14:48 -0700 (PDT)
Received: from 2116bb4b8996.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d65c7000000b00349eb6eae3esm23748079wrw.4.2024.04.26.17.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 17:14:48 -0700 (PDT)
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
Subject: [PATCH 5/5] crypto: atmel-sha204a - provide the otp content
Date: Sat, 27 Apr 2024 00:14:39 +0000
Message-Id: <20240427001439.12726-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240427001439.12726-1-l.rubusch@gmail.com>
References: <20240427001439.12726-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set up sysfs for the Atmel SHA204a. Provide the content of the otp zone as
an attribute field on the sysfs entry. Thereby make sure that if the chip
is locked, not connected or trouble with the i2c bus, the sysfs device is
not set up. This is mostly already handled in atmel-i2c.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/crypto/atmel-sha204a.c | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 81b5ea722..4a2027a60 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -105,6 +105,39 @@ static int atmel_sha204a_otp_read(struct i2c_client *client, u16 addr, u8 *otp)
 	return ret;
 }
 
+static ssize_t otp_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	u16 addr;
+	u8 otp[OTP_ZONE_SIZE];
+	char *str = buf;
+	struct i2c_client *client = to_i2c_client(dev);
+	int i;
+
+	for (addr = 0; addr < OTP_ZONE_SIZE/4; addr++) {
+		if (atmel_sha204a_otp_read(client, addr, otp + addr * 4) < 0) {
+			dev_err(dev, "failed to read otp zone\n");
+			break;
+		}
+	}
+
+	for (i = 0; i < addr*2; i++)
+		str += sprintf(str, "%02X", otp[i]);
+	str += sprintf(str, "\n");
+	return str - buf;
+}
+static DEVICE_ATTR_RO(otp);
+
+static struct attribute *atmel_sha204a_attrs[] = {
+	&dev_attr_otp.attr,
+	NULL
+};
+
+static const struct attribute_group atmel_sha204a_groups = {
+	.name = "atsha204a",
+	.attrs = atmel_sha204a_attrs,
+};
+
 static int atmel_sha204a_probe(struct i2c_client *client)
 {
 	struct atmel_i2c_client_priv *i2c_priv;
@@ -125,6 +158,16 @@ static int atmel_sha204a_probe(struct i2c_client *client)
 	if (ret)
 		dev_warn(&client->dev, "failed to register RNG (%d)\n", ret);
 
+	/* otp read out */
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	ret = sysfs_create_group(&client->dev.kobj, &atmel_sha204a_groups);
+	if (ret) {
+		dev_err(&client->dev, "failed to register sysfs entry\n");
+		return ret;
+	}
+
 	return ret;
 }
 
@@ -137,6 +180,8 @@ static void atmel_sha204a_remove(struct i2c_client *client)
 		return;
 	}
 
+	sysfs_remove_group(&client->dev.kobj, &atmel_sha204a_groups);
+
 	kfree((void *)i2c_priv->hwrng.priv);
 }
 
-- 
2.39.2



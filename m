Return-Path: <linux-kernel+bounces-168217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32958BB543
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590052853B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117545A7A0;
	Fri,  3 May 2024 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHTYllCk"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FA84CDE0;
	Fri,  3 May 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770666; cv=none; b=loHxHegscyesY+Eq1CJwDAeVgLAN2HbY4XCQEET/uH0ePLuZdaa5jqQgo8xklIoqmcY2LffgombhvAq283uvyTLytcMaUM5K+FA6LPrV4V0a0TOPW53ZENyox4ZOZe+HpLP0DyTPu7q6IOiCjBZ9cZix42woZdRCQVFSDerlQEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770666; c=relaxed/simple;
	bh=/ytmHdvFHRgBzTtgyEnBN+dR5abXDd4ZX2hL9w20UK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m36kJPVRx6vh/GnZ7j14A4OAtNi+kz+EbGcGzbmc4eysR3lTtBdbzp1EOiL3GAccM7523NEW1s6/NQVCUnBRvcXp+yymVi1qrtRHCWWoJ898WPjEhkG03cFpUN17V+VuO6KgJ77i4N00DcQNcZAl1fs5y9jSDWuCdM1HlCxECsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHTYllCk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a599c55055dso11897766b.0;
        Fri, 03 May 2024 14:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714770663; x=1715375463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9qQDpvAvfKRu8qLDslBuxd5B2UXk46RBnF6wvfi1D4=;
        b=NHTYllCkiQGDQNnk6P6mdGNZxjCGeKfucavWm2kRj5f+GRKfbge3SfXS0H1d6iPkkd
         QBY4aD2qTjBy03ioPFXT+LzARfmKnchVltQ9WKD6Ne0HB3UydtkFJtKB2RiPFQOkcaLn
         eX+/fqnhzrBgtLrbajQmcr5J0Wu10rJmLZVrVK8HA5upMh+elgpFcPCAe7vVq33ESlOk
         QG8B6ZiWhfCoXx8bGCaNTH7vDT7yWWq67hr3fUDSqs2bx74J2JtADE7ng1A93NaFEm1R
         gIRTZqWteuEPNy4u8oj/+lc9Z0a2vI1CuOUnsIQm9ZvhKllL3Z0+YCwPPspaHaRagSNK
         K5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714770663; x=1715375463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9qQDpvAvfKRu8qLDslBuxd5B2UXk46RBnF6wvfi1D4=;
        b=i97raZsoTbAJAN7yoZZRoanJFvGziTsbWyaIVDyg3xms01DN0J4+dQMUL9jcHtSrtk
         VeSg/1PKHHPEQo9mq+f7H+d3/cva5/3ROkCf6Q/gnR1H4RsDTYF7jRb3VQmOCvk489E+
         iV12aH5akhp7A0UHN83f7vLPN2M9weRoE6syPBKUQ4RFJjAUrYDF6LcZFLFom6cFGrpV
         ob8X4WWKQVH97xrLX942R1EXnRw61+Bek6gvVBTa5HYF1VAnLAqIztCfTAkFQMA8cL08
         bSg3NcR9nhrt7/2ic9dwBc9JqtvcMQCbZNXo9NbCXXY9MCs2SFa5yiaZvB6DIIEotI5H
         AtpA==
X-Forwarded-Encrypted: i=1; AJvYcCW1adTYw3QpbMamI0QQkZSLn6zjf6pC9eKZGrSZv/JxoW1dG4XykfJt4QKvsFDzC4t1RjkNpMJnVBnIOhD1yNrS2N/OhlQGUjvGxDu5ga/S3ho0cDGOb1kxb7qwONAyGVl6ecuZKVzL1s7U
X-Gm-Message-State: AOJu0YwfFz0vsB4FuXGBO1UD7BvIzx9KnjC/nDz6+898GIasSEnHkqcO
	7+nuOaqfAMxkP4cNR2hpxewtmxwteuEvLqH/MCVi7DFA/Hoe6pGRYUgk42JA
X-Google-Smtp-Source: AGHT+IGQBHowAMt1VfarNtWX6H7l9qKYH+O1pO94CXBV/3quyL6tynl7ApxlTtNnPHq53oTyMFLy3w==
X-Received: by 2002:a17:907:1b06:b0:a59:9a68:7283 with SMTP id mp6-20020a1709071b0600b00a599a687283mr1869686ejc.12.1714770663111;
        Fri, 03 May 2024 14:11:03 -0700 (PDT)
Received: from 58b9ec80ce2f.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id jy9-20020a170907762900b00a598646f173sm1475948ejc.191.2024.05.03.14.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:11:02 -0700 (PDT)
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
Subject: [PATCH v2 4/4] crypto: atmel-sha204a - provide the otp content
Date: Fri,  3 May 2024 21:10:54 +0000
Message-Id: <20240503211054.1231-5-l.rubusch@gmail.com>
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

Set up sysfs for the Atmel SHA204a. Provide the content of the otp zone as
an attribute field on the sysfs entry. Thereby make sure that if the chip
is locked, not connected or trouble with the i2c bus, the sysfs device is
not set up. This is mostly already handled in atmel-i2c.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/crypto/atmel-sha204a.c | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 563a0493b..24ffdf505 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -114,6 +114,39 @@ static int atmel_sha204a_otp_read(struct i2c_client *client, u16 addr, u8 *otp)
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
@@ -134,6 +167,16 @@ static int atmel_sha204a_probe(struct i2c_client *client)
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
 
@@ -146,6 +189,8 @@ static void atmel_sha204a_remove(struct i2c_client *client)
 		return;
 	}
 
+	sysfs_remove_group(&client->dev.kobj, &atmel_sha204a_groups);
+
 	kfree((void *)i2c_priv->hwrng.priv);
 }
 
-- 
2.25.1



Return-Path: <linux-kernel+bounces-168216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324238BB540
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1521F2347F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3881258ABC;
	Fri,  3 May 2024 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flKj0Dom"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C257841C92;
	Fri,  3 May 2024 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770665; cv=none; b=LxrOaYp8hpZQjTuFZ8IvQjRc8+nc2GLtcn7LSbnYRaIOLhRPvHTZ6hqMHXyQ+8U8IKoFlNG5DmL6rU+Lvxqa0RxIl9DEMrrudMCiUguwIMNbA8IwQZNuHYSZIt2b+U+ptx/cgYyCmyDZmjfOWBPH6YctDSW7QVXOD5vzOvUJJec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770665; c=relaxed/simple;
	bh=EM2kQIWp7A2DBI7dldPxTG7tiHmQrcc+lqxRDW/TXW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ECFXBkhLFimfQZFCWh0pceA8tw7K9egzNLcFm6cLK1+13SOYYYPO4qhaQtlj8vhOPOFgH0Kr/k+amlofyrviilsJHnXqAfoTi+DgnPOH79yCDNbhYaMX3zt/SiEp5yScyPKcdtNQ9ckq2uesvMI6Rzi8MEpdNU17z7bH2NEIxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flKj0Dom; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f60817e34so81499e87.2;
        Fri, 03 May 2024 14:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714770662; x=1715375462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL9kJ3wI1BHKgVHcnOLEHEX6FzjxHvxmkut4qqZfeuQ=;
        b=flKj0DomZiOmQ2Ni3svUK+Ou8qX8zATnNEq0xivnWquOLkyOLAWYyRWzUH8XztAVIR
         IAPtwfuGiAYvfLLMHUx9uqdRYTwRj5eX7Pq4wCWuXSW3elW9X3oLmJTPO+hf5tCQSuvt
         DGDgRvVWsXLelslqXaRyX9U2xjAZCUkpiOjvFy+DW9uf5yDlZtJt8W2B0MM7nmEpVS1e
         ny3ItwMyDNCcvpMmlftOJUOzCNeTNCH7fth2aCi01mWSv6FklRVjJTKwHAJ4qMOXFEdU
         CRSuV+QGadipq/HrBPmjfiI7UDlM9PPBb207RVWmfxUlmu1HN5rySPKHYeV1wuHaTNQD
         WC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714770662; x=1715375462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL9kJ3wI1BHKgVHcnOLEHEX6FzjxHvxmkut4qqZfeuQ=;
        b=YMANR/B7uPKNxF9gSNDcROjXv/c8XQew2ekM6qvNnUhgy8VcF66hrKc1SArMLNNwgv
         2sPL7H+Y7dVUKKS8RFJ6t0uKf9kALnsJbKCeAeNaRcKgAgXjLukMkx69SoxxzGKz6vD0
         d8rcxgh8GR5DXnx7zOR8ph6T7gW5cj9VgQjERrplZBFj4lKMPNl8HpARSguWOY12iqH4
         tkjAzsz+VzZGygfzf7gV9LTFJGrrQC9ynFYfxOuZAdF38pHYG/+ZH0KSiRQ2WT1/B4Be
         0zIqHHcTNlsfiqM7EOvovqSTpF9v/6DRPHDqwk/dP/B9od0Oo7ucCu69hizhZBkVg7bN
         sjLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8EThZtPS5qqB+TabSBtQRRvHyA22H1fBHBRhnI2w5hdOCqocrZlUVHYG/Q7wXiP1n6F7fEILxDQ90Zp6mT2KUznwedd899nWhgyWzEmgQZe4QqZ2NuKcRnOkknNvPW7yMfyfXf4oLPMT+
X-Gm-Message-State: AOJu0YxOsdWGDIXcX1FAfYhi/6T9eQ9neAFdBkv5pPv7cCOFvzDWUNyP
	5jKRBH07r4XDfHv/R1+aAZiEoWaARC51R7rNHTpuqr8ZVoldaTqa
X-Google-Smtp-Source: AGHT+IGu3BjGOP7NuDBPEDOHCG5GXD+7VSwqemrg8eHk9tYcT2FHfx4XMsLrtjU+TYEpyjHmwNoEkw==
X-Received: by 2002:a05:6512:2205:b0:51f:2709:3641 with SMTP id h5-20020a056512220500b0051f27093641mr2984635lfu.26.1714770662041;
        Fri, 03 May 2024 14:11:02 -0700 (PDT)
Received: from 58b9ec80ce2f.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id jy9-20020a170907762900b00a598646f173sm1475948ejc.191.2024.05.03.14.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:11:01 -0700 (PDT)
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
Subject: [PATCH v2 3/4] crypto: atmel-sha204a - add reading from otp zone
Date: Fri,  3 May 2024 21:10:53 +0000
Message-Id: <20240503211054.1231-4-l.rubusch@gmail.com>
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

Provide a read function reading the otp zone. The otp zone can be used for
storing serial numbers. The otp zone, as also data zone, are only
accessible if the chip was locked before. Locking the chip is a post
production customization and has to be done manually i.e. not by this
driver. Without this step the chip is pretty much not usable, where
putting or not putting data into the otp zone is optional.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/crypto/atmel-i2c.c     | 24 ++++++++++++++++++++++++
 drivers/crypto/atmel-i2c.h     |  5 +++++
 drivers/crypto/atmel-sha204a.c | 23 +++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/drivers/crypto/atmel-i2c.c b/drivers/crypto/atmel-i2c.c
index a0d0d4f2a..a895e4289 100644
--- a/drivers/crypto/atmel-i2c.c
+++ b/drivers/crypto/atmel-i2c.c
@@ -70,6 +70,30 @@ void atmel_i2c_init_read_config_cmd(struct atmel_i2c_cmd *cmd)
 }
 EXPORT_SYMBOL(atmel_i2c_init_read_config_cmd);
 
+int atmel_i2c_init_read_otp_cmd(struct atmel_i2c_cmd *cmd, u16 addr)
+{
+	if (addr < 0 || addr > OTP_ZONE_SIZE)
+		return -1;
+
+	cmd->word_addr = COMMAND;
+	cmd->opcode = OPCODE_READ;
+	/*
+	 * Read the word from OTP zone that may contain e.g. serial
+	 * numbers or similar if persistently pre-initialized and locked
+	 */
+	cmd->param1 = OTP_ZONE;
+	cmd->param2 = cpu_to_le16(addr);
+	cmd->count = READ_COUNT;
+
+	atmel_i2c_checksum(cmd);
+
+	cmd->msecs = MAX_EXEC_TIME_READ;
+	cmd->rxsize = READ_RSP_SIZE;
+
+	return 0;
+}
+EXPORT_SYMBOL(atmel_i2c_init_read_otp_cmd);
+
 void atmel_i2c_init_random_cmd(struct atmel_i2c_cmd *cmd)
 {
 	cmd->word_addr = COMMAND;
diff --git a/drivers/crypto/atmel-i2c.h b/drivers/crypto/atmel-i2c.h
index 275297a82..72f04c156 100644
--- a/drivers/crypto/atmel-i2c.h
+++ b/drivers/crypto/atmel-i2c.h
@@ -64,6 +64,10 @@ struct atmel_i2c_cmd {
 
 /* Definitions for eeprom organization */
 #define CONFIGURATION_ZONE		0
+#define OTP_ZONE			1
+
+/* Definitions for eeprom zone sizes */
+#define OTP_ZONE_SIZE			64
 
 /* Definitions for Indexes common to all commands */
 #define RSP_DATA_IDX			1 /* buffer index of data in response */
@@ -179,6 +183,7 @@ void atmel_i2c_flush_queue(void);
 int atmel_i2c_send_receive(struct i2c_client *client, struct atmel_i2c_cmd *cmd);
 
 void atmel_i2c_init_read_config_cmd(struct atmel_i2c_cmd *cmd);
+int atmel_i2c_init_read_otp_cmd(struct atmel_i2c_cmd *cmd, u16 addr);
 void atmel_i2c_init_random_cmd(struct atmel_i2c_cmd *cmd);
 void atmel_i2c_init_genkey_cmd(struct atmel_i2c_cmd *cmd, u16 keyid);
 int atmel_i2c_init_ecdh_cmd(struct atmel_i2c_cmd *cmd,
diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index c77f482d2..563a0493b 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -91,6 +91,29 @@ static int atmel_sha204a_rng_read(struct hwrng *rng, void *data, size_t max,
 	return max;
 }
 
+static int atmel_sha204a_otp_read(struct i2c_client *client, u16 addr, u8 *otp)
+{
+	struct atmel_i2c_cmd cmd;
+	int ret = -1;
+
+	if (atmel_i2c_init_read_otp_cmd(&cmd, addr) < 0) {
+		dev_err(&client->dev, "failed, invalid otp address %04X\n",
+			addr);
+		return ret;
+	}
+
+	ret = atmel_i2c_send_receive(client, &cmd);
+
+	if (cmd.data[0] == 0xff) {
+		dev_err(&client->dev, "failed, device not ready\n");
+		return -ret;
+	}
+
+	memcpy(otp, cmd.data+1, 4);
+
+	return ret;
+}
+
 static int atmel_sha204a_probe(struct i2c_client *client)
 {
 	struct atmel_i2c_client_priv *i2c_priv;
-- 
2.25.1



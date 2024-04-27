Return-Path: <linux-kernel+bounces-160812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A54AE8B4323
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97662B213A6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C1E2AE66;
	Sat, 27 Apr 2024 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2ObT6pZ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFA0E566;
	Sat, 27 Apr 2024 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176890; cv=none; b=dErcBMURrTtVgjVS93isT+2scno+UDbpI68faggYmB+SIwbwRyZT63cM8kHqE7SfZsofKwmQNdHAU1/+6VcAx0BI04irk4HZgK1f8r8y4p5Yqk5w3I19pJAf2mZB+S0QJMM5UA/yfeKwYU5yxNcBdCCJvJrfBEd5Qy0GeLeku1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176890; c=relaxed/simple;
	bh=5Z3YDU23nPaRHuZlW6BpIbTIdFXBjUqo4Zxal5ZJMJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sey10xDj5GhS6h43qSXpFwdPq9gEImOTurZxzEqcxpOmLd1BxDDybsqQSuwkppAJ+KGqJFed2dcF7hJ/RHKEYp8DYBEFbyrwHtd/6Z3LroLLd/oP51IJRs1TcMCyGhTpOT/4svgWdFXgZ3o3J3vqVkKo2NZ1/yIVr8Qxz8l5amo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2ObT6pZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34c8592b8dbso477561f8f.3;
        Fri, 26 Apr 2024 17:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714176887; x=1714781687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Jw+4H2dgDC16joAqwpa2WM311+mGLcZu7L4IaXQQTU=;
        b=f2ObT6pZmNy2oynRWdLz9EBrGYwuvrihnUqbwrhXacvz5x/hiAmEpM750nOkV1lePq
         O+wkePMoDD46fmziEQsEjkRUe+Jt6PdDLsvuc7bwZQbleIPybjrmBaXKTS4ROfWywPW+
         O6/AqygLkLeUMo1uy5bZxmjPDKqfFMzMDZCqxnfTRbgKpN4d2yIc6JJa+sl6Yhi9Tag4
         p70Bod8gy2r+/m3F7CXvxpQyq7tKJP+shSNyaviDn5fBoJw6kCX+oeev0qNlujd6/6bu
         vB2E8Va7Y0Fx2kUc59f4ONdrZuBlZnM9Q2wpigvoW4zt5lOirNAMiaDOaYPECPs9G9Ki
         RTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714176887; x=1714781687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Jw+4H2dgDC16joAqwpa2WM311+mGLcZu7L4IaXQQTU=;
        b=H51FXRZVfRJ0b/SlH6ngM2A2BzR5iK0eSfSbkafL9lreGaH4KL+zeY1x1tOBR5OPPn
         6l0MJvRl3kyqO/VBYSkRtMDqFIRhlAoqaQlsb3G7tmyYB0ydREjJq2NV5R3ufUo3uPX3
         nmX6m4qY+0AR2UvMMUQ+QZfZ2if16BFyjbVmSmmB5lLC8zCiRhAM0Y6tkuT7zSZH7gkS
         i2mEsjRb6BMZFd2ykPcZ/ZJ3+WCmgr5OFSVlf870GO9Gq7WXO/p7DtAa5a8iT3rmIgWd
         45me1RA8xcwdv8CtC495xk3rkcVyE0fwHz189H7aJc06/g+hpcBE1smM2p5i2rF8mgYX
         x8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUV0Ex7/Bv481Rj9TOopRNobm5AqRykIP5YimBMJuyKtDpnAUx+RJd5ig7tcVw5i9ZJ0PKiSjHXZAuH3iJSdGi8QPcsOVkjDjdzo7wie9mIisieIx/fsK8PSqsx8kGz6iHhIKXkpSfmrPNP
X-Gm-Message-State: AOJu0YxMYD4ZUMANvVQej+VrZuXitEBWiTsMuyw/vy1vjnk5f7W37rPK
	iDFoOXX4GlQJOtHRGjzrkOJKpGQYYylSm+k91EUKDoYPLOCWIU7c
X-Google-Smtp-Source: AGHT+IE4GG7POJxQQcSduYqJJ1hpchS7wYZ7oE51tH8muQezmztZSTxqiRyWaLVmbgwuMJ+4DCj1YA==
X-Received: by 2002:a5d:59a4:0:b0:34c:5d7:517 with SMTP id p4-20020a5d59a4000000b0034c05d70517mr3633505wrr.18.1714176887634;
        Fri, 26 Apr 2024 17:14:47 -0700 (PDT)
Received: from 2116bb4b8996.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d65c7000000b00349eb6eae3esm23748079wrw.4.2024.04.26.17.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 17:14:47 -0700 (PDT)
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
Subject: [PATCH 4/5] crypto: atmel-sha204a - add reading from otp zone
Date: Sat, 27 Apr 2024 00:14:38 +0000
Message-Id: <20240427001439.12726-5-l.rubusch@gmail.com>
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
index 5c3fef6e9..81b5ea722 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -82,6 +82,29 @@ static int atmel_sha204a_rng_read(struct hwrng *rng, void *data, size_t max,
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
2.39.2



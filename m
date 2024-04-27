Return-Path: <linux-kernel+bounces-160811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649A18B4321
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61920B22D85
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDF325757;
	Sat, 27 Apr 2024 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex0XjpGU"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3F68C11;
	Sat, 27 Apr 2024 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176889; cv=none; b=Y5ezbEOm9OmWm951AculN7MSDRVJJoUUlGP+o8GdVp1QTlKX6otDTVhMq6oVkJ0pNqj43oBy9jZF9W4yb4W1Yq0pDZB3+nVGtONKvYaX8r68uDAI+o0Y+Vk2b0dHbAm7O267w3DKW7Ei4VTO8qTPhIqqEHwp408IN4eiNZkudAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176889; c=relaxed/simple;
	bh=7dkhjZYA2lOL4VQ95Odht1Oz9K64fNVSbaPiDgL9WZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lExeN/vprzHNO9Jm+WF+JZI9buXNvAi+vFLk/IrXJCEQjj/SYA5nBogUz9hrRC+kbs0pzlEMIdVjGBE5Oa0nXeLD0waBXsQvQls8Y1fhsAU8pgzuLcV3z0exsdzX1Ak7ndbHfiMPnch+CNJKK+ppTj5G2aZuVT95H0Fj+G3yRFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex0XjpGU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343d2b20c4bso1934778f8f.2;
        Fri, 26 Apr 2024 17:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714176887; x=1714781687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7Wu7HX45DmWrSGYlsp775A2vFtSzeLLbSxZad1dUpk=;
        b=Ex0XjpGU4cO/RoUbDbUMsNUwbWu0sygqSmjAOn3jKQo1v8nCOR3Zj8EjRbM2Peq11E
         dal0HP8ryQ0i05lsA08ZS6o2+ZTW7k+k6lm5w7MzTg+lQAB7LfureuuS3mDV7yeXtC6m
         hwgmkPKWR5xha4hPJBx4ZTubbtW11PXddAtVgedbRkGgryTMNCx29WvFxFU75VtzwmXp
         2lsxaZTMSChT6yNWHoDiU3U/RIyPOhcLx2YS1LyVZRQmLu3qako7WPYus41suRqknAVa
         uE/iJFuVaa1qNpPNAXflTgasVLe3/tkO63UZyx9bNd/lvxuErB0l1GKzIAeHBdDovWrn
         m5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714176887; x=1714781687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7Wu7HX45DmWrSGYlsp775A2vFtSzeLLbSxZad1dUpk=;
        b=w9HIBMciDDSHSssgrn1UB1U7+ceATH6uJPo1xV08PdM4GHMscImOHkmLaEBEQXRcdG
         pd5IfUd9awmgM2bXqZ7W5dousDAobOvLkkl2UquqQp8ZaYuQQ14c9MHKAOPfAq/exy6+
         krGN3bSoOxYIt7ig1zYCTojPonsopIfIgU/Z6OjaPalFinkd4VevzHQ7zC0G+NC/x3KX
         pTYB1+XH7gn2osm9iiQCaXqpuOW+kdbShPtDp2Z3nfej3/AJgthB+7k1CGcCj5KI+BnE
         fjMvhp4ECfdwXtHgigWGmMIQIswkefOMVkw+h2fh66C1uzFejRNhPBwzE1UWR1ppuamq
         x4Pg==
X-Forwarded-Encrypted: i=1; AJvYcCW91SBtJJSpcDv+wCMrFiQgzgv5bX5hyB+fSeaP1MZ+pTJv/jndj+mGnWsCEtKRwF9ePG88QnhTdj42GG4Eoccm/CbArgyu9GldvOTdMdinkszoAMfZQ5lVQLOH7smtvQgHiD5upcfF6twX
X-Gm-Message-State: AOJu0YzixTBBLFJp7g2XApuffkbkVsrguKSJRZf08h8yh7abF8Laf+qD
	atlXLS7BQij9X90Kxx7OHkyT0QnbiCDK9t8O2CzpL60NkD2lgXC6
X-Google-Smtp-Source: AGHT+IEmN7Rx+Hbvdq15lK87C/Fn2h+azhHU+pRXnbwUfTaJdKo3RMDApbhevTOVpkgD6LpNRy2LJw==
X-Received: by 2002:a05:6000:18af:b0:349:f8a1:cd6a with SMTP id b15-20020a05600018af00b00349f8a1cd6amr3288311wri.16.1714176886534;
        Fri, 26 Apr 2024 17:14:46 -0700 (PDT)
Received: from 2116bb4b8996.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d65c7000000b00349eb6eae3esm23748079wrw.4.2024.04.26.17.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 17:14:46 -0700 (PDT)
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
Subject: [PATCH 3/5] crypto: atmel-i2c - rename read function
Date: Sat, 27 Apr 2024 00:14:37 +0000
Message-Id: <20240427001439.12726-4-l.rubusch@gmail.com>
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
2.39.2



Return-Path: <linux-kernel+bounces-69835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A97858F51
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BBC2837FD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC44B2C6A4;
	Sat, 17 Feb 2024 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6xKLwJ3"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A968A64A9B
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708172448; cv=none; b=Q3I/lBQ+aWXpk9p1iJnHYlwO4cerQXiUnV0D0Artamga3j9IPYN1xM62iz0jPY2AE0smg1y22YHHhMeLj0b3nzYudTrzHiHh/ISyEAOIHy8o6I7vxc05xvRmGHK81FtaVaisos+ctfG/E2SuLoik9GBHf+2PPAz2WUE1fczHPKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708172448; c=relaxed/simple;
	bh=1dJQ2usnmOgJC70Q+HzcBfcLPgWRuRWngchdgoduzwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qz0aeEvlLjHrdhprPSMbz2DaT88ELFJb+BMLlRXqLvBbXhboU13s2RmFeRs3r8MpySCv5J8X9oeHIiY6amQUcbLOwuCeNlglfijDFnnK6OO9JQeFCLZw2TdGkZJGdoCLyjLO2RDC/a6Cls+hBB/sWmNVu4lRC3lE9RufGy1gVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6xKLwJ3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41258905ea2so3705365e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 04:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708172443; x=1708777243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+mNrI/k5QCja8EvIn+nI1FFHhVVQ40ZahQzJY3VQjKM=;
        b=L6xKLwJ3LzjsfNmJLba8nyc6tvzgrXcCv4BmNi6gLSkvBS+Hu7hXbjJmWVYaR4K0BE
         znCpWZtZ9fNKbPCSswtIxmGATb8D6BDrfDRvSF2Yf4E0HQUqf7dQTj1csLiKgCa/tycp
         u8477BYTGJb9fOwZjFB9tz1bq/Y1v9vJNstLp8CLjnWHVpi3kPCY1Rc5JJU+gQwzm5Ys
         qW83TBSgYUefZHoQ+bc74csaYuCFv72lN41sXpcZhGscIHsal3G9tIYu18dmh83M0/Lf
         0FjvdLKr9xsD0CJc13IOIbJaf/6JJs2etTzqSOB6ckwUocXwT6AbQaxXkGSRZtRGR5Ab
         vOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708172443; x=1708777243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mNrI/k5QCja8EvIn+nI1FFHhVVQ40ZahQzJY3VQjKM=;
        b=rzJ32a6v7HMKr1xg92XucUs7B7tA70ckATCafdmDPq6nlyP5f2lPt+dw2HkJ2tkie9
         d7dBzliu7WhqQ9OMc1U8BnUbRMMSZPDGrSRQe33Cr9eCgIbuC8UryvHOVcQKuRUhNYaM
         So/LQwLaMNi6PWH5HPXnxKgiOpLXXXdbJ08IrNaluBoNzpoESjaJl5M0Y/7mCNQdD7+C
         DqCD4eqIRSKnBTfItnzP0VfIcPVfHxd5p9+4hIVqZkSW/tVs1stJ4RNPlQ9uBigwHNvK
         pl4FzB1UYiZJ6rkwoz8UD5QaYhKeplI4aPGljxNCoH42ntBpXlBkWjXFxYaLsEERPRtC
         zQaw==
X-Forwarded-Encrypted: i=1; AJvYcCUhbqyzxv9p++QUCHkQ2AKgqhCthJyWWRFz6/EhGIjixpub1d89D8KTTBcGWFrenYLbCBQmWPCOTpxDGdTd4zp8ybV7duZZmnEZAhnA
X-Gm-Message-State: AOJu0YzPNdnsQU6K9imzzvZl1EHMm2BV7SrDAKGTToU0JrIIo22TjSdZ
	L7HdIh8T1vlhaL1goRpXdaq+zBEK/cH/g8Qyr46/fliIwFhBGL2hqb4wSfCLLlc=
X-Google-Smtp-Source: AGHT+IEaYydFzZj86yy02sJAY3W0hS6m0uQKa8C/F2YRxJXILvcI9FUuldxlvRHNzSnwpPSKvZB0Dg==
X-Received: by 2002:a05:600c:2184:b0:411:c9c0:eddf with SMTP id e4-20020a05600c218400b00411c9c0eddfmr6002720wme.36.1708172442564;
        Sat, 17 Feb 2024 04:20:42 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id n11-20020a7bcbcb000000b00410bc833c2csm1800172wmi.1.2024.02.17.04.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 04:20:42 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: David Bauer <mail@david-bauer.net>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] mtd: spi-nor: Add support for BoHong bh25q128as
Date: Sat, 17 Feb 2024 13:20:22 +0100
Message-ID: <20240217122029.3278-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Bauer <mail@david-bauer.net>

Add MTD support for the BoHong bh25q128as SPI NOR chip.
The chip has 16MB of total capacity, divided into a total of 256
sectors, each 64KB sized. The chip also supports 4KB sectors.
Additionally, it supports dual and quad read modes.

Datasheet is public and can be found here [1].

Functionality was verified on an Tenbay WR1800K / MTK MT7621 board.

[1] https://www.e-interlink.com.tw/userUpload/files/BH25Q128AS_v1_0.pdf

Signed-off-by: David Bauer <mail@david-bauer.net>
[ reworked to new flash_info format ]
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/bohong.c | 24 ++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.c   |  1 +
 drivers/mtd/spi-nor/core.h   |  1 +
 4 files changed, 27 insertions(+)
 create mode 100644 drivers/mtd/spi-nor/bohong.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 5e68468b72fc..c8849cf5124f 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -2,6 +2,7 @@
 
 spi-nor-objs			:= core.o sfdp.o swp.o otp.o sysfs.o
 spi-nor-objs			+= atmel.o
+spi-nor-objs			+= bohong.o
 spi-nor-objs			+= eon.o
 spi-nor-objs			+= esmt.o
 spi-nor-objs			+= everspin.o
diff --git a/drivers/mtd/spi-nor/bohong.c b/drivers/mtd/spi-nor/bohong.c
new file mode 100644
index 000000000000..26988c139262
--- /dev/null
+++ b/drivers/mtd/spi-nor/bohong.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2005, Intec Automation Inc.
+ * Copyright (C) 2014, Freescale Semiconductor, Inc.
+ */
+
+#include <linux/mtd/spi-nor.h>
+
+#include "core.h"
+
+static const struct flash_info bohong_parts[] = {
+	{
+		.id = SNOR_ID(0x68, 0x40, 0x18),
+		.name = "bh25q128as",
+		.size = SZ_16M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	},
+};
+
+const struct spi_nor_manufacturer spi_nor_bohong = {
+	.name = "bohong",
+	.parts = bohong_parts,
+	.nparts = ARRAY_SIZE(bohong_parts),
+};
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 4129764fad8c..29c28ee683a1 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2037,6 +2037,7 @@ int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor)
 
 static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_atmel,
+	&spi_nor_bohong,
 	&spi_nor_eon,
 	&spi_nor_esmt,
 	&spi_nor_everspin,
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index d36c0e072954..c293568ae827 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -601,6 +601,7 @@ struct sfdp {
 
 /* Manufacturer drivers. */
 extern const struct spi_nor_manufacturer spi_nor_atmel;
+extern const struct spi_nor_manufacturer spi_nor_bohong;
 extern const struct spi_nor_manufacturer spi_nor_eon;
 extern const struct spi_nor_manufacturer spi_nor_esmt;
 extern const struct spi_nor_manufacturer spi_nor_everspin;
-- 
2.43.0



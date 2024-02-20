Return-Path: <linux-kernel+bounces-73639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 715AA85C560
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D53285DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5158D14A0B5;
	Tue, 20 Feb 2024 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNz6T+0q"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5514AD12
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459419; cv=none; b=TSulUtKjXEqrbkhtTYWjbLH8xh9HMZ8O5QGxqsHDtAbwVjh71Bnf/HZQiWqthoXeBWFjmt99/M01lIzc2f64eXCielPqPoaWSm9hlnp6hBKAw7xPR9Fa5tB6w7N9TVa6B/CaKat1AO8v5ry6tHiGqJ4HFrdRDpgXhLSWxV/EaVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459419; c=relaxed/simple;
	bh=bSI0amZpEoKNz4ctn7HeIKGVObO+8OmOkCcRmss7Fns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K1SZIc6FYANzfMClT+iX5doGzP+JMLez7UzkYfLNU29Qo+bI59WCuCUJX69rbesoDKEW77o2ljLaQ2hNWbOkknZoL5vywsjX7fE/l17nCuuK9utkaTlgKrkpSF4rhvFvOSHVVELcqe7J3QEYta8eZE1Qq3qjGzP61e3vbZX1oAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNz6T+0q; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d066f8239so2889465f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708459416; x=1709064216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nv7+yFK9n5VmWtu0mqH5ORYhJIf9Kx3iQ/yYWuoADPM=;
        b=QNz6T+0qRdOhVU6FVGn+SFKztK/Vx5pVZH4AaWjX8jWsRcI2A5rCRCEj/m/pmV1bvK
         uSFao0wzC3qyNYu1PFEHeIxJ/5Gej2gLAW+q8kv5DMPWbbN9+v+rokkd+bS8zxI+Wpk3
         FIif6XyYt0TX8/G+LXGnZnSD/rRVs/oEke0ezafaVgNELSdMQCAd6hgUh8/ECmwyVs1f
         ZIQ3AqKZwwR0Hs1F0+GmXGT0FD1AXQSpxPWJ5d8YvGcb+3msFuPiJ35Hw0AtNKEwaYp2
         YbjEXoLlSJAx8aof27UGIiccSKsXOKw1Q5QOg44NuFIaIeRXMQddmk8HQaL7m0lDsdAn
         7hMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708459416; x=1709064216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nv7+yFK9n5VmWtu0mqH5ORYhJIf9Kx3iQ/yYWuoADPM=;
        b=Yv0L8qcLwEE7/BSvgRUfLH00A+IOPCO04eEa3Solhg99FwB+Ks3/RDTUQATgf0Dgeu
         YVu+z6c/gi93Q58kowt7kUHPzJEn4Tbpjsj+zW4wTPe04ATqmk07uK4jYXklLl6vP0g9
         UP2tXfaMI+121sCR73WU6ZpmSWkda1s2kJSh6Hp1lqgfamIo4/WUZsxfzATLLeusIS/H
         4oxjM2IIb1inDGtrrs0bI4IcDELNV2jQWfTWbWFPIwAgchCYOuv51geJQjWkujr3YA4S
         87LsFViwIbrwALlGF9AbYNQQlqTbfPpF3U1/Sjy1rRGM8McMDacb3TUJ2bTJv4pJCgSb
         nHkw==
X-Forwarded-Encrypted: i=1; AJvYcCVuPv5ajanYva+kto4MshXecToAsD5nmMozkk6edmjlfHhccd5TKVKXpp56b5HYoGgE2QcCquscNtzT+xzQwKxjdj25GsVdbVwAAGPc
X-Gm-Message-State: AOJu0YzgljOsEa1XxmJWkIIgCMbLAjwlbLHaD+RaKF6mPAOY6mde87FG
	b9eP9EJN7PiJz6Bf3nV0DyO2MfG3cAcIc4/LexM2OwHjF19nmxg4
X-Google-Smtp-Source: AGHT+IEM+Bk6HvcZ+x9oKGd6+MSXBHv6fbx/PMbTluktnlEjiuzxJ+ncYLh7048GIgpCKQ2pScg9BA==
X-Received: by 2002:a5d:4104:0:b0:33b:5f1d:5ef4 with SMTP id l4-20020a5d4104000000b0033b5f1d5ef4mr10028927wrp.1.1708459415563;
        Tue, 20 Feb 2024 12:03:35 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id x4-20020adff644000000b0033b792ed609sm14539955wrp.91.2024.02.20.12.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 12:03:35 -0800 (PST)
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
Subject: [PATCH v2] mtd: spi-nor: Add support for BoHong bh25q128as
Date: Tue, 20 Feb 2024 21:03:23 +0100
Message-ID: <20240220200325.19089-1-ansuelsmth@gmail.com>
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

Datasheet is public and can be found at the referenced link.

Functionality was verified on an Tenbay WR1800K / MTK MT7621 board.

Link: https://www.e-interlink.com.tw/userUpload/files/BH25Q128AS_v1_0.pdf
Signed-off-by: David Bauer <mail@david-bauer.net>
[ reworked to new flash_info format ]
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Read/write/erase test are done by flashing and installing an OpenWrt
image on the spi and by using overlayfs on it confirming correct
read/write.

root@OpenWrt:/tmp/tmp2# cat /sys/bus/spi/devices/spi0.0/spi-nor/partname 
bh25q128as
root@OpenWrt:/tmp/tmp2# cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id 
684018
root@OpenWrt:/tmp/tmp2# cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer 
bohong

root@OpenWrt:/# xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
53464450000101ff00000109300000ff68000103600000ffffffffffffff
ffffffffffffffffffffffffffffffffffffe520f1ffffffff0744eb086b
083b42bbeeffffffffff00ffffff44eb0c200f5210d800ffffffffffffff
ffffffffffff003600279ef97764fcebffff

root@OpenWrt:/# sha256sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
e2e374124e998c9c430a5a4c368ded374186637f48301dcb3943b81af2987995  /sys/bus/spi/devices/spi0.0/spi-np

root@OpenWrt:/tmp/tmp2# hexdump -Cv /sys/bus/spi/devices/spi0.0/spi-nor/sfdp 
00000000  53 46 44 50 00 01 01 ff  00 00 01 09 30 00 00 ff  |SFDP........0...|
00000010  68 00 01 03 60 00 00 ff  ff ff ff ff ff ff ff ff  |h...`...........|
00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000030  e5 20 f1 ff ff ff ff 07  44 eb 08 6b 08 3b 42 bb  |. ......D..k.;B.|
00000040  ee ff ff ff ff ff 00 ff  ff ff 44 eb 0c 20 0f 52  |..........D.. .R|
00000050  10 d8 00 ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000060  00 36 00 27 9e f9 77 64  fc eb ff ff              |.6.'..wd....|
0000006c

root@OpenWrt:/tmp/tmp2# sha256sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
e2e374124e998c9c430a5a4c368ded374186637f48301dcb3943b81af2987995  /sys/bus/spi/devices/spi0.0/spi-nor/sfdp

root@OpenWrt:/tmp/tmp2# cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode	0x03
  mode cycles	0
  dummy cycles	0
 1S-1S-2S
  opcode	0x3b
  mode cycles	0
  dummy cycles	8
 1S-2S-2S
  opcode	0xbb
  mode cycles	2
  dummy cycles	2
 1S-1S-4S
  opcode	0x6b
  mode cycles	0
  dummy cycles	8
 1S-4S-4S
  opcode	0xeb
  mode cycles	2
  dummy cycles	4

Supported page program modes by the flash
 1S-1S-1S
  opcode	0x02

root@OpenWrt:/tmp/tmp2# cat /sys/kernel/debug/spi-nor/spi0.0/params
name		bh25q128as
id		68 40 18
size		16.0 MiB
write size	1
page size	256
address nbytes	3
flags		HAS_16BIT_SR

opcodes
 read		0x03
  dummy cycles	0
 erase		0xd8
 program	0x02
 8D extension	none

protocols
 read		1S-1S-1S
 write		1S-1S-1S
 register	1S-1S-1S

erase commands
 20 (4.00 KiB) [1]
 52 (32.0 KiB) [2]
 d8 (64.0 KiB) [3]
 c7 (16.0 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-00ffffff |     [ 123] | 

Changes v2:
- Drop wrong copyright header
- Drop name
- Add requested info about sfpd and others

 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/bohong.c | 18 ++++++++++++++++++
 drivers/mtd/spi-nor/core.c   |  1 +
 drivers/mtd/spi-nor/core.h   |  1 +
 4 files changed, 21 insertions(+)
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
index 000000000000..8ba4f3a32040
--- /dev/null
+++ b/drivers/mtd/spi-nor/bohong.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/mtd/spi-nor.h>
+
+#include "core.h"
+
+static const struct flash_info bohong_parts[] = {
+	{
+		.id = SNOR_ID(0x68, 0x40, 0x18),
+		.size = SZ_16M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	},
+};
+
+const struct spi_nor_manufacturer spi_nor_bohong = {
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



Return-Path: <linux-kernel+bounces-28917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A343A83049D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03594B25204
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61AD1DFCB;
	Wed, 17 Jan 2024 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAPuvlur"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E81D553;
	Wed, 17 Jan 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705491344; cv=none; b=aVcCkEEzSUvsgcazA2LhTRN62tg/IzlcXif9DZHSvSw3c4qiR90hKN0nh2+XSlkDtGvYl9a7z3OCRD9ruJF8RODFuV+zfmKcG9KYP/0YCOlEGa6Lu2uc0lFpyj+NE5w2LS9t8TECNSunjDN8xJ9liJjoZ1doPgGPuFRBjS6Cd24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705491344; c=relaxed/simple;
	bh=cGVn5nGKU6295YOEeT1bunPSed8dfV5dlF10LiiNIv4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=ZBvzjVMsEWp1aZbsA3rFTIyrPMog3Hy6VpXYhGWIVF+Zx1c2v1BSc/c8zhmDuL1aWkqx5uhd1B5/xwhyaenYIvawnP4aBsr5dykIIbB8L3qrE2DAPWTj/3ZEYxEeYhrUDGz8upeUhrfvnIX8ysJ3nL2/XG1VQlwiVsqa5RJJIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAPuvlur; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-337b71a0240so1384589f8f.0;
        Wed, 17 Jan 2024 03:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705491341; x=1706096141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rlN6ktNqZqlESmFt/Q5ERUw4tTnRFjyWqNJgs9EIDOU=;
        b=WAPuvlurwnVNhD1GbxJ+T2qiYVYDw34SiTxFAmFoY1iMi3TDQJOZeBxStVIQ6j+IdI
         PTbhFwJ9nL12eT5iy9MV3oyskuqZBrsm3XmQtEz+cVpvgh3MI9Q1aGVdUtUv8yzBdNIV
         ZZ7DgHaUg3/w+AxaP7ETg4I02xJTD9GjRQ7nKu7PebJkSq26Ht2WuGhJecMGbxWs+LQV
         lX1Mf/NbPz+BgoA8WGFlHU2Dv47uFUEf0tTmf9J67xV46SYoAe5q0ES3XBWBdD+jdUfo
         Id7Jvy5/sztv5uSuK92Zu3ySuIh+8jkC07unNTsg5lNUWIkbstLiqqQ+uUpASvwKBe0W
         4j5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705491341; x=1706096141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlN6ktNqZqlESmFt/Q5ERUw4tTnRFjyWqNJgs9EIDOU=;
        b=OeTasXTsgiDRnlgiIDfuJytnENbAXfgHMlPKXGrEoxCf2iFEbYf8IsTu9bzDkC5FZx
         ViGgQSN2usSRMGUbBreOm35PP1MD3sUnc6bVeBzVR4RqnRO/OHz2J4LW76JSoX78Wgz1
         2G+UH+6deanFIUusO6+XSkyqk+GpaAnHeeQYecio5FNW7tnzYDZDQwOWY5g4AFMjkYdH
         f0krSZbANUpJKtw306Tj6naZ1qgoLlrRpQld7ShfyRcXH0RaZBVn7np2RUa0cIO7/qrk
         d01KMG4ZplNABeViDUuUDlqym0B7ZKDICDxoNv8L9dx3Cm+bK+pJ3czWigdNWRP334na
         1soQ==
X-Gm-Message-State: AOJu0YyGNvDl+lGDo1t6AhPL74qWQUnF8GMNB1vhdhgHSzwdE8PmlMYK
	a5FnG/fQxv6EA9oAPYdQoDA=
X-Google-Smtp-Source: AGHT+IF8xWULn/5ZymiXJYjCyz9QaV6Tu9o4kcTTnRDvwNuvDUFkvnVxemCFrwokZb+L9hdahgg4zA==
X-Received: by 2002:a05:6000:1b0a:b0:337:bdcf:9d8b with SMTP id f10-20020a0560001b0a00b00337bdcf9d8bmr1360328wrz.76.1705491340740;
        Wed, 17 Jan 2024 03:35:40 -0800 (PST)
Received: from ran.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id g15-20020a5d64ef000000b00336f43fa654sm1493288wri.22.2024.01.17.03.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 03:35:40 -0800 (PST)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: richardcochran@gmail.com,
	jonathan.lemon@gmail.com,
	vadfed@fb.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH v4] ptp: ocp: add Adva timecard support
Date: Wed, 17 Jan 2024 13:35:36 +0200
Message-Id: <20240117113536.2829-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.26.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support for the Adva timecard.
The card uses different drivers to provide access to the
firmware SPI flash (Altera based).
Other parts of the code are the same and could be reused.

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---

 Addressed comments from:
 - Vadim Fedorenko : https://www.spinics.net/lists/netdev/msg962933.html
          
 Changes since version 3:
 - Initialize fw information for ADVA board.
 - Adding serialnum and board ID attribute support for ADVA board.
 - Adding signal generators and frequency counters. 
 
 drivers/ptp/ptp_ocp.c | 302 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 293 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 4021d3d325f9..39dbf58ca360 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -34,6 +34,9 @@
 #define PCI_VENDOR_ID_OROLIA			0x1ad7
 #define PCI_DEVICE_ID_OROLIA_ARTCARD		0xa000
 
+#define PCI_VENDOR_ID_ADVA			0xad5a
+#define PCI_DEVICE_ID_ADVA_TIMECARD		0x0400
+
 static struct class timecard_class = {
 	.name		= "timecard",
 };
@@ -63,6 +66,13 @@ struct ocp_reg {
 	u32	status_drift;
 };
 
+struct ptp_ocp_servo_conf {
+	u32	servo_offset_p;
+	u32	servo_offset_i;
+	u32	servo_drift_p;
+	u32	servo_drift_i;
+};
+
 #define OCP_CTRL_ENABLE		BIT(0)
 #define OCP_CTRL_ADJUST_TIME	BIT(1)
 #define OCP_CTRL_ADJUST_OFFSET	BIT(2)
@@ -397,10 +407,14 @@ static int ptp_ocp_sma_store(struct ptp_ocp *bp, const char *buf, int sma_nr);
 
 static int ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
+static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
+
 static const struct ocp_attr_group fb_timecard_groups[];
 
 static const struct ocp_attr_group art_timecard_groups[];
 
+static const struct ocp_attr_group adva_timecard_groups[];
+
 struct ptp_ocp_eeprom_map {
 	u16	off;
 	u16	len;
@@ -700,6 +714,12 @@ static struct ocp_resource ocp_fb_resource[] = {
 	},
 	{
 		.setup = ptp_ocp_fb_board_init,
+		.extra = &(struct ptp_ocp_servo_conf) {
+			.servo_offset_p = 0x2000,
+			.servo_offset_i = 0x1000,
+			.servo_drift_p = 0,
+			.servo_drift_i = 0,
+		},
 	},
 	{ }
 };
@@ -831,6 +851,170 @@ static struct ocp_resource ocp_art_resource[] = {
 	},
 	{
 		.setup = ptp_ocp_art_board_init,
+		.extra = &(struct ptp_ocp_servo_conf) {
+			.servo_offset_p = 0x2000,
+			.servo_offset_i = 0x1000,
+			.servo_drift_p = 0,
+			.servo_drift_i = 0,
+		},
+	},
+	{ }
+};
+
+static struct ocp_resource ocp_adva_resource[] = {
+	{
+		OCP_MEM_RESOURCE(reg),
+		.offset = 0x01000000, .size = 0x10000,
+	},
+	{
+		OCP_EXT_RESOURCE(ts0),
+		.offset = 0x01010000, .size = 0x10000, .irq_vec = 1,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 0,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(ts1),
+		.offset = 0x01020000, .size = 0x10000, .irq_vec = 2,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 1,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(ts2),
+		.offset = 0x01060000, .size = 0x10000, .irq_vec = 6,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 2,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	/* Timestamp for PHC and/or PPS generator */
+	{
+		OCP_EXT_RESOURCE(pps),
+		.offset = 0x010C0000, .size = 0x10000, .irq_vec = 0,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 5,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(signal_out[0]),
+		.offset = 0x010D0000, .size = 0x10000, .irq_vec = 11,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 1,
+			.irq_fcn = ptp_ocp_signal_irq,
+			.enable = ptp_ocp_signal_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(signal_out[1]),
+		.offset = 0x010E0000, .size = 0x10000, .irq_vec = 12,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 2,
+			.irq_fcn = ptp_ocp_signal_irq,
+			.enable = ptp_ocp_signal_enable,
+		},
+	},
+	{
+		OCP_MEM_RESOURCE(pps_to_ext),
+		.offset = 0x01030000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(pps_to_clk),
+		.offset = 0x01040000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(tod),
+		.offset = 0x01050000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(image),
+		.offset = 0x00020000, .size = 0x1000,
+	},
+	{
+		OCP_MEM_RESOURCE(pps_select),
+		.offset = 0x00130000, .size = 0x1000,
+	},
+	{
+		OCP_MEM_RESOURCE(sma_map1),
+		.offset = 0x00140000, .size = 0x1000,
+	},
+	{
+		OCP_MEM_RESOURCE(sma_map2),
+		.offset = 0x00220000, .size = 0x1000,
+	},
+	{
+		OCP_SERIAL_RESOURCE(gnss_port),
+		.offset = 0x00160000 + 0x1000, .irq_vec = 3,
+		.extra = &(struct ptp_ocp_serial_port) {
+			.baud = 9600,
+		},
+	},
+	{
+		OCP_SERIAL_RESOURCE(mac_port),
+		.offset = 0x00180000 + 0x1000, .irq_vec = 5,
+		.extra = &(struct ptp_ocp_serial_port) {
+			.baud = 115200,
+		},
+	},
+	{
+			OCP_MEM_RESOURCE(freq_in[0]),
+			.offset = 0x01200000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(freq_in[1]),
+		.offset = 0x01210000, .size = 0x10000,
+	},
+	{
+		OCP_SPI_RESOURCE(spi_flash),
+		.offset = 0x00310400, .size = 0x10000, .irq_vec = 9,
+		.extra = &(struct ptp_ocp_flash_info) {
+			.name = "spi_altera", .pci_offset = 0,
+			.data_size = sizeof(struct altera_spi_platform_data),
+			.data = &(struct altera_spi_platform_data) {
+				.num_chipselect = 1,
+				.num_devices = 1,
+				.devices = &(struct spi_board_info) {
+					.modalias = "spi-nor",
+				},
+			},
+		},
+	},
+	{
+		OCP_I2C_RESOURCE(i2c_ctrl),
+		.offset = 0x150000, .size = 0x100, .irq_vec = 7,
+		.extra = &(struct ptp_ocp_i2c_info) {
+			.name = "ocores-i2c",
+			.fixed_rate = 50000000,
+			.data_size = sizeof(struct ocores_i2c_platform_data),
+			.data = &(struct ocores_i2c_platform_data) {
+				.clock_khz = 50000,
+				.bus_khz = 100,
+				.reg_io_width = 4, // 32-bit/4-byte
+				.reg_shift = 2, // 32-bit addressing
+				.num_devices = 2,
+				.devices = (struct i2c_board_info[]) {
+					{ I2C_BOARD_INFO("24c02", 0x50) },
+					{ I2C_BOARD_INFO("24mac402", 0x58),
+					 .platform_data = "mac" },
+				},
+			},
+		},
+	},
+	{
+		.setup = ptp_ocp_adva_board_init,
+		.extra = &(struct ptp_ocp_servo_conf) {
+			.servo_offset_p = 0xc000,
+			.servo_offset_i = 0x1000,
+			.servo_drift_p = 0,
+			.servo_drift_i = 0,
+		},
 	},
 	{ }
 };
@@ -839,6 +1023,7 @@ static const struct pci_device_id ptp_ocp_pcidev_id[] = {
 	{ PCI_DEVICE_DATA(FACEBOOK, TIMECARD, &ocp_fb_resource) },
 	{ PCI_DEVICE_DATA(CELESTICA, TIMECARD, &ocp_fb_resource) },
 	{ PCI_DEVICE_DATA(OROLIA, ARTCARD, &ocp_art_resource) },
+	{ PCI_DEVICE_DATA(ADVA, TIMECARD, &ocp_adva_resource) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, ptp_ocp_pcidev_id);
@@ -917,6 +1102,30 @@ static const struct ocp_selector ptp_ocp_art_sma_out[] = {
 	{ }
 };
 
+static const struct ocp_selector ptp_ocp_adva_sma_in[] = {
+	{ .name = "10Mhz",	.value = 0x0000,      .frequency = 10000000},
+	{ .name = "PPS1",	.value = 0x0001,      .frequency = 1 },
+	{ .name = "PPS2",	.value = 0x0002,      .frequency = 1 },
+	{ .name = "TS1",	.value = 0x0004,      .frequency = 0 },
+	{ .name = "TS2",	.value = 0x0008,      .frequency = 0 },
+	{ .name = "FREQ1",	.value = 0x0100,      .frequency = 0 },
+	{ .name = "FREQ2",	.value = 0x0200,      .frequency = 0 },
+	{ .name = "None",	.value = SMA_DISABLE, .frequency = 0 },
+	{ }
+};
+
+static const struct ocp_selector ptp_ocp_adva_sma_out[] = {
+	{ .name = "10Mhz",	.value = 0x0000,  .frequency = 10000000},
+	{ .name = "PHC",	.value = 0x0001,  .frequency = 1 },
+	{ .name = "MAC",	.value = 0x0002,  .frequency = 1 },
+	{ .name = "GNSS1",	.value = 0x0004,  .frequency = 1 },
+	{ .name = "GEN1",	.value = 0x0040 },
+	{ .name = "GEN2",	.value = 0x0080 },
+	{ .name = "GND",	.value = 0x2000 },
+	{ .name = "VCC",	.value = 0x4000 },
+	{ }
+};
+
 struct ocp_sma_op {
 	const struct ocp_selector *tbl[2];
 	void (*init)(struct ptp_ocp *bp);
@@ -1363,7 +1572,7 @@ ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
 }
 
 static int
-ptp_ocp_init_clock(struct ptp_ocp *bp)
+ptp_ocp_init_clock(struct ptp_ocp *bp, struct ptp_ocp_servo_conf *servo_conf)
 {
 	struct timespec64 ts;
 	u32 ctrl;
@@ -1371,12 +1580,11 @@ ptp_ocp_init_clock(struct ptp_ocp *bp)
 	ctrl = OCP_CTRL_ENABLE;
 	iowrite32(ctrl, &bp->reg->ctrl);
 
-	/* NO DRIFT Correction */
-	/* offset_p:i 1/8, offset_i: 1/16, drift_p: 0, drift_i: 0 */
-	iowrite32(0x2000, &bp->reg->servo_offset_p);
-	iowrite32(0x1000, &bp->reg->servo_offset_i);
-	iowrite32(0,	  &bp->reg->servo_drift_p);
-	iowrite32(0,	  &bp->reg->servo_drift_i);
+	/* servo configuration */
+	iowrite32(servo_conf->servo_offset_p, &bp->reg->servo_offset_p);
+	iowrite32(servo_conf->servo_offset_i, &bp->reg->servo_offset_i);
+	iowrite32(servo_conf->servo_drift_p, &bp->reg->servo_drift_p);
+	iowrite32(servo_conf->servo_drift_p, &bp->reg->servo_drift_i);
 
 	/* latch servo values */
 	ctrl |= OCP_CTRL_ADJUST_SERVO;
@@ -2362,6 +2570,14 @@ static const struct ocp_sma_op ocp_fb_sma_op = {
 	.set_output	= ptp_ocp_sma_fb_set_output,
 };
 
+static const struct ocp_sma_op ocp_adva_sma_op = {
+	.tbl		= { ptp_ocp_adva_sma_in, ptp_ocp_adva_sma_out },
+	.init		= ptp_ocp_sma_fb_init,
+	.get		= ptp_ocp_sma_fb_get,
+	.set_inputs	= ptp_ocp_sma_fb_set_inputs,
+	.set_output	= ptp_ocp_sma_fb_set_output,
+};
+
 static int
 ptp_ocp_set_pins(struct ptp_ocp *bp)
 {
@@ -2441,7 +2657,7 @@ ptp_ocp_fb_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 		return err;
 	ptp_ocp_sma_init(bp);
 
-	return ptp_ocp_init_clock(bp);
+	return ptp_ocp_init_clock(bp, r->extra);
 }
 
 static bool
@@ -2603,7 +2819,44 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 	if (err)
 		return err;
 
-	return ptp_ocp_init_clock(bp);
+	return ptp_ocp_init_clock(bp, r->extra);
+}
+
+/* ADVA specific board initializers; last "resource" registered. */
+static int
+ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
+{
+	int err;
+	u32 version;
+
+	bp->flash_start = 0xA00000;
+	bp->eeprom_map = fb_eeprom_map;
+	bp->sma_op = &ocp_adva_sma_op;
+
+	version = ioread32(&bp->image->version);
+	/* if lower 16 bits are empty, this is the fw loader. */
+	if ((version & 0xffff) == 0) {
+		version = version >> 16;
+		bp->fw_loader = true;
+	}
+	bp->fw_tag = 1;
+	bp->fw_version = version & 0xffff;
+	bp->fw_cap = OCP_CAP_BASIC | OCP_CAP_SIGNAL | OCP_CAP_FREQ;
+
+	ptp_ocp_tod_init(bp);
+	ptp_ocp_nmea_out_init(bp);
+	ptp_ocp_signal_init(bp);
+
+	err = ptp_ocp_attr_group_add(bp, adva_timecard_groups);
+	if (err)
+		return err;
+
+	err = ptp_ocp_set_pins(bp);
+	if (err)
+		return err;
+	ptp_ocp_sma_init(bp);
+
+	return ptp_ocp_init_clock(bp, r->extra);
 }
 
 static ssize_t
@@ -3578,6 +3831,37 @@ static const struct ocp_attr_group art_timecard_groups[] = {
 	{ },
 };
 
+static struct attribute *adva_timecard_attrs[] = {
+	&dev_attr_serialnum.attr,
+	&dev_attr_gnss_sync.attr,
+	&dev_attr_clock_source.attr,
+	&dev_attr_available_clock_sources.attr,
+	&dev_attr_sma1.attr,
+	&dev_attr_sma2.attr,
+	&dev_attr_sma3.attr,
+	&dev_attr_sma4.attr,
+	&dev_attr_available_sma_inputs.attr,
+	&dev_attr_available_sma_outputs.attr,
+	&dev_attr_clock_status_drift.attr,
+	&dev_attr_clock_status_offset.attr,
+	&dev_attr_ts_window_adjust.attr,
+	&dev_attr_tod_correction.attr,
+	NULL,
+};
+
+static const struct attribute_group adva_timecard_group = {
+	.attrs = adva_timecard_attrs,
+};
+
+static const struct ocp_attr_group adva_timecard_groups[] = {
+	{ .cap = OCP_CAP_BASIC,	    .group = &adva_timecard_group },
+	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal0_group },
+	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal1_group },
+	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq0_group },
+	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq1_group },
+	{ },
+};
+
 static void
 gpio_input_map(char *buf, struct ptp_ocp *bp, u16 map[][2], u16 bit,
 	       const char *def)
-- 
2.26.3



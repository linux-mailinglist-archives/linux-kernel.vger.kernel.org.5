Return-Path: <linux-kernel+bounces-15227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 805568228BB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB40DB21A45
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F254418032;
	Wed,  3 Jan 2024 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+uyaWx8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDD2179AA;
	Wed,  3 Jan 2024 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d87df95ddso23413915e9.0;
        Tue, 02 Jan 2024 23:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704265843; x=1704870643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d1xSlSEpk9i2PdiPgvOpboLqVAXHUKk6uv67sMJ/h+8=;
        b=c+uyaWx80SLwp1FX7o8zyX7QU3kGZvxVd9Qo0M0rVQs9I7WcEn2PdazjWPqMEJWeRU
         cY7yrf0foa/Dq1+qteatmrXQ8Eb1/T8iHSao2hddhwCoCT+htJAOcq9uiM8qXkJREbtE
         UhBi7UdUqCoJEZyP9VOeMkr5Cdxq6P6TuLFPARDAL6G/wqQr9BhthinJlQudMk+EwPrP
         HGaIUk5b4eZuM4nrO619pyo6OINEkYwrxhsu2RWIj+Lc46dnH62xn8eUwy490YI2/3cK
         CUsOqj4+QEVPsBg0qOBvYT2GjCjTx1YVMzcx4oSbSDAziuc6RVQjsKYFTKFUmm9emwk7
         RBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704265843; x=1704870643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1xSlSEpk9i2PdiPgvOpboLqVAXHUKk6uv67sMJ/h+8=;
        b=EpIXDXF/FkT00/mekI+F6Hc9Gcdl2dEu5WlMpq0/lvIGDtaCIb1KSvGeHr6vzkwYvq
         4IuTpHYLowWVHF5vVyX3EKUDb8r0x0efw2arBMgeQS7Jbkw3CZSpGGFhZGv+IbLTCD0c
         wQzYZeqv53mVuITjUip8x/g2rcyw6qh05j89Fars+QO6l1dk8mDnfSXNtu94pIFew13A
         kiO4QDIj9vUA7wDt7iarQ7x6H9T291Eyl1fzkLA1WMzgd7Hs580UrvOCGuztSZ6lq0n/
         u4bZbJUSPpIh1qXje7l65eVBoWw94lBHBwkslB3gM/JojpD2Y4DwIwTzgLinZJA3pnex
         pAag==
X-Gm-Message-State: AOJu0YzAbI3MRmOK9ND++0QCnayuscJnxVVYLcsRfcKt/m2jKDetc1Zm
	Qih01kQTKblb/kZWyGm/kbc=
X-Google-Smtp-Source: AGHT+IH/LYVKGB9iS892w7jugK2mXCLiq/DlWErOwI2yiYJ/2hB7mth1xcCwV1vDYwHjtoVajCwZrA==
X-Received: by 2002:a05:600c:3d0e:b0:40d:5c47:906c with SMTP id bh14-20020a05600c3d0e00b0040d5c47906cmr3430433wmb.294.1704265843394;
        Tue, 02 Jan 2024 23:10:43 -0800 (PST)
Received: from ran.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c4f4400b0040d3276ba19sm1342367wmq.25.2024.01.02.23.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 23:10:42 -0800 (PST)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: richardcochran@gmail.com,
	jonathan.lemon@gmail.com,
	vadfed@fb.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH v3] ptp: ocp: add Adva timecard support
Date: Wed,  3 Jan 2024 09:10:39 +0200
Message-Id: <20240103071039.94132-1-maimon.sagi@gmail.com>
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
 - Jakub Kicinski : https://www.spinics.net/lists/netdev/msg962419.html
          
 Changes since version 2:
 - reformat the commit message to separate the subject from the body of the message.
 
 
 drivers/ptp/ptp_ocp.c | 247 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 238 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 4021d3d325f9..96f2ab8a9d61 100644
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
@@ -831,6 +851,129 @@ static struct ocp_resource ocp_art_resource[] = {
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
+			OCP_MEM_RESOURCE(freq_in[0]),
+			.offset = 0x01200000, .size = 0x10000,
+	},
+	{
+			OCP_SPI_RESOURCE(spi_flash),
+			.offset = 0x00310400, .size = 0x10000, .irq_vec = 9,
+			.extra = &(struct ptp_ocp_flash_info) {
+				.name = "spi_altera", .pci_offset = 0,
+				.data_size = sizeof(struct altera_spi_platform_data),
+				.data = &(struct altera_spi_platform_data) {
+					.num_chipselect = 1,
+					.num_devices = 1,
+					.devices = &(struct spi_board_info) {
+						.modalias = "spi-nor",
+					},
+				},
+			},
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
@@ -839,6 +982,7 @@ static const struct pci_device_id ptp_ocp_pcidev_id[] = {
 	{ PCI_DEVICE_DATA(FACEBOOK, TIMECARD, &ocp_fb_resource) },
 	{ PCI_DEVICE_DATA(CELESTICA, TIMECARD, &ocp_fb_resource) },
 	{ PCI_DEVICE_DATA(OROLIA, ARTCARD, &ocp_art_resource) },
+	{ PCI_DEVICE_DATA(ADVA, TIMECARD, &ocp_adva_resource) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, ptp_ocp_pcidev_id);
@@ -917,6 +1061,27 @@ static const struct ocp_selector ptp_ocp_art_sma_out[] = {
 	{ }
 };
 
+static const struct ocp_selector ptp_ocp_adva_sma_in[] = {
+	{ .name = "10Mhz",	.value = 0x0000,      .frequency = 10000000},
+	{ .name = "PPS1",	.value = 0x0001,      .frequency = 1 },
+	{ .name = "PPS2",	.value = 0x0002,      .frequency = 1 },
+	{ .name = "TS1",	.value = 0x0004,      .frequency = 0 },
+	{ .name = "TS2",	.value = 0x0008,      .frequency = 0 },
+	{ .name = "FREQ1",	.value = 0x0100,      .frequency = 0 },
+	{ .name = "None",	.value = SMA_DISABLE, .frequency = 0 },
+	{ }
+};
+
+static const struct ocp_selector ptp_ocp_adva_sma_out[] = {
+	{ .name = "10Mhz",	.value = 0x0000,  .frequency = 10000000},
+	{ .name = "PHC",	.value = 0x0001,  .frequency = 1 },
+	{ .name = "GNSS1",	.value = 0x0004,  .frequency = 1 },
+	{ .name = "GEN1",	.value = 0x0040 },
+	{ .name = "GND",	.value = 0x2000 },
+	{ .name = "VCC",	.value = 0x4000 },
+	{ }
+};
+
 struct ocp_sma_op {
 	const struct ocp_selector *tbl[2];
 	void (*init)(struct ptp_ocp *bp);
@@ -1363,7 +1528,7 @@ ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
 }
 
 static int
-ptp_ocp_init_clock(struct ptp_ocp *bp)
+ptp_ocp_init_clock(struct ptp_ocp *bp, struct ptp_ocp_servo_conf *servo_conf)
 {
 	struct timespec64 ts;
 	u32 ctrl;
@@ -1371,12 +1536,11 @@ ptp_ocp_init_clock(struct ptp_ocp *bp)
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
@@ -2362,6 +2526,14 @@ static const struct ocp_sma_op ocp_fb_sma_op = {
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
@@ -2441,7 +2613,7 @@ ptp_ocp_fb_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 		return err;
 	ptp_ocp_sma_init(bp);
 
-	return ptp_ocp_init_clock(bp);
+	return ptp_ocp_init_clock(bp, r->extra);
 }
 
 static bool
@@ -2603,7 +2775,35 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
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
+
+	bp->flash_start = 0xA00000;
+	bp->fw_version = ioread32(&bp->image->version);
+	bp->sma_op = &ocp_adva_sma_op;
+
+	ptp_ocp_fb_set_version(bp);
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
@@ -3578,6 +3778,35 @@ static const struct ocp_attr_group art_timecard_groups[] = {
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
+	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq0_group },
+	{ },
+};
+
 static void
 gpio_input_map(char *buf, struct ptp_ocp *bp, u16 map[][2], u16 bit,
 	       const char *def)
-- 
2.26.3



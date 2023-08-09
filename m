Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779D6775429
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjHIHat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjHIHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:30:21 -0400
X-Greylist: delayed 1816 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 00:29:28 PDT
Received: from mx0a-002bf204.pphosted.com (mx0a-002bf204.pphosted.com [205.220.160.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C37271E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:29:28 -0700 (PDT)
Received: from pps.filterd (m0207524.ppops.net [127.0.0.1])
        by mx0a-002bf204.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3795W1PS013090;
        Tue, 8 Aug 2023 23:39:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        monolithicpower.com; h=from:to:cc:subject:date:message-id
        :content-type:content-transfer-encoding:mime-version; s=pps1;
         bh=duY11ensR5R2ti2+K0vKljYuCRCuwSTAsaFQTS0WBbM=; b=Mpo+yy1czm73
        fqROQykP6UPuo+2QKbbDPtSemSbfjsAAlp+qyKdp+K/xtvx4fzm62Uyuq+Z/tFsw
        CnluozL9yRRe8UsfCn81uT/ASl4TrwR83Xen9EofrnvJuZ5R8L8lkRYpW3aWyWx5
        RArzbcJedch6/BpFKBUxCphJwQ3R2RN7vu1HPy3gdfviSsfJpNCiE/BCXQAdru34
        cQkm6pNe8uUM14OtEbf6zv/ALkk/pDgDSAO8LpG/GlaMwgx6/n5fnqQnr92FBUTV
        Mwu5k6KDBuhDxn0CV708HeSxTJ+4Az/g7pGNUckp1Of/3fPwCwpJlbTOKLX0bjO7
        FlCJ6OonDg==
Received: from webmail.monolithicpower.com (mps-vpn.monolithicpower.com [12.33.0.20] (may be forged))
        by mx0a-002bf204.pphosted.com (PPS) with ESMTPS id 3s9hunssfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Aug 2023 23:39:14 -0700 (PDT)
Received: from CD-MSH02.monolithicpower.com (10.10.70.19) by
 mps-mslbn01.monolithicpower.com (10.10.10.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 8 Aug 2023 23:39:12 -0700
Received: from CD-MSH04.monolithicpower.com (10.10.70.213) by
 CD-MSH02.monolithicpower.com (10.10.70.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 9 Aug 2023 14:39:10 +0800
Received: from CD-MSH04.monolithicpower.com ([fe80::fd9c:129e:f4d1:923f]) by
 CD-MSH04.monolithicpower.com ([fe80::fd9c:129e:f4d1:923f%4]) with mapi id
 15.01.2242.004; Wed, 9 Aug 2023 14:39:10 +0800
From:   "Yuxi (Yuxi) Wang" <Yuxi.Wang@monolithicpower.com>
To:     "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "Yuxi (Yuxi) Wang" <Yuxi.Wang@monolithicpower.com>,
        "Leal (Long) Li" <Leal.Li@monolithicpower.com>,
        "wyx137120466@gmail.com" <wyx137120466@gmail.com>
Subject: [PATCH 1/2] leds: Add driver for mp3326
Thread-Topic: [PATCH 1/2] leds: Add driver for mp3326
Thread-Index: AdnKiRscmSK32XKzR9ChxNBk+6Goqg==
Date:   Wed, 9 Aug 2023 06:39:09 +0000
Message-ID: <97598d1812a7430d8f11682038ecf6dd@monolithicpower.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.84.38]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: fVIdsG5aZnms8I8mvvVRe8qerhZqy6rJ
X-Proofpoint-GUID: fVIdsG5aZnms8I8mvvVRe8qerhZqy6rJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_04,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2306200000
 definitions=main-2308090058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a led
 driver for the mp3326 which is from Monolithic Power Systems, Inc.

Signed-off-by: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
---
 drivers/leds/Kconfig       |   7 +
 drivers/leds/Makefile      |   1 +
 drivers/leds/leds-mp3326.c | 836 +++++++++++++++++++++++++++++++++++++
 3 files changed, 844 insertions(+)
 create mode 100644 drivers/leds/leds-mp3326.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 499d0f215a8b..5369506be7b2 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -244,6 +244,13 @@ config LEDS_MT6323
 	  This option enables support for on-chip LED drivers found on
 	  Mediatek MT6323 PMIC.
=20
+config LEDS_MP3326
+	tristate "LED Support for Monolithic power system MP3326"
+	depends on LEDS_CLASS
+	help
+	  This option enables support for on-chip LED drivers found on
+	  Monolithic power system MP3326.
+
 config LEDS_S3C24XX
 	tristate "LED Support for Samsung S3C24XX GPIO LEDs"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4fd2f92cd198..4859959c5c9a 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_LEDS_MIKROTIK_RB532)	+=3D leds-rb532.o
 obj-$(CONFIG_LEDS_MLXCPLD)		+=3D leds-mlxcpld.o
 obj-$(CONFIG_LEDS_MLXREG)		+=3D leds-mlxreg.o
 obj-$(CONFIG_LEDS_MT6323)		+=3D leds-mt6323.o
+obj-$(CONFIG_LEDS_MP3326)		+=3D leds-mp3326.o
 obj-$(CONFIG_LEDS_NET48XX)		+=3D leds-net48xx.o
 obj-$(CONFIG_LEDS_NETXBIG)		+=3D leds-netxbig.o
 obj-$(CONFIG_LEDS_NIC78BX)		+=3D leds-nic78bx.o
diff --git a/drivers/leds/leds-mp3326.c b/drivers/leds/leds-mp3326.c
new file mode 100644
index 000000000000..b54e167ea7cf
--- /dev/null
+++ b/drivers/leds/leds-mp3326.c
@@ -0,0 +1,836 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ * MP3326 Led driver
+ *
+ * Copyright 2023 Monolithic Power Systems, Inc
+ *
+ * Author: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
+ */
+#include <linux/bits.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/i2c.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/leds.h>
+
+/*reg list*/
+#define MP3326_PWM_DIM_FREQUENCY_CONFIG                 0x00
+#define MP3326_PWM_CTRL                                 0x01
+#define MP3326_PWM_DIM_FREQUENCY_CONFIG                 0x00
+#define MP3326_PWM_CTRL_CHANNEL_9_16                    0x04
+#define MP3326_PWM_CTRL_CHANNEL_1_8                     0x05
+#define MP3326_PWM_OPEN_FAULT_CHANNEL_9_16              0x06
+#define MP3326_PWM_OPEN_FAULT_CHANNEL_1_8               0x07
+#define MP3326_PWM_SHORT_FAULT_CHANNEL_9_16             0x08
+#define MP3326_PWM_SHORT_FAULT_CHANNEL_1_8              0x09
+#define MP3326_PWM_CURRENT_SET_CHANNEL1                 0x0A
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL1                0x0B
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL1                0x0C
+#define MP3326_PWM_CURRENT_SET_CHANNEL2                 0x0D
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL2                0x0E
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL2                0x0F
+#define MP3326_PWM_CURRENT_SET_CHANNEL3                 0x10
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL3                0x11
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL3                0x12
+#define MP3326_PWM_CURRENT_SET_CHANNEL4                 0x13
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL4                0x14
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL4                0x15
+#define MP3326_PWM_CURRENT_SET_CHANNEL5                 0x16
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL5                0x17
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL5                0x18
+#define MP3326_PWM_CURRENT_SET_CHANNEL6                 0x19
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL6                0x1A
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL6                0x1B
+#define MP3326_PWM_CURRENT_SET_CHANNEL7                 0x1C
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL7                0x1D
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL7                0x1E
+#define MP3326_PWM_CURRENT_SET_CHANNEL8                 0x1F
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL8                0x20
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL8                0x21
+#define MP3326_PWM_CURRENT_SET_CHANNEL9                 0x22
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL9                0x23
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL9                0x24
+#define MP3326_PWM_CURRENT_SET_CHANNEL10                0x25
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL10               0x26
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL10               0x27
+#define MP3326_PWM_CURRENT_SET_CHANNEL11                0x28
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL11               0x29
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL11               0x2A
+#define MP3326_PWM_CURRENT_SET_CHANNEL12                0x2B
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL12               0x2C
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL12               0x2D
+#define MP3326_PWM_CURRENT_SET_CHANNEL13                0x2E
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL13               0x2F
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL13               0x30
+#define MP3326_PWM_CURRENT_SET_CHANNEL14                0x31
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL14               0x32
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL14               0x33
+#define MP3326_PWM_CURRENT_SET_CHANNEL15                0x34
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL15               0x35
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL15               0x36
+#define MP3326_PWM_CURRENT_SET_CHANNEL16                0x37
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL16               0x38
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL16               0x39
+
+#define MP3326_REG_FIELD(ref) {		\
+	.regmap_fields =3D ref##_reg_fields,\
+}
+
+enum MP3326_Channel {
+	Channel1,
+	Channel2,
+	Channel3,
+	Channel4,
+	Channel5,
+	Channel6,
+	Channel7,
+	Channel8,
+	Channel9,
+	Channel10,
+	Channel11,
+	Channel12,
+	Channel13,
+	Channel14,
+	Channel15,
+	Channel16,
+	Max_Channel,
+};
+
+enum RGB_CTRL {
+ENABLE,
+BRIGHTNESS,
+COLOR_H4,
+COLOR_L8,
+OPEN_FAULT,
+SHORT_FAULT,
+Max_CTRL,
+};
+
+struct MP3326_reg_field {
+	struct reg_field  *regmap_fields;
+};
+
+static  struct reg_field channel1_reg_fields[] =3D {
+	[ENABLE]		=3D REG_FIELD(MP3326_PWM_CTRL_CHANNEL_1_8, 0, 0),
+	[BRIGHTNESS]	=3D REG_FIELD(MP3326_PWM_CURRENT_SET_CHANNEL1, 0, 5),
+	[COLOR_H4]		=3D REG_FIELD(MP3326_PWM_DUTY_LSB_SET_CHANNEL1, 0, 3),
+	[COLOR_L8]		=3D REG_FIELD(MP3326_PWM_DUTY_MSB_SET_CHANNEL1, 0, 7),
+	[OPEN_FAULT]	=3D REG_FIELD(MP3326_PWM_OPEN_FAULT_CHANNEL_1_8, 0, 0),
+	[SHORT_FAULT]	=3D REG_FIELD(MP3326_PWM_SHORT_FAULT_CHANNEL_1_8, 0, 0),
+};
+
+static  struct reg_field channel2_reg_fields[] =3D {
+	[ENABLE]		=3D REG_FIELD(MP3326_PWM_CTRL_CHANNEL_1_8, 1, 1),
+	[BRIGHTNESS]	=3D REG_FIELD(MP3326_PWM_CURRENT_SET_CHANNEL2, 0, 5),
+	[COLOR_H4]		=3D REG_FIELD(MP3326_PWM_DUTY_LSB_SET_CHANNEL2, 0, 3),
+	[COLOR_L8]		=3D REG_FIELD(MP3326_PWM_DUTY_MSB_SET_CHANNEL2, 0, 7),
+	[OPEN_FAULT]	=3D REG_FIELD(MP3326_PWM_OPEN_FAULT_CHANNEL_1_8, 1, 1),
+	[SHORT_FAULT]	=3D REG_FIELD(MP3326_PWM_SHORT_FAULT_CHANNEL_1_8, 1, 1),
+};
+
+static  struct reg_field channel3_reg_fields[] =3D {
+	[ENABLE]		=3D REG_FIELD(MP3326_PWM_CTRL_CHANNEL_1_8, 2, 2),
+	[BRIGHTNESS]	=3D REG_FIELD(MP3326_PWM_CURRENT_SET_CHANNEL3, 0, 5),
+	[COLOR_H4]		=3D REG_FIELD(MP3326_PWM_DUTY_LSB_SET_CHANNEL3, 0, 3),
+	[COLOR_L8]		=3D REG_FIELD(MP3326_PWM_DUTY_MSB_SET_CHANNEL3, 0, 7),
+	[OPEN_FAULT]	=3D REG_FIELD(MP3326_PWM_OPEN_FAULT_CHANNEL_1_8, 2, 2),
+	[SHORT_FAULT]	=3D REG_FIELD(MP3326_PWM_SHORT_FAULT_CHANNEL_1_8, 2, 2),
+};
+
+static  struct reg_field channel4_reg_fields[] =3D {
+	[ENABLE]		=3D REG_FIELD(MP3326_PWM_CTRL_CHANNEL_1_8, 3, 3),
+	[BRIGHTNESS]	=3D REG_FIELD(MP3326_PWM_CURRENT_SET_CHANNEL4, 0, 5),
+	[COLOR_H4]		=3D REG_FIELD(MP3326_PWM_DUTY_LSB_SET_CHANNEL4, 0, 3),
+	[COLOR_L8]		=3D REG_FIELD(MP3326_PWM_DUTY_MSB_SET_CHANNEL4, 0, 7),
+	[OPEN_FAULT]	=3D REG_FIELD(MP3326_PWM_OPEN_FAULT_CHANNEL_1_8, 3, 3),
+	[SHORT_FAULT]	=3D REG_FIELD(MP3326_PWM_SHORT_FAULT_CHANNEL_1_8, 3, 3),
+};
+
+static  struct reg_field channel5_reg_fields[] =3D {
+	[ENABLE]		=3D REG_FIELD(MP3326_PWM_CTRL_CHANNEL_1_8, 4, 4),
+	[BRIGHTNESS]	=3D REG_FIELD(MP3326_PWM_CURRENT_SET_CHANNEL5, 0, 5),
+	[COLOR_H4]		=3D REG_FIELD(MP3326_PWM_DUTY_LSB_SET_CHANNEL5, 0, 3),
+	[COLOR_L8]		=3D REG_FIELD(MP3326_PWM_DUTY_MSB_SET_CHANNEL5, 0, 7),
+	[OPEN_FAULT]	=3D REG_FIELD(MP3326_PWM_OPEN_FAULT_CHANNEL_1_8, 4, 4),
+	[SHORT_FAULT]	=3D REG_FIELD(MP3326_PWM_SHORT_FAULT_CHANNEL_1_8, 4, 4),
+};
+
+static  struct reg_field channel6_reg_fields[] =3D {
+	[ENABLE]		=3D REG_FIELD(MP3326_PWM_CTRL_CHANNEL_1_8, 5, 5),
+	[BRIGHTNESS]	=3D REG_FIELD(MP3326_PWM_CURRENT_SET_CHANNEL6, 0, 5),
+	[COLOR_H4]		=3D REG_FIELD(MP3326_PWM_DUTY_LSB_SET_CHANNEL6, 0, 3),
+	[COLOR_L8]		=3D REG_FIELD(MP3326_PWM_DUTY_MSB_SET_CHANNEL6, 0, 7),
+	[OPEN_FAULT]	=3D REG_FIELD(MP3326_PWM_OPEN_FAULT_CHANNEL_1_8, 5, 5),
+	[SHORT_FAULT]	=3D REG_FIELD(MP3326_PWM_SHORT_FAULT_CHANNEL_1_8, 5, 5),
+};
+
+static  struct reg_field channel7_reg_fields[] =3D {
+	[ENABLE]		=3D REG_FIELD(MP3326_PWM_CTRL_CHANNEL_1_8, 6, 6),
+	[BRIGHTNESS]	=3D REG_FIELD(MP3326_PWM_CURRENT_SET_CHANNEL7, 0, 5),
+	[COLOR_H4]		=3D REG_FIELD(MP3326_PWM_DUTY_LSB_SET_CHANNEL7, 0, 3),
+	[COLOR_L8]		=3D REG_FIELD(MP3326_PWM_DUTY_MSB_SET_CHANNEL7, 0, 7),
+	[OPEN_FAULT]	=3D REG_FIELD(MP3326_PWM_OPEN_FAULT_CHANNEL_1_8, 6, 6),
+	[SHORT_FAULT]	=3D REG_FIELD(MP3326_PWM_SHORT_FAULT_CHANNEL_1_8, 6, 6),
+};
+
+static  struct reg_field channel8_reg_fields[] =3D {
+	[ENABLE]		=3D REG_FIELD(MP3326_PWM_CTRL_CHANNEL_1_8, 7, 7),
+	[BRIGHTNESS]	=3D REG_FIELD(MP3326_PWM_CURRENT_SET_CHANNEL8, 0, 5),
+	[COLOR_H4]		=3D REG_FIELD(MP3326_PWM_DUTY_LSB_SET_CHANNEL8, 0, 3),
+	[COLOR_L8]		=3D REG_FIELD(MP3326_PWM_DUTY_MSB_SET_CHANNEL8, 0, 7),
+	[OPEN_FAULT]	=3D REG_FIELD(MP3326_PWM_OPEN_FAULT_CHANNEL_1_8, 7, 7),
+	[SHORT_FAULT]	=3D REG_FIELD(MP3326_PWM_SHORT_FAULT_CHANNEL_1_8, 7, 7),
+};
+
+static  struct reg_field channel9_reg_fields[] =3D {
+	[ENABLE]		=3D REG_FIELD(MP3326_PWM_CTRL_CHANNEL_9_16, 0, 0),
+	[BRIGHTNESS]	=3D REG_FIELD(MP3326_PWM_CURRENT_SET_CHANNEL9, 0, 5),
+	[COLOR_H4]		=3D REG_FIELD(MP3326_PWM_DUTY_LSB_SET_CHANNEL9, 0, 3),
+	[COLOR_L8]		=3D REG_FIELD(MP3326_PWM_DUTY_MSB_SET_CHANNEL9, 0, 7),
+	[OPEN_FAULT]	=3D REG_FIELD(MP3326_PWM_OPEN_FAULT_CHANNEL_9_16, 0, 0),
+	[SHORT_FAULT]	=3D REG_FIELD(MP3326_PWM_SHORT_FAULT_CHANNEL_9_16, 0, 0),
+};
+
+static  struct reg_field channel10_reg_fields[] =3D {
+	[ENABLE]		=3D REG_FIELD(MP3326_PWM_CTRL_CHANNEL_9_16, 1, 1),
+	[BRIGHTNESS]	=3D REG_FIELD(MP3326_PWM_CURRENT_SET_CHANNEL10, 0, 5),
+	[COLOR_H4]		=3D REG_FIELD(MP3326_PWM_DUTY_LSB_SET_CHANNEL10, 0, 3),
+	[COLOR_L8]		=3D REG_FIELD(MP3326_PWM_DUTY_MSB_SET_CHANNEL10, 0, 7),
+	[OPEN_FAULT]	=3D REG_FIELD(MP3326_PWM_OPEN_FAULT_CHANNEL_9_16, 1, 1),
+	[SHORT_FAULT]	=3D REG_FIELD(MP3326_PWM_SHORT_FAULT_CHANNEL_9_16, 1, 1),
+};
+
+static  struct reg_field channel11_reg_fields[] =3D {
+	[ENABLE]		=3D REG_FIELD(MP3326_PWM_CTRL_CHANNEL_9_16, 2, 2),
+	[BRIGHTNESS]	=3D REG_FIELD(MP3326_PWM_CURRENT_SET_CHANNEL11, 0, 5),
+	[COLOR_H4]		=3D REG_FIELD(MP3326_PWM_DUTY_LSB_SET_CHANNEL11, 0, 3),
+	[COLOR_L8]		=3D REG_FIELD(MP3326_PWM_DUTY_MSB_SET_CHANNEL11, 0, 7),
+	[OPEN_FAULT]	=3D REG_FIELD(MP3326_PWM_OPEN_FAULT_CHANNEL_9_16, 2, 2),
+	[SHORT_FAULT]	=3D REG_FIELD(MP3326_PWM_SHORT_FAULT_CHANNEL_9_16, 2, 2),
+};
+
+static  struct reg_field channel12_reg_fields[] =3D {
+	[ENABLE]		=3D REG_FIELD(MP3326_PWM_CTRL_CHANNEL_9_16, 3, 3),
+	[BRIGHTNESS]	=3D REG_FIELD(MP3326_PWM_CURRENT_SET_CHANNEL12, 0, 5),
+	[COLOR_H4]		=3D REG_FIELD(MP3326_PWM_DUTY_LSB_SET_CHANNEL12, 0, 3),
+	[COLOR_L8]		=3D REG_FIELD(MP3326_PWM_DUTY_MSB_SET_CHANNEL12, 0, 7),
+	[OPEN_FAULT]	=3D REG_FIELD(MP3326_PWM_OPEN_FAULT_CHANNEL_9_16, 3, 3),
+	[SHORT_FAULT]	=3D REG_FIELD(MP3326_PWM_SHORT_FAULT_CHANNEL_9_16, 3, 3),
+};
+
+static  struct reg_field channel13_reg_fields[] =3D {
+	[ENABLE]		=3D REG_FIELD(MP3326_PWM_CTRL_CHANNEL_9_16, 4, 4),
+	[BRIGHTNESS]	=3D REG_FIELD(MP3326_PWM_CURRENT_SET_CHANNEL13, 0, 5),
+	[COLOR_H4]		=3D REG_FIELD(MP3326_PWM_DUTY_LSB_SET_CHANNEL13, 0, 3),
+	[COLOR_L8]		=3D REG_FIELD(MP3326_PWM_DUTY_MSB_SET_CHANNEL13, 0, 7),
+	[OPEN_FAULT]	=3D REG_FIELD(MP3326_PWM_OPEN_FAULT_CHANNEL_9_16, 4, 4),
+	[SHORT_FAULT]	=3D REG_FIELD(MP3326_PWM_SHORT_FAULT_CHANNEL_9_16, 4, 4),
+};
+
+static  struct reg_field channel14_reg_fields[] =3D {
+	[ENABLE]		=3D REG_FIELD(MP3326_PWM_CTRL_CHANNEL_9_16, 5, 5),
+	[BRIGHTNESS]	=3D REG_FIELD(MP3326_PWM_CURRENT_SET_CHANNEL14, 0, 5),
+	[COLOR_H4]		=3D REG_FIELD(MP3326_PWM_DUTY_LSB_SET_CHANNEL14, 0, 3),
+	[COLOR_L8]		=3D REG_FIELD(MP3326_PWM_DUTY_MSB_SET_CHANNEL14, 0, 7),
+	[OPEN_FAULT]	=3D REG_FIELD(MP3326_PWM_OPEN_FAULT_CHANNEL_9_16, 5, 5),
+	[SHORT_FAULT]	=3D REG_FIELD(MP3326_PWM_SHORT_FAULT_CHANNEL_9_16, 5, 5),
+};
+
+static  struct reg_field channel15_reg_fields[] =3D {
+	[ENABLE]		=3D REG_FIELD(MP3326_PWM_CTRL_CHANNEL_9_16, 6, 6),
+	[BRIGHTNESS]	=3D REG_FIELD(MP3326_PWM_CURRENT_SET_CHANNEL15, 0, 5),
+	[COLOR_H4]		=3D REG_FIELD(MP3326_PWM_DUTY_LSB_SET_CHANNEL15, 0, 3),
+	[COLOR_L8]		=3D REG_FIELD(MP3326_PWM_DUTY_MSB_SET_CHANNEL15, 0, 7),
+	[OPEN_FAULT]	=3D REG_FIELD(MP3326_PWM_OPEN_FAULT_CHANNEL_9_16, 6, 6),
+	[SHORT_FAULT]	=3D REG_FIELD(MP3326_PWM_SHORT_FAULT_CHANNEL_9_16, 6, 6),
+};
+
+static  struct reg_field channel16_reg_fields[] =3D {
+	[ENABLE]		=3D REG_FIELD(MP3326_PWM_CTRL_CHANNEL_9_16, 7, 7),
+	[BRIGHTNESS]	=3D REG_FIELD(MP3326_PWM_CURRENT_SET_CHANNEL16, 0, 5),
+	[COLOR_H4]		=3D REG_FIELD(MP3326_PWM_DUTY_LSB_SET_CHANNEL16, 0, 3),
+	[COLOR_L8]		=3D REG_FIELD(MP3326_PWM_DUTY_MSB_SET_CHANNEL16, 0, 7),
+	[OPEN_FAULT]	=3D REG_FIELD(MP3326_PWM_OPEN_FAULT_CHANNEL_9_16, 7, 7),
+	[SHORT_FAULT]	=3D REG_FIELD(MP3326_PWM_SHORT_FAULT_CHANNEL_9_16, 7, 7),
+};
+
+static const struct MP3326_reg_field MP3266_reg_fields[] =3D {
+	[Channel1] =3D MP3326_REG_FIELD(channel1),
+	[Channel2] =3D MP3326_REG_FIELD(channel2),
+	[Channel3] =3D MP3326_REG_FIELD(channel3),
+	[Channel4] =3D MP3326_REG_FIELD(channel4),
+	[Channel5] =3D MP3326_REG_FIELD(channel5),
+	[Channel6] =3D MP3326_REG_FIELD(channel6),
+	[Channel7] =3D MP3326_REG_FIELD(channel7),
+	[Channel8] =3D MP3326_REG_FIELD(channel8),
+	[Channel9] =3D MP3326_REG_FIELD(channel9),
+	[Channel10] =3D MP3326_REG_FIELD(channel10),
+	[Channel11] =3D MP3326_REG_FIELD(channel11),
+	[Channel12] =3D MP3326_REG_FIELD(channel12),
+	[Channel13] =3D MP3326_REG_FIELD(channel13),
+	[Channel14] =3D MP3326_REG_FIELD(channel14),
+	[Channel15] =3D MP3326_REG_FIELD(channel15),
+	[Channel16] =3D MP3326_REG_FIELD(channel16),
+};
+
+struct RGB {
+struct led_classdev cdev;
+struct MP3326_Led *chip;
+int red;
+int green;
+int blue;
+int AnalogDim;
+int PWMDim;
+bool IsAlive;
+};
+
+static const struct regmap_config MP3326_regmap_config =3D {
+.reg_bits =3D 8,
+.val_bits =3D 8,
+};
+
+struct ChannelField {
+	struct regmap_field *regmap_fields[Max_CTRL];
+};
+
+struct MP3326_Led {
+struct i2c_client *client;
+struct regmap *regmap;
+struct ChannelField *channel_fields[Max_Channel];
+struct mutex mutex;
+u32 num_rgbs;
+struct  RGB rgbs[];
+};
+
+/*
+ *	Set the brightness.
+ */
+static int MP3326_led_set(struct led_classdev *led_cdev,
+			   enum led_brightness value)
+{
+	struct RGB *led =3D container_of(led_cdev, struct RGB, cdev);
+	struct MP3326_Led *chip =3D led->chip;
+	int ret;
+
+	if (value > 63)
+		led->AnalogDim =3D 63;
+	else
+		led->AnalogDim =3D value;
+
+	ret =3D regmap_field_write(chip->channel_fields[led->red]->regmap_fields[=
BRIGHTNESS], led->AnalogDim);
+	if (ret)
+		return -EINVAL;
+
+	ret =3D regmap_field_write(chip->channel_fields[led->green]->regmap_field=
s[BRIGHTNESS], led->AnalogDim);
+	if (ret)
+		return -EINVAL;
+
+	ret =3D regmap_field_write(chip->channel_fields[led->blue]->regmap_fields=
[BRIGHTNESS], led->AnalogDim);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Show the current pwm dim value which is decimal.
+ */
+static ssize_t pwm_Dim_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct led_classdev *cdev =3D dev_get_drvdata(dev);
+	struct RGB *led =3D container_of(cdev, struct RGB, cdev);
+	struct MP3326_Led *chip =3D led->chip;
+	unsigned int val;
+	int rval =3D 0, gval =3D 0, bval =3D 0;
+
+	regmap_field_read(chip->channel_fields[led->red]->regmap_fields[COLOR_L8]=
, &val);
+	rval |=3D val << 4;
+	regmap_field_read(chip->channel_fields[led->red]->regmap_fields[COLOR_H4]=
, &val);
+	rval |=3D val;
+	val =3D 0;
+	regmap_field_read(chip->channel_fields[led->green]->regmap_fields[COLOR_L=
8], &val);
+	gval |=3D val << 4;
+	regmap_field_read(chip->channel_fields[led->green]->regmap_fields[COLOR_H=
4], &val);
+	gval |=3D val;
+	val =3D 0;
+	regmap_field_read(chip->channel_fields[led->blue]->regmap_fields[COLOR_L8=
], &val);
+	bval |=3D val << 4;
+	regmap_field_read(chip->channel_fields[led->blue]->regmap_fields[COLOR_H4=
], &val);
+	bval |=3D val;
+
+	rval =3D rval * 255 / 4095 + ((rval * 255) % 4095 > 2047 ? 1 : 0);
+	gval =3D gval * 255 / 4095 + ((gval * 255) % 4095 > 2047 ? 1 : 0);
+	bval =3D bval * 255 / 4095 + ((bval * 255) % 4095 > 2047 ? 1 : 0);
+
+
+	return  sysfs_emit(buf, "%d %d %d\n", rval, gval, bval);
+}
+
+/*
+ * PWM dimming, here are two input ways.
+ * The first: Input '200 200 200' which sequence is red green blue and dec=
imal.
+ * The Second: Input 'H 0f 0f 0f' which sequence is red green blue and Hex=
.
+ */
+static ssize_t pwm_Dim_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t count)
+{
+	struct led_classdev *cdev =3D dev_get_drvdata(dev);
+	struct RGB *led =3D container_of(cdev, struct RGB, cdev);
+	struct  MP3326_Led *chip =3D led->chip;
+	ssize_t ret;
+	int r_val, g_val, b_val;
+
+	ret =3D sscanf(buf, "%d %d %d", &r_val, &g_val, &b_val);
+	if (ret !=3D 3) {
+		ret =3D sscanf(buf, "H %x %x %x", &r_val, &g_val, &b_val);
+		if (ret !=3D 3)
+			return ret;
+	}
+	r_val =3D r_val * 4095 / 255 + ((r_val * 4095) % 255 > 127 ? 1 : 0);
+	g_val =3D g_val * 4095 / 255 + ((g_val * 4095) % 255 > 127 ? 1 : 0);
+	b_val =3D b_val * 4095 / 255 + ((b_val * 4095) % 255 > 127 ? 1 : 0);
+
+	ret =3D regmap_field_write(chip->channel_fields[led->red]->regmap_fields[=
COLOR_H4], r_val & 0x0f);
+	ret =3D regmap_field_write(chip->channel_fields[led->red]->regmap_fields[=
COLOR_L8], r_val >> 4);
+	ret =3D regmap_field_write(chip->channel_fields[led->green]->regmap_field=
s[COLOR_H4], g_val & 0x0f);
+	ret =3D regmap_field_write(chip->channel_fields[led->green]->regmap_field=
s[COLOR_L8], g_val >> 4);
+	ret =3D regmap_field_write(chip->channel_fields[led->blue]->regmap_fields=
[COLOR_H4], b_val & 0x0f);
+	ret =3D regmap_field_write(chip->channel_fields[led->blue]->regmap_fields=
[COLOR_L8], b_val >> 4);
+
+	if (ret)
+		return -EINVAL;
+	return count;
+}
+
+/*
+ *Show an integer which indicates current brightness.
+ */
+static ssize_t analog_Dim_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct led_classdev *cdev =3D dev_get_drvdata(dev);
+	struct RGB *led =3D container_of(cdev, struct RGB, cdev);
+	struct  MP3326_Led *chip =3D led->chip;
+	unsigned int val;
+
+	regmap_field_read(chip->channel_fields[led->red]->regmap_fields[BRIGHTNES=
S], &val);
+
+	return  sysfs_emit(buf, "%u\n", val);
+}
+/*
+ * Input an integer value which changes the brightness.
+ * The integer is range from 0 to 63
+ */
+static ssize_t analog_Dim_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t count)
+{
+	struct led_classdev *cdev =3D dev_get_drvdata(dev);
+	struct RGB *led =3D container_of(cdev, struct RGB, cdev);
+	struct  MP3326_Led *chip =3D led->chip;
+	ssize_t ret;
+	long long_val;
+
+	ret =3D kstrtol(buf, 10, &long_val);
+	if (long_val < 0)
+		return -EINVAL;
+	if (long_val > cdev->max_brightness) {
+		led->AnalogDim =3D cdev->max_brightness;
+		cdev->brightness =3D cdev->max_brightness;
+	} else {
+		led->AnalogDim =3D long_val;
+		cdev->brightness =3D long_val;
+	}
+
+	ret =3D regmap_field_write(chip->channel_fields[led->red]->regmap_fields[=
BRIGHTNESS], led->AnalogDim);
+	if (ret)
+		return -EINVAL;
+
+	ret =3D regmap_field_write(chip->channel_fields[led->green]->regmap_field=
s[BRIGHTNESS], led->AnalogDim);
+	if (ret)
+		return -EINVAL;
+
+	ret =3D regmap_field_write(chip->channel_fields[led->blue]->regmap_fields=
[BRIGHTNESS], led->AnalogDim);
+	if (ret)
+		return -EINVAL;
+	return count;
+}
+
+/*
+ * Show a string which indicates enable all channels of rgb.
+ * True  indicates all channels of rgb enable.
+ * False indicates all channels of rgb disable.
+ */
+static ssize_t rgb_enable_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct led_classdev *cdev =3D dev_get_drvdata(dev);
+	struct RGB *led =3D container_of(cdev, struct RGB, cdev);
+	struct  MP3326_Led *chip =3D led->chip;
+	unsigned int rval =3D 0, val;
+
+	regmap_field_read(chip->channel_fields[led->red]->regmap_fields[ENABLE], =
&val);
+	rval |=3D val;
+	regmap_field_read(chip->channel_fields[led->green]->regmap_fields[ENABLE]=
, &val);
+	rval |=3D val;
+	regmap_field_read(chip->channel_fields[led->blue]->regmap_fields[ENABLE],=
 &val);
+	rval |=3D val;
+	regmap_read(chip->regmap, 0x05, &val);
+	if (rval)
+		return  sysfs_emit(buf, "%s\n", "True");
+
+	return  sysfs_emit(buf, "%s\n", "False");
+}
+
+/*
+ * Input 1 or 0 to control the channels of rgb enable/disable.
+ * If input 1, the channels of rgb is enable
+ * If input 0, the channels of rgb is disable
+ */
+static ssize_t rgb_enable_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t count)
+{
+	struct led_classdev *cdev =3D dev_get_drvdata(dev);
+	struct RGB *led =3D container_of(cdev, struct RGB, cdev);
+	struct  MP3326_Led *chip =3D led->chip;
+	ssize_t ret;
+	long long_val;
+
+	ret =3D kstrtol(buf, 10, &long_val);
+	if (long_val) {
+		ret =3D regmap_field_write(chip->channel_fields[led->red]->regmap_fields=
[BRIGHTNESS], led->AnalogDim);
+		if (ret)
+			return -EINVAL;
+
+		ret =3D regmap_field_write(chip->channel_fields[led->green]->regmap_fiel=
ds[BRIGHTNESS], led->AnalogDim);
+		if (ret)
+			return -EINVAL;
+
+		ret =3D regmap_field_write(chip->channel_fields[led->blue]->regmap_field=
s[BRIGHTNESS], led->AnalogDim);
+		if (ret)
+			return -EINVAL;
+
+
+		ret =3D regmap_field_write(chip->channel_fields[led->red]->regmap_fields=
[ENABLE], long_val);
+		if (ret)
+			return -EINVAL;
+
+		ret =3D regmap_field_write(chip->channel_fields[led->green]->regmap_fiel=
ds[ENABLE], long_val);
+		if (ret)
+			return -EINVAL;
+
+		ret =3D regmap_field_write(chip->channel_fields[led->blue]->regmap_field=
s[ENABLE], long_val);
+		if (ret)
+			return -EINVAL;
+
+		led->IsAlive =3D true;
+	} else {
+		ret =3D regmap_field_write(chip->channel_fields[led->red]->regmap_fields=
[ENABLE], long_val);
+		if (ret)
+			return -EINVAL;
+
+
+		ret =3D regmap_field_write(chip->channel_fields[led->green]->regmap_fiel=
ds[ENABLE], long_val);
+		if (ret)
+			return -EINVAL;
+
+		ret =3D regmap_field_write(chip->channel_fields[led->blue]->regmap_field=
s[ENABLE], long_val);
+		if (ret)
+			return -EINVAL;
+
+		led->IsAlive =3D false;
+	}
+
+	return count;
+}
+
+/*
+ * Show a string which indicates short fault of rgb.
+ * True  indicates the rgb has a short fault.
+ * False indicates the rgb is normal.
+ */
+static ssize_t short_fault_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct led_classdev *cdev =3D dev_get_drvdata(dev);
+	struct RGB *led =3D container_of(cdev, struct RGB, cdev);
+	struct  MP3326_Led *chip =3D led->chip;
+	unsigned int rval =3D 0, val;
+
+	regmap_field_read(chip->channel_fields[led->red]->regmap_fields[SHORT_FAU=
LT], &val);
+	rval |=3D val;
+	regmap_field_read(chip->channel_fields[led->green]->regmap_fields[SHORT_F=
AULT], &val);
+	rval |=3D val;
+	regmap_field_read(chip->channel_fields[led->blue]->regmap_fields[SHORT_FA=
ULT], &val);
+	rval |=3D val;
+	if (rval)
+		return  sysfs_emit(buf, "%s\n", "True");
+
+	return  sysfs_emit(buf, "%s\n", "False");
+}
+
+/*
+ * Show a string which indicates open load fault of rgb.
+ * True  indicates the rgb has an open load fault.
+ * False indicates the rgb is normal.
+ */
+static ssize_t open_fault_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct led_classdev *cdev =3D dev_get_drvdata(dev);
+	struct RGB *led =3D container_of(cdev, struct RGB, cdev);
+	struct  MP3326_Led *chip =3D led->chip;
+	unsigned int rval =3D 0, val;
+
+	regmap_field_read(chip->channel_fields[led->red]->regmap_fields[OPEN_FAUL=
T], &val);
+	rval |=3D val;
+	regmap_field_read(chip->channel_fields[led->green]->regmap_fields[OPEN_FA=
ULT], &val);
+	rval |=3D val;
+	regmap_field_read(chip->channel_fields[led->blue]->regmap_fields[OPEN_FAU=
LT], &val);
+	rval |=3D val;
+
+	if (rval)
+		return  sysfs_emit(buf, "%s\n", "True");
+
+	return  sysfs_emit(buf, "%s\n", "False");
+}
+
+
+static DEVICE_ATTR_RW(rgb_enable);
+static DEVICE_ATTR_RW(pwm_Dim);
+static DEVICE_ATTR_RW(analog_Dim);
+static DEVICE_ATTR_RO(open_fault);
+static DEVICE_ATTR_RO(short_fault);
+static struct attribute *MP3266_led_sysfs_attrs[] =3D {
+	&dev_attr_rgb_enable.attr,
+	&dev_attr_pwm_Dim.attr,
+	&dev_attr_analog_Dim.attr,
+	&dev_attr_open_fault.attr,
+	&dev_attr_short_fault.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(MP3266_led_sysfs);
+
+static int MP3266_probe_fw(struct device *dev, struct MP3326_Led *chip)
+{
+	struct fwnode_handle *child;
+	int ret;
+	int i;
+
+	device_for_each_child_node(dev, child) {
+		struct RGB *rgb;
+		struct led_init_data  init_data =3D {};
+		u32 source, Red =3D 0, Green, Blue;
+
+		ret =3D fwnode_property_read_u32(child, "rgb_r", &Red);
+		if (ret) {
+			dev_err(dev, "Missing rgb_r property\n");
+			chip->num_rgbs--;
+			continue;
+		}
+
+		if (Red <=3D 0 || Red > Max_Channel) {
+			dev_err(dev, "LED reg %u out of range (max %u)(min 1)\n",
+					Red, Max_Channel);
+			chip->num_rgbs--;
+			continue;
+		}
+
+		ret =3D fwnode_property_read_u32(child, "rgb_g", &Green);
+
+		if (ret) {
+			dev_err(dev, "Missing rgb_g property\n");
+			chip->num_rgbs--;
+			continue;
+	}
+
+	if (Green <=3D 0 || Green > Max_Channel) {
+		dev_err(dev, "LED reg %u out of range (max %u)(min 1)\n",
+				Green, Max_Channel);
+		chip->num_rgbs--;
+		continue;
+	}
+
+	ret =3D fwnode_property_read_u32(child, "rgb_b", &Blue);
+
+	if (ret) {
+		dev_err(dev, "Missing rgb_b property\n");
+		chip->num_rgbs--;
+		continue;
+	}
+
+	if (Blue <=3D 0 || Blue > Max_Channel) {
+		dev_err(dev, "LED reg %u out of range (max %u)(min 1)\n",
+				Blue, Max_Channel);
+		chip->num_rgbs--;
+		continue;
+	}
+
+	ret =3D fwnode_property_read_u32(child, "brightness", &source);
+
+	if (ret) {
+		dev_err(dev, "Missing brightness property\n");
+		chip->num_rgbs--;
+		continue;
+	}
+
+	if (source < 0) {
+		dev_err(dev, "Brightness: %u must be greater than 0\n",
+				source);
+		chip->num_rgbs--;
+		continue;
+	} else if (source > 63) {
+		source =3D 63;
+	}
+	rgb =3D &chip->rgbs[i];
+	rgb->chip =3D chip;
+	rgb->red =3D Red-1;
+	rgb->green =3D Green-1;
+	rgb->blue =3D Blue-1;
+	rgb->AnalogDim =3D source;
+
+	rgb->cdev.groups =3D MP3266_led_sysfs_groups;
+	rgb->cdev.brightness_set_blocking =3D MP3326_led_set;
+	rgb->cdev.brightness =3D source;
+	rgb->cdev.max_brightness =3D 63;
+	init_data.fwnode =3D child;
+
+	ret =3D devm_led_classdev_register_ext(dev, &rgb->cdev,
+						     &init_data);
+	if (ret) {
+		fwnode_handle_put(child);
+		break;
+	}
+	i++;
+	ret =3D regmap_field_write(chip->channel_fields[rgb->red]->regmap_fields[=
BRIGHTNESS], source);
+	ret =3D regmap_field_write(chip->channel_fields[rgb->green]->regmap_field=
s[BRIGHTNESS], source);
+	ret =3D regmap_field_write(chip->channel_fields[rgb->blue]->regmap_fields=
[BRIGHTNESS], source);
+	}
+	if (!chip->num_rgbs)
+		return -EINVAL;
+	return 0;
+}
+
+static int MP3326_leds_probe(struct i2c_client *client, const struct i2c_d=
evice_id *id)
+{
+	struct MP3326_Led *chip;
+	struct ChannelField *channel;
+	struct device_node *np =3D client->dev.of_node;
+	int ret, count, source;
+	int i, j;
+
+	count =3D device_get_child_node_count(&client->dev);
+	if (!count || count > 5) {
+		return dev_err_probe(&client->dev, -EINVAL,
+				"Incorrect number of rgbs (%d)", count);
+	}
+
+	chip =3D devm_kzalloc(&client->dev, struct_size(chip, rgbs, count), GFP_K=
ERNEL);
+	if (!chip)
+		return -ENOMEM;
+	channel =3D devm_kzalloc(&client->dev, sizeof(struct ChannelField) * Max_=
Channel, GFP_KERNEL);
+	if (!channel)
+		return -ENOMEM;
+
+	chip->client =3D client;
+	chip->num_rgbs =3D count;
+
+	i2c_set_clientdata(client, chip);
+	chip->regmap =3D devm_regmap_init_i2c(client, &MP3326_regmap_config);
+	if (IS_ERR(chip->regmap))
+		return PTR_ERR(chip->regmap);
+
+
+	for (i =3D 0; i < Max_Channel; i++) {
+		for (j =3D 0; j < Max_CTRL; j++) {
+			channel[i].regmap_fields[j] =3D devm_regmap_field_alloc(&client->dev,
+			chip->regmap, MP3266_reg_fields[i].regmap_fields[j]);
+
+			if (IS_ERR(channel[i].regmap_fields[j])) {
+				dev_err(&client->dev, "regmap field alloc fail %d\n", i);
+				return PTR_ERR(channel[i].regmap_fields[j]);
+			}
+		}
+		chip->channel_fields[i] =3D &channel[i];
+		channel++;
+	}
+
+	if (IS_ERR(chip->channel_fields))
+		return PTR_ERR(chip->channel_fields);
+
+	ret =3D of_property_read_u32(np, "led-protect", &source);
+	if (!ret)
+		ret =3D regmap_update_bits(chip->regmap, 0x01, BIT(4) | BIT(5), source<<=
4);
+
+	ret =3D of_property_read_u32(np, "switch_status", &source);
+	if (ret)
+		regmap_update_bits(chip->regmap, 0x01, BIT(0), 0);
+	else
+		regmap_update_bits(chip->regmap, 0x01, BIT(0), source);
+
+	/*close all channel*/
+	regmap_write(chip->regmap, MP3326_PWM_CTRL_CHANNEL_9_16, 0);
+	regmap_write(chip->regmap, MP3326_PWM_CTRL_CHANNEL_1_8, 0);
+	mutex_init(&chip->mutex);
+	mutex_lock(&chip->mutex);
+
+	ret =3D MP3266_probe_fw(&client->dev, chip);
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static int MP3326_leds_remove(struct i2c_client *client)
+{
+	return 0;
+}
+
+static const struct i2c_device_id MP3326_led_id[] =3D {
+	{"MP3326", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, MP3326_led_id);
+
+static const struct of_device_id MP3326_led_of_match[] =3D {
+	{ .compatible =3D "mps,MP3326" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, MP3326_led_of_match);
+
+static struct i2c_driver MP3326_leds_driver =3D {
+	.probe =3D MP3326_leds_probe,
+	.remove =3D MP3326_leds_remove,
+	.driver =3D {
+		.owner =3D THIS_MODULE,
+		.name =3D "MP3326_led",
+		.of_match_table =3D MP3326_led_of_match,
+		},
+
+	.id_table =3D MP3326_led_id,
+};
+
+module_i2c_driver(MP3326_leds_driver);
+
+MODULE_AUTHOR("Yuxi Wang <Yuxi.Wang@monolithicpower.com>");
+MODULE_DESCRIPTION("MP3326 Led driver");
+MODULE_LICENSE("GPL");
--=20
2.25.1


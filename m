Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BF57FE153
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjK2Us3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjK2Us1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:48:27 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2034.outbound.protection.outlook.com [40.92.22.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4A910C8;
        Wed, 29 Nov 2023 12:48:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+aBNHhCiMExMCm1IPphd0W7SBYWFAbSoqCcNrNCQbazVttc21CT4nqYAUqlxBeIPvD5ya5EvrPg7Oe8vCBNTxRS4QZDXYIkzKUs6QuJoYG4k9YkgiOcRYUMh4yRxUpTmMtiHsxCw3ZOWWAsnYGwpHnpZ+gStiEA2sOIHI+Ny4Z5ow5thQtTTLWEzz1m9gOeqVpp5u9MsHYyiEbm72lVeKHBeMJ1wVojW+ugX7lag205cDg5piV424fmPtETLLQOG8GaY5nmNhz/penWLDw0BaSEt+NRAFlNWw/T+yIiqrSSlr8N5PB4hkBpVSzasGYkD4ixrCkzsKJF3LQWU3smbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVNz2xM0bQwMV2GkOmeCI5gIzGNY7AzaUjJLGEmqnig=;
 b=IgyTmde1JGjAnYE2DaXgMH/D70StYtbZe5NTnsbVS4OzKy9Vz+2ahrjN1IJ/5FP7Kbv9LWSV+zx1X0qpjK3Ae4s/s/ynJ0tchGB3bM+BlBwCiQ92x4owIybzHeUTFPN9mobxz7ldMyfmXuducFf5e1bFI8NF6AcLXq6X6XTkfbKifx9q9xh7E6cK3Fp4OjRAcQN2YKgv+ZRoKo1rOC3t9rBhqYjwnGQrAUrV8VTjDjHyXjFjqv56jYCvMRFkR1VmtkWS/yE6fPEzUqDhd8eHXXGbcEcZ5303R8cQavXksylEk7pQbRQbZqMJw9v2ZIwKoPlBJI3wjfkMZeE/lSHImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVNz2xM0bQwMV2GkOmeCI5gIzGNY7AzaUjJLGEmqnig=;
 b=gJHP46NRpI1KnQpkdiPJ0vL+5cP9vyWTn1Nxe4SEJCcDJbNr8R1kNs0cPVbG0bQ1Tw13XFiP9vCgbsdLyMuF4y6Ztuh89XGKg7YXsdUmbLbp6lAYkkQ/aWtA/1wYJZo77L4LNfrYAWjdby8nOjQ4MbNX5KhCGLLLUbelCR9NBfkMENF7SOQuuxXnRTz4Ng+i5Vi4AL7Vn9i1BAhPZl4+5XbEaIHpxA2McAGT7pL3RT1pQ3RN9Tn5ZN42AuNexiThwQ1HT7GThFnD3TmYh3RHWG+GIFSOYwE2KeYAyORCkET+vreL0s0x4WaorkNuEs6Q247vFUJ4ao9jgF5euqIhTQ==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by SJ0PR03MB5808.namprd03.prod.outlook.com (2603:10b6:a03:2dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 20:48:23 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 20:48:23 +0000
From:   Min Li <lnimi@hotmail.com>
To:     richardcochran@gmail.com, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v2 2/2] ptp: add FemtoClock3 Wireless as ptp hardware clock
Date:   Wed, 29 Nov 2023 15:48:06 -0500
Message-ID: <PH7PR03MB7064FC8C284D83E9C34B8C08A083A@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231129204806.14539-1-lnimi@hotmail.com>
References: <20231129204806.14539-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [S0NFmF46h/VmGaNYE+pv/TGN4hWN8y0j]
X-ClientProxiedBy: YQBPR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::36) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20231129204806.14539-2-lnimi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|SJ0PR03MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: d57b9436-1a1e-4c3d-0298-08dbf11c86ce
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HYoC7Fx+GD0DE4QR5H9krH1J9uAk7yf44aPPvl7xmAfVBfzoY415GdeTAvG4DmGtzAeSKpvXYjTdwDdcRuupivnVvtWrhFSMvp3abX4a0qbp7J0IvfIbUazpXt1X3xc6gZFvoWm/La1gDiHi5S5V5Nx2BUxR8iepB206LyMMHuDxdppcglgd+2BVeY7gK0usCN24csjTGv6ieCOK03q0tqZ7XElUdAm5MeinERlwNB1F8yB7Kl8hnKJWNcFIuvKpvdjbQ6+SwCKXo+JyJBkYk4UuxlYkFkU56+LfJXJZhbrmM6e/AZut71XFSh+nff1D7DWA5hFy1R6d62MWJxVA+vZSmV6ji6BrmHFE35nyivrEzrdzIJPCzeQtop9SxChejRJh44gKuJP4JBJ1pUlJkU6X6HYLrek+9eVeQW6YSyU+vNu8G8kErERJTDSPlJx9p5lHRwebrUV0QUgPSLhnglUAJiYB7HmCKxuhsGC+kzw5J0CXB18jcMiSPAIcOMRHr+c4uJYw01a+Q8SnLjP/tm9Ium/kL3BL42Hawm3HjvECr25XF0mcbkFOxYJWB43I
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3oTCRNQNOr3DjU/vLepqXMsantjbBUz0/1xO8VjKEoNNLQ6zp0SJeL+Tean4?=
 =?us-ascii?Q?/ElvbgoEeJARVQRA4yJndf9WzP4TSaRHOHlKcannzstJgTwMZA0x1fDp5e1G?=
 =?us-ascii?Q?4GltQi1GRe9svwLUWhiB2bquwvrd5stV22aCNkpG6E/xaTBTxRozJ7VMnras?=
 =?us-ascii?Q?4nYvpG51xoI1cNvUCv5ejd3zN4gfYNHJDhLeySD1jq+PLRRXm/niMKAaL4+M?=
 =?us-ascii?Q?dMtCYo4i+YzWWj55EepyoPKlV/A0uqiFlS6cIkZPQPKJsTFEA5UQtU7HPOvI?=
 =?us-ascii?Q?aDSJ9J1FW7+oI8FL+3Bv4xA+Wro8ScGSkqCObyrG3xCpWn0Zdd5ZqZxpnCVb?=
 =?us-ascii?Q?2b7ks28eaZqR+sjwvq7YkvCl71cuPVeY1pH6HXzWMug4x+KYeWbVVqwiRGNa?=
 =?us-ascii?Q?AFIFbWUoEbSBk8+POx5Io+C54gnPy97xE2KfyEwjBEvA4xBuRn64MHr3CA1h?=
 =?us-ascii?Q?IgSPE4+JiPf2FRBLPPrSWMCzZVXmYg4i7NEHHDX1DENAmgvXHhXCpikJFpvD?=
 =?us-ascii?Q?9X2g4qWVrv3rdeFEHzvaZjdEHXaNsAq2FO27290DKchQQkZ4IM+TmlCSUEWD?=
 =?us-ascii?Q?cXcQt4plglBBscZ0lyGwdRRk1DUqJkFRU+nQvZepiAREQ/XTVJf6YGf93vwx?=
 =?us-ascii?Q?KwA1Fo4Bu8OrrLS+wHT4+h2BqSeCmbeeVhK8/aRKfn2kAWwOXvX3SoHwyr5Q?=
 =?us-ascii?Q?SwK0dEY08lv0mIYz08BDI6J9BZYM7/H/QnSXZdGz60kK5WZWpewmDLJPegJ6?=
 =?us-ascii?Q?FM5q7jegMB1OhJF+TbZ5yyOwjTnUvlLqXLrp7wkRIQf2FQHWkJpQcSB8mzkC?=
 =?us-ascii?Q?39QvcdaGL9D1jrbHM5yzLBFzFCpxI3DTCu0gBuioW564yF8gXRtoSaU87nzz?=
 =?us-ascii?Q?sdhlzaSVB1/3++fFTOGcJNDv10LUapp6lkGCuo4i2AxH+7sm+WD3ZjYKqDgx?=
 =?us-ascii?Q?3NUN39f8y/tvCNX75DMnd/hFE4xXelf2jEZbE6R58HU0qZ88a/HFHAgWfLjK?=
 =?us-ascii?Q?C5APbOxudlPYHfDP7AqiY85IJr2HHctXPfVWM12Twp5D8KFM4LIRHzqexcrn?=
 =?us-ascii?Q?Ix+chTafMk6Pn0XsbNsCH1T9fCSx1pA7fEijIqnSvwJKaoFFvnDqJ5+/NhQW?=
 =?us-ascii?Q?WwRckVS1EO3istCKsvLt1WKNsln70iJQZhWu0kJKi7q8g76dYCw8JZMry8Pe?=
 =?us-ascii?Q?AeVj5GKsEPA2S8+SxJ9CKZGFnz6Lm8W2+Lc8Rw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d57b9436-1a1e-4c3d-0298-08dbf11c86ce
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 20:48:23.1427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5808
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Li <min.li.xe@renesas.com>

The RENESAS FemtoClock3 Wireless is a high-performance jitter attenuator,
frequency translator, and clock synthesizer. The device is comprised of 3
digital PLLs (DPLL) to track CLKIN inputs and three independent low phase
noise fractional output dividers (FOD) that output low phase noise clocks.

FemtoClock3 supports one Time Synchronization (Time Sync) channel to enable
an external processor to control the phase and frequency of the Time Sync
channel and to take phase measurements using the TDC. Intended applications
are synchronization using the precision time protocol (PTP) and
synchronization with 0.5 Hz and 1 Hz signals from GNSS.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/Kconfig                |   12 +
 drivers/ptp/Makefile               |    1 +
 drivers/ptp/ptp_fc3.c              | 1036 ++++++++++++++++++++++++++++
 drivers/ptp/ptp_fc3.h              |   45 ++
 include/linux/mfd/idtRC38xxx_reg.h |  273 ++++++++
 5 files changed, 1367 insertions(+)
 create mode 100644 drivers/ptp/ptp_fc3.c
 create mode 100644 drivers/ptp/ptp_fc3.h
 create mode 100644 include/linux/mfd/idtRC38xxx_reg.h

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 5dd5f188e..604541dcb 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -155,6 +155,18 @@ config PTP_1588_CLOCK_IDTCM
 	  To compile this driver as a module, choose M here: the module
 	  will be called ptp_clockmatrix.
 
+config PTP_1588_CLOCK_FC3W
+	tristate "RENESAS FemtoClock3 Wireless as PTP clock"
+	depends on PTP_1588_CLOCK && I2C
+	default n
+	help
+	  This driver adds support for using Renesas FemtoClock3 Wireless
+	  as a PTP clock. This clock is only useful if your time stamping
+	  MAC is connected to the RENESAS chip.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_fc3.
+
 config PTP_1588_CLOCK_MOCK
 	tristate "Mock-up PTP clock"
 	depends on PTP_1588_CLOCK
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index dea0cebd2..68bf02078 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_PTP_1588_CLOCK_QORIQ)	+= ptp-qoriq.o
 ptp-qoriq-y				+= ptp_qoriq.o
 ptp-qoriq-$(CONFIG_DEBUG_FS)		+= ptp_qoriq_debugfs.o
 obj-$(CONFIG_PTP_1588_CLOCK_IDTCM)	+= ptp_clockmatrix.o
+obj-$(CONFIG_PTP_1588_CLOCK_FC3W)	+= ptp_fc3.o
 obj-$(CONFIG_PTP_1588_CLOCK_IDT82P33)	+= ptp_idt82p33.o
 obj-$(CONFIG_PTP_1588_CLOCK_MOCK)	+= ptp_mock.o
 obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
diff --git a/drivers/ptp/ptp_fc3.c b/drivers/ptp/ptp_fc3.c
new file mode 100644
index 000000000..f7ebd870d
--- /dev/null
+++ b/drivers/ptp/ptp_fc3.c
@@ -0,0 +1,1036 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PTP hardware clock driver for the FemtoClock3 family of timing and
+ * synchronization devices.
+ *
+ * Copyright (C) 2023 Integrated Device Technology, Inc., a Renesas Company.
+ */
+#include <linux/firmware.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/timekeeping.h>
+#include <linux/string.h>
+#include <linux/of.h>
+#include <linux/bitfield.h>
+#include <linux/mfd/rsmu.h>
+#include <linux/mfd/idtRC38xxx_reg.h>
+#include <asm/unaligned.h>
+
+#include "ptp_private.h"
+#include "ptp_fc3.h"
+
+MODULE_DESCRIPTION("Driver for IDT FemtoClock3(TM) family");
+MODULE_AUTHOR("IDT support-1588 <IDT-support-1588@lm.renesas.com>");
+MODULE_VERSION("1.0");
+MODULE_LICENSE("GPL");
+
+/*
+ * The name of the firmware file to be loaded
+ * over-rides any automatic selection
+ */
+static char *firmware;
+module_param(firmware, charp, 0);
+
+static inline s64 ns2counters(struct idtfc3 *idtfc3, s64 nsec, u32 *sub_ns)
+{
+	s64 sync;
+	s32 rem;
+
+	if (likely(nsec > 0)) {
+		sync = div_u64_rem(nsec, idtfc3->ns_per_sync, &rem);
+		*sub_ns = rem;
+	} else if (nsec < 0) {
+		sync = -div_u64_rem(-nsec - 1, idtfc3->ns_per_sync, &rem) - 1;
+		*sub_ns = idtfc3->ns_per_sync - rem - 1;
+	}
+
+	return sync * idtfc3->ns_per_sync;
+}
+
+static inline s64 tdc_meas2offset(struct idtfc3 *idtfc3, u64 meas_read)
+{
+	s64 coarse, fine;
+
+	fine = sign_extend64(FIELD_GET(FINE_MEAS_MASK, meas_read), 12);
+	coarse = sign_extend64(FIELD_GET(COARSE_MEAS_MASK, meas_read), (39 - 13));
+
+	fine = div64_s64(fine * NSEC_PER_SEC, idtfc3->tdc_apll_freq * 62LL);
+	coarse = div64_s64(coarse * NSEC_PER_SEC, idtfc3->time_ref_freq);
+
+	return coarse + fine;
+}
+
+static inline s64 tdc_offset2phase(struct idtfc3 *idtfc3, s64 offset_ns)
+{
+	if (offset_ns > idtfc3->ns_per_sync / 2)
+		offset_ns -= idtfc3->ns_per_sync;
+
+	return offset_ns * idtfc3->tdc_offset_sign;
+}
+
+static int idtfc3_set_lpf_mode(struct idtfc3 *idtfc3, u8 mode)
+{
+	int err;
+
+	if (mode >= LPF_INVALID)
+		return -EINVAL;
+
+	if (idtfc3->lpf_mode == mode)
+		return 0;
+
+	err = regmap_bulk_write(idtfc3->regmap, LPF_MODE_CNFG, &mode, sizeof(mode));
+	if (err)
+		return err;
+
+	idtfc3->lpf_mode = mode;
+
+	return 0;
+}
+
+static int idtfc3_enable_lpf(struct idtfc3 *idtfc3, bool enable)
+{
+	u8 val;
+	int err;
+
+	err = regmap_bulk_read(idtfc3->regmap, LPF_CTRL, &val, sizeof(val));
+	if (err)
+		return err;
+
+	if (enable == true)
+		val |= LPF_EN;
+	else
+		val &= ~LPF_EN;
+
+	return regmap_bulk_write(idtfc3->regmap, LPF_CTRL, &val, sizeof(val));
+}
+
+static int idtfc3_get_time_ref_freq(struct idtfc3 *idtfc3)
+{
+	int err;
+	u8 buf[4];
+	u8 time_ref_div;
+	u8 time_clk_div;
+
+	err = regmap_bulk_read(idtfc3->regmap, TIME_CLOCK_MEAS_DIV_CNFG, buf, sizeof(buf));
+	if (err)
+		return err;
+	time_ref_div = FIELD_GET(TIME_REF_DIV_MASK, get_unaligned_le32(buf)) + 1;
+
+	err = regmap_bulk_read(idtfc3->regmap, TIME_CLOCK_COUNT, buf, 1);
+	if (err)
+		return err;
+	time_clk_div = (buf[0] & TIME_CLOCK_COUNT_MASK) + 1;
+	idtfc3->time_ref_freq = idtfc3->hw_param.time_clk_freq *
+				time_clk_div / time_ref_div;
+
+	return 0;
+}
+
+static int idtfc3_get_tdc_offset_sign(struct idtfc3 *idtfc3)
+{
+	int err;
+	u8 buf[4];
+	u32 val;
+	u8 sig1, sig2;
+
+	err = regmap_bulk_read(idtfc3->regmap, TIME_CLOCK_TDC_FANOUT_CNFG, buf, sizeof(buf));
+	if (err)
+		return err;
+
+	val = get_unaligned_le32(buf);
+	if ((val & TIME_SYNC_TO_TDC_EN) != TIME_SYNC_TO_TDC_EN) {
+		dev_err(idtfc3->dev, "TIME_SYNC_TO_TDC_EN is off !!!");
+		return -EINVAL;
+	}
+
+	sig1 = FIELD_GET(SIG1_MUX_SEL_MASK, val);
+	sig2 = FIELD_GET(SIG2_MUX_SEL_MASK, val);
+
+	if ((sig1 == sig2) || ((sig1 != TIME_SYNC) && (sig2 != TIME_SYNC))) {
+		dev_err(idtfc3->dev, "Invalid tdc_mux_sel sig1=%d sig2=%d", sig1, sig2);
+		return -EINVAL;
+	} else if (sig1 == TIME_SYNC) {
+		idtfc3->tdc_offset_sign = 1;
+	} else if (sig2 == TIME_SYNC) {
+		idtfc3->tdc_offset_sign = -1;
+	}
+
+	return 0;
+}
+
+static int idtfc3_lpf_bw(struct idtfc3 *idtfc3, u8 shift, u8 mult)
+{
+	u8 val = FIELD_PREP(LPF_BW_SHIFT, shift) | FIELD_PREP(LPF_BW_MULT, mult);
+
+	return regmap_bulk_write(idtfc3->regmap, LPF_BW_CNFG, &val, sizeof(val));
+}
+
+static int idtfc3_enable_tdc(struct idtfc3 *idtfc3, bool enable, u8 meas_mode)
+{
+	int err;
+	u8 val = 0;
+
+	/* Disable TDC first */
+	err = regmap_bulk_write(idtfc3->regmap, TIME_CLOCK_MEAS_CTRL, &val, sizeof(val));
+	if (err)
+		return err;
+
+	if (enable == false)
+		return idtfc3_lpf_bw(idtfc3, LPF_BW_SHIFT_DEFAULT, LPF_BW_MULT_DEFAULT);
+
+	if (meas_mode >= MEAS_MODE_INVALID)
+		return -EINVAL;
+
+	/* Change TDC meas mode */
+	err = regmap_bulk_write(idtfc3->regmap, TIME_CLOCK_MEAS_CNFG,
+				&meas_mode, sizeof(meas_mode));
+	if (err)
+		return err;
+
+	/* Enable TDC */
+	val = TDC_MEAS_EN;
+	if (meas_mode == CONTINUOUS)
+		val |= TDC_MEAS_START;
+	err = regmap_bulk_write(idtfc3->regmap, TIME_CLOCK_MEAS_CTRL, &val, sizeof(val));
+	if (err)
+		return err;
+
+	return idtfc3_lpf_bw(idtfc3, LPF_BW_SHIFT_1PPS, LPF_BW_MULT_DEFAULT);
+}
+
+static inline bool get_tdc_meas(struct idtfc3 *idtfc3, s64 *offset_ns)
+{
+	bool valid = false;
+	u8 buf[9];
+	u8 val;
+	int err;
+
+	while (true) {
+		err = regmap_bulk_read(idtfc3->regmap, TDC_FIFO_STS,
+				       &val, sizeof(val));
+		if (err)
+			return false;
+
+		if (val & FIFO_EMPTY)
+			break;
+
+		err = regmap_bulk_read(idtfc3->regmap, TDC_FIFO_READ_REQ,
+				       &buf, sizeof(buf));
+		if (err)
+			return false;
+
+		valid = true;
+	}
+
+	if (valid)
+		*offset_ns = tdc_meas2offset(idtfc3, get_unaligned_le64(&buf[1]));
+
+	return valid;
+}
+
+static inline int check_tdc_fifo_overrun(struct idtfc3 *idtfc3)
+{
+	u8 val;
+	int err;
+
+	/* Check if FIFO is overrun */
+	err = regmap_bulk_read(idtfc3->regmap, TDC_FIFO_STS, &val, sizeof(val));
+	if (err)
+		return err;
+
+	if (!(val & FIFO_FULL))
+		return 0;
+
+	dev_warn(idtfc3->dev, "TDC FIFO overrun !!!");
+
+	err = idtfc3_enable_tdc(idtfc3, true, CONTINUOUS);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int get_tdc_meas_continuous(struct idtfc3 *idtfc3)
+{
+	int err;
+	s64 offset_ns;
+	struct ptp_clock_event event;
+
+	err = check_tdc_fifo_overrun(idtfc3);
+	if (err)
+		return err;
+
+	if (get_tdc_meas(idtfc3, &offset_ns) && offset_ns >= 0) {
+		event.index = 0;
+		event.offset = tdc_offset2phase(idtfc3, offset_ns);
+		event.type = PTP_CLOCK_EXTOFF;
+		ptp_clock_event(idtfc3->ptp_clock, &event);
+	}
+
+	return 0;
+}
+
+static int idtfc3_read_subcounter(struct idtfc3 *idtfc3)
+{
+	u8 buf[5] = {0};
+	int err;
+
+	err = regmap_bulk_read(idtfc3->regmap, TOD_COUNTER_READ_REQ,
+			       &buf, sizeof(buf));
+	if (err)
+		return err;
+
+	/* sync_counter_value is [31:82] and sub_sync_counter_value is [0:30] */
+	return get_unaligned_le32(&buf[1]) & SUB_SYNC_COUNTER_MASK;
+}
+
+static int idtfc3_tod_update_is_done(struct idtfc3 *idtfc3)
+{
+	int err;
+	u8 req;
+
+	err = read_poll_timeout_atomic(regmap_bulk_read, err, !req, USEC_PER_MSEC,
+				       idtfc3->tc_write_timeout, true, idtfc3->regmap,
+				       TOD_SYNC_LOAD_REQ_CTRL, &req, 1);
+	if (err)
+		dev_err(idtfc3->dev, "TOD counter write timeout !!!");
+
+	return err;
+}
+
+static int idtfc3_write_subcounter(struct idtfc3 *idtfc3, u32 counter)
+{
+	u8 buf[18] = {0};
+	int err;
+
+	/* sync_counter_value is [31:82] and sub_sync_counter_value is [0:30] */
+	put_unaligned_le32(counter & SUB_SYNC_COUNTER_MASK, &buf[0]);
+
+	buf[16] = SUB_SYNC_LOAD_ENABLE | SYNC_LOAD_ENABLE;
+	buf[17] = SYNC_LOAD_REQ;
+
+	err = regmap_bulk_write(idtfc3->regmap, TOD_SYNC_LOAD_VAL_CTRL,
+				&buf, sizeof(buf));
+	if (err)
+		return err;
+
+	return idtfc3_tod_update_is_done(idtfc3);
+}
+
+static int idtfc3_timecounter_update(struct idtfc3 *idtfc3, u32 counter, s64 ns)
+{
+	int err;
+
+	err = idtfc3_write_subcounter(idtfc3, counter);
+	if (err)
+		return err;
+
+	/* Update time counter */
+	idtfc3->ns = ns;
+	idtfc3->last_counter = counter;
+
+	return 0;
+}
+
+static int idtfc3_timecounter_read(struct idtfc3 *idtfc3)
+{
+	int now, delta;
+
+	now = idtfc3_read_subcounter(idtfc3);
+	if (now < 0)
+		return now;
+
+	/* calculate the delta since the last idtfc3_timecounter_read(): */
+	if (now >= idtfc3->last_counter)
+		delta = now - idtfc3->last_counter;
+	else
+		delta = idtfc3->sub_sync_count - idtfc3->last_counter + now;
+
+	/* Update time counter */
+	idtfc3->ns += delta * idtfc3->ns_per_counter;
+	idtfc3->last_counter = now;
+
+	return 0;
+}
+
+static int _idtfc3_gettime(struct idtfc3 *idtfc3, struct timespec64 *ts)
+{
+	int err;
+
+	err = idtfc3_timecounter_read(idtfc3);
+	if (err)
+		return err;
+
+	*ts = ns_to_timespec64(idtfc3->ns);
+
+	return 0;
+}
+
+static int idtfc3_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
+{
+	struct idtfc3 *idtfc3 = container_of(ptp, struct idtfc3, caps);
+	int err;
+
+	mutex_lock(idtfc3->lock);
+	err = _idtfc3_gettime(idtfc3, ts);
+	mutex_unlock(idtfc3->lock);
+
+	if (err)
+		dev_err(idtfc3->dev, "Failed at line %d in %s!",
+			__LINE__, __func__);
+
+	return err;
+}
+
+static int _idtfc3_settime(struct idtfc3 *idtfc3, const struct timespec64 *ts)
+{
+	s64 offset_ns, now_ns, sync_ns;
+	u32 counter, sub_ns;
+	int now;
+
+	if (timespec64_valid(ts) == false) {
+		dev_err(idtfc3->dev, "%s: invalid timespec", __func__);
+		return -EINVAL;
+	}
+
+	now = idtfc3_read_subcounter(idtfc3);
+	if (now < 0)
+		return now;
+
+	offset_ns = (idtfc3->sub_sync_count - now) * idtfc3->ns_per_counter;
+	now_ns = timespec64_to_ns(ts);
+	sync_ns = ns2counters(idtfc3, offset_ns + now_ns, &sub_ns);
+
+	counter = sub_ns / idtfc3->ns_per_counter;
+	return idtfc3_timecounter_update(idtfc3, counter, now_ns);
+}
+
+static int idtfc3_settime(struct ptp_clock_info *ptp, const struct timespec64 *ts)
+{
+	struct idtfc3 *idtfc3 = container_of(ptp, struct idtfc3, caps);
+	int err;
+
+	mutex_lock(idtfc3->lock);
+	err = _idtfc3_settime(idtfc3, ts);
+	mutex_unlock(idtfc3->lock);
+
+	if (err)
+		dev_err(idtfc3->dev,
+			"Failed at line %d in %s!", __LINE__, __func__);
+
+	return err;
+}
+
+static int _idtfc3_adjtime(struct idtfc3 *idtfc3, s64 delta)
+{
+	/*
+	 * The TOD counter can be synchronously loaded with any value,
+	 * to be loaded on the next Time Sync pulse
+	 */
+	s64 sync_ns;
+	u32 sub_ns;
+	u32 counter;
+
+	if (idtfc3->ns + delta < 0) {
+		dev_err(idtfc3->dev, "%lld ns adj is too large", delta);
+		return -EINVAL;
+	}
+
+	sync_ns = ns2counters(idtfc3, delta + idtfc3->ns_per_sync, &sub_ns);
+
+	counter = sub_ns / idtfc3->ns_per_counter;
+	return idtfc3_timecounter_update(idtfc3, counter, idtfc3->ns + sync_ns +
+									counter * idtfc3->ns_per_counter);
+}
+
+static int idtfc3_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct idtfc3 *idtfc3 = container_of(ptp, struct idtfc3, caps);
+	int err;
+
+	mutex_lock(idtfc3->lock);
+	err = _idtfc3_adjtime(idtfc3, delta);
+	mutex_unlock(idtfc3->lock);
+
+	if (err)
+		dev_err(idtfc3->dev,
+			"Failed at line %d in %s!", __LINE__, __func__);
+
+	return err;
+}
+
+static int _idtfc3_adjphase(struct idtfc3 *idtfc3, s32 delta)
+{
+	u8 buf[8] = {0};
+	int err;
+	s64 pcw;
+
+	err = idtfc3_set_lpf_mode(idtfc3, LPF_WP);
+	if (err)
+		return err;
+
+	/*
+	 * Phase Control Word unit is: 10^9 / (TDC_APLL_FREQ * 124)
+	 *
+	 *       delta * TDC_APLL_FREQ * 124
+	 * PCW = ---------------------------
+	 *                  10^9
+	 *
+	 */
+	pcw = div_s64((s64)delta * idtfc3->tdc_apll_freq * 124, NSEC_PER_SEC);
+
+	put_unaligned_le64(pcw, buf);
+
+	return regmap_bulk_write(idtfc3->regmap, LPF_WR_PHASE_CTRL, buf, sizeof(buf));
+}
+
+static int idtfc3_adjphase(struct ptp_clock_info *ptp, s32 delta)
+{
+	struct idtfc3 *idtfc3 = container_of(ptp, struct idtfc3, caps);
+	int err;
+
+	mutex_lock(idtfc3->lock);
+	err = _idtfc3_adjphase(idtfc3, delta);
+	mutex_unlock(idtfc3->lock);
+
+	if (err)
+		dev_err(idtfc3->dev,
+			"Failed at line %d in %s!", __LINE__, __func__);
+
+	return err;
+}
+
+static int _idtfc3_adjfine(struct idtfc3 *idtfc3, long scaled_ppm)
+{
+	u8 buf[8] = {0};
+	int err;
+	s64 fcw;
+
+	err = idtfc3_set_lpf_mode(idtfc3, LPF_WF);
+	if (err)
+		return err;
+
+	/*
+	 * Frequency Control Word unit is: 2^-44 * 10^6 ppm
+	 *
+	 * adjfreq:
+	 *       ppb * 2^44
+	 * FCW = ----------
+	 *          10^9
+	 *
+	 * adjfine:
+	 *       ppm_16 * 2^28
+	 * FCW = -------------
+	 *           10^6
+	 */
+	fcw = scaled_ppm * BIT(28);
+	fcw = div_s64(fcw, 1000000);
+
+	put_unaligned_le64(fcw, buf);
+
+	return regmap_bulk_write(idtfc3->regmap, LPF_WR_FREQ_CTRL, buf, sizeof(buf));
+}
+
+static int idtfc3_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	struct idtfc3 *idtfc3 = container_of(ptp, struct idtfc3, caps);
+	int err;
+
+	mutex_lock(idtfc3->lock);
+	err = _idtfc3_adjfine(idtfc3, scaled_ppm);
+	mutex_unlock(idtfc3->lock);
+
+	if (err)
+		dev_err(idtfc3->dev,
+			"Failed at line %d in %s!", __LINE__, __func__);
+
+	return err;
+}
+
+static int idtfc3_enable(struct ptp_clock_info *ptp,
+			 struct ptp_clock_request *rq, int on)
+{
+	struct idtfc3 *idtfc3 = container_of(ptp, struct idtfc3, caps);
+	int err = -EOPNOTSUPP;
+
+	mutex_lock(idtfc3->lock);
+		switch (rq->type) {
+		case PTP_CLK_REQ_PEROUT:
+			if (!on)
+				err = 0;
+			/* Only accept a 1-PPS aligned to the second. */
+			else if (rq->perout.start.nsec || rq->perout.period.sec != 1 ||
+				 rq->perout.period.nsec)
+				err = -ERANGE;
+			else
+				err = 0;
+			break;
+		case PTP_CLK_REQ_EXTTS:
+			if (on) {
+				/* Only accept requests for external phase offset */
+				if ((rq->extts.flags & PTP_EXT_OFFSET) != (PTP_EXT_OFFSET))
+					err = -EOPNOTSUPP;
+				else
+					err = idtfc3_enable_tdc(idtfc3, true, CONTINUOUS);
+			} else {
+				err = idtfc3_enable_tdc(idtfc3, false, MEAS_MODE_INVALID);
+			}
+			break;
+		default:
+			break;
+		}
+	mutex_unlock(idtfc3->lock);
+
+	if (err)
+		dev_err(idtfc3->dev, "Failed in %s with err %d!", __func__, err);
+
+	return err;
+}
+
+static long idtfc3_aux_work(struct ptp_clock_info *ptp)
+{
+	struct idtfc3 *idtfc3 = container_of(ptp, struct idtfc3, caps);
+	static int tdc_get;
+
+	mutex_lock(idtfc3->lock);
+	tdc_get %= TDC_GET_PERIOD;
+	if ((tdc_get == 0) || (tdc_get == TDC_GET_PERIOD / 2))
+		idtfc3_timecounter_read(idtfc3);
+	get_tdc_meas_continuous(idtfc3);
+	tdc_get++;
+	mutex_unlock(idtfc3->lock);
+
+	return idtfc3->tc_update_period;
+}
+
+static const struct ptp_clock_info idtfc3_caps = {
+	.owner		= THIS_MODULE,
+	.max_adj	= MAX_FFO_PPB,
+	.n_per_out	= 1,
+	.n_ext_ts	= 1,
+	.adjphase	= &idtfc3_adjphase,
+	.adjfine	= &idtfc3_adjfine,
+	.adjtime	= &idtfc3_adjtime,
+	.gettime64	= &idtfc3_gettime,
+	.settime64	= &idtfc3_settime,
+	.enable		= &idtfc3_enable,
+	.do_aux_work	= &idtfc3_aux_work,
+};
+
+static int idtfc3_hw_calibrate(struct idtfc3 *idtfc3)
+{
+	int err = 0;
+	u8 val;
+
+	mdelay(10);
+	/*
+	 * Toggle TDC_DAC_RECAL_REQ:
+	 * (1) set tdc_en to 1
+	 * (2) set tdc_dac_recal_req to 0
+	 * (3) set tdc_dac_recal_req to 1
+	 */
+	val = TDC_EN;
+	err = regmap_bulk_write(idtfc3->regmap, TDC_CTRL,
+				&val, sizeof(val));
+	if (err)
+		return err;
+	val = TDC_EN | TDC_DAC_RECAL_REQ;
+	err = regmap_bulk_write(idtfc3->regmap, TDC_CTRL,
+				&val, sizeof(val));
+	if (err)
+		return err;
+	mdelay(10);
+
+	/*
+	 * Toggle APLL_REINIT:
+	 * (1) set apll_reinit to 0
+	 * (2) set apll_reinit to 1
+	 */
+	val = 0;
+	err = regmap_bulk_write(idtfc3->regmap, SOFT_RESET_CTRL,
+				&val, sizeof(val));
+	if (err)
+		return err;
+	val = APLL_REINIT;
+	err = regmap_bulk_write(idtfc3->regmap, SOFT_RESET_CTRL,
+				&val, sizeof(val));
+	if (err)
+		return err;
+	mdelay(10);
+
+	return err;
+}
+
+static int idtfc3_init_timecounter(struct idtfc3 *idtfc3)
+{
+	int err;
+	u32 period_ms;
+
+	period_ms = idtfc3->sub_sync_count * MSEC_PER_SEC /
+			idtfc3->hw_param.time_clk_freq;
+
+	idtfc3->tc_update_period = msecs_to_jiffies(period_ms / TDC_GET_PERIOD);
+	idtfc3->tc_write_timeout = period_ms * USEC_PER_MSEC;
+
+	err = idtfc3_timecounter_update(idtfc3, 0, 0);
+	if (err)
+		return err;
+
+	err = idtfc3_timecounter_read(idtfc3);
+	if (err)
+		return err;
+
+	ptp_schedule_worker(idtfc3->ptp_clock, idtfc3->tc_update_period);
+
+	return 0;
+}
+
+static int idtfc3_get_tdc_apll_freq(struct idtfc3 *idtfc3)
+{
+	int err;
+	u8 tdc_fb_div_int;
+	u8 tdc_ref_div;
+	struct idtfc3_hw_param *param = &idtfc3->hw_param;
+
+	err = regmap_bulk_read(idtfc3->regmap, TDC_REF_DIV_CNFG,
+				&tdc_ref_div, sizeof(tdc_ref_div));
+	if (err)
+		return err;
+
+	err = regmap_bulk_read(idtfc3->regmap, TDC_FB_DIV_INT_CNFG,
+				&tdc_fb_div_int, sizeof(tdc_fb_div_int));
+	if (err)
+		return err;
+
+	tdc_fb_div_int &= TDC_FB_DIV_INT_MASK;
+	tdc_ref_div &= TDC_REF_DIV_CONFIG_MASK;
+
+	idtfc3->tdc_apll_freq = div_u64(param->xtal_freq * (u64)tdc_fb_div_int,
+					1 << tdc_ref_div);
+
+	return 0;
+}
+
+static int idtfc3_get_fod(struct idtfc3 *idtfc3)
+{
+	int err;
+	u8 fod;
+
+	err = regmap_bulk_read(idtfc3->regmap, TIME_CLOCK_SRC, &fod, sizeof(fod));
+	if (err)
+		return err;
+
+	switch (fod) {
+	case 0:
+		idtfc3->fod_n = FOD_0;
+		break;
+	case 1:
+		idtfc3->fod_n = FOD_1;
+		break;
+	case 2:
+		idtfc3->fod_n = FOD_2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int idtfc3_get_sync_count(struct idtfc3 *idtfc3)
+{
+	int err;
+	u8 buf[4];
+
+	err = regmap_bulk_read(idtfc3->regmap, SUB_SYNC_GEN_CNFG, buf, sizeof(buf));
+	if (err)
+		return err;
+
+	idtfc3->sub_sync_count = (get_unaligned_le32(buf) & SUB_SYNC_COUNTER_MASK) + 1;
+	idtfc3->ns_per_counter = NSEC_PER_SEC / idtfc3->hw_param.time_clk_freq;
+	idtfc3->ns_per_sync = idtfc3->sub_sync_count * idtfc3->ns_per_counter;
+
+	return 0;
+}
+
+static int idtfc3_setup_hw_param(struct idtfc3 *idtfc3)
+{
+	int err;
+
+	err = idtfc3_get_fod(idtfc3);
+	if (err)
+		return err;
+
+	err = idtfc3_get_sync_count(idtfc3);
+	if (err)
+		return err;
+
+	err = idtfc3_get_time_ref_freq(idtfc3);
+	if (err)
+		return err;
+
+	return idtfc3_get_tdc_apll_freq(idtfc3);
+}
+
+static int idtfc3_configure_hw(struct idtfc3 *idtfc3)
+{
+	int err = 0;
+
+	err = idtfc3_hw_calibrate(idtfc3);
+	if (err)
+		return err;
+
+	err = idtfc3_enable_lpf(idtfc3, true);
+	if (err)
+		return err;
+
+	err = idtfc3_enable_tdc(idtfc3, false, MEAS_MODE_INVALID);
+	if (err)
+		return err;
+
+	err = idtfc3_get_tdc_offset_sign(idtfc3);
+	if (err)
+		return err;
+
+	return idtfc3_setup_hw_param(idtfc3);
+}
+
+static int idtfc3_set_overhead(struct idtfc3 *idtfc3)
+{
+	s64 current_ns = 0;
+	s64 lowest_ns = 0;
+	int err;
+	u8 i;
+	ktime_t start;
+	ktime_t stop;
+	ktime_t diff;
+
+	char buf[18] = {0};
+
+	for (i = 0; i < 5; i++) {
+		start = ktime_get_raw();
+
+		err = regmap_bulk_write(idtfc3->regmap, TOD_SYNC_LOAD_VAL_CTRL,
+					&buf, sizeof(buf));
+		if (err)
+			return err;
+
+		stop = ktime_get_raw();
+
+		diff = ktime_sub(stop, start);
+
+		current_ns = ktime_to_ns(diff);
+
+		if (i == 0) {
+			lowest_ns = current_ns;
+		} else {
+			if (current_ns < lowest_ns)
+				lowest_ns = current_ns;
+		}
+	}
+
+	idtfc3->tod_write_overhead = lowest_ns;
+
+	return err;
+}
+
+static int idtfc3_enable_ptp(struct idtfc3 *idtfc3)
+{
+	int err;
+
+	idtfc3->caps = idtfc3_caps;
+	snprintf(idtfc3->caps.name, sizeof(idtfc3->caps.name), "IDT FC3W");
+	idtfc3->ptp_clock = ptp_clock_register(&idtfc3->caps, NULL);
+
+	if (IS_ERR(idtfc3->ptp_clock)) {
+		err = PTR_ERR(idtfc3->ptp_clock);
+		idtfc3->ptp_clock = NULL;
+		return err;
+	}
+
+	err = idtfc3_set_overhead(idtfc3);
+	if (err)
+		return err;
+
+	err = idtfc3_init_timecounter(idtfc3);
+	if (err)
+		return err;
+
+	dev_info(idtfc3->dev, "TIME_SYNC_CHANNEL registered as ptp%d",
+		 idtfc3->ptp_clock->index);
+
+	return 0;
+}
+
+static int idtfc3_load_firmware(struct idtfc3 *idtfc3)
+{
+	char fname[128] = FW_FILENAME;
+	const struct firmware *fw;
+	struct idtfc3_fwrc *rec;
+	u16 addr;
+	u8 val;
+	int err;
+	s32 len;
+
+	idtfc3_default_hw_param(&idtfc3->hw_param);
+
+	if (firmware) /* module parameter */
+		snprintf(fname, sizeof(fname), "%s", firmware);
+
+	dev_info(idtfc3->dev, "requesting firmware '%s'\n", fname);
+
+	err = request_firmware(&fw, fname, idtfc3->dev);
+
+	if (err) {
+		dev_err(idtfc3->dev,
+			"requesting firmware failed with err %d!\n", err);
+		return err;
+	}
+
+	dev_dbg(idtfc3->dev, "firmware size %zu bytes\n", fw->size);
+
+	rec = (struct idtfc3_fwrc *)fw->data;
+
+	for (len = fw->size; len > 0; len -= sizeof(*rec)) {
+		if (rec->reserved) {
+			dev_err(idtfc3->dev,
+				"bad firmware, reserved field non-zero\n");
+			err = -EINVAL;
+		} else {
+			val = rec->value;
+			addr = rec->hiaddr << 8 | rec->loaddr;
+
+			rec++;
+
+			err = idtfc3_set_hw_param(&idtfc3->hw_param, addr, val);
+		}
+
+		if (err != -EINVAL) {
+			err = 0;
+
+			/* Max register */
+			if (addr >= 0xE88)
+				continue;
+
+			err = regmap_bulk_write(idtfc3->regmap, addr,
+						&val, sizeof(val));
+		}
+
+		if (err)
+			goto out;
+	}
+
+	err = idtfc3_configure_hw(idtfc3);
+out:
+	release_firmware(fw);
+	return err;
+}
+
+static int idtfc3_read_device_id(struct idtfc3 *idtfc3, u16 *device_id)
+{
+	int err;
+	u8 buf[2] = {0};
+
+	err = regmap_bulk_read(idtfc3->regmap, DEVICE_ID,
+			       &buf, sizeof(buf));
+	if (err) {
+		dev_err(idtfc3->dev, "%s failed with %d", __func__, err);
+		return err;
+	}
+
+	*device_id = get_unaligned_le16(buf);
+
+	return 0;
+}
+
+static int idtfc3_check_device_compatibility(struct idtfc3 *idtfc3)
+{
+	int err;
+	u16 device_id;
+
+	err = idtfc3_read_device_id(idtfc3, &device_id);
+	if (err)
+		return err;
+
+	if ((device_id & DEVICE_ID_MASK) == 0) {
+		dev_err(idtfc3->dev, "invalid device");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int idtfc3_probe(struct platform_device *pdev)
+{
+	struct rsmu_ddata *ddata = dev_get_drvdata(pdev->dev.parent);
+	struct idtfc3 *idtfc3;
+	int err;
+
+	idtfc3 = devm_kzalloc(&pdev->dev, sizeof(struct idtfc3), GFP_KERNEL);
+
+	if (!idtfc3)
+		return -ENOMEM;
+
+	idtfc3->dev = &pdev->dev;
+	idtfc3->mfd = pdev->dev.parent;
+	idtfc3->lock = &ddata->lock;
+	idtfc3->regmap = ddata->regmap;
+
+	mutex_lock(idtfc3->lock);
+
+	err = idtfc3_check_device_compatibility(idtfc3);
+	if (err) {
+		mutex_unlock(idtfc3->lock);
+		return err;
+	}
+
+	err = idtfc3_load_firmware(idtfc3);
+	if (err) {
+		if (err == -ENOENT) {
+			mutex_unlock(idtfc3->lock);
+			return -EPROBE_DEFER;
+		}
+		dev_warn(idtfc3->dev, "loading firmware failed with %d", err);
+	}
+
+	err = idtfc3_enable_ptp(idtfc3);
+	if (err) {
+		dev_err(idtfc3->dev, "idtfc3_enable_ptp failed with %d", err);
+		mutex_unlock(idtfc3->lock);
+		return err;
+	}
+
+	mutex_unlock(idtfc3->lock);
+
+	if (err) {
+		ptp_clock_unregister(idtfc3->ptp_clock);
+		return err;
+	}
+
+	platform_set_drvdata(pdev, idtfc3);
+
+	return 0;
+}
+
+static int idtfc3_remove(struct platform_device *pdev)
+{
+	struct idtfc3 *idtfc3 = platform_get_drvdata(pdev);
+
+	ptp_clock_unregister(idtfc3->ptp_clock);
+
+	return 0;
+}
+
+static struct platform_driver idtfc3_driver = {
+	.driver = {
+		.name = "rc38xxx-phc",
+	},
+	.probe = idtfc3_probe,
+	.remove	= idtfc3_remove,
+};
+
+module_platform_driver(idtfc3_driver);
diff --git a/drivers/ptp/ptp_fc3.h b/drivers/ptp/ptp_fc3.h
new file mode 100644
index 000000000..897101579
--- /dev/null
+++ b/drivers/ptp/ptp_fc3.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * PTP hardware clock driver for the FemtoClock3 family of timing and
+ * synchronization devices.
+ *
+ * Copyright (C) 2023 Integrated Device Technology, Inc., a Renesas Company.
+ */
+#ifndef PTP_IDTFC3_H
+#define PTP_IDTFC3_H
+
+#include <linux/ktime.h>
+#include <linux/ptp_clock.h>
+#include <linux/regmap.h>
+
+#define FW_FILENAME	"idtfc3.bin"
+
+#define MAX_FFO_PPB	(244000)
+#define TDC_GET_PERIOD	(10)
+
+struct idtfc3 {
+	struct ptp_clock_info	caps;
+	struct ptp_clock	*ptp_clock;
+	struct device		*dev;
+	/* Mutex to protect operations from being interrupted */
+	struct mutex		*lock;
+	struct device		*mfd;
+	struct regmap		*regmap;
+	struct idtfc3_hw_param	hw_param;
+	u32			sub_sync_count;
+	u32			ns_per_sync;
+	int			tdc_offset_sign;
+	u64			tdc_apll_freq;
+	u32			time_ref_freq;
+	u16			fod_n;
+	u8			lpf_mode;
+	/* Time counter */
+	u32			last_counter;
+	s64			ns;
+	u32			ns_per_counter;
+	u32			tc_update_period;
+	u32			tc_write_timeout;
+	s64			tod_write_overhead;
+};
+
+#endif /* PTP_IDTFC3_H */
diff --git a/include/linux/mfd/idtRC38xxx_reg.h b/include/linux/mfd/idtRC38xxx_reg.h
new file mode 100644
index 000000000..edddaae61
--- /dev/null
+++ b/include/linux/mfd/idtRC38xxx_reg.h
@@ -0,0 +1,273 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Register Map - Based on PolarBear_CSRs.RevA.xlsx (2023-04-21)
+ *
+ * Copyright (C) 2023 Integrated Device Technology, Inc., a Renesas Company.
+ */
+#ifndef HAVE_IDTRC38XXX_REG
+#define HAVE_IDTRC38XXX_REG
+
+/* GLOBAL */
+#define SOFT_RESET_CTRL		(0x15) /* Specific to FC3W */
+#define MISC_CTRL		(0x14) /* Specific to FC3A */
+#define APLL_REINIT		BIT(1)
+#define APLL_REINIT_VFC3A	BIT(2)
+
+#define DEVICE_ID		(0x2)
+#define DEVICE_ID_MASK		(0x1000) /* Bit 12 is 1 if FC3W and 0 if FC3A */
+#define DEVICE_ID_SHIFT		(12)
+
+/* FOD */
+#define FOD_0		(0x300)
+#define FOD_0_VFC3A	(0x400)
+#define FOD_1		(0x340)
+#define FOD_1_VFC3A	(0x440)
+#define FOD_2		(0x380)
+#define FOD_2_VFC3A	(0x480)
+
+/* TDCAPLL */
+#define TDC_CTRL		(0x44a) /* Specific to FC3W */
+#define TDC_ENABLE_CTRL		(0x169) /* Specific to FC3A */
+#define TDC_DAC_CAL_CTRL	(0x16a) /* Specific to FC3A */
+#define TDC_EN			BIT(0)
+#define TDC_DAC_RECAL_REQ	BIT(1)
+#define TDC_DAC_RECAL_REQ_VFC3A	BIT(0)
+
+#define TDC_FB_DIV_INT_CNFG		(0x442)
+#define TDC_FB_DIV_INT_CNFG_VFC3A	(0x162)
+#define TDC_FB_DIV_INT_MASK		GENMASK(7, 0)
+#define TDC_REF_DIV_CNFG		(0x443)
+#define TDC_REF_DIV_CNFG_VFC3A		(0x163)
+#define TDC_REF_DIV_CONFIG_MASK		GENMASK(2, 0)
+
+/* TIME SYNC CHANNEL */
+#define TIME_CLOCK_SRC		(0xa01) /* Specific to FC3W */
+#define TIME_CLOCK_COUNT	(0xa00) /* Specific to FC3W */
+#define TIME_CLOCK_COUNT_MASK	GENMASK(5, 0)
+
+#define SUB_SYNC_GEN_CNFG	(0xa04)
+
+#define TOD_COUNTER_READ_REQ		(0xa5f)
+#define TOD_COUNTER_READ_REQ_VFC3A	(0x6df)
+#define TOD_SYNC_LOAD_VAL_CTRL		(0xa10)
+#define TOD_SYNC_LOAD_VAL_CTRL_VFC3A	(0x690)
+#define SYNC_COUNTER_MASK		GENMASK(51, 0)
+#define SUB_SYNC_COUNTER_MASK		GENMASK(30, 0)
+#define TOD_SYNC_LOAD_REQ_CTRL		(0xa21)
+#define TOD_SYNC_LOAD_REQ_CTRL_VFC3A	(0x6a1)
+#define SYNC_LOAD_ENABLE		BIT(1)
+#define SUB_SYNC_LOAD_ENABLE		BIT(0)
+#define SYNC_LOAD_REQ			BIT(0)
+
+#define LPF_MODE_CNFG		(0xa80)
+#define LPF_MODE_CNFG_VFC3A	(0x700)
+enum lpf_mode {
+	LPF_DISABLED = 0,
+	LPF_WP       = 1,
+	LPF_HOLDOVER = 2,
+	LPF_WF       = 3,
+	LPF_INVALID  = 4
+};
+#define LPF_CTRL	(0xa98)
+#define LPF_CTRL_VFC3A	(0x718)
+#define LPF_EN		BIT(0)
+
+#define LPF_BW_CNFG	(0xa81)
+#define LPF_BW_SHIFT	GENMASK(7, 3)
+#define LPF_BW_MULT		GENMASK(2, 0)
+#define LPF_BW_SHIFT_DEFAULT	(0xb)
+#define LPF_BW_MULT_DEFAULT		(0x0)
+#define LPF_BW_SHIFT_1PPS		(0x5)
+
+#define LPF_WR_PHASE_CTRL	(0xaa8)
+#define LPF_WR_PHASE_CTRL_VFC3A	(0x728)
+#define LPF_WR_FREQ_CTRL	(0xab0)
+#define LPF_WR_FREQ_CTRL_VFC3A	(0x730)
+
+#define TIME_CLOCK_TDC_FANOUT_CNFG	(0xB00)
+#define TIME_SYNC_TO_TDC_EN	BIT(0)
+#define SIG1_MUX_SEL_MASK	GENMASK(7, 4)
+#define SIG2_MUX_SEL_MASK	GENMASK(11, 8)
+enum tdc_mux_sel {
+	REF0 = 0,
+	REF1 = 1,
+	REF2 = 2,
+	REF3 = 3,
+	REF_CLK5 = 4,
+	REF_CLK6 = 5,
+	DPLL_FB_TO_TDC = 6,
+	DPLL_FB_DIVIDED_TO_TDC = 7,
+	TIME_CLK_DIVIDED = 8,
+	TIME_SYNC = 9,
+};
+
+#define TIME_CLOCK_MEAS_CNFG	(0xB04)
+#define TDC_MEAS_MODE	BIT(0)
+enum tdc_meas_mode {
+	CONTINUOUS = 0,
+	ONE_SHOT = 1,
+	MEAS_MODE_INVALID = 2,
+};
+
+#define TIME_CLOCK_MEAS_DIV_CNFG	(0xB08)
+#define TIME_REF_DIV_MASK	GENMASK(29, 24)
+
+#define TIME_CLOCK_MEAS_CTRL	(0xB10)
+#define TDC_MEAS_EN	BIT(0)
+#define TDC_MEAS_START	BIT(1)
+
+#define TDC_FIFO_READ_REQ	(0xB2F)
+#define TDC_FIFO_READ		(0xB30)
+#define COARSE_MEAS_MASK	GENMASK(39, 13)
+#define FINE_MEAS_MASK		GENMASK(12, 0)
+
+#define TDC_FIFO_CTRL		(0xB12)
+#define FIFO_CLEAR		BIT(0)
+#define TDC_FIFO_STS		(0xB38)
+#define FIFO_FULL		BIT(1)
+#define FIFO_EMPTY		BIT(0)
+#define TDC_FIFO_EVENT		(0xB39)
+#define FIFO_OVERRUN		BIT(1)
+
+/* DPLL */
+#define MAX_REFERENCE_INDEX	(3)
+#define MAX_NUM_REF_PRIORITY	(4)
+
+#define MAX_DPLL_INDEX	(2)
+
+#define DPLL_STS		(0x580)
+#define DPLL_STS_VFC3A		(0x571)
+#define DPLL_STATE_STS_MASK	(0x70)
+#define DPLL_STATE_STS_SHIFT	(4)
+#define DPLL_REF_SEL_STS_MASK	(0x6)
+#define DPLL_REF_SEL_STS_SHIFT	(1)
+
+#define DPLL_REF_PRIORITY_CNFG			(0x502)
+#define DPLL_REFX_PRIORITY_DISABLE_MASK		(0xf)
+#define DPLL_REF0_PRIORITY_ENABLE_AND_SET_MASK	(0x31)
+#define DPLL_REF1_PRIORITY_ENABLE_AND_SET_MASK	(0xc2)
+#define DPLL_REF2_PRIORITY_ENABLE_AND_SET_MASK	(0x304)
+#define DPLL_REF3_PRIORITY_ENABLE_AND_SET_MASK	(0xc08)
+#define DPLL_REF0_PRIORITY_SHIFT		(4)
+#define DPLL_REF1_PRIORITY_SHIFT		(6)
+#define DPLL_REF2_PRIORITY_SHIFT		(8)
+#define DPLL_REF3_PRIORITY_SHIFT		(10)
+
+enum dpll_state {
+	DPLL_STATE_MIN             = 0,
+	DPLL_STATE_FREERUN         = DPLL_STATE_MIN,
+	DPLL_STATE_LOCKED          = 1,
+	DPLL_STATE_HOLDOVER        = 2,
+	DPLL_STATE_WRITE_FREQUENCY = 3,
+	DPLL_STATE_ACQUIRE         = 4,
+	DPLL_STATE_HITLESS_SWITCH  = 5,
+	DPLL_STATE_MAX             = DPLL_STATE_HITLESS_SWITCH
+};
+
+/* REFMON */
+#define LOSMON_STS_0		(0x81e)
+#define LOSMON_STS_0_VFC3A	(0x18e)
+#define LOSMON_STS_1		(0x82e)
+#define LOSMON_STS_1_VFC3A	(0x19e)
+#define LOSMON_STS_2		(0x83e)
+#define LOSMON_STS_2_VFC3A	(0x1ae)
+#define LOSMON_STS_3		(0x84e)
+#define LOSMON_STS_3_VFC3A	(0x1be)
+#define LOS_STS_MASK		(0x1)
+
+#define FREQMON_STS_0		(0x874)
+#define FREQMON_STS_0_VFC3A	(0x1d4)
+#define FREQMON_STS_1		(0x894)
+#define FREQMON_STS_1_VFC3A	(0x1f4)
+#define FREQMON_STS_2		(0x8b4)
+#define FREQMON_STS_2_VFC3A	(0x214)
+#define FREQMON_STS_3		(0x8d4)
+#define FREQMON_STS_3_VFC3A	(0x234)
+#define FREQ_FAIL_STS_SHIFT	(31)
+
+/* Firmware interface */
+#define TIME_CLK_FREQ_ADDR	(0xffa0)
+#define XTAL_FREQ_ADDR		(0xffa1)
+
+/*
+ * Return register address and field mask based on passed in firmware version
+ */
+#define IDTFC3_FW_REG(FW, VER, REG)	(((FW) < (VER)) ? (REG) : (REG##_##VER))
+#define IDTFC3_FW_FIELD(FW, VER, FIELD)	(((FW) < (VER)) ? (FIELD) : (FIELD##_##VER))
+enum fw_version {
+	V_DEFAULT = 0,
+	VFC3W     = 1,
+	VFC3A     = 2
+};
+
+/* XTAL_FREQ_ADDR/TIME_CLK_FREQ_ADDR */
+enum {
+	FREQ_MIN     = 0,
+	FREQ_25M     = 1,
+	FREQ_49_152M = 2,
+	FREQ_50M     = 3,
+	FREQ_100M    = 4,
+	FREQ_125M    = 5,
+	FREQ_250M    = 6,
+	FREQ_MAX
+};
+
+struct idtfc3_hw_param {
+	u32 xtal_freq;
+	u32 time_clk_freq;
+};
+
+struct idtfc3_fwrc {
+	u8 hiaddr;
+	u8 loaddr;
+	u8 value;
+	u8 reserved;
+} __packed;
+
+static inline void idtfc3_default_hw_param(struct idtfc3_hw_param *hw_param)
+{
+	hw_param->xtal_freq = 49152000;
+	hw_param->time_clk_freq = 25000000;
+}
+
+static inline int idtfc3_set_hw_param(struct idtfc3_hw_param *hw_param,
+				      u16 addr, u8 val)
+{
+	if (addr == XTAL_FREQ_ADDR)
+		switch (val) {
+		case FREQ_49_152M:
+			hw_param->xtal_freq = 49152000;
+			break;
+		case FREQ_50M:
+			hw_param->xtal_freq = 50000000;
+			break;
+		default:
+			return -EINVAL;
+		}
+	else if (addr == TIME_CLK_FREQ_ADDR)
+		switch (val) {
+		case FREQ_25M:
+			hw_param->time_clk_freq = 25000000;
+			break;
+		case FREQ_50M:
+			hw_param->time_clk_freq = 50000000;
+			break;
+		case FREQ_100M:
+			hw_param->time_clk_freq = 100000000;
+			break;
+		case FREQ_125M:
+			hw_param->time_clk_freq = 125000000;
+			break;
+		case FREQ_250M:
+			hw_param->time_clk_freq = 250000000;
+			break;
+		default:
+			return -EINVAL;
+		}
+	else
+		return -EFAULT;
+
+	return 0;
+}
+
+#endif
-- 
2.39.2


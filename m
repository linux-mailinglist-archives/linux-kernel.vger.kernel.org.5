Return-Path: <linux-kernel+bounces-11833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F124381EC4A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4908B1F22B92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 05:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CA863AF;
	Wed, 27 Dec 2023 05:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="HgQynyv4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2104.outbound.protection.outlook.com [40.92.52.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB56134;
	Wed, 27 Dec 2023 05:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk5LVLfjM6LH6LXbpkqxGpYYSJoOzjkoKMB5HkKkgZTM+DEF5C91QGc7Owd1EgmURqLJPN3rhGRwil1ggSUNs5VXNYRcrgzP2l0+o4tRVOphfg9h3OSOTrFCphRT0lC6IiRefdu7st1G0ayr10ijI+v80DjyXqOeHHKKRya9EqMtdqgYPwrisohfMRaCH3Mx7MFwpaDqata99p16e9C72aXDRvlv5xRCyUvfPex9B7S+GYWxc2kxoN58cv+YGPglbbOU9+RJJ+HcglbHAwLlOiZr8tmljA4frU0SbF+Q9V88HNGt88z82tV3hNfVwiHSEROS08u0wccKGiF/sLl+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pc/0J4dnZa3aRripSGpBsYMWNDnbEC+uRWVEnjB810s=;
 b=JC2n/eQWRbaLAeEJQva/I0XvfsT/g03UspIMpNVelJlva8/khpvjAUzDKUu6/g4uMuhc9K+jl+fqTkv2Y5TFyWiY3iTi/o7GaQ4H3Foqj3smPE/DcYojS38IImSfVNDD1dcj/ruEQBmnTdHoWNiQA0adhzw6qsU+1CCNIVI67lXt/aNMxruX1FKSl7R7Mu9uS/r+6s/sSjsCsdBxN746s0I2R6rzOb8kSy30eJqwUPDD/0oaUeYkmEdR03YELkYRmCnJf9ROaS/k4lw8TrT61+4B2lJkt2dfUBQywhCtoWo1+v2m4ZLn2H4MxicwQ/j+2Ol4XneUvXHg7HBdFUU1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc/0J4dnZa3aRripSGpBsYMWNDnbEC+uRWVEnjB810s=;
 b=HgQynyv4n8mRRgU+bTc6KCrt1JSurlFoafDzWE8D7kxkLGL4zeJXKZ0/X8oWMAfPjbSic7OWDbmxvuywR99McrgZXgvsgD1wsJ1nGXGEKj7sLb9jVf+IdGkzAo15+npmS5pZ+74/si7eFSnj1vVoSL3h4NPk312WKDqqShWb2bNqB+IsAG7IxbHJQTs00wheFBUdYs6nZRJ2/eAUtHsezyDtuuhVKt6PrcaqbHaC9I7HrJe3DrBHDJ4xTjTATy+HkPG4tGVzl3ujYZQzj9M1ZcslGg8DoCrHxLDiRfoE6FA6VUn6Oqw//z9wBcwy05vpoh5RcoijXx8gi67lje5Crw==
Received: from SEZPR06MB5608.apcprd06.prod.outlook.com (2603:1096:101:c8::13)
 by JH0PR06MB6977.apcprd06.prod.outlook.com (2603:1096:990:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 05:35:28 +0000
Received: from SEZPR06MB5608.apcprd06.prod.outlook.com
 ([fe80::3786:2a86:9685:a19d]) by SEZPR06MB5608.apcprd06.prod.outlook.com
 ([fe80::3786:2a86:9685:a19d%2]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 05:35:28 +0000
From: Allen_Lin <allencl_lin@hotmail.com>
To: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Allen_Lin <allencl_lin@hotmail.com>
Subject: [PATCH v3 2/2] Input: Add Himax HX83102J touchscreen driver
Date: Wed, 27 Dec 2023 13:35:09 +0800
Message-ID:
 <SEZPR06MB560897A94EB645FC8FFD4FCE9E9FA@SEZPR06MB5608.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227053509.894642-1-allencl_lin@hotmail.com>
References: <20231227053509.894642-1-allencl_lin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [VZJ6nfetJ3cnd73euJWMgR1FG9Qh0NZH]
X-ClientProxiedBy: PS1PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::33) To SEZPR06MB5608.apcprd06.prod.outlook.com
 (2603:1096:101:c8::13)
X-Microsoft-Original-Message-ID:
 <20231227053509.894642-3-allencl_lin@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5608:EE_|JH0PR06MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e50038-673c-4985-34ea-08dc069da24a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tJATs5oML1QVqJXMmvP9gVOnEhucShGaneB1KMf85W6xX0R9ExkF3YTpQUU3Dikgpp9yAby+To1HkHDXwOPOkXElbuzES02u4je9el0WdNtZHalSL8t1Dn/6C2cr+kozFP86lCaVJF8NZ+kXeHSDrEWaJvSmhnOkK68Zxqrg74NUPOG8PQzMzX5APiGI7BmkHcF06ksVMDt5YNzwc2rkSXgHbVAgGYbJte+isq5X7iO2aU5YkhnfxAcav/OL0yetB79OfhAczW0APumoA/3jRC7PiT5AAgxSeHocQtYEVd1Lq1k87psRWe5/33ifuC2BAeAhS2UQLUQsf5cUuqkDplvANKZxFYYaOSGM4uu8EtwljPOIu98l0kAFmTPCF4F409HV1oKZxxRtzkVl/0sB36O+IVp2vtt94LbG8XbxquL0tcHWUovic8vuRrtUlepv5hJsj/b+brYlNzwdjV4FVVyiDXenZjogaySIG0y0kpkYFS2MD4Qjykp1oQEp+soWpLh+ErAn/uZCLhQazOBVlj8bMks5sOGEyBHQRxFbNcI+UGEZbpbll9zPP7j/7xxZYdcjcXuwc0Ka9/U0T/k3CSzYR4s0irS1aArmD1HvVW+2S9efm6YenVga1YaZbIBe
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ku6RH5El63uIAT36WxDy7QQ/tGTMySxdQAmRsoY5akYM0DBBj9jGT4YFpkTm?=
 =?us-ascii?Q?6sp/iYHHbIAAzHKYdzQqv95fJBeA6mzAKaMXBC+MU8ShbR/cbBOkpvwe/yRw?=
 =?us-ascii?Q?i371e3oFwCyQq9lxN8Sei8tvjpo2KP7K7lP852gwxrpWPY8G66/NUhMfbeJi?=
 =?us-ascii?Q?xz0Gogt65tjqfQJY4C+Ak6pngWwj81WUtt53LS6kqFdF4vOVXYnr7MAhukpf?=
 =?us-ascii?Q?11w/sNxangqXrNyqs0GhblYBRa1A0hUd6BFj2bamNfANeExg6RfamG4RDI+z?=
 =?us-ascii?Q?xMfpZKhKcg37GmHayogiZ3EGkrGRm/U6hVzmvYk8zLozlaJqxeQQeOMuJSBD?=
 =?us-ascii?Q?awlVMP3T0uY3x3/UZlvL5QVX/AfhflHe6qFg/2M3+u0u+TWbqcqQp2nSD24/?=
 =?us-ascii?Q?iUNDkaRiYLmnBPhg2FoEP/5dP1t8YbJVtUirfBYpO6KTpESaCXzS0qyOnwXv?=
 =?us-ascii?Q?obxj2yR47F550n3EG74mUcyHzHfbAnU30f5bw7zXIRqaJYPh76cQrRKzO/uK?=
 =?us-ascii?Q?YNqKDDHjKOL+2VxcrKfIySZC9yXQqg1DeLl2XTY5macrc2LGujOjxIK/n/Gf?=
 =?us-ascii?Q?RsEuaiSd/gdS5+Cw/yaoNV+6Tsw33NHLf9ir/Dex9/6lEgA2izLvdKDDCd9E?=
 =?us-ascii?Q?rXZpsfL3Gv+ULPdAbmb2C+LSukj9QYWWnui98VS6DXUugWt9hbGqAsU/Ojnj?=
 =?us-ascii?Q?C/mgUsSozjWfKRxvxhg4wJmmKeYbbu0SEfEvYMJd1fauYLLaCjvPu2LnFMpk?=
 =?us-ascii?Q?figGNQuPHhq8yzCWxYqWPZF4ZYk14/sDTzHU0FmUODeM7btDOUqGgmf+t9Gb?=
 =?us-ascii?Q?eA5jgx1ZaOXeLiflAPkw645+MLPNp/GPxnIq4crJzAJbSfMapNaozxC+iMcv?=
 =?us-ascii?Q?/PBRo69eEDYM4UqjxkMqqrugTawbqTHnkfl8HDlwQcLEqHzXqQ8t+bk5PuAM?=
 =?us-ascii?Q?i1Lri/GvAo/2exDoR2G+Et8junY0RQHgYtCUZ5wM7BdJVfUTXZhu3HAgy5jy?=
 =?us-ascii?Q?PPLlKUDhsjtWlU1OogFBnLllFYr6Bj5G8BwyuO3eSA6JhQyTFNHqwv+UapSd?=
 =?us-ascii?Q?fHVswIWz8Klg/7Vx1yrTdMpWurmduLZJKatacKx6onVS5nyaktuNQtAmEYxf?=
 =?us-ascii?Q?Z7bK8XRD6bF7fGpBMcEcKRqR4l/z3mB9S1deV70X4+dGbD2KcfD0WKRPsJJ9?=
 =?us-ascii?Q?7ebt++aJ8oy6RMf4UGratOXjbCplQg6NCFRjBQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e50038-673c-4985-34ea-08dc069da24a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5608.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 05:35:28.5947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6977

Add a new driver for Himax touchscreen series touchscreen controllers.
This driver supports Himax IC using the SPI interface to
acquire HID packets.

Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
---
 MAINTAINERS                    |    1 +
 drivers/hid/Kconfig            |    8 +
 drivers/hid/Makefile           |    2 +
 drivers/hid/hid-himax-83102j.c | 1096 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-himax-83102j.h |  202 ++++++
 5 files changed, 1309 insertions(+)
 create mode 100644 drivers/hid/hid-himax-83102j.c
 create mode 100644 drivers/hid/hid-himax-83102j.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6a92e40d126d..e9553edf0bf0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9507,6 +9507,7 @@ M:	Allen Lin <allencl_lin@hotmail.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/input/himax,hx83102j.yaml
+F:	drivers/hid/hid-himax-83102j.*
 
 HIMAX HX83112B TOUCHSCREEN SUPPORT
 M:	Job Noorman <job@noorman.info>
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4ce74af79657..e9bb95c288ec 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1325,6 +1325,14 @@ config HID_KUNIT_TEST
 
 	  If in doubt, say "N".
 
+config HID_HIMAX_HX83102J
+	tristate "Himax hx83102j touchpanel CHIPSET"
+	depends on HID
+	help
+	  Say Y here if you have a Himax CHIPSET touchscreen.
+	  HIMAX controllers are multi touch controllers which can
+	  report 10 touches at a time.
+	  If unsure, say N.
 endmenu
 
 source "drivers/hid/bpf/Kconfig"
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 8a06d0f840bc..3474a9d8c43d 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -169,3 +169,5 @@ obj-$(INTEL_ISH_FIRMWARE_DOWNLOADER)	+= intel-ish-hid/
 obj-$(CONFIG_AMD_SFH_HID)       += amd-sfh-hid/
 
 obj-$(CONFIG_SURFACE_HID_CORE)  += surface-hid/
+
+obj-$(CONFIG_HID_HIMAX_HX83102J)	+= hid-himax-83102j.o
diff --git a/drivers/hid/hid-himax-83102j.c b/drivers/hid/hid-himax-83102j.c
new file mode 100644
index 000000000000..414c5fb99885
--- /dev/null
+++ b/drivers/hid/hid-himax-83102j.c
@@ -0,0 +1,1096 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Himax hx83102j Driver Code for Common IC to simulate HID
+ *
+ *  Copyright (C) 2023 Himax Corporation.
+ */
+
+#include "hid-himax-83102j.h"
+
+static void hx83102j_pin_reset(struct himax_ts_data *ts);
+static void himax_ts_work(struct himax_ts_data *ts);
+static int himax_resume(struct device *dev);
+static int himax_suspend(struct device *dev);
+static int himax_chip_init(struct himax_ts_data *ts);
+static bool hx83102j_sense_off(struct himax_ts_data *ts, bool check_en);
+
+static int himax_spi_read(struct himax_ts_data *ts, u8 *cmd,
+			  u8 cmd_len, u8 *buf, u32 len)
+{
+	struct spi_message m;
+	int result = 0;
+	int retry;
+	int error;
+	struct spi_transfer	t = {
+		.len = cmd_len + len,
+	};
+
+	t.tx_buf = ts->xfer_data;
+	t.rx_buf = ts->xfer_data;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	for (retry = 0; retry < HIMAX_BUS_RETRY_TIMES; retry++) {
+		error = spi_sync(ts->spi, &m);
+		if (!unlikely(error))
+			break;
+	}
+
+	if (retry == HIMAX_BUS_RETRY_TIMES) {
+		dev_err(ts->dev, "SPI read error retry over %d", HIMAX_BUS_RETRY_TIMES);
+		result = -EIO;
+		goto err_retry_over;
+	} else {
+		memcpy(buf, ts->xfer_data + cmd_len, len);
+	}
+
+err_retry_over:
+	return result;
+}
+
+static int himax_spi_write(struct himax_ts_data *ts, u8 *buf,
+			   u32 length)
+{
+	int status;
+	struct spi_message	m;
+	struct spi_transfer	t = {
+			.tx_buf		= buf,
+			.len		= length,
+	};
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	status = spi_sync(ts->spi, &m);
+
+	if (status == 0) {
+		status = m.status;
+		if (status == 0)
+			status = m.actual_length;
+	}
+
+	return status;
+}
+
+static int himax_bus_read(struct himax_ts_data *ts, u8 cmd,
+		   u8 *buf, u32 len)
+{
+	int result = -1;
+	u8 hw_addr = 0x00;
+
+	if (len > HIMAX_BUS_R_DLEN) {
+		dev_err(ts->dev, "len[%d] is over %d", len, HIMAX_BUS_R_DLEN);
+		return result;
+	}
+
+	mutex_lock(&ts->rw_lock);
+
+	hw_addr = 0xF3;
+
+	memset(ts->xfer_data, 0, HIMAX_BUS_R_HLEN + len);
+	ts->xfer_data[0] = hw_addr;
+	ts->xfer_data[1] = cmd;
+	ts->xfer_data[2] = 0x00;
+	result = himax_spi_read(ts, ts->xfer_data, HIMAX_BUS_R_HLEN, buf, len);
+
+	mutex_unlock(&ts->rw_lock);
+
+	return result;
+}
+
+static int himax_bus_write(struct himax_ts_data *ts, u8 cmd,
+		    u8 *addr, u8 *data, u32 len)
+{
+	int result = -1;
+	u8 offset = 0;
+	u32 tmp_len = len;
+	u8 hw_addr = 0x00;
+
+	if (len > HIMAX_BUS_W_DLEN) {
+		dev_err(ts->dev, "len[%d] is over %d", len, HIMAX_BUS_W_DLEN);
+		return -EFAULT;
+	}
+
+	mutex_lock(&ts->rw_lock);
+
+	hw_addr = 0xF2;
+
+	ts->xfer_data[0] = hw_addr;
+	ts->xfer_data[1] = cmd;
+	offset = HIMAX_BUS_W_HLEN;
+
+	if (addr) {
+		memcpy(ts->xfer_data + offset, addr, 4);
+		offset += 4;
+		tmp_len -= 4;
+	}
+
+	if (data)
+		memcpy(ts->xfer_data + offset, data, tmp_len);
+
+	result = himax_spi_write(ts, ts->xfer_data, len + HIMAX_BUS_W_HLEN);
+
+	mutex_unlock(&ts->rw_lock);
+
+	return (result == len + HIMAX_BUS_W_HLEN) ? 0 : -EIO;
+}
+
+static void himax_int_enable(struct himax_ts_data *ts, int enable)
+{
+	unsigned long irqflags = 0;
+	int irqnum = ts->himax_irq;
+
+	spin_lock_irqsave(&ts->irq_lock, irqflags);
+	if (enable == 1 && atomic_read(&ts->irq_state) == 0) {
+		atomic_set(&ts->irq_state, 1);
+		enable_irq(irqnum);
+		ts->irq_enabled = 1;
+	} else if (enable == 0 && atomic_read(&ts->irq_state) == 1) {
+		atomic_set(&ts->irq_state, 0);
+		disable_irq_nosync(irqnum);
+		ts->irq_enabled = 0;
+	}
+
+	spin_unlock_irqrestore(&ts->irq_lock, irqflags);
+}
+
+static void himax_ts_isr_func(struct himax_ts_data *ts)
+{
+	himax_ts_work(ts);
+}
+
+static irqreturn_t himax_ts_thread(int irq, void *ptr)
+{
+	himax_ts_isr_func((struct himax_ts_data *)ptr);
+
+	return IRQ_HANDLED;
+}
+
+static int himax_int_register_trigger(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	if (ts->ic_data->HX_INT_IS_EDGE) {
+		ret = devm_request_threaded_irq(ts->dev, ts->himax_irq, NULL,
+					  himax_ts_thread, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					  ts->dev->driver->name, ts);
+	} else {
+		ret = devm_request_threaded_irq(ts->dev, ts->himax_irq, NULL,
+					  himax_ts_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					  ts->dev->driver->name, ts);
+	}
+
+	return ret;
+}
+
+static int himax_ts_register_interrupt(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	ts->irq_enabled = 0;
+
+	if (ts->himax_irq) {
+
+		ret = himax_int_register_trigger(ts);
+
+		if (ret == 0) {
+			ts->irq_enabled = 1;
+			atomic_set(&ts->irq_state, 1);
+		} else {
+
+			dev_err(ts->dev, "request_irq failed");
+		}
+	}
+
+	return ret;
+}
+
+static void himax_mcu_burst_enable(struct himax_ts_data *ts,
+				   u8 auto_add_4_byte)
+{
+	u8 tmp_data[HIMAX_REG_DATA_LEN];
+	int ret;
+
+	tmp_data[0] = HIMAX_IC_CMD_CONTI;
+
+	ret = himax_bus_write(ts, HIMAX_IC_ADR_CONTI, NULL, tmp_data, 1);
+	if (ret < 0) {
+		dev_err(ts->dev, "bus access fail!");
+		return;
+	}
+
+	tmp_data[0] = (HIMAX_IC_CMD_INCR4 | auto_add_4_byte);
+
+	ret = himax_bus_write(ts, HIMAX_IC_ADR_INCR4, NULL, tmp_data, 1);
+	if (ret < 0) {
+		dev_err(ts->dev, "bus access fail!");
+		return;
+	}
+}
+static int himax_mcu_register_read(struct himax_ts_data *ts, u32 addr,
+				   u8 *buf, u32 len)
+{
+	int ret = 0;
+	union {
+		u8 byte[4];
+		u32 word;
+	} target_addr = { .word = cpu_to_le32(addr) };
+	u8 direction_switch = HIMAX_IC_CMD_AHB_ACCESS_DIRECTION_READ;
+
+	mutex_lock(&ts->reg_lock);
+
+	if (addr == HIMAX_FLASH_ADDR_SPI200_DATA)
+		himax_mcu_burst_enable(ts, 0);
+	else if (len > HIMAX_REG_DATA_LEN)
+		himax_mcu_burst_enable(ts, 1);
+	else
+		himax_mcu_burst_enable(ts, 0);
+
+	ret = himax_bus_write(ts, HIMAX_IC_ADR_AHB_ADDR_BYTE_0, target_addr.byte, NULL, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "bus access fail!");
+		goto read_end;
+	}
+
+	ret = himax_bus_write(ts, HIMAX_IC_ADR_AHB_ACCESS_DIRECTION, NULL,
+			      &direction_switch, 1);
+	if (ret < 0) {
+		dev_err(ts->dev, "bus access fail!");
+		goto read_end;
+	}
+
+	ret = himax_bus_read(ts, HIMAX_IC_ADR_AHB_RDATA_BYTE_0, buf, len);
+	if (ret < 0) {
+		dev_err(ts->dev, "bus access fail!");
+		goto read_end;
+	}
+
+read_end:
+	mutex_unlock(&ts->reg_lock);
+
+	return ret;
+}
+
+static int himax_mcu_register_write(struct himax_ts_data *ts, u32 addr,
+				    u8 *val, u32 len)
+{
+	int ret = 0;
+	const u32 max_trans_sz = 4 * 1024;
+	int i = 0;
+	union {
+		u8 byte[4];
+		u16 half[2];
+		u32 word;
+	} target_addr;
+	u32 temp_len = 0;
+
+	mutex_lock(&ts->reg_lock);
+	if (addr == HIMAX_FLASH_ADDR_SPI200_DATA)
+		himax_mcu_burst_enable(ts, 0);
+	else if (len > HIMAX_REG_DATA_LEN)
+		himax_mcu_burst_enable(ts, 1);
+	else
+		himax_mcu_burst_enable(ts, 0);
+
+	if (len > max_trans_sz) {
+		for (i = 0; i < len; i += max_trans_sz) {
+			if ((len - i) > max_trans_sz)
+				temp_len = max_trans_sz;
+			else
+				temp_len = len % max_trans_sz;
+
+			target_addr.word = cpu_to_le32(addr + i);
+			ret = himax_bus_write(ts, HIMAX_IC_ADR_AHB_ADDR_BYTE_0,
+					      target_addr.byte, val + i, temp_len + HIMAX_REG_ADDR_LEN);
+			if (ret < 0) {
+				dev_err(ts->dev, "xfer fail!");
+				goto write_end;
+			}
+		}
+	} else {
+		target_addr.word = cpu_to_le32(addr);
+		ret = himax_bus_write(ts, HIMAX_IC_ADR_AHB_ADDR_BYTE_0, target_addr.byte, val,
+				      len + HIMAX_REG_ADDR_LEN);
+		if (ret < 0) {
+			dev_err(ts->dev, "xfer fail!");
+			goto write_end;
+		}
+	}
+write_end:
+	mutex_unlock(&ts->reg_lock);
+
+	return ret;
+}
+
+
+static void himax_ap_notify_fw_sus(struct himax_ts_data *ts, int suspend)
+{
+	int retry = 0;
+	int read_sts = 0;
+	union {
+		u8 byte[4];
+		u16 half[2];
+		u32 word;
+	} rdata, data;
+
+	if (suspend)
+		data.word = HIMAX_FW_DATA_AP_NOTIFY_FW_SUS_EN;
+	else
+		data.word = HIMAX_FW_DATA_AP_NOTIFY_FW_SUS_DIS;
+
+	data.word = cpu_to_le32(data.word);
+	do {
+		himax_mcu_register_write(ts, HIMAX_FW_ADDR_AP_NOTIFY_FW_SUS, data.byte,
+			4);
+		usleep_range(1000, 1001);
+		read_sts = himax_mcu_register_read(ts, HIMAX_FW_ADDR_AP_NOTIFY_FW_SUS, rdata.byte,
+			4);
+	} while ((retry++ < 10) && (read_sts != 0) &&
+		(rdata.word != data.word));
+}
+
+static void himax_resume_proc(struct himax_ts_data *ts, bool suspended)
+{
+		himax_ap_notify_fw_sus(ts, 0);
+}
+
+static void himax_mcu_ic_reset(struct himax_ts_data *ts, u8 loadconfig,
+			       u8 int_off)
+{
+
+	if (ts->gpiod_rst) {
+		if (int_off)
+			himax_int_enable(ts, 0);
+
+		hx83102j_pin_reset(ts);
+
+		if (int_off)
+			himax_int_enable(ts, 1);
+	}
+}
+static void himax_mcu_touch_information(struct himax_ts_data *ts)
+{
+	if (ts->ic_data->HX_RX_NUM == 0xFFFFFFFF)
+		ts->ic_data->HX_RX_NUM = 48;
+
+	if (ts->ic_data->HX_TX_NUM == 0xFFFFFFFF)
+		ts->ic_data->HX_TX_NUM = 32;
+
+	if (ts->ic_data->HX_BT_NUM == 0xFFFFFFFF)
+		ts->ic_data->HX_BT_NUM = 0;
+
+	if (ts->ic_data->HX_MAX_PT == 0xFFFFFFFF)
+		ts->ic_data->HX_MAX_PT = 10;
+
+	if (ts->ic_data->HX_INT_IS_EDGE == 0xFF)
+		ts->ic_data->HX_INT_IS_EDGE = false;
+
+	if (ts->ic_data->HX_STYLUS_FUNC == 0xFF)
+		ts->ic_data->HX_STYLUS_FUNC = 1;
+
+	if (ts->ic_data->HX_STYLUS_ID_V2 == 0xFF)
+		ts->ic_data->HX_STYLUS_ID_V2 = 0;
+
+	if (ts->ic_data->HX_STYLUS_RATIO == 0xFF)
+		ts->ic_data->HX_STYLUS_RATIO = 1;
+
+}
+static bool hx83102j_chip_detect(struct himax_ts_data *ts)
+{
+	union {
+		u8 byte[4];
+		u16 half[2];
+		u32 word;
+	} data;
+	bool ret_data = false;
+	int ret = 0;
+	int i = 0;
+	bool check_flash;
+
+	hx83102j_pin_reset(ts);
+	ret = himax_bus_read(ts, 0x13, data.byte, 1);
+	if (ret < 0) {
+		dev_err(ts->dev, "bus access fail!");
+		return false;
+	}
+
+	check_flash = false;
+
+	if (hx83102j_sense_off(ts, check_flash) == false) {
+		ret_data = false;
+		dev_err(ts->dev, "hx83102_sense_off Fail!");
+		return ret_data;
+	}
+
+	for (i = 0; i < 5; i++) {
+		ret = himax_mcu_register_read(ts, HIMAX_HX83102J_ICID_ADDR, data.byte, 4);
+		if (ret != 0) {
+			ret_data = false;
+			dev_err(ts->dev, "read ic id Fail");
+			return ret_data;
+		}
+
+		if ((data.word & 0xFFFFFF00) == HIMAX_HX83102J_ICID_DATA) {
+			strscpy(ts->chip_name,
+				HIMAX_HX83102J_ID, 30);
+			ts->ic_data->icid = data.word;
+			ret_data = true;
+			break;
+		}
+		dev_err(ts->dev, "Read driver IC ID = %X,%X,%X",
+		  data.byte[3], data.byte[2], data.byte[1]);
+		ret_data = false;
+		dev_err(ts->dev, "Read driver ID register Fail!");
+		dev_err(ts->dev, "Could NOT find Himax Chipset");
+		dev_err(ts->dev, "Please check:\n1.VCCD,VCCA,VSP,VSN");
+		dev_err(ts->dev, "2. LCM_RST,TP_RST");
+		dev_err(ts->dev, "3. Power On Sequence");
+	}
+
+	return ret_data;
+}
+static bool hx83102j_sense_off(struct himax_ts_data *ts, bool check_en)
+{
+	u32 cnt = 0;
+	union {
+		u8 byte[4];
+		u16 half[2];
+		u32 word;
+	} data;
+	int ret = 0;
+
+	do {
+		data.word = cpu_to_le32(HIMAX_FW_DATA_FW_STOP);
+		if (cnt == 0 ||
+		    (data.byte[0] != 0xA5 &&
+		    data.byte[0] != 0x00 &&
+		    data.byte[0] != 0x87))
+			himax_mcu_register_write(ts, HIMAX_FW_ADDR_CTRL_FW,
+				data.byte, 4);
+		usleep_range(10000, 10001);
+
+		himax_mcu_register_read(ts, HIMAX_IC_ADR_CS_CENTRAL_STATE,
+			data.byte, 4);
+
+		if (data.byte[0] != 0x05)
+			break;
+
+		himax_mcu_register_read(ts, HIMAX_FW_ADDR_CTRL_FW,
+			data.byte, 4);
+	} while (data.byte[0] != 0x87 && ++cnt < 35 && check_en);
+
+	cnt = 0;
+
+	do {
+		/**
+		 * set Enter safe mode : 0x31 ==> 0x9527
+		 */
+		data.half[0] = cpu_to_le16(HIMAX_HX83102J_SAFE_MODE_PASSWORD);
+		ret = himax_bus_write(ts, 0x31, NULL, data.byte, 2);
+		if (ret < 0) {
+			dev_err(ts->dev, "bus access fail!");
+			return false;
+		}
+
+		/**
+		 *Check enter_save_mode
+		 */
+		himax_mcu_register_read(ts, HIMAX_IC_ADR_CS_CENTRAL_STATE, data.byte, 4);
+
+		if (data.byte[0] == 0x0C) {
+			/**
+			 *Reset TCON
+			 */
+			data.word = 0;
+			himax_mcu_register_write(ts, HIMAX_HX83102J_IC_ADR_TCON_RST, data.byte, 4);
+			usleep_range(1000, 1001);
+			return true;
+		}
+		usleep_range(5000, 5001);
+		hx83102j_pin_reset(ts);
+	} while (cnt++ < 5);
+
+	return false;
+}
+
+static bool hx83102j_read_event_stack(struct himax_ts_data *ts,
+				      u8 *buf, u32 length)
+{
+	int ret = 0;
+
+	ret = himax_bus_read(ts, HIMAX_FW_ADDR_EVENT_ADDR, buf, length);
+
+	return (ret == 0) ? true : false;
+}
+
+static void hx83102j_pin_reset(struct himax_ts_data *ts)
+{
+	if (ts->gpiod_rst) {
+		gpiod_set_value(ts->gpiod_rst, 1);
+		usleep_range(100 * 100, 101 * 100);
+		gpiod_set_value(ts->gpiod_rst, 0);
+		usleep_range(200 * 100, 201 * 100);
+	}
+}
+
+static int himax_touch_get(struct himax_ts_data *ts, u8 *buf, int ts_path)
+{
+	u32 read_size = 0;
+	int ts_status = 0;
+
+	switch (ts_path) {
+	case HIMAX_REPORT_COORD:
+		read_size = ts->touch_all_size;
+		break;
+	default:
+		break;
+	}
+
+	if (read_size == 0) {
+		dev_err(ts->dev, "Read size fault!");
+		ts_status = HIMAX_TS_GET_DATA_FAIL;
+	} else {
+		if (!hx83102j_read_event_stack(ts, buf, read_size)) {
+			dev_err(ts->dev, "can't read data from chip!");
+			ts_status = HIMAX_TS_GET_DATA_FAIL;
+		}
+	}
+
+	return ts_status;
+}
+
+static int himax_hid_parse(struct hid_device *hid)
+{
+	struct himax_ts_data *ts = NULL;
+	int ret;
+
+	if (!hid) {
+		dev_err(ts->dev, "hid is NULL");
+		return -EINVAL;
+	}
+
+	ts = hid->driver_data;
+	if (!ts) {
+		dev_err(ts->dev, "hid->driver_data is NULL");
+		return -EINVAL;
+	}
+
+	ret = hid_parse_report(hid, ts->hid_rd_data.rd_data,
+			       ts->hid_rd_data.rd_length);
+	if (ret) {
+		dev_err(ts->dev, "failed parse report");
+		return	ret;
+	}
+	return 0;
+}
+
+static int himax_hid_start(struct hid_device *hid)
+{
+	return 0;
+}
+
+static void himax_hid_stop(struct hid_device *hid)
+{
+}
+
+static int himax_hid_open(struct hid_device *hid)
+{
+	return 0;
+}
+
+static void himax_hid_close(struct hid_device *hid)
+{
+}
+
+static int himax_hid_get_raw_report(const struct hid_device *hid, unsigned char reportnum,
+				 __u8 *buf, size_t len, unsigned char report_type)
+{
+	struct himax_ts_data *ts = NULL;
+	int ret = 0;
+
+	ts = hid->driver_data;
+	if (!ts) {
+		dev_err(ts->dev, "hid->driver_data is NULL");
+		return -EINVAL;
+	}
+
+
+	switch (reportnum) {
+	case ID_CONTACT_COUNT:
+		if (!ts->ic_data) {
+			dev_err(ts->dev, "ts->ic_data is NULL");
+			return -EINVAL;
+		}
+		buf[1] = ts->ic_data->HX_MAX_PT;
+		ret = len;
+		break;
+	default:
+		ret = -EINVAL;
+	};
+	return ret;
+}
+
+static int himax_raw_request(struct hid_device *hid, unsigned char reportnum,
+			  __u8 *buf, size_t len, unsigned char rtype, int reqtype)
+{
+	switch (reqtype) {
+	case HID_REQ_GET_REPORT:
+		return himax_hid_get_raw_report(hid, reportnum, buf, len, rtype);
+	default:
+		return -EIO;
+	}
+
+	return -EINVAL;
+}
+
+static struct hid_ll_driver himax_hid_ll_driver = {
+	.parse = himax_hid_parse,
+	.start = himax_hid_start,
+	.stop = himax_hid_stop,
+	.open = himax_hid_open,
+	.close = himax_hid_close,
+	.raw_request = himax_raw_request
+};
+
+static int himax_hid_report(const struct himax_ts_data *ts, u8 *data, s32 len)
+{
+	int ret = 0;
+
+	if (ts->hid)
+		ret = hid_input_report(ts->hid, HID_INPUT_REPORT, data, len, 1);
+
+	return ret;
+}
+static int himax_hid_probe(struct himax_ts_data *ts)
+{
+	int ret;
+	struct hid_device *hid = NULL;
+
+	if (!ts) {
+		dev_err(ts->dev, "ts is NULL");
+		return -EINVAL;
+	}
+	hid = ts->hid;
+	if (hid) {
+		hid_destroy_device(hid);
+		hid = NULL;
+	}
+
+	hid = hid_allocate_device();
+	if (IS_ERR(hid)) {
+		ret = PTR_ERR(hid);
+		return ret;
+	}
+
+	hid->driver_data = ts;
+	hid->ll_driver = &himax_hid_ll_driver;
+	hid->bus = BUS_SPI;
+	hid->dev.parent = &ts->spi->dev;
+
+	hid->version = ts->hid_desc.bcd_version;
+	hid->vendor = ts->hid_desc.vendor_id;
+	hid->product = ts->hid_desc.product_id;
+	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "hid-hxtp",
+		 hid->vendor, hid->product);
+
+	ret = hid_add_device(hid);
+	if (ret) {
+		dev_err(ts->dev, "failed add hid device");
+		goto err_hid_data;
+	}
+	ts->hid = hid;
+	mutex_unlock(&ts->hid_ioctl_lock);
+	return 0;
+
+err_hid_data:
+	hid_destroy_device(hid);
+	return ret;
+}
+
+static void himax_hid_remove(struct himax_ts_data *ts)
+{
+	mutex_lock(&ts->hid_ioctl_lock);
+	if (ts && ts->hid)
+		hid_destroy_device(ts->hid);
+	else
+		goto out;
+	ts->hid = NULL;
+out:
+	mutex_unlock(&ts->hid_ioctl_lock);
+}
+
+
+static int himax_ts_operation(struct himax_ts_data *ts,
+			      int ts_path)
+{
+	int ts_status = HIMAX_TS_NORMAL_END;
+	int ret = 0;
+	u32 offset = 0;
+
+	memset(ts->xfer_buff,
+	       0x00,
+		ts->touch_all_size * sizeof(u8));
+	ts_status = himax_touch_get(ts, ts->xfer_buff, ts_path);
+	if (ts_status == HIMAX_TS_GET_DATA_FAIL)
+		goto end_function;
+	if (ts->hid_probe) {
+		offset += ts->hid_desc.max_input_length;
+		if (ts->ic_data->HX_STYLUS_FUNC) {
+			ret += himax_hid_report(ts,
+				ts->xfer_buff + offset + HIMAX_HID_REPORT_HDR_SZ,
+				ts->hid_desc.max_input_length - HIMAX_HID_REPORT_HDR_SZ);
+			offset += ts->hid_desc.max_input_length;
+		}
+	}
+
+	if (ret != 0)
+		ts_status = HIMAX_TS_GET_DATA_FAIL;
+
+end_function:
+	return ts_status;
+}
+static void himax_ts_work(struct himax_ts_data *ts)
+{
+	int ts_status = HIMAX_TS_NORMAL_END;
+	int ts_path = 0;
+
+
+	ts_path = HIMAX_REPORT_COORD;
+	ts_status = himax_ts_operation(ts, ts_path);
+	if (ts_status == HIMAX_TS_GET_DATA_FAIL)
+		himax_mcu_ic_reset(ts, false, true);
+
+}
+
+static int himax_hid_rd_init(struct himax_ts_data *ts)
+{
+	int ret = 0;
+	u32 rd_sz = 0;
+
+	rd_sz = ts->hid_desc.report_desc_length;
+	if (ts->flash_ver_info.addr_hid_rd_desc != 0) {
+		if (ts->hid_rd_data.rd_data &&
+		    rd_sz != ts->hid_rd_data.rd_length) {
+			kfree(ts->hid_rd_data.rd_data);
+			ts->hid_rd_data.rd_data = NULL;
+		}
+
+		if (!ts->hid_rd_data.rd_data)
+			ts->hid_rd_data.rd_data = kzalloc(rd_sz, GFP_KERNEL);
+
+		if (ts->hid_rd_data.rd_data) {
+		} else {
+			dev_err(ts->dev, "hid rd data alloc fail");
+			ret = -ENOMEM;
+		}
+	}
+
+	return ret;
+}
+
+static void himax_hid_register(struct himax_ts_data *ts)
+{
+	if (ts->hid_probe) {
+		hid_destroy_device(ts->hid);
+		ts->hid = NULL;
+		ts->hid_probe = false;
+	}
+
+	if (himax_hid_probe(ts) != 0) {
+		dev_err(ts->dev, "hid probe fail");
+		ts->hid_probe = false;
+	} else {
+		ts->hid_probe = true;
+	}
+}
+
+static int himax_hid_report_data_init(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	ts->touch_info_size = ts->hid_desc.max_input_length;
+	if (ts->ic_data->HX_STYLUS_FUNC)
+		ts->touch_info_size += ts->hid_desc.max_input_length;
+
+	ts->touch_all_size = ts->touch_info_size;
+	return ret;
+}
+
+static void himax_hid_update(struct work_struct *work)
+{
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+			work_hid_update.work);
+
+	himax_int_enable(ts, false);
+	if (himax_hid_rd_init(ts) == 0) {
+		himax_hid_register(ts);
+		if (ts->hid_probe)
+			himax_hid_report_data_init(ts);
+	}
+	himax_int_enable(ts, true);
+}
+
+static int himax_chip_suspend(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	ts->suspended = true;
+	himax_int_enable(ts, false);
+	if (ts->gpiod_rst)
+		gpiod_set_value(ts->gpiod_rst, 1);
+	himax_hid_remove(ts);
+	return ret;
+}
+
+static int himax_chip_resume(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	ts->suspended = false;
+	if (ts->gpiod_rst)
+		gpiod_set_value(ts->gpiod_rst, 0);
+	himax_resume_proc(ts, ts->suspended);
+		himax_hid_probe(ts);
+		himax_int_enable(ts, true);
+	return ret;
+}
+
+static int himax_suspend(struct device *dev)
+{
+	struct himax_ts_data *ts = dev_get_drvdata(dev);
+
+	if (!ts->initialized) {
+		dev_err(ts->dev, "init not ready, skip!");
+		return -ECANCELED;
+	}
+	himax_chip_suspend(ts);
+	return 0;
+}
+
+static void himax_shutdown(struct spi_device *spi)
+{
+	struct himax_ts_data *ts = spi_get_drvdata(spi);
+
+	if (!ts->initialized) {
+		dev_err(ts->dev, "init not ready, skip!");
+		return;
+	}
+
+	himax_int_enable(ts, false);
+	himax_hid_remove(ts);
+}
+
+static int himax_resume(struct device *dev)
+{
+	int ret = 0;
+	struct himax_ts_data *ts = dev_get_drvdata(dev);
+
+	if (!ts->initialized) {
+		if (himax_chip_init(ts))
+			return -ECANCELED;
+	}
+	ret = himax_chip_resume(ts);
+	if (ret < 0)
+		dev_err(ts->dev, "resume failed!");
+	return ret;
+}
+static const struct dev_pm_ops himax_hid_pm = {
+	.suspend = himax_suspend,
+	.resume = himax_resume,
+	.restore = himax_resume,
+};
+
+#if defined(CONFIG_OF)
+static const struct of_device_id himax_table[] = {
+	{ .compatible = "himax,hx83102j" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, himax_table);
+#endif
+
+static int himax_chip_init(struct himax_ts_data *ts)
+{
+	himax_mcu_touch_information(ts);
+	spin_lock_init(&ts->irq_lock);
+	if (himax_ts_register_interrupt(ts)) {
+		dev_err(ts->dev, "register interrupt failed");
+		return -EIO;
+	}
+	himax_int_enable(ts, false);
+	INIT_DELAYED_WORK(&ts->work_hid_update, himax_hid_update);
+	ts->suspended = false;
+	ts->initialized = true;
+	return 0;
+
+}
+static bool himax_platform_init(struct himax_ts_data *ts,
+				struct himax_platform_data *local_pdata)
+{
+	struct himax_platform_data *pdata;
+
+	ts->xfer_buff = devm_kzalloc(ts->dev, HIMAX_FULL_STACK_SIZE, GFP_KERNEL);
+	if (!ts->xfer_buff)
+		return false;
+
+	pdata = devm_kzalloc(ts->dev, sizeof(struct himax_platform_data), GFP_KERNEL);
+	if (!pdata)
+		return false;
+
+
+	ts->ic_data = devm_kzalloc(ts->dev, sizeof(struct himax_ic_data), GFP_KERNEL);
+	if (!ts->ic_data)
+		return false;
+
+	memset(ts->ic_data, 0xFF, sizeof(struct himax_ic_data));
+	memcpy(pdata, local_pdata, sizeof(struct himax_platform_data));
+	ts->pdata = pdata;
+	pdata->ts = ts;
+	ts->gpiod_rst = pdata->gpiod_rst;
+	if (pdata->gpiod_rst)
+		gpiod_set_value(pdata->gpiod_rst, 1);
+	if (pdata->gpiod_rst)
+		gpiod_set_value(pdata->gpiod_rst, 0);
+
+	return true;
+}
+
+static int himax_spi_drv_probe(struct spi_device *spi)
+{
+	struct himax_ts_data *ts = NULL;
+	int ret = 0;
+	bool bret = false;
+	static struct himax_platform_data pdata = {0};
+
+	ts = devm_kzalloc(&spi->dev, sizeof(struct himax_ts_data), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	ts->dev = &spi->dev;
+	if (spi->master->flags & SPI_MASTER_HALF_DUPLEX) {
+		dev_err(ts->dev, "Full duplex not supported by host");
+		return -EIO;
+	}
+	pdata.ts = ts;
+	ts->dev = &spi->dev;
+	if (!spi->irq) {
+		dev_dbg(ts->dev, "no IRQ?\n");
+		return -EINVAL;
+	}
+	ts->himax_irq = spi->irq;
+	pdata.gpiod_rst = devm_gpiod_get(ts->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(pdata.gpiod_rst)) {
+		dev_err(ts->dev, "gpio-rst value is not valid");
+		return -EIO;
+	}
+
+
+	ts->xfer_data = devm_kzalloc(ts->dev, HIMAX_BUS_RW_MAX_LEN, GFP_KERNEL);
+	if (!ts->xfer_data)
+		return -ENOMEM;
+
+	spi->bits_per_word = 8;
+	spi->mode = SPI_MODE_3;
+	spi->chip_select = 0;
+
+	ts->spi = spi;
+	mutex_init(&ts->rw_lock);
+	mutex_init(&ts->reg_lock);
+	mutex_init(&ts->hid_ioctl_lock);
+	dev_set_drvdata(&spi->dev, ts);
+	spi_set_drvdata(spi, ts);
+
+	ts->probe_finish = false;
+	ts->initialized = false;
+	ts->ic_boot_done = false;
+	bret = himax_platform_init(ts, &pdata);
+	if (!bret) {
+		dev_err(ts->dev, "platform init failed");
+		return -ENODEV;
+	}
+
+	bret = hx83102j_chip_detect(ts);
+	if (!bret) {
+		dev_err(ts->dev, "IC detect failed");
+		return -ENODEV;
+	}
+
+	ret = himax_chip_init(ts);
+	if (ret < 0)
+		return ret;
+	ts->probe_finish = true;
+	return ret;
+
+}
+
+
+static void himax_spi_drv_remove(struct spi_device *spi)
+{
+	struct himax_ts_data *ts = spi_get_drvdata(spi);
+
+	if (ts->probe_finish) {
+		if (ts->ic_boot_done) {
+			himax_int_enable(ts, false);
+
+			if (ts->hid_probe) {
+				himax_hid_remove(ts);
+				ts->hid_probe = false;
+			}
+
+			kfree(ts->hid_rd_data.rd_data);
+			ts->hid_rd_data.rd_data = NULL;
+
+			ts->ic_boot_done = false;
+		}
+	}
+	spi_set_drvdata(spi, NULL);
+
+}
+static struct spi_driver himax_hid_over_spi_driver = {
+	.driver = {
+		.name =		"hx83102j",
+		.owner =	THIS_MODULE,
+		.pm	= &himax_hid_pm,
+#if defined(CONFIG_OF)
+		.of_match_table = of_match_ptr(himax_table),
+#endif
+	},
+	.probe =	himax_spi_drv_probe,
+	.remove =	himax_spi_drv_remove,
+	.shutdown =	himax_shutdown,
+};
+static void himax_spi_drv_exit(void)
+{
+	spi_unregister_driver(&himax_hid_over_spi_driver);
+}
+
+static int himax_spi_drv_init(void)
+{
+	int ret;
+
+	ret = spi_register_driver(&himax_hid_over_spi_driver);
+	return ret;
+}
+
+static int __init himax_ic_init(void)
+{
+	int ret = 0;
+
+	ret = himax_spi_drv_init();
+	return ret;
+}
+
+static void __exit himax_ic_exit(void)
+{
+	himax_spi_drv_exit();
+}
+
+#if !defined(CONFIG_HID_HIMAX)
+module_init(himax_ic_init);
+#else
+late_initcall(himax_ic_init);
+#endif
+module_exit(himax_ic_exit);
+
+MODULE_DESCRIPTION("Himax SPI driver for HID simulator for " HIMAX_HX83102J_ID);
+MODULE_AUTHOR("Himax, Inc.");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-himax-83102j.h b/drivers/hid/hid-himax-83102j.h
new file mode 100644
index 000000000000..61e9d006f9be
--- /dev/null
+++ b/drivers/hid/hid-himax-83102j.h
@@ -0,0 +1,202 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __HX_IC_83102J_H__
+#define __HX_IC_83102J_H__
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/regulator/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/acpi.h>
+#include <linux/spi/spi.h>
+#include <linux/hid.h>
+#include <linux/sizes.h>
+#include <linux/fs.h>
+#include <linux/gpio.h>
+#include <linux/types.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/proc_fs.h>
+#include <linux/version.h>
+#include <linux/firmware.h>
+#include <linux/stddef.h>
+#include <linux/power_supply.h>
+
+#define HIMAX_BUS_RETRY_TIMES 3
+// SPI bus read/write max length
+#define HIMAX_BUS_RW_MAX_LEN 0x20006
+// SPI bus read header length
+#define HIMAX_BUS_R_HLEN 3
+// SPI bus read data length, must be multiple of 4 and smaller than BUS_RW_MAX_LEN - BUS_R_HLEN
+#define HIMAX_BUS_R_DLEN ((HIMAX_BUS_RW_MAX_LEN - HIMAX_BUS_R_HLEN) - ((HIMAX_BUS_RW_MAX_LEN - HIMAX_BUS_R_HLEN) % 4))
+// SPI bus write header length
+#define HIMAX_BUS_W_HLEN 2
+// SPI bus write data length, must be multiple of 4 and smaller than BUS_RW_MAX_LEN - BUS_W_HLEN
+#define HIMAX_BUS_W_DLEN ((HIMAX_BUS_RW_MAX_LEN - HIMAX_BUS_W_HLEN) - ((HIMAX_BUS_RW_MAX_LEN - HIMAX_BUS_W_HLEN) % 4))
+
+enum HID_ID_FUNCT {
+	ID_CONTACT_COUNT = 0x03,
+};
+
+enum HID_FW_UPDATE_STATUS_CODE {
+	FWUP_ERROR_NO_ERROR = 0x77,
+	FWUP_ERROR_NO_MAIN = 0xC2,
+	FWUP_ERROR_BL_COMPLETE = 0xB1,
+	FWUP_ERROR_BL = 0xB2,
+	FWUP_ERROR_FLASH_PROGRAMMING = 0xB5,
+};
+
+
+// Register setting
+#define HIMAX_REG_DATA_LEN			4
+#define HIMAX_REG_ADDR_LEN			4
+#define HIMAX_MAX_TRANS_SZ			128
+#define HIMAX_MAX_RETRY_TIMES			5
+
+#define HIMAX_HX83102J_STACK_SIZE			128
+#define HIMAX_HX83102J_IC_ADR_TCON_RST     0x80020004
+#define HIMAX_HX83102J_SAFE_MODE_PASSWORD			0x9527
+#define HIMAX_HX83102J_ICID_ADDR					0x900000D0
+#define HIMAX_HX83102J_ICID_DATA					0x83102900
+#define HIMAX_HX83102J_MAX_RX_NUM			48
+#define HIMAX_HX83102J_MAX_TX_NUM			32
+
+#define HIMAX_IC_ADR_AHB_ADDR_BYTE_0           0x00
+#define HIMAX_IC_ADR_AHB_RDATA_BYTE_0          0x08
+#define HIMAX_IC_ADR_AHB_ACCESS_DIRECTION      0x0c
+#define HIMAX_IC_ADR_CONTI                     0x13
+#define HIMAX_IC_ADR_INCR4                     0x0D
+#define HIMAX_IC_CMD_AHB_ACCESS_DIRECTION_READ 0x00
+#define HIMAX_IC_CMD_CONTI                     0x31
+#define HIMAX_IC_CMD_INCR4                     0x10
+#define HIMAX_IC_ADR_CS_CENTRAL_STATE          0x900000A8
+
+#define HIMAX_FW_ADDR_CTRL_FW                     0x9000005c
+#define HIMAX_FW_USB_DETECT_ADDR                  0x10007F38
+#define HIMAX_FW_DATA_SAFE_MODE_RELEASE_PW_RESET  0x00000000
+#define HIMAX_FW_DATA_FW_STOP                     0x000000A5
+#define HIMAX_FW_ADDR_AP_NOTIFY_FW_SUS            0x10007FD0
+#define HIMAX_FW_DATA_AP_NOTIFY_FW_SUS_EN         0xA55AA55A
+#define HIMAX_FW_DATA_AP_NOTIFY_FW_SUS_DIS        0x00000000
+#define HIMAX_FW_ADDR_EVENT_ADDR                  0x30
+#define HIMAX_FW_FUNC_HANDSHAKING_PWD             0xA55AA55A
+
+#define HIMAX_FLASH_ADDR_CTRL_BASE           0x80000000
+#define HIMAX_FLASH_ADDR_SPI200_DATA         (HIMAX_FLASH_ADDR_CTRL_BASE + 0x2c)
+
+#define HIMAX_HID_REPORT_HDR_SZ (2)
+#define HIMAX_HX83102J_ID		"HX83102J"
+
+
+struct flash_version_info {
+	u32 addr_hid_rd_desc;
+};
+
+struct himax_hid_rd_data_t {
+	u8 *rd_data;
+	u32 rd_length;
+};
+union himax_dword_data_t {
+	u32 dword;
+	u8 byte[4];
+};
+
+enum hid_reg_action {
+	REG_READ = 0,
+	REG_WRITE = 1
+};
+
+enum hid_reg_types {
+	REG_TYPE_EXT_AHB,
+	REG_TYPE_EXT_SRAM,
+	REG_TYPE_EXT_TYPE = 0xFFFFFFFF
+};
+struct himax_hid_req_cfg_t {
+	u32 data_type;
+	u32 input_RD_de;
+};
+
+#define HIMAX_FULL_STACK_SIZE \
+	(HIMAX_HX83102J_STACK_SIZE +\
+	(2 + HIMAX_HX83102J_MAX_RX_NUM * HIMAX_HX83102J_MAX_TX_NUM + HIMAX_HX83102J_MAX_TX_NUM + HIMAX_HX83102J_MAX_RX_NUM)\
+	* 2)
+
+struct himax_ic_data {
+	u32 HX_RX_NUM;
+	u32 HX_TX_NUM;
+	u32 HX_BT_NUM;
+	u32 HX_MAX_PT;
+	u8 HX_INT_IS_EDGE;
+	u8 HX_STYLUS_FUNC;
+	u8 HX_STYLUS_ID_V2;
+	u8 HX_STYLUS_RATIO;
+	u32 icid;
+};
+
+enum HX_TS_PATH {
+	HIMAX_REPORT_COORD = 1,
+};
+
+enum HX_TS_STATUS {
+	HIMAX_TS_GET_DATA_FAIL = -4,
+	HIMAX_TS_NORMAL_END = 0,
+};
+
+struct himax_hid_desc_t {
+	u16 desc_length;
+	u16 bcd_version;
+	u16 report_desc_length;
+	u16 max_input_length;
+	u16 max_output_length;
+	u16 max_fragment_length;
+	u16 vendor_id;
+	u16 product_id;
+	u16 version_id;
+	u16 flags;
+	u32 reserved;
+} __packed;
+
+struct himax_ts_data {
+	bool initialized;
+	bool probe_finish;
+	bool suspended;
+	char chip_name[30];
+	bool ic_boot_done;
+	u8 *xfer_data;
+	struct himax_ic_data *ic_data;
+	int touch_all_size;
+	int touch_info_size;
+	struct flash_version_info flash_ver_info;
+	u8 irq_enabled;
+	struct gpio_desc *gpiod_rst;
+	s32 (*power)(s32 on);
+	struct device *dev;
+	struct himax_platform_data *pdata;
+	/* mutex lock for reg access */
+	struct mutex reg_lock;
+	/* mutex lock for read/write action */
+	struct mutex rw_lock;
+	/* mutex lock for hid ioctl action */
+	struct mutex hid_ioctl_lock;
+	atomic_t irq_state;
+	/* spin lock for irq */
+	spinlock_t irq_lock;
+	struct spi_device	*spi;
+	s32 himax_irq;
+	u8 *xfer_buff;
+	struct hid_device *hid;
+	struct himax_hid_desc_t hid_desc;
+	struct himax_hid_rd_data_t hid_rd_data;
+	bool hid_probe;
+	struct delayed_work work_hid_update;
+};
+
+struct himax_platform_data {
+	struct himax_ts_data *ts;
+	struct gpio_desc *gpiod_rst;
+};
+
+#endif
-- 
2.34.1



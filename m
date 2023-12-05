Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC53804FCD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345001AbjLEKG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346663AbjLEKGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:06:21 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2055.outbound.protection.outlook.com [40.92.53.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F86116;
        Tue,  5 Dec 2023 02:06:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJy80ZIUEWXvkQfguF3irveMxX84sQEPg2W/Tn0VOu9ru1xQoPl0iA0BR+eFHceWYp+DZQViRNYh7aQKibkHk5ztjFtRN5jEpcYq3czhomHEHrF66GBZLbmB+KWLjr6WMcxPS0cLW7QwASqHKfZYrQoytI7fyvnbASqF0HiHc+L3JQ9hso0j8TLq8tzTm/P6DfGwcnO6SWY2vTQ895X0pzY9LfLll15szhoYLJ1Bh7W0xguwQxkZiQNq42LEvN1CMbm7L5AE42E0n+k6vl0CLF6XuhCWJjxls8hxwVWqPoH85NK9nwb2oBbbjAwleMDCUX3W4rbrZaBW5boqvonoXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSKaUd3bF8UueXjnYRITWq/7ESfAeIvGVchiunUTjtE=;
 b=mCaA2FYvg6n53eU+fc3Sf4oFPCjN2dloMcVO0AYiskruQbDT414GXwZhvjVy2q7eGEYvYdsHejBs/cXKUj17fZ5m1ZKyUzO7q+UloO+Zb45ZWBNExeCFUu/m50a16VjSqqT3CRfwkZk8oy35TLpHZxYh/riZ9u2Ip0Pdf+HTUuW7Y/y0BcLqFJo4QEK5p13okCgDbLGtIIbTtdDUvPD0bjrA2MvGDB1A9urnLfCVwoZuO7OTbm2wubPOOiXbSzrDRjKLgGhZnSaR9gD5DUDlSeaZLOv2izsp0/ng2pNg4Qrkx34TqT+nl5/CeQQKBk9tLEnOsiNnGypisd6uevIK4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSKaUd3bF8UueXjnYRITWq/7ESfAeIvGVchiunUTjtE=;
 b=IJ0+6/NiOZpjhHBnQB7SRM2Jthwj12ldAEMi7rQnSk13c/DYtLKkLX8BtfDlL/A/+hKKREGroZsfXKR+i+D0gUHVA9ZxHfsvP+OfJa8GLVNaTDnip4ki1tG7u2Eu6dyMbXSeESFZ6PZ0QnyKUwg3X08ZS2r6DtR/osBVWhDXduu8mjoqGOoEjOxf9PVUs89BScDieBpgQcAOXsf6rSSpFpNEV2FDqsWs6GwSmFQ5DbyFMWBAPUFSdBHC/YDgpyMQz+BMPsS0ZNzHc51TurYtfyUtPMRqfOICLxTHqzSwSsoJ0Ct9V7oBr1WH5cHZqGa7f9skPDiRYMnR2boV3HYbMA==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by SEYPR06MB6587.apcprd06.prod.outlook.com (2603:1096:101:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 10:06:12 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::f2fd:d852:e4b9:6166]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::f2fd:d852:e4b9:6166%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 10:06:12 +0000
From:   Allen_Lin <allencl_lin@hotmail.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Allen_Lin <allencl_lin@hotmail.com>
Subject: [PATCH v1 2/2] Input: Add Himax HX83102J touchscreen driver
Date:   Tue,  5 Dec 2023 18:05:52 +0800
Message-ID: <TY0PR06MB5611228C6B67733DC93842C99E85A@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205100552.723620-1-allencl_lin@hotmail.com>
References: <20231205100552.723620-1-allencl_lin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [phpfMsHw3zLtXDkdMjrXzbzA/LmQmJxYw2ofxDtJph2uBkNNJJPo3alPCCULW29GIfiF7gRUKa0=]
X-ClientProxiedBy: TYCPR01CA0102.jpnprd01.prod.outlook.com
 (2603:1096:405:4::18) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID: <20231205100552.723620-3-allencl_lin@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|SEYPR06MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: f176824d-548e-4946-21e7-08dbf579cf53
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mV1rgknZ8bIMY7wFZpclOtACE6mf1yE646Bt/97pi7VFuuj3q618ekhN0CmcKCxyYt4ayLUyBwHSzvtO2NhbizGJsUoehYFc57f075dzDAW4wPLzWYm85vBd/BAKqDcIiyikuVjgyMztksMrf2OrKjqGXcpy0etqwYHyUOZgGoKDhTUP1g3SaajPbb27FFg+JWm3xjqNAEIypV4xXVQ1WAZjfJNJyHRFrjl3/8+cGqDj1tEqA/QoKZnpSOGBPhd29km8A/yJCiwFc20pCjt4cLwJ7e4fliUGwqFr60BeLrRkwdS1/xT7AX68whYfywaOhnjq2Wupc+yY5kkr89lJEbItOty+KtPdvs9P1CTVQHm4w+FiMtcdVenng8MuTUuS74WhOqlTR3GKXEYosD+7ar6kG1Q1o8Ck6G/iKR+tTEgm3sJGyJUJjk0Cuxub0PqojFGNI0lJcBqh7vVGeWdXBaZoQPM2ZT/beeTm+725aNejFaepxugwd2CNWCUVSdNHHAizyWSK61vCdWLmKAg3pjCJwrAZAZ+iuUC4olUDhlE7yUbEMmQbnNb9oalnwDdfscRVURGlwBSFTVFU/EVi4grRmH+xL+ZYXLZ5jMGW1guwfOGnFs+vswJ+xBNvqidF
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U/lQiLOL1Kd5Th7FBXVXw+rZ2N/iuWCNPwA5ZP/sPyM6rE8/8vwb8SLduLuB?=
 =?us-ascii?Q?aW89hv0Qyrj7CwbrPj/Zt79WMHqbrTsk4Pt8zoSyAO54qyueksWJ45bH0WmY?=
 =?us-ascii?Q?8ncrXT4eJrATEAwpbU953sy70OHLUJdKGxIQQ/0QMBawaQfn3dvDCz2io4rO?=
 =?us-ascii?Q?BQh35cR5FDMANdybjNGI2iABN0kV7OeocTVUgPuFFKwcSogGWTPHAl9bpZt2?=
 =?us-ascii?Q?Cy/+BivqsxhVtYUv1T9T1Qow4cTeIjSwX3TAIYUlPspYh48bOvsg3V3AA+jq?=
 =?us-ascii?Q?sPpIGZ009HiVG76WSgbdSe2wGTZZ3diZyGJSezj+fFWY5F8Kwc1SKLhejqi6?=
 =?us-ascii?Q?aSkl5ZbPE6voP+1r4EFVh1/O763LH08Qd2y9uKHndGqeYUGAegB6HKkSdgHH?=
 =?us-ascii?Q?yrKkFE7r3wRY0CARfJeWyPqTwYDMeJ4Ml9+s+ADyh7aQTSE+p5gN0g+S5pN9?=
 =?us-ascii?Q?KsNkb/O2nquL88W8Ow1Lo/ck1A0EPQ/eozyeBm9i5bHYY816qd0sLo7zWY6e?=
 =?us-ascii?Q?/uKNWf1VN5QYxZPriEBlCzOypDB6jOYRHPVv+YcC5Ehs5Nuu3leR3pqmZei7?=
 =?us-ascii?Q?tpgRfreD4BS9h/NwlaYDuooTVxBbELPff622n7f9KBZWgdE/GlWrvjVHw5Mb?=
 =?us-ascii?Q?67RNolrrseft+KGIDIBUaPq2ubIIgai3dAPT0lWdWBs1GkHgxZ24SUxMkCN1?=
 =?us-ascii?Q?/D2yes89VJUr0vNSZTFGD7PmZN4KCGlaWhChL0S90XgsYcJ8XT9nGV0uhWvS?=
 =?us-ascii?Q?yO0omz4MBuvMNTX9U1na2/EVPA70k5ueJfb/cXRVOET2/hc+e3FuLlsomvC7?=
 =?us-ascii?Q?zxGwRQk/D2gYcuOW6ykVkKgutLHtn0FAGSvD1t2uhQbitrvOC6k08+MllZmu?=
 =?us-ascii?Q?pXqDnCmoudh7v5JRkJkaky2AnYL9RF336sDsc8PuAnl5EI3Ea29+blW1LQNJ?=
 =?us-ascii?Q?UWFXMS3Yr8eFd1LqBzZPcBL3e5ylXpnR7Cy+vgaFlX1iHt/GWNdenakDkOgl?=
 =?us-ascii?Q?2K4+LBToJXmzBi0y4lsxo3qTFV5/A2MabEaNB0WYwDiy2dcSo2qwtCYMKONr?=
 =?us-ascii?Q?KrCuehY0ThUgXZ/TBWE9lN/mJ1tAdhGIS/jfuTIu69HXRRxC9xwZUE9xHKFN?=
 =?us-ascii?Q?D1GYyNM+MUqtQLnU6OtOzrCfYHC+zS6zBovs2q70Nu4EIZjHsTEhYPdsDEai?=
 =?us-ascii?Q?6HonX7BSJUhJVadxTP5a49JRY1Qf/DI0fYA4gnV/SOOLMUFDT8+0MQKKH1RX?=
 =?us-ascii?Q?rZdK5GVMn0/LLeekmk/cHDp1ReDDcugOCWAZQCU+vDr3E5aD2N3GWKTymh/C?=
 =?us-ascii?Q?YbI=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f176824d-548e-4946-21e7-08dbf579cf53
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 10:06:12.8315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6587
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new driver for Himax  touchscreen series touchscreen controllers.
This driver supports Himax IC using the SPI interface to
acquire HID packets.

Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
---
 MAINTAINERS                    |    2 +
 drivers/hid/Kconfig            |    9 +-
 drivers/hid/Makefile           |    2 +-
 drivers/hid/hid-himax-83102j.c | 3176 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-himax-83102j.h |  927 ++++++++++
 5 files changed, 4114 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hid/hid-himax-83102j.c
 create mode 100644 drivers/hid/hid-himax-83102j.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cadcbf7294a6..d0d5ab7ea1e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9507,6 +9507,8 @@ M:	Allen Lin <allencl_lin@hotmail.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/input/himax,hx8310xx.yaml
+F:	drivers/hid/hid-himax-83102j.c
+F:	drivers/hid/hid-himax-83102j.h
 
 HIMAX HX83112B TOUCHSCREEN SUPPORT
 M:	Job Noorman <job@noorman.info>
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4ce74af79657..896af236c1f8 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1324,7 +1324,14 @@ config HID_KUNIT_TEST
 	  Documentation/dev-tools/kunit/.
 
 	  If in doubt, say "N".
-
+config HID_HIMAX
+	tristate "Himax touchpanel CHIPSET"
+	depends on HID
+	help
+	  Say Y here if you have a Himax CHIPSET touchscreen.
+	  HIMAX controllers are multi touch controllers which can
+	  report 10 touches at a time.
+	  If unsure, say N.
 endmenu
 
 source "drivers/hid/bpf/Kconfig"
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 8a06d0f840bc..a0f0fc3261e0 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -156,7 +156,7 @@ hid-uclogic-test-objs		:= hid-uclogic-rdesc.o \
 				   hid-uclogic-params.o \
 				   hid-uclogic-rdesc-test.o
 obj-$(CONFIG_HID_KUNIT_TEST)	+= hid-uclogic-test.o
-
+obj-$(CONFIG_HID_HIMAX)		+= hid-himax-83102j.o
 obj-$(CONFIG_USB_HID)		+= usbhid/
 obj-$(CONFIG_USB_MOUSE)		+= usbhid/
 obj-$(CONFIG_USB_KBD)		+= usbhid/
diff --git a/drivers/hid/hid-himax-83102j.c b/drivers/hid/hid-himax-83102j.c
new file mode 100644
index 000000000000..fa1b22477457
--- /dev/null
+++ b/drivers/hid/hid-himax-83102j.c
@@ -0,0 +1,3176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Himax Driver Code for HX83102J to simulate HID
+ *
+ *  Copyright (C) 2023 Himax Corporation.
+ *
+ *  This software is licensed under the terms of the GNU General Public
+ *  License version 2,  as published by the Free Software Foundation,  and
+ *  may be copied,  distributed,  and modified under those terms.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include "hid-himax-83102j.h"
+
+struct himax_ts_data *g_himax_ts;
+struct himax_core_fp g_core_fp;
+
+#define FW_EXT_NAME(FWNAME)	FWNAME ".bin"
+char *g_fw_boot_upgrade_name = FW_EXT_NAME(BOOT_UPGRADE_FWNAME);
+struct himax_core_command_regs g_core_regs;
+
+
+union host_ext_rd_t g_host_ext_rd = {
+	.host_report_descriptor = {
+		0x06, 0x00, 0xFF,// Usage Page (Vendor-defined)
+		0x09, 0x01,// Usage (0x1)
+		0xA1, 0x01,// Collection (Application)
+		0x75, 0x08,// Report Size (8)
+		0x15, 0x00,// Logical Minimum (0)
+		0x26, 0xFF, 0x00,// Logical Maximum (255)
+		0x85, 0x05,// Report ID (5)
+		0x09, 0x02,// Usage (0x2)
+		0x96, 0xFF, 0x00,// Report Count (255)
+		0xB1, 0x02,// Feature (ID: 5, sz: 2040 bits(255 bytes))
+		0x85, 0x06,// Report ID (6)
+		0x09, 0x02,// Usage (0x2)
+		0x96, (HID_REG_SZ_MAX & 0xFF), (HID_REG_SZ_MAX >> 8),
+		0xB1, 0x02,// Feature (ID: 6, sz: 72 bits(9 bytes))
+		0x85, 0x07,// Report ID (7)
+		0x09, 0x02,// Usage (0x2)
+		0x96, 0x04, 0x00,// Report Count (4)
+		0xB1, 0x02,// Feature (ID: 7, sz: 32 bits(4 bytes))
+		0x85, 0x08,// Report ID (8)
+		0x09, 0x02,// Usage (0x2)
+		0x96, 0x8D, 0x13,// Report Count (5005)
+		0xB1, 0x02,// Feature (ID: 8, sz: 40040 bits(5005 bytes))
+		// 0x85, 0x09,// Report ID (9)
+		// 0x09, 0x02,// Usage (0x2)
+		// 0x96, 0x4F, 0x03,// Report Count (847)
+		// 0xB1, 0x02,// Feature (ID: 9, sz: 6776 bits(847 bytes))
+		0x85, 0x0A,// Report ID (10)
+		0x09, 0x02,// Usage (0x2)
+		0x96, 0x00, 0x04,// Report Count (1024)
+		0x91, 0x02,// Output (ID: 10, sz: 8192 bits(1024 bytes))
+		0x85, 0x0B,// Report ID (11)
+		0x09, 0x02,// Usage (0x2)
+		0x96, 0x01, 0x00,// Report Count (1)
+		0xB1, 0x02,// Feature (ID: 11, sz: 8 bits(1 bytes))
+		0x85, 0x0C,// Report ID (12)
+		0x09, 0x02,// Usage (0x2)
+		0x96, 0x01, 0x00,// Report Count (1)
+		0xB1, 0x02,// Feature (ID: 12, sz: 8 bits(1 bytes))
+		0x85, 0x31,// Report ID (49)
+		0x09, 0x02,// Usage (0x2)
+		0x96, 0x01, 0x00,// Report Count (1)
+		0xB1, 0x02,// Feature (ID: 49, sz: 8 bits(1 bytes))
+		0xC0,// End Collection
+	},
+};
+
+const unsigned int host_ext_report_desc_sz =
+	sizeof(g_host_ext_rd.host_report_descriptor);
+
+union heatmap_rd_t g_heatmap_rd = {
+	.host_report_descriptor = {
+		0x05, 0x0D,// Usage Page (Digitizers)
+		0x09, 0x0F,// Usage (0xF)
+		0xA1, 0x01,// Collection (Application)
+		0x85, 0x61,// Report ID (97)
+		0x05, 0x0D,// Usage Page (Digitizers)
+		0x15, 0x00,// Logical Minimum (0)
+		0x27, 0xFF, 0xFF, 0x00, 0x00,// Logical Maximum (65535)
+		0x75, 0x10,// Report Size (16)
+		0x95, 0x01,// Report Count (1)
+		0x09, 0x6A,// Usage (0x6A)
+		0x81, 0x02,// Input (ID: 97, sz: 16 bits(2 bytes))
+		0x09, 0x6B,// Usage (0x6B)
+		0x81, 0x02,// Input (ID: 97, sz: 16 bits(2 bytes))
+		0x27, 0xFF, 0xFF, 0xFF, 0xFF,// Logical Maximum (-1)
+		0x75, 0x20,// Report Size (32)
+		0x09, 0x56,// Usage (0x56)
+		0x81, 0x02,// Input (ID: 97, sz: 32 bits(4 bytes))
+		0x05, 0x01,// Usage Page (Generic Desktop)
+		0x09, 0x3B,// Usage (0x3B)
+		0x81, 0x02,// Input (ID: 97, sz: 32 bits(4 bytes))
+		0x05, 0x0D,// Usage Page (Digitizers)
+		0x26, 0xFF, 0x00,// Logical Maximum (255)
+		0x09, 0x6C,// Usage (0x6C)
+		0x75, 0x08,// Report Size (8)
+		0x96, 0x00, 0x0C,// Report Count (3072)
+		0x81, 0x02,// Input (ID: 97, sz: 24576 bits(3072 bytes))
+		0xC0,// End Collection
+	},
+};
+
+const unsigned int host_heatmap_report_desc_sz =
+	sizeof(g_heatmap_rd.host_report_descriptor);
+
+void himax_rst_gpio_set(int pinnum, u8 value)
+{
+	gpio_direction_output(pinnum, value);
+}
+
+int himax_gpio_power_config(struct himax_ts_data *ts,
+			    struct himax_platform_data *pdata)
+{
+	int error = 0;
+
+	if (gpio_is_valid(pdata->gpio_reset)) {
+		error = gpio_request(pdata->gpio_reset, "himax-reset");
+
+		if (error < 0) {
+			E("request reset pin failed");
+			goto err_gpio_reset_req;
+		}
+
+		error = gpio_direction_output(pdata->gpio_reset, 0);
+
+		if (error) {
+			E("unable to set direction for gpio [%d]",
+			  pdata->gpio_reset);
+			goto err_gpio_reset_dir;
+		}
+	}
+
+	if (pdata->vccd_supply) {
+		error = regulator_enable(pdata->vccd_supply);
+		if (error) {
+			E("unable to enable vccd supply");
+			goto err_vccd_supply_enable;
+		}
+	}
+
+	if (pdata->vcca_supply) {
+		error = regulator_enable(pdata->vcca_supply);
+		if (error) {
+			E("unable to enable vcca supply");
+			goto err_vcca_supply_enable;
+		}
+	}
+
+	if (gpio_is_valid(pdata->gpio_irq)) {
+		/* configure touchscreen irq gpio */
+		error = gpio_request(pdata->gpio_irq, "himax_gpio_irq");
+
+		if (error) {
+			E("unable to request gpio [%d]", pdata->gpio_irq);
+			goto err_gpio_irq_req;
+		}
+
+		error = gpio_direction_input(pdata->gpio_irq);
+		if (error) {
+			E("unable to set direction for gpio [%d]",
+			  pdata->gpio_irq);
+			goto err_gpio_irq_set_input;
+		}
+
+		ts->hx_irq = gpio_to_irq(pdata->gpio_irq);
+	} else if (pdata->of_irq) {
+		ts->hx_irq = pdata->of_irq;
+	} else {
+		E("irq not provided");
+		goto err_gpio_irq_req;
+	}
+
+	usleep_range(2000, 2001);
+
+	if (gpio_is_valid(pdata->gpio_reset)) {
+		error = gpio_direction_output(pdata->gpio_reset, 1);
+
+		if (error) {
+			E("unable to set direction for gpio [%d]",
+			  pdata->gpio_reset);
+			goto err_gpio_reset_set_high;
+		}
+	}
+
+	return error;
+
+err_gpio_reset_set_high:
+err_gpio_irq_set_input:
+	if (gpio_is_valid(pdata->gpio_irq))
+		gpio_free(pdata->gpio_irq);
+err_gpio_irq_req:
+	if (pdata->vcca_supply) {
+		regulator_disable(pdata->vcca_supply);
+		regulator_put(pdata->vcca_supply);
+		pdata->vcca_supply = NULL;
+	}
+err_vcca_supply_enable:
+	if (pdata->vccd_supply) {
+		regulator_disable(pdata->vccd_supply);
+		regulator_put(pdata->vccd_supply);
+		pdata->vccd_supply = NULL;
+	}
+err_vccd_supply_enable:
+err_gpio_reset_dir:
+	if (gpio_is_valid(pdata->gpio_reset))
+		gpio_free(pdata->gpio_reset);
+err_gpio_reset_req:
+
+	return error;
+}
+
+void himax_gpio_power_deconfig(struct himax_platform_data *pdata)
+{
+	if (gpio_is_valid(pdata->gpio_irq)) {
+		I("free gpio_irq = %d", pdata->gpio_irq);
+		gpio_free(pdata->gpio_irq);
+	}
+
+	if (gpio_is_valid(pdata->gpio_reset)) {
+		I("free gpio_reset = %d", pdata->gpio_reset);
+		gpio_free(pdata->gpio_reset);
+	}
+
+	if (pdata->vcca_supply) {
+		regulator_disable(pdata->vcca_supply);
+		regulator_put(pdata->vcca_supply);
+		pdata->vcca_supply = NULL;
+	}
+	if (pdata->vccd_supply) {
+		regulator_disable(pdata->vccd_supply);
+		regulator_put(pdata->vccd_supply);
+		pdata->vccd_supply = NULL;
+	}
+}
+
+static int himax_spi_read(struct himax_ts_data *ts, u8 *cmd,
+			  u8 cmd_len, u8 *buf, u32 len)
+{
+	struct spi_message m;
+	int result = NO_ERR;
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
+		if (unlikely(error))
+			E("SPI read error: %d", error);
+		else
+			break;
+	}
+
+	if (retry == HIMAX_BUS_RETRY_TIMES) {
+		E("SPI read error retry over %d", HIMAX_BUS_RETRY_TIMES);
+		result = -EIO;
+		goto END;
+	} else {
+		memcpy(buf, ts->xfer_data + cmd_len, len);
+	}
+
+END:
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
+int himax_bus_read(struct himax_ts_data *ts, u8 cmd,
+		   u8 *buf, u32 len)
+{
+	int result = -1;
+	u8 hw_addr = 0x00;
+
+	if (len > BUS_R_DLEN) {
+		E("len[%d] is over %d", len, BUS_R_DLEN);
+		return result;
+	}
+
+	mutex_lock(&ts->rw_lock);
+
+	if (ts->select_slave_reg) {
+		hw_addr = ts->slave_read_reg;
+		I("now addr=0x%02X!", hw_addr);
+	} else {
+		hw_addr = 0xF3;
+	}
+
+	memset(ts->xfer_data, 0, BUS_R_HLEN + len);
+	ts->xfer_data[0] = hw_addr;
+	ts->xfer_data[1] = cmd;
+	ts->xfer_data[2] = 0x00;
+	result = himax_spi_read(ts, ts->xfer_data, BUS_R_HLEN, buf, len);
+
+	mutex_unlock(&ts->rw_lock);
+
+	return result;
+}
+
+int himax_bus_write(struct himax_ts_data *ts, u8 cmd,
+		    u8 *addr, u8 *data, u32 len)
+{
+	int result = -1;
+	u8 offset = 0;
+	u32 tmp_len = len;
+	u8 hw_addr = 0x00;
+
+	if (len > BUS_W_DLEN) {
+		E("len[%d] is over %d", len, BUS_W_DLEN);
+		return -EFAULT;
+	}
+
+	mutex_lock(&ts->rw_lock);
+
+	if (ts->select_slave_reg) {
+		hw_addr = ts->slave_write_reg;
+		I("now addr=0x%02X!", hw_addr);
+	} else {
+		hw_addr = 0xF2;
+	}
+
+	ts->xfer_data[0] = hw_addr;
+	ts->xfer_data[1] = cmd;
+	offset = BUS_W_HLEN;
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
+	result = himax_spi_write(ts, ts->xfer_data, len + BUS_W_HLEN);
+
+	mutex_unlock(&ts->rw_lock);
+
+	return result;
+}
+
+void himax_int_enable(struct himax_ts_data *ts, int enable)
+{
+	unsigned long irqflags = 0;
+	int irqnum = ts->hx_irq;
+
+	spin_lock_irqsave(&ts->irq_lock, irqflags);
+	D("Entering! irqnum = %d", irqnum);
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
+	I("interrupt enable = %d", enable);
+	spin_unlock_irqrestore(&ts->irq_lock, irqflags);
+}
+
+static void himax_ts_isr_func(struct himax_ts_data *ts)
+{
+	himax_ts_work(ts);
+}
+
+irqreturn_t himax_ts_thread(int irq, void *ptr)
+{
+	himax_ts_isr_func((struct himax_ts_data *)ptr);
+
+	return IRQ_HANDLED;
+}
+
+static void himax_ts_work_func(struct work_struct *work)
+{
+	struct himax_ts_data *ts = container_of(work,
+		struct himax_ts_data, work);
+
+	himax_ts_work(ts);
+}
+
+int himax_int_register_trigger(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	if (ts->ic_data->HX_INT_IS_EDGE) {
+		I("edge triiger falling");
+		ret = request_threaded_irq(ts->hx_irq, NULL, himax_ts_thread,
+					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			himax_dev_name, ts);
+	} else {
+		I("level trigger low");
+		ret = request_threaded_irq(ts->hx_irq, NULL, himax_ts_thread,
+					   IRQF_TRIGGER_LOW | IRQF_ONESHOT, himax_dev_name, ts);
+	}
+
+	return ret;
+}
+
+int himax_ts_register_interrupt(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	ts->irq_enabled = 0;
+
+	/* Work functon */
+	if (ts->hx_irq) {/*INT mode*/
+		ts->use_irq = 1;
+		ret = himax_int_register_trigger(ts);
+
+		if (ret == 0) {
+			ts->irq_enabled = 1;
+			atomic_set(&ts->irq_state, 1);
+			I("irq enabled at number: %d",
+			  ts->hx_irq);
+		} else {
+			ts->use_irq = 0;
+			E("request_irq failed");
+		}
+	} else {
+		I("ts->hx_irq is empty, use polling mode.");
+	}
+
+	/*if use polling mode need to disable HX_ESD_RECOVERY function*/
+	if (!ts->use_irq) {
+		ts->himax_wq = create_singlethread_workqueue("himax_touch");
+		INIT_WORK(&ts->work, himax_ts_work_func);
+		hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		ts->timer.function = himax_ts_timer_func;
+		hrtimer_start(&ts->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
+		I("polling mode enabled");
+	}
+
+	return ret;
+}
+
+int himax_ts_unregister_interrupt(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	I("entered.");
+
+	/* Work functon */
+	if (ts->hx_irq && ts->use_irq) {/*INT mode*/
+		free_irq(ts->hx_irq, ts);
+		I("irq disabled at qpio: %d",
+		  ts->hx_irq);
+	}
+
+	/*if use polling mode need to disable HX_ESD_RECOVERY function*/
+	if (!ts->use_irq) {
+		hrtimer_cancel(&ts->timer);
+		cancel_work_sync(&ts->work);
+		if (ts->himax_wq)
+			destroy_workqueue(ts->himax_wq);
+		I("polling mode destroyed");
+	}
+
+	return ret;
+}
+
+#if defined(CONFIG_FB)
+int fb_notifier_callback(struct notifier_block *self,
+			 unsigned long event, void *data)
+{
+	const struct fb_event *evdata = data;
+	int *blank;
+	struct himax_ts_data *ts =
+	    container_of(self, struct himax_ts_data, fb_notif);
+
+	I("entered");
+
+	if (!ts) {
+		E("ts is NULL");
+		return -ECANCELED;
+	}
+
+	if (!ts->ic_boot_done) {
+		E("IC is booting");
+		return -ECANCELED;
+	}
+
+	if (evdata && evdata->data &&
+	    event == FB_EVENT_BLANK &&
+		ts->dev) {
+		blank = evdata->data;
+
+		switch (*blank) {
+		case FB_BLANK_UNBLANK:
+			himax_resume(ts->dev);
+			break;
+
+		case FB_BLANK_POWERDOWN:
+		case FB_BLANK_HSYNC_SUSPEND:
+		case FB_BLANK_VSYNC_SUSPEND:
+		case FB_BLANK_NORMAL:
+			himax_suspend(ts->dev);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+void himax_fb_register(struct work_struct *work)
+{
+	int ret = 0;
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+			work_att.work);
+
+	ts->fb_notif.notifier_call = fb_notifier_callback;
+	ret = fb_register_client(&ts->fb_notif);
+
+	if (ret)
+		E("Unable to register fb_notifier: %d", ret);
+}
+#endif
+
+void hx_check_power_status(struct work_struct *work)
+{
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+			work_pwr.work);
+
+	ts->latest_power_status = power_supply_is_system_supplied();
+
+	I("Update ts->latest_power_status = %X", ts->latest_power_status);
+
+	himax_cable_detect_func(ts, true);
+}
+
+int pwr_notifier_callback(struct notifier_block *self,
+			  unsigned long event, void *data)
+{
+	struct himax_ts_data *ts = container_of(self, struct himax_ts_data,
+		power_notif);
+	I("entered. event = %lX", event);
+
+	cancel_delayed_work_sync(&ts->work_pwr);
+	queue_delayed_work(ts->himax_pwr_wq, &ts->work_pwr,
+			   msecs_to_jiffies(1100));
+
+	return 0;
+}
+
+void himax_pwr_register(struct work_struct *work)
+{
+	int ret = 0;
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+			work_pwr.work);
+
+	ts->power_notif.notifier_call = pwr_notifier_callback;
+	ret = power_supply_reg_notifier(&ts->power_notif);
+	if (ret) {
+		E("Unable to register power_notif: %d", ret);
+	} else {
+		INIT_DELAYED_WORK(&ts->work_pwr, hx_check_power_status);
+		queue_delayed_work(ts->himax_pwr_wq, &ts->work_pwr,
+				   msecs_to_jiffies(3000));
+	}
+}
+
+
+/* COMMON*/
+/* CORE_IC */
+/* IC side start*/
+static void himax_mcu_burst_enable(struct himax_ts_data *ts,
+				   u8 auto_add_4_byte)
+{
+	u8 tmp_data[DATA_LEN_4];
+	int ret;
+
+	/*I("Entering");*/
+	tmp_data[0] = IC_GET_VAL(data_conti);
+
+	ret = himax_bus_write(ts, IC_GET_VAL(addr_conti), NULL, tmp_data, 1);
+	if (ret < 0) {
+		E("bus access fail!");
+		return;
+	}
+
+	tmp_data[0] = (IC_GET_VAL(data_incr4) | auto_add_4_byte);
+
+	ret = himax_bus_write(ts, IC_GET_VAL(addr_incr4), NULL, tmp_data, 1);
+	if (ret < 0) {
+		E("bus access fail!");
+		return;
+	}
+}
+
+static int himax_mcu_register_read(struct himax_ts_data *ts, u8 *addr,
+				   u8 *buf, u32 len)
+{
+	int ret = -1;
+	u32 orig_addr = le32_to_cpup((__le32 *)addr);
+
+	mutex_lock(&ts->reg_lock);
+
+	if (orig_addr == flash_addr_spi200_data)
+		g_core_fp.fp_burst_enable(ts, 0);
+	else if (len > DATA_LEN_4)
+		g_core_fp.fp_burst_enable(ts, 1);
+	else
+		g_core_fp.fp_burst_enable(ts, 0);
+
+	ret = himax_bus_write(ts, IC_GET_VAL(addr_ahb_addr_byte_0), addr, NULL, 4);
+	if (ret < 0) {
+		E("bus access fail!");
+		mutex_unlock(&ts->reg_lock);
+		return BUS_FAIL;
+	}
+
+	ret = himax_bus_write(ts, IC_GET_VAL(addr_ahb_access_direction), NULL,
+			      IC_GET_ARRAY(data_ahb_access_direction_read), 1);
+	if (ret < 0) {
+		E("bus access fail!");
+		mutex_unlock(&ts->reg_lock);
+		return BUS_FAIL;
+	}
+
+	ret = himax_bus_read(ts, IC_GET_VAL(addr_ahb_rdata_byte_0), buf, len);
+	if (ret < 0) {
+		E("bus access fail!");
+		mutex_unlock(&ts->reg_lock);
+		return BUS_FAIL;
+	}
+
+	mutex_unlock(&ts->reg_lock);
+
+	return NO_ERR;
+}
+
+static int himax_mcu_reg_read(struct himax_ts_data *ts, struct hx_reg_t *addr,
+			      struct data_pack_t *data)
+{
+	return g_core_fp.fp_register_read(ts,
+		addr->data.byte, data->data.byte, data->len);
+}
+
+static int himax_mcu_register_write(struct himax_ts_data *ts, u8 *addr,
+				    u8 *val, u32 len)
+{
+	int ret = -1;
+	const u32 max_trans_sz = 4 * 1024;
+	int i = 0;
+	u32 orig_addr = 0;
+	union hx_dword_data_t temp_addr = {0};
+	u32 temp_len = 0;
+
+	mutex_lock(&ts->reg_lock);
+	orig_addr = le32_to_cpup((__le32 *)addr);
+	if (orig_addr == flash_addr_spi200_data)
+		g_core_fp.fp_burst_enable(ts, 0);
+	else if (len > DATA_LEN_4)
+		g_core_fp.fp_burst_enable(ts, 1);
+	else
+		g_core_fp.fp_burst_enable(ts, 0);
+
+	if (len > max_trans_sz) {
+		for (i = 0; i < len; i += max_trans_sz) {
+			if ((len - i) > max_trans_sz)
+				temp_len = max_trans_sz;
+			else
+				temp_len = len % max_trans_sz;
+			temp_addr.dword = cpu_to_le32(orig_addr + i);
+			ret = himax_bus_write(ts, IC_GET_VAL(addr_ahb_addr_byte_0),
+					      temp_addr.byte, val + i, temp_len + ADDR_LEN_4);
+			if (ret < 0) {
+				E("xfer fail!");
+				mutex_unlock(&ts->reg_lock);
+				return BUS_FAIL;
+			}
+		}
+	} else {
+		ret = himax_bus_write(ts, IC_GET_VAL(addr_ahb_addr_byte_0), addr, val,
+				      len + ADDR_LEN_4);
+		if (ret < 0) {
+			E("xfer fail!");
+			mutex_unlock(&ts->reg_lock);
+			return BUS_FAIL;
+		}
+	}
+
+	mutex_unlock(&ts->reg_lock);
+
+	return NO_ERR;
+}
+
+static int himax_mcu_reg_write(struct himax_ts_data *ts,
+			       struct hx_reg_t *addr, struct data_pack_t *data)
+{
+	return g_core_fp.fp_register_write(ts,
+		addr->data.byte, data->data.byte, data->len);
+}
+
+static void himax_mcu_interface_on(struct himax_ts_data *ts)
+{
+	u8 tmp_data[DATA_LEN_4];
+	u8 tmp_data2[DATA_LEN_4];
+	int cnt = 0;
+	int ret = 0;
+
+	/* Read a dummy register to wake up BUS.*/
+	ret = himax_bus_read(ts, IC_GET_VAL(addr_ahb_rdata_byte_0), tmp_data,
+			     DATA_LEN_4);
+	if (ret < 0) {/* to knock BUS*/
+		E("bus access fail!");
+		return;
+	}
+
+	do {
+		tmp_data[0] = IC_GET_VAL(data_conti);
+
+		ret = himax_bus_write(ts, IC_GET_VAL(addr_conti), NULL, tmp_data, 1);
+		if (ret < 0) {
+			E("bus access fail!");
+			return;
+		}
+
+		tmp_data[0] = IC_GET_VAL(data_incr4);
+
+		ret = himax_bus_write(ts, IC_GET_VAL(addr_incr4), NULL, tmp_data, 1);
+		if (ret < 0) {
+			E("bus access fail!");
+			return;
+		}
+
+		/*Check cmd*/
+		himax_bus_read(ts, IC_GET_VAL(addr_conti), tmp_data, 1);
+		himax_bus_read(ts, IC_GET_VAL(addr_incr4), tmp_data2, 1);
+
+		if (tmp_data[0] == IC_GET_VAL(data_conti) &&
+		    tmp_data2[0] == IC_GET_VAL(data_incr4))
+			break;
+
+		usleep_range(1000, 1100);
+	} while (++cnt < 10);
+
+	if (cnt > 0)
+		I("Polling burst mode: %d times", cnt);
+}
+
+static void himax_mcu_power_on_init(struct himax_ts_data *ts)
+{
+	union hx_dword_data_t tmp_data = { .byte = {0x01, 0x00, 0x00, 0x00} };
+	u8 retry = 0;
+
+	/*RawOut select initial*/
+	g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_raw_out_sel),
+		FW_GET_ARRAY(data_clear), FW_GET_SZ(data_clear));
+	/*DSRAM func initial*/
+	g_core_fp.fp_assign_sorting_mode(ts, FW_GET_ARRAY(data_clear));
+	/*N frame initial*/
+	/* reset N frame back to default value 1 for normal mode */
+	g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_set_frame_addr),
+		tmp_data.byte, 4);
+	/*FW reload done initial*/
+	g_core_fp.fp_register_write(ts,
+		DRV_GET_ARRAY(addr_fw_define_2nd_flash_reload),
+		FW_GET_ARRAY(data_clear), FW_GET_SZ(data_clear));
+
+	g_core_fp.fp_sense_on(ts, 0x00);
+
+	I("waiting for FW reload data");
+
+	while (retry++ < 30) {
+		g_core_fp.fp_register_read(ts,
+			DRV_GET_ARRAY(addr_fw_define_2nd_flash_reload), tmp_data.byte,
+			DATA_LEN_4);
+
+		/* use all 4 bytes to compare */
+		if (le32_to_cpu(tmp_data.dword) == 0x72C0) {
+			I("FW reload done");
+			break;
+		}
+		I("wait FW reload %d times", retry);
+		g_core_fp.fp_read_FW_status(ts);
+		usleep_range(10000, 11000);
+	}
+}
+
+/* IC side end*/
+/* CORE_IC */
+
+/* CORE_FW */
+/* FW side start*/
+static void himax_mcu_system_reset(struct himax_ts_data *ts)
+{
+	int ret = 0;
+	u8 tmp_data[DATA_LEN_4];
+	int retry = 0;
+
+	g_core_fp.fp_interface_on(ts);
+	g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_ctrl_fw_isr),
+		FW_GET_ARRAY(data_clear), FW_GET_SZ(data_clear));
+	do {
+		/* reset code*/
+		/**
+		 * I2C_password[7:0] set Enter safe mode : 0x31 ==> 0x27
+		 */
+		tmp_data[0] = IC_GET_VAL(data_i2c_psw_lb);
+
+		ret = himax_bus_write(ts, IC_GET_VAL(adr_i2c_psw_lb), NULL, tmp_data,
+				      1);
+		if (ret < 0)
+			E("bus access fail!");
+
+		/**
+		 * I2C_password[15:8] set Enter safe mode :0x32 ==> 0x95
+		 */
+		tmp_data[0] = IC_GET_VAL(data_i2c_psw_ub);
+
+		ret = himax_bus_write(ts, IC_GET_VAL(adr_i2c_psw_ub), NULL, tmp_data,
+				      1);
+		if (ret < 0)
+			E("bus access fail!");
+
+		/**
+		 * I2C_password[7:0] set Enter safe mode : 0x31 ==> 0x00
+		 */
+		tmp_data[0] = 0x00;
+
+		ret = himax_bus_write(ts, IC_GET_VAL(adr_i2c_psw_lb), NULL, tmp_data,
+				      1);
+		if (ret < 0)
+			E("bus access fail!");
+
+		usleep_range(10000, 11000);
+
+		g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_flag_reset_event),
+			tmp_data, DATA_LEN_4);
+		I("Read status from IC = %X,%X", tmp_data[0], tmp_data[1]);
+	} while ((tmp_data[1] != 0x02 || tmp_data[0] != 0x00) && retry++ < 5);
+}
+
+static void himax_mcu_usb_detect_set(struct himax_ts_data *ts,
+				     const u8 *cable_config)
+{
+	struct hx_reg_t tmp_reg;
+	struct hx_reg_t back_reg;
+	u8 retry_cnt = 0;
+
+	do {
+		if (cable_config[1] == 0x01) {
+			WORD_REG(tmp_reg, fw_func_handshaking_pwd);
+			g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_usb_detect),
+				REG_GET_ARRAY(tmp_reg), REG_GET_SZ(tmp_reg));
+			WORD_REG(back_reg, fw_func_handshaking_pwd);
+			I("USB detect status IN!");
+		} else {
+			WORD_REG(tmp_reg, fw_data_safe_mode_release_pw_reset);
+			g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_usb_detect),
+				REG_GET_ARRAY(tmp_reg), REG_GET_SZ(tmp_reg));
+			WORD_REG(back_reg, fw_data_safe_mode_release_pw_reset);
+			I("USB detect status OUT!");
+		}
+
+		g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_usb_detect),
+			REG_GET_ARRAY(tmp_reg), REG_GET_SZ(tmp_reg));
+		/*I("tmp_data[0]=%d, USB detect=%d, retry_cnt=%d",
+		 *	tmp_data[0], cable_config[1], retry_cnt);
+		 */
+		retry_cnt++;
+	} while ((REG_GET_ARRAY(tmp_reg)[3] != REG_GET_ARRAY(back_reg)[3] ||
+		REG_GET_ARRAY(tmp_reg)[2] != REG_GET_ARRAY(back_reg)[2] ||
+		REG_GET_ARRAY(tmp_reg)[1] != REG_GET_ARRAY(back_reg)[1] ||
+		REG_GET_ARRAY(tmp_reg)[0] != REG_GET_ARRAY(back_reg)[0]) &&
+		retry_cnt < HIMAX_REG_RETRY_TIMES);
+}
+
+/* Please call this function after FW finish reload done */
+static void himax_mcu_read_FW_ver(struct himax_ts_data *ts)
+{
+	u8 data[12] = {0};
+
+	g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_fw_ver_addr), data,
+		DATA_LEN_4);
+	ts->ic_data->vendor_panel_ver =  data[0];
+	ts->ic_data->vendor_fw_ver = data[1] << 8 | data[2];
+	I("PANEL_VER : %X", ts->ic_data->vendor_panel_ver);
+	I("FW_VER : %X", ts->ic_data->vendor_fw_ver);
+	g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_fw_cfg_addr), data,
+		DATA_LEN_4);
+	ts->ic_data->vendor_config_ver = data[2] << 8 | data[3];
+	/*I("CFG_VER : %X",ts->ic_data->vendor_config_ver);*/
+	ts->ic_data->vendor_touch_cfg_ver = data[2];
+	I("TOUCH_VER : %X", ts->ic_data->vendor_touch_cfg_ver);
+	ts->ic_data->vendor_display_cfg_ver = data[3];
+	I("DISPLAY_VER : %X", ts->ic_data->vendor_display_cfg_ver);
+	g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_fw_vendor_addr), data,
+		DATA_LEN_4);
+	ts->ic_data->vendor_cid_maj_ver = data[2];
+	ts->ic_data->vendor_cid_min_ver = data[3];
+	I("CID_VER : %X", (ts->ic_data->vendor_cid_maj_ver << 8
+			| ts->ic_data->vendor_cid_min_ver));
+	g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_cus_info), data, 12);
+	memcpy(ts->ic_data->vendor_cus_info, data, 12);
+	I("Cusomer ID = %s", ts->ic_data->vendor_cus_info);
+	g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_proj_info), data, 12);
+	memcpy(ts->ic_data->vendor_proj_info, data, 12);
+	I("Project ID = %s", ts->ic_data->vendor_proj_info);
+	hx_hid_update_info(ts);
+}
+
+static u32 dbg_reg_ary[4] = {fw_addr_fw_dbg_msg_addr,
+	fw_addr_chk_fw_status, fw_addr_chk_dd_status, fw_addr_flag_reset_event};
+
+static void himax_mcu_read_FW_status(struct himax_ts_data *ts)
+{
+	u8 len = 0;
+	u8 i = 0;
+	struct hx_reg_t addr_reg;
+	u8 data[4] = {0};
+
+	len = (u8)(sizeof(dbg_reg_ary) / sizeof(u32));
+
+	for (i = 0; i < len; i++) {
+		WORD_REG(addr_reg, dbg_reg_ary[i]);
+		g_core_fp.fp_register_read(ts, REG_GET_ARRAY(addr_reg),
+			data, DATA_LEN_4);
+
+		I("reg[0-3] : 0x%08X = 0x%02X, 0x%02X, 0x%02X, 0x%02X",
+		  dbg_reg_ary[i], data[0], data[1], data[2], data[3]);
+	}
+}
+
+static void himax_mcu_irq_switch(struct himax_ts_data *ts, int switch_on)
+{
+	if (switch_on) {
+		if (ts->use_irq)
+			himax_int_enable(ts, switch_on);
+		else
+			hrtimer_start(&ts->timer, ktime_set(1, 0),
+				      HRTIMER_MODE_REL);
+	} else {
+		if (ts->use_irq) {
+			himax_int_enable(ts, switch_on);
+		} else {
+			hrtimer_cancel(&ts->timer);
+			cancel_work_sync(&ts->work);
+		}
+	}
+}
+
+static int himax_mcu_assign_sorting_mode(struct himax_ts_data *ts,
+					 u8 *tmp_data_in)
+{
+	u8 retry = 0;
+	union hx_dword_data_t rdata = {0};
+	u32 sorting_addr = FW_GET_VAL(addr_sorting_mode_en);
+	union hx_dword_data_t *tmp_data = (union hx_dword_data_t *)tmp_data_in;
+
+	I("addr: 0x%08X, write: 0x%08X",
+	  sorting_addr, le32_to_cpu(tmp_data->dword));
+
+	while (retry++ < 3) {
+		g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_sorting_mode_en),
+			tmp_data->byte, DATA_LEN_4);
+		usleep_range(1000, 1100);
+		g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_sorting_mode_en),
+			rdata.byte, DATA_LEN_4);
+
+		if (rdata.dword == tmp_data->dword) {
+			I("success to write sorting mode");
+			return NO_ERR;
+		}
+		E("fail to write sorting mode");
+	}
+
+	return BUS_FAIL;
+}
+
+static void hx_ap_notify_fw_sus(struct himax_ts_data *ts, int suspend)
+{
+	int retry = 0;
+	int read_sts = 0;
+	union hx_dword_data_t read_tmp = {0};
+	union hx_dword_data_t addr_tmp = {0};
+	union hx_dword_data_t data_tmp = {0};
+
+	addr_tmp.dword = FW_GET_VAL(addr_ap_notify_fw_sus);
+
+	if (suspend) {
+		I("Suspend mode!");
+		data_tmp.dword = FW_GET_VAL(data_ap_notify_fw_sus_en);
+	} else {
+		I("Non-Suspend mode!");
+		data_tmp.dword = FW_GET_VAL(data_ap_notify_fw_sus_dis);
+	}
+
+	I("R%08XH<-0x%08X",	addr_tmp.dword,	data_tmp.dword);
+	addr_tmp.dword = cpu_to_le32(addr_tmp.dword);
+	data_tmp.dword = cpu_to_le32(data_tmp.dword);
+	do {
+		g_core_fp.fp_register_write(ts, addr_tmp.byte, data_tmp.byte,
+			sizeof(data_tmp.byte));
+		usleep_range(1000, 1001);
+		read_sts = g_core_fp.fp_register_read(ts, addr_tmp.byte, read_tmp.byte,
+			sizeof(read_tmp.byte));
+		I("read bus status=%d", read_sts);
+		I("Now retry=%d, data=0x%08X", retry,
+		  le32_to_cpu(read_tmp.dword));
+	} while ((retry++ < 10) && (read_sts != NO_ERR) &&
+		(read_tmp.dword != data_tmp.dword));
+}
+
+/* FW side end*/
+/* CORE_FW */
+
+/* CORE_FLASH */
+/* FLASH side start*/
+
+
+/* CORE_DRIVER */
+static void himax_suspend_proc(struct himax_ts_data *ts, bool suspended)
+{
+	I("himax suspend.");
+}
+
+static void himax_resume_proc(struct himax_ts_data *ts, bool suspended)
+{
+	int result = 0;
+
+	I("himax resume.");
+
+	if (g_core_fp.fp_resend_cmd_func) {
+		g_core_fp.fp_resend_cmd_func(ts, suspended);
+		ts->resume_success = true;
+	}
+
+
+	if (g_core_fp.fp_ap_notify_fw_sus && result == 0)
+		g_core_fp.fp_ap_notify_fw_sus(ts, 0);
+}
+
+static void himax_mcu_pin_reset(struct himax_ts_data *ts)
+{
+	const int rst_low_period_s = RST_LOW_PERIOD_S;
+	const int rst_low_period_e = RST_LOW_PERIOD_E;
+	int rst_high_period_s;
+	int rst_high_period_e;
+
+	I("Now reset the Touch chip.");
+
+	rst_high_period_s = RST_HIGH_PERIOD_S;
+	rst_high_period_e = RST_HIGH_PERIOD_E;
+
+	himax_rst_gpio_set(ts->rst_gpio, 0);
+	usleep_range(rst_low_period_s, rst_low_period_e);
+	himax_rst_gpio_set(ts->rst_gpio, 1);
+	usleep_range(rst_high_period_s, rst_high_period_e);
+}
+
+static void himax_mcu_ic_reset(struct himax_ts_data *ts, u8 loadconfig,
+			       u8 int_off)
+{
+	I("status: loadconfig=%d,int_off=%d", loadconfig, int_off);
+
+	if (ts->rst_gpio >= 0) {
+		if (int_off)
+			g_core_fp.fp_irq_switch(ts, 0);
+
+		g_core_fp.fp_pin_reset(ts);
+
+		if (int_off)
+			g_core_fp.fp_irq_switch(ts, 1);
+	}
+}
+
+static u8 himax_mcu_tp_info_check(struct himax_ts_data *ts)
+{
+	union hx_dword_data_t addr;
+	char data[DATA_LEN_4] = {0};
+	u32 rx_num;
+	u32 tx_num;
+	u32 bt_num;
+	u32 max_pt;
+	u32 y_res;
+	u32 x_res;
+	u8 int_is_edge;
+	u8 stylus_func;
+	u8 stylus_id_v2;
+	u8 stylus_ratio;
+
+	g_core_fp.fp_register_read(ts,
+		DRV_GET_ARRAY(addr_fw_define_rxnum_txnum), data, DATA_LEN_4);
+	rx_num = data[2];
+	tx_num = data[3];
+
+	g_core_fp.fp_register_read(ts,
+		DRV_GET_ARRAY(addr_fw_define_maxpt_xyrvs), data, DATA_LEN_4);
+	max_pt = data[0];
+
+	g_core_fp.fp_register_read(ts,
+		DRV_GET_ARRAY(addr_fw_define_x_y_res), data, DATA_LEN_4);
+	y_res = be16_to_cpup((u16 *)&data[0]);
+	x_res = be16_to_cpup((u16 *)&data[2]);
+	/* I("rx_num=%d, tx_num=%d, max_pt=%d, y_res=%d, x_res=%d",
+	 *	rx_num, tx_num, max_pt, y_res, x_res);
+	 */
+
+	g_core_fp.fp_register_read(ts,
+		DRV_GET_ARRAY(addr_fw_define_int_is_edge), data, DATA_LEN_4);
+	if ((data[1] & 0x01) == 1)
+		int_is_edge = true;
+	else
+		int_is_edge = false;
+
+	/*1. Read number of MKey R100070E8H to determin data size*/
+	g_core_fp.fp_register_read(ts, SRAM_GET_ARRAY(addr_mkey), data,
+		DATA_LEN_4);
+	bt_num = data[0] & 0x03;
+	ts->ic_data->HX_BT_NUM = bt_num;
+
+	addr.dword = 0x1000719C;
+	addr.dword = cpu_to_le32(addr.dword);
+
+	g_core_fp.fp_register_read(ts, addr.byte, data, DATA_LEN_4);
+	stylus_func = data[3];
+	ts->ic_data->HX_STYLUS_FUNC = stylus_func;
+
+	ts->ic_data->HX_RX_NUM = rx_num;
+
+	ts->ic_data->HX_TX_NUM = tx_num;
+
+	ts->ic_data->HX_X_RES = x_res;
+	ts->ic_data->HX_Y_RES = y_res;
+	ts->ic_data->HX_MAX_PT = max_pt;
+	ts->ic_data->HX_INT_IS_EDGE = int_is_edge;
+
+	if (ts->ic_data->HX_STYLUS_FUNC) {
+		addr.dword = 0x100071FC;
+		addr.dword = cpu_to_le32(addr.dword);
+		g_core_fp.fp_register_read(ts, addr.byte, data, DATA_LEN_4);
+		stylus_id_v2 = data[2];/* 0x100071FE 0=off 1=on */
+		stylus_ratio = data[3];
+		/* 0x100071FF 0=ratio_1 10=ratio_10 */
+		ts->ic_data->HX_STYLUS_ID_V2 = stylus_id_v2;
+		ts->ic_data->HX_STYLUS_RATIO = stylus_ratio;
+	}
+
+	I("TOUCH_INFO updated");
+
+	return 0;
+}
+
+static void himax_mcu_touch_information(struct himax_ts_data *ts)
+{
+	if (ts->ic_data->HX_RX_NUM == 0xFFFFFFFF)
+		ts->ic_data->HX_RX_NUM = FIX_HX_RX_NUM;
+
+	if (ts->ic_data->HX_TX_NUM == 0xFFFFFFFF)
+		ts->ic_data->HX_TX_NUM = FIX_HX_TX_NUM;
+
+	if (ts->ic_data->HX_BT_NUM == 0xFFFFFFFF)
+		ts->ic_data->HX_BT_NUM = FIX_HX_BT_NUM;
+
+	if (ts->ic_data->HX_MAX_PT == 0xFFFFFFFF)
+		ts->ic_data->HX_MAX_PT = FIX_HX_MAX_PT;
+
+	if (ts->ic_data->HX_INT_IS_EDGE == 0xFF)
+		ts->ic_data->HX_INT_IS_EDGE = FIX_HX_INT_IS_EDGE;
+
+	if (ts->ic_data->HX_STYLUS_FUNC == 0xFF)
+		ts->ic_data->HX_STYLUS_FUNC = FIX_HX_STYLUS_FUNC;
+
+	if (ts->ic_data->HX_STYLUS_ID_V2 == 0xFF)
+		ts->ic_data->HX_STYLUS_ID_V2 = FIX_HX_STYLUS_ID_V2;
+
+	if (ts->ic_data->HX_STYLUS_RATIO == 0xFF)
+		ts->ic_data->HX_STYLUS_RATIO = FIX_HX_STYLUS_RATIO;
+
+	I("HX_RX_NUM = %d,HX_TX_NUM = %d",
+	  ts->ic_data->HX_RX_NUM, ts->ic_data->HX_TX_NUM);
+	I("HX_MAX_PT = %d", ts->ic_data->HX_MAX_PT);
+	I("HX_INT_IS_EDGE = %d,HX_STYLUS_FUNC = %d",
+	  ts->ic_data->HX_INT_IS_EDGE, ts->ic_data->HX_STYLUS_FUNC);
+	I("HX_STYLUS_ID_V2 = %d,HX_STYLUS_RATIO = %d",
+	  ts->ic_data->HX_STYLUS_ID_V2, ts->ic_data->HX_STYLUS_RATIO);
+}
+
+static void himax_mcu_calc_touch_data_size(struct himax_ts_data *ts)
+{
+	ts->x_channel = ts->ic_data->HX_RX_NUM;
+	ts->y_channel = ts->ic_data->HX_TX_NUM;
+	ts->n_finger_support = ts->ic_data->HX_MAX_PT;
+}
+
+static int himax_mcu_ic_excp_recovery
+		(struct himax_ts_data *ts,
+		 u32 hx_excp_event,
+		 u32 hx_zero_event,
+		 u32 length)
+{
+	int ret_val = NO_ERR;
+
+	if (hx_excp_event == length) {
+		ts->excp_zero_event_count = 0;
+		ret_val = HX_EXCP_EVENT;
+	} else if (hx_zero_event == length) {
+		if (ts->excp_zero_event_count > 5) {
+			ts->excp_zero_event_count = 0;
+			I("EXCEPTION event checked - ALL Zero.");
+			ret_val = HX_EXCP_EVENT;
+		} else {
+			ts->excp_zero_event_count++;
+			I("ALL Zero event is %d times.",
+			  ts->excp_zero_event_count);
+			ret_val = HX_ZERO_EVENT_COUNT;
+		}
+	}
+
+	return ret_val;
+}
+
+static void himax_mcu_excp_ic_reset(struct himax_ts_data *ts)
+{
+	ts->excp_reset_active = 0;
+	himax_mcu_pin_reset(ts);
+	I("reset!");
+}
+
+static void himax_mcu_resend_cmd_func(struct himax_ts_data *ts, bool suspended)
+{
+	himax_cable_detect_func(ts, true);
+}
+
+/* CORE_DRIVER */
+
+static void hx_dis_rload_0f(struct himax_ts_data *ts, int disable)
+{
+	/*Disable Flash Reload*/
+	g_core_fp.fp_register_write(ts,
+		DRV_GET_ARRAY(addr_fw_define_flash_reload),
+		ZF_GET_ARRAY(data_dis_flash_reload), DATA_LEN_4);
+}
+
+static bool hx83102j_chip_detect(struct himax_ts_data *ts)
+{
+	DEF_WORD_DATA(tmp_data);
+	struct hx_reg_t tmp_addr;
+	bool ret_data = false;
+	int ret = 0;
+	int i = 0;
+	bool check_flash;
+
+	g_core_fp.fp_pin_reset(ts);
+	ret = himax_bus_read(ts, 0x13, tmp_data.data.byte, 1);
+	if (ret < 0) {
+		E("bus access fail!");
+		return false;
+	}
+
+	check_flash = true;
+
+	if (g_core_fp.fp_sense_off(ts, check_flash) == false) {
+		ret_data = false;
+		E("hx83102_sense_off Fail!");
+		return ret_data;
+	}
+
+	for (i = 0; i < 5; i++) {
+		WORD_REG(tmp_addr, 0x900000D0);
+		ret = g_core_fp.fp_reg_read(ts, &tmp_addr, &tmp_data);
+		if (ret != 0) {
+			ret_data = false;
+			E("read ic id Fail");
+			return ret_data;
+		}
+
+		if (((*tmp_data.data.word) & 0x83102900) == 0x83102900) {
+			strscpy(ts->chip_name,
+				HX83102J_ID, 30);
+			(ts->ic_data)->ic_adc_num =
+				hx83102j_data_adc_num;
+			ts->ic_data->flash_size = HX83102J_FLASH_SIZE;
+			ts->ic_data->icid = *tmp_data.data.word;
+			I("detect IC HX83102J successfully");
+			ret_data = true;
+			break;
+		}
+		E("Read driver IC ID = %X,%X,%X",
+		  tmp_data_array[3],
+		  tmp_data_array[2], tmp_data_array[1]); /*83,10,2X*/
+		ret_data = false;
+		E("Read driver ID register Fail!");
+		E("Could NOT find Himax Chipset");
+		E("Please check:\n1.VCCD,VCCA,VSP,VSN");
+		E("2. LCM_RST,TP_RST");
+		E("3. Power On Sequence");
+	}
+
+	return ret_data;
+}
+
+static void hx83102j_sense_on(struct himax_ts_data *ts, u8 flash_mode)
+{
+	int ret = 0;
+
+	DEF_WORD_DATA(tmp_data);
+
+	I("Enter");
+	ts->notouch_frame = ts->ic_notouch_frame;
+	g_core_fp.fp_interface_on(ts);
+	g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_ctrl_fw_isr),
+		FW_GET_ARRAY(data_clear), FW_GET_SZ(data_clear));
+	usleep_range(10000, 11000);
+	if (!flash_mode) {
+		g_core_fp.fp_ic_reset(ts, false, false);
+	} else {
+		tmp_data.data.half[0] = 0;
+		ret = himax_bus_write(ts, IC_GET_ARRAY(adr_i2c_psw_lb)[0], NULL,
+				      tmp_data.data.byte, 2);
+		if (ret < 0) {
+			E("cmd=%x bus access fail!",
+			  IC_GET_ARRAY(adr_i2c_psw_lb)[0]);
+		}
+	}
+}
+
+static bool hx83102j_sense_off(struct himax_ts_data *ts, bool check_en)
+{
+	u32 cnt = 0;
+	struct hx_reg_t tmp_addr = {0};
+	int ret = 0;
+
+	DEF_WORD_DATA(tmp_data);
+
+	do {
+		if (cnt == 0 ||
+		    (tmp_data.data.byte[0] != 0xA5 &&
+		    tmp_data.data.byte[0] != 0x00 &&
+		    tmp_data.data.byte[0] != 0x87))
+			g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_ctrl_fw_isr),
+				FW_GET_ARRAY(data_fw_stop), FW_GET_SZ(data_fw_stop));
+		usleep_range(10000, 10001);
+
+		/* check fw status */
+		g_core_fp.fp_register_read(ts, IC_GET_ARRAY(addr_cs_central_state),
+			tmp_data.data.byte, tmp_data.len);
+
+		if (tmp_data.data.byte[0] != 0x05) {
+			I("Do not need wait FW, Status = 0x%02X!", tmp_data.data.byte[0]);
+			break;
+		}
+
+		g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_ctrl_fw_isr),
+			tmp_data.data.byte, tmp_data.len);
+		I("cnt = %d, data[0] = 0x%02X!", cnt, tmp_data.data.byte[0]);
+	} while (tmp_data.data.byte[0] != 0x87 && ++cnt < 35 && check_en);
+
+	cnt = 0;
+
+	do {
+		/**
+		 * set Enter safe mode : 0x31 ==> 0x9527
+		 */
+		tmp_data.data.half[0] = 0x9527;
+		ret = himax_bus_write(ts, 0x31, NULL, tmp_data.data.byte, 2);
+		if (ret < 0) {
+			E("bus access fail!");
+			return false;
+		}
+
+		/**
+		 *Check enter_save_mode
+		 */
+		WORD_REG(tmp_addr, 0x900000A8);
+		g_core_fp.fp_reg_read(ts, &tmp_addr, &tmp_data);
+		I("Check enter_save_mode data[0]=%X", tmp_data.data.byte[0]);
+
+		if (tmp_data.data.byte[0] == 0x0C) {
+			/**
+			 *Reset TCON
+			 */
+			WORD_REG(tmp_addr, 0x80020004);
+			VAL_SET(tmp_data, 0x00000000);
+			g_core_fp.fp_reg_write(ts, &tmp_addr, &tmp_data);
+			usleep_range(1000, 1001);
+			return true;
+		}
+		usleep_range(5000, 5001);
+		g_core_fp.fp_pin_reset(ts);
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
+	ret = himax_bus_read(ts, FW_GET_ARRAY(addr_event_addr)[0], buf, length);
+
+	return (ret == NO_ERR) ? true : false;
+}
+
+static void hx83102j_chip_init(struct himax_ts_data *ts)
+{
+	ts->chip_cell_type = CHIP_IS_IN_CELL;
+	ts->chip_max_dsram_size = 73728;
+	I("IC cell type = %d", ts->chip_cell_type);
+	ts->ic_checksum_type = HX_TP_BIN_CHECKSUM_CRC;
+	/*Himax: Set FW and CFG Flash Address*/
+	WORD_REG(g_core_regs.flash_ver_info.addr_fw_ver_major, 59397);	/*0x00E805*/
+	WORD_REG(g_core_regs.flash_ver_info.addr_fw_ver_minor, 59398);	/*0x00E806*/
+	WORD_REG(g_core_regs.flash_ver_info.addr_cfg_ver_major, 59648);	/*0x00E900*/
+	WORD_REG(g_core_regs.flash_ver_info.addr_cfg_ver_minor, 59649);	/*0x00E901*/
+	WORD_REG(g_core_regs.flash_ver_info.addr_cid_ver_major, 59394);	/*0x00E802*/
+	WORD_REG(g_core_regs.flash_ver_info.addr_cid_ver_minor, 59395);	/*0x00E803*/
+	WORD_REG(g_core_regs.flash_ver_info.addr_cfg_table, 0x10000);
+	g_core_regs.flash_ver_info.addr_cfg_table_t.data.word =
+		g_core_regs.flash_ver_info.addr_cfg_table.data.word;
+	ts->ic_data->enc16bits = false;
+}
+
+static void himax_ic_reg_init(struct himax_core_command_regs *reg_data)
+{
+	I("Entering!");
+/* CORE_IC -start- */
+	BYTE_REG(reg_data->ic_op.addr_ahb_addr_byte_0, ic_adr_ahb_addr_byte_0);
+	BYTE_REG(reg_data->ic_op.addr_ahb_rdata_byte_0, ic_adr_ahb_rdata_byte_0);
+	BYTE_REG(reg_data->ic_op.addr_ahb_access_direction, ic_adr_ahb_access_direction);
+	BYTE_REG(reg_data->ic_op.addr_conti, ic_adr_conti);
+	BYTE_REG(reg_data->ic_op.addr_incr4, ic_adr_incr4);
+	BYTE_REG(reg_data->ic_op.adr_i2c_psw_lb, ic_adr_i2c_psw_lb);
+	BYTE_REG(reg_data->ic_op.adr_i2c_psw_ub, ic_adr_i2c_psw_ub);
+	BYTE_REG(reg_data->ic_op.data_ahb_access_direction_read, ic_cmd_ahb_access_direction_read);
+	BYTE_REG(reg_data->ic_op.data_conti, ic_cmd_conti);
+	BYTE_REG(reg_data->ic_op.data_incr4, ic_cmd_incr4);
+	BYTE_REG(reg_data->ic_op.data_i2c_psw_lb, ic_cmd_i2c_psw_lb);
+	BYTE_REG(reg_data->ic_op.data_i2c_psw_ub, ic_cmd_i2c_psw_ub);
+	WORD_REG(reg_data->ic_op.addr_tcon_on_rst, hx83102j_ic_adr_tcon_rst);
+	WORD_REG(reg_data->ic_op.addr_cs_central_state, ic_adr_cs_central_state);
+/* CORE_IC -end- */
+/* CORE_FW -start- */
+	WORD_REG(reg_data->fw_op.addr_system_reset, fw_addr_system_reset);
+	WORD_REG(reg_data->fw_op.addr_ctrl_fw_isr, fw_addr_ctrl_fw);
+	WORD_REG(reg_data->fw_op.addr_flag_reset_event, fw_addr_flag_reset_event);
+	WORD_REG(reg_data->fw_op.addr_raw_out_sel, hx83102j_fw_addr_raw_out_sel);
+	WORD_REG(reg_data->fw_op.addr_reload_status, fw_addr_reload_status);
+	WORD_REG(reg_data->fw_op.addr_reload_crc32_result,
+		fw_addr_reload_crc32_result);
+	WORD_REG(reg_data->fw_op.addr_reload_addr_from, fw_addr_reload_addr_from);
+	WORD_REG(reg_data->fw_op.addr_reload_addr_cmd_beat,
+		fw_addr_reload_addr_cmd_beat);
+	WORD_REG(reg_data->fw_op.addr_set_frame_addr, fw_addr_set_frame_addr);
+	WORD_REG(reg_data->fw_op.addr_sorting_mode_en, fw_addr_sorting_mode_en);
+	WORD_REG(reg_data->fw_op.addr_fw_ver_addr, fw_addr_fw_ver_addr);
+	WORD_REG(reg_data->fw_op.addr_fw_cfg_addr, fw_addr_fw_cfg_addr);
+	WORD_REG(reg_data->fw_op.addr_fw_vendor_addr, fw_addr_fw_vendor_addr);
+	WORD_REG(reg_data->fw_op.addr_cus_info, fw_addr_cus_info);
+	WORD_REG(reg_data->fw_op.addr_proj_info, fw_addr_proj_info);
+	WORD_REG(reg_data->fw_op.addr_ap_notify_fw_sus, fw_addr_ap_notify_fw_sus);
+	WORD_REG(reg_data->fw_op.data_ap_notify_fw_sus_en,
+		 fw_data_ap_notify_fw_sus_en);
+	WORD_REG(reg_data->fw_op.data_ap_notify_fw_sus_dis,
+		 fw_data_ap_notify_fw_sus_dis);
+	WORD_REG(reg_data->fw_op.data_system_reset, fw_data_system_reset);
+	WORD_REG(reg_data->fw_op.data_clear, fw_data_clear);
+	WORD_REG(reg_data->fw_op.data_fw_stop, fw_data_fw_stop);
+	BYTE_REG(reg_data->fw_op.addr_event_addr, fw_addr_event_addr);
+	WORD_REG(reg_data->fw_op.addr_usb_detect, fw_usb_detect_addr);
+/* CORE_FW -end- */
+/* CORE_SRAM */
+	/* sram start*/
+	WORD_REG(reg_data->sram_op.addr_mkey, sram_adr_mkey);
+	WORD_REG(reg_data->sram_op.addr_rawdata_addr, sram_adr_rawdata_addr);
+	HALF_REG(reg_data->sram_op.passwrd_start, sram_passwrd_start);
+	HALF_REG(reg_data->sram_op.passwrd_end, sram_passwrd_end);
+	/* sram end*/
+/* CORE_SRAM */
+/* CORE_DRIVER -start- */
+	WORD_REG(reg_data->driver_op.addr_fw_define_flash_reload,
+		 driver_addr_fw_define_flash_reload);
+	WORD_REG(reg_data->driver_op.addr_fw_define_2nd_flash_reload,
+		 driver_addr_fw_define_2nd_flash_reload);
+	WORD_REG(reg_data->driver_op.addr_fw_define_int_is_edge,
+		 driver_addr_fw_define_int_is_edge);
+	WORD_REG(reg_data->driver_op.addr_fw_define_rxnum_txnum,
+		 driver_addr_fw_define_rxnum_txnum);
+	WORD_REG(reg_data->driver_op.addr_fw_define_maxpt_xyrvs,
+		 driver_addr_fw_define_maxpt_xyrvs);
+	WORD_REG(reg_data->driver_op.addr_fw_define_x_y_res,
+		 driver_addr_fw_define_x_y_res);
+/* CORE_DRIVER -end- */
+	WORD_REG(reg_data->zf_op.data_dis_flash_reload, zf_data_dis_flash_reload);
+	WORD_REG(reg_data->zf_op.addr_system_reset, zf_addr_system_reset);
+	BYTE_REG(reg_data->zf_op.data_system_reset, zf_data_system_reset);
+	WORD_REG(reg_data->zf_op.data_sram_start_addr, zf_data_sram_start_addr);
+	WORD_REG(reg_data->zf_op.data_cfg_info, zf_data_cfg_info);
+	WORD_REG(reg_data->zf_op.data_fw_cfg_1, zf_data_fw_cfg_1);
+	WORD_REG(reg_data->zf_op.data_fw_cfg_2, zf_data_fw_cfg_2);
+	WORD_REG(reg_data->zf_op.data_fw_cfg_3, zf_data_fw_cfg_3);
+	WORD_REG(reg_data->zf_op.data_adc_cfg_1, zf_data_adc_cfg_1);
+	WORD_REG(reg_data->zf_op.data_adc_cfg_2, zf_data_adc_cfg_2);
+	WORD_REG(reg_data->zf_op.data_adc_cfg_3, zf_data_adc_cfg_3);
+	WORD_REG(reg_data->zf_op.data_map_table, zf_data_map_table);
+}
+
+static void himax_para_init(struct himax_ts_data *ts)
+{
+	I("Entering!");
+	ts->ic_notouch_frame = hx83102j_notouch_frame;
+}
+
+static void hx83102j_pin_reset(struct himax_ts_data *ts)
+{
+	I("Now reset the Touch chip.");
+	himax_rst_gpio_set(ts->rst_gpio, 0);
+	usleep_range(100 * 100, 101 * 100);
+	himax_rst_gpio_set(ts->rst_gpio, 1);
+	usleep_range(200 * 100, 201 * 100);
+}
+
+static void himax_ic_fp_init(void)
+{
+	I("Entering!");
+/* CORE_IC */
+	g_core_fp.fp_burst_enable = himax_mcu_burst_enable;
+	g_core_fp.fp_register_read = himax_mcu_register_read;
+	g_core_fp.fp_reg_read = himax_mcu_reg_read;
+	g_core_fp.fp_register_write = himax_mcu_register_write;
+	g_core_fp.fp_reg_write = himax_mcu_reg_write;
+	g_core_fp.fp_interface_on = himax_mcu_interface_on;
+	g_core_fp.fp_sense_on = hx83102j_sense_on;
+	g_core_fp.fp_sense_off = hx83102j_sense_off;
+	g_core_fp.fp_power_on_init = himax_mcu_power_on_init;
+/* CORE_IC */
+/* CORE_FW */
+	g_core_fp.fp_system_reset = himax_mcu_system_reset;
+	g_core_fp.fp_usb_detect_set = himax_mcu_usb_detect_set;
+	g_core_fp.fp_reload_disable = hx_dis_rload_0f;
+	g_core_fp.fp_read_FW_ver = himax_mcu_read_FW_ver;
+	g_core_fp.fp_read_FW_status = himax_mcu_read_FW_status;
+	g_core_fp.fp_irq_switch = himax_mcu_irq_switch;
+	g_core_fp.fp_assign_sorting_mode = himax_mcu_assign_sorting_mode;
+	g_core_fp.fp_ap_notify_fw_sus = hx_ap_notify_fw_sus;
+/* CORE_FW */
+/* CORE_DRIVER */
+	g_core_fp.fp_chip_detect = hx83102j_chip_detect;
+	g_core_fp.fp_chip_init = hx83102j_chip_init;
+	g_core_fp.fp_pin_reset = hx83102j_pin_reset;
+	g_core_fp.fp_ic_reset = himax_mcu_ic_reset;
+	g_core_fp.fp_tp_info_check = himax_mcu_tp_info_check;
+	g_core_fp.fp_touch_information = himax_mcu_touch_information;
+	g_core_fp.fp_calc_touch_data_size = himax_mcu_calc_touch_data_size;
+	g_core_fp.fp_ic_excp_recovery = himax_mcu_ic_excp_recovery;
+	g_core_fp.fp_excp_ic_reset = himax_mcu_excp_ic_reset;
+	g_core_fp.fp_resend_cmd_func = himax_mcu_resend_cmd_func;
+	g_core_fp.fp_read_event_stack = hx83102j_read_event_stack;
+	g_core_fp.fp_suspend_proc = himax_suspend_proc;
+	g_core_fp.fp_resume_proc = himax_resume_proc;
+/* CORE_DRIVER */
+
+}
+
+
+#if defined(CONFIG_HID_HIMAX)
+/* calculate time diff and return as milliseconds */
+static unsigned int time_diff(struct time_var *start, struct time_var *end)
+{
+	unsigned int diff = 0;
+
+	diff = (end->tv_sec - start->tv_sec) * 1000;
+	diff += (end->time_var_fine - start->time_var_fine) / time_var_fine_unit;
+
+	return diff;
+}
+#endif
+
+/* start himax_touch_get */
+static int himax_touch_get(struct himax_ts_data *ts, u8 *buf, int ts_path)
+{
+	u32 read_size = 0;
+	int ts_status = 0;
+
+	switch (ts_path) {
+	/*normal*/
+	case HX_REPORT_COORD:
+	case HX_REPORT_COORD_RAWDATA:
+		read_size = ts->touch_all_size;
+		break;
+	default:
+		break;
+	}
+
+	if (read_size == 0) {
+		E("Read size fault!");
+		ts_status = HX_TS_GET_DATA_FAIL;
+	} else {
+		if (!g_core_fp.fp_read_event_stack(ts, buf, read_size)) {
+			E("can't read data from chip!");
+			ts_status = HX_TS_GET_DATA_FAIL;
+		}
+	}
+
+	return ts_status;
+}
+
+/* start error_control*/
+static int himax_checksum_cal(struct himax_ts_data *ts, u8 *buf, int ts_path)
+{
+	u16 check_sum_cal = 0;
+	s32	i = 0;
+	int length = 0;
+	int zero_cnt = 0;
+	int ret_val = HX_TS_NORMAL_END;
+
+	/* Normal */
+	switch (ts_path) {
+	case HX_REPORT_COORD:
+	case HX_REPORT_COORD_RAWDATA:
+		length = ts->touch_info_size;
+		break;
+	default:
+		I("Neither Normal Nor SMWP error!");
+		ret_val = HX_PATH_FAIL;
+		goto END_FUNCTION;
+	}
+
+	for (i = 0; i < length; i++) {
+		check_sum_cal += buf[i];
+		if (buf[i] == 0x00)
+			zero_cnt++;
+	}
+
+	if (check_sum_cal % 0x100 != 0 && ts_path != HX_REPORT_COORD &&
+	    ts_path != HX_REPORT_COORD_RAWDATA) {
+		I("point data_checksum not match check_sum_cal: 0x%02X",
+		  check_sum_cal);
+		ret_val = HX_CHKSUM_FAIL;
+	} else if (zero_cnt == length) {
+		if (ts->use_irq)
+			I("[HIMAX TP MSG] All Zero event");
+
+		ret_val = HX_CHKSUM_FAIL;
+	} else {
+		if (ts_path == HX_REPORT_COORD ||
+		    ts_path == HX_REPORT_COORD_RAWDATA) {
+			ret_val = HX_REPORT_DATA;
+			goto END_FUNCTION;
+		}
+		/*Need to clear event stack here*/
+		g_core_fp.fp_read_event_stack(ts, buf,
+			(HX_STACK_ORG_LEN -	ts->touch_info_size));
+	}
+
+END_FUNCTION:
+	return ret_val;
+}
+
+static int hx_hid_parse(struct hid_device *hid)
+{
+	struct himax_ts_data *ts = NULL;
+	int ret;
+
+	if (!hid) {
+		E("hid is NULL");
+		return -EINVAL;
+	}
+
+	ts = hid->driver_data;
+	if (!ts) {
+		E("hid->driver_data is NULL");
+		return -EINVAL;
+	}
+
+	ret = hid_parse_report(hid, ts->hid_rd_data.rd_data,
+			       ts->hid_rd_data.rd_length);
+	if (ret) {
+		E("failed parse report");
+		return	ret;
+	}
+	I("rdesc parse success");
+	return 0;
+}
+
+static int hx_hid_start(struct hid_device *hid)
+{
+	D("enter");
+	return 0;
+}
+
+static void hx_hid_stop(struct hid_device *hid)
+{
+	D("enter");
+}
+
+static int hx_hid_open(struct hid_device *hid)
+{
+	D("enter");
+	return 0;
+}
+
+static void hx_hid_close(struct hid_device *hid)
+{
+	D("enter");
+}
+
+void hx_hid_update_info(struct himax_ts_data *ts)
+{
+	memcpy(&ts->hid_info.fw_bin_desc, &ts->fw_bin_desc, sizeof(struct hx_bin_desc_t));
+	ts->hid_info.vid = cpu_to_be16(ts->hid_desc.vendor_id);
+	ts->hid_info.pid = cpu_to_be16(ts->hid_desc.product_id);
+	ts->hid_info.cfg_version = ts->ic_data->vendor_touch_cfg_ver;
+	ts->hid_info.disp_version = ts->ic_data->vendor_display_cfg_ver;
+	ts->hid_info.rx = ts->ic_data->HX_RX_NUM;
+	ts->hid_info.tx = ts->ic_data->HX_TX_NUM;
+	ts->hid_info.yres = cpu_to_be16(ts->ic_data->HX_Y_RES);
+	ts->hid_info.xres = cpu_to_be16(ts->ic_data->HX_X_RES);
+	ts->hid_info.pt_num = ts->ic_data->HX_MAX_PT;
+	ts->hid_info.mkey_num = ts->ic_data->HX_BT_NUM;
+
+	// firmware table parameters, use only bl part.
+	ts->hid_info.bl_mapping.cmd = HID_FW_UPDATE_BL_CMD;
+	ts->hid_info.bl_mapping.bin_start_offset = 0;
+	ts->hid_info.bl_mapping.unit_sz = ts->ic_data->flash_size / 1024;
+}
+
+static int hx_hid_get_raw_report(const struct hid_device *hid, unsigned char reportnum,
+				 __u8 *buf, size_t len, unsigned char report_type)
+{
+	struct himax_ts_data *ts = NULL;
+	int ret = 0;
+
+	ts = hid->driver_data;
+	if (!ts) {
+		E("hid->driver_data is NULL");
+		return -EINVAL;
+	}
+
+	D("reportnum:%d, len:%lu, report_type:%d", reportnum, len, report_type);
+
+	switch (reportnum) {
+	case ID_CONTACT_COUNT:
+		if (!ts->ic_data) {
+			E("ts->ic_data is NULL");
+			return -EINVAL;
+		}
+		buf[1] = ts->ic_data->HX_MAX_PT;
+		ret = len;
+		break;
+
+	default:
+		ret = -EINVAL;
+	};
+
+	if (ret > 0)
+		D("ret:%d", ret);
+
+	return ret;
+}
+
+static int hx_raw_request(struct hid_device *hid, unsigned char reportnum,
+			  __u8 *buf, size_t len, unsigned char rtype, int reqtype)
+{
+	if (!hid) {
+		E("hid is NULL");
+		return -EINVAL;
+	}
+
+	D("report num %d, len %lu, rtype %d, reqtype %d", reportnum, len, rtype, reqtype);
+	switch (reqtype) {
+	case HID_REQ_GET_REPORT:
+		return hx_hid_get_raw_report(hid, reportnum, buf, len, rtype);
+	default:
+		return -EIO;
+	}
+
+	return -EINVAL;
+}
+
+static struct hid_ll_driver hx_hid_ll_driver = {
+	.parse = hx_hid_parse,
+	.start = hx_hid_start,
+	.stop = hx_hid_stop,
+	.open = hx_hid_open,
+	.close = hx_hid_close,
+	.raw_request = hx_raw_request
+};
+
+int hx_hid_report(const struct himax_ts_data *ts, u8 *data, s32 len)
+{
+	int ret = 0;
+
+	if (ts->hid)
+		ret = hid_input_report(ts->hid, HID_INPUT_REPORT, data, len, 1);
+
+	return ret;
+}
+
+static int hx_hid_desc_fetch(struct himax_ts_data *ts)
+{
+	if (!ts)
+		return -EINVAL;
+
+	I("desc_length:           %d", ts->hid_desc.desc_length);
+	I("bcd_version:           0x%x", ts->hid_desc.bcd_version);
+	I("report_desc_length:    %d", ts->hid_desc.report_desc_length);
+	I("max_input_length:      %d", ts->hid_desc.max_input_length);
+	I("max_output_length:     %d", ts->hid_desc.max_output_length);
+	I("max fragment length:   %d", ts->hid_desc.max_fragment_length);
+	I("vendor_id:             0x%x", ts->hid_desc.vendor_id);
+	I("product_id:            0x%x", ts->hid_desc.product_id);
+	I("version_id:            0x%x", ts->hid_desc.version_id);
+	I("flags:                 0x%x", ts->hid_desc.flags);
+
+	return 0;
+}
+
+int hx_hid_probe(struct himax_ts_data *ts)
+{
+	int ret;
+	struct hid_device *hid = NULL;
+
+	if (!ts) {
+		E("ts is NULL");
+		return -EINVAL;
+	}
+
+	ret = hx_hid_desc_fetch(ts);
+	if (ret) {
+		E("failed get hid desc");
+		return ret;
+	}
+
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
+	hid->ll_driver = &hx_hid_ll_driver;
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
+		E("failed add hid device");
+		goto err_hid_data;
+	}
+	I("hid init success");
+	ts->hid = hid;
+	mutex_unlock(&ts->hid_ioctl_lock);
+	return 0;
+
+err_hid_data:
+	hid_destroy_device(hid);
+	return ret;
+}
+
+void hx_hid_remove(struct himax_ts_data *ts)
+{
+	mutex_lock(&ts->hid_ioctl_lock);
+	if (ts && ts->hid) {
+		hid_destroy_device(ts->hid);
+	} else {
+		D("ts or hid is NULL");
+		goto OUT;
+	}
+	ts->hid = NULL;
+
+	if (ts->hid_req_cfg.fw) {
+		I("free fw");
+		kfree(ts->hid_req_cfg.fw->data);
+		kfree(ts->hid_req_cfg.fw->priv);
+		kfree(ts->hid_req_cfg.fw);
+		ts->hid_req_cfg.fw = NULL;
+	}
+OUT:
+	mutex_unlock(&ts->hid_ioctl_lock);
+}
+static void himax_excp_hw_reset(struct himax_ts_data *ts)
+{
+
+	I("START EXCEPTION Reset");
+	hx_hid_remove(ts);
+	g_core_fp.fp_excp_ic_reset(ts);
+	hx_hid_probe(ts);
+
+	I("END EXCEPTION Reset");
+}
+
+static int himax_ts_event_check(struct himax_ts_data *ts,
+				const u8 *buf, int ts_path)
+{
+	u32 hx_EB_event = 0;
+	u32 hx_EC_event = 0;
+	u32 hx_ED_event = 0;
+	u32 hx_excp_event = 0;
+	u32 hx_zero_event = 0;
+	int shaking_ret = 0;
+
+	u32 i = 0;
+	u32 length = 0;
+	int ret_val = 0;
+
+	/* Normal */
+	switch (ts_path) {
+	case HX_REPORT_COORD:
+		length = ts->touch_info_size;
+		break;
+	case HX_REPORT_COORD_RAWDATA:
+		length = ts->touch_info_size;
+		break;
+	default:
+		I("Neither Normal Nor SMWP error!");
+		ret_val = HX_PATH_FAIL;
+		goto END_FUNCTION;
+	}
+
+	if (ts_path == HX_REPORT_COORD || ts_path == HX_REPORT_COORD_RAWDATA) {
+		for (i = 0; i < length; i++) {
+			/* case 1 EXCEEPTION recovery flow */
+			if (buf[i] == 0xEB) {
+				hx_EB_event++;
+			} else if (buf[i] == 0xEC) {
+				hx_EC_event++;
+			} else if (buf[i] == 0xED) {
+				hx_ED_event++;
+
+			/* case 2 EXCEPTION recovery flow-Disable */
+			} else if (buf[i] == 0x00) {
+				hx_zero_event++;
+			} else {
+				ts->excp_zero_event_count = 0;
+				break;
+			}
+		}
+	}
+
+	if (hx_EB_event == length) {
+		hx_excp_event = length;
+		ts->excp_eb_event_flag++;
+		I("[HIMAX TP MSG]: EXCEPTION event checked - ALL 0xEB.");
+	} else if (hx_EC_event == length) {
+		hx_excp_event = length;
+		ts->excp_ec_event_flag++;
+		I("[HIMAX TP MSG]: EXCEPTION event checked - ALL 0xEC.");
+	} else if (hx_ED_event == length) {
+		hx_excp_event = length;
+		ts->excp_ed_event_flag++;
+		I("[HIMAX TP MSG]: EXCEPTION event checked - ALL 0xED.");
+	}
+
+	if ((hx_excp_event == length || hx_zero_event == length) &&
+	    ts->excp_reset_active == 0) {
+		shaking_ret = g_core_fp.fp_ic_excp_recovery(ts,
+			hx_excp_event, hx_zero_event, length);
+
+		if (shaking_ret == HX_EXCP_EVENT) {
+			g_core_fp.fp_read_FW_status(ts);
+			himax_excp_hw_reset(ts);
+			ret_val = HX_EXCP_EVENT;
+		} else if (shaking_ret == HX_ZERO_EVENT_COUNT) {
+			g_core_fp.fp_read_FW_status(ts);
+			ret_val = HX_ZERO_EVENT_COUNT;
+		} else {
+			I("IC is running. Nothing to be done!");
+			ret_val = HX_IC_RUNNING;
+		}
+
+	/* drop 1st interrupts after chip reset */
+	} else if (ts->excp_reset_active) {
+		ts->excp_reset_active = 0;
+		I("Skip by excp_reset_active.");
+		ret_val = HX_EXCP_REC_OK;
+	}
+
+END_FUNCTION:
+
+	return ret_val;
+}
+
+static int himax_err_ctrl(struct himax_ts_data *ts,
+			  u8 *buf, int ts_path)
+{
+	int ts_status = HX_CHKSUM_FAIL;
+
+	ts_status = himax_checksum_cal(ts, buf, ts_path);
+	if (ts_status == HX_CHKSUM_FAIL) {
+		goto CHK_FAIL;
+	} else {
+		/* continuous N times record, not total N times. */
+		ts->excp_zero_event_count = 0;
+		goto END_FUNCTION;
+	}
+
+CHK_FAIL:
+	ts_status = himax_ts_event_check(ts, buf, ts_path);
+END_FUNCTION:
+	return ts_status;
+}
+
+/* end error_control*/
+
+static int himax_ts_operation(struct himax_ts_data *ts,
+			      int ts_path)
+{
+	int ts_status = HX_TS_NORMAL_END;
+	int ret = 0;
+	u32 offset = 0;
+
+	memset(ts->xfer_buff,
+	       0x00,
+		ts->touch_all_size * sizeof(u8));
+	ts_status = himax_touch_get(ts, ts->xfer_buff, ts_path);
+	if (ts_status == HX_TS_GET_DATA_FAIL)
+		goto END_FUNCTION;
+
+	ts_status = himax_err_ctrl(ts, ts->xfer_buff, ts_path);
+	if (!(ts_status == HX_REPORT_DATA || ts_status == HX_TS_NORMAL_END))
+		goto END_FUNCTION;
+	if (ts->hid_probe) {
+		offset = 0;
+		if (!ts->hid_req_cfg.input_RD_de) {
+			ret = hx_hid_report(ts, ts->xfer_buff + offset + HID_REPORT_HDR_SZ,
+					    ts->hid_desc.max_input_length - HID_REPORT_HDR_SZ);
+		}
+		offset += ts->hid_desc.max_input_length;
+		if (ts->ic_data->HX_STYLUS_FUNC) {
+			if (!ts->hid_req_cfg.input_RD_de) {
+				ret += hx_hid_report(ts,
+					ts->xfer_buff + offset + HID_REPORT_HDR_SZ,
+					ts->hid_desc.max_input_length - HID_REPORT_HDR_SZ);
+			}
+			offset += ts->hid_desc.max_input_length;
+		}
+	}
+
+	if (ret != 0)
+		ts_status = HX_TS_GET_DATA_FAIL;
+
+END_FUNCTION:
+	return ts_status;
+}
+
+void himax_cable_detect_func(struct himax_ts_data *ts, bool force_renew)
+{
+	/*u32 connect_status = 0;*/
+	u8 connect_status = 0;
+
+	connect_status = ts->latest_power_status;
+
+	/* I("Touch: cable status=%d, cable_config=%p, usb_connected=%d\n",*/
+	/*		connect_status, ts->cable_config, ts->usb_connected); */
+	if (ts->cable_config) {
+		if (connect_status != ts->usb_connected || force_renew) {
+			if (connect_status) {
+				ts->cable_config[1] = 0x01;
+				ts->usb_connected = 0x01;
+			} else {
+				ts->cable_config[1] = 0x00;
+				ts->usb_connected = 0x00;
+			}
+
+			g_core_fp.fp_usb_detect_set(ts, ts->cable_config);
+			I("Cable status change: 0x%2.2X",
+			  ts->usb_connected);
+		}
+	}
+}
+
+void himax_ts_work(struct himax_ts_data *ts)
+{
+	int ts_status = HX_TS_NORMAL_END;
+	int ts_path = 0;
+
+	if (ts->notouch_frame > 0) {
+		ts->notouch_frame--;
+		return;
+	}
+
+	himax_cable_detect_func(ts, false);
+
+	ts_path = HX_REPORT_COORD;
+	ts_status = himax_ts_operation(ts, ts_path);
+	if (ts_status == HX_TS_GET_DATA_FAIL) {
+		I("Now reset the Touch chip.");
+		g_core_fp.fp_ic_reset(ts, false, true);
+	}
+}
+
+/*end ts_work*/
+enum hrtimer_restart himax_ts_timer_func(struct hrtimer *timer)
+{
+	struct himax_ts_data *ts;
+
+	ts = container_of(timer, struct himax_ts_data, timer);
+	queue_work(ts->himax_wq, &ts->work);
+	hrtimer_start(&ts->timer, ktime_set(0, 12500000), HRTIMER_MODE_REL);
+
+	return HRTIMER_NORESTART;
+}
+
+static int hx_chk_flash_sts(struct himax_ts_data *ts, u32 size)
+{
+	int rslt = 0;
+	return rslt;
+}
+
+static int hx_hid_rd_init(struct himax_ts_data *ts)
+{
+	int ret = 0;
+	const u32 x_num = ts->ic_data->HX_RX_NUM;
+	const u32 y_num = ts->ic_data->HX_TX_NUM;
+	unsigned int raw_data_sz = (x_num * y_num + x_num + y_num) * 2 + 4;
+	u32 rd_sz = 0;
+
+	if (ts->hid_req_cfg.input_RD_de == 0)
+		rd_sz = ts->hid_desc.report_desc_length + host_ext_report_desc_sz;
+	else
+		rd_sz = host_heatmap_report_desc_sz + host_ext_report_desc_sz;
+
+	if (FLASH_VER_GET_VAL(addr_hid_rd_desc) != 0) {
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
+			if (ts->hid_req_cfg.input_RD_de == 0) {
+				memcpy((void *)ts->hid_rd_data.rd_data,
+				       &ts->hxfw->data[FLASH_VER_GET_VAL(addr_hid_rd_desc)],
+				       ts->hid_desc.report_desc_length);
+				ts->hid_rd_data.rd_length = ts->hid_desc.report_desc_length;
+			} else {
+				memcpy((void *)ts->hid_rd_data.rd_data,
+				       g_heatmap_rd.host_report_descriptor,
+				       host_heatmap_report_desc_sz);
+				ts->hid_rd_data.rd_length = host_heatmap_report_desc_sz;
+			}
+			I("Re-assign HID DIAG size: original = %d, new = %d",
+			  le16_to_cpu(g_host_ext_rd.rd_struct.monitor.report_cnt),
+			  raw_data_sz);
+			g_host_ext_rd.rd_struct.monitor.report_cnt = cpu_to_le16(raw_data_sz);
+			memcpy((void *)(ts->hid_rd_data.rd_data + ts->hid_rd_data.rd_length),
+			       &g_host_ext_rd.host_report_descriptor, host_ext_report_desc_sz);
+			ts->hid_rd_data.rd_length += host_ext_report_desc_sz;
+		} else {
+			E("hid rd data alloc fail");
+			ret = -ENOMEM;
+		}
+	}
+
+	return ret;
+}
+
+static void hx_hid_register(struct himax_ts_data *ts)
+{
+	if (ts->hid_probe) {
+		hid_destroy_device(ts->hid);
+		ts->hid = NULL;
+		ts->hid_probe = false;
+	}
+
+	if (hx_hid_probe(ts) != 0) {
+		E("hid probe fail");
+		ts->hid_probe = false;
+	} else {
+		I("hid probe success");
+		ts->hid_probe = true;
+	}
+}
+
+static int hx_hid_report_data_init(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	ts->touch_info_size = ts->hid_desc.max_input_length;
+	I("base touch_info_size = %d", ts->touch_info_size);
+	if (ts->ic_data->HX_STYLUS_FUNC) {
+		ts->touch_info_size += ts->hid_desc.max_input_length;
+		I("include stylus touch_info_size = %d", ts->touch_info_size);
+	}
+	ts->touch_all_size = ts->touch_info_size;
+
+	if (himax_report_data_init(ts) != 0) {
+		E("report data init fail");
+		ret = -ENOMEM;
+	}
+
+	return ret;
+}
+
+static void himax_boot_upgrade(struct work_struct *work)
+{
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+			work_boot_upgrade.work);
+
+	I("Entering");
+	ts->ic_boot_done = false;
+
+	if (hx_chk_flash_sts(ts, ts->ic_data->flash_size) == 1) {
+		E("check flash fail, please upgrade FW");
+		goto END;
+	} else {
+		g_core_fp.fp_reload_disable(ts, 0);
+		g_core_fp.fp_power_on_init(ts);
+		g_core_fp.fp_read_FW_ver(ts);
+		g_core_fp.fp_tp_info_check(ts);
+	}
+END:
+	ts->ic_boot_done = true;
+	himax_int_enable(ts, true);
+
+}
+
+void hx_hid_update(struct work_struct *work)
+{
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+			work_hid_update.work);
+
+	himax_int_enable(ts, false);
+
+	if (ts->hid_req_cfg.input_RD_de == 0) {
+		himax_boot_upgrade(&ts->work_boot_upgrade.work);
+	} else {
+		if (hx_hid_rd_init(ts) == 0) {
+			I("hid rd init success");
+			hx_hid_register(ts);
+			if (ts->hid_probe)
+				hx_hid_report_data_init(ts);
+		}
+		himax_int_enable(ts, true);
+	}
+}
+
+int himax_report_data_init(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	kfree(ts->hx_rawdata_buf);
+	ts->hx_rawdata_buf = NULL;
+
+	ts->hx_rawdata_buf = kzalloc(ts->touch_info_size, GFP_KERNEL);
+	if (!ts->hx_rawdata_buf) {
+		E("ts->hx_rawdata_buf kzalloc failed!");
+		ret = -ENOMEM;
+		goto fail_1;
+	}
+
+	return 0;
+fail_1:
+
+	return ret;
+}
+
+void himax_report_data_deinit(struct himax_ts_data *ts)
+{
+	kfree(ts->hx_rawdata_buf);
+	ts->hx_rawdata_buf = NULL;
+}
+
+
+int himax_chip_suspend(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	if (ts->suspended) {
+		I("Already suspended, skip...");
+		goto END;
+	} else {
+		ts->suspended = true;
+	}
+
+	I("enter");
+	g_core_fp.fp_suspend_proc(ts, ts->suspended);
+
+	himax_int_enable(ts, false);
+
+	if (!ts->use_irq) {
+		s32 cancel_state;
+
+		cancel_state = cancel_work_sync(&ts->work);
+		if (cancel_state)
+			himax_int_enable(ts, true);
+	}
+
+	atomic_set(&ts->suspend_mode, 1);
+
+	if (ts->pdata) {
+		if (ts->pdata->power_off_3v3) {
+			if (ts->pdata->vcca_supply)
+				ret = regulator_disable(ts->pdata->vcca_supply);
+		}
+	}
+
+END:
+	hx_hid_remove(ts);
+	I("END");
+
+	return ret;
+}
+
+int himax_chip_resume(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	if (!ts->suspended && ts->resume_success) {
+		I("Already resumed, skip...");
+		goto END;
+	} else {
+		ts->suspended = false;
+	}
+	ts->resume_success = false;
+
+	I("enter");
+	/* continuous N times record, not total N times. */
+	ts->excp_zero_event_count = 0;
+
+	atomic_set(&ts->suspend_mode, 0);
+	if (ts->pdata) {
+		if (ts->pdata->power_off_3v3) {
+			if (ts->pdata->vcca_supply)
+				ret = regulator_enable(ts->pdata->vcca_supply);
+		}
+	}
+
+	g_core_fp.fp_resume_proc(ts, ts->suspended);
+	// hx_report_all_leave_event(ts);
+	if (ts->resume_success) {
+		hx_hid_probe(ts);
+		himax_int_enable(ts, true);
+	} else {
+		E("resume failed!");
+		ret = -ECANCELED;
+	}
+END:
+	I("END");
+
+	return ret;
+}
+
+int himax_suspend(struct device *dev)
+{
+	struct himax_ts_data *ts = dev_get_drvdata(dev);
+
+	I("enter");
+	if (!ts->initialized) {
+		E("init not ready, skip!");
+		return -ECANCELED;
+	}
+	himax_chip_suspend(ts);
+	return 0;
+}
+
+int himax_resume(struct device *dev)
+{
+	int ret = 0;
+	struct himax_ts_data *ts = dev_get_drvdata(dev);
+
+	I("enter");
+	/*
+	 *	wait until device resume for TDDI
+	 *	TDDI: Touch and display Driver IC
+	 */
+	if (!ts->initialized) {
+#if !defined(CONFIG_FB)
+		if (himax_chip_init(ts))
+			return -ECANCELED;
+#else
+		E("init not ready, skip!");
+		return -ECANCELED;
+#endif
+	}
+	ret = himax_chip_resume(ts);
+	if (ret < 0) {
+		E("resume failed!");
+		I("retry resume");
+		schedule_delayed_work(&ts->work_resume_delayed_work,
+				      msecs_to_jiffies(ts->pdata->ic_resume_delay));
+		// I("try int rescue");
+		// himax_int_enable(ts, 1);
+	}
+
+	return ret;
+}
+
+static void himax_resume_work_func(struct work_struct *work)
+{
+	struct himax_ts_data *ts = NULL;
+
+	ts = container_of(work, struct himax_ts_data,
+			  work_resume_delayed_work.work);
+	if (!ts) {
+		E("ts is NULL");
+		return;
+	}
+	himax_chip_resume(ts);
+}
+
+#if defined(CONFIG_PM_SLEEP)
+static const struct dev_pm_ops hx_hid_pm = {
+	.suspend = himax_suspend,
+	.resume = himax_resume,
+	.restore = himax_resume,
+};
+
+#define HX_HID_PM (&hx_hid_pm)
+#else
+#define HX_HID_PM NULL
+#endif
+
+#if defined(CONFIG_OF)
+static const struct of_device_id himax_match_table[] = {
+	{ .compatible = "himax,hx83102j" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, himax_match_table);
+#define himax_match_table of_match_ptr(himax_match_table)
+#else
+#define himax_match_table NULL
+#endif
+
+
+#define hx_acpi_spi_table NULL
+
+
+int himax_chip_init(struct himax_ts_data *ts)
+{
+	int err = PROBE_FAIL;
+	struct himax_platform_data *pdata = ts->pdata;
+
+	ts->chip_max_dsram_size = 0;
+	ts->notouch_frame = 0;
+	ts->ic_notouch_frame = 0;
+
+	if (g_core_fp.fp_chip_init) {
+		g_core_fp.fp_chip_init(ts);
+	} else {
+		E("function point of chip_init is NULL!");
+		goto error_ic_init_failed;
+	}
+	g_core_fp.fp_touch_information(ts);
+
+	spin_lock_init(&ts->irq_lock);
+
+	if (himax_ts_register_interrupt(ts)) {
+		E("register interrupt failed");
+		goto err_register_interrupt_failed;
+	}
+
+	himax_int_enable(ts, false);
+
+	ts->himax_hid_debug_wq =
+		create_singlethread_workqueue("HX_hid_debug");
+	if (!ts->himax_hid_debug_wq) {
+		E("allocate himax_hid_debug_wq failed");
+		err = -ENOMEM;
+		goto err_hid_debug_wq_failed;
+	}
+	INIT_DELAYED_WORK(&ts->work_hid_update, hx_hid_update);
+
+	ts->himax_resume_delayed_work_wq =
+		create_singlethread_workqueue("HX_resume_delayed_work");
+	if (!ts->himax_resume_delayed_work_wq) {
+		E("allocate himax_resume_delayed_work_wq failed");
+		err = -ENOMEM;
+		goto err_resume_delayed_work_wq_failed;
+	}
+	INIT_DELAYED_WORK(&ts->work_resume_delayed_work, himax_resume_work_func);
+
+	g_core_fp.fp_calc_touch_data_size(ts);
+
+#if defined(CONFIG_OF)
+	pdata->cable_config[0]             = 0xF0;
+	pdata->cable_config[1]             = 0x00;
+#endif
+
+	ts->suspended                      = false;
+	ts->usb_connected = 0x00;
+	ts->cable_config = pdata->cable_config;
+	ts->initialized = true;
+	return 0;
+
+err_resume_delayed_work_wq_failed:
+	destroy_workqueue(ts->himax_hid_debug_wq);
+err_hid_debug_wq_failed:
+	himax_ts_unregister_interrupt(ts);
+err_register_interrupt_failed:
+error_ic_init_failed:
+	ts->probe_fail_flag = 1;
+	return err;
+}
+
+void himax_chip_deinit(struct himax_ts_data *ts)
+{
+	kfree(ts->zf_update_cfg_buffer);
+	ts->zf_update_cfg_buffer = NULL;
+
+	himax_ts_unregister_interrupt(ts);
+
+	himax_report_data_deinit(ts);
+
+	cancel_delayed_work_sync(&ts->work_resume_delayed_work);
+	destroy_workqueue(ts->himax_resume_delayed_work_wq);
+	destroy_workqueue(ts->himax_hid_debug_wq);
+
+	ts->probe_fail_flag = 0;
+
+	I("Common section deinited!");
+}
+
+static void himax_platform_deinit(struct himax_ts_data *ts)
+{
+	struct himax_platform_data *pdata = NULL;
+
+	I("entering");
+
+	if (!ts) {
+		E("ts is NULL");
+		return;
+	}
+
+	pdata = ts->pdata;
+	if (!pdata) {
+		E("pdata is NULL");
+		return;
+	}
+
+	himax_gpio_power_deconfig(pdata);
+
+	kfree(ts->ic_data);
+	ts->ic_data = NULL;
+
+	kfree(pdata);
+	pdata = NULL;
+	ts->pdata = NULL;
+
+	kfree(ts->xfer_buff);
+	ts->xfer_buff = NULL;
+
+	I("exit");
+}
+
+static bool himax_platform_init(struct himax_ts_data *ts,
+				struct himax_platform_data *local_pdata)
+{
+	int err = PROBE_FAIL;
+	struct himax_platform_data *pdata;
+
+	I("entering");
+	ts->xfer_buff = kcalloc
+		(HX_FULL_STACK_RAWDATA_SIZE, sizeof(u8), GFP_KERNEL);
+	if (!ts->xfer_buff) {
+		err = -ENOMEM;
+		goto err_xfer_buff_fail;
+	}
+
+	I("PDATA START");
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) { /*Allocate Platform data space*/
+		err = -ENOMEM;
+		goto err_dt_platform_data_fail;
+	}
+
+	I("ts->ic_data START");
+	ts->ic_data = kzalloc(sizeof(*ts->ic_data), GFP_KERNEL);
+	if (!ts->ic_data) { /*Allocate IC data space*/
+		err = -ENOMEM;
+		goto err_dt_ic_data_fail;
+	}
+	memset(ts->ic_data, 0xFF, sizeof(struct himax_ic_data));
+	/* default 128k, different size please follow HX83121A style */
+	ts->ic_data->flash_size = 131072;
+
+	memcpy(pdata, local_pdata, sizeof(struct himax_platform_data));
+	ts->pdata = pdata;
+	pdata->ts = ts;
+	ts->rst_gpio = pdata->gpio_reset;
+
+	if (himax_gpio_power_config(ts, pdata) < 0) {
+		E("gpio config fail, exit!");
+		goto err_power_config_failed;
+	}
+
+	I("Completed.");
+
+	return true;
+
+err_power_config_failed:
+	kfree(ts->ic_data);
+	ts->ic_data = NULL;
+err_dt_ic_data_fail:
+	kfree(pdata);
+	pdata = NULL;
+err_dt_platform_data_fail:
+	kfree(ts->xfer_buff);
+	ts->xfer_buff = NULL;
+err_xfer_buff_fail:
+	return false;
+}
+
+static struct himax_ts_data *get_ts(struct device *dev)
+{
+	struct list_head *listptr = NULL;
+	struct himax_ts_data *ts = NULL;
+	struct himax_ts_data *tmp_ts = NULL;
+
+	if (!g_himax_ts->dev ||
+	    g_himax_ts->dev == dev) {
+		D("Found 1st device : %p", dev);
+		return g_himax_ts;
+	}
+
+	D("Matching for device %p", dev);
+	list_for_each(listptr, &g_himax_ts->list) {
+		tmp_ts = list_entry(listptr, struct himax_ts_data, list);
+		if (tmp_ts->dev == dev) {
+			ts = tmp_ts;
+			break;
+		}
+	}
+	if (!ts)
+		D("No matching device found");
+
+	return ts;
+}
+
+int himax_parse_dt(struct device_node *dt, struct himax_platform_data *pdata)
+{
+	/* pid_fw_name size = length of default_fw_name + length of "_XXXX" +
+	 * length of ".bin" + null terminator.
+	 */
+	static char pid_fw_name[ARRAY_SIZE(default_fw_name) + 5 + 4 + 1] = {0};
+	int tmp = 0;
+	const int pid_prop_args = 2;
+	u32 data = 0;
+	int id_gpios[8] = {0};
+	int counter = 0;
+	int i = 0;
+	s16 id_value = -1;
+	int dts_irq = 0;
+	int err = 0;
+
+	UNUSED(default_fw_name);
+	if (!dt || !pdata) {
+		E("DT: dev or pdata is NULL");
+		return -EINVAL;
+	}
+
+	dts_irq = of_irq_get(dt, 0);
+	D("DT: dts_irq = %d", dts_irq);
+	if (dts_irq <= 0) {
+		if (dts_irq == -EPROBE_DEFER)
+			E("DT: dts_irq = -EPROBE_DEFER");
+		return -EIO;
+	}
+
+	pdata->of_irq = dts_irq;
+	pdata->gpio_irq = -1;
+
+	pdata->gpio_reset = of_get_named_gpio(dt, "reset-gpios", 0);
+	if (!gpio_is_valid(pdata->gpio_reset)) {
+		I(" DT:gpio-rst value is not valid");
+		return -EIO;
+	}
+
+	I(" DT:interrupt=%d, reset=%d",
+	  pdata->of_irq, pdata->gpio_reset);
+	counter = gpiod_count(pdata->ts->dev, "himax,id");
+	if (counter > 0) {
+		for (i = 0 ; i < counter ; i++) {
+			id_gpios[i] = of_get_named_gpio(dt, "himax,id-gpios", i);
+			if (!gpio_is_valid(id_gpios[i])) {
+				I(" DT:gpio-id value is not valid");
+				return -EIO;
+			}
+			I(" DT:gpio-id[%d]=%d", i, id_gpios[i]);
+		}
+		id_value = 0;
+		for (i = 0 ; i < counter ; i++) {
+			gpio_direction_input(id_gpios[i]);
+			id_value |= gpio_get_value(id_gpios[i]) << i;
+		}
+		I(" DT:gpio-id value=%04X", id_value);
+		pdata->panel_id = id_value;
+	} else {
+		pdata->panel_id = -1;
+		D(" DT:gpio-id not found");
+	}
+
+	// himax,ic_det_delay unit is millisecond
+	if (of_property_read_u32(dt, "himax,ic-det-delay-ms", &data)) {
+		pdata->ic_det_delay = 0;
+		D(" DT:himax,ic-det-delay-ms not found");
+	} else {
+		pdata->ic_det_delay = data;
+		I(" DT:himax,ic-det-delay-ms=%d", pdata->ic_det_delay);
+	}
+
+	// himax,ic_resume_delay unit is millisecond
+	if (of_property_read_u32(dt, "himax,ic-resume-delay-ms", &data)) {
+		pdata->ic_resume_delay = 0;
+		D(" DT:himax,ic-resume-delay-ms not found");
+	} else {
+		pdata->ic_resume_delay = data;
+		I(" DT:himax,ic-resume-delay-ms=%d", pdata->ic_resume_delay);
+	}
+
+	if (of_property_read_bool(dt, "himax,has-flash")) {
+		pdata->is_zf = false;
+		D(" DT:himax,has-flash");
+	} else {
+		pdata->is_zf = true;
+		I(" DT:himax,has-flash not found, load firmware from file");
+	}
+
+	if (of_property_read_bool(dt, "vccd-supply")) {
+		pdata->vccd_supply = regulator_get(pdata->ts->dev, "vccd");
+		if (IS_ERR(pdata->vccd_supply)) {
+			E(" DT:failed to get vccd supply");
+			err = PTR_ERR(pdata->vccd_supply);
+			pdata->vccd_supply = NULL;
+			return err;
+		}
+		I(" DT:vccd-supply=%p", pdata->vccd_supply);
+	} else {
+		pdata->vccd_supply = NULL;
+	}
+
+	if (of_property_read_bool(dt, "vcca-supply")) {
+		pdata->vcca_supply = regulator_get(pdata->ts->dev, "vcca");
+		if (IS_ERR(pdata->vcca_supply)) {
+			E(" DT:failed to get vcca supply");
+			err = PTR_ERR(pdata->vcca_supply);
+			pdata->vcca_supply = NULL;
+			return err;
+		}
+		I(" DT:vcca-supply=%p", pdata->vcca_supply);
+	} else {
+		pdata->vcca_supply = NULL;
+	}
+
+	/*
+	 * check himax,pid first, if exist then check if it is single.
+	 * Single case: himax,pid = <0x1002>; // 0x1002 is pid value
+	 * Multiple case: himax,pid = <id_value0 00x1001>, <id_value1 0x1002>;
+	 * When id_value >= 0, check the mapping listed to use the pid value.
+	 */
+	if (of_get_property(dt, "himax,pid", &data)) {
+		counter = data / (sizeof(u32) * pid_prop_args);
+
+		if (!counter) {
+			// default case, no id->pid mappings
+			if (of_property_read_u32(dt, "himax,pid", &data)) {
+				pdata->pid = 0;
+				D(" DT:himax,pid not found");
+				goto GET_PID_END;
+			} else {
+				goto GET_PID_VALUE;
+			}
+		}
+
+		if (id_value < 0) {
+			E(" DT:himax,pid has no matched for id_value=%04X", id_value);
+			pdata->pid = 0;
+			goto GET_PID_END;
+		}
+
+		for (i = 0; i < counter; i++) {
+			if (of_property_read_u32_index(dt, "himax,pid",
+						       i * pid_prop_args, &tmp)) {
+				D(" DT:himax,pid parsing error!");
+				pdata->pid = 0;
+				goto GET_PID_END;
+			}
+
+			if (of_property_read_u32_index(dt, "himax,pid",
+						       i * pid_prop_args + 1, &data)) {
+				D(" DT:himax,pid parsing error!");
+				pdata->pid = 0;
+				goto GET_PID_END;
+			}
+
+			if (tmp == id_value) {
+				I(" DT:himax,pid mapping: id=%04X => pid=%04X, matched!",
+				  tmp, data);
+				i = counter;
+			} else {
+				I(" DT:himax,pid mapping: id=%04X => pid=%04X", tmp, data);
+			}
+		}
+
+		if (counter == i) {
+			E(" DT:himax,pid has no matched for id_value=%04X", id_value);
+			pdata->pid = 0;
+			goto GET_PID_END;
+		}
+
+GET_PID_VALUE:
+		g_fw_boot_upgrade_name = pid_fw_name;
+		pdata->pid = data;
+		snprintf(pid_fw_name, sizeof(pid_fw_name), "%s_%04X%s",
+			 BOOT_UPGRADE_FWNAME, pdata->pid, ".bin");
+		I(" DT:himax,pid=%04X, fw_name=%s",
+		  pdata->pid, pid_fw_name);
+	} else {
+		pdata->pid = 0;
+		D(" DT:himax,pid not found");
+	}
+GET_PID_END:
+
+	return 0;
+}
+
+
+int himax_spi_drv_probe(struct spi_device *spi)
+{
+	struct himax_ts_data *ts = NULL;
+	int ret = 0;
+	bool bret = false;
+	static struct himax_platform_data pdata = {0};
+#if defined(CONFIG_HID_HIMAX)
+	struct time_var current_time;
+#endif
+
+	ts = get_ts(&spi->dev);
+	if (!ts) {
+		// non exist, create new one
+		ts = kzalloc(sizeof(*ts), GFP_KERNEL);
+		if (!ts) {
+			E("allocate himax_ts_data failed");
+			ret = -ENOMEM;
+			goto err_alloc_data_failed;
+		}
+		list_add_tail(&ts->list, &g_himax_ts->list);
+		I("Allocated himax_ts_data for new device %p", &spi->dev);
+		ts->dev = &spi->dev;
+	}
+	if (ts == g_himax_ts)
+		ts->dev = &spi->dev;
+#if defined(CONFIG_HID_HIMAX)
+	if ((ts->deferred_start.tv_sec != 0 ||
+	     ts->deferred_start.tv_nsec != 0) && ts->ic_det_delay) {
+		time_func(&current_time);
+		if (time_diff(&ts->deferred_start, &current_time) <
+			ts->ic_det_delay) {
+			D("delay time not reach, defer probe");
+			return -EPROBE_DEFER;
+		}
+		I("delay time reach, probe again!");
+	}
+#endif
+	D("Enter");
+	if (spi->master->flags & SPI_MASTER_HALF_DUPLEX) {
+		E("Full duplex not supported by host");
+		return -EIO;
+	}
+	pdata.ts = ts;
+	ts->dev = &spi->dev;
+
+#if defined(CONFIG_OF)
+	if (himax_parse_dt(spi->dev.of_node, &pdata) < 0) {
+		E(" parse OF data failed!");
+		if (ts != g_himax_ts) {
+			list_del(&ts->list);
+			kfree(ts);
+			D("free ts %p of dev %p", ts, &spi->dev);
+		} else {
+			ts->dev = NULL;
+		}
+		return -ENODEV;
+	}
+#endif
+
+#if defined(CONFIG_HID_HIMAX)
+	if (pdata.ic_det_delay > 0) {
+		if (ts->deferred_start.tv_sec == 0 &&
+		    ts->deferred_start.tv_nsec == 0) {
+			I("delay %d ms for IC detect",
+			  pdata.ic_det_delay);
+			ts->ic_det_delay = pdata.ic_det_delay;
+			time_func(&ts->deferred_start);
+			return -EPROBE_DEFER;
+		}
+	}
+#endif
+
+	ts->xfer_data = kzalloc(BUS_RW_MAX_LEN, GFP_KERNEL);
+	if (!ts->xfer_data) {
+		E("allocate xfer_data failed");
+		ret = -ENOMEM;
+		goto err_alloc_xfer_data_failed;
+	}
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
+		E("platform init failed");
+		ret = -ENODEV;
+		goto error_platform_init_failed;
+	}
+	ts->ic_data->has_flash = !pdata.is_zf;
+
+	bret = g_core_fp.fp_chip_detect(ts);
+	if (!bret) {
+		E("IC detect failed");
+		ret = -ENODEV;
+		goto error_ic_detect_failed;
+	}
+
+	ret = himax_chip_init(ts);
+	if (ret < 0)
+		goto err_init_failed;
+
+#if defined(CONFIG_FB)
+	ts->himax_att_wq = create_singlethread_workqueue("HMX_ATT_request");
+	if (!ts->himax_att_wq) {
+		E(" allocate himax_att_wq failed");
+		ret = -ENOMEM;
+		goto err_get_intr_bit_failed;
+	}
+
+	INIT_DELAYED_WORK(&ts->work_att, himax_fb_register);
+	queue_delayed_work(ts->himax_att_wq, &ts->work_att,
+			   msecs_to_jiffies(0));
+#endif
+
+	ts->himax_pwr_wq = create_singlethread_workqueue("HMX_PWR_request");
+	if (!ts->himax_pwr_wq) {
+		E(" allocate himax_pwr_wq failed");
+		ret = -ENOMEM;
+		goto err_create_pwr_wq_failed;
+	}
+
+	INIT_DELAYED_WORK(&ts->work_pwr, himax_pwr_register);
+	queue_delayed_work(ts->himax_pwr_wq, &ts->work_pwr,
+			   msecs_to_jiffies(0));
+
+	ts->probe_finish = true;
+	I("%s, End\n", __func__);
+	return ret;
+
+err_create_pwr_wq_failed:
+#if defined(CONFIG_FB)
+	cancel_delayed_work_sync(&ts->work_att);
+	destroy_workqueue(ts->himax_att_wq);
+err_get_intr_bit_failed:
+#endif
+	himax_chip_deinit(ts);
+err_init_failed:
+error_ic_detect_failed:
+	himax_platform_deinit(ts);
+error_platform_init_failed:
+	kfree(ts->xfer_data);
+	ts->xfer_data = NULL;
+err_alloc_xfer_data_failed:
+	if (ts != g_himax_ts)
+		list_del(&ts->list);
+	kfree(ts);
+	ts = NULL;
+err_alloc_data_failed:
+
+	return ret;
+}
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
+				hx_hid_remove(ts);
+				ts->hid_probe = false;
+			}
+
+			kfree(ts->hid_rd_data.rd_data);
+			ts->hid_rd_data.rd_data = NULL;
+
+			ts->ic_boot_done = false;
+		}
+		power_supply_unreg_notifier(&ts->power_notif);
+		cancel_delayed_work_sync(&ts->work_pwr);
+		destroy_workqueue(ts->himax_pwr_wq);
+	#if defined(CONFIG_FB)
+		if (fb_unregister_client(&ts->fb_notif))
+			E("Err occur while unregister fb_noti.");
+		cancel_delayed_work_sync(&ts->work_att);
+		destroy_workqueue(ts->himax_att_wq);
+	#endif
+		himax_chip_deinit(ts);
+		himax_platform_deinit(ts);
+		ts->pdata = NULL;
+		kfree(ts->ovl_idx);
+		ts->ovl_idx = NULL;
+		kfree(ts->xfer_data);
+		ts->xfer_data = NULL;
+		ts->probe_fail_flag = 0;
+		if (ts != g_himax_ts) {
+			list_del(&ts->list);
+			kfree(ts);
+			ts = NULL;
+		}
+	}
+	spi_set_drvdata(spi, NULL);
+	I("completed.");
+}
+
+static void print_config(void)
+{
+#if !defined(CONFIG_HID_HIMAX)
+	D("Himax module defined.");
+#endif
+#if defined(CONFIG_DRM_ROCKCHIP)
+	D("CONFIG_DRM_ROCKCHIP defined.");
+#endif
+#if defined(CONFIG_FB)
+	D("CONFIG_FB defined.");
+#endif
+#if defined(CONFIG_OF)
+	D("CONFIG_OF defined.");
+#endif
+#if defined(BUS_R_DLEN)
+	D("BUS_R_DLEN defined : %d.", BUS_R_DLEN);
+#endif
+#if defined(BUS_W_DLEN)
+	D("BUS_W_DLEN defined : %d.", BUS_W_DLEN);
+#endif
+#if defined(BOOT_UPGRADE_FWNAME)
+	D("BOOT_UPGRADE_FWNAME defined : %s.", BOOT_UPGRADE_FWNAME);
+#endif
+#if defined(HIMAX_DRIVER_VER)
+	D("HIMAX_DRIVER_VER defined : %s.", HIMAX_DRIVER_VER);
+#endif
+#if defined(HX_HID_PM)
+	D("HX_HID_PM defined.");
+#endif
+}
+static struct spi_driver himax_hid_over_spi_driver = {
+	.driver = {
+		.name =		himax_dev_name,
+		.owner =	THIS_MODULE,
+		.pm	= HX_HID_PM,
+		.of_match_table = himax_match_table,
+		.acpi_match_table = hx_acpi_spi_table,
+	},
+	.probe =	himax_spi_drv_probe,
+	.remove =	himax_spi_drv_remove,
+};
+void himax_spi_drv_exit(void)
+{
+	if (g_himax_ts) {
+		spi_unregister_driver(&himax_hid_over_spi_driver);
+		kfree(g_himax_ts);
+		g_himax_ts = NULL;
+		I("Free g_himax_ts");
+	}
+}
+
+static int himax_spi_drv_init(struct himax_ts_data *ts)
+{
+	int ret;
+
+	I("Himax touch panel driver for HID init");
+	print_config();
+	ret = spi_register_driver(&himax_hid_over_spi_driver);
+
+	return ret;
+}
+
+static int __init himax_ic_init(void)
+{
+	int ret = 0;
+	// set default regs
+	himax_ic_reg_init(&g_core_regs);
+	himax_ic_fp_init();
+	// basic struct init
+	g_himax_ts = kzalloc(sizeof(*g_himax_ts), GFP_KERNEL);
+	if (!g_himax_ts) {
+		E("allocate himax_ts_data failed");
+		ret = -ENOMEM;
+		goto err_alloc_data_failed;
+	}
+	INIT_LIST_HEAD(&g_himax_ts->list);
+	// init ic specific params
+	himax_para_init(g_himax_ts);
+
+	// add to ic module list
+	ret = himax_spi_drv_init(g_himax_ts);
+	if (ret) {
+		E("himax_spi_drv_init failed");
+		kfree(g_himax_ts);
+		g_himax_ts = NULL;
+	}
+
+err_alloc_data_failed:
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
+MODULE_DESCRIPTION("Himax SPI driver for HID simulator for " HX83102J_ID);
+MODULE_AUTHOR("Himax, Inc.");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(HIMAX_DRIVER_VER);
diff --git a/drivers/hid/hid-himax-83102j.h b/drivers/hid/hid-himax-83102j.h
new file mode 100644
index 000000000000..52fd633fc7dc
--- /dev/null
+++ b/drivers/hid/hid-himax-83102j.h
@@ -0,0 +1,927 @@
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
+#include <linux/of_irq.h>
+#include <linux/proc_fs.h>
+#include <linux/version.h>
+#include <linux/firmware.h>
+#include <linux/stddef.h>
+#include <linux/power_supply.h>
+
+#define HIMAX_DRIVER_VER "1.0.0"
+
+#define HIMAX_BUS_RETRY_TIMES 3
+#define BUS_RW_MAX_LEN 0x20006
+#define BUS_R_HLEN 3
+#define BUS_R_DLEN ((BUS_RW_MAX_LEN - BUS_R_HLEN) - ((BUS_RW_MAX_LEN - BUS_R_HLEN) % 4))
+#define BUS_W_HLEN 2
+#define BUS_W_DLEN ((BUS_RW_MAX_LEN - BUS_W_HLEN) - ((BUS_RW_MAX_LEN - BUS_W_HLEN) % 4))
+#define FIX_HX_INT_IS_EDGE	(false)
+
+#define HX_DELAY_BOOT_UPDATE			(2000)
+#define HID_REG_SZ_MAX					(1 + 4 + 1 + 4 + 256)
+
+enum HID_ID_FUNCT {
+	ID_CONTACT_COUNT = 0x03,
+};
+
+#define HID_RAW_DATA_TYPE_DELTA     (0x09)
+#define HID_RAW_DATA_TYPE_RAW       (0x0A)
+#define HID_RAW_DATA_TYPE_BASELINE  (0x0B)
+#define HID_RAW_DATA_TYPE_NORMAL	(0x00)
+
+enum HID_FW_UPDATE_STATUS_CODE {
+	FWUP_ERROR_NO_ERROR = 0x77,
+	FWUP_ERROR_MCU_00 = 0x00,
+	FWUP_ERROR_MCU_A0 = 0xA0,
+	FWUP_ERROR_NO_BL = 0xC1,
+	FWUP_ERROR_NO_MAIN = 0xC2,
+	FWUP_ERROR_BL_COMPLETE = 0xB1,
+	FWUP_ERROR_BL = 0xB2,
+	FWUP_ERROR_PW = 0xB3,
+	FWUP_ERROR_ERASE_FLASH = 0xB4,
+	FWUP_ERROR_FLASH_PROGRAMMING = 0xB5,
+	FWUP_ERROR_NO_DEVICE = 0xFFFFFF00,
+	FWUP_ERROR_LOAD_FW_BIN = 0xFFFFFF01,
+	FWUP_ERROR_INITIAL = 0xFFFFFF02,
+	FWUP_ERROR_POLLING_TIMEOUT = 0xFFFFFF03,
+	FWUP_ERROR_FW_TRANSFER = 0xFFFFFF04
+};
+
+struct himax_ts_data;
+union host_ext_rd_t;
+union heatmap_rd_t;
+
+#define HID_FW_UPDATE_BL_CMD    (0x77)
+#define HID_FW_UPDATE_MAIN_CMD  (0x55)
+
+int hx_hid_probe(struct himax_ts_data *ts);
+void hx_hid_remove(struct himax_ts_data *ts);
+
+void hx_hid_update_info(struct himax_ts_data *ts);
+int hx_hid_report(const struct himax_ts_data *ts, u8 *data, s32 len);
+
+enum fix_touch_info {
+	FIX_HX_RX_NUM = 48,
+	FIX_HX_TX_NUM = 32,
+	FIX_HX_BT_NUM = 0,
+	FIX_HX_MAX_PT = 10,
+	FIX_HX_STYLUS_FUNC = 1,
+	FIX_HX_STYLUS_ID_V2 = 0,
+	FIX_HX_STYLUS_RATIO = 1,
+	HX_STACK_ORG_LEN = 128
+};
+
+#define himax_dev_name "hx_spi_hid_tp"
+
+#if defined(CONFIG_FB)
+#include <linux/notifier.h>
+#include <linux/fb.h>
+#endif
+
+/* log macro */
+#define I(fmt, arg...) pr_info("[HXTP][%s]: " fmt "\n", __func__, ##arg)
+#define W(fmt, arg...) pr_warn("[HXTP][WARNING][%s]: " fmt "\n", __func__, ##arg)
+#define E(fmt, arg...) pr_err("[HXTP][ERROR][%s]: " fmt "\n", __func__, ##arg)
+#define D(fmt, arg...) pr_debug("[HXTP][DEBUG][%s]: " fmt "\n", __func__, ##arg)
+
+#define himax_dev_name "hx_spi_hid_tp"
+
+#define BOOT_UPGRADE_FWNAME "himax_i2chid"
+
+#define MPAP_FWNAME "himax_mpfw.bin"
+
+#define UNUSED(x) ((void)(x))
+static const char default_fw_name[] = BOOT_UPGRADE_FWNAME;
+
+#define DATA_LEN_4				4
+#define ADDR_LEN_4				4
+#define MAX_I2C_TRANS_SZ		128
+#define HIMAX_REG_RETRY_TIMES	5
+#define FW_PAGE_SZ			128
+#define HX1K					0x400
+#define HX_48K_SZ				0xC000
+#define HX64K					0x10000
+
+#define HX_RW_REG_FAIL			(-1)
+
+#define hx83102j_fw_addr_raw_out_sel 0x100072EC
+#define hx83102j_ic_adr_tcon_rst     0x80020004
+#define hx83102j_data_adc_num        400 /* 200x2 */
+#define hx83102j_notouch_frame       0
+#define HX83102J_FLASH_SIZE        261120
+#define HX83102j_ic_addr_hw_crc 0x80010000
+#define HX83102j_data_hw_crc 0x0000ECCE
+
+/* CORE_IC */
+	#define ic_adr_ahb_addr_byte_0           0x00
+	#define ic_adr_ahb_rdata_byte_0          0x08
+	#define ic_adr_ahb_access_direction      0x0c
+	#define ic_adr_conti                     0x13
+	#define ic_adr_incr4                     0x0D
+	#define ic_adr_i2c_psw_lb                0x31
+	#define ic_adr_i2c_psw_ub                0x32
+	#define ic_cmd_ahb_access_direction_read 0x00
+	#define ic_cmd_conti                     0x31
+	#define ic_cmd_incr4                     0x10
+	#define ic_cmd_i2c_psw_lb                0x27
+	#define ic_cmd_i2c_psw_ub                0x95
+	#define ic_adr_tcon_on_rst               0x80020020
+	#define ic_adr_cs_central_state          0x900000A8
+/* CORE_IC */
+/* CORE_FW */
+	#define fw_addr_system_reset                0x90000018
+	#define fw_addr_ctrl_fw                     0x9000005c
+	#define fw_addr_flag_reset_event            0x900000e4
+	#define fw_usb_detect_addr                  0x10007F38
+	#define fw_addr_raw_out_sel                 0x800204b4
+	#define fw_addr_reload_status               0x80050000
+	#define fw_addr_reload_crc32_result         0x80050018
+	#define fw_addr_reload_addr_from            0x80050020
+	#define fw_addr_reload_addr_cmd_beat        0x80050028
+	#define fw_data_system_reset                0x00000055
+    #define fw_data_safe_mode_release_pw_reset  0x00000000
+	#define fw_data_clear                       0x00000000
+	#define fw_data_fw_stop                     0x000000A5
+	#define fw_addr_set_frame_addr              0x10007294
+	#define fw_addr_sorting_mode_en             0x10007f04
+	#define fw_addr_fw_ver_addr                 0x10007004
+	#define fw_addr_fw_cfg_addr                 0x10007084
+	#define fw_addr_fw_vendor_addr              0x10007000
+	#define fw_addr_cus_info                    0x10007008
+	#define fw_addr_proj_info                   0x10007014
+	#define fw_addr_fw_dbg_msg_addr             0x10007f40
+	#define fw_addr_chk_fw_status               0x900000a8
+	#define fw_addr_chk_dd_status               0x900000E8
+	#define fw_addr_ap_notify_fw_sus            0x10007FD0
+	#define fw_data_ap_notify_fw_sus_en         0xA55AA55A
+	#define fw_data_ap_notify_fw_sus_dis        0x00000000
+	#define fw_addr_event_addr                  0x30
+	#define fw_func_handshaking_pwd             0xA55AA55A
+	#define fw_func_handshaking_end             0x77887788
+	#define fw_addr_ulpm_33                     0x33
+	#define fw_addr_ulpm_34                     0x34
+	#define fw_data_ulpm_11                     0x11
+	#define fw_data_ulpm_22                     0x22
+	#define fw_data_ulpm_33                     0x33
+	#define fw_data_ulpm_aa                     0xAA
+	#define fw_addr_ctrl_mpap_ovl               0x100073EC
+	#define fw_data_ctrl_mpap_ovl_on            0x107380
+/* CORE_FW */
+/* CORE_FLASH */
+	#define flash_addr_ctrl_base           0x80000000
+	#define flash_addr_spi200_data         (flash_addr_ctrl_base + 0x2c)
+/* CORE_FLASH */
+/* CORE_SRAM */
+	#define sram_adr_mkey         0x100070E8
+	#define sram_adr_rawdata_addr 0x10000000
+	#define	sram_passwrd_start    0x5AA5
+	#define	sram_passwrd_end      0xA55A
+/* CORE_SRAM */
+/* CORE_DRIVER */
+	#define driver_addr_fw_define_flash_reload              0x10007f00
+	#define driver_addr_fw_define_2nd_flash_reload          0x100072c0
+	#define driver_addr_fw_define_int_is_edge               0x10007088
+	#define driver_addr_fw_define_rxnum_txnum               0x100070f4
+	#define driver_addr_fw_define_maxpt_xyrvs               0x100070f8
+	#define driver_addr_fw_define_x_y_res                   0x100070fc
+/* CORE_DRIVER */
+	#define zf_data_dis_flash_reload 0x00009AA9
+	#define zf_addr_system_reset     0x90000018
+	#define zf_data_system_reset     0x00000055
+	#define zf_data_sram_start_addr  0x08000000
+	#define zf_data_cfg_info         0x10007000
+	#define zf_data_fw_cfg_1         0x10007084
+	#define zf_data_fw_cfg_2         0x10007264
+	#define zf_data_fw_cfg_3         0x10007300
+	#define zf_data_adc_cfg_1        0x10006A00
+	#define zf_data_adc_cfg_2        0x10007B28
+	#define zf_data_adc_cfg_3        0x10007AF0
+	#define zf_data_map_table        0x10007500
+	#define ovl_section_num      3
+	#define ovl_border_reply     0x66
+	#define ovl_sorting_reply    0xAA
+	#define ovl_fault            0xFF
+	#define ovl_alg_request  0x11111111
+	#define ovl_alg_reply    0x22222222
+
+	#define time_var timespec64
+	#define time_var_fine tv_nsec
+	#define time_var_fine_unit (1000 * 1000)
+	#define time_func ktime_get_real_ts64
+	#define owner_line
+
+	#define HX_TP_BIN_CHECKSUM_CRC		3
+
+	#define FW_SIZE_255k    261120
+
+	#define HX83102J_ID		"HX83102J"
+
+	/* origin is 20/50 */
+	#define RST_LOW_PERIOD_S 5000
+	#define RST_LOW_PERIOD_E 5100
+	#define RST_HIGH_PERIOD_ZF_S 5000
+	#define RST_HIGH_PERIOD_ZF_E 5100
+	#define RST_HIGH_PERIOD_S 50000
+	#define RST_HIGH_PERIOD_E 50100
+enum data_type {
+	HX_REG = 0xA5,
+	HX_DATA
+};
+
+struct hx_reg_t {
+	union {
+		u32 word;
+		u16 half[2];
+		u8 byte[4];
+	} data;
+	u32 len;
+	u32 data_type;
+};
+
+struct data_pack_t {
+	union {
+		u32 *word;
+		u16 *half;
+		u8 *byte;
+		void *ptr;
+	} data;
+	/* length in byte unit */
+	u32 len;
+	u32 data_type;
+};
+
+#define BYTE_REG(_reg, _data) \
+	{ \
+		_reg.data.byte[0] = (_data) & 0xFF; \
+		_reg.len = 1; \
+		_reg.data_type = HX_REG; \
+	}
+#define HALF_REG(_reg, _data) \
+	{ \
+		_reg.data.half[0] = cpu_to_le16((_data) & 0xFFFF); \
+		_reg.len = 2; \
+		_reg.data_type = HX_REG; \
+	}
+#define WORD_REG(_reg, _data) \
+	{ \
+		_reg.data.word = cpu_to_le32(_data); \
+		_reg.len = 4; \
+		_reg.data_type = HX_REG; \
+	}
+
+// set val to already defined reg/data
+#define VAL_SET(_var, _val) \
+	({ \
+		bool _ret = true; \
+		do { \
+			if (_var.data_type == HX_DATA) { \
+				memset(_var.data.byte, 0, _var.len); \
+				do { \
+					switch (_var.len) { \
+					case 1: \
+						_var.data.byte[0] = (_val) & 0xFF; \
+						break; \
+					case 2: \
+						_var.data.half[0] = cpu_to_le16((_val) & 0xFFFF); \
+						break; \
+					case 3: \
+						_var.data.half[0] = cpu_to_le16((_val) & 0xFFFF); \
+						_var.data.byte[2] = ((_val) >> 16) & 0xFF; \
+						break; \
+					case 4: \
+						_var.data.word[0] =\
+						cpu_to_le32((_val) & 0xFFFFFFFF); \
+						break; \
+					default: \
+						_ret = false; \
+						break; \
+					};\
+				} while (0); \
+			} else { \
+				_ret = false; \
+			} \
+		} while (0); \
+		_ret; \
+	})
+
+// set ptr/array to already defined reg/data
+#define PTR_SET(_var, _ptr, _len) \
+	({ \
+		bool _ret = true; \
+		do { \
+			if ((_len) > (_var).len) { \
+				_ret = false; \
+				break; \
+			} \
+			memcpy((_var).data.byte, _ptr, (_len)); \
+			(_var).len = (_len); \
+		} while (0); \
+		_ret; \
+	})
+
+#define DEF_WORD_DATA(_data_name) \
+	u8 _data_name##_array[4] = {0}; \
+	struct data_pack_t _data_name = { \
+		.data.byte = _data_name##_array, \
+		.len = 4, \
+		.data_type = HX_DATA \
+	}
+
+#define ARRAY_DATA(_data, _byte_len) { \
+		_data.data.byte = (uint8_t *)_data, \
+		_data.len = _byte_len, \
+		.data_type = HX_DATA \
+	}
+
+#define REG_GET_VAL(_reg) \
+	({ \
+		u32 _val = 0; \
+		do { \
+			switch (_reg.len) { \
+			case 1: \
+				_val = _reg.data.byte[0]; \
+				break; \
+			case 2: \
+				_val = le16_to_cpu(_reg.data.half[0]); \
+				break; \
+			case 3: \
+				_val = le16_to_cpu(_reg.data.half[0]) | (_reg.data.byte[2] << 16); \
+				break; \
+			case 4: \
+				_val = le32_to_cpu(_reg.data.word); \
+				break; \
+			} \
+		} while (0); \
+		_val; \
+	})
+
+struct ic_operation {
+	struct hx_reg_t addr_ahb_addr_byte_0;
+	struct hx_reg_t addr_ahb_rdata_byte_0;
+	struct hx_reg_t addr_ahb_access_direction;
+	struct hx_reg_t addr_conti;
+	struct hx_reg_t addr_incr4;
+	struct hx_reg_t adr_i2c_psw_lb;
+	struct hx_reg_t adr_i2c_psw_ub;
+	struct hx_reg_t data_ahb_access_direction_read;
+	struct hx_reg_t data_conti;
+	struct hx_reg_t data_incr4;
+	struct hx_reg_t data_i2c_psw_lb;
+	struct hx_reg_t data_i2c_psw_ub;
+	struct hx_reg_t addr_tcon_on_rst;
+	struct hx_reg_t addr_cs_central_state;
+};
+
+struct fw_operation {
+	struct hx_reg_t addr_system_reset;
+	struct hx_reg_t addr_ctrl_fw_isr;
+	struct hx_reg_t addr_flag_reset_event;
+	struct hx_reg_t addr_raw_out_sel;
+	struct hx_reg_t addr_reload_status;
+	struct hx_reg_t addr_reload_crc32_result;
+	struct hx_reg_t addr_reload_addr_from;
+	struct hx_reg_t addr_reload_addr_cmd_beat;
+	struct hx_reg_t addr_set_frame_addr;
+	struct hx_reg_t addr_sorting_mode_en;
+	struct hx_reg_t addr_fw_ver_addr;
+	struct hx_reg_t addr_fw_cfg_addr;
+	struct hx_reg_t addr_fw_vendor_addr;
+	struct hx_reg_t addr_cus_info;
+	struct hx_reg_t addr_proj_info;
+	struct hx_reg_t addr_ap_notify_fw_sus;
+	struct hx_reg_t data_ap_notify_fw_sus_en;
+	struct hx_reg_t data_ap_notify_fw_sus_dis;
+	struct hx_reg_t data_system_reset;
+	struct hx_reg_t data_clear;
+	struct hx_reg_t data_fw_stop;
+	struct hx_reg_t addr_event_addr;
+	struct hx_reg_t addr_usb_detect;
+};
+
+struct sram_operation {
+	struct hx_reg_t addr_mkey;
+	struct hx_reg_t addr_rawdata_addr;
+	struct hx_reg_t passwrd_start;
+	struct hx_reg_t passwrd_end;
+};
+
+struct driver_operation {
+	struct hx_reg_t addr_fw_define_flash_reload;
+	struct hx_reg_t addr_fw_define_2nd_flash_reload;
+	struct hx_reg_t addr_fw_define_int_is_edge;
+	struct hx_reg_t addr_fw_define_rxnum_txnum;
+	struct hx_reg_t addr_fw_define_maxpt_xyrvs;
+	struct hx_reg_t addr_fw_define_x_y_res;
+
+};
+
+struct zf_operation {
+	struct hx_reg_t data_dis_flash_reload;
+	struct hx_reg_t addr_system_reset;
+	struct hx_reg_t data_system_reset;
+	struct hx_reg_t data_sram_start_addr;
+	struct hx_reg_t data_sram_clean;
+	struct hx_reg_t data_cfg_info;
+	struct hx_reg_t data_fw_cfg_1;
+	struct hx_reg_t data_fw_cfg_2;
+	struct hx_reg_t data_fw_cfg_3;
+	struct hx_reg_t data_adc_cfg_1;
+	struct hx_reg_t data_adc_cfg_2;
+	struct hx_reg_t data_adc_cfg_3;
+	struct hx_reg_t data_map_table;
+};
+
+struct flash_version_info {
+	struct hx_reg_t addr_fw_ver_major;
+	struct hx_reg_t addr_fw_ver_minor;
+	struct hx_reg_t addr_cfg_ver_major;
+	struct hx_reg_t addr_cfg_ver_minor;
+	struct hx_reg_t addr_cid_ver_major;
+	struct hx_reg_t addr_cid_ver_minor;
+	struct hx_reg_t addr_cfg_table;
+	struct hx_reg_t addr_cfg_table_t;
+	struct hx_reg_t addr_hid_table;
+	struct hx_reg_t addr_hid_desc;
+	struct hx_reg_t addr_hid_rd_desc;
+};
+
+struct himax_core_command_regs {
+	struct flash_version_info flash_ver_info;
+	struct ic_operation ic_op;
+	struct fw_operation fw_op;
+	struct sram_operation sram_op;
+	struct driver_operation driver_op;
+	struct zf_operation zf_op;
+};
+struct hx_hid_rd_data_t {
+	u8 *rd_data;
+	u32 rd_length;
+};
+union hx_dword_data_t {
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
+
+struct rd_feature_unit_t {
+	u8 id_tag;
+	u8 id;
+	u8 usage_tag;
+	u8 usage;
+	u8 report_cnt_tag;
+	u16 report_cnt;
+	u8 feature_tag[2];
+} __packed;
+struct hx_hid_req_cfg_t {
+	u32 processing_id;
+	u32 data_type;
+	u32 self_test_type;
+	u32 handshake_set;
+	u32 handshake_get;
+	struct firmware *fw;
+	u32 current_size;
+	// HID REG READ/WRITE format:
+	// STANDARD TYPE
+	// [ID:1][READ/WRITE:1][REG_ADDR:4][REG_DATA:4] : 10 bytes
+	//  0     1             2~5         6~9
+	// EXT TYPE
+	// [ID:1][READ/WRITE:1][0xFFFFFFFF][REG_TYPE:1][REG_ADDR:1|4][REG_DATA:1~256]
+	//  0	  1             2~5         6           7|7~10        8~263|11~266
+	union hx_dword_data_t reg_addr;
+	u32 reg_addr_sz;
+	u8 reg_data[HID_REG_SZ_MAX - 1 - 4];
+	u32 reg_data_sz;
+	u32 input_RD_de;
+};
+
+enum cell_type {
+	CHIP_IS_ON_CELL,
+	CHIP_IS_IN_CELL
+};
+
+#define HX_FULL_STACK_RAWDATA_SIZE \
+	(HX_STACK_ORG_LEN +\
+	(2 + FIX_HX_RX_NUM * FIX_HX_TX_NUM + FIX_HX_TX_NUM + FIX_HX_RX_NUM)\
+	* 2)
+
+struct himax_ic_data {
+	int vendor_fw_ver;
+	int vendor_config_ver;
+	int vendor_touch_cfg_ver;
+	int vendor_display_cfg_ver;
+	int vendor_cid_maj_ver;
+	int vendor_cid_min_ver;
+	int vendor_panel_ver;
+	int vendor_sensor_id;
+	int ic_adc_num;
+	u8 vendor_cus_info[12];
+	u8 vendor_proj_info[12];
+	u32 flash_size;
+	u32 HX_RX_NUM;
+	u32 HX_TX_NUM;
+	u32 HX_BT_NUM;
+	u32 HX_X_RES;
+	u32 HX_Y_RES;
+	u32 HX_MAX_PT;
+	u8 HX_INT_IS_EDGE;
+	u8 HX_STYLUS_FUNC;
+	u8 HX_STYLUS_ID_V2;
+	u8 HX_STYLUS_RATIO;
+	u32 icid;
+	bool enc16bits;
+	bool has_flash;
+};
+
+enum HX_TS_PATH {
+	HX_REPORT_COORD = 1,
+	HX_REPORT_COORD_RAWDATA,
+};
+
+enum HX_TS_STATUS {
+	HX_TS_GET_DATA_FAIL = -4,
+	HX_EXCP_EVENT,
+	HX_CHKSUM_FAIL,
+	HX_PATH_FAIL,
+	HX_TS_NORMAL_END = 0,
+	HX_EXCP_REC_OK,
+	HX_READY_SERVE,
+	HX_REPORT_DATA,
+	HX_EXCP_WARNING,
+	HX_IC_RUNNING,
+	HX_ZERO_EVENT_COUNT,
+	HX_RST_OK,
+};
+
+enum HX_ERROR_CODE {
+	NO_ERR = 0,
+	READY_TO_SERVE = 1,
+	WORK_OUT = 2,
+	HX_EMBEDDED_FW = 3,
+	BUS_FAIL = -1,
+	HX_INIT_FAIL = -1,
+	MEM_ALLOC_FAIL = -2,
+	CHECKSUM_FAIL = -3,
+	GESTURE_DETECT_FAIL = -4,
+	INPUT_REGISTER_FAIL = -5,
+	FW_NOT_READY = -6,
+	LENGTH_FAIL = -7,
+	OPEN_FILE_FAIL = -8,
+	PROBE_FAIL = -9,
+	ERR_WORK_OUT = -10,
+	ERR_STS_WRONG = -11,
+	ERR_TEST_FAIL = -12,
+	HW_CRC_FAIL = 1
+};
+
+struct himax_platform_data {
+	struct himax_ts_data *ts;
+	u16 pid;
+	bool power_off_3v3;
+	u8 cable_config[2];
+	int gpio_irq;
+	int of_irq;
+	int gpio_reset;
+	int ic_det_delay;
+	int ic_resume_delay;
+	int panel_id;
+	bool is_zf;
+	struct regulator *vccd_supply;
+	struct regulator *vcca_supply;
+};
+
+struct hx_hid_fw_unit_t {
+	u8 cmd;
+	u16 bin_start_offset;
+	u16 unit_sz;
+} __packed;
+
+struct hx_bin_desc_t {
+	u16 passwd;
+	u16 cid;
+	u8 panel_ver;
+	u16 fw_ver;
+	u8 ic_sign;
+	char customer[12];
+	char project[12];
+	char fw_major[12];
+	char fw_minor[12];
+	char date[12];
+	char ic_sign_2[12];
+} __packed;
+
+struct hx_hid_desc_t {
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
+struct hx_hid_info_t {
+	struct hx_hid_fw_unit_t main_mapping[9];
+	struct hx_hid_fw_unit_t bl_mapping;
+	struct hx_bin_desc_t fw_bin_desc;
+	u16 vid;
+	u16 pid;
+	u8 cfg_info[32];
+	u8 cfg_version;
+	u8 disp_version;
+	u8 rx;
+	u8 tx;
+	u16 yres;
+	u16 xres;
+	u8 pt_num;
+	u8 mkey_num;
+	u8 debug_info[78];
+} __packed;
+
+struct himax_ts_data {
+	bool initialized;
+	bool probe_finish;
+	bool suspended;
+	s32 notouch_frame;
+	s32 ic_notouch_frame;
+	atomic_t suspend_mode;
+	u8 x_channel;
+	u8 y_channel;
+	char chip_name[30];
+	u8 chip_cell_type;
+	u32 chip_max_dsram_size;
+	u32 ic_checksum_type;
+	bool ic_boot_done;
+	u32 probe_fail_flag;
+	u8 *xfer_data;
+	struct himax_ic_data *ic_data;
+
+	int touch_all_size;
+	int touch_info_size;
+
+	u8 *hx_rawdata_buf;
+	bool boot_upgrade_flag;
+	const struct firmware *hxfw;
+	bool has_alg_overlay;
+	u8 *ovl_idx;
+	bool zf_update_flag;
+	u8 *zf_update_cfg_buffer;
+#if defined(CONFIG_HID_HIMAX)
+	struct time_var deferred_start;
+	unsigned int ic_det_delay;
+#endif
+
+	u8 n_finger_support;
+	u8 irq_enabled;
+
+	u32 debug_log_level;
+
+	s32 rst_gpio;
+	s32 use_irq;
+	s32 (*power)(s32 on);
+
+	struct device *dev;
+	struct workqueue_struct *himax_wq;
+	struct work_struct work;
+
+	struct hrtimer timer;
+	struct i2c_client *client;
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
+
+/******* SPI-start *******/
+	struct spi_device	*spi;
+	s32 hx_irq;
+	u8 *xfer_buff;
+/******* SPI-end *******/
+
+	struct hid_device *hid;
+	struct hx_hid_desc_t hid_desc;
+	struct hx_hid_rd_data_t hid_rd_data;
+	struct hx_hid_info_t hid_info;
+	struct hx_hid_req_cfg_t hid_req_cfg;
+	struct hx_bin_desc_t fw_bin_desc;
+	bool hid_probe;
+	bool resume_success;
+
+	s32 in_self_test;
+	s32 suspend_resume_done;
+	s32 bus_speed;
+
+	s32 excp_reset_active;
+	s32 excp_eb_event_flag;
+	s32 excp_ec_event_flag;
+	s32 excp_ed_event_flag;
+	s32 excp_zero_event_count;
+
+#if defined(CONFIG_FB)
+	struct notifier_block fb_notif;
+	struct workqueue_struct *himax_att_wq;
+	struct delayed_work work_att;
+#endif
+
+	struct notifier_block power_notif;
+	struct workqueue_struct *himax_pwr_wq;
+	struct delayed_work work_pwr;
+
+	struct workqueue_struct *himax_boot_upgrade_wq;
+	struct delayed_work work_boot_upgrade;
+
+	struct workqueue_struct *himax_hid_debug_wq;
+	struct delayed_work work_hid_update;
+	u8 usb_connected;
+	u8 *cable_config;
+	u8 latest_power_status;
+
+	struct workqueue_struct *himax_resume_delayed_work_wq;
+	struct delayed_work work_resume_delayed_work;
+
+	u8 slave_write_reg;
+	u8 slave_read_reg;
+	bool acc_slave_reg;
+	bool select_slave_reg;
+	struct list_head list;
+};
+struct himax_core_fp {
+/* CORE_IC */
+	void (*fp_burst_enable)(struct himax_ts_data *ts, u8 auto_add_4_byte);
+	int (*fp_register_read)(struct himax_ts_data *ts, u8 *addr,
+			u8 *buf, u32 len);
+	int (*fp_reg_read)(struct himax_ts_data *ts, struct hx_reg_t *addr,
+			struct data_pack_t *data);
+	int (*fp_register_write)(struct himax_ts_data *ts, u8 *addr,
+			u8 *val, u32 len);
+	int (*fp_reg_write)(struct himax_ts_data *ts, struct hx_reg_t *addr,
+			struct data_pack_t *data);
+	void (*fp_interface_on)(struct himax_ts_data *ts);
+	void (*fp_sense_on)(struct himax_ts_data *ts, u8 flash_mode);
+	bool (*fp_sense_off)(struct himax_ts_data *ts, bool check_en);
+	void (*fp_power_on_init)(struct himax_ts_data *ts);
+/* CORE_IC */
+
+/* CORE_FW */
+	void (*fp_system_reset)(struct himax_ts_data *ts);
+	void (*fp_usb_detect_set)(struct himax_ts_data *ts,
+			const u8 *cable_config);
+	void (*fp_diag_register_set)(struct himax_ts_data *ts,
+			u8 diag_command);
+	void (*fp_reload_disable)(struct himax_ts_data *ts, int disable);
+	void (*fp_read_FW_ver)(struct himax_ts_data *ts);
+	void (*fp_read_FW_status)(struct himax_ts_data *ts);
+	void (*fp_irq_switch)(struct himax_ts_data *ts, int switch_on);
+	int (*fp_assign_sorting_mode)(struct himax_ts_data *ts, u8 *tmp_data);
+	void (*fp_ap_notify_fw_sus)(struct himax_ts_data *ts, int suspend);
+/* CORE_FW */
+/* CORE_FLASH */
+	int (*fp_diff_overlay_flash)(struct himax_ts_data *ts);
+/* CORE_FLASH */
+/* CORE_DRIVER */
+	bool (*fp_chip_detect)(struct himax_ts_data *ts);
+	void (*fp_chip_init)(struct himax_ts_data *ts);
+	void (*fp_pin_reset)(struct himax_ts_data *ts);
+	void (*fp_ic_reset)(struct himax_ts_data *ts,
+		    u8 loadconfig, u8 int_off);
+	u8 (*fp_tp_info_check)(struct himax_ts_data *ts);
+	void (*fp_touch_information)(struct himax_ts_data *ts);
+	void (*fp_calc_touch_data_size)(struct himax_ts_data *ts);
+	int (*fp_ic_excp_recovery)(struct himax_ts_data *ts,
+		u32 hx_excp_event,
+		u32 hx_zero_event, u32 length);
+	void (*fp_excp_ic_reset)(struct himax_ts_data *ts);
+	void (*fp_resend_cmd_func)(struct himax_ts_data *ts, bool suspended);
+	bool (*fp_read_event_stack)(struct himax_ts_data *ts, u8 *buf,
+				    u32 length);
+	void (*fp_suspend_proc)(struct himax_ts_data *ts, bool suspended);
+	void (*fp_resume_proc)(struct himax_ts_data *ts, bool suspended);
+/* CORE_DRIVER */
+/* INSPECTION*/
+/* INSPECTION*/
+};
+
+#define FLASH_VER_GET_VAL(_reg) REG_GET_VAL(g_core_regs.flash_ver_info._reg)
+#define IC_GET_VAL(_reg) REG_GET_VAL(g_core_regs.ic_op._reg)
+#define FW_GET_VAL(_reg) REG_GET_VAL(g_core_regs.fw_op._reg)
+#define FLASH_GET_VAL(_reg) REG_GET_VAL(g_core_regs.flash_op._reg)
+#define SRAM_GET_VAL(_reg) REG_GET_VAL(g_core_regs.sram_op._reg)
+#define DRV_GET_VAL(_reg) REG_GET_VAL(g_core_regs.driver_op._reg)
+#define ZF_GET_VAL(_reg) REG_GET_VAL(g_core_regs.zf_op._reg)
+#define REG_GET_ARRAY(_reg) \
+	({ \
+		_reg.data.byte; \
+	})
+#define FLASH_VER_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.flash_ver_info._reg)
+#define IC_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.ic_op._reg)
+#define FW_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.fw_op._reg)
+#define FLASH_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.flash_op._reg)
+#define SRAM_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.sram_op._reg)
+#define DRV_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.driver_op._reg)
+#define ZF_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.zf_op._reg)
+#define REG_GET_SZ(_reg) \
+	({ \
+		_reg.len; \
+	})
+#define FLASH_VER_GET_SZ(_reg) REG_GET_SZ(g_core_regs.flash_ver_info._reg)
+#define IC_GET_SZ(_reg) REG_GET_SZ(g_core_regs.ic_op._reg)
+#define FW_GET_SZ(_reg) REG_GET_SZ(g_core_regs.fw_op._reg)
+#define FLASH_GET_SZ(_reg) REG_GET_SZ(g_core_regs.flash_op._reg)
+#define SRAM_GET_SZ(_reg) REG_GET_SZ(g_core_regs.sram_op._reg)
+#define DRV_GET_SZ(_reg) REG_GET_SZ(g_core_regs.driver_op._reg)
+#define ZF_GET_SZ(_reg) REG_GET_SZ(g_core_regs.zf_op._reg)
+void himax_rst_gpio_set(int pinnum, u8 value);
+void himax_cable_detect_func(struct himax_ts_data *ts, bool force_renew);
+int himax_report_data_init(struct himax_ts_data *ts);
+
+int himax_bus_read(struct himax_ts_data *ts, u8 cmd, u8 *buf,
+		   u32 len);
+int himax_bus_write(struct himax_ts_data *ts, u8 cmd, u8 *addr,
+		    u8 *data, u32 len);
+
+void himax_int_enable(struct himax_ts_data *ts, int enable);
+
+union host_ext_rd_t {
+	struct __packed rd_struct_t {
+		u8 header[14];
+		struct rd_feature_unit_t cfg;// ID_CFG
+		struct rd_feature_unit_t reg_rw;// ID_REG_RW
+		struct rd_feature_unit_t monitor_sel;// ID_TOUCH_MONITOR_SEL
+		struct rd_feature_unit_t monitor;// ID_TOUCH_MONITOR
+		// rd_feature_unit_t monitor_partial;// ID_TOUCH_MONITOR_PARTIAL
+		struct rd_feature_unit_t fw_update;// ID_FW_UPDATE
+		struct rd_feature_unit_t fw_update_handshaking;// ID_FW_UPDATE_HANDSHAKING
+		struct rd_feature_unit_t self_test;// ID_SELF_TEST
+		struct rd_feature_unit_t input_rd_en;// ID_INPUT_RD_DE
+		u8 end_collection;
+	} rd_struct;
+	u8 host_report_descriptor[sizeof(struct rd_struct_t)];
+};
+
+union heatmap_rd_t {
+	struct __packed heatmap_struct_t {
+		u8 header[17];
+		u8 heatmap_info_desc[29];
+		u8 heatmap_data_hdr[9];
+		u8 heatmap_data_cnt_tag;
+		u16 heatmap_data_cnt;
+		u8 heatmap_input_desc[2];
+		u8 end_collection;
+	} heatmap_struct;
+	u8 host_report_descriptor[sizeof(struct heatmap_struct_t)];
+};
+
+/* FW Auto upgrade case, you need to setup the fix_touch_info of module
+ */
+
+#define HID_REPORT_HDR_SZ (2)
+#if defined(CONFIG_OF)
+int himax_parse_dt(struct device_node *dt, struct himax_platform_data *pdata);
+#endif
+void himax_ts_work(struct himax_ts_data *ts);
+enum hrtimer_restart himax_ts_timer_func(struct hrtimer *timer);
+int himax_resume(struct device *dev);
+int himax_suspend(struct device *dev);
+
+// int himax_spi_drv_init(struct himax_ts_data *ts);
+void himax_spi_drv_exit(void);
+int himax_chip_init(struct himax_ts_data *ts);
+int himax_report_data_init(struct himax_ts_data *ts);
+void himax_cable_detect_func(struct himax_ts_data *ts, bool force_renew);
+#endif
-- 
2.34.1


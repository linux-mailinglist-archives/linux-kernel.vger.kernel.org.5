Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C2976551C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjG0Ndg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjG0Nde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:33:34 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980B72D67;
        Thu, 27 Jul 2023 06:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NN39Y/jNxh9qm+QR1EfakfWvIVnt4lNwzFQU+UeVKzzFTLvh/s+0MyY7CiDYZZ8booZr/vDOT4GY3mVNSOe81lWc649U1Y4rS/Ig2O1MDYv51x62Qp+1NyoVeMx84lHPrLiT95JXJMuxMw92sWnH0bV/nni4mFM9g31i/WUiWhoMB39IBVhCV5AXEa2iwlIMnde8TejFVHfXuJMrPK5fQKXSjH3EeW9qM1OlIgkn7DUOsaiB4HbHMhQUgNQEutmL4Y64OW6wjAGz/E5tViFaXyqgjvI0YibSkv/kUOKcjWCUTUImbLeon6gt7Cv7aJU4JjQfUmOXu89Olve0Jj+xBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpRz66U+FgS9nr6pLUbOu1o4zpeDyndcdMwjq03AovM=;
 b=MrVt6Mjz+BxjcWJ+Cq/Mtw2Czsd7gCbR58FcaKWIS5zIGHVOrQhHRg7bPQQt3X0gPt5H6uh5m+jJG2+PHvKjplbBE04zHhyt+rmufZ3kQ//Hmw4mrsNJsdk0/XUjmPdaZBceZ511pCVDk+h9gUme0UE49FNsFlY//6CdSNW8CC0wpPvuvBUQpzLni9LHiuVRKdyy3g0nBVvEFd+FwavSz2XWnj5jCWSKjiuV0AKeAxm//PAtwG0SmLbTYevryH2CydeXvuwT7zO65SPIc1XPofP6j/sO4IzZDOkmbQgaX43lE/3GnxSvFh+6HuGY3PrDEgyh1Up6ZdRjP0qtpv01dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpRz66U+FgS9nr6pLUbOu1o4zpeDyndcdMwjq03AovM=;
 b=B5X+VApioJPmtvS3qoy+Xd/pEDESBR1MxR/W0itlesXX8M2iMJ93cb4b7XnPYZLxtUv6AFf4kdeERzHYl4pSSz79WPFitNiZjLJu+lGJZT20iq4myuT4jJkYdS2izgsKuw9USZxf7UuwwqTrMMAUcmgvMXbRxoCkb71xYONFVD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by DB9PR04MB8411.eurprd04.prod.outlook.com (2603:10a6:10:24c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 13:33:19 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7504:9897:4e5d:df25]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7504:9897:4e5d:df25%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 13:33:19 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] Bluetooth: btnxpuart: Add support for AW693 chipset
Date:   Thu, 27 Jul 2023 19:03:17 +0530
Message-Id: <20230727133317.297014-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|DB9PR04MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: dea81d75-9f8e-49ad-85b7-08db8ea60a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1iKz15h2pmkNNWxq53qZkAMuhFvK3mk5va/BkijcCJq69tje6MsgB37nRjmZGLrb3OmvlzeQMYQiBF03+eSU2pxop5gzOy3lGXPT6HXaRPdAO9tbYcUn0jVvCNTaBioETcDZtZeceFzAdoj3b47Yu9jmKJpd39tjtwar7NcNiJ7ZUaVE1JhEhEdLlpTEu+JEK/0nXLVNiyC63DLVigv6wBQ3oB28k60w/46vPQtLFbq1vKObK0l9PRfWy8PIQzW/l7tgDB4S9XbnOlzwkp4PHJXn1GtZ3mpjr4jTuFNyPYwQsH+rKGgyfNn05drWWQNPjx6FULBDWQXUsD2+c3IvqbXZs4rpMPqg4+5e9h4QU5tCLy6HeNGAlBpAV/q+HQ7/ZAxXkXkviJFd7u2LA7i0WcdVjrxvyxz4+f2r8/T2JAD4Qn6M5gXsRlqqzn64S4FlxBFjZZQMJAs/kJ9M/DDejRnckzOAOtU2yd3avLsrSvKRmhFWJ3PKsgPVY+KTQU0Kg9W+PkgVlBgxcd5Y1RIMO+zVc/jD1wvNww7pOdNpuX7AGvGfHzm51gbNMPnHtZ2RndYRyTnFtTdw70zzyfFaASvj+QO6xDrLoU1ZHzyAIhY/oIaFnREAbe9UT/PFQXUW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199021)(52116002)(6486002)(6512007)(478600001)(36756003)(83380400001)(86362001)(2906002)(66556008)(66476007)(2616005)(26005)(6506007)(1076003)(186003)(38100700002)(38350700002)(6636002)(316002)(8936002)(4326008)(66946007)(8676002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?virPWU/kGGiD219kTM+dWlUxxEX0srXr9k6jjXPzla+IubpL8LCkIKpJPbmy?=
 =?us-ascii?Q?Nu1zhA7yf6Gcrp6uP1X7f3ldxIdAuuxXpal37izJn0b4hknQOU6bu7+PCy0o?=
 =?us-ascii?Q?U2DwaGvYvQ5o7AEkaTtPKrF6AbVS5ZWfs1fY8MuWay24ay8xfLz09tLhcuuh?=
 =?us-ascii?Q?eedtlsZCskS5paMacxxrPSsioL7/pSBLB0nT2k7GWhz26b1ZLaaLqt5ZKX9P?=
 =?us-ascii?Q?QKlG7PgRXpUstM6pj3MkpcppCP0IIIR17pgH6Qng4Xbz5d8ZlbennMtd9Xx4?=
 =?us-ascii?Q?UWjfFKpjGL0RLTSovQJ7/D31KzZooLiUcaD3SWb3/r1imiEzWETLOnTZIzUG?=
 =?us-ascii?Q?qy31Di+5g/iK4LO54LWqwBX8naJocCWd07ClRLwQkZq4hHZ8bXKOD1nA03Kx?=
 =?us-ascii?Q?SyIGQ9wTt1AXXVY7Uxik7rnXwVaH9D8eOcWP6YUDt9SOxPyvySwdAGbon4Ov?=
 =?us-ascii?Q?bkj4LH7m0vqpYfVdEkj1rit1sBCtR5G7DwOg+8Vdj0sLg8Z8kJ6h6/iQPIlg?=
 =?us-ascii?Q?0AS5QOWzuHvrTKhQLfX4Z9MXIHL69WCyA9yrRHAqFs2CzNHHGwBtoJHZy2yR?=
 =?us-ascii?Q?podzrAULTohapST0y5CU1Zd4JiG1iMIRjNJ/cdeLgHFxNEhcsWgc6TNcExcR?=
 =?us-ascii?Q?fXcrzHm9Bcw8Ehz7AvtS/xLTwJfnAR7wEF8hyQl0GVtL0n54LS2DSeXWe+B9?=
 =?us-ascii?Q?6x8u6UIh7WykVhLGwNn/HPcDVHN2MJu7f9riNchuAmy6XVndScWgKis5WmO1?=
 =?us-ascii?Q?5hIbN/FTpXpfpOq0PzFfn//oQxVuV93CFwYlegCrZ4E9GCTQhf4HL+Ibh49h?=
 =?us-ascii?Q?TLRFM9bzbiTpm0quHnJmbofbv3b38e74gIzrAz5oaJbAeXaFB8qiIyp+iy+J?=
 =?us-ascii?Q?Auc5xEo24t1UhXC2Knf7VlYobPfJrE2nZsZmnOofY6yXgWigK5MLS5Pddg8j?=
 =?us-ascii?Q?aDs9aGj9X2/TJFmc3nUBzhow2VdXQHlRl7gUXgus00lm8Bb7HZeLfb/pRfI+?=
 =?us-ascii?Q?uPbfvA3Rwnf8OT4b6E7wCdLARKbWTPCUWinUVmlTtomNERU27ojVP8nMD9bl?=
 =?us-ascii?Q?RAyc7v5Hb4fhvDnGmQKK9AQxBGTE2wC2P0Bh7RKzfvJanSMQnohk8j55XDLs?=
 =?us-ascii?Q?40S8bGy9Lu3RPT1VFB2sRKwKkuasN42n4QAuHwVSNgH5orlmFo1XVLQSlKJb?=
 =?us-ascii?Q?6nQ34jsG86hYLDfuNSEeOc2ZEkS683dyX+57cT6hqGTjMs9/TgtBtbtJaGqB?=
 =?us-ascii?Q?wdHXECWinAYebCPdtPbK7L3D9GLUFqYgb4A8KvOxkvZJGGEAyaKuSP/GAK9h?=
 =?us-ascii?Q?kfFE7rHLP8zaTvyUOVwW8X7pZ/qr5kYM2yl7zaCKrpx/PacoMmKt/xw+7icS?=
 =?us-ascii?Q?1LqEPVm69NsSFjFKy2B5aXPbcv1yG+0umMoBccy8T6HtwEBBSrE9WIYsFhVN?=
 =?us-ascii?Q?rvs3NwYGcWSzxSb6BauauZPT2JGVfAbI564frW+BIRmZXSP8oJeO6nXvwcpa?=
 =?us-ascii?Q?R8koMRCjt4eMR5ieEK9fJ9Q5MyIGsO+o1t45hZsY1bu07NmTE3z7zl0SgKCl?=
 =?us-ascii?Q?arsTydINprJvv5zjVKY/xzQxK1aDm9CQcuybXYuFd2chNjMT/a8hQLl2oxC4?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea81d75-9f8e-49ad-85b7-08db8ea60a36
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 13:33:19.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywRvDzGKZAx0qUFHmdRgWOxLbvPNF1KuKEIvEMwXTrfE/1p37m/6m1Mmzq2ChJBFfk0vTCMlpdfjz2GU17TPipylgbdJrpbOtE3aI9qy8Zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8411
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for NXP AW693 chipset in btnxpuart driver
by adding FW name and bootloader signature. Based on the
loader version bits 7:6 of the bootloader signature, the
driver can choose between selecting secure and non-secure
FW files.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 39 ++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 52ef44688d38..ee6f6c872a34 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -29,16 +29,25 @@
 #define BTNXPUART_CHECK_BOOT_SIGNATURE	3
 #define BTNXPUART_SERDEV_OPEN		4
 
-#define FIRMWARE_W8987	"nxp/uartuart8987_bt.bin"
-#define FIRMWARE_W8997	"nxp/uartuart8997_bt_v4.bin"
-#define FIRMWARE_W9098	"nxp/uartuart9098_bt_v1.bin"
-#define FIRMWARE_IW416	"nxp/uartiw416_bt_v0.bin"
-#define FIRMWARE_IW612	"nxp/uartspi_n61x_v1.bin.se"
-#define FIRMWARE_HELPER	"nxp/helper_uart_3000000.bin"
+#define FIRMWARE_W8987		"nxp/uartuart8987_bt.bin"
+#define FIRMWARE_W8997		"nxp/uartuart8997_bt_v4.bin"
+#define FIRMWARE_W9098		"nxp/uartuart9098_bt_v1.bin"
+#define FIRMWARE_IW416		"nxp/uartiw416_bt_v0.bin"
+#define FIRMWARE_IW612		"nxp/uartspi_n61x_v1.bin.se"
+#define FIRMWARE_AW693		"nxp/uartaw693_bt.bin"
+#define FIRMWARE_SECURE_AW693	"nxp/uartaw693_bt.bin.se"
+#define FIRMWARE_HELPER		"nxp/helper_uart_3000000.bin"
 
 #define CHIP_ID_W9098		0x5c03
 #define CHIP_ID_IW416		0x7201
 #define CHIP_ID_IW612		0x7601
+#define CHIP_ID_AW693		0x8200
+
+#define FW_SECURE_MASK		0xc0
+#define FW_OPEN			0x00
+#define FW_AUTH_ILLEGAL		0x40
+#define FW_AUTH_PLAIN		0x80
+#define FW_AUTH_ENC		0xc0
 
 #define HCI_NXP_PRI_BAUDRATE	115200
 #define HCI_NXP_SEC_BAUDRATE	3000000
@@ -665,6 +674,9 @@ static int nxp_request_firmware(struct hci_dev *hdev, const char *fw_name)
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	int err = 0;
 
+	if (!fw_name)
+		return -ENOENT;
+
 	if (!strlen(nxpdev->fw_name)) {
 		snprintf(nxpdev->fw_name, MAX_FW_FILE_NAME_LEN, "%s", fw_name);
 
@@ -812,7 +824,8 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
-static char *nxp_get_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid)
+static char *nxp_get_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid,
+					 u8 loader_ver)
 {
 	char *fw_name = NULL;
 
@@ -826,6 +839,14 @@ static char *nxp_get_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid)
 	case CHIP_ID_IW612:
 		fw_name = FIRMWARE_IW612;
 		break;
+	case CHIP_ID_AW693:
+		if ((loader_ver & FW_SECURE_MASK) == FW_OPEN)
+			fw_name = FIRMWARE_AW693;
+		else if ((loader_ver & FW_SECURE_MASK) != FW_AUTH_ILLEGAL)
+			fw_name = FIRMWARE_SECURE_AW693;
+		else
+			bt_dev_err(hdev, "Illegal loader version %02x", loader_ver);
+		break;
 	default:
 		bt_dev_err(hdev, "Unknown chip signature %04x", chipid);
 		break;
@@ -838,13 +859,15 @@ static int nxp_recv_chip_ver_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	struct v3_start_ind *req = skb_pull_data(skb, sizeof(*req));
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	u16 chip_id;
+	u8 loader_ver;
 
 	if (!process_boot_signature(nxpdev))
 		goto free_skb;
 
 	chip_id = le16_to_cpu(req->chip_id);
+	loader_ver = req->loader_ver;
 	if (!nxp_request_firmware(hdev, nxp_get_fw_name_from_chipid(hdev,
-								    chip_id)))
+								    chip_id, loader_ver)))
 		nxp_send_ack(NXP_ACK_V3, hdev);
 
 free_skb:
-- 
2.34.1


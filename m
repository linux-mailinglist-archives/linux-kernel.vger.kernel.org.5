Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0C2778BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjHKKXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbjHKKXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:23:01 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D3A423B;
        Fri, 11 Aug 2023 03:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cu97XXFuNim9Ry3/QqFMuDvuWQxu4IGF+FaOXiYBjZsV6QeHHdYyVZfHKOV2+k4ecsvMKZRajimftvZ+bEAzYkeXqsWH2J94RUiM/Wa5tjD7YB8V9EcPnlT6Q6rFuI53d50LqSAG06spb7P1ck0R0tKgj51BP8G/470PdwkhEj2+yxFlC1oAc7OrjBGNQ+Z6Bpwpcw+hnpk3J39bArlfyhwpcAhavW01/q1eJOYfgWjTk0iB0yIE6Y7tZv6I7gkhDxwnTuf2tO5m6+QqD3QFYjqNR1eZw42xpj+qBCfhP0hnSxL9mFHmF3eXFhBQhTqPiZL5MJNbH8i2oCFMosqg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkfSc4XAeCD9PsGhKSlf3NOVTPDp9ikanJU4IiVIT5Y=;
 b=LBuJxOyi+4hvIQy1ywLV5+OLYzRfdnbu2i9MH6MAVE+YzvtluCfZYiLMpa/rqLNuXVJHD2GjwrNU5hZTdgzISr5Ifr2Pg9iRPv/zexYjPNnldIgzPSOTiM1CCx3kVuqJdDoqJK8dZrXyoLJ+DFoB4EkfWH9xIIE+azycpLg7uqyzOxWxLahr+ACsbkj3UZQD3km7lX+LbNDpnnb21zIiJe2XUJ4D3kb4zZp6VArpRrH7BSNXgSeY6v8rJrzL56YgK6UopeF/BXceIT75FvxMi/noLNOZ3u/FGenr+gUqgG2bSLWqYlRcEwIeNjFlOMmpkWVwdubAJpMB6u23RpK8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkfSc4XAeCD9PsGhKSlf3NOVTPDp9ikanJU4IiVIT5Y=;
 b=qbgLiD/qP1J+skWqq4CXZOKc1ISSRvEcpsRKcXBhPqF4fHeXuEnI8oXX+FwAHdcBhXnQUOzzBj2bMmdUG1mMsfkU7s4IticNUocBGzFdX2MxJrlnqEHQNJoTTrxjiv7U9nI4OFkKKSCE9K3/fO1U8aNwbwc9gJZKvHI+PNpmzwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by PAXPR04MB8441.eurprd04.prod.outlook.com (2603:10a6:102:1d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 10:12:25 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7504:9897:4e5d:df25]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7504:9897:4e5d:df25%4]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 10:12:25 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: btnxpuart: Add support for IW624 chipset
Date:   Fri, 11 Aug 2023 15:42:32 +0530
Message-Id: <20230811101232.844769-3-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811101232.844769-1-neeraj.sanjaykale@nxp.com>
References: <20230811101232.844769-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|PAXPR04MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bea5dd8-8bb2-4238-0696-08db9a5375e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JTodfSQ7I7sndIRIjr7R/ZyRc2xQf3Dt6s66qQG+Y6nRGt2Uq+csXHsG3owz7D4cZQ4jeXmGSvMScbzsNbpFyBZz6UNuJAAZNbt8YZdAabfbd4kmnlxEfpgCWLwYtOCDeb7fHf/jZOZtA2f4T7yFEAwVUw0cmPhVulHW3JsewHGYk9AzhZ68B2rHTwKTBR13EdtSlLOXuQvZb1rliuoWUX2Zq2JgeR8x/BTGQa5L5djtJh6UJ1l9RbCoWlcJr1nCnluwVAOaRQ9LZke3ZZbipMU/bA1LJNvUs9hx62kpI2AzFqJvjShpOa7GgNUkqyP/DSaTNJtAT2jdLrhg/jxe2TbsOBm10FuSNEvBhx+a5R0JzEisY1rS9sW+w5l65FPmAtUOIgB2Fg+PvP2O247UVJgKJjjRHVt9qAcrzowhpJ14Jkn/E4qTw50k7Ur27bAFcl7SAj0TX+iow5x1sDFIQJaNvbreNOt3A8OFIb9lIt+MWlD2EBvx14tsVrpq7IctJE/M8tFIcfyvAGkJCtLZLWlztK7K4l6EbzK+3IHPsUls7Fit/I1NI2NnME7Ty6alVFkC2dluqhCzvk7w1EX29kyYs9eOVSUekWuuhuuYgsIg3r1MFXN8aQr0SB05qTMT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(376002)(346002)(186006)(451199021)(1800799006)(6666004)(83380400001)(2616005)(2906002)(478600001)(41300700001)(6512007)(26005)(316002)(1076003)(4326008)(6506007)(36756003)(66946007)(66556008)(66476007)(6636002)(38350700002)(38100700002)(52116002)(86362001)(8676002)(8936002)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MfAdk5AUM2gqbGKbL/l1+prjhyqkVIPp5IHxsxDfwOhv+9HHMXfErfzXJ+hd?=
 =?us-ascii?Q?RxfqQ9d0vwV8kNJNhwKfew1Gau1CrrqP3pspr/ywVD38xx+Zss5OT79C07rG?=
 =?us-ascii?Q?2C3vZ0EGhAPuEljYdyldwzTYp9skmkPlmiLV/ulhjrGkeWPN1992Mbj0o09U?=
 =?us-ascii?Q?6QXXZT1le39VXNU8WaTCnltTQv6S9ULSpm+WJ82eGn0X4e5K5zQh1b8qe9EC?=
 =?us-ascii?Q?dqxqwOwEVezdIIh8nZAaLxhuI8Ri1nvBJJ9ues9PW9fODRH4e09mqdYT0OTM?=
 =?us-ascii?Q?xyus3050s5V10IV0oyAKoaKaF/XsWg/mJoxVTdyX351bScT7+z42tr2M7hUv?=
 =?us-ascii?Q?cGruJYNmVfzeKsP7TUa2Ats4a+MuEqrTluzCZKIiUHU97Rf3xQ5BleTWecJy?=
 =?us-ascii?Q?F0U5zNBmSPcwyHghP6JuZ58ERR2mG707LTK2aAyjGpbwm5JiYFVHJ4TcaUaC?=
 =?us-ascii?Q?Zf10R0lBNddZR+8EfWCRB3y9xKEh+eTRIASmDtgF5s2+UL6+z1bCETX9TVSP?=
 =?us-ascii?Q?Cyj3bHXThvv2ucA+YC2khI1ZAGdSjh/pueD86mI6dKJPpPQadJo28gw7ki8D?=
 =?us-ascii?Q?UB7ihYvI4m6lMuVbIWDtIl/ru+aaqKUDbC0bBoFVtNK/R/qZrVwMe02Pqkm8?=
 =?us-ascii?Q?yjcXeZdpAp1y1eOd/fpr6rJVLveYLwtMi8B3nZuaAqyRSW9KnTdQwoFohSd8?=
 =?us-ascii?Q?PNnIAX4FJG/yymaVf82PFZ5XDGWzAr5Hr71pzg60AMlPHNb0uK2VvZjWiln0?=
 =?us-ascii?Q?H/tIqhtzscO3E8yvZIR5aJajJQ+P4R6ZvaghxT8GWbb4a1o7XAnhItsCKSFC?=
 =?us-ascii?Q?mLOtIZkpMIbJfmLHpbxYrvtVVld0UlKVeVexGTrYj98ujZ0NwMC52eUxrhfI?=
 =?us-ascii?Q?LCTe5q7qWB4PHTnACI5z5j61bOjf7DaObII/Gofjmwx0w6EM+L6aFTDoXGXZ?=
 =?us-ascii?Q?+CrQh8YEfKlMZYpD6P9LeEAovDy8rWEq0eTmdsSBsN/WQj41CqNwEKMw0BR3?=
 =?us-ascii?Q?ABz3lcE7g+maNTki48AAhyCtrICGIkL0ZjZY3hF0kIXYiYQdgNJpdLGRorv7?=
 =?us-ascii?Q?oARxJf1MAAo2z0IznwDFkNYxIzBERvh2yVPTbxfFGtwOx3Hw7clZv7AUdRt1?=
 =?us-ascii?Q?5e9STbN79ZOejprTI1V60IMAPHF586xESo88bls2vsE+ezEpAiGqr+dXz7yQ?=
 =?us-ascii?Q?cgJgeJT7lDhOA9L08uT1yxjkOtezlCCGqfpGQOpcIDLec+xbznRaFWCCdD1F?=
 =?us-ascii?Q?QHyx+kPKnsYkdE8rDjps1hxAW1HrCnNqZlO6GJuzp5YdSaMrW0W75FKofdLd?=
 =?us-ascii?Q?+vIQ4mhpIrm1IqnOC7Fg/u9TBvZ7X1vYV8gq5mm5Btk3g+n9QQnEvgCU73+s?=
 =?us-ascii?Q?kKT7m0hktCH9za8vI6YOTMWKRr7Djgc8ukTtsF0JJsSqXMJ5JHYoJFaZAGeh?=
 =?us-ascii?Q?zTaT6SAPR1vnvzrxmqTkucb41oRIVWJkdgHTFPTJ+TuZYXJXPckmpzJR8TVr?=
 =?us-ascii?Q?3gmZVy8f0ipaS5ORtfQHEtipeHJYoR1ZBAcyYoiN3Xo3+ycFemNDmMRE/HTJ?=
 =?us-ascii?Q?iLlHtRauBTGo6LBnWALQz6LdHlFHFcq3Q8FHx35y4eQ5nJgCRAk+Z1dhapc/?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bea5dd8-8bb2-4238-0696-08db9a5375e8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 10:12:25.5723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89ftwDPGEnw++WWTe4PZX6vay930Zse+UD6NyUa+/ui92XGPmDKn1SkcuQaTd+6/wsZcNjIhhrVYf/K8lOgrZtHvSktX67DkqRNQ5bzCOAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8441
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for NXP IW624 chipset in btnxpuart driver
by adding FW name and bootloader signature. Based on the
loader version bits 7:6 of the bootloader signature, the
driver can choose between selecting secure and non-secure
FW files.
For cmd5 payload during FW download, this chip has addresses
of few registers offset by 1, so added boot_reg_offset to
handle the chip specific offset.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Remove wait_for_cts low check in a separate commit (Francesco
Dolcini)
---
 drivers/bluetooth/btnxpuart.c | 37 ++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 1dd60c7e6fe0..b42572ca63af 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -34,6 +34,8 @@
 #define FIRMWARE_W9098		"nxp/uartuart9098_bt_v1.bin"
 #define FIRMWARE_IW416		"nxp/uartiw416_bt_v0.bin"
 #define FIRMWARE_IW612		"nxp/uartspi_n61x_v1.bin.se"
+#define FIRMWARE_IW624		"nxp/uartiw624_bt.bin"
+#define FIRMWARE_SECURE_IW624	"nxp/uartiw624_bt.bin.se"
 #define FIRMWARE_AW693		"nxp/uartaw693_bt.bin"
 #define FIRMWARE_SECURE_AW693	"nxp/uartaw693_bt.bin.se"
 #define FIRMWARE_HELPER		"nxp/helper_uart_3000000.bin"
@@ -41,6 +43,8 @@
 #define CHIP_ID_W9098		0x5c03
 #define CHIP_ID_IW416		0x7201
 #define CHIP_ID_IW612		0x7601
+#define CHIP_ID_IW624a		0x8000
+#define CHIP_ID_IW624c		0x8001
 #define CHIP_ID_AW693		0x8200
 
 #define FW_SECURE_MASK		0xc0
@@ -152,6 +156,7 @@ struct btnxpuart_dev {
 	u32 fw_v1_sent_bytes;
 	u32 fw_v3_offset_correction;
 	u32 fw_v1_expected_len;
+	u32 boot_reg_offset;
 	wait_queue_head_t fw_dnld_done_wait_q;
 	wait_queue_head_t check_boot_sign_wait_q;
 
@@ -538,6 +543,7 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 	nxpdev->fw_dnld_v1_offset = 0;
 	nxpdev->fw_v1_sent_bytes = 0;
 	nxpdev->fw_v1_expected_len = HDR_LEN;
+	nxpdev->boot_reg_offset = 0;
 	nxpdev->fw_v3_offset_correction = 0;
 	nxpdev->baudrate_changed = false;
 	nxpdev->timeout_changed = false;
@@ -547,7 +553,7 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 	serdev_device_set_flow_control(nxpdev->serdev, false);
 	nxpdev->current_baudrate = HCI_NXP_PRI_BAUDRATE;
 
-	/* Wait till FW is downloaded and CTS becomes low */
+	/* Wait till FW is downloaded */
 	err = wait_event_interruptible_timeout(nxpdev->fw_dnld_done_wait_q,
 					       !test_bit(BTNXPUART_FW_DOWNLOADING,
 							 &nxpdev->tx_state),
@@ -586,6 +592,12 @@ static bool nxp_fw_change_baudrate(struct hci_dev *hdev, u16 req_len)
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct nxp_bootloader_cmd nxp_cmd5;
 	struct uart_config uart_config;
+	u32 clkdivaddr = CLKDIVADDR - nxpdev->boot_reg_offset;
+	u32 uartdivaddr = UARTDIVADDR - nxpdev->boot_reg_offset;
+	u32 uartmcraddr = UARTMCRADDR - nxpdev->boot_reg_offset;
+	u32 uartreinitaddr = UARTREINITADDR - nxpdev->boot_reg_offset;
+	u32 uarticraddr = UARTICRADDR - nxpdev->boot_reg_offset;
+	u32 uartfcraddr = UARTFCRADDR - nxpdev->boot_reg_offset;
 
 	if (req_len == sizeof(nxp_cmd5)) {
 		nxp_cmd5.header = __cpu_to_le32(5);
@@ -598,17 +610,17 @@ static bool nxp_fw_change_baudrate(struct hci_dev *hdev, u16 req_len)
 		serdev_device_write_buf(nxpdev->serdev, (u8 *)&nxp_cmd5, sizeof(nxp_cmd5));
 		nxpdev->fw_v3_offset_correction += req_len;
 	} else if (req_len == sizeof(uart_config)) {
-		uart_config.clkdiv.address = __cpu_to_le32(CLKDIVADDR);
+		uart_config.clkdiv.address = __cpu_to_le32(clkdivaddr);
 		uart_config.clkdiv.value = __cpu_to_le32(0x00c00000);
-		uart_config.uartdiv.address = __cpu_to_le32(UARTDIVADDR);
+		uart_config.uartdiv.address = __cpu_to_le32(uartdivaddr);
 		uart_config.uartdiv.value = __cpu_to_le32(1);
-		uart_config.mcr.address = __cpu_to_le32(UARTMCRADDR);
+		uart_config.mcr.address = __cpu_to_le32(uartmcraddr);
 		uart_config.mcr.value = __cpu_to_le32(MCR);
-		uart_config.re_init.address = __cpu_to_le32(UARTREINITADDR);
+		uart_config.re_init.address = __cpu_to_le32(uartreinitaddr);
 		uart_config.re_init.value = __cpu_to_le32(INIT);
-		uart_config.icr.address = __cpu_to_le32(UARTICRADDR);
+		uart_config.icr.address = __cpu_to_le32(uarticraddr);
 		uart_config.icr.value = __cpu_to_le32(ICR);
-		uart_config.fcr.address = __cpu_to_le32(UARTFCRADDR);
+		uart_config.fcr.address = __cpu_to_le32(uartfcraddr);
 		uart_config.fcr.value = __cpu_to_le32(FCR);
 		/* FW expects swapped CRC bytes */
 		uart_config.crc = __cpu_to_be32(crc32_be(0UL, (char *)&uart_config,
@@ -822,6 +834,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 static char *nxp_get_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid,
 					 u8 loader_ver)
 {
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	char *fw_name = NULL;
 
 	switch (chipid) {
@@ -834,6 +847,16 @@ static char *nxp_get_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid,
 	case CHIP_ID_IW612:
 		fw_name = FIRMWARE_IW612;
 		break;
+	case CHIP_ID_IW624a:
+	case CHIP_ID_IW624c:
+		nxpdev->boot_reg_offset = 1;
+		if ((loader_ver & FW_SECURE_MASK) == FW_OPEN)
+			fw_name = FIRMWARE_IW624;
+		else if ((loader_ver & FW_SECURE_MASK) != FW_AUTH_ILLEGAL)
+			fw_name = FIRMWARE_SECURE_IW624;
+		else
+			bt_dev_err(hdev, "Illegal loader version %02x", loader_ver);
+		break;
 	case CHIP_ID_AW693:
 		if ((loader_ver & FW_SECURE_MASK) == FW_OPEN)
 			fw_name = FIRMWARE_AW693;
-- 
2.34.1


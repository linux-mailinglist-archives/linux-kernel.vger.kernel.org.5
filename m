Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7DD7774E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjHJJrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjHJJrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:47:39 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EB81BF7;
        Thu, 10 Aug 2023 02:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYmFEwC3IWdhn5u6Os4vPVYBYpB5auLvjtBkKf/CdXH2rt/LN8eyrKrkoteeQ0gxDDV5Z7o2i/Idoa/rQtsB4DlKBwLXIttEnb/cnNkrA3k+stMQc5Sq3BtsS9wIKrVwqRCLKuiuORyFe29sOLHbbVYDTXteS6tcAEMumtcPSRmIUTQzHUJpYoQ76ExQE/ytiumPoE6BGZJvyVTT88DhrczehUBZrd8yET9QnYt7HKBGqvTKHIhC+cNtUa4RaNKf+s/EM44DeU5KWM/TI0vCyg27k4MVQaozxI4N/XM/dDEQ1EVrDuao8ad5RoA6z1v2r4koocY3wrCjSGpPDbEVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnCtmvYpP4xVB9QuyamWwkua1X3GCGKL0XKhHT6suZg=;
 b=MB6Hpjp8HVoZU3MJbQo/pQXkkn60y20yudONkdxRtB6Heso3Xb5t9scI0cGsEYRx0d+Ni6eJCLZUfNo3YVTKefLtTr9BrgVyTXOp86ZzUlVjaEVxe2Z3BuCAgJQPsZFPAIQCj8T2O069AfkzDv/9dFBuhpkbBA1xWtypDSX5rNxASC8ZZc/Axe9xSk6/i0aNirA8fa0jha3KbnSyb/RCRTTGdnXafQp8Nbm2M/Hrkks/u8cv0sDEc2vB99MhV0/c/bs+SzAsmSiOODvFsX4P8q9QObz7SQXy2OzNAu0/8ty61THNFbdioGoB72/I6V9KgsJ9OUXb9csr0k7n018NhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnCtmvYpP4xVB9QuyamWwkua1X3GCGKL0XKhHT6suZg=;
 b=ZbnFo6r9uRutu9/yEysrxXgllg6PhhX2Z8mBwfAFXcGRHb5VhrULP3GNrXraUtiW6/dfD7zTvv9rQq1RzVIOQ4kYgtEvHKSegCD4u3ba8u18Dy/OhqVVSEk9VxvOG5k4TB8wmOW7Xlo7XzQWPpjbySWT0aYBrCzguxSSssJ8G3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AS1PR04MB9263.eurprd04.prod.outlook.com (2603:10a6:20b:4c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 09:47:31 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7504:9897:4e5d:df25]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7504:9897:4e5d:df25%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 09:47:31 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] Bluetooth: btnxpuart: Add support for IW624 chipset
Date:   Thu, 10 Aug 2023 15:18:02 +0530
Message-Id: <20230810094802.832652-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|AS1PR04MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: 711cabf9-8e87-49de-1c1f-08db9986d0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZNxISRmKEYa2rNVJEgEHLwAkKz5nJ4RCRBpAP75z670RkJ349xyMlvLnqGxakAuRi3wb6wr0Rb+7UyWvbwPWG5ijSkDUZN4+dZwmsv+DZ+WsP2Vb8jTQA2gb3ugdCebdRXuH6N71nLCpPQEzO5OaG+lFPRDps0HsG5f5YUMb85Mqzhk7mnmug6dIFUCqXdvpg1PTHzJxQO0DWGJvvfQCtTlRfUeqUcPHV88v62NlhCMOIacEcY4DS98Mtd1kJc6Wj7tUffwvE7xze4q9p/VUV+hekTrSVZTd/B5m9H9n7gxRM+405AM7VxH6qre+9D6hw6r8bVTQgfwAHFFPaBUICvvvv2nBiwlADrgXJNACAPqE+MuUCxudgiI6e9R6bfI3mu/k1QdRNzeVdIhgy6jsHSiFphvtzZ8pZbX3EWaWoq/5x7Lfu/BBCwTOazQ7ixP/cwD9dog4CyJJVuBZEV3Yq9DQWEoivfm6A1gsKpaY1cN0ebu2ENR43n0UBEPRaS0ve0D+M26GTNqY7gJEwftXfaPxE7Jaw4FP/2hXDO9UUkC+0alaFgAuL1ybnkTTJGkIlec0kHOVlhK5SJVzHUWiUj1f7bSoLjnlx4xJbob9CZ5ZW1HaSDhEbRZZGzBm/WB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(186006)(1800799006)(451199021)(316002)(1076003)(6506007)(26005)(41300700001)(8676002)(6666004)(8936002)(5660300002)(83380400001)(2906002)(38350700002)(38100700002)(36756003)(4326008)(6486002)(52116002)(86362001)(478600001)(6512007)(66946007)(6636002)(66556008)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hmS0jL8LuWHHx4kn2VYsSLdSa+JbRXgYEHNzgGNo5OZ+3NEqIAZBN/4+X8IS?=
 =?us-ascii?Q?H5xyAF/ngNGAChPv/Rs4noiUvifnO6ONLUkoEnXL5aJWoKJWdLA7/BRgBEo+?=
 =?us-ascii?Q?stNH4A9+ND6q0FdgXrQ0COXBj3Q8c7xjRPutUdKUGjRrAYkS2GWBjVUqkIKv?=
 =?us-ascii?Q?I5UL0VvDUlnmjeOM4iQ03n2LAZgNXzcFZy6UVJQV8z0TdR0b7PysOYP5PNSd?=
 =?us-ascii?Q?mGkj/Xmr+a5qY8buUJyRn44plv/lfT6Wp819JEZvXTySl/rhFa4cWBmPd0+w?=
 =?us-ascii?Q?+XqmFTbwozLsOTo75FezW2pNybOkySyHwVhx0vvjd3InTMSLlApbiUOAbKOo?=
 =?us-ascii?Q?9/DmzUpechBr+BwzfWBvY1/GsGriCplP1Zf8TwNTweBCcQE1A71BpiGZ4cwk?=
 =?us-ascii?Q?cscBvglp4W785lzG1vH4Jfg0e7OXtr+oxL5nPakfoVmUedt6b5Q5quV0dWlY?=
 =?us-ascii?Q?zn5IDYfr8x8PuD5YnUZVHJXqlWxH2KJtzOFBXhgPTAj/rz3PqXrUgB89eFFa?=
 =?us-ascii?Q?Z5ooTf07esisJzko7htvIRRyOEz527PvEb5kODPjqvZKINj1zNb0j4As1LAi?=
 =?us-ascii?Q?p9qVcNfjol8qtd1T895yB44AItnoCitH4U981ahmKJp9W9eOF8Y56AAsxW1T?=
 =?us-ascii?Q?H+Ug/YRKbCdIHCaVvID8++8PuQaGGNpFWK8beD6yFnLUACXTbwhrTjJMNXN2?=
 =?us-ascii?Q?tV/xbYoeMq5QtzFsynXkVHckLzuwgAeGqffoRyijVv5Vtd2sw0k8iHdL0n/6?=
 =?us-ascii?Q?f1HBY//BYTlfESlIbhlPEyjDml2TltFxeCOqZgGKP9Rf2n6DV4ppibvUbShI?=
 =?us-ascii?Q?zWcRkgsnXQnN9oHNulu8UYGf0xiNB0HmHP9Hjcg/IOtcryka4+7brSISaaap?=
 =?us-ascii?Q?D2L6v/g5M63rBQujRGR8eUmZ3KzuLAt5pEnIXzqD9FZetsDAKYoFiOAonw3e?=
 =?us-ascii?Q?9oqM+bCdyNl6DeSJk6DHLCpvXKY+pKGtZB9w3u68KyLhTgNXuNrfJnQFnJHw?=
 =?us-ascii?Q?lZtjCX8dxZIqFgr0cPCu43j3Jqeq//3E0EjjaiDxem/EEUMI4Qi2DLyvh4vD?=
 =?us-ascii?Q?n7yf3U+aTJ+JHAdxyNZ/sY/3HitwoXSscLfkBO6txqs37fOFfHYfU5jFMHxv?=
 =?us-ascii?Q?cxGWRFvrOIaa1WDLHV3L/AnGsCTwSAX3OSRMduI2gejvoTHqHcpsdQENmRjW?=
 =?us-ascii?Q?FxJca2Iia1pEHIU7d7wmz2YCz5r9W/7avAblII2Lgs1hQ0TC+6GkAfcno9W9?=
 =?us-ascii?Q?NDwcq7VKOuyQ6bEPiFg9h0+jLGE079pO00v50ukx1jJ3Bb1ZpwLKcxm/dqQg?=
 =?us-ascii?Q?5A50yhvJRYfrAzkJTAGzbyUc9HRBvzKkdLSAmv/QCtD6+5LVWa1aoj085smP?=
 =?us-ascii?Q?8YBBx0ATyl1YHKy0f3n9AuPshPKqADBip8JLZINqpnZ2nUEe0GvOOWZmhwIY?=
 =?us-ascii?Q?k9n44s6IoGwhWDTGDAnh7vIzO3gKJmEJlRK46aEQtx47tEycga8UnoZ24XwC?=
 =?us-ascii?Q?eBDEBdrIrZpTXm9++qubioYLMDBj5U0KBDrI6eDFug/W/cCtJCYSBrWK3T+O?=
 =?us-ascii?Q?rtHMLUqQj3sFq8FCZQ8yNwaT/1fkP2PqlQLDobPM14wmPbzBY8L6J4cTk1RG?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711cabf9-8e87-49de-1c1f-08db9986d0ce
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 09:47:31.2673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpNe4ZAOjzXLa7u4ZdNJFkWDUgfSDVGfnxLRIzWZ/sMN6DWhi6CFPLYdSlXmLT1y8Av/hmNHDbj3G2c+nZgGEJbx0WgkOB5h2CsMufO9z2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9263
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
 drivers/bluetooth/btnxpuart.c | 44 ++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index ee6f6c872a34..b42572ca63af 100644
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
@@ -558,16 +564,11 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 	}
 
 	serdev_device_set_flow_control(nxpdev->serdev, true);
-	err = serdev_device_wait_for_cts(nxpdev->serdev, 1, 60000);
-	if (err < 0) {
-		bt_dev_err(hdev, "CTS is still high. FW Download failed.");
-		return err;
-	}
 	release_firmware(nxpdev->fw);
 	memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
 
 	/* Allow the downloaded FW to initialize */
-	usleep_range(800 * USEC_PER_MSEC, 1 * USEC_PER_SEC);
+	msleep(1200);
 
 	return 0;
 }
@@ -591,6 +592,12 @@ static bool nxp_fw_change_baudrate(struct hci_dev *hdev, u16 req_len)
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
@@ -603,17 +610,17 @@ static bool nxp_fw_change_baudrate(struct hci_dev *hdev, u16 req_len)
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
@@ -827,6 +834,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 static char *nxp_get_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid,
 					 u8 loader_ver)
 {
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	char *fw_name = NULL;
 
 	switch (chipid) {
@@ -839,6 +847,16 @@ static char *nxp_get_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid,
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


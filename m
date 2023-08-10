Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148EB7779EC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbjHJNyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjHJNyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:54:39 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2052.outbound.protection.outlook.com [40.107.15.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0C6212B;
        Thu, 10 Aug 2023 06:54:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYCEHh6QA3piXadtolxVGHJDdPvaLmHGG+2I4W8GrVCCmXW9eVmgNL0awnqcORLVkAbUYgvYjLO81G8OOVyMViZ0vZdOpS7mKJ8neaUMBPGUSAnhzYCXwgu7OVU7eLGuT99FhOKeIqRZF55k06IpYLYAWaOi5wmqsQsH/xiskFQfaZyexQOiNyR44Y2eH8nlv9h6csSi7dgoHFDi0YwzH+/go55WrGdM/w8NuiGzt/RBcT+RDpmiSphdhZ4SPudbPt5RzJeK7JXMMRGw5gkx4vcoc8elj6RKutm+44uYJFtVoMQ5+KP2Z5bTwlpXZdyrHyEaCUcmiDHZDmYyXRcKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYyhErDSboPj6H10truil7TuSW6RyfvG9tvPCd9mTFI=;
 b=KFAqbz7wZfCn4Jsw+y5DHJyy+/NvOGKS/YywE3q0+FvLS9RHYujRJ4B5wndrG/2PrHNe+uUyCmjf4q2jEThlfUx3aFzw7cwJa433YbhlL67IDtjJgkjJaqBRxK1zd32SQVruX4YWi6XGhFqipqUOKIj/FfR812OioWLYmm+8MoccX+OYQs1xa/TNtc8uOWNxv95j35cfME4J2Ibsc4LXHYL2YszgtEd8GBlVhuq24oRy7hY+7cMM1/ITVz9d7JYYVn/u6EvgHutyfo6yul3V9TKG9q/I5HLknxlfvnpwrrSXG2CESXMvXyEdg7wKVclBA6FqGzT8QqZiz8lW1i5AMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYyhErDSboPj6H10truil7TuSW6RyfvG9tvPCd9mTFI=;
 b=UtV72qIKb7o91iEiAIlRkmJpLtvi9lI2NsUxELS6wWrCYb0o9pjDgOB3uTI7n9bfkhC2S3SOMBLcw18zI9zf7v4OGj8GjJ4M4keZTNzoLUfc6LOXKIe7zZ6pC/YcjGnoKrDSgfoqidW1Iapc9QF2HnNaa767H0hXynJloD5e8O8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by PAXPR04MB9400.eurprd04.prod.outlook.com (2603:10a6:102:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 13:54:35 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7504:9897:4e5d:df25]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7504:9897:4e5d:df25%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 13:54:35 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] Bluetooth: btnxpuart: Improve inband Independent Reset handling
Date:   Thu, 10 Aug 2023 19:25:09 +0530
Message-Id: <20230810135509.835889-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|PAXPR04MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: 5219a8bd-6557-4b3e-93d0-08db99a954aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sx7MUfShKt+Fu/GFYbgoU+RWgn1DUewXH3T7IChGhrjCx6TmlEyMBt4tRdX9baSwI0H8gCJXfbokR23+V+A+beIumJb+n8Uq9BDQ/pzyDOtrLGJDbRawFBZ8krTqciaPpxnLA53kaWyLWHt8WMtbU93G90A0EXfUY/IfkjQpSwVw/g40Nsfzn6b5zhulT+JbKE7cWok7ClvSV26RDYceyYeuX5GQTylt4yDeXkmrvBw/XQFCS3wWmCyg536CFu6JIsQa9hTYpHwcd97hZYQhCsSmj3FBwYjDQ5Znq5Efz+Vdwf46ERNxMbMLijHpg2Ahwk3qVN6DYyiSGyWPApqF12KaUJVIvSWZbG4V5J4eu/KCjkkSC6e3I0pMbuF01eUAqglv3bZw9FgqYHWTiObd2eDVDYQf3TzcLU4GZXFGFPkn7VaBVcKHdcAgOdx0t3UmPrbWW2Lbm5rFNIVOA5k/+JYvmFx+JMYKNKAg3MaRgfdOgigt6LsUbjEI2Bvjy29THxHfxIPsPKm0GX3DOZyQADkA6wW2voxlNcv0PVjWkPQeLKkbO9juNLbdD4EbYlKyHDb3WwrV6QrkjHxmoR9Jfk6l5/Uoygo9rElk0FIYDrJsaxkWbKACvbMaHE6i/vgF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(186006)(1800799006)(66946007)(66476007)(66556008)(38350700002)(36756003)(38100700002)(5660300002)(8676002)(8936002)(83380400001)(316002)(6636002)(4326008)(2906002)(41300700001)(86362001)(6666004)(52116002)(6486002)(6512007)(6506007)(26005)(1076003)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?roiW+16CzOuA7hBiLwe63Opr0vp+MJe3u8ZYd5VQoOCb449/Mp65XcajkWL6?=
 =?us-ascii?Q?DIzk6XENOBORT/aQwQ9THCkqUU9w4KeX2yujrYqL2RPKLnVSCq9NdP9YQ+4I?=
 =?us-ascii?Q?Qjrb1uduOjFWoQcvLToWWC/UrLsqATLqD8t3lAPsP4I/GpW3xypenVmm6Bji?=
 =?us-ascii?Q?wu0z4yxWLgZelVduxt1+q9zK6NNdrCWgfONW3RjeOCS3G/tQvy52eaDkVWJJ?=
 =?us-ascii?Q?X5MQVgBO6K9pJpNtr2Y9SSXWJTieu6d1YZ21jn/+YN9UyErTO2HjVomaLHPJ?=
 =?us-ascii?Q?y7Qs8j6EjtlxavKbAvVmo+HFB8n6D5MFITR4ITZve6HoTMS+zGs1L+Eat9l9?=
 =?us-ascii?Q?drRMMU816F0LVX1pf9rAsiZ8hb0EN8BObJc7HZXbPWlUv33UwQ76ngtelMRK?=
 =?us-ascii?Q?AmtEUwTq+N8CYvruu49zO0VF/vQ+zjojktwvpZwtcLQ63n2fRKN4cphJHeHi?=
 =?us-ascii?Q?V5xQLYTS8O3Mn3YaKrSzSItRVc/t3JSj8tDhYC4Tmfkl9OhrnO8eSDK7SoGZ?=
 =?us-ascii?Q?qSkOGxn40VBSyODudAVQzt2otqjtV3mnsqNYLyeoJYI45hUVaI1F9I0VLBXq?=
 =?us-ascii?Q?pJUJYfzI8xOanZyFjGybU3DN/f+V6V/FJVBfVZAZBv3hZG2xlDlrIWa5I6nC?=
 =?us-ascii?Q?HjhZR9OxYYup+QJqmWrfLBhYPMLvb+ra3prQwY5rL23nX8evpKpF5oXS7Vkd?=
 =?us-ascii?Q?X3GdbwtgPdFp/KIXMTL/pVPJ5g02/QexlD4RYLQ0A+H4z9YssfDHPVTg7vu5?=
 =?us-ascii?Q?noApnvgyWgyKb+RngPGOEfUy5K5a3C89FxpAKpDkcwoE5/A/n1mMixjKwBvs?=
 =?us-ascii?Q?RmNbkVtVdqilLpJKT+EOpCNfaQ9LTb/Uuf4IqaGcVY22JfZTLRdERfG7XYT9?=
 =?us-ascii?Q?h1t6fAuVCKFUhXUZwxixIhVaAEZQTpY+fLapTPxNb5MD6+PWCU3TZrc1Tb4l?=
 =?us-ascii?Q?mvSsetAzb6oR70/n5Pdk3WZ5Q3V/Z/WP1/rPH1uuL3GoHRxE42kn4AoB7A9a?=
 =?us-ascii?Q?DeYNhJpFi2t5ubInzFbb7aSKYddLcado+reCLkDahFXkcl98A0JM7Aqtfxao?=
 =?us-ascii?Q?Uldo4bQFLSKlrtX031VFqS+JpP8IXojMXXNiA/x+Y73PHXocn6/HRnFIau00?=
 =?us-ascii?Q?pUjL5kkufEhuf+tg7Z6t6GQCWh2nqcPrm7A5ClX0EfQrk0aBxlxG13ULB9zx?=
 =?us-ascii?Q?e8UK8xZ0iWE3P8DWKmEuUijJz54iGfHgtS4YzWHUYFa+DxkvVT2msBts3kaC?=
 =?us-ascii?Q?Sh+jKKVtJzi6M5z5hn+ycgXc5NveeoxEIt3VKsIjpTMt4OcBDv+cQUfWJvkX?=
 =?us-ascii?Q?7MfMBUj0acvAEYbDyZFfuspQPRNOtxrlNR1fN16l99/BiwR51SqgbtzGFVqN?=
 =?us-ascii?Q?+i0PgAnszsDCYuGXcV/IkTEwiWwTJb228y1MV5uLQHt4YRKpMZnbahcOh/cf?=
 =?us-ascii?Q?JaxtuP9n5HP2YBKVgKudbvO1Go3NLG2dHWoBCq5gJhA9dvIiApocGlKwigHN?=
 =?us-ascii?Q?Z+mpw8q41Dbt4rev1ch/jHvu77W/DzfVKKu4nsIVjQBziGxJDVhTCu6wFVrm?=
 =?us-ascii?Q?g1wpe0MSS4R66o30RsyAJ+FwuKNQPU0y5LUuEpT6r4FKtk59iFWfr04UieZQ?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5219a8bd-6557-4b3e-93d0-08db99a954aa
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 13:54:35.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8czn4+cS7tPvWLLBSOl+2ThSk07dM0Ub5nmZtYZdEPidQ39HJ51lXKxR6Z6Pb9krdi8zu3/Nhd+pkISxjMCzRg+U7wQh6bnzNbIhDc5f1Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9400
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This improves the inband IR command handling for NXP BT chipsets.
When the IR vendor command is received, the driver injects a HW
error event, which causes a reset sequence in hci_error_reset().
The vendor IR command is sent to the controller while hci dev
is been closed, and FW is re-downloaded when nxp_setup() is
called during hci_dev_do_open().
The HCI_SETUP flag is set in nxp_hw_err() to make sure that
nxp_setup() is been called during hci_dev_do_open().

This also makes the nxp_setup() and power save functions more
generic.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 172 +++++++++++++++++++---------------
 1 file changed, 96 insertions(+), 76 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index ee6f6c872a34..de92fc0f08ad 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -28,6 +28,10 @@
 #define BTNXPUART_FW_DOWNLOADING	2
 #define BTNXPUART_CHECK_BOOT_SIGNATURE	3
 #define BTNXPUART_SERDEV_OPEN		4
+#define BTNXPUART_IR_IN_PROGRESS	5
+
+/* NXP HW err codes */
+#define BTNXPUART_IR_HW_ERR		0xb0
 
 #define FIRMWARE_W8987		"nxp/uartuart8987_bt.bin"
 #define FIRMWARE_W8997		"nxp/uartuart8997_bt_v4.bin"
@@ -375,39 +379,13 @@ static void ps_timeout_func(struct timer_list *t)
 	}
 }
 
-static int ps_init_work(struct hci_dev *hdev)
+static void ps_setup(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
 
-	psdata->h2c_ps_interval = PS_DEFAULT_TIMEOUT_PERIOD_MS;
-	psdata->ps_state = PS_STATE_AWAKE;
-	psdata->target_ps_mode = DEFAULT_PS_MODE;
 	psdata->hdev = hdev;
-	psdata->c2h_wakeupmode = BT_HOST_WAKEUP_METHOD_NONE;
-	psdata->c2h_wakeup_gpio = 0xff;
-
-	switch (DEFAULT_H2C_WAKEUP_MODE) {
-	case WAKEUP_METHOD_DTR:
-		psdata->h2c_wakeupmode = WAKEUP_METHOD_DTR;
-		break;
-	case WAKEUP_METHOD_BREAK:
-	default:
-		psdata->h2c_wakeupmode = WAKEUP_METHOD_BREAK;
-		break;
-	}
-	psdata->cur_psmode = PS_MODE_DISABLE;
-	psdata->cur_h2c_wakeupmode = WAKEUP_METHOD_INVALID;
 	INIT_WORK(&psdata->work, ps_work_func);
-
-	return 0;
-}
-
-static void ps_init_timer(struct hci_dev *hdev)
-{
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
-	struct ps_data *psdata = &nxpdev->psdata;
-
 	timer_setup(&psdata->ps_timer, ps_timeout_func, 0);
 }
 
@@ -510,19 +488,31 @@ static void ps_init(struct hci_dev *hdev)
 	serdev_device_set_tiocm(nxpdev->serdev, TIOCM_RTS, 0);
 	usleep_range(5000, 10000);
 
-	switch (psdata->h2c_wakeupmode) {
+	psdata->ps_state = PS_STATE_AWAKE;
+	psdata->c2h_wakeupmode = BT_HOST_WAKEUP_METHOD_NONE;
+	psdata->c2h_wakeup_gpio = 0xff;
+
+	psdata->cur_h2c_wakeupmode = WAKEUP_METHOD_INVALID;
+	psdata->h2c_ps_interval = PS_DEFAULT_TIMEOUT_PERIOD_MS;
+	switch (DEFAULT_H2C_WAKEUP_MODE) {
 	case WAKEUP_METHOD_DTR:
+		psdata->h2c_wakeupmode = WAKEUP_METHOD_DTR;
 		serdev_device_set_tiocm(nxpdev->serdev, 0, TIOCM_DTR);
 		serdev_device_set_tiocm(nxpdev->serdev, TIOCM_DTR, 0);
 		break;
 	case WAKEUP_METHOD_BREAK:
 	default:
+		psdata->h2c_wakeupmode = WAKEUP_METHOD_BREAK;
 		serdev_device_break_ctl(nxpdev->serdev, -1);
 		usleep_range(5000, 10000);
 		serdev_device_break_ctl(nxpdev->serdev, 0);
 		usleep_range(5000, 10000);
 		break;
 	}
+
+	psdata->cur_psmode = PS_MODE_DISABLE;
+	psdata->target_ps_mode = DEFAULT_PS_MODE;
+
 	if (psdata->cur_h2c_wakeupmode != psdata->h2c_wakeupmode)
 		hci_cmd_sync_queue(hdev, send_wakeup_method_cmd, NULL, NULL);
 	if (psdata->cur_psmode != psdata->target_ps_mode)
@@ -702,7 +692,7 @@ static int nxp_recv_chip_ver_v1(struct hci_dev *hdev, struct sk_buff *skb)
 		goto free_skb;
 
 	chip_id = le16_to_cpu(req->chip_id ^ req->chip_id_comp);
-	if (chip_id == 0xffff) {
+	if (chip_id == 0xffff && nxpdev->fw_dnld_v1_offset) {
 		nxpdev->fw_dnld_v1_offset = 0;
 		nxpdev->fw_v1_sent_bytes = 0;
 		nxpdev->fw_v1_expected_len = HDR_LEN;
@@ -969,45 +959,13 @@ static int nxp_set_baudrate_cmd(struct hci_dev *hdev, void *data)
 	return 0;
 }
 
-static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
-{
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
-	struct sk_buff *skb;
-	u8 *status;
-	u8 pcmd = 0;
-	int err = 0;
-
-	skb = nxp_drv_send_cmd(hdev, HCI_NXP_IND_RESET, 1, &pcmd);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	status = skb_pull_data(skb, 1);
-	if (!status || *status)
-		goto free_skb;
-
-	set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
-	err = nxp_download_firmware(hdev);
-	if (err < 0)
-		goto free_skb;
-	serdev_device_set_baudrate(nxpdev->serdev, nxpdev->fw_init_baudrate);
-	nxpdev->current_baudrate = nxpdev->fw_init_baudrate;
-	if (nxpdev->current_baudrate != HCI_NXP_SEC_BAUDRATE) {
-		nxpdev->new_baudrate = HCI_NXP_SEC_BAUDRATE;
-		nxp_set_baudrate_cmd(hdev, NULL);
-	}
-	hci_cmd_sync_queue(hdev, send_wakeup_method_cmd, NULL, NULL);
-	hci_cmd_sync_queue(hdev, send_ps_cmd, NULL, NULL);
-
-free_skb:
-	kfree_skb(skb);
-	return err;
-}
-
-/* NXP protocol */
 static int nxp_check_boot_sign(struct btnxpuart_dev *nxpdev)
 {
 	serdev_device_set_baudrate(nxpdev->serdev, HCI_NXP_PRI_BAUDRATE);
-	serdev_device_set_flow_control(nxpdev->serdev, true);
+	if (test_bit(BTNXPUART_IR_IN_PROGRESS, &nxpdev->tx_state))
+		serdev_device_set_flow_control(nxpdev->serdev, false);
+	else
+		serdev_device_set_flow_control(nxpdev->serdev, true);
 	set_bit(BTNXPUART_CHECK_BOOT_SIGNATURE, &nxpdev->tx_state);
 
 	return wait_event_interruptible_timeout(nxpdev->check_boot_sign_wait_q,
@@ -1016,15 +974,29 @@ static int nxp_check_boot_sign(struct btnxpuart_dev *nxpdev)
 					       msecs_to_jiffies(1000));
 }
 
+static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
+{
+	static const u8 ir_hw_err[] = { HCI_EV_HARDWARE_ERROR,
+					0x01, BTNXPUART_IR_HW_ERR };
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(3, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
+	skb_put_data(skb, ir_hw_err, 3);
+
+	/* Inject Hardware Error to upper stack */
+	return hci_recv_frame(hdev, skb);
+}
+
+/* NXP protocol */
 static int nxp_setup(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	int err = 0;
 
-	set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
-	init_waitqueue_head(&nxpdev->fw_dnld_done_wait_q);
-	init_waitqueue_head(&nxpdev->check_boot_sign_wait_q);
-
 	if (nxp_check_boot_sign(nxpdev)) {
 		bt_dev_dbg(hdev, "Need FW Download.");
 		err = nxp_download_firmware(hdev);
@@ -1035,10 +1007,6 @@ static int nxp_setup(struct hci_dev *hdev)
 		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 	}
 
-	device_property_read_u32(&nxpdev->serdev->dev, "fw-init-baudrate",
-				 &nxpdev->fw_init_baudrate);
-	if (!nxpdev->fw_init_baudrate)
-		nxpdev->fw_init_baudrate = FW_INIT_BAUDRATE;
 	serdev_device_set_baudrate(nxpdev->serdev, nxpdev->fw_init_baudrate);
 	nxpdev->current_baudrate = nxpdev->fw_init_baudrate;
 
@@ -1049,6 +1017,46 @@ static int nxp_setup(struct hci_dev *hdev)
 
 	ps_init(hdev);
 
+	if (test_and_clear_bit(BTNXPUART_IR_IN_PROGRESS, &nxpdev->tx_state))
+		hci_dev_clear_flag(hdev, HCI_SETUP);
+
+	return 0;
+}
+
+static void nxp_hw_err(struct hci_dev *hdev, u8 code)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+
+	switch (code) {
+	case BTNXPUART_IR_HW_ERR:
+		set_bit(BTNXPUART_IR_IN_PROGRESS, &nxpdev->tx_state);
+		hci_dev_set_flag(hdev, HCI_SETUP);
+		break;
+	default:
+		break;
+	}
+}
+
+static int nxp_shutdown(struct hci_dev *hdev)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct sk_buff *skb;
+	u8 *status;
+	u8 pcmd = 0;
+
+	if (test_bit(BTNXPUART_IR_IN_PROGRESS, &nxpdev->tx_state)) {
+		skb = nxp_drv_send_cmd(hdev, HCI_NXP_IND_RESET, 1, &pcmd);
+		if (IS_ERR(skb))
+			return PTR_ERR(skb);
+
+		status = skb_pull_data(skb, 1);
+		if (status) {
+			serdev_device_set_flow_control(nxpdev->serdev, false);
+			set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
+		}
+		kfree_skb(skb);
+	}
+
 	return 0;
 }
 
@@ -1256,7 +1264,8 @@ static int btnxpuart_receive_buf(struct serdev_device *serdev, const u8 *data,
 		nxpdev->rx_skb = NULL;
 		return err;
 	}
-	nxpdev->hdev->stat.byte_rx += count;
+	if (!is_fw_downloading(nxpdev))
+		nxpdev->hdev->stat.byte_rx += count;
 	return count;
 }
 
@@ -1289,6 +1298,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	INIT_WORK(&nxpdev->tx_work, btnxpuart_tx_work);
 	skb_queue_head_init(&nxpdev->txq);
 
+	init_waitqueue_head(&nxpdev->fw_dnld_done_wait_q);
+	init_waitqueue_head(&nxpdev->check_boot_sign_wait_q);
+
+	device_property_read_u32(&nxpdev->serdev->dev, "fw-init-baudrate",
+				 &nxpdev->fw_init_baudrate);
+	if (!nxpdev->fw_init_baudrate)
+		nxpdev->fw_init_baudrate = FW_INIT_BAUDRATE;
+
+	set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
+
 	crc8_populate_msb(crc8_table, POLYNOMIAL8);
 
 	/* Initialize and register HCI device */
@@ -1309,6 +1328,8 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	hdev->flush = btnxpuart_flush;
 	hdev->setup = nxp_setup;
 	hdev->send  = nxp_enqueue;
+	hdev->hw_error = nxp_hw_err;
+	hdev->shutdown = nxp_shutdown;
 	SET_HCIDEV_DEV(hdev, &serdev->dev);
 
 	if (hci_register_dev(hdev) < 0) {
@@ -1317,8 +1338,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 		return -ENODEV;
 	}
 
-	ps_init_work(hdev);
-	ps_init_timer(hdev);
+	ps_setup(hdev);
 
 	return 0;
 }
-- 
2.34.1


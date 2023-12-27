Return-Path: <linux-kernel+bounces-12036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7D381EF32
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74AACB215D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427F34500E;
	Wed, 27 Dec 2023 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jY9IuDPo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1113044C84;
	Wed, 27 Dec 2023 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYQTjF2ErhUrA10v0C5fds9YE/xEMVxu1gqdwTZ5rIwEIe8Rh363Urz4WX3FksgKTk5+UnQnr0xg2+e19mcf3akBXDmNwnoqwjqCcXNk/VvVfWHG0bWT/Myjld1MhtimM6vvG0UgAbjmONnYsRKYR40DjjW1c9tovlgIz34pcZ97B4lqnHupDYM+SxYcq94LwmzBX0O2LabMU0I3AzCfmuTCddaCOhQhpp3MYTtZmS6lM6l8fwWwBbTFKewThX9UboTmZai1LNSGQN7weI/dZwmcKnGsCUCVbt9T/omKepcQxg73cxIPLRmGIhh4H3FfSLrovYqnKVp0ebDdDVaDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQNrOp9dM3EokswWNu0Lf4HPUlWTkKhPogX0NYX/4Ck=;
 b=RxLmSNPhDHDDCbzhxKXW9x5GgdSBHTCaVhzBZHiWWR3310ElHKMSX0LD1hq4ui4nMCwK2nuXHBRoIN11U6kn26A9z+PhKRnarUy7aZUrsm+E2df00kzv0LsU7CHsnhYK2qmdwHPysstj4Rs8p7j2xOU52dopGXcxR6louKKUpmiyivC2BFWLIyZ0+FxZZTLLBPDoJPR5Zz3iUz100ByBj2SnrpheQcXDYZT6eD0EYHbiEJzsrG0DL8zkknFjEacUFjm3Pp5udlAy/S/WjFAt55VsWF/zbs3GQWR79ZQbxfrV1DxmtQ/UrfsVhq7BjzkmzYKjR1OgGQZAcGj92/dI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQNrOp9dM3EokswWNu0Lf4HPUlWTkKhPogX0NYX/4Ck=;
 b=jY9IuDPo6V/cp6EylOP4pBRVFnXUR7qpbzLw8KeEooNQ8yvPuFQgpPQHA1cWt0nHi+WMPAYzWqugXrQh76zNjpskzurcJCNJXE6xU9noenwQhZh82nKrkVh0uSrd3Vg+naEkTi9Ry4CeJLBQvJ5pl4rx1429aDBZZLE3ywNmCd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB7668.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::10)
 by DBAPR04MB7287.eurprd04.prod.outlook.com (2603:10a6:10:1a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 13:28:28 +0000
Received: from AM9PR04MB7668.eurprd04.prod.outlook.com
 ([fe80::27c7:7617:d343:6204]) by AM9PR04MB7668.eurprd04.prod.outlook.com
 ([fe80::27c7:7617:d343:6204%3]) with mapi id 15.20.7135.019; Wed, 27 Dec 2023
 13:28:28 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com,
	rohit.fule@nxp.com
Subject: [PATCH v3] Bluetooth: btnxpuart: Resolve TX timeout error in power save stress test
Date: Wed, 27 Dec 2023 18:59:27 +0530
Message-Id: <20231227132927.3938396-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To AM9PR04MB7668.eurprd04.prod.outlook.com
 (2603:10a6:20b:2dd::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7668:EE_|DBAPR04MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3dc570-c2ff-4639-7227-08dc06dfb5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ezTjL/cB3Tl1+ZQ+CDGSEPtLusnJ3plkNAlPOMvFsrLGcdBD1S2sZ3bxGSjQj6w3DcYN2k8gPWiFAJU7erAm9QIN5g75KJ1nYHR814M2+5day4YC8Lge6V3aYRutlcFhdLqcsyEl1wkRRpzOoCk2KmnpzKKSc1MfDY0CdtqmVeO6CAKN6t3yx8Tw035P5P5aiu591WtnSiZUfMp/b1EM4ou8yQj7NzQZScBdTjFUlDiN2yIooqnxFL/6EhCCQWx4Hp7n+Wt6nekRa1esy0fZplqAkIEnxUhtRd8MzIa6sbxxnUq5SE4y7O+J02HhvLHbNhvL5YPvMHQ0D2vsDmgZjvwQXgzrCGkndyNVTjsy9m6/bRPaU22eqwMMWZ9dLZeS0Ofh3j7UYsUKylcWG75cagjb24nHxR5YsYVGqCExuZv+ZZrzBOEvz24UsmhAPBjFGgu4HUFeXCUP+Bd6Z0yBktxJXwS524jT7tn9h3gxOEk9YSIR7d/4bVxtn/OoO1Qk5QJK+DnvlO3JXNFPC7NlQtkVdTOvb9DiRbcK4JADuPaEku7U1V5GVRQ/rqyNZMzwLHUMe28AM6MjYrEWWwZE7AjYFjfK7HHFL6WpPee+6zpLUrCSINmE7WtG7heYuFpg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7668.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(316002)(8936002)(8676002)(36756003)(478600001)(1076003)(6506007)(52116002)(2616005)(86362001)(26005)(6512007)(38100700002)(38350700005)(83380400001)(6486002)(41300700001)(66556008)(66476007)(5660300002)(2906002)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I4lEDDfiRlrILWfBwXt6bpeY5ALZbUq4e+77eN34E67WBYNj64MWvfmId7lU?=
 =?us-ascii?Q?0J0Rr2jIQ3qVLW6m6K1p8+AXCY1AC1GUYqWYZP4KAKyxxtTa2RWoLmGWSVmx?=
 =?us-ascii?Q?t6tL0m7SgfdqIuStzfgzxllR7Eeqo1m0kTgnOm+Z5febaEUKckIeFP+Z/49G?=
 =?us-ascii?Q?T4whtnAbpHxt/HAQ7uDTMco9v+wAUNNVViQaIa0XK1ezk4FTXCPdzEOuGCNO?=
 =?us-ascii?Q?1tZ8gmkT7cd2agAQYkTuUGiesG1P3YCPyhksaJuxRCfTL9NrP/WvO0spAvSZ?=
 =?us-ascii?Q?gKbcNjS8TLrhk5UqyfMMebNLM1bSJ5g1KrL4jLbwVat3Ha+m7LQIoH6IYgjF?=
 =?us-ascii?Q?jirQRDh/rVxIqYTsbD6I3dsKtD5t7dtbuYeuZ4bHmyQVkbJfIhMgmkgjFtOo?=
 =?us-ascii?Q?iSVlKYGVGZt3xss1EajTJdMql8XEGBZqzys4uMKZycxAJqkYFemkqmSsXh2+?=
 =?us-ascii?Q?dpmfC+h9WSW4MfHWafH52UR7SvFDKqCCWmbqAKZEIrxtBsyUbZrnDkF3TD9c?=
 =?us-ascii?Q?B6v9ETylATdK8bLI5nVgidR5aN87TL0/+baY+1ujNgrpCJPykXmEVFgUV7a6?=
 =?us-ascii?Q?fYme+tQRoWMttbW63cItKoMWckgktXczVUWEo/rtm6JwccqzOFHQe0YD54dJ?=
 =?us-ascii?Q?ncUcBF1nRhp5QbMd90NeI2JAvRiDiha5QnBpj7Pv1HLGgPs8+LBpVOfdvdNr?=
 =?us-ascii?Q?0clERzRQDrgcdg44VKfjKT/7CkP0+DcD+yaj0TFFcYR8F6JxVtqhb4LoKlpF?=
 =?us-ascii?Q?O+iY7vzK9vDWyU1u6fgjgA2kmKgbviVKGyV72uXpGCHqMK8vm0VHwkNAx+CU?=
 =?us-ascii?Q?3lnrl7tbOFIhmCPrfCOLaxAsBJoSyQx7nmSLTy0url3Ou8N7CeIKkQn65hm7?=
 =?us-ascii?Q?zyACKP2S3R1iozdm3x2bXGPa1f3H3EbZe1MBZaXTw6Jsx+6BmGNHy0bySj6H?=
 =?us-ascii?Q?w4QBR7jArgNZZZCQSR57L6lKVaaTSOH3YdlGi46C55SIpsxyXn6se5EVR/KK?=
 =?us-ascii?Q?TrB7COqkPAXXcTxPZH86O6wVmvtNLPy2CBnmEvFceVn8BHj5nrt0YVcjUWiJ?=
 =?us-ascii?Q?vKwTGvxt6aCNPoSa5UKztt9ef7DKzg7q69aDJ+5d+Pd9YZorDZtMwOFaHPkh?=
 =?us-ascii?Q?U230syHQj+MbPQQxXuBnnJf/7y88iGzLJUCoFpSe4+sdhOH3w2vOv3QgvBHy?=
 =?us-ascii?Q?FALSUcsKZxGSgvcB/7mmjyay/vY/Wxmp/B14r3lTcOxjZ5y5rbfXrTNS2Dq7?=
 =?us-ascii?Q?CIoRgqPMjmow56OfYqZL3/MTfzrI9NgW1DnrN+7HdqmduRrwMc19WRnjmWlR?=
 =?us-ascii?Q?6jiqmAf7hmux8N5gl/obgQVFaKhJkYFvJMVAf60Fb/I7fD6utNf3a9ZhjFYk?=
 =?us-ascii?Q?5iVCKLNx7Pcswu13h080yRXx5nOd5f96dToFsqin3AZRoi9wMq57vtZaLsPP?=
 =?us-ascii?Q?NUevpMFZLWtR5bIRJjp2e4NqNShHExv0qmgpMpetqILzp86OViP63wryDbOE?=
 =?us-ascii?Q?VFA/af5pA8WHCw7s509F9R0eQRIJbPxuVSM2C9i7G1iE0K9Yy0IUGXMF9Jgi?=
 =?us-ascii?Q?TSMC06dDMO0PgHr3pe6QL92aTNJuzxaCd6snBAsacLhuAngh7aVsaC1OqdAT?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3dc570-c2ff-4639-7227-08dc06dfb5af
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7668.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 13:28:27.8389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKPfHBVUu8o9bUM+Qc+9L8rQnwBrub8SKY6yTeGyNxoQYnqrhfZ2shQFmk2+qbYGmFpxhTyYok6mGSfSAyzVqAva9zg2sssXLEzPHuSC6ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7287

This fixes the tx timeout issue seen while running a stress test on
btnxpuart for couple of hours, such that the interval between two HCI
commands coincide with the power save timeout value of 2 seconds.

Test procedure using bash script:
<load btnxpuart.ko>
hciconfig hci0 up
//Enable Power Save feature
hcitool -i hci0 cmd 3f 23 02 00 00
while (true)
do
    hciconfig hci0 leadv
    sleep 2
    hciconfig hci0 noleadv
    sleep 2
done

Error log, after adding few more debug prints:
Bluetooth: btnxpuart_queue_skb(): 01 0A 20 01 00
Bluetooth: hci0: Set UART break: on, status=0
Bluetooth: hci0: btnxpuart_tx_wakeup() tx_work scheduled
Bluetooth: hci0: btnxpuart_tx_work() dequeue: 01 0A 20 01 00
Can't set advertise mode on hci0: Connection timed out (110)
Bluetooth: hci0: command 0x200a tx timeout

When the power save mechanism turns on UART break, and btnxpuart_tx_work()
is scheduled simultaneously, psdata->ps_state is read as PS_STATE_AWAKE,
which prevents the psdata->work from being scheduled, which is responsible
to turn OFF UART break.

This issue is fixed by adding a ps_lock mutex around UART break on/off as
well as around ps_state read/write.
btnxpuart_tx_wakeup() will now read updated ps_state value. If ps_state is
PS_STATE_SLEEP, it will first schedule psdata->work, and then it will
reschedule itself once UART break has been turned off and ps_state is
PS_STATE_AWAKE.

Tested above script for 50,000 iterations and TX timeout error was not
observed anymore.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Add 20msec delay after enabling UART break, cancel ps_work when ps_timer is restarted.
v3: Fix build error. Keep a common delay of 20msec for UART break enable/disable.
---
 drivers/bluetooth/btnxpuart.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index b7e66b7ac570..9131615b6f76 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -126,6 +126,7 @@ struct ps_data {
 	struct hci_dev *hdev;
 	struct work_struct work;
 	struct timer_list ps_timer;
+	struct mutex ps_lock;
 };
 
 struct wakeup_cmd_payload {
@@ -317,6 +318,9 @@ static void ps_start_timer(struct btnxpuart_dev *nxpdev)
 
 	if (psdata->cur_psmode == PS_MODE_ENABLE)
 		mod_timer(&psdata->ps_timer, jiffies + msecs_to_jiffies(psdata->h2c_ps_interval));
+
+	if (psdata->ps_state == PS_STATE_AWAKE && psdata->ps_cmd == PS_CMD_ENTER_PS)
+		cancel_work_sync(&psdata->work);
 }
 
 static void ps_cancel_timer(struct btnxpuart_dev *nxpdev)
@@ -337,6 +341,7 @@ static void ps_control(struct hci_dev *hdev, u8 ps_state)
 	    !test_bit(BTNXPUART_SERDEV_OPEN, &nxpdev->tx_state))
 		return;
 
+	mutex_lock(&psdata->ps_lock);
 	switch (psdata->cur_h2c_wakeupmode) {
 	case WAKEUP_METHOD_DTR:
 		if (ps_state == PS_STATE_AWAKE)
@@ -350,12 +355,15 @@ static void ps_control(struct hci_dev *hdev, u8 ps_state)
 			status = serdev_device_break_ctl(nxpdev->serdev, 0);
 		else
 			status = serdev_device_break_ctl(nxpdev->serdev, -1);
+		msleep(20); /* Allow chip to detect UART-break and enter sleep */
 		bt_dev_dbg(hdev, "Set UART break: %s, status=%d",
 			   str_on_off(ps_state == PS_STATE_SLEEP), status);
 		break;
 	}
 	if (!status)
 		psdata->ps_state = ps_state;
+	mutex_unlock(&psdata->ps_lock);
+
 	if (ps_state == PS_STATE_AWAKE)
 		btnxpuart_tx_wakeup(nxpdev);
 }
@@ -391,17 +399,25 @@ static void ps_setup(struct hci_dev *hdev)
 
 	psdata->hdev = hdev;
 	INIT_WORK(&psdata->work, ps_work_func);
+	mutex_init(&psdata->ps_lock);
 	timer_setup(&psdata->ps_timer, ps_timeout_func, 0);
 }
 
-static void ps_wakeup(struct btnxpuart_dev *nxpdev)
+static bool ps_wakeup(struct btnxpuart_dev *nxpdev)
 {
 	struct ps_data *psdata = &nxpdev->psdata;
+	u8 ps_state;
 
-	if (psdata->ps_state != PS_STATE_AWAKE) {
+	mutex_lock(&psdata->ps_lock);
+	ps_state = psdata->ps_state;
+	mutex_unlock(&psdata->ps_lock);
+
+	if (ps_state != PS_STATE_AWAKE) {
 		psdata->ps_cmd = PS_CMD_EXIT_PS;
 		schedule_work(&psdata->work);
+		return true;
 	}
+	return false;
 }
 
 static int send_ps_cmd(struct hci_dev *hdev, void *data)
@@ -1171,7 +1187,6 @@ static struct sk_buff *nxp_dequeue(void *data)
 {
 	struct btnxpuart_dev *nxpdev = (struct btnxpuart_dev *)data;
 
-	ps_wakeup(nxpdev);
 	ps_start_timer(nxpdev);
 	return skb_dequeue(&nxpdev->txq);
 }
@@ -1186,6 +1201,9 @@ static void btnxpuart_tx_work(struct work_struct *work)
 	struct sk_buff *skb;
 	int len;
 
+	if (ps_wakeup(nxpdev))
+		return;
+
 	while ((skb = nxp_dequeue(nxpdev))) {
 		len = serdev_device_write_buf(serdev, skb->data, skb->len);
 		hdev->stat.byte_tx += len;
-- 
2.34.1



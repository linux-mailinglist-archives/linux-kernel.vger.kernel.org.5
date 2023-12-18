Return-Path: <linux-kernel+bounces-3325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CC3816B08
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667BA1C22575
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B292154AB;
	Mon, 18 Dec 2023 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rbs0h8i4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C080614A9D;
	Mon, 18 Dec 2023 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VugtPFp3aKuIFOvPib3kFhoQL8MhDWBIlZKEVmO3ZC4MkdAxR65z8/Jo6cgtj7EcQsW79JE3Taf5vanP1CV9Rp4PaWAH4vbc7MsAIwPdYXQYWRjmnvyVqL4FLPnzo3CyzS+ZhEcLnSHUZ7muQJtRWqhA025RxjhszETV7POHRws2hqkfviyKTuhEsDM8H9FdghnO+akB3ssWLCQrdfl7I1Ccht00qZ/l6ZG/eAhJ2G9TqES1B45w1fM1xdqxk9etZJRP3TUPHQ1rMqcBKqjlCjDzceRGhOnozMu69QIR09lO6sykDMGkKgEWAFuFDixgBZsdQGOz2mkBteNUXdvuCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rX96sfRouqN2nRRKvOYxxMLVVfEwa7SIe0+kkU0vkI8=;
 b=DDSu+63C12AllYWAE/mIW64rQ/cdCjU86O+IAtib3+ZRcl8sZ1l/KziygWnbLIXZy3gvWhoYkLXvFdBCk9/CjoycgRi+107IqHVU5xxb/AXU3FwHtuDvVvHr6cQltj6vBQ2LUSNCRfAxPha+HdGtS63QG1WQzwyGx5kwqCgV6Oy/vKn1fKB+JJ0PvfAw424FCavVFBfSEqKohrD2DX3ZVNaI+MAaby0acrJ+jByN8Yqa7rF3nII8JFzx40LC4r4prIHYn5S0kk6MJ3iwq/qUwBhPagzaKSP5AHMVLocGfz+kBhqk6Hlokleb4S+k+KGYXg5AFjoIk+IL7MCXgA9DYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX96sfRouqN2nRRKvOYxxMLVVfEwa7SIe0+kkU0vkI8=;
 b=rbs0h8i4TlLJUUNBC3uVbNNQe4Akl4RpNxdXH6aGXs8V8UqnzHBoIcSP3PFgaCqxeEEi7Dv0wNIiRrCE6sLj0k7WP1x+mu3yMPRXvu1RykV+jQ1ekPCp3PHhX/ccfkMy6jhcA4acVDGwah75bCil2sTcUsNuhYtkx6xYwAOLCVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB7668.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::10)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 10:26:23 +0000
Received: from AM9PR04MB7668.eurprd04.prod.outlook.com
 ([fe80::27c7:7617:d343:6204]) by AM9PR04MB7668.eurprd04.prod.outlook.com
 ([fe80::27c7:7617:d343:6204%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 10:26:23 +0000
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
Subject: [PATCH v1] Bluetooth: btnxpuart: Resolve TX timeout error in power save stress test
Date: Mon, 18 Dec 2023 15:57:20 +0530
Message-Id: <20231218102720.3816166-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::25) To AM9PR04MB7668.eurprd04.prod.outlook.com
 (2603:10a6:20b:2dd::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7668:EE_|DU2PR04MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed82c13-29dd-4eec-c1f0-08dbffb3c8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WTRLC+C3FIHEiOE6M3AdhAh8j2b0Y9hN8LhjAPlH9vfZxloENKmLs0vmGtecyH7s6YZlH6pn/v8aidTzJSqvb1dpo4YShqSTTC82Vgs7FW6uI2VDVtDp52eGYJ8ie8dDqoC2dwkFJBVlH6y7q4sNnaw65PnpCDTu/s04VFiCZKtobMKPL6NaBzYBAjgisiVNn/Hry6r3RD7Bq6lCbU/yN5SGurCgbYhs67zfNMAFXqmQjwSJKr0t/pWjueWqPRCi31qiTnqmyQtUagx+5aLqQ0illeZbRHgBE2ZQjFuT+xfa14CMiw8Wa0Di8vYGulQ4tZSNq/coioxl8rzL8tmcyfArTKKrIVhLpzqCL6thpvwmbPz1SPTjTWCxaR519Kpc4rbybxnwcrFPZoqTksX2Q397qI6Jd+IDdhE33u1xkCw60w5NyCTcMub8g/WVqyiS7ZGH0HZkoJyk9wd6wV6QcvMLsKNLXw8MeiSf34RXrU6lJAJnqOaBP0qHG2V1gW6P1s2qqvGsbncn2Yr5myPva4pC0g6VHARbGXShr3daYQHAfQrMWmPe7kRCLbBiZ8mPFuYXEbITmGCM9ilUhb/G46RAul3AlIIQh9fng6Wr5IV7ADH6MhBeFrMh+g16Kn6w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7668.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(83380400001)(52116002)(1076003)(2616005)(26005)(38100700002)(316002)(478600001)(66946007)(4326008)(8676002)(8936002)(41300700001)(2906002)(6486002)(6506007)(6512007)(66476007)(66556008)(36756003)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eleRPweb290WHuRgujzONBPm4AVRu1Ruk8Bix5/9wISDq4nefuoxJssu9EDK?=
 =?us-ascii?Q?lhIow65qtG3amdktJorVv85pyKTUNvJt3QDRf+ZBz/iMtlW0pN7geoAvVWDX?=
 =?us-ascii?Q?K08W7ULBfu56uMIKTQvG0VSpLmd2eLk+yk6sjeWuOzluC4EzKaE2DzK/YYEy?=
 =?us-ascii?Q?q6FDIuNxBu7WVjKxXVcYOBKjfAV5b9Wek8Hsgxzd7PHJzuSQFN5fqT7Ui0R3?=
 =?us-ascii?Q?JS04fe8U9sozeN1hFkjgckuZjDtSSpwirJa1ccd9x+XjEaKI88eaQo6/8vJc?=
 =?us-ascii?Q?wOJN7dTAdejpMxyk4xCwsBD4t/thsdfhJkOznaXkMvEhwBXRr9HTaofpY4RI?=
 =?us-ascii?Q?F4dywfHH9S5fukjnXsxkt9Se2Wk4MpnDii7ni1d8SdVLjNHgqdawzRmJZSw5?=
 =?us-ascii?Q?pKJXXj42g85dCjQlk4nNAC3p3dWzkip4GEXtDg7z2CB1jKwlZHw8oQFc8R1O?=
 =?us-ascii?Q?pL7qT3ZeJdlFScBoZKHPqmrIF26GTFXsN4E+sDO8Jhv/d0xqHXFHG7/QVBzv?=
 =?us-ascii?Q?v/+XwjLUnhtFUlZr897H9RiFU3D1TcIudiMWf2rWdrPFNdy5TB05OuNr7+JI?=
 =?us-ascii?Q?60y/6qV0df9plchBDRjzB14rhkB70PnjgpNT9ee/35vPrqQj+3CLSwdXLcXx?=
 =?us-ascii?Q?lDqG6YbI152Ua2vlnm3ZDOAut/N0jcrTSQA7uzeRE3/l2jhAH4Vrdn5uhej8?=
 =?us-ascii?Q?DddrAw/JGJBYtQDSoOeRgYncYHjchoA09WVFlJpX1UcpHWW74L2goPWMsJJv?=
 =?us-ascii?Q?U/+IxBATRg+ohARzFa3Oa83bwsZmuNT5ia8F4y85mLbrd7R+Zyw42FSe6c7G?=
 =?us-ascii?Q?CSQf+VZn1FCO3iBOGp2/OD8q80k5M8g/FIPnnAoHdA9TVx1IWjqlQZo2e/Hz?=
 =?us-ascii?Q?XapZC7grg5hblgE6eLdmoSBAr8wyTPhxNSJCQP0+GzX0NI7XjkvKHSPETJrx?=
 =?us-ascii?Q?1zE3Nl4hMT7y4NaYxnZwxIPp9heDnCJgJ6BMNk1dOTB+rBHWaN8kcv19C/Vt?=
 =?us-ascii?Q?HDQYRk3szVnb+8a+tIOGYUs9kBImKEEJbC6sctcJQHCWTA16RV45GXnsjTnE?=
 =?us-ascii?Q?0LgSdxhZ5recf69+rXZtHQvqaG80CvTc42LTcIjFCw6+CpnRZ2r2+HuOkPCI?=
 =?us-ascii?Q?kS9LwX/mKeDcuwL+wyBrgVYK0/7LpMR3Ebl/889igCUXCwe9rVPfoWjdrxHH?=
 =?us-ascii?Q?QLVcUrmKt+a0jmFgJxaStkyZqegpu+NTJbqN+iMg81pgDfaPfhhhOf99xaOt?=
 =?us-ascii?Q?JunKlKy1kPsW+YuiahVQ6jVn6JExQzR1XRDZvIIAZJJG0toBR0ToHx25eTkv?=
 =?us-ascii?Q?lFjZ6XRU14Ki8kjXFYItW+PEVL1LlvCRs0b4g8LzyZKKEAu/ho8QXf/SXlZQ?=
 =?us-ascii?Q?6TumgI/JYrqeEq3XjzaUt2TUwkA4qM4jZf02qBrfOeOs2p70Sv0HU88F1FqL?=
 =?us-ascii?Q?4l6XCoLFcdd60EcELOXS/Q8ld7h5QlVJWYjHIi9toEGuiyLV7kySp+xxLCtt?=
 =?us-ascii?Q?ZLRPoeQGpXMdXYCD3PlCxbMo+nG4o8IJ49UTZwPa+yoQJmZUn+oyv54+yOcc?=
 =?us-ascii?Q?+PCubN280v3ivVmKnEXznjryLD6IkG1BPqrrno4I0eV8RbIcFg1VH8yS3NDj?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed82c13-29dd-4eec-c1f0-08dbffb3c8b8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7668.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 10:26:23.7770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ez7hILKzhChI059og8nxbIHTg/s2VGzWriaE/ikfRBgWkyi9JwM4MgHuICTrrbk4MXqUyUt+CW0crOE+g467jdAKhs++LYeLiQtJ2/Ure+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050

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
[ 2206.497227] Bluetooth: btnxpuart_queue_skb(): 01 0A 20 01 00
[ 2206.498239] Bluetooth: hci0: Set UART break: on, status=0
[ 2206.503283] Bluetooth: hci0: btnxpuart_tx_wakeup() tx_work scheduled
[ 2206.503299] Bluetooth: hci0: btnxpuart_tx_work() dequeue: 01 0A 20 01 00
Can't set advertise mode on hci0: Connection timed out (110)
[ 2208.514238] Bluetooth: hci0: command 0x200a tx timeout

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
 drivers/bluetooth/btnxpuart.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index b7e66b7ac570..a68d10771c99 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -126,6 +126,7 @@ struct ps_data {
 	struct hci_dev *hdev;
 	struct work_struct work;
 	struct timer_list ps_timer;
+	struct mutex ps_lock;
 };
 
 struct wakeup_cmd_payload {
@@ -337,6 +338,7 @@ static void ps_control(struct hci_dev *hdev, u8 ps_state)
 	    !test_bit(BTNXPUART_SERDEV_OPEN, &nxpdev->tx_state))
 		return;
 
+	mutex_lock(&psdata->ps_lock);
 	switch (psdata->cur_h2c_wakeupmode) {
 	case WAKEUP_METHOD_DTR:
 		if (ps_state == PS_STATE_AWAKE)
@@ -356,6 +358,8 @@ static void ps_control(struct hci_dev *hdev, u8 ps_state)
 	}
 	if (!status)
 		psdata->ps_state = ps_state;
+	mutex_unlock(&psdata->ps_lock);
+
 	if (ps_state == PS_STATE_AWAKE)
 		btnxpuart_tx_wakeup(nxpdev);
 }
@@ -391,17 +395,25 @@ static void ps_setup(struct hci_dev *hdev)
 
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
+
+	mutex_lock(&psdata->ps_lock);
+	ps_state = psdata->ps_state;
+	mutex_unlock(&psdata->ps_lock);
 
-	if (psdata->ps_state != PS_STATE_AWAKE) {
+	if (ps_state != PS_STATE_AWAKE) {
 		psdata->ps_cmd = PS_CMD_EXIT_PS;
 		schedule_work(&psdata->work);
+		return true;
 	}
+	return false;
 }
 
 static int send_ps_cmd(struct hci_dev *hdev, void *data)
@@ -1171,7 +1183,6 @@ static struct sk_buff *nxp_dequeue(void *data)
 {
 	struct btnxpuart_dev *nxpdev = (struct btnxpuart_dev *)data;
 
-	ps_wakeup(nxpdev);
 	ps_start_timer(nxpdev);
 	return skb_dequeue(&nxpdev->txq);
 }
@@ -1186,6 +1197,11 @@ static void btnxpuart_tx_work(struct work_struct *work)
 	struct sk_buff *skb;
 	int len;
 
+	if (ps_wakeup(nxpdev)) {
+		schedule_work(&nxpdev->tx_work);
+		return;
+	}
+
 	while ((skb = nxp_dequeue(nxpdev))) {
 		len = serdev_device_write_buf(serdev, skb->data, skb->len);
 		hdev->stat.byte_tx += len;
-- 
2.34.1



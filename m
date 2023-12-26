Return-Path: <linux-kernel+bounces-11487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB1A81E71C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBC11C2111B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790754E1D5;
	Tue, 26 Dec 2023 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ACvShQe6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180BE4E1C9;
	Tue, 26 Dec 2023 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVEudCRAASt3NBQdeendYJyBx/c0OzupBFsOaa8XYmRu26/fn9VgJQ9dTpRRLxUgTKQG7FL45ZiPPwBCZeQHSyA90Z4qbJZfzeW6KO5tJhI0R6BjoEEqKd83L/Kr5Dm7HsMxLE/EzQ2dD9RkTxKjj4d3jxwPJld8Rhdj2IY8LoINVGC4tjweaABkObV3EWzCiPRfSShpmL9kmBJrcfB6kr4djesnjfjyhvJAGOERQNFMvZHXMJN0YUSwVDfJXxwnF+82z/KVSZliwKKR7hLna0leCaLNcxBg9QtrGLIY8PbJezXHdz/bf5KDh548zmPvIP1BRph9oRN9H4HFRC2cgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zK1KCjsVrkCgFA/jR7sIzHP7UnXzGQo9wvyxKH2Y6ng=;
 b=AnVwhxoPr9L7ytIW8SjpsP8z937KqkA3pWsc2tjXx6STCu0xutsexHLO6XJ09guRW6y5I+Po2AKCUQNA9E320uiMlJZxWiQKDyTSxh+ESkH1M96MgtvCqVw83OrkBPDYUSaGix5MnOiXwaLg5jnErypWZ01G5yxs/rX7BSFCZoo6J8AP8uTcQfcpa+k80ddkM4nj8TMk61OpaWSBiZ0FAShgkYn7qLvgsByOhxKpkUbLAZMXz7ES0tFhD4VGoWlprqSVbLojT5QMl0YOtlV9z0hCnnnM0bkQd+ZXY5GZ70rbzXcdN1f5RLyJFH9REHmJ228oQ5OvujqIF1GJeoZGlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zK1KCjsVrkCgFA/jR7sIzHP7UnXzGQo9wvyxKH2Y6ng=;
 b=ACvShQe693FpQt+8Xdr0HjEfJd+zq52rE0d3WFyN5cIVMPwsMSPh4XhicWHmzKHnfE2YpUNHEMBrFohzYvfH+z/dgSpsPLYA/Odzu2zIgbhSjHVtRb8C2AcH8DJZLrsYjXu250BGCS2uqr1y+rMtDIqp9LGrnbJMLzNWwr1OpEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB7668.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::10)
 by PAXPR04MB8206.eurprd04.prod.outlook.com (2603:10a6:102:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 11:30:11 +0000
Received: from AM9PR04MB7668.eurprd04.prod.outlook.com
 ([fe80::27c7:7617:d343:6204]) by AM9PR04MB7668.eurprd04.prod.outlook.com
 ([fe80::27c7:7617:d343:6204%3]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 11:30:11 +0000
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
Subject: [PATCH v2] Bluetooth: btnxpuart: Resolve TX timeout error in power save stress test
Date: Tue, 26 Dec 2023 17:01:10 +0530
Message-Id: <20231226113110.3923962-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0040.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::9) To AM9PR04MB7668.eurprd04.prod.outlook.com
 (2603:10a6:20b:2dd::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7668:EE_|PAXPR04MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: b8977af5-0268-48b9-37ce-08dc06060539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xwzSA1LHX/BRFUEEEUJwVnTL8KTq7lOjwMmgJAFlAkifxNLrcwluH02Nq5V2PKji4agupLhL6WFVUj87tfo+plFQ41p9JUezIo6qyELAB+jPCzzyRuB+YPhaVst/ULPtHMfwOarX6a9dnxZ7OItCVcAI3OOWOUkdMMVa31PRoPfMkuY+GR9ej5Z2g5DI0TBKb+1fq4ie4scAHPPXYZaxwWUkepf9k+RgT2A7JcBRXMu6RcbiieNaBXLP8+U5rw8x+u9tYFEincHNskBZPE/lEzVfN7u7YFWbkFWCm827Cfu0rXozDQRBDADhYN9UQ/9+ACCDxhJSjf0EUmaaNoNY8mZNqLlRXT37UaDTs9dO1q5VVokhd7Ss/b7jYGbKMq89ObRMMUEZcPEP8ci8apW66Gtkfioq0N6cD7eL9dkJFeTr6hQCSxsUWZ+vfWYMVjAEITeVRAMUqXndRr/GNKpTTwX7XX2QgwS6hU7XJ1J5oNqI9hM3Stjqa8TVa0F8zlm87CRFXXRqsj+tYqZCyQDVeatUtP2VKsS/5suPcs+5ao6kMLBVqJAyEXrd//Q9JeP4gxltF21YOVYRCQEW2qX9MttMfocjOdgEAX6rAY+m9l6VLrVPztsD9blOB28Nt4Wr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7668.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(5660300002)(2906002)(478600001)(26005)(1076003)(2616005)(52116002)(6486002)(38100700002)(41300700001)(86362001)(36756003)(38350700005)(316002)(66476007)(66556008)(66946007)(6512007)(6506007)(8936002)(8676002)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6UwWs+5blfVY7i+UqN+IqrTDB8PTboG7v1hqxoKJoG00Y5nTE4AbzU54CRkg?=
 =?us-ascii?Q?vDOGDADD+6WHWBuBTY6WXQx8AulGbXGQTdTzCq9SNsRkApK1eDhdB+gnQ0K5?=
 =?us-ascii?Q?/AsT8v6JaZv4mkaKBOx7uCh5SaQw7I2BSaWB5VkZqkDiZaIO0L2pW98q6W6y?=
 =?us-ascii?Q?wyMtN3078vYl7yJzjRabvBzvP0u4lH9vKD5Opf4JnNZ893KORGPIBT3Chj4I?=
 =?us-ascii?Q?vrSGNLSxreHCNPUUTvopuY0Y6ifmtrxQGrmzXPdus76Xk13KHP68dYuhn8ZK?=
 =?us-ascii?Q?N+L+JoGZ88iLU930TdYjaMIBUVMfDTua5oMxkrSDFUlA7QIRq0xPBcgRTB0z?=
 =?us-ascii?Q?UAJ2rDahkbiCoPNLD756UIESgXkkNuA3N90Oa67w3CFzLj4n3c5qmaSuwIAr?=
 =?us-ascii?Q?srG3W4yeivvWLZ+pFj/NFR+j+4aGlIZALctvoVWGLExFQT86uslPWRelS3Sl?=
 =?us-ascii?Q?lCH/asaA93ptCExYaFr3WcoHM/8GMHkJYXHv7AC9bQqMF+cTHnr/WeCtA1ts?=
 =?us-ascii?Q?+UyOwX6A08YS9kEagHaeIxsdnV5Sbn8fhrMa0I4/5hXIhUBAEefmrwNdwTnF?=
 =?us-ascii?Q?0ziw/yQfzeIpdUqA6eaP+bIejqYOzhoEmijDKacji61U3MjJBTJI2duBzQ+r?=
 =?us-ascii?Q?+GH359YuBrHP8MmHxifx7EXX/7qv2aOfutgl5r8xSwg+K/SwvZ1IbI7zuk35?=
 =?us-ascii?Q?KHCXwgyTik4742UYH8NLIHXCaDL/EFmWoqIN6MW2uhlttnNsz3FTlLr4u0wr?=
 =?us-ascii?Q?VZBfYtocq+CFCu7210kfUHmDMmRtFYYY6TiIZLeifLgID4w/5GgjOzJZu+W3?=
 =?us-ascii?Q?U5jTRLTRYY0oLmFdzOM5JZGF85Kyhg/hgson3X4Z1AKzCI698VnJaylEFYdi?=
 =?us-ascii?Q?EY5GSS6MQ3Ldgl0x4+CihsvR0vwcgrPdIIizLiA7ieuBu9sJAzPPPKP9VmzR?=
 =?us-ascii?Q?bmoYQQF5X2gsJl6ef5aGIpqCFfRzuDssXQCOw+WtAFhxQ9L9PABEGK2agG1/?=
 =?us-ascii?Q?kIadp6DxSwuzw/juELC0Kkm3Vr+KXRGrg/Ti7Ytp9bYoZMENbjCo6E9uB1Lb?=
 =?us-ascii?Q?9tF2fZRs0navSDH4nZgEtIsKv2B+VZpsF7G9uRP++79YOKA2WqnnBkmcwZ4P?=
 =?us-ascii?Q?xNJidB8mq3fvb4mPcRDRio9WmIeMhOmNRoPwk6PbhLVJP9K/qM+p0YBBJstX?=
 =?us-ascii?Q?737HGukanJKG/WlOZYSYzAFHzrQ7tjl+giR94GmYlLAwAv7zOJvjCHR7Nh0b?=
 =?us-ascii?Q?3mwvAtP+FsFddSxdD68Nc4uPKwKHn8u6cf408zWIpu8whUPcwBBSrnnWsAVd?=
 =?us-ascii?Q?zW/jJCQllG+7BLuDz0i5zcHpi9gYXlpNDWq7dnLbN98vNbBk9T4acwukfiKW?=
 =?us-ascii?Q?R03s+S0dwq2SYfffHsd+vxlgjuTMohT0wqiVFwcY38cTKIyGwXdWzaynPIhn?=
 =?us-ascii?Q?gmX4+VQZUcStxUFhjnX+Sz/Vx//0jOSpOXJJdONEvSIU0UMX7P3WZWaS7WXy?=
 =?us-ascii?Q?HvTzYZHe4D2+DUfKoMOMoToZTBjGkhgA2oFJVJEG2kUWjExV3sk+KjgJ4jW+?=
 =?us-ascii?Q?sWQP7PQIOsk9Qlk0cg4qfyM0H91hXv9ZgsK+maf/xYrStmKEIqWVwViLB+wU?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8977af5-0268-48b9-37ce-08dc06060539
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7668.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 11:30:11.0009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMn+gN2KPqa35kJOEoh2eIuoP7wCjmqJpZ7L8OBMlZwCb414h1rwGOd9nsviq++Z0iNc9Ld6vJ6gPw8dfgGoTxytgIaduhCG6DtBx+BsZXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8206

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
v2: Add 2msec delay after enabling UART break, cancel ps_work when
ps_timer is restarted.
---
 drivers/bluetooth/btnxpuart.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index b7e66b7ac570..c6ef5878abe5 100644
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
@@ -346,16 +351,20 @@ static void ps_control(struct hci_dev *hdev, u8 ps_state)
 		break;
 	case WAKEUP_METHOD_BREAK:
 	default:
-		if (ps_state == PS_STATE_AWAKE)
+		if (ps_state == PS_STATE_AWAKE) {
 			status = serdev_device_break_ctl(nxpdev->serdev, 0);
-		else
+			usleep(2000); /* Allow chip to detect UART-break and enter sleep */
+		} else {
 			status = serdev_device_break_ctl(nxpdev->serdev, -1);
+		}
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
@@ -391,17 +400,25 @@ static void ps_setup(struct hci_dev *hdev)
 
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
@@ -1171,7 +1188,6 @@ static struct sk_buff *nxp_dequeue(void *data)
 {
 	struct btnxpuart_dev *nxpdev = (struct btnxpuart_dev *)data;
 
-	ps_wakeup(nxpdev);
 	ps_start_timer(nxpdev);
 	return skb_dequeue(&nxpdev->txq);
 }
@@ -1186,6 +1202,11 @@ static void btnxpuart_tx_work(struct work_struct *work)
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



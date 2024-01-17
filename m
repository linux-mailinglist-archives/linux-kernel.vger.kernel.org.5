Return-Path: <linux-kernel+bounces-28525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DE582FFAA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787BD1F258AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00777465;
	Wed, 17 Jan 2024 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NIDy3Fqj"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578AA945A;
	Wed, 17 Jan 2024 05:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705467926; cv=fail; b=U1G9ciMGGrBX7toCpQ7j6rLwLRk028EFwL7r+mC/kupdSkKf68CNYIoAxFQ2sbe+nW6WdUj7H53kEDxWsaY34hRx7n9lGGzdZJNofyEvUwD8pys2MEys64FXOvTOxCpcGHKWtXTnGtASmCAHol8vRqUHkaCJvbaevEoADAkvKCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705467926; c=relaxed/simple;
	bh=EjKUOxJkDAkN1pezcWnWrLVIs/28C8RrEiwiwaPt9r0=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=p5tKwAG4dftFqPJEKsv1ISEi3KFiJjZmFrxYpeXdae6HMp/EjsQHukWtSP++jvw1jgVb/D0khua3k33pyJq0znRVW/py8IEk1LXhnwGC8ENz4XkeGogN8ErDrmQEEkhOuu4mJ+yO7jd1pIoh8XDlFPLIyfoTb/a7cCKzcY3m37w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NIDy3Fqj; arc=fail smtp.client-ip=40.107.249.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRi10H3DuNcKIevcAKpuMUgj6Xr65o1ImU/uUOwHPWum5HZJ9GjzHzLp02LN4q006Ab593up7YgN6ZtQ/12xSO885n6ClBnKaopaXdrQ8tUU0dT3dNP6YwgnkyhA5Nd0gLxbOjMHHJYY7hSuF7NTWpjz4ATGPB4GxwNIQJJAi6V+KMLiEeaHKWprFQ5tU7Lw6IVfocCNo5GzIXGI4NmyR/hKHeujOmF8PLUg+zBP7q3aM5Mx1J6Xly3i0gZ4F1gq/GVX1BclmJKPSLCzcUFhgo4O2jGtxwAjLAF0/IulWpvdA6wD/t7g8ruTz5eBUXdntIRpO7+j/zb60Ltm9YsRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR/j0sNTSs/nJ/jAyh01CN4MzolgbMx0U8EnvQe4FI8=;
 b=fkRdl/XtbIBNSGI6gzjI5eESUWWywwQsMco+UgxrvJRDxkdujOYUa7bnVjdu6HU959CbreGQA1+QLvhAit0+nGGtexGjFZWGGSn0g1s1/hyzs2q/D1Q+PfGsP4UTnX7FXsLhOVL6YiD5k7qV5a0fuqlt7WN/I0OUfaqY+PH0Y5fAfMF42NPZXyurFzyRk2CnkKX39wdA8ECpnCtj+Dbb8LMBx5ZoUwatrZioBcz7iSZMuhM9zxiCRbNgnFv7mbfa30Xn/xvhjU/ccSA4StsW5LCbdCawGfzrH684RyioM8a9XtGAaOBvAwRyy4vjoAZyluUGEbjiTyjGVnp/u1h9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jR/j0sNTSs/nJ/jAyh01CN4MzolgbMx0U8EnvQe4FI8=;
 b=NIDy3FqjQAaVpIQ9+m3dqXp9R/J4XTI8f7MVS36Y2g59TnrEyzeTDAhBeRE9B0pc7v3cMXPsPTHlpAYYIPkZLNaX7Q3zbmjC24rmiu2cW8BKjpDp/Ign3ANgemMnhb2gJGORFx113bkaQnO10IjzLrysQxQ2qOPZSmGQdA6+o84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DB9PR04MB8140.eurprd04.prod.outlook.com (2603:10a6:10:249::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 05:05:21 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::748a:98f4:59fa:f206]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::748a:98f4:59fa:f206%7]) with mapi id 15.20.7181.022; Wed, 17 Jan 2024
 05:05:21 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	marcel.ziswiler@toradex.com
Cc: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com,
	rohit.fule@nxp.com
Subject: [RFC PATCH] Bluetooth: btnxpuart: Fix nxp_setup in case chip is powered on late
Date: Wed, 17 Jan 2024 08:35:01 +0530
Message-Id: <20240117030501.149114-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DB9PR04MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe5f63b-81e3-42ef-8736-08dc1719e7c6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 gQvEjldlIdsmAQHo3XTrTO3lBbdju6yi8x5WGzzFEzuo5dxsmmnVJDtmBfavlNfBZzmXbaM4OdzVSd4kLvxaWurIsB2GZf6GXDujVM8OLaWm2ifenXIujcoCOR1zVKWChwKhQbu3nXk3in9TRjfzp+063IBFPbzAYPQw1uf5rGaMQLufJHpnGKhm4/dVqr9VnqYHo3hEbBAquum8pGCeVrNe+UPhzvOBINA81QL313aD+9vAJwRA1Qh1w40vZSw8vWzG9illVrNRDTznsroWr6Iuo3leoFXXNvlCveSOCDKPvBlhgqprTDfFprol1WfkDDREkeZmEuBN7wRbA8sacJaPmrkw5ZVoRcweZII/lvNjVM8XWKZNsDC7JOR1R+c+oZy8q/r+S7n+6ZKIFq8la0NBrJPq0LQCun0/5V7HCqlYN8kTBjl6wkrsxG8kT8Ej3Y+Bn9SIwq+p7LoMyWeGqwMeTDPsSngc5i5OnJlKDs73M0UVWYa4YOKh+LrfD5B59qvwltSshP7ct9/7mtiCxSLBD9r2DWkCSjJFW2cMa+PtLl7wATNyNTyZvYNibWPF37CRy0S0yABTd1w/7oU6FF0aVT66+jocQlZcevTUtNM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(8676002)(4326008)(5660300002)(66946007)(316002)(66476007)(66556008)(2906002)(26005)(1076003)(2616005)(38350700005)(36756003)(86362001)(6666004)(6512007)(6506007)(478600001)(6486002)(966005)(52116002)(41300700001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?GtI4U7wVBMAZMqxBAD2Np4Baofk43KZc5AgjE1rPs9gHE5yLj/HpMejx7ANi?=
 =?us-ascii?Q?DYro9Nh8a88HIfHnv5rlOCsr1AwuwIxVRUGPZTBHrZvvaESTZ966UhMGkcv8?=
 =?us-ascii?Q?X7jnxOdhWOJagwEgVcAy33vJJMViirmWfNWPWeQ3hojlC2z7fhDkbWlkDEUb?=
 =?us-ascii?Q?MJ2Re+CnUT9DitS/3iNPTXKe/+BLT62J4iwjbJLDfnLK6sttBC0OjJCfdvB6?=
 =?us-ascii?Q?FMpTmA7xkzH2J3uYNZv0ZEAmMP4St2yMlQkuGPwmJZrk7vT3ysJVxnOnkRY2?=
 =?us-ascii?Q?9utiC74nuUvKAoCDIW/pknwneXBcq+YsB9SGyJUnY7b8u56oIc4W8MmUuztt?=
 =?us-ascii?Q?f2jiFYfg/NzzgGjNC6PkXvyGtXMfZUU+yn/SDJ2l7PwJSDVuGEqFILAzXn9j?=
 =?us-ascii?Q?5EKyyNc8jhWxn0dt5pVOMb9kNn5xiSx45w+pGyh9yLZ3QEC5rD6u1QdWa1Az?=
 =?us-ascii?Q?5h+giM2PgNyrpfTOSG9RJfeWVr8Mzc8s4ZnZVDPcYdKCxTU31KhQu2G6SzHM?=
 =?us-ascii?Q?n/1bCDSIik4l3a8QLI+FFu/zeAzxgrJubvOtj6Ibt8mNM/Zx60qE6UJ7/tg4?=
 =?us-ascii?Q?Q4oymo0aWhU0hPnYUXaIbdvf5MzsCfBozZc9JDcIjr8ZlmWbWiU1cT6bIpYU?=
 =?us-ascii?Q?So6EByKLREs/XMgCDQDBkhv5AkMFp1z6v42EIBFs9nMhZOPh4BJnXSgrGEra?=
 =?us-ascii?Q?n597A04DsZh1RMxOj7x4UOqF8wNm4y5KVg3TEaUUALNqirkMejexRQwFxq3r?=
 =?us-ascii?Q?wJ0L1EVKVPXnOEgEtBxVK2Q9quZH4cCixED2HvHiHAY9cxF5xXiNALdXCLpl?=
 =?us-ascii?Q?z1YADtgUqcKr4WE9Q8M+xwS6cdO0OwUcYqw8YNPFffuILDvtuufCmmCbWxmu?=
 =?us-ascii?Q?gyuXat9oIKVE71ZXrONBkRdtYQvb6a6U7A5f42YlApMMBRS0ft0YTZKjoUbp?=
 =?us-ascii?Q?jINvZgaAFxtOEFTFnWq/oNJf8OjK5t6LsXJJW3I0E1tsocZJkycnA/6VvXcH?=
 =?us-ascii?Q?ZaHsYQ4MkrmzkKaz1ELaamTVtmaxLwLCNzkfMD5x0JsXfILIMRPZAkk8iSJz?=
 =?us-ascii?Q?bVe87c5iBiksxeF6Rmu0C46UjistfryE1XSoy2c3udz9lwvU8IML+us9sqlq?=
 =?us-ascii?Q?RMl2RBoUCnhtXKIgTTzvry8bReiJfWmzCJ3Rrwm0QRs75MXcePpH7Y5UBQdG?=
 =?us-ascii?Q?oq5Oi47/hs8YYnKgUdk5st8o79On//5rblSwiKp7o8SNuA+xNwU+Kfaa3SS5?=
 =?us-ascii?Q?CpdH49/DNoqidK0MFGLdNpFwhXEi78NmR6F5DNWevZTp2EmPDTLm94SkHkG8?=
 =?us-ascii?Q?Akdb6G52YhbN6YcBLR4nepbRk9h+wpshlBjj9CMKU+3P3HV22oypw/FMtyfA?=
 =?us-ascii?Q?DuaAARnoq6wRYkMWG2HeimMN9v9C4zkOQ+5TtiRBlF5ZIiYJ7F7THJa8sf3t?=
 =?us-ascii?Q?sD0sjGaE2KyTRcFbpW7Z/npG879++tgO5ndxwmZ7+ko+ZNT6bekE2kVop5lx?=
 =?us-ascii?Q?E2Tjp/0OLt2JZLN9N6ms25fbZ7nREQHuolAhMa59UeZiiOssI6lF6FHKfmBC?=
 =?us-ascii?Q?34tGQiQJA4KSzt4AI35BiOvxQLRN1lG2bdYugZYcs/BTzPP5znh7nw/L6IIv?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe5f63b-81e3-42ef-8736-08dc1719e7c6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 05:05:21.1076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2HX8xEXnWKJhtQuqA9qZ+YCxiFVXYFYIyBx71MX8UrgoPrxnKombT3Z12L8jYRfd+9/aJ7aAn++uH+tTMFzv0z07qbHV8pdGBpPIESnTTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8140

This adds a setup retry mechanism in case the chip is powered on after the
btnxpuart driver is loaded.

The NXP chipsets have a common PDn pin shared between Wi-Fi and Bluetooth.

When customers use mwifiex_sdio drivers for Wi-Fi, the pwrseq tied to the
driver toggles the GPIO connected to the chip's PDn pin, powering it on.

The btnxpuart driver is loaded before mwifiex, and the setup function does
not receive any bootloader signature, as PDn is held low at this moment.
The driver inadvertently assumes that FW is already running on the chip.

The nxp_setup exits with a success, and BT subsystem proceeds with sending
initialization commands, which result in a timeout.
[  284.588177] Bluetooth: hci0: Opcode 0x0c03 failed: -110
[  286.636167] Bluetooth: hci0: Setting wake-up method failed (-110)

Later when mwifiex is loaded, the pwrseq makes PDn pin high, and downloads
either WiFi or combo FW.

However, the btnxpuart is in a bad state, and re-loading btnxpuart module
does not help.

This fix adds a check for CTS pin, in case no bootloader signatures are
received. If CTS is high, it means that the chip is currently powered off,
and nxp_setup will return an error, preventing any HCI initialization
commands to be sent by the BT subsystem.

The driver attempts to check for bootloader signatures and CTS again, by
scheduling the hci power_on work after every 5 seconds, as long as the
btnxpuart module is inserted in the kernel.

This fix attempts to improvise the fix provided my Marcel Ziswiler and
handle this scenario gracefully.
https://patchwork.kernel.org/project/bluetooth/patch/20231018145540.34014-3-marcel@ziswiler.com/

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Closes: https://patchwork.kernel.org/project/bluetooth/patch/20231018145540.34014-3-marcel@ziswiler.com/
---
 drivers/bluetooth/btnxpuart.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 7f88b6f52f26..20a3a5bd5529 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -171,6 +171,7 @@ struct btnxpuart_dev {
 	bool timeout_changed;
 	bool baudrate_changed;
 	bool helper_downloaded;
+	struct delayed_work setup_retry_work;
 
 	struct ps_data psdata;
 	struct btnxpuart_data *nxp_data;
@@ -240,6 +241,8 @@ struct v3_start_ind {
 	u8 crc;
 } __packed;
 
+#define NXP_SETUP_RETRY_TIME_MS	5000
+
 /* UART register addresses of BT chip */
 #define CLKDIVADDR	0x7f00008f
 #define UARTDIVADDR	0x7f000090
@@ -1008,6 +1011,15 @@ static int nxp_check_boot_sign(struct btnxpuart_dev *nxpdev)
 					       msecs_to_jiffies(1000));
 }
 
+static void nxp_setup_retry_work(struct work_struct *work)
+{
+	struct btnxpuart_dev *nxpdev = container_of(work, struct btnxpuart_dev,
+						    setup_retry_work.work);
+	struct hci_dev *hdev = nxpdev->hdev;
+
+	queue_work(hdev->req_workqueue, &hdev->power_on);
+}
+
 static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
 {
 	static const u8 ir_hw_err[] = { HCI_EV_HARDWARE_ERROR,
@@ -1036,6 +1048,13 @@ static int nxp_setup(struct hci_dev *hdev)
 		err = nxp_download_firmware(hdev);
 		if (err < 0)
 			return err;
+	} else if (!serdev_device_get_cts(nxpdev->serdev)) {
+		/* CTS is high and no bootloader signatures detected */
+		bt_dev_dbg(hdev, "Controller not detected. Will check again in %d msec",
+			   NXP_SETUP_RETRY_TIME_MS);
+		schedule_delayed_work(&nxpdev->setup_retry_work,
+				      msecs_to_jiffies(NXP_SETUP_RETRY_TIME_MS));
+		return -ENODEV;
 	} else {
 		bt_dev_dbg(hdev, "FW already running.");
 		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
@@ -1373,6 +1392,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	}
 
 	ps_setup(hdev);
+	INIT_DELAYED_WORK(&nxpdev->setup_retry_work, nxp_setup_retry_work);
 
 	return 0;
 }
@@ -1391,6 +1411,7 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 		nxp_set_baudrate_cmd(hdev, NULL);
 	}
 
+	cancel_delayed_work_sync(&nxpdev->setup_retry_work);
 	ps_cancel_timer(nxpdev);
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
-- 
2.34.1



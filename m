Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E75810A29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378570AbjLMGSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378566AbjLMGSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:18:52 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2030.outbound.protection.outlook.com [40.92.53.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48FE9A;
        Tue, 12 Dec 2023 22:18:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9JmGrrHei1bZZIjuhEq6MGQoBUQiMpmf1kfEGJ4n9c4XZ28u5B5CaOhP8zubFRkPTPKKoJzyRsSxJcUl24t5kGCCA1P/aD8GDozRXMgZkH4g9uVvL8iSNqYhYB+f8C51qVkUHkyzHK9kCS9s1x+HPTnIlJekGLbRw3yJaTGlajlL+P0K/9c+77Ylk+jq29RoGkUIBTeuUczS6xMbKj3b9NWam1VtPsygwdazFNWOLT5XXzf0Rw+Fb7UfczOKZ+Vba3AzLo+Y/EJ3M4biDnBOUJaBMNLlxxZjPvTS4IrMFrucs68HBMzYEbQWrmrHFKMwYhmxez0aTaNov/HrlzQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tI/Yz4axlEi50lnavJP8Aif7yOCBh2DNd5P++Bko3fM=;
 b=NqFgo4HBoO0lYuEpdwLylqHVpjPrQenJQKl+V34Rny6TG54TydnyF/6Vbl9ZF3f6UGHn3yq+XHETfakgutFz12U2O/0TozDNnOlflVRO1UbsabNt7DcSvVmnaM92Y/H/Yeovq4r+62HcH0J0ateYvM8/3LLlR8LJxPoK0ZLkZ8bAqR4zNDunwr68rWu6rYUBkudloEt+2OAEK29nvIz+XWuw6HBkYZgelr7apsQ18jhHGvxjHo8Sf1keONnpXlr1cBHjt1FPmXRBJPM+vY+YPya8f7BD/pJXh8D386Nz5NG9/CoqBRhqWVv2FrD3Q9IDSIWvmAf2eFY0A4ejSpdGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tI/Yz4axlEi50lnavJP8Aif7yOCBh2DNd5P++Bko3fM=;
 b=KTPlDdhB+stueXrP3nzhJf5w/1XDT/X9lV0Qggj20YSU7+IZZ4WYqGWEUxgYSHDvGNGlP4IckuDfmsCg5SFX08MlGTxlWZS7eASQcC32JjTRhqCkvzYQXbtK1atFMiagKEU32kbqZi8TLTatCBNEpqIjn20OFXmoiGUHdpBP5sv+/eOmzSPYaM/Re0URHoVsg0fukGvVrBLNA8ourvLjslMPLtY9KDpZKd+ajumXkABSRYciSZjPMySNt86E4dHuUmjGM/6dX61Ndowfdqla2sXThvs8SyK1WoEIOAza4hFD7DaI2DEBi/jewizFfPF2I6NVbzrqqhCZ7OfVQjMmZw==
Received: from TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 (2603:1096:400:28d::9) by OSQPR01MB6328.apcprd01.prod.exchangelabs.com
 (2603:1096:604:293::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:18:54 +0000
Received: from TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 ([fe80::5074:605e:7b60:3ad4]) by TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 ([fe80::5074:605e:7b60:3ad4%5]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 06:18:54 +0000
From:   Yaxiong Tian <iambestgod@outlook.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yaxiong Tian <tianyaxiong@kylinos.cn>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [V2] usb:xhci: Avoid hub_event() stuck when xHC restore state timeout
Date:   Wed, 13 Dec 2023 14:18:38 +0800
Message-ID: <TYZPR01MB4784EC31D8A4BC381AD83451D58DA@TYZPR01MB4784.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [2saL7vsID0RKA58RfLsim7JW/8dwXKMPRizmaVDArww=]
X-ClientProxiedBy: TYAPR01CA0209.jpnprd01.prod.outlook.com
 (2603:1096:404:29::29) To TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 (2603:1096:400:28d::9)
X-Microsoft-Original-Message-ID: <20231213061838.349708-1-iambestgod@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB4784:EE_|OSQPR01MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: a4190e36-1618-47fa-fa6e-08dbfba360d9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HzqzF/8KxqoEEkvEdlLgZUpt4ezPv9AqVZ4mUGlHfYLWznsdkBl3BYEyAxmjYfuSLD4XBvfTF0VhvTjjti34gw0tB77K3zLSwexJlL5OfxnHYDQGLxIx7DQnCzzQv2iFQo6kRQhjnDMCa3I+8a67ituX4CUBN2xb+nb5ZbtdC7D/qYUjyXobZqLmkd/MbK7DCOpLnotcFLwNY77YqfUyp1oeUIfOwvVZrq8DzVhR+6D0XYzOIVkjn3qvH19JxKZbmvFxJ8MG3eY9ccXbAm2xfrvTXxrGzozpLWznU6QoPyzwoJmmyQs6Q9VD6ReXYC4LML0roCv4A2FbBdPlskjKsJVfipxDpvH7Ud3aRkZlQOsDpwtdTC7tXW4U42DddgcWew3Ny4UdGM9fjlDNQWn+FEVmShoyWqBfEqz1Nh43WTU7q/U4E9iY9glJTZKniWdnVw8KIh2b4oFPAVZuEjXKw/eWRWTG+Efw+26rrFO7DL3CGJCCST0ja36cdONTX9+G22J3IEi5z5SZGMmXge6GPSW/FLQLQMkEI4OS5hyfVfOKGPqdL/49HkqEL5DRf/IY
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t3gWmhJBhyfJRcv2RlyRjmM6X+08SGCUPZlA9nxoJW6MF0hlqgkCMDZkXgmG?=
 =?us-ascii?Q?ccCBZzQQ20VCg7k1RW/7i7Q0AuOGV0IHDvHiBPpAc3iqtoPqJeLc3G9rKTgM?=
 =?us-ascii?Q?vaIxxNsb0dwXCEgl1ZLDSfylnML0AhY5ejNp9gW81HoNf9MxPQeTJ5YVaJOr?=
 =?us-ascii?Q?mHyGhpsv1VfNn4jsmq47FD7zzIyRmc3JS+LUMNIHYicSCoi5qXgwc2hrXDL9?=
 =?us-ascii?Q?bf1Waj0rV+sTjQS8w2K6V3rGC1oKKyx9PD3CIINiMaAYWX6gl0mO1YRzsS2C?=
 =?us-ascii?Q?yufZL/nEkw3S5/u5dq8UYNOMSs29vWqji7FJILk+PkonSKdilePExU4EUYE9?=
 =?us-ascii?Q?l7ojn2D5kdK9CgmitpBgQy4gyE7pRj4q6jfGeFdWGHI6G5lpJ1Da/q0vNjVs?=
 =?us-ascii?Q?0rmwuwAo7iqfRyHnoHGeBLMJeTwDnZB7L/9UteiUnnTO+C6PmPm+e81SC+QN?=
 =?us-ascii?Q?zI00si2PgQRkHsNsiJ3qbDt+8D2t0i1jM0ais0e+y1SBVc1CsU6FzOuHHLtr?=
 =?us-ascii?Q?C1rGgytXnAL54qzBtAco0cKNS3DeXFBU2JIXflgUiACRc6M3J6LtnEIqjO8K?=
 =?us-ascii?Q?gKE6e5MsB0IA/+g21jcpFpVkwGOSj0EGk5FSLm4ciicxlneWtwJMkRM/ZAgJ?=
 =?us-ascii?Q?aY39qrDip7EiU3zoFw2DBic0vDBX6OoU2IO4LUFUk8JYJ756gd3i7SYmjinL?=
 =?us-ascii?Q?zkGpTRcc0BfoJDO8tc00Jk/HenLrBaS/nF/CIESNqOYfoRGenxO8sfhhuQt1?=
 =?us-ascii?Q?6Zcm5tLEfKyqOQI22iNLMrfdqeNytFwX+6a1umacpJIvHDVWn/cnK8VnFsxa?=
 =?us-ascii?Q?RGGAZcbLlPpxSG5FQmikipfxs1Q+U4ECjDS5VPsOBHQmleYTwlAiKEoYx6gP?=
 =?us-ascii?Q?0J685hXuye+uRFA/UHVmFkK6QdmdPgjvNll3i2LTuPciM4nFzePTwUKz8IKu?=
 =?us-ascii?Q?3nd7quN8Ro7dkhRHFWC+cn+/46HFFIZsnsEzNympiL3r0p/O4jvC899DE0v9?=
 =?us-ascii?Q?BzU+4dJgeg5cbvvdkvuV1vrzLtI0sIap0+fH5qOyZylNVPwi3itOp0XRSR0I?=
 =?us-ascii?Q?UiUjC2y7E1xNeotontvPrQ0E0IkYxpp7RyNowSCtuqPsiPwSkIrONYxwk+zd?=
 =?us-ascii?Q?4qUiC4xkZi7pNIgIz1PMCfj1/WCuXrHb0Y3LBnnC/nXwq1SHKv6Zdw+u0j0S?=
 =?us-ascii?Q?Rzzo/lGWGVtDC0UjzZwZZEwPIUNrEzsuK17yHtQlbBpYDrGV3L1cheAK0T8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4190e36-1618-47fa-fa6e-08dbfba360d9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB4784.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:18:53.8180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR01MB6328
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

when xHc restore state timeout,the xhci_reusme() return -ETIMEDOUT
instantly. After usb_hc_died() called ,they kick hub_wq to running
hub_event() but the wq is freezd. When suspend ends,hub_evnet realy
running and sticking.
Such as:
[  968.794016][ 2] [   T37] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  968.802969][ 2] [   T37] kworker/2:3     D    0   999      2 0x00000028
[  968.809579][ 2] [   T37] Workqueue: usb_hub_wq hub_event
[  968.814885][ 2] [   T37] Call trace:
[  968.818455][ 2] [   T37]  __switch_to+0xd4/0x138
[  968.823067][ 2] [   T37]  __schedule+0x2dc/0x6a0
[  968.827680][ 2] [   T37]  schedule+0x34/0xb0
[  968.831947][ 2] [   T37]  schedule_timeout+0x1e0/0x298
[  968.837079][ 2] [   T37]  __wait_for_common+0xf0/0x208
[  968.842212][ 2] [   T37]  wait_for_completion+0x1c/0x28
[  968.847432][ 2] [   T37]  xhci_configure_endpoint+0x104/0x640
[  968.853173][ 2] [   T37]  xhci_check_bandwidth+0x140/0x2e0
[  968.858652][ 2] [   T37]  usb_hcd_alloc_bandwidth+0x1c8/0x348
[  968.864393][ 2] [   T37]  usb_disable_device+0x198/0x260
[  968.869698][ 2] [   T37]  usb_disconnect+0xdc/0x3a0
[  968.874571][ 2] [   T37]  usb_disconnect+0xbc/0x3a0
[  968.879441][ 2] [   T37]  hub_quiesce+0xa0/0x108
[  968.884053][ 2] [   T37]  hub_event+0x4d4/0x1558
[  968.888664][ 2] [   T37]  kretprobe_trampoline+0x0/0xc4
[  968.893884][ 2] [   T37]  worker_thread+0x4c/0x488
[  968.898668][ 2] [   T37]  kthread+0xf8/0x128
[  968.902933][ 2] [   T37]  ret_from_fork+0x10/0x18

The result is that you cannot suspend again.because the wq can't
be freezed.Also hard to reboot,when some application visited this
piece.

The reason of stuck is that the xhci_resume() don't complete correctly.
In the error path before command |= CMD_RUN,the xhc should not be accessed.

To fix it, move set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags) and others
after "done:" .Also add HCD_HW_ACCESSIBLE() checks in
queue_command().

Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 drivers/usb/host/xhci-ring.c |  7 +++++--
 drivers/usb/host/xhci.c      | 10 +++++-----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 2c1d614b3b0f..ee6e06590974 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -4263,10 +4263,13 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 {
 	int reserved_trbs = xhci->cmd_ring_reserved_trbs;
 	int ret;
+	struct usb_hcd		*hcd = xhci_to_hcd(xhci);
 
 	if ((xhci->xhc_state & XHCI_STATE_DYING) ||
-		(xhci->xhc_state & XHCI_STATE_HALTED)) {
-		xhci_dbg(xhci, "xHCI dying or halted, can't queue_command\n");
+		(xhci->xhc_state & XHCI_STATE_HALTED) ||
+		!HCD_HW_ACCESSIBLE(hcd)) {
+		xhci_dbg(xhci,
+			"xHCI dying or halted,or hcd hw can't accessible,can't queue_command\n");
 		return -ESHUTDOWN;
 	}
 
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 08fbabff23a0..7f2c2b76a51c 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1006,10 +1006,6 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 	    time_before(jiffies, xhci->usb3_rhub.bus_state.next_statechange))
 		msleep(100);
 
-	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
-	if (xhci->shared_hcd)
-		set_bit(HCD_FLAG_HW_ACCESSIBLE, &xhci->shared_hcd->flags);
-
 	spin_lock_irq(&xhci->lock);
 
 	if (hibernated || xhci->quirks & XHCI_RESET_ON_RESUME || xhci->broken_suspend)
@@ -1133,9 +1129,13 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 
 	spin_unlock_irq(&xhci->lock);
 
+ done:
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	if (xhci->shared_hcd)
+		set_bit(HCD_FLAG_HW_ACCESSIBLE, &xhci->shared_hcd->flags);
+
 	xhci_dbc_resume(xhci);
 
- done:
 	if (retval == 0) {
 		/*
 		 * Resume roothubs only if there are pending events.
-- 
2.25.1


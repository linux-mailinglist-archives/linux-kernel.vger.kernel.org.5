Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3D9802C97
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 09:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbjLDICY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDICX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:02:23 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2080.outbound.protection.outlook.com [40.92.52.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79585AC;
        Mon,  4 Dec 2023 00:02:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDeQaZU9jlmg6RTKIGYLdxxGLSpF/gHRX6sn/jOvd0VR518Z24i32zMGfMX1ffCc8GQGJmFs221NFo6CV6h6cgnVKGwEp+ltEcQZvNZisFc5mjUjcOLezvWc13gUdFqXERpwC9a78yf1loOVMgy8oNxLq1XJvVoWEWkFQqAAHq+yhUHWtBYvJmsnQ2KIILT56m85xfrcDgngrlRYFFgGil7nSoUfhN5g+budiiSGduqODsPbkLlWd2LcYkm1oGh0CLjkwtWAUb3tLUI8pxDcAyC62XfA9fgoIfTmxHrk1JyBVkAz/Ww+UxNfMX7jGBhwBvFc4TpY7woPZucwwSdWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R16B4foL4La4oRinSIw0VyaexNtQkw39QD16LQwMmrI=;
 b=jrm/bRBxD/hWdCpkON0/x4tf1YVkKEkzTyOKAwywQ0URDt05bgInMbo/lNUp0FBHM42yNleEWMQVuqrzKMHmpYaB78PaCFHxHe+s8Cx7348ShocYjNv1KeHtvxsSD4Zun6MB26jQy2pMIkQ44qZL44mokRgfr5ZsJ32lHGeU+LO8qGiPOZ4dSA5d8efvmB73ejzmLXqRVbd1MPlIVLdhInSGBbxEFS4RLpAqdIA476VzeKl3immC29hceEWfaBS1LfiEj4tvRbfCxzN8obT2lVeENSH8qeee+GJ6LhRPEtqFoXRh1PJ3psNhLGwCSNZG9HlSFmKTy8dKsmJ4PiYY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R16B4foL4La4oRinSIw0VyaexNtQkw39QD16LQwMmrI=;
 b=nLK6DBs9z8OrdN6ga64ttmxPUg98Rj1TEV1wBbg0bv6biNZlp6aSyr2SUSfZuYgQ3rgehjDoJwvKHdCgXB1pcBgz802Ikp4FKUqs1Omjs3Wdm9g5EtC30HW6GEv+BPgAGw2/NPVXhhY1F5WnJ70hMHhFHUDo5nwyCuFhlgGcB7iNJ0xuvGm7dRTEh8Ij74UuR8yFrWR5A4GbOwyfBv8AWp1LjMQ46PCM4HKgHG6iQmklon6CklMKyfkM/VsffkkYB+bDN9yGXZnvOrVWsdLsfsT+wN4eeoqa8zxt0amams8M4GwKmOLL9VQdYM+qQk4KBIrmIhDM9Wx4oEKjKLufcg==
Received: from TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 (2603:1096:400:28d::9) by SEYPR01MB5484.apcprd01.prod.exchangelabs.com
 (2603:1096:101:142::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 08:02:24 +0000
Received: from TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 ([fe80::5074:605e:7b60:3ad4]) by TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 ([fe80::5074:605e:7b60:3ad4%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 08:02:24 +0000
From:   Yaxiong Tian <iambestgod@outlook.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianyaxiong@kylinos.cn
Subject: [PATCH] usb:xhci: Avoid hub_event() stuck when xHC restore state timeout
Date:   Mon,  4 Dec 2023 16:02:11 +0800
Message-ID: <TYZPR01MB4784CB3058AC1B5787DB6601D586A@TYZPR01MB4784.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [6kwSLCW32Oq8QARCfydWDi/9ocrN/Tt+dXP3zw5mKHA=]
X-ClientProxiedBy: TYAPR01CA0053.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::17) To TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 (2603:1096:400:28d::9)
X-Microsoft-Original-Message-ID: <20231204080211.159632-1-iambestgod@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB4784:EE_|SEYPR01MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f631a92-bbf1-4435-33bc-08dbf49f58f4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GC+pPbXrhoFBMlETlL7YgT7fXW4AszOtOkYLh34g02xm5TbH9XleZmWQYjDe521muvma/9z744q3IAsdUuCRpZIjBolIysD2EZMQdbcq9v2x/wLhNzDzeR/o24Lp1ohFpC9q765fJ6A07GsH8YiPJzbqHr9qErEH+6XZD+3ojzK8DDfxNmfz+bh9HrwGnhSyvAHDvThES/jmPzcI+SMGHZszncgs3/gHM0vHYfjGqI81N0oapU8sQpTaEluuY+ycvGRyYw+C1fG5TSZPgzeEZkmylh/6eMA0CMmMLCeyJ9uxZcI/yDG90T6k7mHj7yduAJKiQ3A94Jvlsaqe/VlG9pFBWy3OBnOjDiHcs5TX1ynkkEF24oeJ3ALLejaU95ExFSgwxCOmLKQYiFKIcQCEW/vlok0evEwX8vZ6i3Kylsa3XhXrH4FiR0l4FCRriCQrLR2t7Ar2f0+wrpKi10QQelqcN0VEv33ZznJ+5LcY67SHugJtI67qrV227GQKPjhjFe/g6cdIuax0sGRLLZujm/Ot9RQ2h9VmUelNgaYiWvDGfL/IMMeYyMzrFVo6MUhp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?riIuNHvwCWh8eExQAy/K0yZo5KNlC/ovNZYlSxljJ4G34tIiwua4893wosuz?=
 =?us-ascii?Q?rHp61qfBYRa6GXAVsTiDTF+gqol6T0DiS3mVnfvM0BL1vw/nDxROAtxdZc84?=
 =?us-ascii?Q?ZtlaoVTvMOlOujg+r8ox13pjYhb8qcUFrkn+oIIPq71eGemVeaYWL+ukSpDN?=
 =?us-ascii?Q?Z/+3PyjjJTtIJ9bZiTa+vU9Ye53KvJBJEqvhH9AErek+KQPkfVu0Y1nON0ri?=
 =?us-ascii?Q?n4r8hIQEaah0YruEAI9V4ZxlBZAVfz8LRv9G+dEZjAJJ8SDLBposSSRvo6Zi?=
 =?us-ascii?Q?vtg8iHObdNTUYuPiisrRwSSDPPokWRJkfZQiQmrvfwasmoF72mtndoCZAcql?=
 =?us-ascii?Q?8PvABlkhQuShPLNRQPOr1u9V+A2eC7b6p5DoFkUsdKYHw45uxwURS1oAjgpB?=
 =?us-ascii?Q?49CTIhEiVHDTBK6gSCRgpsjD5bF460hgWs/egFhkaI56WRPXbGb/DvpF0F/W?=
 =?us-ascii?Q?O8QPLjHsKuOCKpsjN8epCva1ImEs0gphtsRzz5z1xrdcxSmROvEWFweRH8OG?=
 =?us-ascii?Q?sTgIOTR4jFpTmwMtmWF3DYcWaGdiU2ZVMqf/noju5Cd9OuMnCkgQAQFiGj8c?=
 =?us-ascii?Q?ZgWRjxMZB+3fNYvBLMjiPJFHG8seRt3NGPluYZvsMd9ooCYx74F7XEE6G4nu?=
 =?us-ascii?Q?mZUcGee1PIHfLwtLBEDXIMbQNrVji61+tI4UTs7DF5REdQFZ62rnKhKGPS5a?=
 =?us-ascii?Q?6gtdgOmLryNxj4DrxDm2FWNFfumPD3VIj/z9IV9ta6N9By7hcMHQ3qzWkHen?=
 =?us-ascii?Q?wEFnYtScbPgdKhkZljfYS6fdBzU6UtwTGrSc5WTH0YvUHDPRgSb1tQr6xhu+?=
 =?us-ascii?Q?2Tp1Aw5UGuvyouacrkd7XFf7yrRgDTRUenJNHQ4jxUS9qwggeQkB+PXNsiBR?=
 =?us-ascii?Q?M/wm2uuzbnWtBPLWdMoqtmGmNPXVKrfglMy2UO/A2kG/gVSnT3e7HtBYzaPF?=
 =?us-ascii?Q?6k/BqHkkqJMOWVXS/kQHmBPiiH8bSdCmyd8MTAD5p8qgXP+R6aJmCpAObR/5?=
 =?us-ascii?Q?Ti52GRoUwulcPfsMxnxu8/zQWjhFR4ASGXV+UknE0shYNIbXEkpy5Kjq9ITE?=
 =?us-ascii?Q?gQEctfSaUFiNDeD392hIzek5a/htpzE2diKY7Z0UMYRBHt1WSiXq/ONQAlvN?=
 =?us-ascii?Q?L7YYMzbvU8GbB4VYWeMC+oJBq7TviobJwx29yaHuItxkybpv3AkEaK/tHmMi?=
 =?us-ascii?Q?+t1gOtxiX/ZIPov4T0JWmo7wJYhvOoSMLfcIEHgfnhvWXCZh8yhpa6zOq0E?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f631a92-bbf1-4435-33bc-08dbf49f58f4
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB4784.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 08:02:24.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5484
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

The reason of stuck is that some access related to xhci hardware
is being called.But xhci has problem,at least not running.(
when xhci_restore_registers(),the xhci will load op_regs.The
CMD_RUN will clear in xhci_suspend().)

So using XHCI_STATE_DYING flag,to avoid any code to touching
hardware immediately.hub_event() will complete.The usb_hc_died
tasks will be completed and some sys interfaces will be removed.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/usb/host/xhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index cb885ddc2032..f0ddd7421e1f 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1044,7 +1044,8 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 		 */
 		if (xhci_handshake(&xhci->op_regs->status,
 			      STS_RESTORE, 0, 100 * 1000)) {
-			xhci_warn(xhci, "WARN: xHC restore state timeout\n");
+			xhci_err(xhci, "xHC restore state timeout, assume dead\n");
+			xhci->xhc_state |= XHCI_STATE_DYING;
 			spin_unlock_irq(&xhci->lock);
 			return -ETIMEDOUT;
 		}
-- 
2.25.1


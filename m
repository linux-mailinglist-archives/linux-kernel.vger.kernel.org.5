Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A901B798A1B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244686AbjIHPkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbjIHPkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:40:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn20831.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9E91BFF;
        Fri,  8 Sep 2023 08:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt4pVDMw6gLOUVDmvplEAlZSEbx73tDquH8d6gKb5JdhjLImMrN73tC270RKDRUFa2U7j8EnySSoztVIu8/PL6BeTXgIH5L2Gj4A9ROwS5RtUimUxcuJBe1HjDkpetF/Y/uFws9RLhXNqROldTayrf3f8GLsZU9+gV4K0n/ayY1uazTLsPszZTfoQPgcAmFwr+CyXqxw95lYWoKTWGWHsaJf0iq+6fbZXOFlc/Ia8AiCjbfADfRB2GBzo1YM9uKCeI3qozO5HmxNLu4AqRuB8Kkhb5tOVSR9vMIOCEGVzjtBZ3hDXlBH5kyiq88cHYehVDibjRv0sPgcjtIgWtUokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMxdzWJBfP6gO4p6HdqJJ5eRAprvG2SMg7tXHARoeJ4=;
 b=VH4yMwR4a7fuvyCQUVSocDN1JiDkkSIMTPN/3qZw+pI9ZxD9eJjLR7rTyOgKAyEQWBKnEZR2TqblbAngjxOigYakF/Jf6SjvDgF0U9HIlfXFL8jERjW4rowiBcpEDJ682hFc16V8+wglzbjIGN9u8jnC2edhf6ueoA/CREPWgj+Dxod3Gd0mSn4FHR7yLlqPuUr0SepFdYyP6LDWtyiOCImAkTMxyRlfOiooCKtO/6hZckW7RTH5G7tn81q4gqfmhIcI8VtJwkDZhINWt4tJUJFt0TbySjuEplhJp5QP2vCH4HdjqEwN52fqkVqaFbjbM0nTjAyerYvg3yZyWHmaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMxdzWJBfP6gO4p6HdqJJ5eRAprvG2SMg7tXHARoeJ4=;
 b=m19HAsX2eI84YT4TsrCvT1iT/laX+NaEcUTNPqZdVletow66O3HbKw51RxH7nL3hP7KUMSKTFxQzP6JMT6EhZpPaTS9mAaEsOhqEjRp+OAnR/nSOG+Xd2217unIaFZl+qePLtJUflnhGG/ofORq4mhqCiD2lKud6AfuAwQlCLqcO542UEhj71DUwbEHf1sGTDbw6pM8r0U5DP+1TPAATmOGHaIzNJcbViYRJ1c3z5Hpnj7eI9FZDbvVAb0VvAY2GAXNmpom1vtXh0RKG9GfICKzIa99PhEaNxIgutDT6PMCp5NdkxaZtw88+cld5KEJ4IgBnrWiDg+FD4VXLy1GsOA==
Received: from AS8P192MB1269.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3ca::5)
 by AS8P192MB1191.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 15:40:32 +0000
Received: from AS8P192MB1269.EURP192.PROD.OUTLOOK.COM
 ([fe80::6fd3:22b4:117d:a5a9]) by AS8P192MB1269.EURP192.PROD.OUTLOOK.COM
 ([fe80::6fd3:22b4:117d:a5a9%2]) with mapi id 15.20.6745.035; Fri, 8 Sep 2023
 15:40:32 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>,
        stern@rowland.harvard.edu, royluo@google.com,
        christophe.jaillet@wanadoo.fr, raychi@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+c063a4e176681d2e0380@syzkaller.appspotmail.com
Subject: [PATCH] USB: core: Fix a NULL pointer dereference
Date:   Fri,  8 Sep 2023 21:09:37 +0530
Message-ID: <AS8P192MB12697886EC8DF1650AD56A57E8EDA@AS8P192MB1269.EURP192.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [8r7N4A654WAbBOIsNwNcL1jVtF0FfFfC]
X-ClientProxiedBy: JNAP275CA0061.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::19)
 To AS8P192MB1269.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3ca::5)
X-Microsoft-Original-Message-ID: <20230908153937.153306-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB1269:EE_|AS8P192MB1191:EE_
X-MS-Office365-Filtering-Correlation-Id: 53508e2c-a3db-4912-e5df-08dbb081ef95
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTy/vZ83dre6Sn7U0xkpm3ZifORm1pritQNri3u99OYEUz4EcVWj0IjCqjV6o8onBv8ZnLsZ/WdVxsyJUiI/bsqTjEN35FdWMw4h5Kx03atDk1c3NVHNAWhu69UTME3iWz3FRN6Zqcbxioel3IIYmpSFt2gio5ouKLDRJpxFgN/jKzJODzLA3mSSOIeZNtsL6ZxnE+lFLLbSi2OStjDKvqcwV9rZpU9gFjcZMOlcpfdrGFXJyMBUBB/xgmNm6WDiRXN9c37ybtmFHhmQDg5+3SmLDksEucKUxs8t+6SMKN9cqoXtgYMz4OU1TnCuk4jpoJKG2zGp3Enxz26w/1sxTAZZPMFrvigihBYqtGchY35+V5r5OVeuqOzC9ygH1fXebZmwkWhEXrbjeDm0kR2/Jr30zuw7RMEwhflpU+SjE27o1cRtE9TR/NDvbcX8s+AUMuUxYjKGtDMeiNWlSSs8pt3nwFhgB7p2byvi6Od9qLT3tkJ4Je/3V82/p9gVl7a//0PIA4x7q7xgB7jYiJJLzmu6zamvemKDurVXC6u043nr5mPe4c1XHLF1Z3PL+lnFNMUncpdIsMNdgMrOSZPzW8YrukYZyKOMDkIng8+7gIo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eo52L0J1GN4qXljOV7TqpxF8r5c1SGHxiSyOUjWooDVPOZfFW3CfOwua0k+k?=
 =?us-ascii?Q?H4N67xnIUbDXeStA30O2VCjItZLt0Chq+gobo4fkV9v9zXF1R/imytI/0enP?=
 =?us-ascii?Q?FlvqdHw0G0H+jc6NCH/OO83Rtsdnn8HqcjqQJLRHys/aff9zstc9thJAXnY6?=
 =?us-ascii?Q?yx6adMXk5J+Z9X7Tnke71NnfAVBu6m/qmXsAKxZ3gOPSyF9bDz7p3zFAgFGb?=
 =?us-ascii?Q?S2/WONdEVEMUn0feRYUnjl0dHaGqJWoFr3ZasFHe1r+1boyj2MtR1F+LIRzh?=
 =?us-ascii?Q?E/tPtWzatGFoZ+zBKzoCd0wIa25W5ZnDlETR/IhVQcA2/uwkWeeFqBB0CXbM?=
 =?us-ascii?Q?mMcWbQPrbAzbVvJ67Xr82Q+nyjs8FeN/conDRXVWQboGi2k09F3xGaDIBgYt?=
 =?us-ascii?Q?BKjS55hxJoTwNdhGxb58t/c+Vjlu6SF1BlCpIrbczm7YiGWCpIBaJtKcXB4K?=
 =?us-ascii?Q?oBgSLHlQ3zuZyXBQ/g5ePAiiy6nDMCayQ9uyllPcTNMu3Tknj8hJMLg67kQ7?=
 =?us-ascii?Q?nzCHMIV+dcvbwbC1o9rimL26REoHOC3RwICEcmd0D7RLbFuy2/e69VdPcmG6?=
 =?us-ascii?Q?cz20cS/ydn9ogBvGjuiSgcr5gNHDWYbMWE3BP6KQryGPUHaZWnJMiD2ev3PL?=
 =?us-ascii?Q?7WIFzOnneHh6Zj5xTIWtMjXmc2CDiMP52+ob2h0irLD7AWfedK3dHqkkDILZ?=
 =?us-ascii?Q?eVSmiNl2VcigI/s+c21X8xrZurWtDBIj6VzbCaPZAdiBAVc0sRjNYDEmXGbe?=
 =?us-ascii?Q?7xP2jun1533IpsZces2+YApOwEUGeib8hfcBTC/Fm4LfNkmvv5oUhitrgynX?=
 =?us-ascii?Q?9tA8fOX6cQ1zYhmUZtVR/DywmoGXIQRaC971vsMW3kDsH7l/7w9V+E+iM8OM?=
 =?us-ascii?Q?mT5TJ9A4iy8XJejzX3gTf0pTqyYoGVkAgA99t5mh5Psk7JRQNzhzFY0CPXPw?=
 =?us-ascii?Q?bOnJ+qs1SvTL9++5/BTHjeTUPGSqBZMfaQijueDo4qcXe2kv+Mvu/pv+84tE?=
 =?us-ascii?Q?z+SwvRsdqz11Ow7qhYW/sPeyl0i4m7S6U8CwyW3i2ot6vnRnCyP6tqmbX/my?=
 =?us-ascii?Q?7AM330XQthEn2Q8eFjvgFQkUaIF38rsBzFHvTvqICv4Zu7zFBZagnEtjdHdl?=
 =?us-ascii?Q?pGr12ltkvpwB42TwfNwzjOi6UZNrrDmZbgdlQ+YZ4Cs9jpM2r6gPJFbtCaMx?=
 =?us-ascii?Q?SLiPgzHwjec/KRJj8EChJaBFpzyNcJxkiE8ouZwt9QtMoDrFOylBOSv6S3s?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-fb43a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 53508e2c-a3db-4912-e5df-08dbb081ef95
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB1269.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 15:40:32.3455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P192MB1191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


When the call to dev_set_name() in the usb_hub_create_port_device 
function fails to set the device's kobject's name field, 
the subsequent call to device_register() is bound to fail and cause
a NULL pointer derefference, because kobject_add(), which is in the 
call sequence, expects the name field to be set before it is called


This patch adds code to perform error checking for dev_set_name()'s
return value. If the call to dev_set_name() was unsuccessful, 
usb_hub_create_port_device() returns with an error.


PS: The patch also frees port_dev->req and port_dev before returning.
However, I am not sure if that is necessary, because port_dev->req
and port_dev are not freed when device_register() fails. Would be
happy if someone could help me understand why that is, and whether I
should keep those kfree calls in my patch.

dashboard link: https://syzkaller.appspot.com/bug?extid=c063a4e176681d2e0380

Reported-by: syzbot+c063a4e176681d2e0380@syzkaller.appspotmail.com

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 drivers/usb/core/port.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 77be0dc28da9..e546e92e31a7 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -707,8 +707,14 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	port_dev->dev.driver = &usb_port_driver;
 	if (hub_is_superspeed(hub->hdev))
 		port_dev->is_superspeed = 1;
-	dev_set_name(&port_dev->dev, "%s-port%d", dev_name(&hub->hdev->dev),
-			port1);
+
+	retval = dev_set_name(&port_dev->dev, "%s-port%d", 
+			dev_name(&hub->hdev->dev), port1);
+	if (retval < 0) {
+		kfree(port_dev->req);
+		kfree(port_dev);
+		return retval;
+	}
 	mutex_init(&port_dev->status_lock);
 	retval = device_register(&port_dev->dev);
 	if (retval) {
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805607E2FD0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjKFW0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjKFW0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:26:33 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2010.outbound.protection.outlook.com [40.92.73.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5125F1BC;
        Mon,  6 Nov 2023 14:26:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD1/DCiQpfM+yZRIFbebTDAxDOC51TrTBf3BUdUZ58w6pLKHJglo9MjX/R3SZf96GHvEP85ioLBECYl2jMfSknQJRCfWqqUCGZv6fEi4IEzD8nkO5jGlXhgDEsU251MV0ci6GvflAm2PmERl8EXEmR/h7tJMZsbMBOX/79NcA0lUu2Y9ByW92VjaFWzyy073xpB4fKLxKfMVZd98xht8qLUkmZXhK8cBhNrfHZ51FX19VfsfUQuPF1QZGA/fH/h8iTgqyZNvLh2c9SH5tFT2gc0al/GiPSVDdkqCsv5a+Mct3jaCYjjt8/MrNScn/zYwC2Rz89LvavrPZuTf4Pp6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYerno5TqoWJ5H81zCz5xdfJQ4b134jDbbNHTizHyp4=;
 b=apwyPz4FWGRq+dRmxFVtkD0HvucIjJgwl8N7skrSg5IQ7Kk+wbstMR6fQLEooIbcTDuQAUVsxbAz/GMqa2I5ef0m0Kwko6bYqf0WUNtbDEaLa0V3fX3SaqJpMCMuVcLJc5eZvYe/54nAWm10KIfhuCEG2oUfiEi0hbnQv3/J0uPdDBzHZo6/abTCuKU2qT/LP/Pu2a57zaX6SfkQbUNoNvC1Pxq40IXX4BgFeV1DQA32KvT0pAZQDDx7ncHJV88Sg19082DlYsuFbbqA6NXgC5jjW5cqB5AlLEfHV0/NDy+k3WbS2GEzMiUjdnvZc2xCRAnAzU/dMY1mZJDeBcUtEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYerno5TqoWJ5H81zCz5xdfJQ4b134jDbbNHTizHyp4=;
 b=bYxOIfz/VDOed/PGS6y97ZRlmEQyD4qaKQt8EjN+/8NYy09jeQVRiJirZxf+u4VXvPsFOERXeMJcQupafcIwg5bdkiODUB4tGF7/Gg1Is3lnMfSe0oJO4qszXoY7sDYhqXEKttG5S72UHABlqqjAbj3COBRj5YTdyqeiT82aoQt1cwM0wwkDi4em8gP4DMVYFKU+RQ9IGUn4g0YNnx+InURlMeJKUqFyOklh1ngPtIh7PUqAkG5s5wx792TAzN23YaAxcNf9A25L7P4H52FphXm/m9em+L/gHRKujMiAvME2zrU0GaHY8XQz5uCak5//VKn/g2QfWV/VGmMPB/wiaw==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by AS1PR10MB5144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Mon, 6 Nov
 2023 22:26:28 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 22:26:28 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 2/2] Bluetooth: Replaces printk with pr_debug in bt_dbg
Date:   Tue,  7 Nov 2023 03:56:08 +0530
Message-ID: <DB3PR10MB6835DE6D279B65EC040B92AEE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DB3PR10MB6835C002EB4C5A05AD17610BE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
References: <DB3PR10MB6835C002EB4C5A05AD17610BE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [M9Vs5nU69k1Ps+TS4XSpHpLyAzz7pMwF]
X-ClientProxiedBy: JN2P275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::26)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231106222608.1793859-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|AS1PR10MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c9dc27-e238-465e-cfd1-08dbdf176b12
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VmsH5lVWdfwVPwmeD8ZDDxNchkWduuI/qURpYP5h7m3qbK11ngpF3I8tnxw63H1ftn++xBzSxEQd74MXyMxkg3IOxQJIKTUt/2FVGN+xMkyZARKe1QT3csCDvltdBrpbDu2fYhaBpGF7zMfNy/0qY2J25SjiWiXm1aav8E2aNqmVO3clwcZiLfO/L2po1a9YfJ0w8sVrLyGBKn+ScSXhyxdkw9k51hoWUWm3Bdvb2NhvYwqNSdwS8sGmexZtLuCpNzjo6HdHz7vKhXnkeprX4WJU0YVNbvqHMu2nFnnISaYe+oLSRpljvV4dYasLoNifzx6s/6yhepthbtmJyhdMhZYUYzWX1pH1TgqIzGpWxjrShY3BVB3HH9BDDkf96IUbzrqKf+ZG+RGeaLs/YtoMfEsQrvdWJQlq4+dQm7oi+80TafzMSH4ypgF/OJB2WPy04Sr2i3YLQsaPGezM8IAILTw1+xTzhFWncjpwm5/wq9dS43TOvMr3nRGo6XzpZf6wQWY91RtHoRmeW7qwinoKN/lD899W4W655mMXaAvnUyRvhrT9vvWZvylrDnGH+BnMC72ek0TDAvqj6mp3Zsmv+JVNIuLjq/+zoNK1lBXOeIiswkxflw3Y1KwgsHnWUzCa
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hZiiX7pHWJrw+IMnlHLpyQa1sIWJYJ/6ADkD3ev3vvV0uaAzRpn8N+oLpGCv?=
 =?us-ascii?Q?j72NeWoKcsGxsftwJSfGhNL93+eQmFEQMsgLh/2sZuEwssWKWDwucwWM0Xly?=
 =?us-ascii?Q?w0UHTU9N4A8EJQdhR6apczsxkXKlfy6tSFS2S7JFcb76FTBtVVgariOvU8hj?=
 =?us-ascii?Q?pQg7QSzU3RQLJB/j85j2Gc8E9br6ZizFv1S0dHNShliJXfAhl8B7cKEPr/vV?=
 =?us-ascii?Q?ji0o2UJfEuXsLOfNwSbXwu8vfY0R0hvKg9fk0Xyr3Wjw8G9kKQda29F3tput?=
 =?us-ascii?Q?q2dY9BidH8ql8CHxd88MKrByuj1ilHWLoSwfKYy8E0J4DonyOZS6joF1dEiz?=
 =?us-ascii?Q?wZ9mhktfprbXNofJ/cU1zZJ+5YVYfH4UJbFM494qXk8tkrdoOhOQQibfgqUt?=
 =?us-ascii?Q?OPhJF3rMIV2CyC2gV6F/Q/nGCYe/l0kTRzwfIpEGwiYAbDPEeF0Ul+mZpcGz?=
 =?us-ascii?Q?5VLCq/xKk896osYrjTdQiV+1vMTODY+XIitvuXtl0o7VniqP4GqU03DWDbVo?=
 =?us-ascii?Q?9LstP7TrUDwQ65aJVKnOIPuV3QkPIVJIJvGnYrRZTyuF40dD3kfuxk+4MYaz?=
 =?us-ascii?Q?kFkwT9OLgs7wqxQGTj2ewIHUmBkmCz3fh5nIAhnKyMH5FiUklrJPg9n2CV5p?=
 =?us-ascii?Q?BEok4fQmMI5UaBIz8x8lR6F6ErqqdZYjOLHLFRzNTqYDFhd2zhOweA5ESMPm?=
 =?us-ascii?Q?/VTZGXtCp8y+2SsTz/UL9gSHOqFwCjeRC3bUOJgh7zJ1bv7izo5vaaqyFpTy?=
 =?us-ascii?Q?a31cMkR6yNf6qHv5cnUB5UiAQJ0pB5408/YRBf7DGguFgEBGey7yP7Xj2rmj?=
 =?us-ascii?Q?F7sTJXWIfaxE73fTv5ZP92a8Jd4Cw9oS3PhCuIZOsUWf1fLrc94JHtSGfEU2?=
 =?us-ascii?Q?GbL3S1RMCSKqFcr9+tHr/hY00AEof8RtaacUAPBfBFjz6vCuhPgLI/B3d6rr?=
 =?us-ascii?Q?Uk6AAa/oen2B9EUt58cwRnBXltIqrZ8YyHYWIcGW0lVPDZmhJI81ESQdOoW+?=
 =?us-ascii?Q?TT/LxI/LeI48gajQmn7B+LoY5oHyXmdHlFHYKl+LOyuVf0nYY7Tic/61Cl46?=
 =?us-ascii?Q?LOq96ZIK+kMvyn5v5f93zPduZGnPiqY+YnpZry+GrtTlb1nxVVf3CfWMiqPm?=
 =?us-ascii?Q?izrVP3OVbtE7s8zu3sHl/ahMoPO0VGXEosB6gsiQZP2olaJpz9bcKngKGkUo?=
 =?us-ascii?Q?44+iLe7kLAUN3zXaAgzqGS7g8lB48KyXMQg9lRy6YzbkAJoLA0SkLWaO9YA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c9dc27-e238-465e-cfd1-08dbdf176b12
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 22:26:28.2617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bt_dbg() uses printk, as opposed to other functions in this file
which use pr_* family of logging functions.

This patch changes that by replacing `printk(KERN_DEBUG` with
the equivalent pr_debug() call which makes the overall file
look more uniform and cleaner.

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 net/bluetooth/lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index 063032fe9c68..96ba39f8b461 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -329,7 +329,7 @@ void bt_dbg(const char *format, ...)
 	vaf.fmt = format;
 	vaf.va = &args;
 
-	printk(KERN_DEBUG pr_fmt("%pV"), &vaf);
+	pr_debug("%pV", &vaf);
 
 	va_end(args);
 }
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BC17BC73E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 13:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343890AbjJGLjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 07:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjJGLja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 07:39:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2034.outbound.protection.outlook.com [40.92.89.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAC1B6;
        Sat,  7 Oct 2023 04:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIQlwNPAOV+mQu5LhpSf+F3WUE3wP41CsV/hySql0vi6AHZ2uQIEWGmtb6IDDr/K9pZZEO2VZAUpjW3h6WbsJ052LVzVWNcTDFv8ttC8ACayXr2lwhe1te6XGj/wwbeVE3dHAIZGq8ZPUl3qgWQddRcEatgnpq4iglpIBO/pEtQpevaL3w9AGdcdhryqQ7O7XjCO2BHmIPcW/LZClz9rFIrmm1ixW47QAx1FsKv6TryxII49EyjTc1kdq3TGiq8Nt4cDSNnYZyCS849s/Bo39Fid77zbXujfQir+xpXVH4Gz5pSgirpv5JqjGizlOODR5CDacvDzb6eORHBERbLYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnLyyMJP8yRxdOnJ0/PrBjD4FhLJ2rx1lMdub3vQl64=;
 b=atjsP6KphjwUHRNPSOWor/SkOIAxdIuWJwJfdBTj2AbMCXUAOvJKJSXfKyqrmSFLIgW2WWvNSc2o4I9J9zxLfnA2B31CaOaCq9wTqD4kChaBT4L/ijn1e3zowMvl6weplhvOu+dIzSQJc9FCsdovjAiHDANGlsq1O16+kK7JNodiLSvkAkKOabApf5Z9u4IjPrwhdhV2U18WQA8LYUX4vrURSeA6dILdzmc0VnTVjM/gpwfn0xldpkJxuSFkHMWjQr0uGF+eMCSjA4JZ6ISLORWVZ/gJnriJMeGC6jKmX98kCUxe4bRCofNSZIRnLPNnAyvPpq50VKN0vGe8YlN0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnLyyMJP8yRxdOnJ0/PrBjD4FhLJ2rx1lMdub3vQl64=;
 b=XyGghgS1kAaSvXFKO9q/AwndEQjrXI0Y9Yi7Y507Y6cssBB2XuutprLam8NajAmfAZ/JVLI2HDND1bIra97R60PeuLsr+74584uIakqCipEwQ7Vgspo7xn5g7WMzEtejZwHLL2caY+w6dCj0UUeM2mTwSAU0BK2u31o4APlVsOEoPvCp+EYp7WmCpVbFKJAJM6wWFQMK6xP8nKqvKzw/ollHAcTrsFk3Xg+Wl3nlAqzsKntQ9IKtsLob/p6Jh2cWDMsQccFJiH9XKHKVgYtMNYcbgZqOXOG2VWC6xNWCUQOfQ5Eh8qkaEYag6sY0a8QArLKx1wxPNAP9/GQ1iZ21eA==
Received: from AM9P192MB1267.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a7::7)
 by DB5P192MB2197.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:4a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Sat, 7 Oct
 2023 11:39:26 +0000
Received: from AM9P192MB1267.EURP192.PROD.OUTLOOK.COM
 ([fe80::628d:d050:3672:a203]) by AM9P192MB1267.EURP192.PROD.OUTLOOK.COM
 ([fe80::628d:d050:3672:a203%7]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 11:39:26 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     marcel@holtmann.org
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: hci_conn_failed: Fixes memory leak
Date:   Sat,  7 Oct 2023 17:09:01 +0530
Message-ID: <AM9P192MB12672AA34A0480B522D23741E8C8A@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [92CQgJDPQ3qekFenKEftQSxTumWaYRYm]
X-ClientProxiedBy: JN2P275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::28)
 To AM9P192MB1267.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a7::7)
X-Microsoft-Original-Message-ID: <20231007113901.206517-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB1267:EE_|DB5P192MB2197:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba6f99a-0493-41d7-56f5-08dbc72a0ecb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSRWJLKdLfkn/gmXV567fc7b47eIUCYdxc+B4XVS9NljW7Pqx+pRkr2+bDuzroH1rMca9Q/Yohbwz/1PuCkO1qS7QoN4LCFAJ5Rb5Toi91I/QSRs9N6anOtngh9Mrl4Y6EdF9BvMEfq14iBP/SosImZ5gDE7HR6Zky9beifj6rqTqeJeZ9Z4NDlhMjzY/GtqWKGJc6MQwXvnJdgGEjv0MnpBScOqZTASroyRobzCBBWvFEI8D+nU87N9p/zeolGYhwg9OSTtUjoaNOIBsEZsWf5i0F/1nZJ/04siZi91pBNAnDhAbtjdRLUPsVJW43if8/2M5BzqOBIu20HltUiOssuL9NzXLZY/vP/eR7g2M+DkJ7A+H1kzTbRYgiikr0eyD2oHTIBdIu8STzBSKe7n6EcA/t+wkK+egbIGDAttJACvHJNlyVTcYZfZZ0jd9Dv0LCrT/zBHEM0tk7Gl5Paw6TtlxTauf4yaPCaB3zej2lN/heM9WFR/7Rfy/kPy3cR3Nr0PzBIcGaQyBp7BHSWillnuc4HxQ1/iuA4VoI4zXCcSiifDCepfDBN91fJFbe4WeA8c1H6/0lG0eufn3233RSOEatTfWIQzRrmfKJA9V/iSDGVysH0FIFJmAS6VpdrE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9C+g7i+d25tDpTPrMi5n9n1iJRUGyfLa9GofXmclFdm8wpU7bPrc9tsrGRKF?=
 =?us-ascii?Q?QoEsyGkHtM7OgKvnHamg+Pq5ngJKu5gsZSTyp05jkGhqvGBOZsTz4ZGCVZw0?=
 =?us-ascii?Q?TdGLJ1vwxwlUzA4UzxW6hraxPfUdoeBHMEburQtuvJQ0k8lG/7Ko7CMGiY1/?=
 =?us-ascii?Q?mcuYSLfNSBNic/AahO2XDBtxUVWo0xjGmduCU2yQPdhlI1k6R6fXxLFEn4Si?=
 =?us-ascii?Q?wi6IJ8RFw2sc1+Pd/jhf6u9c2xlQ+YSnx+T4GwzCRxFCMP9b8AVHjuE5ZG9B?=
 =?us-ascii?Q?fLRRmSsZ86ITLOz/GYfGDgUlB7Pfaa6BjavodWSOsC7WjkjEZzNDO8A46Y5S?=
 =?us-ascii?Q?+3Qt1qnwuUcS784zAVXnjuSRS6vXfl3+UfZNDU81T/26bx+g8DXEeyTSRrr1?=
 =?us-ascii?Q?xtuOM0gGI+LTPNcTwINUbbkMcwUfEwDLHUYphAO/i19OvCQi5Kx56SVZ/tN1?=
 =?us-ascii?Q?TkzFiudPrRS63y9/G1bej76qUJDVh5oPnLBASt6Yo7gfq77tupDnN+xeGiDX?=
 =?us-ascii?Q?Guei6XlvNgek0S864URAZxzgrEltXfy6/YBBxiIk+tV12OS9j2Iq8TcfpUKU?=
 =?us-ascii?Q?OBmwevZJz1HpTSlYkH2vdyvQ5da4VbtO9+R2qPjqhzFejV1N5Y4bkPRHD1YO?=
 =?us-ascii?Q?WyJ31fefrnGwJPi/mU6tHuCoDBC7gE8cbKVyhe3+qZkngKT+09U63cqGjr9n?=
 =?us-ascii?Q?a7wm31fpW/nXBTLSrE3XAy9w92uIjGNZoWVE3r5fYPEU919EXG16EvTVClLP?=
 =?us-ascii?Q?1CBulP5PMRmrbUUq9KZC5CfrnGR3dxxIlTbJuR80uzDZ0DOHydyy5/RgQZRa?=
 =?us-ascii?Q?t2IS6OP3TdoMt5S51DGgSdCrB709jeXzwITUgfD35S5K3qA6lPsbNOVdPPDc?=
 =?us-ascii?Q?AlPfnpE0M4beuu83DqzJ5hY6LrdJHFgpeS+QwCMtaqQ1EMntn72v5T4mqIS/?=
 =?us-ascii?Q?ffumKg7Qq/HRL79s5rKx4RdQastNEw39aNpxbpRAbcvTCLLXkIECFAo9eSfA?=
 =?us-ascii?Q?zsoS0FU68gKeMh72nqi9Jj6h61HJdoMQVrjPwmQUoCndWsekncpVAvKqMs4x?=
 =?us-ascii?Q?HPHDiybN3MavVu3VN5nRa+uGVMI/d3Yc5Rzf9Vmp+jLo2hPLTnGTpeSbZZQv?=
 =?us-ascii?Q?zfoW+3LueIJPL5E2o+rb2tPX0p9DIjRng+/pEvt71LVE9opJdKEHRg01dyg+?=
 =?us-ascii?Q?PHgf4gWkUBy1I2Uh6UKlhIPpDq4gt43NESvf9RBxkY2GCFrLTlZ+PQ1NKOs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-fb43a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba6f99a-0493-41d7-56f5-08dbc72a0ecb
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1267.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 11:39:26.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5P192MB2197
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hci_conn_failed() function currently calls hci_connect_cfm(), which
indirectly leads to the allocation of an l2cap_conn struct in l2cap_conn_add().
This operation results in a memory leak, as the l2cap_conn structure
becomes unreferenced.

To address this issue and prevent the memory leak, this patch modifies
hci_conn_failed() to replace the call to hci_connect_cfm() with a
call to hci_disconn_cfm().

Reported-by: syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com
Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7a6f20338db8..1d2d03b4a98a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1248,7 +1248,7 @@ void hci_conn_failed(struct hci_conn *conn, u8 status)
 	}
 
 	conn->state = BT_CLOSED;
-	hci_connect_cfm(conn, status);
+	hci_disconn_cfm(conn, status);
 	hci_conn_del(conn);
 }
 
-- 
2.25.1


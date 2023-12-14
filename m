Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CCF8134A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573811AbjLNPYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573771AbjLNPYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:24:30 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2049.outbound.protection.outlook.com [40.92.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A689120;
        Thu, 14 Dec 2023 07:24:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTqI1z1yoiK01ZPETCX32T1ajNzOu4pQMWCMLdO35pmXmJxgLco4bSYRSfHyW0KLK334OhN4CZKqiMBMK/0jx69ySdTvEOxCQG4U63SXqOP2aktSmY+t8pqkiu/NgnXtiBQzOyPdNHTxMs+mGJFVXy29E3n136TzlHBr+m2XtpWpW52FcH3MmcjbdRu+Rj6UTRWLly5P5UN32yrWz71cBh4mWAXExHtM3A2pPuwmrUSxdh2Ne5QSA0LDGS39lV5FZdHgb/bb/SFDwTxkhOhhZgq35iB8qiz7mgADvcY8JKFT5RBnDX0aO3ceoBDTpotPDIC/vXcCLzY9u1QTMso63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTWLBrb4fL4nzNjk3Tbhv6WCgSXloJeYw3KGYpXWzDY=;
 b=RwHQX20f8AVgbmbjAr5s2gWoH0Tn4qbIlowT5D5qNxHePS+KzAliqW/mbwBjU+IdevPeuWQCcOWZ5MTYVIK/gzCaM1VAmTO6cHFwz/oppyvvkCsuDfTXTjQ/ahZ6dt9hm0vgAfT6I7h/LV4CgbT8jECVu/prsFQHc8PQPS6fR1lIm/E1flrLKnqtgUAmXWx3n1yRZGKHCqwPDwdcKP96B1tmO73JHRAbPppPXuIShNnkK78WHH4891k35i0Q7FXoKHhcveT5OnWhU+KXcKP9WU/xOPvjWPyUkBulb5IysF41VhgH6rDK/FW5VtMwieFyRdDJ84Sso9/replwmZYH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTWLBrb4fL4nzNjk3Tbhv6WCgSXloJeYw3KGYpXWzDY=;
 b=ADTAsatEjbZfubeZE118xAIp4pPyN+L4TO/oSQ1o4oCy9jqGVE87P+25gBg+sUT2IXn4mw+WG8vBePOCNil8iRs6TodlRKvvrslg8aB4MiPQN1ztAykMO5Z8mQWm/LoYlJVxht/Uw9Q5ulfL6flth/Vstzq6KViGMJDhDdz4HafqDy9vTY1OCaKPjYRl9+N3HR1i8425NOpJk6n6yJslaR6TQEdfK1NF+dULpMmNov1OYMt4hYsjcugmhbJ////fuaYnrQVPsEdJ2lPSH84g0kNnsHtfdph9vx9fvCUuJTKYNK8kQcC0AjrkvVWHHHzCABVj5LLue0SUBrKG1qOmuw==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by PH0PR03MB6252.namprd03.prod.outlook.com (2603:10b6:510:e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 15:24:35 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 15:24:35 +0000
From:   Min Li <lnimi@hotmail.com>
To:     richardcochran@gmail.com, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 3/5] ptp: clockmatrix: dco input-to-output delay is 20 FOD cycles + 8ns
Date:   Thu, 14 Dec 2023 10:24:13 -0500
Message-ID: <PH7PR03MB7064A28BA133E6A3EC98C17BA08CA@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214152415.14785-1-lnimi@hotmail.com>
References: <20231214152415.14785-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [/uwt5zhZU/Jrr2l2vsmunMFfCsA4H1CJXqRPSzHjTos=]
X-ClientProxiedBy: YQBPR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::26) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20231214152415.14785-3-lnimi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|PH0PR03MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2a40d4-0f12-4ef4-28d0-08dbfcb8c6fc
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnrf5XTkHvzLuPL047Guub83EEQFcvsLvQKYdqeeCjwGPaRFMq8YG6zAfARW0OKCwlG8add0wVZWzUblN8ZIettqhRTHRrH7oWGqoTknv0wzkCH/ScoysEOWWdtvukvDSfSaCOnb7nv0LSJU9nFWex+M9qUsCv8VKZ0MQUHSpd8xBF7XseQVS3kTIi9SaMvCWpwuJEIi5gh56iFhGubdE5jLTedoc3n9/laJeGkjJI/ENSTZ7dBHjcoVGn2qKxEE0bHJY2FjlN3HadCT0y0qnOb14hBDAOar5XeNmO9kRwJ5NyyIk4CQze/f5P4j7wyLn3anKyscsj0Lh6jnDZqImycm0yEImfP9HyeovbMfwFumg4Sroj/gU3uVZ4/dzMjVXpaIod+CF8eV4tAqQq9vFNWbAN1LBoPzY1/q7HLX00gzLTFxDreMOyihsxo68a1SeHz/pmnNaCzRr+B2FGjPWY5LDgYC4gUFG3QJkiAh0SOUHYzdXYmrtHKnmR9I0u7EDfJynfgVjK/Od6F2cWylnQxztE1Tc5c8sR5/eT37tOD6BMeCfLd/Mi3TS63zmJBTXVNxxP7r5b9GWxKtHqMpNFv030POhm7dDX21GskvTlPUZ4bY12sZTl6Y/A8SJODpAixnvrJX2fpNHQdmWA3WNDeKFBAKt3TF76O1ecERCvlFz5CNVYpuUe/YnL4lzSBqQSFHIimrEUq2sIzkfqw0TjU9a0WKcBpwhatz4lzJo6UXY36fyJZsKk5klH6bFYf3axY=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBxw+fbdyIjAcrWMvA40bkEkvhGaBOzaMnAvH9ESf/22yIdm2w2iAeaI84fC35ATkTgvMI5DtjBAYftwbarh20BQw5G0axAlvJiWGsYZmOYRX4+e8ZYa7dY45uZe4vrPdnwrciRDPZREaTZIFZBgh/Fdx20VhgwmFYopHn9YnFN6SfIJfgzjZUJNEXfjeaL8Tzo13keb9rV00lHx+Edpwzbkv0Z46wgeCRp6JgZctlKAv1JWIUJ+uHXCB9beZME1DUJRBy4BRRo3LIrdpoC0ci8fTG8fOXyJ1z0MzloztOe8VPL4jilDZZniWgCyDjdkfiKMHciXm7MyBAkQLYZn4jZIUlbu+J35bh2nla7p/Tc9hWyeKkVUjgz580kaIUpC7VNYwzvnwA5YzMe4wbW6FEPJHk7nmN0zoMOPlhGc98peXMvImXk5kE3J4fjgQ0yqcHzJ32N4sH0hTanuMlfBnnATX1kg9o/FSes2ZmWxIqCVql7XY8oceQTyJedZdEDm9QJGqRqtxwUhx5dnZDCqX1b984BfafWYPhagISTEJ9eZchn3gZEMc0nLF3BNAr24
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6JsD5LfQH/WG7NGeVUWRh1q5Co9qSWc5k5jw5Jo4KKmezhAK0VwgFatEUpJL?=
 =?us-ascii?Q?1B5jfMTefeSjQRwv0L47+hEQgD9gjvkxL+kCNmDh8YQY6EfAUd+iEgBHY0KL?=
 =?us-ascii?Q?kRoXkQVyLAXCO92BoKTaj2Rj77EexWu3dkOk4LfbRyppWqcXLQT52QN/7qDV?=
 =?us-ascii?Q?i4VUn/zZsOqPsUl8pe9MJOvwjFTrQJojFrOE5sCRU6JgXJRGMCJ/UrK031DH?=
 =?us-ascii?Q?LO14zaIy1vHfv1mO34vZNtWujyuBt8ZvEHxlJ8tu0b/yvPZC2MZPE9rI0cJK?=
 =?us-ascii?Q?vGLtZTr0rjSDA0/OuuXAieoIPNFWLigsFdvQFR6uBGtCBFj5rItwP/3hBYaV?=
 =?us-ascii?Q?8na9vZE8cTlQMW67xM92qPrHE72A6zaIQo+AR4f4DlohQO3ZP/aus893jqu0?=
 =?us-ascii?Q?Y5eUPQCBg9gWYXyQ3fZnSx9Kh21Tu5+YT0yjgQZJHnIXaWjBKdDq7+05RuzR?=
 =?us-ascii?Q?fhYSeN+coMHYijU5QfZPS5TD3MzxwqLC+R5+Sr60WWJzQad4LEhoVtoTGSs4?=
 =?us-ascii?Q?HrXp+PJxTPSxqYN4iAYRsunyX37+Ro0YFVHmbpzhYfiIavjy23NHNNcEstR6?=
 =?us-ascii?Q?X6xq/6wEjeEfc3RYFn5m6FuYTuWlMG47a4Kd7hDVmc3yCzGcof5n+3tMHyLH?=
 =?us-ascii?Q?LLu23Gaz+Ou+BD1TLvK5EqLQyUTdgcwabyS38mYuP1fl2ACoKzFpQSxTh5xw?=
 =?us-ascii?Q?MkrUWynkW6NFmkVa2nDvXMzYWo0sBfdyPUYzC4qtWmDjlRTk1fYmHLLY8H17?=
 =?us-ascii?Q?Dq9G/YgqiChnmlE8YtsZnl04IMXeipsKPNi7J9ixE8YnoNlSa73B/Y90us5s?=
 =?us-ascii?Q?KcWOZm3/AKaz0bJvsMo3wpv44sKdMu0qnblAxdm+c0BZE1UfWk+Bof6w++9F?=
 =?us-ascii?Q?+udzIBxA956Y+tg/Kc9mmMSsnanl0LrWyGNuOkKbqKCje1Chsg3y+rSDz1TH?=
 =?us-ascii?Q?4IpDmbBu4Ls2It/FMveRrxbZnYIU8AjvzC8bw4ysLpuG4QDaGSHHaM3sbDre?=
 =?us-ascii?Q?54moz8hIwESQSQEuMr4ac6aN3lMyS25dQY/QssZ2NFfnKOP+T2oHgqrgxF2G?=
 =?us-ascii?Q?Xm2MId0qHwahnqPP0+6i26G+sLUA26Zb7ILEkH+sa5llmbHJcbWoep1fEg8V?=
 =?us-ascii?Q?E5Yswa9apEM0Sqh4lJCVmgRABysBj9lqL62JlN2v9bNJtx8NFgsItEJ3ciaH?=
 =?us-ascii?Q?miufLMetTRS5oaUsTs1OWassvkzr1Oe8AqglEw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2a40d4-0f12-4ef4-28d0-08dbfcb8c6fc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 15:24:35.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6252
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Li <min.li.xe@renesas.com>

Set dco input-to-output delay is 20 FOD cycles + 8ns

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_clockmatrix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index d069b6e451ef..21f3a2c179f5 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -2165,7 +2165,7 @@ static int configure_channel_pll(struct idtcm_channel *channel)
 
 /*
  * Compensate for the PTP DCO input-to-output delay.
- * This delay is 18 FOD cycles.
+ * This delay is 20 FOD cycles + 8ns.
  */
 static u32 idtcm_get_dco_delay(struct idtcm_channel *channel)
 {
@@ -2196,7 +2196,7 @@ static u32 idtcm_get_dco_delay(struct idtcm_channel *channel)
 	fodFreq = (u32)div_u64(m, n);
 
 	if (fodFreq >= 500000000)
-		return (u32)div_u64(18 * (u64)NSEC_PER_SEC, fodFreq);
+		return (u32)div_u64(20 * (u64)NSEC_PER_SEC, fodFreq) + 8;
 
 	return 0;
 }
-- 
2.39.2


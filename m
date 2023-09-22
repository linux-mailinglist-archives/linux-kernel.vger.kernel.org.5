Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FB37AA7A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjIVEPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjIVEPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:15:19 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DE5F1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 21:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3ppE/YU9+09pTEUkABxreIZxqtQMZHDiEsGMpHtyeDu4RuXJuCkd5U5h0mmXsIjTywqxqznu/b0FKYj+tRvKfEENL14oz21hfGSuCPQkEkg8MaqoOU6LPcF1etsqB8hWHvb9Nw09Jo5zBeW3G7GecSIdKFwGN6OGWiXYHcbAu82CsvwQeCSie+qXJyPRBBEP+ClXSM3ywsAU007Zgg7pVG3NKL4j0mj4nE8JNwSTMaUMXEVUbaISbpn5wYF2MMHbeHCwgmfjtz/MiFxMucyiTNB+p6S/fI7ohT4kwu0OV1lK8pco4mQ1Pgy5hk8fUMdU1GcgYmjnlqqS4q/Cq6C1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t8UNqZ91plZHBALd149ETXAJYAtNkZTNbL5vXPLBpY=;
 b=YDmX8ztWo9pOh6Ao/pOa/Uht4bcJghh3NT6ZFfdceDic67clg4dfR/KjiuqsDQ6oDm4fEvpXNhYf9vUZH/nt//W1l7dDnlbry7it2X+X2TY3/yy5PSraGPpgqojO7mEfW8111QIe3pjBoxZAqq3Nzf7Ou2389jzQxNSbgkxD3slKvQZzbAa4Ho4rMW1zeD5pxyStHQNP2NCWtFcXTX+JymMUxHbO8zlkm5o+Yt6s82pPJZ628bF2Y0tZl0OsFXw/Q4RDLEgRjucqAHpuk511304/eQZfR/90AFvNcurErez0jmGeJnJIwD/gFWIKVvfRUzAmv4eszS/feK50S2t6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t8UNqZ91plZHBALd149ETXAJYAtNkZTNbL5vXPLBpY=;
 b=C3DSxKYtN/30YoWp8iwzRs48065vd7RSIfe8p41hihdkPQt2MjxRGgasck/8idwu0KYYJQLg5eR59ItoTnPgAE/Ye+yXFMtv6FyBh21dXN0qlhFjRIX+qJvqBPvPWm7xSpNl98PooMqO74qgIao3JRLSmcI0mazZH3bfrIGXUuPeFjaxQuv8kcO0FLKidY4sVWo5nmP5RzfDMPpOGlDUsTE/KnalbUfvSd7F8Q/IpnXigwChCDMriDJKrQoj0Pg10YwEDq1lRVthb1dcDUK0if90MMePSt1miL4CVyWpUMqMIGLF0kDyLCpOqV2gZUXfaAl6gdbht3xjaFk2z+0bGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEYPR06MB5326.apcprd06.prod.outlook.com (2603:1096:101:6b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29; Fri, 22 Sep
 2023 04:15:09 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::832:19a2:2f83:1cfc]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::832:19a2:2f83:1cfc%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 04:15:09 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: vmscan: fix the kcompactd order wakeuped by kswapd
Date:   Fri, 22 Sep 2023 12:14:58 +0800
Message-ID: <20230922041459.122-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::9) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEYPR06MB5326:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2fdce5-b7a0-41b2-47b8-08dbbb228222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pl34tSMt4BIZp7eCiq87mC3maYGm6ZMzE99vyhHt1vwBVTASUxNgXt8hSmut5ZkpWLY+HMFsRMnApIfNiR7IUfBMWpPHFa8M77kcrNx/Ihuus7AVDC/azhWio1A1WCNiqHGACI68AaEQA+t4x5w4yra6ONvMIzjT1AoQgoVZko5eJIuKu969noLftIZVhcTU/BYzm3oIv9QZRNEyB/EkcwxJt1If09Xat+nNiTlBF9bZam5vMLN/xSbLqYFCzJUqY7qpVDjMK2uvuGk5Duk0F+8hm4ysQZ6/JKvNEH3tBlJ3OmeIboCEZfhCulSftReqNHQrfYOwnBIsZsUz1YDL52u1gXWqJNpEaTh7aCXOFT1TK83WGj/+fznVTdnS5mkVCSPHF/ldbv2iGt9Uyyxbn+1C5hyoPiYt4FxKQAgKBhKQ09liIHojYXwkfNrs8gSSMS0mLfy6N8MJuEm3bS5/BKaxtpV/JX52XzqNTVK9hJ+HphKWpIihb13ZJ4vj/nZbol3QrHo3FcHe8zi0DOp76zkoBlMgbdcA42UaFit+vwbAGbHAeFB7nyBpJ4eTM8HpBFyOvHdz6V+F9Hz5CD2O3gUO8y/pHtQSLsDlC7+q1sIY5oVUwAeCvkUPf0Pa3I3u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199024)(1800799009)(186009)(36756003)(41300700001)(83380400001)(6506007)(6666004)(8676002)(8936002)(4326008)(6486002)(52116002)(1076003)(86362001)(107886003)(26005)(5660300002)(2616005)(6512007)(66946007)(38100700002)(2906002)(38350700002)(478600001)(66476007)(316002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QQYkZJZ9EF6mexnCbXciUz1ip1MYkANJ4t69icxhLknfrJ9bx2mCsJI/gSnf?=
 =?us-ascii?Q?SPvP49jZo2u7gmauHPw07M568++W5A6OFTkRMjOM0WYgPlV14/p6ISPvFY7S?=
 =?us-ascii?Q?yZEBKm4ue1g9HoB62AfzGk2r7brhGf2vYAmbR4ERv19GMkf1IEMAq2FS+FaB?=
 =?us-ascii?Q?MEBerd7XWTnkYn/9rRGJNxBO88f4GMhFwe7DRY96cSjE33Ya/hL7+U9+wk3M?=
 =?us-ascii?Q?4D0QgoqsLrEnZ1kIdo4nvF73BChIjyd+cbxJe01Y9fCxNJXSqbIN05GcuXdK?=
 =?us-ascii?Q?7OY5O2Gr++KW+Z/W8xZhOMKFyIGrelwBzb209rT6anPzXVM2kBbk4rt466ER?=
 =?us-ascii?Q?FD1RHzJLi7G2iaiNgbb4vagBBWq8PdX/0I4XRfDa+Bhh72TnxeyJwT+G7DCT?=
 =?us-ascii?Q?A6aibQLRjul4Yu4uKrVCKUzYqxEDLEA5IPad8VTA90VCuqygj8pcGnDS8+FY?=
 =?us-ascii?Q?YPSj8CJ6aY4Rd4rFf9PcnORMn393cOHH5VOMQ/VjOKP+EIcpxqDnQCwry0QU?=
 =?us-ascii?Q?RZVkkg/1+fOkpJh8vMG2BspcelLXEBgBDAZlxgI0UAM7m3A9SCCm1tyU735Y?=
 =?us-ascii?Q?xYF3x7NrwVf5c1kXmAYoD8o3WgM6ca8eGsXIux5r2U2SJmcwkrSzkVEYryex?=
 =?us-ascii?Q?jxTWRJs+7NHVqcG2KKPy/Elg8QjFfCHg5F7h/fUh080AnGIjyPSIjzFET37L?=
 =?us-ascii?Q?QuqR9djcRmeXEbqm3kSLHaXrPErlDpRBIVK5WYJTaRLFooGJCyXazUvjXEVL?=
 =?us-ascii?Q?p28SU+2EHcwcgYR9XkoJnwqiOlqPA0jnu8/4++XMHJhGvSA0SZK4VRbpCAoQ?=
 =?us-ascii?Q?zwYt11S7nZ+vV/uwZfYf9LUL+OK5boxT5suXLcpPF+qp+/E54Ra+CrjxA9Q7?=
 =?us-ascii?Q?3Spj8/ZvWVt2/wK+2xopGT8ksxTRakrJ2jrDkPuKPtplQPOLoeZu6pBFkd1R?=
 =?us-ascii?Q?wGEJh3Cx/a27PV95uD7mjYIz6P2wd+S0fVx5+MbW7FJ+CNtzaXtzNj16d1lk?=
 =?us-ascii?Q?d4Qn+iTC8ogaaHPVCWIekVGDwYZs2IRmAW6wOSvcN/2pPgMlBkc1Oe4KMqPK?=
 =?us-ascii?Q?s5rX/GKyDOilzvFXVISgwfYof1rW/u8RvabRqJZy6CDV7c5OtZQBVhLWnjgc?=
 =?us-ascii?Q?mHlMXf2ixFbjrFFjAbq05bf5NKhNStt2sMb3WuLN0jC/1RRMqn5BuQslfeZy?=
 =?us-ascii?Q?VeZWo29fW6B8XzVQRZoCqlGsJBJEjElczyHT+Aia0CE0N2kr8cDoe05wINZK?=
 =?us-ascii?Q?YLv/Y0ZG0+/r7KoyYqSBUYZSOTSwElCRtae9GpnyR3pSMEXrdauqKUYfUn0p?=
 =?us-ascii?Q?rQ+6jh68vWf5Vcw5hPh/7BgN/XuYxQKbMBfbZZ6BsH+DmwBZ0RcUr7vgiPXD?=
 =?us-ascii?Q?w5/7hDu0nu/4h42SiyU0pX2GQbbDG32XzKC2a6JB7L0Q2Ofx9kZrPLhc2H1E?=
 =?us-ascii?Q?gyT88epGXp1OdyQPPRMcwQBH+O6HmYx+S8//6D0HCY7ok+0UGLT1qpE7Kn3i?=
 =?us-ascii?Q?HQljC6zDa7ZMBe4xqCBsXe/iMH2VgiBTddZ512cbxA5GRX1FMWQd7yL24I5k?=
 =?us-ascii?Q?QdXyWbCj5x/P+ieDK8UYGqktikrqK5Y9eeAGPSR2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2fdce5-b7a0-41b2-47b8-08dbbb228222
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 04:15:09.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlPxjtQ9LJ/0uCu+OXlzppKHJwAED8mlmSyVAAJ4x85+IBAVFVzCQ5YmRsbHU1Vyr2DlQQS5q1yHNPheRxzxew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5326
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kswapd enters sleep, the situation of reclaim_order < 
alloc_order < pgdat->kswapd_order is possible, so the kcompactd 
order wakeuped by kswapd should take the max value of reclaim_order,
alloc_order and pgdat->kswapd_order.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/vmscan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 mm/vmscan.c

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 48c092cc6088..95883bbe2d29
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6955,6 +6955,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 	 * succeed.
 	 */
 	if (prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx)) {
+		int kcompactd_order;
 		/*
 		 * Compaction records what page blocks it recently failed to
 		 * isolate pages from and skips them in the future scanning.
@@ -6967,7 +6968,8 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 		 * We have freed the memory, now we should compact it to make
 		 * allocation of the requested order possible.
 		 */
-		wakeup_kcompactd(pgdat, alloc_order, highest_zoneidx);
+		kcompactd_order = max(alloc_order, pgdat->kswapd_order);
+		wakeup_kcompactd(pgdat, kcompactd_order, highest_zoneidx);
 
 		remaining = schedule_timeout(HZ/10);
 
-- 
2.39.0


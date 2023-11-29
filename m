Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4217FD759
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjK2NBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjK2NBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:01:34 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2099.outbound.protection.outlook.com [40.107.215.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE0FC4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:01:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfTvXOz0t/J9qagO8Whe1qUVv3Lim7NHSkOClBxZx0nKeQcIEpomAetJYcWSW5AaARhZ/vJYVV70UjFeCbnMEokxIxPStHYmhj8rWqdQMloGjvkRFZFhcaOli82RffWiliIeByS5UdvBetOJTebSK4Kog+VEXxxse16oqV0dQXBHl2QdZRU0w8ikOYYI0UhfvrH4sS3O8dgv5lKxwX9+9rAXH+7l43fNNxZU7zQ0VVZpkD68n7FcXU3jAMO71c+tTCe3Y0req0Vp7gk1/uJgRoafHf7DWGqDpfTrivR92SBitt7d7phLUzFXJcbhxiYtbZ+GLKiNzz8e9lcBA2WCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cvm/ujxTwXGNHT39TGAcjZCTuY6kyPGesTONZlmbL/k=;
 b=YdY2fVmYb+4EZCkAZvJ2MJnqNQCjgKkrwH2r/PJIJo+JfothO7LTB4N5S1qajzvY/EokKWTCHA1SiyWnV8eaCTUUneFAt6BEnoRCyXLonFBJBF9XpuPu6QZi+tfuEnuTusrqrABfXL5fYHBZ2o6w5mfhr/cbfYC8X8rKyXPOxa2AwtHLHR8c5TIziPCHo4UcZawiVVhiqZ5QjrN2G6iWX/oufOFmm25UY6NzgRaM75RFa17nrPHDShNiReM5u4K6UeV50AFjCHry1cFoW/edHKSQBUwiHUsMbASmdDlPblVhGBU+39DfTJaLeQKLo6EEXPJIswofWi+NVRN2Pm6/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cvm/ujxTwXGNHT39TGAcjZCTuY6kyPGesTONZlmbL/k=;
 b=kbv0u1pGsZgmQ9K9xqfpWSfKhLr6NbFPFUe9IL96FJY1Xx/gec+CmCGbmZMn+PWRhpWXFv9CInK3667YFx3IyKxxb5u707DdVxK/UrcvXkvm+sJ6qCaZ6Dkj0N8QA6v4eGbtHKJoRO4TAtqSylPD+rs7DcO9Fkmgbt3rbkJyz8sjQmFGIpUqIA6GoEoa7jmlRG/VdUQOzvzpq6T/1thZo4xKda99uyYlN/gxEtB6+WzOVnXA5GYAYax506w9Zv+M8lGnyeX74WQW+8GO5OIyh1DM/wmUWnBOSpXo12wOxlK4UOyyiifEP+p6coQVprjRs9nO23rDcQxre7tCYMMugQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by JH0PR06MB6850.apcprd06.prod.outlook.com (2603:1096:990:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 13:01:35 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 13:01:35 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm:vmscan: fix shrink sc->nr counter values issue
Date:   Wed, 29 Nov 2023 21:01:26 +0800
Message-ID: <20231129130126.2130-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|JH0PR06MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: cff08565-5a1e-4c42-584d-08dbf0db50b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCgwqDNBlrDPF7IjORd248yOKjvF4wR4ZTXnFzSlEQbHha0B+Tg+rKGDnap9fP0Z8gseipc6d4C5entAiUKfQNJYWZHhDheQG/6R08kMA8Vaa5/ZZupSDgc70zzUM58fCqJUe8GxOy3XK4din/PslOLsvsbeRHJylEvaNaAXogyce/7UQq3D8iGv5RDQybEVo55q/zeE81nmo6uLubs9zpELrFNFifUd7Ho6novFBgpfaI1eYY5r1lQTW5sugE00h8E5oWqyAD4JicFSnzKI2bSWAgVSLoLsvOcOc2YloboEQqhW45NESyRlYZ9Yh8V4ikAi9inl9qNXinXVZbaq1zyk9l98TTOo9hIRJFJbbZX9Xl5w7Rx3pGE8f75zJZDP5WFTdzgrMkklSmjm4Fa6zwnkwynTGi6zFyzLuRMEdhGReQhSIFYmTS/sSuuYBGgk/Tv32aVYfheIU4JaPE8ih+2sW/SnSSafT8sIOhsPXIEufc2mC94Oa37fCk33fwLdgeCkf0y3WYgeIBDoSArB2l6DYDAMVp14deqAO0v7wbzY0nWSd4S8IkEG7A1VA3N0n3m+/Q5R0vrZIp+huL57cpz3mLWzhowfO2bYqmxZ/YiKmPf5IpgvJl26heoElbGY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(83380400001)(4326008)(8936002)(6506007)(8676002)(66946007)(66476007)(316002)(66556008)(5660300002)(86362001)(478600001)(6486002)(2906002)(36756003)(41300700001)(38350700005)(52116002)(6512007)(6666004)(1076003)(107886003)(2616005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fq9IPqsy7Gsmpjp4z7baQtUHspAplg3LAYIBt1d02S7Cew5/vZOe3mNyMdX6?=
 =?us-ascii?Q?c+lw8mx6KqXuUH5lC18GMrzgYuI6VIWOOlfG/QcfOEzZBYe6tp6vNgTo7MyC?=
 =?us-ascii?Q?YwGxXR5ar/RASQw9sXaOehTEYS48bKXWJzoOTH0yEZDKh43Pn3bdqWk3fqfJ?=
 =?us-ascii?Q?W9qzKtCCNBA/Z2wPihMKLiqsyA3GDXL0wWGjzpwTz+jhiLL93S0MYeAsXYmf?=
 =?us-ascii?Q?5j0zEluTy4BC2WgeleApQfl1BnVhP0muh8/fcnh2fmmj/+U+zm5+R5Kk7NIi?=
 =?us-ascii?Q?65HtgH3l1UUJkMSJKS7jsgJRC13Na6mplvBGS81SFdt9Id6QvCkPw/hONrPH?=
 =?us-ascii?Q?ainGva0P89DjA7mG6qARResJtrpkYVcR5y4yB2o976sw+DrQoALBcwRFtxvo?=
 =?us-ascii?Q?2B3mtRzlkJDDCy5P8wh+hfh6ERwThVY7XdAjviXjwFAN6D9foNGpNFXG2EnZ?=
 =?us-ascii?Q?eN3sP57nGjdolA0PKnUKhyvbQSJMbiMqrRQCPUsIzlQzpvdF/zvjntV1yXy5?=
 =?us-ascii?Q?W0x96WtiZlS9WDagNNI/xyFuTQsqdEOhEoQ+V4tSBH65JiK0o8Xav4KlnTQU?=
 =?us-ascii?Q?zIRVT+lND3Cxx1MKVTKtN7QA7EwN35I3F4+0zUZ/e1eBvBFar9yhGwYZQ0Nu?=
 =?us-ascii?Q?hXYQpHxbLFhcfSwWF972xQW89MFNsuQnJfoFQxhcR0SsZFjp8FUqo5PvmVWV?=
 =?us-ascii?Q?btT45Ql+CZSq00sXodItTn9H/2/K6TpSeHmCBsSuUnHzrpb2gvQBSU4PzzLG?=
 =?us-ascii?Q?5GynP4mMGSjaUMOvhMY7r59kHU3kThbljOLuM/C/X2nvgG3zpzcW1M17lhGH?=
 =?us-ascii?Q?ydCdoXvMM4FMaET4i6gZ6RAQUPYOdQ9NOPpGejWWyTuS6MUBQACNiHB7D8oN?=
 =?us-ascii?Q?R3wLQVpxjNJxhFdfBYH/LX0dqS74G6jibEWSXNwo34n43lmAkbg1Td5HD6Im?=
 =?us-ascii?Q?aa82w8DavavusnoollDF7SrtIMPvVQ9O/A7ERlcDRppVTyW76b4qZIWDwEi+?=
 =?us-ascii?Q?Db3F4cq3Y/297jvZPo0i7vDhgp0oN7CmjwpK8oZn5i5Rpu4djTOoSyAzEQ07?=
 =?us-ascii?Q?05qv3Pdf0Ft6reyQim0ubQ2AbFmRVEEzcbjwXzDC3HGp7/sBWNvDr8ExurGY?=
 =?us-ascii?Q?D6A0x5PwdHDzw+LpngLTWGEJf7l4eSMfKdyco+QpLIaIYBfU6hcE/Fi6XKr7?=
 =?us-ascii?Q?DLSZVpYMyhoUI18TzQDCAEaByu273CN4HfFgCZgA7LApb/cPxmBke/Sizbph?=
 =?us-ascii?Q?EDQ1KuRcQSRHpS+9uJiR+EqoPf3ZzXQrZaB3fyGWTHWSXdhe8p2tP83QTUYL?=
 =?us-ascii?Q?zCOWkJntBLWyCj2WNWVrJ8AWUO8ODrglKfWZ4SFaO24MqDXdiktG/AB2QGID?=
 =?us-ascii?Q?pu30NUQvMudYi2PTrWgWOeneu8umFM8r+T9HmMsEp2XVv3t1gR6uOpS6+b4U?=
 =?us-ascii?Q?3x0FYcebGArwKNUPq6kLdxNu/jkG9360ztwYFDADtVdDxt/+1v0GL/CWY1vM?=
 =?us-ascii?Q?QhbFwvqAX1cu6tU6aGtz7Gk8QgkzpMbyH9llyskUy5X9x1UZxYT6An2Pz6uO?=
 =?us-ascii?Q?DRpVd6WME+XgN13cqKNQcI1xo7r30JGy00SxDFxq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff08565-5a1e-4c42-584d-08dbf0db50b8
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 13:01:34.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKNs+wwByg0UKvMcDYEzE6sKq23/QOTu2mCVBA6jKRfShKJ7sTWfIhawpWdStMW/fNW2a5e9GnBACh5WR9I4QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6850
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is needed to ensure sc->nr.unqueued_dirty > 0, which can avoid to
set PGDAT_DIRTY flag when sc->nr.unqueued_dirty and sc->nr.file_taken
are both zero at the same time.

It can't be guaranteed for the PGDAT_WRITEBACK flag that only pages
marked for immediate reclaim are on evictable LRUs in other following
shrink processes of the same kswapd shrink recycling. So when both a
small amount of pages marked for immediate reclaim and a large amount
of pages marked for non-immediate reclaim are on evictable LRUs at the
same time, if it's only determined that there is at least a page marked
for immediate reclaim on evictable LRUs, kswapd shrink is throttled to
sleep, which will increase kswapd process consumption.

It can be fixed to throttle kswapd shrink when sc->nr.immediate is equal
to sc->nr.file_taken.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/vmscan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 mm/vmscan.c

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d8c3338fee0f..5723672bbdc2
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5915,17 +5915,17 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
 
 		/* Allow kswapd to start writing pages during reclaim.*/
-		if (sc->nr.unqueued_dirty == sc->nr.file_taken)
+		if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.file_taken)
 			set_bit(PGDAT_DIRTY, &pgdat->flags);
 
 		/*
-		 * If kswapd scans pages marked for immediate
+		 * If kswapd scans massive pages marked for immediate
 		 * reclaim and under writeback (nr_immediate), it
 		 * implies that pages are cycling through the LRU
 		 * faster than they are written so forcibly stall
 		 * until some pages complete writeback.
 		 */
-		if (sc->nr.immediate)
+		if (sc->nr.immediate && sc->nr.immediate == sc->nr.file_taken)
 			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
 	}
 
-- 
2.39.0


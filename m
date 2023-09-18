Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494107A465B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbjIRJuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239281AbjIRJuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:50:02 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2114.outbound.protection.outlook.com [40.107.117.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1869A8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jb5A7/nrjdTy0+oAlzOEmDyxIC+XF63BYCXjt06HD1yV5QJAodEyDc49+W7wrDbnV9awrh/3h0MU+YAIwkTtCgqEtsAkG02FMVefHXhpfeflIsy5PViNMEQvRCdPXFlQ9hOjFbHb8IGAyYBFmjs7zjDNV2ATT99e67bwVu9JXeHk7oJbXysvRDRuSXQ7j/wriHUeXbo3fx+fTx3bZOrUUcO/iPwMAYVNGhJGK8T/HJX2hbEmFvwaBC8UEs/xpcq+87LeCkoBL+LuYtWHQ6VCUjse2ChxBCnUIrTS1o3xtaiVLFvcBFbzhVnaeFE0ub/JbuOccvpI+Z0Rnx7vDkwl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x46bwXsN77+lQe6o5h3k6w7NeKuYfv/vdkjHeoe4ELg=;
 b=TEQLktqTPfX0ohv+rMEpGVh9F8r0C/T7OdJ4odvMM+J5xvAPHu3w0Ij7n8671vNoP4lMVrMoAgF2owqwU3qyGk9VGMR3hQqQ8cGdvb1NG8cXjzG4Kzqu8Di2pL5tR8y1t5Jp/qMYXJbbBFyqa0JliygYTc++s0HQ1l0ax07Fqa0mDYAC77CwwzQVNP7wBdGuQ4MC5PemK9pb9upP6cnIPTCmx6czbx3ya/upt0hER8PwFoS0mIdLgYr8PHDwcNeDUkys3EoW039quBY9C+UjPljvSN55AmaaMNEG88RkAmvAE+3sH5oTOpQWo8j49M3dWyDlKQWwRSUXEZ//the0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x46bwXsN77+lQe6o5h3k6w7NeKuYfv/vdkjHeoe4ELg=;
 b=ifvnnANFgbtpFJ8y0VZIYCHF28D51pc3DYSAh1nev3FhAVgE8LIQADU2qbJwB9XS53xQvfBVn7yyRXZA7YMpg0v4+HDS9IOX1bFNwfSRDyYF52rcSIqnVF7+7UVW7UEz0VnBAM8lltAg1Larr9g4AF7HDbl/assIWMb6jRQ+f6JCEoIhQJdcKydEf1PXWlMPC2/1X45iqaANgdsIchxFzcjzRqd5XvXRX1Da25O58y0Z91+8Z1rOhHq7bg0zaWgbpx1E8g/Dw78Q+QkwUVU6qH30JqwooiLG5cCDGyiM+1FbGWorFl2drCpN6B3bZJQdUISB2ANc1Rat66hM4aw9Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by PUZPR06MB6266.apcprd06.prod.outlook.com (2603:1096:301:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Mon, 18 Sep
 2023 09:49:53 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02%4]) with mapi id 15.20.6792.020; Mon, 18 Sep 2023
 09:49:53 +0000
From:   Huan Yang <link@vivo.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev (open list:DATA ACCESS MONITOR),
        linux-mm@kvack.org (open list:DATA ACCESS MONITOR),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Huan Yang <link@vivo.com>
Subject: [PATCH] mm/damon/core: remove unnecessary si_meminfo invoke.
Date:   Mon, 18 Sep 2023 17:49:34 +0800
Message-Id: <20230918094934.18123-1-link@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0046.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::10) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|PUZPR06MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: f2335658-a519-4067-9a96-08dbb82c9ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GeVIO5aiL7Ls+3vHP1Ll0XLu8qVZfkqYE5UYoVeDIH+Im+iOEZr96oM9IpTfZCDU7sD8t+4d8IfEZuvvYPaqfCYWVhV1Aa9DdW3UUto7RqBE3m6d3tKkXoeyrduX+2Gi1YByygPLHOsKpI4A8rWafSn0dNoE2Bvla7r+ctknFFqb3mQ+6c24ovaQ76WKpFPmUi/vdYc5NKTtohqLwSdwAVueVh8nCLSa5h7uU2+HqqwqlJza35Jx0tTA4dNRaohxuifQRDYsbByPasOTfh+oLG85fC24ojuWjgJnOHfjgnOQ7DIFOckYaRtcM2kW8XyI27R3hEgm+E9N4zGXpkxDhgzSJtTTjZ1tSXdLKf6dFc4yBRwb7sGNPPBlea+HOkAApIuYPMDv7Kfl0IYmUEeCPfwCKdKIokpTm715S0sonF5+HAVaNGWXLd0A5fGl6Fs/Gnp4pQrfKvk/iXsNG9QkPFN6zhTuONEY8Jxc5Ax/s0wPJyQ2FJMLKM8YLI40VdnCKH3ez9/AceakY7QEOg/oMhXfqpnEyVvCkQvPvPdtnnEkwtGN49oCEbjyAfIEVskBJpRzQ4n7Lr68mPvQ6EC5nLUAMKEBYHU9+Ju/jWO7su8cbv8PUvDYr6xawGMM9c2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199024)(1800799009)(186009)(478600001)(4326008)(8936002)(8676002)(316002)(2616005)(110136005)(66476007)(66946007)(36756003)(66556008)(5660300002)(41300700001)(1076003)(86362001)(26005)(107886003)(2906002)(38100700002)(38350700002)(52116002)(6486002)(6512007)(6506007)(6666004)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U8DZ8QS9srUlEmmNB40yF5K18BnAhZ2xhLPw09yzom6tEyX4goO/q/zr0aGA?=
 =?us-ascii?Q?AlX1UX8nipr5WPJO1vbDv7vm9t1TMaPVQheu31DC0Na1IPDgZf4erBjSWQNc?=
 =?us-ascii?Q?Xmbwe8CPH5BF1qA87TkODffJTloahiwMBt5a2LaIsblKfSl0BJB7WVmYDFAU?=
 =?us-ascii?Q?Cfug8yWnR29B0C9SSIj9hYfN5d+RDTB1XEfObkWCTAHOv0D6RPZCfeRu2rcg?=
 =?us-ascii?Q?q+xfbrmDr5kxbUfB/PeE4VLOFdsA02mcnmT8eLbKtt7As2X18m2S/oMLqbpF?=
 =?us-ascii?Q?Sc9aPN85D8vwOKoTDL7ixoI7jXdYCEoszgPfsz5/f8mfJxNQSPYrterv0bae?=
 =?us-ascii?Q?HQpqxXPpcA2R7BduYo/oG3edgZ5EprrANrR3ftqIXpqcc5ybqeBb4JDOMH/N?=
 =?us-ascii?Q?/K2LxvMsWEb+N9p19VLEQlrUQ/RCFUIdvcjkbgcaUHPPGCPUPINaH5FPwfnz?=
 =?us-ascii?Q?Tfhc++yrQ6oEZdc9pPro3jX75RaFVjxvT3KYgMPCI1oedFdPEOGIJcRCMRnp?=
 =?us-ascii?Q?XPtQ96IeaKisknuuC+o7N9YPNwNYMxKvIvU1l2Sxads2M38d/6gc8oy79kky?=
 =?us-ascii?Q?jClou+rpdD1jTP0zo9+rrmmBPGj8cBHLnFqSVO2xYzTSkItDO8CC9Z8QQIZB?=
 =?us-ascii?Q?Uqof22tcYAYSrRhqkSwuEtJCUEFlnsG4b3Gqss4haMt8XnqcfAQWvR+cjHFP?=
 =?us-ascii?Q?nxDfMmcgktPwctSEpkDStSs6IP0zLeyN+Sv6BuTqj0uJJmEnEVKhJR0t5UTs?=
 =?us-ascii?Q?DLviCZlsqvHcmv8+BrxFu5RweW2Y05J4iAX2YI28/p5jP4g3Z9vT2BdgdWLV?=
 =?us-ascii?Q?p0R2btMRav+FRZCWeCuWMdD8C+MPWCepo9O17a9xL6WHcXtxJhiHNJTINRVm?=
 =?us-ascii?Q?mAfJ0n6Ope10VTr8U14T1wodZyyocIUS97FUc2HGlG9TLyKJ2y6mF2HZPf6R?=
 =?us-ascii?Q?1iIihxGfpAKkkvTpbtRby1IJzKb4FluKa22PDRm4NX9IOCc4CCqIjifNKcbX?=
 =?us-ascii?Q?kLfTx/KY2Vq7xMg162+9I0AkwETjSqzQWbumOIpsBPNAVa+mZE5X5iv4DQdK?=
 =?us-ascii?Q?GMXHvZUPVdLU9xfchpxTiWO9htbBl6kQheHMuyQ2y3mX0YEVntJzViHQJ+m4?=
 =?us-ascii?Q?K4oov5+gay3IKv6dsl6QBKWmeH7bPS3tiizPQggA619HE1Audzl4rJgp0X6L?=
 =?us-ascii?Q?+f3TFLWxuP22fjfaZchkdPRPpPpEwAeu6s+/4hNGYm6WsoktDWx0S3vOrB7Y?=
 =?us-ascii?Q?Rzsu0FdaDwfQHSph0yiE1HiATAHRIU33Z6ux9l0URIbImrNn2NZP82Bde56r?=
 =?us-ascii?Q?RJP4y8yCAHA1d2ng5x7viLyzpCPf2UPDf05iIl9GQMnFNi+xllJwZN5Zb32B?=
 =?us-ascii?Q?Hj9iqjZwuWOeXf9LySaduCmtDPXpSim0mBqa6SGgeyfKB9plDJrXwD2Q8l4O?=
 =?us-ascii?Q?TuUuokxh453Ut6ChRZc4xX2vDZnN+u8eY0M4RJoqK3gz9y2iFgOeqpKBxMLB?=
 =?us-ascii?Q?wr00zH2v1E25yxkK0LxW9Mx2ved4AqitrOQatQN/EXBWHmxeYMNzd2Hsq8Tq?=
 =?us-ascii?Q?yQS23nbnklRcYutbP+MNGMf7GoPIfg1ZdB5+CTY5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2335658-a519-4067-9a96-08dbb82c9ba9
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 09:49:53.6145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGyshqNxMDdh15yX0DsV2EPjqLcVKDi4PTx4fQq3Pq8nZkNGVdDERGl787hcHF2Iz5p8pv9nhnYg3nfoApeQXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

si_meminfo() will read and assign more info not just free/ram pages.
For just DAMOS_WMARK_FREE_MEM_RATE use, only get free and ram pages
is ok to save cpu.

Signed-off-by: Huan Yang <link@vivo.com>
---
 mm/damon/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index bcd2bd9d6c10..1cddee9ae73b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1278,14 +1278,16 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 	return true;
 }
 
-static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
+static unsigned long __damons_get_wmark_free_mem_rate(void)
 {
-	struct sysinfo i;
+	return global_zone_page_state(NR_FREE_PAGES) * 1000 / totalram_pages();
+}
 
+static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
+{
 	switch (metric) {
 	case DAMOS_WMARK_FREE_MEM_RATE:
-		si_meminfo(&i);
-		return i.freeram * 1000 / i.totalram;
+		return __damons_get_wmark_free_mem_rate();
 	default:
 		break;
 	}
-- 
2.34.1


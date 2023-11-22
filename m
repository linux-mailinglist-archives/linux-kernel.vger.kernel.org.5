Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA24B7F3C82
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343619AbjKVDne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbjKVDnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:43:33 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2096.outbound.protection.outlook.com [40.107.117.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5255918E;
        Tue, 21 Nov 2023 19:43:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX+d1RNU01WVm2V5ZNhdpRaW6Hy5KTRH2eEiz20EhXSqHJ3Olmvf9hIUHkv8jN8ClvgKtAvgwG5jzeQIdsgr95IMboXSfxr8pepy6+iSVi35VLvXBRq8Dz1gt9MMk7BPC2ee7dQo7qFDrmkPaCkc2ldj6/7lO6N4ct/gAnTaq1+OyTpXiRWRklhsecjWlnWMRzVLdH2sQuddQbdPxA/vLmefgW3cWRYbfpUIw3IrrFX3Q/+QnCbiL+gzFP/mBDSjtWC9Hot4P5KOPFScD3coS9sAZdNDP4f4Y7pknjIG2K0NOviqWon5nXZybGniZw/TvclPCSXxMKzIbs2lgUf1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/qf2T/5cEDHh8tPY410B8H5G0BBARESDNRqdWsycAY=;
 b=QHeJaVKW1ixqERtsuHHArAJv/ahJST8IFihIe3c9reFey6fjPhewQd+wJeh1dyk3gFBErWJ31uhKMKCe1X7IkT5m3CSFU/kYYNIFhILCReoT/3HWW/TYltEqn7CExM/csP2LIm0j84eHLfsd56P4g700FpgJrfRjvmYCtY6dM43hv7Q/S6nzg8hVMYoepQet2/8PFy9evQ4iVGwOaKsg0QXGu3jbGjxTcqubPQHuKSdulpfu/JmMQRBW9p/ivX63mJoPUt/cuc0M+rm7zCI6NtUTJHguch6nUyJ7yF72uSzx0VZgefJTOR/yQ9m+fecaeb5F6F7B5Gf3AGCMXMD7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/qf2T/5cEDHh8tPY410B8H5G0BBARESDNRqdWsycAY=;
 b=WGKr/J4MnmmWtX4u/Ojy1QjAj6JEnMu9fbo5E//7X+5V6C/CNdfzMuetRUMHZ6KasFp8T6fxvocDrnZfOQEXpopNd3/EK6QaW3eCailhcMQGRHguzSJpe/lUPjRAiJSFYvbDi4AZVxY/+rq0HSJUhMjPQG6xBfL+eGWd7fck1zN5r+keV1PbAPM0c7xEkBl4MVKjhVgT4RL6d+omK6db92xYFPQMhmM9ONpp+K6BGZzieILsaTJWxfh828i45De2pSRShRdeeLJ8hJmsu5jtMYoe5J3QXueyvS9YA8pKWta+elHBHwzyCPZ35jP7qqccbvDXrvWIpYine3IMnZkrHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS2PR06MB3509.apcprd06.prod.outlook.com (2603:1096:300:67::17)
 by KL1PR0601MB3891.apcprd06.prod.outlook.com (2603:1096:820:2a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 03:43:24 +0000
Received: from PS2PR06MB3509.apcprd06.prod.outlook.com
 ([fe80::863b:f0a1:3066:24d]) by PS2PR06MB3509.apcprd06.prod.outlook.com
 ([fe80::863b:f0a1:3066:24d%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 03:43:24 +0000
From:   Wu Bo <bo.wu@vivo.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wu Bo <wubo.oduw@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>, Wu Bo <bo.wu@vivo.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] dm verity: init fec io before cleaning it
Date:   Tue, 21 Nov 2023 20:51:49 -0700
Message-Id: <4257e74602bd0ea192011eaefdbf8a2205382b56.1700623691.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1700623691.git.bo.wu@vivo.com>
References: <cover.1700623691.git.bo.wu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 PS2PR06MB3509.apcprd06.prod.outlook.com (2603:1096:300:67::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS2PR06MB3509:EE_|KL1PR0601MB3891:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1e050b-9880-40ee-06cc-08dbeb0d2e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L3JaM5Xz4X8VnTQOCoUPQ03LdaS8/sabCPE5FVh89FIB2hJz+3hRzD5ATBXjK7nlFEJ0tOVxElqFYZ16qClYKV4NclL9n+93md8hpAuE082QwJ8oaFesrqPgcz7AxkUTFOgCPohbenlCOBEjZ7fjobw6s4X1yul8bvL0sKQ1uqVJrFFw22twBErxeQNx3NEyfmKBIshzVTIctfgqEbWKizO7uVsloTVJEVS8Dj6SRVKcVQQRlCD5BeiMGDYToFbX+02DdM2oFR1lQhSdDakXY/REAhx1czsPN6SRCVlbLKWJi7kjtgA2g5/VYjVL9tx5VhM62optKRHmqy8zbaBewwmjVuUYGRV5zjG+nh05WIXyWZ7sa+iBcqn6QpZff6k7hLuImraPvCKSVitjpiWcGsG9d/nopNBx0tcWQMlZgPm56HJNq6CqgcDEFuoZ5dXYrTRDpc4dLHpxrjT1SKbhXulEPf0UBeIqTIeDiWRwBBLfPar1evGEtivQ7nn0U9RfhZP29Hql+YrXT4UBkZZqT1qaADSFTR6B+ck6MWJ4FS8v6hUO0/bFCDIQbhygxV6HZps4wA8qMboccKkxGT5ODY4VGZx89VXS1qfE6WR/LQqOfVgUK5YlJkCgQRCWuHVs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR06MB3509.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(38100700002)(5660300002)(2906002)(86362001)(6666004)(38350700005)(52116002)(6506007)(6512007)(36756003)(478600001)(6486002)(83380400001)(2616005)(26005)(54906003)(316002)(66556008)(110136005)(66946007)(4326008)(66476007)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dUQx9MJIDtkTT29G+1fKJVcSkNBf524s8v7niimZAJ1TKxrZ0ShllsknesvG?=
 =?us-ascii?Q?xvOmKuV+fknORh3u77/G2XnDyaalBgo6h+bIOq0c9w+FZ1FjWdvny4gQzMvA?=
 =?us-ascii?Q?qTVI7nENz2J5gvdbMS++20igocf4aD2II7NQURLBtbQrWwexNiaYiDzoeG+D?=
 =?us-ascii?Q?DeopENTaO+qHki7V2vSbf4yb+khuWOnLRYNUqx2aePursGqa3qM8CcBLVU5N?=
 =?us-ascii?Q?8ZWvmFJTiyegiC/0hQMLb9r4r69XYXKHnfS1/GQMUhsgGpXG5CJjIuF80527?=
 =?us-ascii?Q?1XfwpfRAQLobm5B++b0vEKHd3Vo3LO8QOEne1hfQbwTWis5xLqkslVMvdbqW?=
 =?us-ascii?Q?MTdhq2Ew3U5hRTaHFr0Jss5qWidAPDllPRojRoohWabhuTxD0fVbdQZYwXb8?=
 =?us-ascii?Q?fhr58E7TXSBeQC3jDLZLgJqa01YlBAf2KZ/X/HhqTVDLQAl4XBxOd8jk5Uk9?=
 =?us-ascii?Q?+2e0y5Zwk69swetCBCqY8QQQBeo7dXkXOXGpUm+ZwvmI+JTmU4w1pNWmR8Am?=
 =?us-ascii?Q?0k417J9g5lbbEgcwTfbtOpXVIGNPZu27qkTaSsDTpz0AIJPFAFZf/wRjUCMp?=
 =?us-ascii?Q?poeXzh7PGrbajA6wLDe2H3IsDVwwt8ymcLlPOn1tLQFT3RkcwbBHxtJEN0Xs?=
 =?us-ascii?Q?34ZfDyHlu1m1ZsdR3mDCb504VI3LWVvfpo9uf3/cDzStczKN7noaoBnI1SMh?=
 =?us-ascii?Q?9qWV5e7n/Az0vTPxHK7hyNhh7YAvl13UME5mzD00Wkixl4KRtE5HRe0PtsyU?=
 =?us-ascii?Q?wA0bam7avnsDsxR1995CkCY9VrS4ZXISW/88XTILsYcQZAuPn++pdS7ZGkfw?=
 =?us-ascii?Q?zoFfLehmc+5RzD6Uqc+t+InHuDDidJiAuBO5DBQ1uG9N/loSAe1l0b32OMfs?=
 =?us-ascii?Q?oZ4uyI0hUGoFtHJjDS4CJZ4mGMyoWBspfB9dOradQzWAkd7WNr0qeoVjgYcl?=
 =?us-ascii?Q?A1kUV97BSGf3aFaRLKfULFqXDM464ye/FUur+4+oX4L8ZM6WxYwEFKFa672v?=
 =?us-ascii?Q?jRFtt4UoapfzZI10HbwP4ejR3YQRsoYEKcjwhzZspqjzyL9ci+OswHAMw77h?=
 =?us-ascii?Q?F53V/rsFUStmHKpSoN04jF6Sz3TW+bZBnNRXt7mhJ6Jw3hmbzQuR5QXNAXuT?=
 =?us-ascii?Q?atTqn7ek5pTyceJJNuLQURt9ENv0ugCz41lmmNJCtumwpiegaZQKGQMhtrhl?=
 =?us-ascii?Q?fXH1DOzvI/sNywsavIqXXVjF66eaZyz91WS+g69bdqarThcyZEGvfSuS3+M3?=
 =?us-ascii?Q?Cw1ZQAwiXHM6vmbhSDP8qPIKTz0aExBafAQb3aJch/7MmWO3Y43ZIA2yYabt?=
 =?us-ascii?Q?pCE8Q9eU33fjdxs/dJIa10Vg3ZlwxZWkhXGADiLjpXe310tdeNVxzQo24vqA?=
 =?us-ascii?Q?LE6fH6wnis7EGXzxe3d/s9ag9+I1NWwTDndeIlK5nJ+SWR2jl6L3ou65jngM?=
 =?us-ascii?Q?f/JwDIutvwZssVFST28qmS+sS2nZomK/U8nHNbRkC+jbeB6b5D02Ng41IMvj?=
 =?us-ascii?Q?w2Tf6bG+KM2iExjWPDLngxQdYhf3wQtLLcuV0m31FKNKlMtJTJsNyux/JmhF?=
 =?us-ascii?Q?+f9MwgoSGB8s4rMzDspqk22xvL82fhxpIPiWLkRO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1e050b-9880-40ee-06cc-08dbeb0d2e2b
X-MS-Exchange-CrossTenant-AuthSource: PS2PR06MB3509.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 03:43:24.6514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mls7Y7bMWyAcYBDja0x9T0j1v2k0BwowSnE7Tg8Cqhr1uYtCx1HvZkTV/7vk3ZAV0AZQhclUPyUYI6SxSULQtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If BIO error, it may goto verity_finish_io() before
verity_fec_init_io(). Therefor, the fec_io->rs is not initialized and
may crash when doing memory freeing in verity_fec_finish_io().

Crash call stack:
 die+0x90/0x2b8
 __do_kernel_fault+0x260/0x298
 do_bad_area+0x2c/0xdc
 do_translation_fault+0x3c/0x54
 do_mem_abort+0x54/0x118
 el1_abort+0x38/0x5c
 el1h_64_sync_handler+0x50/0x90
 el1h_64_sync+0x64/0x6c
 free_rs+0x18/0xac
 fec_rs_free+0x10/0x24
 mempool_free+0x58/0x148
 verity_fec_finish_io+0x4c/0xb0
 verity_end_io+0xb8/0x150

Cc: stable@vger.kernel.org      # v6.0+
Fixes: 5721d4e5a9cd ("dm verity: Add optional "try_verify_in_tasklet" feature")
Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 drivers/md/dm-verity-target.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index e115fcfe723c..beec14b6b044 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -642,7 +642,6 @@ static void verity_work(struct work_struct *w)
 
 	io->in_tasklet = false;
 
-	verity_fec_init_io(io);
 	verity_finish_io(io, errno_to_blk_status(verity_verify_io(io)));
 }
 
@@ -792,6 +791,8 @@ static int verity_map(struct dm_target *ti, struct bio *bio)
 	bio->bi_private = io;
 	io->iter = bio->bi_iter;
 
+	verity_fec_init_io(io);
+
 	verity_submit_prefetch(v, io);
 
 	submit_bio_noacct(bio);
-- 
2.25.1


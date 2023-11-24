Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A177F6ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 04:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjKXDFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 22:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKXDFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 22:05:43 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2048.outbound.protection.outlook.com [40.107.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC88D43;
        Thu, 23 Nov 2023 19:05:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEbWaRxp5ms+DrgR/u21V4YNSnKR2GorfXHnNsQVt/kdFC0ZAJpUbIx6Fcf/QX3PwOc7AFZ4UcC17iYUFRnvhPDpdduYAbEDetY0fTLHMLDqn3mIk8x8Kp3JgNys1Id//HkDE8wrDfxpRdlC7X02xwr2V1R72k1tjfl1r9KmbpJn9JUHKnNAes9PbbyxmBnRDNQH2lhHgx4kArsophUd03KXEWpHq4a96VzBm9cKHw0grwwVd6So9rVfGSiIezeL/jOlyJ6imeflZU8NO++pXGd6BNZg6LVU8i/x6hynA/5dxsBnRi1V64O4u57zjY91zCxLh4dHCaVx1WGTDFpW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEV7pXTpShHiKKEd0Z55xc3LMiRvWs8kvXcWdqoecVM=;
 b=K42llC8Vt3CKCaYZsaKvFK5r2ReO5ovAG5CF23uT5AkbhXJgiO/UejkrZo9qS5geFW/gN7t7hncLumaZx4UgJ98QItY7habOgw2LeLrM4SPCfKHqq8qhyfoOP1OPB4vuQuN7FmwASU3MDrBpgemXZocbPd/KGSMH2iz2SAV9OsV74IPJhezI8eVGWdHLwBGe9wnsXFZaKrSVxppeOKQYsUZA6OKQMJVZ9oxbkr2/JD6ybfx9eo37pAaYoKDbjIi4HNn+qM0IoYfK4uc3RsxdNnuzX4H2kQf2vxzlAEnmV7BQXNk7UVwulkV2tSzn8bhMeurowJZpP2xXqu3rCr+UOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEV7pXTpShHiKKEd0Z55xc3LMiRvWs8kvXcWdqoecVM=;
 b=tq5uyujUE56pcVuogNPrKaEI+ThRbOpfOgy02/Y/u6B+WbjVarkfIDMvhCwcpdGi5KoIWfXtvsuUQDvDfgOtoK/D6Ck49GoC9Rp8BaV6FkUwGmgr7vV5Y878Lb65b6QVOyh95GXXNbtp1qt7PSzKmqU7jAcso562gzCwZ6+e/XsKqcJwQSQQ1TBkfbh9Nbdw4SzbgDO99GdbpztA8oI6s1r5w2ij23K9LW6h+IIneWF3cz6QewOJlcstIrs86ebJWm2MGuXFXirlpi3NzYlkpw5QCAfHddeGiWVAyN68Oeye2pgn5TIPjkzs7dEmUb0hq6DMlit17kY/Dpkg/qcdVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.13; Fri, 24 Nov
 2023 03:05:47 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7046.012; Fri, 24 Nov 2023
 03:05:46 +0000
From:   Wei Gao <wegao@suse.com>
To:     axboe@kernel.dk, dlemoal@kernel.org, hare@suse.de, hch@lst.de,
        niklas.cassel@wdc.com, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wei Gao <wegao@suse.com>
Subject: [PATCH v1] block: ioprio: Fix ioprio_check_cap() validation logic
Date:   Thu, 23 Nov 2023 22:05:25 -0500
Message-Id: <20231124030525.31426-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|PA4PR04MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c01b3e4-6573-4a56-5abb-08dbec9a40ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Wx2AlTvfVFi/quU1i+UPPt0KvdQii2Qa4O/R8LHB1gdRN2RoECkvkf6uNzL0v4UHTGNKwvaMl6lzcxZqW95gbZl5SqxZwEguG3LMrCGQivcmlhHuovX2nNDPZHt7kDnv9GvNRL61t5+YguxLuXlaCmniYBSgmyt7ACc1ldoTGWywspPtKyyFk70TTK78H73vmLrY1ohh9xshrVsRVt4jEQI4iVJtBkf0FOApdNZCNtiJabh/tqz65RXkfmGEULJ3UvfLMvesahSkOtNNa/gpxunLeiQuPgqIT4y5cvsgT+U6k5YqGJU6pp1uuMPi4mOb6er1ufZ2tW5UPhC3HdHBnm7k1EwvqqVmp9ne39F9zjpH+5KvdXnkJOgWfBl51qk09k0UPkE+GfV674AKokODurlSlPVGiAM9Atq1VmtQfESE+rd/UEBKL1SNdBP6KN8xuRkPDaWLx9uahrdHDFT6Hj8flfjTbCf6W6h3HQMPtXWCea82xBJ2lLFpEFnl5rCWLgKnB5N0FW/F5nGt27fRAEAB3vlELjf5w3qxn4OdLlurXMsxsJjdACs9UpXsPS0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8199.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(478600001)(6666004)(6486002)(2616005)(5660300002)(86362001)(2906002)(107886003)(1076003)(4326008)(26005)(66476007)(41300700001)(66556008)(8676002)(8936002)(83380400001)(316002)(66946007)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gWZyhRUAF/R3SmyP3v6SaeuC1cvBuEYNNvAY2q4wXsALyLWkNP5lxXR0OHRZ?=
 =?us-ascii?Q?QVbNSUQd3gM91KKlbybSQdHmtHmByyD4qmLWSA+kELeeKc2snuBpRe8Jgl8l?=
 =?us-ascii?Q?4u4INRmRi0IZ+7ZQhGoNRNHSCKR2vkoTeDsmGJEAv+ghw2Qrk5g55rv1BR7z?=
 =?us-ascii?Q?ByVE7SSsW6VorYw4TNzgDIQSsjNRHeoOzmFZUoDwX4guXHCBnNupJezG/Ky2?=
 =?us-ascii?Q?gRhcW9rnLpVRyGn1vWFDyrVM0b8YlGIwglpbsqS+rBVmONRkOS5l3jX29cT0?=
 =?us-ascii?Q?JiBL5t9py2m30Ms8w6Bg06A8ZQFVc2TRbma1hwuKHwxhKLK+66b/P7Ox6Hp0?=
 =?us-ascii?Q?BSaqPYErZ5ibYHlk5DiRnmXTC66fv452RyGEObKl+G3KoiSHpa/oI2tOr++4?=
 =?us-ascii?Q?E3XV/LXgBG3PY9y5MlXx5/NleOUBGHCf4Fptu0cPER48ZMn2unubwf5E6vo2?=
 =?us-ascii?Q?L29J4CXuhkV4cHfgFUPGJx0RgXHJiB3CH9E2PQPUMEVb2JCRX6ZSTa1MLgtB?=
 =?us-ascii?Q?cNTwYH++q725FCE9AYAWef0c0B6UmERAMny3aTaWbly6QPDpCSGr1yX46H1R?=
 =?us-ascii?Q?CqKrM9jDFCc3JuzjCL7o+T/N9Y5RjkxePbLZQsy6umy6Vt/JGBAS26hEXwXb?=
 =?us-ascii?Q?M0vMVYgtCq5senJj3XJeekhcJRNSyvrpPzWP02Gl7XHej57vqLIJKV/kfi6K?=
 =?us-ascii?Q?Z0fecYQVT6QRCnnVgBCzbRsamFfA4hdmtmh6uOdYO+e52dl7ogn5QzYD/wSN?=
 =?us-ascii?Q?lRgkLjROv/d1TmeCORG/9DbULl7pvrMvsF4eSQNHizTRqRtbQhFmmG5AYkUn?=
 =?us-ascii?Q?vcxWvqH4YTfD0/7k9g2nkV9HCg+kvA0gb9K6qun/TuB33PVrm0wQKmYdQ0kH?=
 =?us-ascii?Q?Os0Nq6EuQmDYW1B4ZSj7woXQDUVTUEUlXiOt6P+O/ED+dKihSnGR310VidgU?=
 =?us-ascii?Q?vP7YWT1GihFr7hS9wtmslzyKI93m4p3NUWE628UU0qrfqFQsKw1jW89DGVQj?=
 =?us-ascii?Q?sr5BR2/xkULTy5lranW/UVDMBzlmWE20n6+P/UmP0VXIH1yDMGGS9tpvYiIn?=
 =?us-ascii?Q?lbx4MIrrZHSeaWJImEKVAEqCrCpjrXPWOJZ6tBX2v/lBhbaGsYG857fVylAe?=
 =?us-ascii?Q?X87xYTlhubVtBymZcDuOVGjE0wifxbVUsgrhURt0hLARd4lUmFmVpUNhKwcm?=
 =?us-ascii?Q?KRKGMupZjWezdU5gtdX8NqIscBy94i5MrxAn3F4zDj5lMwFc+jq1UL3zacNB?=
 =?us-ascii?Q?2+9K1Xjxi1ZRxwvfg1XH9q6WAQFSFxAp57LmUwwboIt12kNIhGdUMYvQXeob?=
 =?us-ascii?Q?647kBYe+kw5gV0vloWa3mu8T+D9WWef2Dl2BKABdSFavw9VzgQCrbYk5xdKy?=
 =?us-ascii?Q?g89Uctvr+wzW8/1O6yhuLDbJbc9+p0fUNyAPXryYLe/TgrjCynEBzrw32dEk?=
 =?us-ascii?Q?76KmKVUcX2aMaiDNT07yHSlIWOZ8g8l1me1iYYu2RE6tTynvljk5U06kojj8?=
 =?us-ascii?Q?C5311HcUSFg7r9l0ndj6uxtEifOJRwCq+DVS1HZQtNYzeeLJoHwrqlZn2+zs?=
 =?us-ascii?Q?GSj/O5EhQ06esmrKP6k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c01b3e4-6573-4a56-5abb-08dbec9a40ce
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 03:05:46.8152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBhBOnGiq+Mn3YGwrb2zgzsuobq13ZcIG3/3hC4AGvVc8nNHl8xhoIt40HmVLGpa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9687
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current logic "if (level >= IOPRIO_NR_LEVELS)" can not be reached since
level value get from IOPRIO_PRIO_LEVEL ONLY extract lower 3-bits of ioprio.
(IOPRIO_NR_LEVELS=8)

So this trigger LTP test case ioprio_set03 failed, the test case expect
error when set IOPRIO_CLASS_BE prio 8, in current implementation level
value will be 0 and obviously can not return error.

Fixes: eca2040972b4 ("scsi: block: ioprio: Clean up interface definition")
Signed-off-by: Wei Gao <wegao@suse.com>
---
 block/ioprio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index b5a942519a79..f83029208f2a 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -33,7 +33,7 @@
 int ioprio_check_cap(int ioprio)
 {
 	int class = IOPRIO_PRIO_CLASS(ioprio);
-	int level = IOPRIO_PRIO_LEVEL(ioprio);
+	int data = IOPRIO_PRIO_DATA(ioprio);
 
 	switch (class) {
 		case IOPRIO_CLASS_RT:
@@ -49,13 +49,13 @@ int ioprio_check_cap(int ioprio)
 			fallthrough;
 			/* rt has prio field too */
 		case IOPRIO_CLASS_BE:
-			if (level >= IOPRIO_NR_LEVELS)
+			if (data >= IOPRIO_NR_LEVELS || data < 0)
 				return -EINVAL;
 			break;
 		case IOPRIO_CLASS_IDLE:
 			break;
 		case IOPRIO_CLASS_NONE:
-			if (level)
+			if (data)
 				return -EINVAL;
 			break;
 		case IOPRIO_CLASS_INVALID:
-- 
2.34.1


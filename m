Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63EB7D7121
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344176AbjJYPoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbjJYPov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:44:51 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C7013A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6elgvVcIb+4sdGMAy9d9mDn3LL4VDLxU5JQ9RMdvstoHXOBZmCGMLSbAzn9uQGb0MaFQ9aCnll2h1ry7umZ6Fkgy+wXJyXU2suNrdl9r3TrE86dCnqX1kGWfJC7JUjXVSqL2hDD21+l9zpSXs8X5ObcKhl1jBOjXfFa1gptNAMe3Hu9AF/B9zBPWg1xAzH4XyKgejSTzhJHGjbrNkCFz30a8l/DJouwfq6HxGpzQwuiog3RUgFyM7gskTSmD/rVEIo+5tv13G0pWjCJn/yIM+NwlbPq4P2UVOjMQ3L7lw7sVqkrP7SWopoDDnNzPwOmz9tWSsVsNqBOM+DyI99/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvsArkRNo1ef55npLUNg2F+7XfUqN03zzLzjQnKI1+I=;
 b=aOd7TuL3YShThzXUwfTFb0Ae4wnfrJFagXmVKqL+PnPBInhuI0Q/JLoR5ajHJO5ggEaKGqercbTif0tnSkFavm5mcrx2/HWk/A/GrXNaRPoh4L0FU3rExhMbiTOvmJ+0CoG6g0WbfeSDyjGSQEI3gxcmpgx+2CMxz0ie0CovlwS1/L4hClQj4qWHcDBA2XM3VgfErWBF98e45PqZmRXvPSKpKYtTh79FunQLmvr3aGT044R8aZWXTUKM+f5vsdEdyWk+PWRn4JwvFuh9swvb9FfpGu4mRL/YvQp2XJOJsjIo8YSIOT5qDDm/w+gTh0ievwjwADbYJEz0uu+usPBKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvsArkRNo1ef55npLUNg2F+7XfUqN03zzLzjQnKI1+I=;
 b=hQ/GRUSxphDVHw52/ovSTsVVMgvj3hM+pFo85ILKFSIyJUStVenyGnL/fa3qpDCAjyvqvGiT+1rtk+la6e9DmFS1BJ98Jxgq2ysnmadkNbpoRMHI2ZukEjpHKZyhYvdnPkmZUC8KN2TcBy5NULWOAO1gegNojUO2qgcTGyyYNREDHrHwIthjEwO31fbQnXtvg6BLRRUAOGMSu5Q5Pt/YvZi2kRkDa7trigzPmS3yw6X/hPIurhksrLfB7s3PYWJDBzR1TW9GW2JQDoCwF7ymGoOT8nKv9cxkifxvlvZhRaptJmcKOQxr9YD+8ykWg0YaI1ACjcqKz/R9wcwGffNtEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEYPR06MB6432.apcprd06.prod.outlook.com (2603:1096:101:16f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 15:44:42 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 15:44:41 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm:vmscan: fix return negative unneed to detect VM_EXEC
Date:   Wed, 25 Oct 2023 23:44:32 +0800
Message-ID: <20231025154432.314-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEYPR06MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 970935b2-ff5d-4186-e023-08dbd5714db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUH8cDUbpXWjkKvA5YKZapmNdkkwPTFw15ItxjmQQEBLJCxiostppzad4U24i6tUqVdQZ+O3ElkhTSMxwzRjIKvo+/JvXt/gnnF3n8pnRD9PpT6MUuKvbgZWm4iN6OkM+bvZqYv4bIwrHY6DcrCb2Bul1O4yJVRDTIe5kXaC1BJqw8CYVUam4qiUCiMMZLzAscalQ9lGzKRySITnQaCdwhHRovP/6KjxF6RCb6lV/k+DDkAY0ZterNLXXLC7WJSl14jN45mB+sD0sUrRR6LnVLxk6RUCCFZu1AbiATFEztk7cWABTIb6nnGiEIsVwPA+/F2fwEBTvRBnuZEsWhLdjxGbnec9nKT1ckvTpW8UKAyehQ0jjppQUXQY1meBdAU9q87eSonsFKcLjII+efwcsQNERKIBjc3Fp4EYOLSTKST5Tadn2j+Pe+WjECrLP/UZ2g96gmOGsRqsmyabD3RNnaamUTcWMazqrSuFbHNFXjQ5ZFBVa9xs08EvQdCL3FvjDTH5apz3w5Rz+JIhvog/uuGRVWJmVwjLsRTQwEAWF3tALlE+sHyfzMyPcQ8IxjXVuYxcu0om3VCWOsgcQF0FfKdx5aBQ+DQlZgls5MB/4Djs3l4pzyPssdwM4SUczQvF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(4744005)(86362001)(1076003)(2906002)(38100700002)(41300700001)(66476007)(316002)(66946007)(66556008)(478600001)(6506007)(6486002)(2616005)(107886003)(52116002)(6512007)(6666004)(83380400001)(4326008)(36756003)(5660300002)(8676002)(8936002)(26005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yx9BJwhYxVefEf54sVDejrgRIiE5s835WuKVCAHQt8VdYhF12VZr2PENzTU0?=
 =?us-ascii?Q?eah+DIFwKdO9h/mXbVuamZYEIo+RgpHvG5IZzodZ/Mt2ul8mUYBlxKOzCTVy?=
 =?us-ascii?Q?Qn50BRWfNVxvtN9y+bGUPSbxAz4HV3w9tWA5H0pFGDlWHOD8YbSotg1jd7Bq?=
 =?us-ascii?Q?IOHJFMyXQ5DYQDybEhenDPT4uKRq5b6WW5NOxP2umEOX7Gc5qTwacTMHZ9fg?=
 =?us-ascii?Q?nQlMvumTOmcYfPqU592K0NQlPGrYa0jpT+alekiJ1Nt8D52PHOnYLWK5/bBc?=
 =?us-ascii?Q?CLHAAlJnsrMIpg8NH+EUQAq4/1HUVU8pTktwtt5+LLjLf5e0sSUMPoLdGJmC?=
 =?us-ascii?Q?abq5g7u874qpOF/24Mwe1BuWxXr2cJKx6ItXSjz8pSwIKJJIHzSJZEMI+QzZ?=
 =?us-ascii?Q?hYW7uakb0pLhSX5jaz4KMvtBNqVeI0nhJveyt3pHql5wOCITgtCnSUE3i/t6?=
 =?us-ascii?Q?rUtIneSRVa5wyII2b6gmA8uhX7cEpV4jF9YO2jJvgA0thhjZkB6jixfSC42b?=
 =?us-ascii?Q?TK1rl6e+/a9fwlRaNBR3h0jbNw3Da82AUz8QTfws23HN3PXiJfOmT1DW4xpv?=
 =?us-ascii?Q?lQHez02FaXgOktEODqOglgn2C8b11EGcQzTAC4r6MKEDFiRxFntT/T41pFL5?=
 =?us-ascii?Q?WlttaaYDQ0gIsFZPwGKW97KsKU5Y4VgKB7hR85ZMPUvVoa0LaOww14VAkphj?=
 =?us-ascii?Q?W8m9Oz+HURM2Jj27obgxSl8UiVvvguctfbiFvv5MVSuDcjIA4gPuI5fOjQvR?=
 =?us-ascii?Q?XzSdDEA2iis4PDCEwx5qnItBw8fe5W+2E6j2inO5J71E3Rk9cooYAAnL0E2Z?=
 =?us-ascii?Q?6iF3G9jcmHJkCX/S79m0OzQsiGfX2+r9ti+Eom/afEda0fUboS5YSzNSb1T3?=
 =?us-ascii?Q?tVPsL//Ej+xz6rzbzo2kcMDZxJpvWclxOp7PWO168nUkklmigKYtluNgrWiz?=
 =?us-ascii?Q?xN0B1ldaA4mimX1NVEbOd74IrDpn3YR3N/X388+vSHIO+SujFLlTBP9ibBYN?=
 =?us-ascii?Q?DH8z3IXDaEqgh7WZOFhEyl9Mvix4kbf14vnFSGvAjB2OyDQoQt754IGlpbE/?=
 =?us-ascii?Q?u4tvccN+ryQ4mj+LRDlVqDBToxrjfZZ460l4YRRNs4k1LFlh+4/Koz4PX3s1?=
 =?us-ascii?Q?K1gFa2UhApSJWTPCm9/UvtkeEKdvLyDwplEYdhHKtVMAM8Y4Ow+y7gND8BMq?=
 =?us-ascii?Q?kl//rB8Wfg0Hp3PmRJ7UjKunOtfSa1lyIETagAxw8SdUks33nWyky1MuRLdv?=
 =?us-ascii?Q?oabf8VXIgOD5k8i8JyKK0d6vC5B3A35bRc5Jjibvg7TzvoEP2t9Q2bRbsXRH?=
 =?us-ascii?Q?ig952PtNd34faNt7JFyNqiGwlQ5/ePWdI9Jcd0/SRbqNWxN/kv6ZmJWUG+EU?=
 =?us-ascii?Q?c/0lwpcAllerz0G1ttoaaFtQlFjNKmAegLQiKhnwshLXHPvS0xPz2PbZFVHV?=
 =?us-ascii?Q?jybIXbLLp2cvLSzWUwSFc9zHlpxwOwqDhYsSut0jLvbhpvaEkgu0Dcu5W1/5?=
 =?us-ascii?Q?e97C8sS7/hmBsgn39p7ZDYHmERv1Xm91T0H92gC86B1gzIidzkce8BgwPXVX?=
 =?us-ascii?Q?WP3tYuVsMLUbbETEeqzNJ/wJDwl2Oge+6xFYHP83?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970935b2-ff5d-4186-e023-08dbd5714db0
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 15:44:41.6028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LN9UhsLRk95UIVoSQWbwwY7nVF4T2geMErgG9YgeH3ykq3NCV43vh6rJk79hYorq0DPR5UAOHk5ENoFzdBLFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6432
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason that folio_referenced() returns negative is because
rwc.contended is 1, vm_flags is 0 at this time and so there is
no need to detect VM_EXEC. And only when referenced > 0, pra->vm_flags
will be filled with vma->vm_flags in folio_referenced_one().

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e587dafeef94..f0b4325cccd4 100755
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2095,7 +2095,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 		/* Referenced or rmap lock contention: rotate */
 		if (folio_referenced(folio, 0, sc->target_mem_cgroup,
-				     &vm_flags) != 0) {
+				     &vm_flags) > 0) {
 			/*
 			 * Identify referenced, file-backed active folios and
 			 * give them one more trip around the active list. So
--
2.39.0


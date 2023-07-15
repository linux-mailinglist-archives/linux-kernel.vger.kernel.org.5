Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE646754A14
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjGOQQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGOQQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:16:47 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2010.outbound.protection.outlook.com [40.92.98.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7610910E9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 09:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLuQZLp5lTJfzYMvX0XUNtlsb+W67UySwLMxPN6j3MfjNyQS6B7N1Ti7LtXPyzUQjAdLbDCvmvdkdn5uTuhtoCv71z6Bdl4AcEXckR5kZX0Fo5BoURLdYvcnJqZKHwcD03Om/15zeEOD5pTHjmqoiTX63VJJw0wZZDJXSsQp5Wkujwkyzv1XiplenT8YTDnhzlKKylBjdnrtSJIZDlYRPzZey8cpEUNy5e5T8jK/l3fABkZFV2wRzGVKLzC6t8qLIsI807EttYSm4nDnevsYjsrqEIs7aBqVcava+M7R0PSjBok5n3wiGugTDkiYDXXe/YpFNTRXvol+2PFg2LajTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pGypAsQ2M+cC6lcu8YWKFgpqIFEXeTHROm2PqnjSBM=;
 b=exegceU+J5Uz6oc8CJD8RpN0dMvHfkN32rq1dqmXN0aAuRzzss3i0zfsUgwBQ+VoQp2/R51unyq6dtCDfM7C2yfkm2y6p4th0rRnWOAPdqAIXrK3ywhCDhn/vChrYrN8OgZECzQlUpGQkgkYqjGypVogFbePcoXjB7xm/AlZLooWUTCkmxlRGPJaET+CAu2LQ2FXZ2cmAUmJEwDDxYhP9a2yjCf4mmCZJYlywEblBh6XWRwHIWtPgbZ5Q3Xx2H/0Fss1VwlmG1lGzpbGe4SPLX1ouCn/VmVn2gcqYKW3VowG8oaew8n5oXcY1QosFGi0GhQls6o4S+H8ndiesY3Tpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pGypAsQ2M+cC6lcu8YWKFgpqIFEXeTHROm2PqnjSBM=;
 b=gcmBj9FmscDoYWfpDuZ0eFaqnKb1fe6Qy2qtoMcj6K+PgZcpI9F4g34VwbKLGyS/chHUM2U/KgJGA1ViDyskzswKIbxagTs1yUsMx3A2BMJfalhAUyGbREgkEmd0GfzZTltobkJwDAaLaVu0OkZQysLdlDIpPC/jf7U0VyDdfbmq0NnhNn4rLcN0rTPut1AgoD1ugcFhIaRTTZqJXJlYDWJd8ip7I0wYwcQBKOKnLxulNS5PMxrQTvw3KS1wO/D9Wv0wjZazpc9rKzl1OG2yGqbJujQugV0GIaOxT5qH6Lu6cb06bfHcqxhz7zb07FHxN0yHKUWDGW//9njtH9Khfg==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OSZP286MB1824.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:165::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.30; Sat, 15 Jul
 2023 16:16:41 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::342f:ecea:d02a:5665]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::342f:ecea:d02a:5665%4]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 16:16:41 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH] iommu/arm-smmu-v3: Change vmid alloc strategy from bitmap to ida
Date:   Sun, 16 Jul 2023 00:16:21 +0800
Message-ID: <TYCP286MB2323E0C525FF9F94E3B07C7ACA35A@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [0PjTds2Km7xhwX3sC7TTxwopNMxlMsSq]
X-ClientProxiedBy: SG2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:3:18::24) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230715161621.7553-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OSZP286MB1824:EE_
X-MS-Office365-Filtering-Correlation-Id: b204f03d-5492-42ce-e901-08db854edfe4
X-MS-Exchange-SLBlob-MailProps: 0wLWl8rLpvtYvvX01Y6SEWEqtdEs1KWikY5Raz/BaCw//ccU+Equ+RPoMyv+wpW39O4lVUI9buS4qggROdNJ9p17J8iKgpl8c7gWT5FDqtSCWXowydozhWa6R2gA+n0gd9Kam4KIopIhpQKsDROHOAAxJFQ8HP8vyadpt+fOm6UYdqx2H5DfqKBK0pCxe+LoT5I7HBVdZdkceZERwnlb3BfgWDH7VF6rAidYG2VyJKwryoc1K2y4GrcZzBDjHlhTn5GPKxtuLsKEC2ZCE8ef8147IrGANgrtMfoYo8IaC31OC+blLg7acVykwJ8Tkj4bNSoUAS4RAH7cSpgwzgfjNhLuD04MhxBNe/K2SHUmWykDhzlZ+dRm/pKa3iFIen2GTt7yYWfj/954WB4F5x4oCi3+fQeXrX6zQxqZVGqxyWbzJBQGt6GaApFajtlnD53bG92Q8t6KsikBQuVFkF0WnFblLrcppTpeZnR3bRWVortmsTf+nwiXATqba9YqkBzdd1zE9bFiZbxofcLUg3prugnnNkxysmi6hYfU/5UU9v96djzM7PdVmLmiv1IlIhPpRlyXKPO9uQS9RHK6oPUL3vulDL7tncj+gyrwmXmyTu3iGU3VcoHZt0iUxvk3NUNeazmdLkL/CEzLNmdnPe+CF6ajw0SdhIqutXxQk6F5rctHXm2bqC8s9ShPeWygqFldNauIP/Kj0JNqI/T5u1nlZfOVWO0f3ZQvtC1e3/oVxyNUl+AjXGSlx2yx61FAOjD/stDA/Qoh1yQ=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wyBEOIvQbrY55MC8rk5fbXYfNiyK8V4VaJZPuG8qixSfpw31/TpCJUcjRfhHZ7GmgSXcuGSRSmIx7JaUYWU9gR0mJ6WTUuVk/P2ukzgwX/kpeK2dIDObhF6t50APrxQMh7o5j6G/DONs0mXWrNe7/MxrQv3VTsKOZLGjE9depMbWLIhUJFNT/KFOFtjDk5vv2yaWjMg1cFQ4K4qJdnzNTWLbQmfOM7ljgNuZxAm0lmcZgoMq3hRK8kWtTA0Col1S9zSiIh3gnTK70GRYTQvxpd00DbiAUu6xny8Z0FO3ZifsH2He1A+b7Dmi3tbeYo5pzT2d3T31OBEW9CED7sOEBACK1yBSnHpCkwaD1P5V3gMXmJ5UkcbqJTj+0yq0IGQl34SDffmhgMR3g4SA2sEVv/y3CeGdGfqQYBkADOANiclFAXhfr98AIlTgtGdysnVz2JjSoMeEflR0BWl8K6MzZ2WE7OBpXiU8bVtAEF/hfsp1dbsWtAVpYH3jI7z8DHR99Rg4iIH/BHuRwudt8XRw9THteaVQTdvIEsZc2dPXFJ9P2TiIxXjM+QKHbAZH6qtqFkVAq1xqd22d7X2b7N49B3nXb/V/yAFWhs0jRkVXtsTqq3RSbL74LtBCmi0b51A
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s8DgG1SbgxSJXaPObFNNwOHeF/F1TCfwY8PCKLLPYfhjsAtsv222wlYietIz?=
 =?us-ascii?Q?j3IhWH7+yhwp9euY7o2+UJoptJvb6m8XLYlevJ+WQNU10jCi9JQ2BAug5PEy?=
 =?us-ascii?Q?P2dI+NJo40KgLVPEKG1SA1Pxn/XK5ydnaM+aU0l+1GI1SUd1NIX9HDgJL43O?=
 =?us-ascii?Q?me33OR3ekddx4HNYJwWOZ2lZsfx1ZMr9+LIfv7AumEcMeGBZxnfCwifcpevj?=
 =?us-ascii?Q?nVxAYP4kWhdOKw4U+KwNY+z7OuOMhDRGd/z5jCczlbqm6MDmpDJU30kRRWZx?=
 =?us-ascii?Q?TEgHjFtlB+g0//GNFHRmH+gklAQopLDZZoRn8oZWGT8wFGnNrbdpIfKnSejO?=
 =?us-ascii?Q?7yq6i/9YrbBpLv/RB+OEXZCzm+nc+yG9eVUqXy7cJtF4gVut4WCc0MJC+kDi?=
 =?us-ascii?Q?NmukVQjw816T0mk9TrQvku5kqTkb47QPCnEXUSrkQKygocvMM0u0l3t+PW8L?=
 =?us-ascii?Q?QHPODIGROkFxmryNHo3qTOamzkUQCDCZg2hgVtGx0/uV9+IYi50NxhnTFhbr?=
 =?us-ascii?Q?TVpAtLmGRgoaDh6dF9ajR5oC+ScV59h81HRN0mjQeEWwTG10iUHhDutM69MO?=
 =?us-ascii?Q?ssD95rpdkCd1iKLycNh8NDtn0eOViKY1zANc8Rse0SbL20cBfeL2As/gBZSe?=
 =?us-ascii?Q?G73zTqewy2Uuwl9eyP8jUI7ehWQmFDwZX1xc4D+da0+ykXEaFspPs2kRC1tg?=
 =?us-ascii?Q?Dxt1y4vUST+YTBVnD8SVPOwBYX70TT2fhhqppXGw3/6vWWCqV5WJMqA77Dhc?=
 =?us-ascii?Q?B6zkwIu0ZsmgCrQ8fgEU/3k7tAnxb/MEJgfn+S2BRuJM7cmrdLn+lvmv409+?=
 =?us-ascii?Q?+GoJJXEUz73fDPDNLlzdx9bkftHRCpF3sGrbjYf93wSwhJF33rGfPUmLtiQR?=
 =?us-ascii?Q?xBSfJDFZUdDeYGOHEtvZyAWxmMwk49/GaPj5FRBNMIASoHINCDPeZUz/D7mo?=
 =?us-ascii?Q?183YKTrsZqaha6J+7LzFDShOtb82A07EW8e4V/Z2xRBrqKbuhaB9dtjMWsSm?=
 =?us-ascii?Q?wZ+1798zKC7k8Q7S3ltk/BwEU/e4dIp2ub/B1JBdp0KE/yNKSaywRIz72c5F?=
 =?us-ascii?Q?jb+NDBsdd3cSI1eCUEhmDD8LQCesnAuo2ivb+YwRoidumGprF2we0TzOyxkM?=
 =?us-ascii?Q?mJ/5jY2617eC6npi2WBF3pRfLYYxb11VrLh8wtGxMMrF1exI96UvYL5tF475?=
 =?us-ascii?Q?TgOZfaUoQoEqEgrwAHKZj/nsxyXRlOGDyTbZKp3FnA3VyKwCHS7kK6prtP0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b204f03d-5492-42ce-e901-08db854edfe4
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 16:16:41.7380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1824
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For current implementation of vmid allocation of arm smmu-v3, a per-smmu
devide bitmap of 64K bits(8K bytes) is allocated on behalf of possible VMID
range, which is two pages for some architectures. Besides that, its memory
consumption is 'static', despite of how many VMIDs are allocated actually.

That's memory inefficient and lack of scalability.

So an IDA based implementation is introduced to address this issue, which
is capable of self-expanding on the actual need of VMID allocation.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 +++++----------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 +-
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9b0dc3505601..d9487602701f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2055,24 +2055,6 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	return &smmu_domain->domain;
 }
 
-static int arm_smmu_bitmap_alloc(unsigned long *map, int span)
-{
-	int idx, size = 1 << span;
-
-	do {
-		idx = find_first_zero_bit(map, size);
-		if (idx == size)
-			return -ENOSPC;
-	} while (test_and_set_bit(idx, map));
-
-	return idx;
-}
-
-static void arm_smmu_bitmap_free(unsigned long *map, int idx)
-{
-	clear_bit(idx, map);
-}
-
 static void arm_smmu_domain_free(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
@@ -2093,7 +2075,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 		if (cfg->vmid)
-			arm_smmu_bitmap_free(smmu->vmid_map, cfg->vmid);
+			ida_free(&smmu->vmid_map, cfg->vmid);
 	}
 
 	kfree(smmu_domain);
@@ -2167,7 +2149,9 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 	typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr;
 
-	vmid = arm_smmu_bitmap_alloc(smmu->vmid_map, smmu->vmid_bits);
+	/* Reserve VMID 0 for stage-2 bypass STEs */
+	vmid = ida_alloc_range(&smmu->vmid_map, 1, (1 << smmu->vmid_bits) - 1,
+			       GFP_KERNEL);
 	if (vmid < 0)
 		return vmid;
 
@@ -3098,8 +3082,8 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 	reg |= STRTAB_BASE_RA;
 	smmu->strtab_cfg.strtab_base = reg;
 
-	/* Allocate the first VMID for stage-2 bypass STEs */
-	set_bit(0, smmu->vmid_map);
+	ida_init(&smmu->vmid_map);
+
 	return 0;
 }
 
@@ -3923,6 +3907,7 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&smmu->iommu);
 	arm_smmu_device_disable(smmu);
 	iopf_queue_free(smmu->evtq.iopf);
+	ida_destroy(&smmu->vmid_map);
 }
 
 static void arm_smmu_device_shutdown(struct platform_device *pdev)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dcab85698a4e..9915850dd4db 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -670,7 +670,7 @@ struct arm_smmu_device {
 
 #define ARM_SMMU_MAX_VMIDS		(1 << 16)
 	unsigned int			vmid_bits;
-	DECLARE_BITMAP(vmid_map, ARM_SMMU_MAX_VMIDS);
+	struct ida			vmid_map;
 
 	unsigned int			ssid_bits;
 	unsigned int			sid_bits;
-- 
2.25.1


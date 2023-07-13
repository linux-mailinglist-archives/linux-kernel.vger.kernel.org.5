Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E91C7519A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjGMHTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjGMHTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:19:20 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AB91FCD;
        Thu, 13 Jul 2023 00:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh/oY7uJJwGKrzR0taNO24adLrqwXFdmll9YqLfrCXABOXV7ZnR9HPCLVBCWuEFNjjSFq1JtRgIddisHgOYwP2aS0H6ATdw/WIaBY0a4OftitIm7uFFUn1UbFrR/ymFFCnx1bQB0oMb0kkDLuWEXPGWLfhsdIHZ63IEw/ZJtOZouDdKeA4v46wIP720jSNBc12I4W/HdaqSDlRhebZUDICfZo/OQAYZIVSiXCAwuT9UVlywivYJ1/SnQboodyk8wL3/L9D5DUPnXg6eYnprNWJHBthAPeY694Sgzi43MTAkxLSWi4vGmSzSE78RZaKe/ngQ90ByH5BzGTnJXMOgS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGYUDSvEf3yKJD/EErQtdf1Ba9vogQYA+/f10bUIv30=;
 b=CMfPdy1bRCz3+iNoNFMEKNiCGbUtGDI1R2buWep87KVQk7EdcgNQls6JvECDCP1PJwT8er+OhOnpDmC8DwL6+pn9cVnhuROWTAzSdYygdj8z2RwYNDisF+781Lru+vDUyjzn3w91zyo4KL7SeCMdqUdoBPP8jID5bnfKXduOQ2pG/Zteqoi4pH0/u920/whlqECG4XrySnK397I7FFNJ/0BkEKlKV0vQrIbJA0kXOHiMjm4MblEwyObX7+RMomjFNzte4L6DiDdIAFcRvH5UPSwb/wnV+ZPDrMJ2eFK7kh43SewlUjVqodKmUuOl4lPPHGaAa+csCTvT2v21Wb2ntA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGYUDSvEf3yKJD/EErQtdf1Ba9vogQYA+/f10bUIv30=;
 b=VBob9AUGp6Feu4tiU4iqnn1zcZVTQ8zf71LSjzyTdCNX+t1oIgwAE4CBoQLVGXve8CG1lFMsFgXghu9gJ2VFV2tfXTv6/YhD10rTyPiBSHmCt7XBasUT1Cgj+MRBTgkULSBKR481hCB07t1H6d2HfQdbM9afxBqOu6yNq7DODIR4utjp8aNXYtJZqq7KxJ8PwHqiIsA2pejC7JYJwFWbnmL2uxhgmQSdoiPlizcL0DfwxpYoxltSxKL/9f221ZL4U4my7zSx4F44SNUY+bVMNjayLXFUhLxlXiHn0SBZ4kZhH5rnpwevoTTGmlBDsuh+dB9PZFfKP/devidnVeH45w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TY0PR06MB5756.apcprd06.prod.outlook.com (2603:1096:400:27e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Thu, 13 Jul 2023 07:19:10 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 07:19:10 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA IOMMU DRIVERS),
        iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v3] iommu: remove redundant parameter check in tegra_smmu_debugfs_init()
Date:   Thu, 13 Jul 2023 15:19:02 +0800
Message-Id: <20230713071902.9007-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TY0PR06MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a8ff4e-a1bf-40cd-03a4-08db837173a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3azoXEL2WP/Td0znFEtKBgpRfI54T78CtGhnoZEA7By6UhcoJBZcqi5WlM7BAbvwKFSq4bMDpxM8E1DR6J6/AoYXfiWH1pQEpToEz5Txz9tBGtUbP/M5z/rRCYP8dxiAbwCiQDieIym1YAnOdDUuTa8BlQwPgcvOft9RSpehhAey3edZXo3wy00ldt1me0OBZfquFW/Akn0OwTQG1b9OMhrrCc43yK7JaSO2+hetJB0hkHzBbC5BCWFOpvy5YztsqXoFREf3HFPC0emXH7TH6A3IRdYNPm34F9fXa6xheJ7rxzwN6L24iqy5uhKngGcWD56+raM6FbJ7PuQhcK9AXmqbdEVlC7IDQSE1Q4XaWXo9W2egn2/v7FIpGeVtryp+NU7ZDyZjLx1xXJZhwTZXzK5TBWS1BmfaZfxJs0zUC8/Kcjro+YEnPBeIMLmAZnCVWmgk8Ft0UqlGZYYEC/3NIvha3vDxNOS8h6iSWEnCboi25Kic2bzvelFgWpZq8sXwyLap+vSkMAPrFXo6osIrnQ0UC6V4uKbLS4dyrGTzaC4DlXOZvn5bST4ZsZ5l/EXHQBOI1RJ6x849Zrv3oMJuYlAmmAbFzXFWAt8+lGX3Amc0VU/TJMy/wiJWFHciOzxD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(2906002)(38350700002)(6512007)(38100700002)(83380400001)(2616005)(1076003)(26005)(186003)(6506007)(86362001)(5660300002)(8676002)(36756003)(7416002)(8936002)(4744005)(110136005)(478600001)(54906003)(6666004)(66556008)(52116002)(66946007)(41300700001)(4326008)(316002)(66476007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jOdWeTnAwRMlEg5uNcAvXLPjKC1efxJ5sqJfIQ+Kbo5CVBIHoXesoLJj+M3+?=
 =?us-ascii?Q?2jaxnQVJGJ/VHAN44KkNWLOdbMDkepQ9wSMdaeT3Te9H69Z7ut2MA5ir/AHT?=
 =?us-ascii?Q?8tbvwdnvqays6zpnIqqNN/H7laFoG2vmEaiUvmh4IJy0kvLXFDhwq2vVdcqT?=
 =?us-ascii?Q?KfySWl6mBOhP9hd2VtMh+zqm064M21jG/c9pRDNkRptE0zrbvU9bIPvdb5hL?=
 =?us-ascii?Q?ExJgb2lLoyY8qvqLrhU8sjsP4RC18H+iNvqEJFPXz5LQAvqNoLszymKUaIne?=
 =?us-ascii?Q?XU5e4iGlQ9rnjjOrXwt2T0vQTo4wYhiNPuxBvQmZJF4rdR1QxVhcGPl6Sunj?=
 =?us-ascii?Q?M8jZseHB2EiqmOOXrRQnR5kX6fmyeJvQCJd0FickQ5HdwaUy30eDBtWg7w4D?=
 =?us-ascii?Q?HzkIsuUov6sk7WfsUEA2z25B3SahlSW5eqQd97D8ZKyjpcoxmp62tkBeuKcG?=
 =?us-ascii?Q?GAEI8s0mZT+TgNQx0FKbO/VGV8Z0+/Z3ljIqdJF6W166swqIXe7whZ4jEuRW?=
 =?us-ascii?Q?fFePyuft7YEG9ereams/44Mrj2EsqeDYlfgmT2KvfcBhkUETYOBFKcrbfWja?=
 =?us-ascii?Q?Cta68Ne1sqtOBkd9KRG4dJ3PsZrzzJD+wSEwHsThKc1e0RGcxFLHjIOAp3Q6?=
 =?us-ascii?Q?GFJKc0kXJE0BW1WxWHPx/XfwrZOx4K1XywNIR635q6KaG586CdJpTRdNncfc?=
 =?us-ascii?Q?xIt1v9eUmB7tAr4n9YmYkvqv6yjDc92fukOqAnQ9rTy4GIa56dXsj0tUwv9u?=
 =?us-ascii?Q?qgR2rT7WUBlJav0LarcFVMeZC8c56WRbDxFhID1v+iN6ATiWP0GeBW7TipCh?=
 =?us-ascii?Q?qqKj5WXqq0CVMnMJzNQMgikO38fbsXBi6uUwG2FlGtaKYMKKqKtmIWxRe5zf?=
 =?us-ascii?Q?tcNqyYBtKKXwBVlA2iZoJ5ZRmujAxg6f+NkFQFKcv4ZG5rW1Xi99DWtfQc0E?=
 =?us-ascii?Q?t8k7aT7nzof3w689VeGIeIeVCMO9JhdHf38sELcnbg9DlSdwe0u5t2rhLhMc?=
 =?us-ascii?Q?jO0xmlbI/sIGWPv0I1svkHdGJDMKGi+iEQV6w5dGXzNxvBzq9UCCag9U2utY?=
 =?us-ascii?Q?BKWVCJfUjZGkDznvLFlaZV3V0VOEmqeQvDrvwBUa1WWhnPaylu1xiBnfZQWf?=
 =?us-ascii?Q?Sjnyu6hPw4F4WHC6gLun7uurhT4aGeOPFaxL+BSmI8ryZI1gPCJAk8/qBXI+?=
 =?us-ascii?Q?evHIyqpuR0iZELWbeUsPu3GtHgF/nt8rB/1v208Y68+7RxGFlskluSiXbVFB?=
 =?us-ascii?Q?fgF0xLp4/RVhohvuAYADIHNqA70r/v48ltmoRaGSVIbhFPRr/27Tv5ut65Ev?=
 =?us-ascii?Q?47nqp0Nv3c6A1qpsy6qX1w4bd6NbHZpkM+Z87r5UM4wqx4y0jWZGM5bQVNkh?=
 =?us-ascii?Q?b9E7/7exFv+bNBN5skfqFOqna+PL6Y5GE/133CppA70tr/rYjoQ9j8HCLg81?=
 =?us-ascii?Q?G3qzlPQhbemzTvT759fG6sdn8k6T4pKIKWwkV1QpXx+wjMludtEK/NI4ZfO/?=
 =?us-ascii?Q?V/pSNl+gFD6V9jnmEMjmPrJWAdKOkAy4Oj2WTTX+mxlFi67I3OkOC57Fx/wa?=
 =?us-ascii?Q?ASgonrcyukjIEojz3k2fjsTDtubEOm+lxIMgz1Qy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a8ff4e-a1bf-40cd-03a4-08db837173a6
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:19:09.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WivBvl+twWJ5HvJv8jbPFFiK8YX6po/Vo3niCvDM58Ha4y9MvOtCLTFbQh1+v1JzhTfH1xBjasYVHVV6JqaTWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5756
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_create_file() will return early if smmu->debugfs is an error
  pointer, so an extra error check is not needed.

Signed-off-by: Minjie Du <duminjie@vivo.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 1cbf063cc..2137040b7 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1056,8 +1056,6 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
 static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
 {
 	smmu->debugfs = debugfs_create_dir("smmu", NULL);
-	if (!smmu->debugfs)
-		return;
 
 	debugfs_create_file("swgroups", S_IRUGO, smmu->debugfs, smmu,
 			    &tegra_smmu_swgroups_fops);
-- 
2.39.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD0E753610
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjGNJHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjGNJHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:07:21 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93692D55;
        Fri, 14 Jul 2023 02:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A70iNVhLaS/P3T80DoGeOsb22QJBS7rk53UVaxTZ/QKLrVUDZem97o2auuVWYFgktXdc/UAhQspGX5nJLtMNsqjPmwRrRZO1Zw6q0pG6nPoB/VLtz4uBH4yaYlC6O/aSu09WfuAmcH3fRC9BZp9fq6YqqoiNI3Aq5g57wHwWSWtqCaZT14VIg0HYPOMCXkxb7TIBHHxVtHUj6xeSErX76haGgUrjzP/eWJSUOqnE10Xpi59ssDG3ropd+OZQPBdZvITN8SuOfhYdd2bPNYdIuS6k2ncgq9Eh3FVkvslvkqpHEixJ2cmTeJ4EcY07CKOOrupSwOsl1qzZQGBTqieudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CftbofGv/HGd+6USRkNfX5115oDEgvPSwWUq757MPJU=;
 b=FV5HsqeyJ/O+hIU4DWxbfH+TKxl/58nZpR70jsOQIPz8IKzvdGEropgXlZ76CtyV7PG2sVR07hm48bjvY139H8aX46wnxJt1RVO53OtJS7NArJyoLhyWUpAcFIjdM7Y1VDJTI49OE3Xu7AdxGJDuE3juG4q+bksjEzG96+s0eh7qVzCINfYg/3zqLmLlC9jcNV+c73Cwn8vEg08TFLtfHUpvIn9LWnrJKtNRYRoJGYsVorb+/nA8mW6XGntaNCcTB9d2/tHdVtPDp96Muw6cASdpWV5sBXveDivFppM2uLYUPoxq3qsoX4FkKzLSqpv5rJSK2CwwRtoeMSSsDAwyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CftbofGv/HGd+6USRkNfX5115oDEgvPSwWUq757MPJU=;
 b=pKaVy2oWHL3J4Ek/eiRSuK7wrXDa5PnZw/PsjxXdKAZaw/bGDNk7RqOudOpBnhaXYJkWM9vDM95RRB+905FVE5bAecaIGsV39/l+GqZJaXzeLctt0h86b8mQ9Odrj65IItiIJBl+kvdq1xoWuqy7eu4ExMNyE9oR+MVioW7rEstbeWO/DlRY04/p2YIPJqPnaxmDJqcWZzcAkBYL9vML+F/bZKLrQ4pIViUUkUL+8/yas4Mxkam1WPeyf2xu40241+eEhH2VPogz6GbecbKNzz+WmX79Bq7qaBTG9RE0Hz/cUufhbTOl4LGYU0CTkaICKdDPoJnH23ndexhP37eVLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SEZPR06MB5521.apcprd06.prod.outlook.com (2603:1096:101:a5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27; Fri, 14 Jul 2023 09:06:51 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Fri, 14 Jul 2023
 09:06:51 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     baolu.lu@linux.intel.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA IOMMU DRIVERS),
        iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v6] iommu: remove redundant parameter check in tegra_smmu_debugfs_init()
Date:   Fri, 14 Jul 2023 17:06:38 +0800
Message-Id: <20230714090639.2708-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:404:42::19) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SEZPR06MB5521:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ce5508-0129-4732-37ec-08db8449a92c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jj/1kk1s/oCoIeAPlnQL2dBaJyszFVFgkykux0WK8TkimifLB01wjBGLTZjUq1NDUezsIvThxisRO8qaITrL04suDKBT6Z+1KSJJT/ZcC+WnTfsDh8MOwSoMbNxKd7GOhDRfYpUhaqIugF5BAfJHzqFNf3xqCkAIwDCqxGfYf5GNjFHsZMgN7D9i6linFmZSpMMIaX7MmuQwJKov3iYGvjDJzURKrswTocsqqlKOGSkThs31yNByp6GsNdVRWGuvlOL87YoOcrwlR/BufpPey1Q65D5gDjT4BLVYNocgwBqdpL0oaKXJFhPbWkBRicQ5GaC9Y4FdzuB3Rkh94aAeHYquokM3gV03X/I7nKzV/k2eyoFpAfQtVsG3+Rtgicm12cJdKZYMix3dEd2csaIY+j5zce1xKZYoVBPmHWbc4WsmappjWfZLNNOjhyhsoFh4YvE+sBZrk9IamKJ7SeCiCr0fjwA1fnNSScKs0Z96ko114n+BPKoi1QAsJRAlgW3Tk0b7ViR2L9MJDe3QwmyR6IV7i6IrvtJuuc2WDcZKkTalJQhT4IEBWm9MLTdATJ+gFwq3YkIEgt2VEAc3LX0n9meu/64ByqpeXp4yHD/GKyY880ph9spG8ZfiwPMibiyB+WbcxO6W3z5ptbgFTaPthQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(7416002)(66946007)(4326008)(66556008)(66476007)(41300700001)(2906002)(316002)(478600001)(5660300002)(8936002)(8676002)(54906003)(110136005)(6666004)(6486002)(52116002)(6512007)(26005)(186003)(36756003)(6506007)(83380400001)(38100700002)(1076003)(921005)(2616005)(86362001)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j+GqMvC0yl4XpT6gt5FJzffbRqrRgh7OjXI3YWPThlFvyutFiAsthYmPWME7?=
 =?us-ascii?Q?UkNqyj1xxiA1zgIKzaSQV+bl6vamqmJ4YxXfZMMcN3wzc8Zq0oG8vBjGN3im?=
 =?us-ascii?Q?k7AjzVMBh7hTCjqv64FwHD461UVcjA2zRmGJn76nnm9h/FygUjC1hUokCaAO?=
 =?us-ascii?Q?OSnGmC+Ok0QexiTIy3+zTYL7MRSlEJipLTqJo8gggPuHSaiPACFCST+pe1sf?=
 =?us-ascii?Q?4ehySL8SG356KEJnBJSGTGtgK+UXbrBFdcLQSGahjwBg02ANX+JaocmY/WSD?=
 =?us-ascii?Q?R5S66Fq+OJGFB/C8zWC7qfldtGvMNQGgOIjrPGQ4+HK/qCrJMvCB43W9Ub/x?=
 =?us-ascii?Q?Wv6/HsOlPa6x/3c2foTdKAVar518zwJoLYq7Cmc5tuip+1ohv4O4t1+Z2OeY?=
 =?us-ascii?Q?gwY8D11sKckYeIcsUso4gjvVpSpOylBybz4rPQxWtOyGtr4C8Z0ZwRlKA2WP?=
 =?us-ascii?Q?JEPDvl/9PrR9U6OlyUHmsNyTN33F/4+l8ljU3z/1B/n85EUZ4nDmELa5VaAh?=
 =?us-ascii?Q?s0kBG44MVNY/vF1OhzZZhjVbpsxJOBpisI79OZNB9q/8Jfm8mlxSjT7uIczy?=
 =?us-ascii?Q?QIhax53T1cO2C8mlIWdOVa5YA0Sic5tdq2dWAYqWdI5Eh3WKd5kkO7tX1Ypu?=
 =?us-ascii?Q?EVmDbD03yju3AuVYXUVx5JFECoB5kwd4HrxDpeDAPw8JlmxMV9IKXCaDzAyR?=
 =?us-ascii?Q?mKLxI3JZzkij4fVEhx2pst+IQHCvpyPs9JmpRZ90puLAyDhEnBQ8Na7NMFja?=
 =?us-ascii?Q?PoOxQqgKFjsaMVXvGYX8FkLkYLoa9blpT8JX1fCI3KOHPAPlcDi0u1R1siWW?=
 =?us-ascii?Q?SwS3EMawxf60NvxCX213VSmG7XDIzLywP6A/BWl3UZvfkLKyXFFnxs/ucVKb?=
 =?us-ascii?Q?rzaSUlICUzrkJlH2hpToJq7P+zrzYB+1CnzGdySTAxSq/McUpk9UQ+gsr21t?=
 =?us-ascii?Q?aCoPDDYl50iWXJSSk9s/5xrU1DEe+4SbaDhuEosWZY1Q5vEKjTNTLeDPkMPA?=
 =?us-ascii?Q?5gfNNmY/RLX8NkreaZ1MuEPom8KX0Azrmemf+GYwYAl07p5h2kcIQnCUj8dH?=
 =?us-ascii?Q?xygrsxT8Nqb5xRqXrbp1tYGpn4BEgY9TxPYuJAKHTQJoJaVb77SFmXZGT66/?=
 =?us-ascii?Q?8Dl9P3DpwRggMHrEO/0dNxMy9B9IoqYCfa3RXBCJINTLLjwZDd1i5lAEp73l?=
 =?us-ascii?Q?wgzSUpfZSQCWSrVPaqzAeJOmLuoMkwk15mEYQbUIh77Sr1BMBnMrl9LQ2E1d?=
 =?us-ascii?Q?OY9owsOw1K04QFA0gFq3JkfXW6oVNyiS+83Lczez0vLppwQNukFE0rpn/Xey?=
 =?us-ascii?Q?E3MHWEfQ9VIODUiyOZwho8TTZmTeCf86+UKnYe7BqPTUS/jqFnxW983h5S/9?=
 =?us-ascii?Q?0DOxBujL5ZzqUjZCFyYYBl6908uGn8S8WmVWF4Qxks6GXBqj0ciOpMr79Y5l?=
 =?us-ascii?Q?9Kb+4AsRzYJ/wIe1LFUfAoQ7NKdxVwSCfYgywqXznFnV62sNxe7hQVeClwBE?=
 =?us-ascii?Q?sdCY+P5RkWLIAK37TT4wdnte8gtuPxKbjlZi+FTSgCa/pRzecNdV1gIs3pVY?=
 =?us-ascii?Q?/7t7byHQApqw6W7JBRLKnNpKDWVANsHVQZTgT/GQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ce5508-0129-4732-37ec-08db8449a92c
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 09:06:51.0677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnpPiWAWjh7/MRy2nXYBS7N/YwizHatruJj+xyieIQSol+lL0LdFR5YPQ3nepdo+ho/A+vAbCJqxJBf1dasITg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5521
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_create_file() will return early if smmu->debugfs is an error
pointer, so an extra error check is not needed.

Signed-off-by: Minjie Du <duminjie@vivo.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
V4 -> V6: Add 'Reviewed-by' tag on the basis of V4.
V5: error patch, should be discarded.
V3 -> V4: fix expression about patch.
V2 -> V3: fix expression about patch.
V1 -> V2: remove the error check.
V1: use IS_ERR() to error check.
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


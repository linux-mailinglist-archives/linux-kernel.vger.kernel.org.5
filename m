Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38568751689
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 04:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjGMC5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 22:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjGMC5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:57:08 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B7819BE;
        Wed, 12 Jul 2023 19:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVSh7tQDeLw/xzloBWwov5BOkHbj891BtgO14ZkWamciCh3Cf1a/dFnGEw9Byo4npQeNowK1GWL3RRs4+vXhasLAykjyqOzeeZsxxcgmtoQRaV7qYqAgc8//ZSFxD85kchIUCC0mUoNa+dxGb2P0iSP8mT5J6/FDCJZRvKFMB76UMEgzP5IIlhEAlBbLs+JL+6qayVNlZua5tQ04uijEonlHJi5rfxdjx+CIjGSBuTwgNYTEAjeHHuDOalVsefjXBOX55fr7OB0IpLVeagTMjS1NVM0I0bPtY6Pm35CDFdj5WPg2n36qUllIbiJlr34pbqpTIfjV3ZfZbv0XSAGI0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2yKxQC3vknxryB735YDLKGCaQcm763vg83m0YXmYTk=;
 b=Y5sBcYxC4fLhmxdv81aJo5p6Shgu1igNZjFuRo/7WYbDB6NLLlNq4+wkRkSZiH/qphqk/dTvMZdwT4p6K2Gs1lpbvcPaNFw3TiKDmWudGXHCnD6hV4LATdscVpF9MMHdfk/ELjgonHEFGKHLIxs92u8oxKyrOGxDvzTELQ9bmqNv5vNyK8voyFCFYnBen+biThzyTuKqR16z0UvTlZK9jg5E4xsyWJ9H1I57v9eAb/4TPdDLniHd9qm3dYPX+FH72N58sYvNhzM8lKDStUdy5U/9fOsZaM4rslz5PnOo8p3j5XTuVi/HCqGJwOJeUhv1OSDK9+KqrNK0UM1YN54z+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2yKxQC3vknxryB735YDLKGCaQcm763vg83m0YXmYTk=;
 b=pi57ixCWoaCk1wUk4CJacEEz9smun3iHspf75mMSOvG1ywcLNWzA0YICSogz8BVrg/Xjltcj4A45ks0pNcC57VwM9nzqqig0TunSjLWEFqde/mvIxvNsxOfuHQtTvNXGHsOLU2AyUAwotv5L9WHEdd3cYvoq1gBlKP9vtmora/R7xB2tlybU/rbeVTYxG2EjqhKKNXVZcCgdFSD5mJQogVUe4FXKqiQhAr1JBa2wPVbGmq0216vnmB+yYFjGSBrubDZVBAKGOgVwixI54amAR6rxKf7wv+8fso6H/h4SB/RyPINKB/9OFFJWn8gg4JWqZNOfEH6PsLXv3XX/02J/wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 PUZPR06MB5519.apcprd06.prod.outlook.com (2603:1096:301:fc::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Thu, 13 Jul 2023 02:57:03 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 02:57:03 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA IOMMU DRIVERS),
        iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v2] iommu: remove redundant parameter check in tegra_smmu_debugfs_init()
Date:   Thu, 13 Jul 2023 10:56:53 +0800
Message-Id: <20230713025653.1540-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0046.jpnprd01.prod.outlook.com
 (2603:1096:404:28::34) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|PUZPR06MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: 69349346-66b0-494f-e595-08db834cd5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7WdqSp6GrE9Kh4Gz7+aX7du6kdHes79TSvrV2e8PtEwIcunMn+9vVRARdgZeSCVkQOJcMmNUa6+DbN+OK3NuNLearQyQ5Ji7ETYB7PImE+icXu16ZYp/qx44bGkXGQrapanSGfQXRwRQQ2qLKhwLY3XTXtQ13wkREAatndnOqIRfchRZVcTbTl8KAIP1ghxJZPSsALfDg0EckLFQWfnAsCdNENncWgfB028nJpoORFKfUBXRvHgS3RTvRXypQEQdfzKw6XZE48NPtcYsKibLD9jDdCKQZvR4Ep3LL+ZLsfg7/axQHHls4RJnUgcrplRbfgq6PKNUbIP2Rce8xjpom6+RdBB6jIFU4ZM0YvjZy60fR9os3aTiz85FhZfxyKOpYF4qT7fnkphVviFDe43knD8xtyzsJGaohDtQSpjcB4KxAH+yNk6mnpX9sL1UylVgvJanB7xtmYb9q1KivW4FmB9ooow333081OmzCpprWbrZQpD1ULh6BcxU3r2fWw1nf6Empmcm6DNvzEkWIPTGBwtvM97yGWWlbmpPWU73cV38a/eY2kBMJT+A3oaz9lW7TTmUgC+KVTOrVOrJQozKquRMXcJWES1WL6QXMZq1UmkisCT67PyYWNnalsOW9sB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(110136005)(4744005)(6666004)(52116002)(6486002)(2906002)(478600001)(36756003)(41300700001)(8936002)(8676002)(5660300002)(38350700002)(38100700002)(316002)(66556008)(66946007)(66476007)(4326008)(107886003)(83380400001)(86362001)(2616005)(186003)(26005)(6506007)(1076003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kb2P06fFPnw5SFBIaUt3Qt47HyhGA6OypMdopoJU/cXJJWuAv6O9W/hv1wf4?=
 =?us-ascii?Q?3UI1zuAGn8K7LQm6bOFMINcTVheGbgqGY9rjZzpmv0F/c3Wmi+KoWfyIVVyR?=
 =?us-ascii?Q?EIxfD6KFqnvBXoMOl4xlD7m1yYr+OrLpbbsuB/qFEs3e8IzJr6HS1u1lxdxo?=
 =?us-ascii?Q?u092MEoEp9VSyJvhHdqSPTQRHYPrhzA7lhHGuU49BQ57ytZAE6AgdY/iyDq0?=
 =?us-ascii?Q?MhRujVHWkrbFLc3PkCz46kFMg+p1p9b67+YmCElq4Mwqada1JveG+SMHcBb0?=
 =?us-ascii?Q?Aal0V9GNwWlOmlav4vpZClmoG838rGrATx7qBYHQI+50IETj5fBQW6IuPwwc?=
 =?us-ascii?Q?gjCr1posGx5hhN1KRaoBlRLn4n9ZheydhjPVjvI3hNVR1lPWTJJK5wRM5V3f?=
 =?us-ascii?Q?qssr9GYVe0tsW9MRsdm/PWN0vjvjrv2ERMQznnqWlJyMeKIqivSZXFIcK9lO?=
 =?us-ascii?Q?Z71QAxnoVdGyu1AReZU0CPNA4+KKbcw6l1J7yqAoRmxTFJymebGz40BvHWiP?=
 =?us-ascii?Q?tjOOOsYdNJp+o81Pqn3/9qwgvKtFiNIEfctWGsuk4DQEGg40XoqdYOib1RdN?=
 =?us-ascii?Q?zrthj792XSbPtycZ0b/DJG9fT95sxgoabikpWLuWsHgZeeQb0qNuvWe1YLan?=
 =?us-ascii?Q?I6c2VK+Ck0ct0p9+B2859vd3FctA2ZakXX3svj5Oetlfu73Xvka3Qks/dH5l?=
 =?us-ascii?Q?povXXya5opAIeZLV+nlv7KHLfLtxhac1rqbzbWhjimsZiAEPfuUPKc4q3eee?=
 =?us-ascii?Q?9yN3GQwJ+vJts4wa+uwposp0GHFE9Rh7wHgFKPUr9iwGOHd+6tTbwLbPDhzG?=
 =?us-ascii?Q?DLPLUQX3MlfFCMZu8eXN3A8BDZtL0/bI0hiQFDDhfH+vDX8KAeF6EnPL2+tU?=
 =?us-ascii?Q?brMFL1IjXodGHwm6upSRxPE2gKNvVzkN+ATrrs4sF3olc1Mdpv9d8mmwdGIx?=
 =?us-ascii?Q?OaghtaAu47iHol7w3JyDuVD13sqdzObm4aeHggw+2o1TVQCEIyB1k5B/EAlp?=
 =?us-ascii?Q?UWmurRoG18r9ezEFV5uKY5+FJZ6lnhtGcM8fz3/Mk/6GzVQgFpYM/BMA68yY?=
 =?us-ascii?Q?wAmVqkB7jm2mip23q61DV4R+0qhx6Jh4xD9GRvQ9n6v4Z3fb2tVDfNMu+6kn?=
 =?us-ascii?Q?dxsldJzi2Qlm5EyiePT1BVuVgo+QuFMTRX6BZGZwqVtGeaB818yjsTMtcEYE?=
 =?us-ascii?Q?xG8IAQTWE/Qj3qBDWJ+UXNqDubO12dyGWuzyvQZzKVMrsZzOi3C8g1/1rhfw?=
 =?us-ascii?Q?k0to4VGwXcu9bOCjv6badpicnuJxIF9u7pHdCinmmlH6LuzKrBdzZFpp01F+?=
 =?us-ascii?Q?RwCjtbCKSFpj3/m0YHFYgB349rMUr/dhxhZPdjUcsgM3Iyo8jbrJxehnHEwe?=
 =?us-ascii?Q?5IK1oU4yqzJNnfeGIzhs0Q+q310ksIigmesjYhpOrLb7oQEXNHAPcidQbW/v?=
 =?us-ascii?Q?NFKkPvYylys7cUyX8Of0GqZbz5MDVymYj1D9EsydMFTZjYEXkwXapKAg1yxB?=
 =?us-ascii?Q?ZEZtE+Lak8EmYQLLL7HYtW4lWFSyGUZ9SShimtFP4XTuYNZHzX2TBbFWRvgP?=
 =?us-ascii?Q?AhsnN+ffhsNK9EFRc1XEsP9v7HApqFN9V09rrHgL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69349346-66b0-494f-e595-08db834cd5fe
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 02:57:03.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrNVyikbuCPbCL6WtKyQvPIZ3Fvo85NEXT6luulXot7+e/loIZi9kYNWJMbYLWTBCKPF+Hy8HRAF46cadGg4Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5519
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_create_file() will simply return early if
 smmu->debugfs is an error pointer.
Make smmu->debugfs check delete in tegra_smmu_debugfs_init().

Signed-off-by: Minjie Du <duminjie@vivo.com>
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


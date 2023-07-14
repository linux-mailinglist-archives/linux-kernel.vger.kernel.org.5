Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606E47534D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjGNIPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjGNIPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:15:21 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2090.outbound.protection.outlook.com [40.107.255.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6664231;
        Fri, 14 Jul 2023 01:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7NK8zzxi4AtaEVCv2clvdg/HrsURVwXhUZ+c4qUUJqlvJ4VESHgKod3fFf9ejj4+zh37v3zx5d4UY2iW5/uS5dELyEED1vWwYNyJQfLeaEch8Hawkc4DA+UrQcZ93d5+VrRMCM+WZc+QUyz9i/rU85qTx676VhRvPJhXslNvjD28ikKTvi2+P7VEamYo5qu/TamAjDqDqG6ywAN8Q4vFGfFSTRsc0o2dj86b4V4KjWVd9XKretYDbUF+gkbtcHOPt7uPtJWhjH97cL4qIDS1R/kI5I48L3xlL2qbtBMTMWtWQFVBxoQHWOgkKhwPb3qYSdDkBZOfe5C0m0tYKeAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aPWwm7W63u/xmLNS0Bynp5E5CrurXP8yLUNMEDIS0M=;
 b=COW2gDFBqCsQFIiJ3aWwziIGWjCfsg0oKWGmFK7CtSMula/8lCHmr6vxFL6ADyaHPOGWCrseh7oH5WS8vIfKdaVCSmhYx8BIE5UtlNlHdd6FJLx5IeuM8Rjo061R58kDtNp+InlPvilygA0P6YQDhXpMfa4nxWTa5rMLI80gSPfPCXoiXTcDk5zB3DfdmqCQReaAoJGBGubrSmEQaRZqjsAUj2/xxSS4KcbiX6vlOTJIgqhUk+mgqP80aibetHOAxAAZ9m66kwlmBDAyk9emQNNMHEM9zAXNc30uu75qjNCIAECQfpSMzfd9o1K7t1Jo/mFl9u7NWLLMQMy+pD1ioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aPWwm7W63u/xmLNS0Bynp5E5CrurXP8yLUNMEDIS0M=;
 b=AgVL9JxAgwX/JPEi0IckYCvf6wrcFGsWnBEx3Sg6hLfPolKa5cPz4JbYuY76/w5N768wKbCnrCV5992r9+I+2a4OWJGSkekJB5+mb8285PMv13SWow3qkHqvBbTPRuPaH/GreAiObGycWDyF2J2MOMWsIwsODURcarO91Tq6cqrQGjlDUW9d/jv3Zrpm9fx/kS6ShLBvR0n8Z+mSJh53c83F+ImzfZaaXcXP2t7mNoTA0TCu5bk++3tsyUce/P5vEDtR7ifTlbTiNFKH1rMVrc7tnVMc/RVKnhhs8fs2I1ZzEshW4/HOzmtUcrjPTR7brB9uMM3BJXPd15FE0MV2wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYZPR06MB4064.apcprd06.prod.outlook.com (2603:1096:400:2c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27; Fri, 14 Jul 2023 08:13:29 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Fri, 14 Jul 2023
 08:13:29 +0000
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
Subject: [PATCH v5] iommu: Fix an error check in tegra_smmu_debugfs_init()
Date:   Fri, 14 Jul 2023 16:13:20 +0800
Message-Id: <20230714081320.1998-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYZPR06MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: cc07eda8-5eaa-463a-eda0-08db844234e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJXh+NM9jasmVBcL/u0jk4KanzXd6SqHjYx6RMcZGjGvW2OUD8123iuuGrQL7qqNIFk9BP4WGs+ZmanpAJ40cYRCdB90fwc1ZWfQTPR8nP7crdbwE1sIxVOC3Ubqs8tZQTzedPlNowoxu0opguz7JtllDf6WC4EKwvDn0qrOn6MEsqXG/5fchvZdAa7WfXw0PO3C/P8TONVX1aLCSXUcz+7LdXbO5opxMduoW8xKcMSMArGIzi4ErN4RlPESrYawkuLS0JSnhzeNpDDzCLMWmh06IC3lFl5Le1iNDTQfLtj0RILdQ5nJmV4RSuiAcg6oQKyQglfXyK6VDWhba4h4n/2gI8GA70pIwXEe7j5ruJ517lEiNrpfx5hDpju7is0zGiuhBUEFczVJr+7LUFiabjAblMgDyl2LsB4/IK0mhss5+SZeMEa7W4Hy1tUf3HqludR1uWbm8GCMPqhjyLXD6+z3mN3lmpNryq02ynjXc5egLEaxoR18BToGUamdOzUolwncDKBj5f53EQOVQXfsPD4c6cC9vsoEUSg38wESCpX70pHz7yMM9hKOwcMp6Z3kSCwI8cU5iyETzCub1KgM1zlGeaIQjwvhH80XTNXfRWuJzI9wRNDKPAW7Z2Zl02FX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(2906002)(38100700002)(38350700002)(6512007)(83380400001)(2616005)(186003)(107886003)(26005)(1076003)(6506007)(5660300002)(86362001)(8676002)(8936002)(36756003)(110136005)(478600001)(41300700001)(6486002)(52116002)(6666004)(316002)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LJ2IFS9I7M8PUDQOJzOmYgDMYbi2YvSncG00p4pKd36ZoT/qZZprHRXqm5hc?=
 =?us-ascii?Q?DjsB5Hgfa3ratRSV7gBNpdpkxi8bop21vl6f1TYiRd9LxGA0RkABEEEYFWdi?=
 =?us-ascii?Q?dAg2uuWMLMAcRmXKBVBsqZ5ze3ulQl/xPvIVs+XSLb8YoYFFUKjkY5lsuT+S?=
 =?us-ascii?Q?WjZ2tWsCsInZX4MQWnSpbPaZrSfb+jctMPxCcf7faEDmGEA8zW4olWdlYFXm?=
 =?us-ascii?Q?D704IEzAfKZkcIUtIhoIT82rSubRe5gO/WpQEDcFYYMtDcVJQNBRjpOulJfy?=
 =?us-ascii?Q?jl/DJWWuy4+SpSq5TuYeRdiRQNDTgOIR9AXv5FnkKUinj3PR3rvT2dGCyaK2?=
 =?us-ascii?Q?aRfGC5cpwUoFZH6AiQ7whhVut6XhR2wXPFD3xzWrhzSklsBl8Ks3qPSC0qp5?=
 =?us-ascii?Q?aVmS73c0WeNk1v/ENfGpSYAfiL81atnv1cV/cPa8BU9YmU0Kf6WtbYsHNQyv?=
 =?us-ascii?Q?8UNt225CpolEZjQEIHcqEllgulKwGdq+/y1xFoRXn7wA94VbCFYi62m++8YV?=
 =?us-ascii?Q?SzsN2dDdLGqnWqkc+f2BP2pL7CIJztcHXndPztGco6dF9Z6h4hKi5vj3y4Ek?=
 =?us-ascii?Q?pgtokBLscdw8MSIYw2lQjoZk3aq9Pg0oKv63Q4b03nxOF+jfahhBVOSXYTQG?=
 =?us-ascii?Q?i2bsCQVP+iTA5FBfOhJoIMd2kSuM5MB5HN47qDbM3ojLJNl8RoiRxWZU4om9?=
 =?us-ascii?Q?4mM+EUUENWml5NVLvqvHZCKMZmBWD78k8tOCXLD0QhB9x8RSQABGtlfTlsXV?=
 =?us-ascii?Q?FPbbs5sNwZgLgse9xFnkvBkOnx4vj4cHG+AK+Y1LVCylkWMnZoCcG06puWfi?=
 =?us-ascii?Q?qh7UcxoASDpCfyVQAx1E/ugk94xVFx1YTxiV0OiNX2nznOQi3yaEdG2XXy9i?=
 =?us-ascii?Q?EIEs32xPrCifdHM09LUVOXUR7hZgDVM9qpAn18RqNKdHwGlKCgKkecUKd8IA?=
 =?us-ascii?Q?8bctxxWxw5T6Rh84sG0txwwFZh5CHs53zZts/E0H/tvTs6y688nY/1+ty2bO?=
 =?us-ascii?Q?Czt4o4O31Gh7qg7nRJDB/jp2xUaMW5+7beiH3dRAyFQR1mppJR2mRfMOP9Ht?=
 =?us-ascii?Q?PcjMVW077X53zr7wheTa2nl7Ngsc6e2ysoGcccaI74EzfvPHRfzrWyv9itVO?=
 =?us-ascii?Q?HwwDOlM9PHegNg/vM+brMYRtJ/h/XEX6LMQkKNs3OcZVZ3WugBFAcoruYcrH?=
 =?us-ascii?Q?dhg66ObkEPLmBXqF5dWmkmiuaYYg3Xceod7hvUnYIRlQWWPhv9AErkYI9VwY?=
 =?us-ascii?Q?Ihlf9bWrZwq1dqii37cHZqZEzzIAuqlNAbjy92BJmMnII9b9nqO4nACeCyKz?=
 =?us-ascii?Q?/+k+1Xpfap6qc2wnmyubsGX4dll2NxPmMhxv0oSSXnvRCVoYOcMkTcu5dbNx?=
 =?us-ascii?Q?2i+CaX6M+UlVaCrBiAj4g66LSnAf2rW1+mgycRHveS5oGsx1DBrXIxj2CfZj?=
 =?us-ascii?Q?EG2SDLdFLL/3olqb0vGL0CuEek/CfyQs5e2MxnFNN+89af0j2ndNXrODtMiu?=
 =?us-ascii?Q?l7pFZ5pNaE2oRXYwt8NlWFIryI2IV8ShzBzFO6f8VlE3/8Ak5NLQkC8kUYxP?=
 =?us-ascii?Q?hubFYT6Ka5SSsjwjrw3QGXNHE5Kg5DVvq8JTdBWM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc07eda8-5eaa-463a-eda0-08db844234e3
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 08:13:29.5017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMA8/QeqEoargOyv4MeXru16ieq1EARflFv8159mLEbQMJGi5dxfRThwYi4CL2bSBJBPWd7nqUDsuDWF9EgVbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_create_dir() function returns an error value(PTR_ERR).
We need to evaluate the return value using IS_ERR,
rather than checking for NULL.

Fixes: d1313e7896e9 ("iommu/tegra-smmu: Add debugfs support")
Signed-off-by: Minjie Du <duminjie@vivo.com>
---
V4 -> V5: debugfs needs to have error checking, so use IS_ERR() to error check.
V3 -> V4: fix expression about patch.
V2 -> V3: fix expression about patch.
V1 -> V2: remove the error check.
V1: use IS_ERR() to error check.
---
 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 1cbf063cc..841e14cce 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1056,7 +1056,7 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
 static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
 {
 	smmu->debugfs = debugfs_create_dir("smmu", NULL);
-	if (!smmu->debugfs)
+	if (IS_ERR(smmu->debugfs))
 		return;
 
 	debugfs_create_file("swgroups", S_IRUGO, smmu->debugfs, smmu,
-- 
2.39.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CF87535FE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjGNJDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjGNJDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:03:12 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2099.outbound.protection.outlook.com [40.107.215.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EEBE65;
        Fri, 14 Jul 2023 02:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBSDf2PLk6E79d7LHq8D7y1GorY9Z0gDdejgSUsSn5Mww8sm97MjD4QUTjwmBK4dgCD8NqLSTFsC/XVERKPbOVqqC2yTyReZmMx/R8m+xiCZlo8/qOYhAOEABoWC+0NkGc6qdp3QwDVjvdadQF9HxRXbFaiehnuGwg2NKha17Cb/kN2r5O19bHzrlzz1RlUGENI2ZysRZjHk13WvIgw6emk2w5IWfKnkaVCwjAwCiWp+zCiAAWC2iYCM8UwfqbK8/33igiQTVesyR1IN7DPaDiyBEH7BtzMWxqpqB66PnBfcA09Njjfcq8V0/2m9ACw5snEO7mO1EdLCGFfpzaYoig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CftbofGv/HGd+6USRkNfX5115oDEgvPSwWUq757MPJU=;
 b=lP4+Q1NkuhIm0t8dQRv/Lw2clyz3coZltD8+MKdRQIMwnemRxASxM5zBIyd9DH5tmvo0KU81y89e75wM1qBU/2ZJFhkz6SMn8sUVyXjU8I1WHO1S6TKFYnACspnF+6yiNcUuvJSVN0kQiZVVPrqJa3IDBwMIyNJUp9rdNnjz/MUtphdrXdSu6jUzfyHsORjnTC84NYUWTlK9R7ClMbreLE4M1n/5r5zWoYBXET4aJPENwe9juYQga0FhgDagmtXotR0TEptjZg95Y6czwWWHU0o0iFRxJ4bXv5bbfrA+G3l7xRRB2j7UXJVnkxpZ0oi6Imc971bgmBt0mK8FfHTrRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CftbofGv/HGd+6USRkNfX5115oDEgvPSwWUq757MPJU=;
 b=MEEoeFSbOh1ZaknDDmHuRFO2sT7sXM4XW/z4K9GmhtExB5onH+7dBqQMdScK4CYYjnncrFuvEI6n9Mz7EWjBKSn8rznN2N4oxRQTek24z6EUz21yQMKx2Mvisjo65iv/EUPsL12SF+WrETIImgLPUjTHxi81Zuy4NJIrIxfN44SA8Bi4dTWUWhCZx+qXXHLvqQcriyLExdfFIAloRYERVukpHpkKyOveTS6eWK50o9DJaf4an8GuALtXhFMuNdu6e4/Fj93Y6u7JjWc9s412eBqS+3JvnG1iocgy7qcQv2plP2kM0NHoAw9Le7Nq7qDJjpyR/UlLjuKjjSzh6FlckA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYZPR06MB6596.apcprd06.prod.outlook.com (2603:1096:400:44d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 09:03:05 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Fri, 14 Jul 2023
 09:03:05 +0000
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
Subject: [PATCH v4] iommu: remove redundant parameter check in tegra_smmu_debugfs_init()
Date:   Fri, 14 Jul 2023 17:02:44 +0800
Message-Id: <20230714090245.2614-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0145.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::25) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYZPR06MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b9ccb2-7204-444b-d170-08db844922bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZc4Gg8BCzlRjjJ1MjbmLPGcQM8zhk2kr+2NjpKcGo1jW07xCZq00RxWGvIs2tIjWlF4LmDPP+fYPAXc5dXH3/WxhTwMlsZK4aguOqZKjjswhFT9x22QKrCWoELrg397PqHsv7ao24Jdb75GQ4V5zlBRaKDJR948In1WlKmiJGTEPkWNKwBmP77JQMczbtneI/AFhxaTi1/xJfV9KpZDjxqPsi7xpLXHTUcSmbkt2q+nhvcpEzwaobfbJb6XAlTYvKZ5gNa6u73N27+iyaEuQYkAJoRxM+UwJ/2lER2cLjs7UzE9WcDcmFeCIoz7ZHdpiycJBowQBGEo5r6oM6dv0O5zABDxHkdXAZPnzHcX9o636jrysOnENKw+wybBRqFJhC8BXBDzVsSz7FWQavNFzXTtNrHX8K/TH5Buv43II9Y2o8UlQpQr3IZDE9JYqM54qfdlMJro7j7enMFL8K3Dkp8ZG4rO9mhMAEsfo2ilQ9zHrOL6ADndCpkIoA5/hEKFc/RGE/dDo7Bo7MJhCQS/R6D+NEQM6+bi9P9ZjSnQJqC+fNFjc4JlbsmLkCSw+4bCzuu9YJhe8uZ9/GPNZXQ8Fhk/erHKW5fP2RQ5ohTxQ6P4rGmUdif+tOZropB6yQp6oIqR2BkDYRhtOd5u8RELlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39850400004)(376002)(346002)(451199021)(6486002)(478600001)(52116002)(110136005)(54906003)(6666004)(83380400001)(2616005)(36756003)(86362001)(2906002)(26005)(186003)(1076003)(6506007)(6512007)(316002)(38100700002)(38350700002)(921005)(66556008)(66476007)(4326008)(41300700001)(8936002)(8676002)(5660300002)(7416002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fyr9UXBQnrqSFNnzoqdJi2UI2PSq6kp4f6KYC2QPmugKpS276kM3tZM5K9RD?=
 =?us-ascii?Q?UMrclYsNOHqVBmjIMN+GyhDV7Do35d7naeIK4Fx1X4RT7hBkJO8uZvWykGFS?=
 =?us-ascii?Q?o8jgPFB4E8ZLGRtlgRFYfLjSakGG2aNYPRYgqj9SqILU0A+W+L4aa7mpE30D?=
 =?us-ascii?Q?bBL4ExKtJNqpO20szmXt+mXUxLArS+D4H9QzOrQFceJ+p9u14fma0DxMwyka?=
 =?us-ascii?Q?yWRmFQaFf0HGg+1LQ2td0kwgvk9g947KPhdnM3vBat+XneQHxfyYvY2TZ1Th?=
 =?us-ascii?Q?sPDXYsl54y2eh3MWCPaMBFXmKQ8xygYkF40Fohx1JvGujHdRWiZ9Mn+bIOQT?=
 =?us-ascii?Q?zG4GArjk0Z48lL+23zdnmJnSQIdBwjBoAPZ7U3ypoazZRFh8ca3M8CzqqOSE?=
 =?us-ascii?Q?xppR0oTUgwPfGgv4/+HirfRTdXzrjLcF+VzSeMJkL12TdijxWCFjD5cH4ULc?=
 =?us-ascii?Q?VevqHpEUXs9BhjX89/esgf4W+DXpVSHmGHuotUX52SVfUL+V84N0G2p0PfNT?=
 =?us-ascii?Q?uXJceNeaRE97VrtBh7zWAnbddbbxzIFB8HUpbkXIBJMccS6pfAKENBHC9CoN?=
 =?us-ascii?Q?ULwdsEHTshCcoxWEwMIzFHOz0kgXLI6spXnl0cbHzQsxzNMpBHr88D6IdGJJ?=
 =?us-ascii?Q?8p7VTYJ44X3rm20xwzgODZE5Osl8z9R5qjkcIpmqOd/ywlm18oBnU1SGipf1?=
 =?us-ascii?Q?/bW8WlCHuV2QOJ78kdu7uHUWnZ/2fiU4cOJpGi0qUsvvKDGXKcDsYdomfXNd?=
 =?us-ascii?Q?SsteuH6SRes4X3kddTqHcElt8WGdDYotR8/3r+PYGdfvCRGbTv1AQ+Qo8/X+?=
 =?us-ascii?Q?n/qMW+sIum3p5eEqC3+Tm5Qk25su5qhmz5UPM3tgOVmnttis1feNaE3xRLMh?=
 =?us-ascii?Q?O6eu7LghQ3XC+UVnSt/tthlCHARwgcFZTUuCbQP9sgYNxrvqIVIx7Ltlk87d?=
 =?us-ascii?Q?buGHNYZ5YOxLNi+cKAFAzSEMAxQuCU4dMdT01h4uw+eYlZYM6BXgUN7odYgr?=
 =?us-ascii?Q?22GxyIyyoBE1TlUd3PdRWQAyLK7QY2UBOI1gBaqofYCsSnoAp2FSYgRjb7bC?=
 =?us-ascii?Q?lvavl8d5j4HcSDYBIr1/XUWnZHVW2luwPioH0YuL8LWHLJWnsBlXjVJJ9/Xz?=
 =?us-ascii?Q?QnNQpOj4/fQ84hz+PrEpbHO07QwWzo9yW2q0WrvLoOPOVhsbKHKARx3HFygx?=
 =?us-ascii?Q?05XGMZMMqI6HOXwbMfMhQClEbtnb2zDbI7Rxj2xE65+EkAz/lR1mYr5y2NA/?=
 =?us-ascii?Q?pyiHubC2cMkoFL6iGpU3iEjwld+00i0w4KoZwivJ+iXeUhyNfRVn57abTW9x?=
 =?us-ascii?Q?lrBUVlfafqOe4NmjF4TzZbSoGIxf9yeulAzOY3jvHAMMYrptJ0/x2looY+sd?=
 =?us-ascii?Q?vF0m+GflvSajTMY4dLLYykcw/WLh460CI2Poi5IWA5UjgIHLL5tMn1cSTTcC?=
 =?us-ascii?Q?7itpYr2HUrsx9cQhZfMfHgrId+Dg9YsmyDbotQFdb+daVO7JcDxhvFI+l48w?=
 =?us-ascii?Q?Kigz0IJ5uF03zWZgTaNTciBdSGE871XUxXkxCnk7Bo1fW12pWyr9oG3AMEhJ?=
 =?us-ascii?Q?feGpOTTePg//DBLFKwcd1Fmc7nt0t+gmfrNEG4Bj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b9ccb2-7204-444b-d170-08db844922bd
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 09:03:05.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVXrT32iv3TIVowA14VbcZsIJpQtSV9FIgDh0bzZjDeFJJMKWEH/7oV9jyzDDnoOryyQuCRBbVSWtn8Oy8QYNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6596
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


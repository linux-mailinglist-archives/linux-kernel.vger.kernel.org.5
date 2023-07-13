Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AF57519EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjGMH2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjGMH2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:28:46 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B869C172C;
        Thu, 13 Jul 2023 00:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3zHdQjrjSXxFr05jXA6TGNjl87u7p6bpdTA4CGRUxnWtIqyfdWHmu2PYIIsreLz9k1K5OfyqCR+ZkMtp8lFHIRF3VNbOveZ8Z3iqSP5QUt2BI+zJE2G2c0V8Qt2wPcjXELe5qjSWqPFl8oUfPYHFQ3Pk8z70B+cFxapMnDZ8sXWSe4LhAiJzgNm4dj/f+pmp7S7/v7hquc+eC9M2xWZYFFJ19HmfirrPSSSQlRsO6Ic/zCkrbWPTXNbJYccp/0gn14jDDOIl7FAwAvEufgCd7jeMctiQL+ZsFEXaHePale5U0VedMSBiBsRA/VJqW/Xkw4Y9PfhTzXoR3dGG6aiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFpOYKW5iwzxJ56icRPI0PpaBTfsqkn6CvaEv2T7b9c=;
 b=EHoIhb58N/uuUcjZl62FeovtLji/4Oc8wUx01x7o6X0/gSFezz6a/XWrog4/ju+4lfyvtnsIR5Y+EnB5g/TNX7OEz6r37s9Rt8N/ExISQs9CmWN2H9BiYyP1agconiDgpSF3HPyrVeoispd5dldeEBFLSWmazVarSgHCExEJMgcZTuJpD5roWc2qIn+aY5+ZzsM3gmYUX1O2mvQQ/LiUCqtonF3/OF4BVuu2zaSdIBzspzkm8Il6nNgbdGKuol7+93P/8K+9TYXGYWrfQ2cr1d6NEzru2nYcpWM8QbrkxOM7Jwjt5ZDjI6lHlXLDcWkXInzYYo7Ylf1J47ThP7/baw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFpOYKW5iwzxJ56icRPI0PpaBTfsqkn6CvaEv2T7b9c=;
 b=aandSrtlvxcMTDHf+MGJ5WfQAI6mOVCgkxLJVtah9iqCy4HYJSntCyi0m4SVSaqJFeeQhkPQr12czM8e51odxi2NosVFp/KCF6LsSnVXOpn2WpLtysFJlusu/BzEi+jgI04iglKJfJVaoqmycGX5/3ZM8O2ej2FmCJTuxVBSK4vdToELxZ+Sy1tTnWsc+1+dLpX8YEKZXyMoV38vlo5+ATqdvkNUrs1M2/fw1qQLB0GAN6oVZI/bX+saQzRv7XLrdPJmGhDagDZvhmnSeuFV2eQSVj2sLfEjz3jxJ1PxCtwNQhk0ZVU3+mPPAYOl8yr1ec00NIQmJxRvWP/vaBMfYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYZPR06MB4206.apcprd06.prod.outlook.com (2603:1096:400:2d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.22; Thu, 13 Jul 2023 07:28:41 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 07:28:41 +0000
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
Subject: [PATCH v4] iommu: remove redundant parameter check in tegra_smmu_debugfs_init()
Date:   Thu, 13 Jul 2023 15:28:25 +0800
Message-Id: <20230713072825.10348-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:403:a::17) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYZPR06MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: b0da3745-c702-4f9c-d2f8-08db8372c83c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wnMdaR6VtenMDfUx80K7hb4iTMXMXCzxKS55gPfTCwnRnq1lg7kKuaZeAA/nYvP90dMrFe3NmM1kNKkB+GN1/S/v9PNEQJXkZsO7gLbWtdEeJwLFuohCzNsC6K1yYkViplj4CM7smCoJHX5Sa82RPXDRzYRLMZgjq+AjcxtSP4E1WY93lgNR1vqwz6nAf8TXGi9VRGEfSAj5piy6BertZ2ppolDsWVYzEyeRBxCuOLTug028EhcmyzBo76GAL1BAWwdjojwIiRSmubvgniblzBMNheBQLqkjbnF39WHl1HTu59qGvg0WhdKYOI1ZKBjlFBqJbCKwueIk3ylkPfYI1+SDamLbmMWewWPXmOfGJv+wyM1mGb/7GN0z6ER4403WG3sHijY1CYt/8142fIOvoPtuiV6lnb3dBNCvPVxrn2Pzc2xSiRcNGgIRRLESHgfFLUULXiNbvEejtvRu8aNGyDndnxAr1tgrWkD1mYG26X5B0Kgw8E4QpRcGC1nm9wU9ZaeBFlk9ZucpSyzgmHx8G9Rj6zx7YtAtRxB7GIc3hT8GsmXsEd0q0i4BcH41p24+EIN//MoHnmtDSyAqoqrjh21lBTFP+lM7ys3oM1lwsv8qy2fsYaH94PDhJgPMwbOh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39850400004)(366004)(451199021)(38100700002)(38350700002)(478600001)(4326008)(86362001)(6666004)(52116002)(6486002)(54906003)(110136005)(66476007)(66556008)(66946007)(6512007)(316002)(83380400001)(41300700001)(4744005)(2906002)(36756003)(2616005)(8676002)(8936002)(26005)(6506007)(1076003)(5660300002)(7416002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FN4/JTABdQ912O5W0giepajf+hPQC2smMUAkLcE3iLKIfWd8rR/1M28FeUi9?=
 =?us-ascii?Q?2ucCkT/QtSkTdDnPteRpa2EsOYcq1MvmoK7OBmTCMuKpXPyZ4IWJLa5ysY04?=
 =?us-ascii?Q?tknMvRtBUXU5WiqFOhE6tUB1ulF41MsDZhfj2Hld6hJmMhh2ksKoKXWRZ28n?=
 =?us-ascii?Q?Jg5QbzlKvLReZXJd/nuVHtxNn3Hb2oBIlS93Dj08JlcK8Qiq8wHzdCf+Y2If?=
 =?us-ascii?Q?Meu8P7c9F6hU2tDgxal1IGe2s4kGZxP3QKo5pxYnXkDJEI/TtwPtZnfAB0IH?=
 =?us-ascii?Q?f2OSEFm5Ltvr6TQdURw/KhlZCL5ckRM8WfMCneH9GPezIzPC8M7Aub3e6+i0?=
 =?us-ascii?Q?agVN4XE40aeXSh2wKyUVaoKGQk/txFN6SxM5ibzfx2AsgUgWzFU/4fmdPAF7?=
 =?us-ascii?Q?9958DEumvFs8DFoK9XL0dJpy/fx12GxwzlxeeZgn6oWPQpjW3JNiXLJk74ZV?=
 =?us-ascii?Q?o3Vz7ntaPvkl6pw3ogAdu6BbQaKR1mjBl+/d/N2qYWLZ+h2peKfZmfcFI96Q?=
 =?us-ascii?Q?6WemctsgV5tmTD1WRkOO9cjLb3sNXPa5Q0IuaLECdHHrYoB3xO35axOu7cSp?=
 =?us-ascii?Q?fHX3X7qGvZ7mq9P0SQKRZ+Ako1s9RqPWlI0KkxahP/FYvmgFTMqfyo7Puacc?=
 =?us-ascii?Q?YVvNMrEW+i2hr6tOXjrT5S900jjiY1pSGbmaUz0IT/Prdeh0dOt+o5ZTswFY?=
 =?us-ascii?Q?rjBW4o55GwEUD/dOodbZj9QYK1nRk4pr3JEGdgNH86C8NTXaxmB24dkfbDoc?=
 =?us-ascii?Q?U2ExOXc8HDprDH7qf06kahJies9/s57FTQWKS2sc4C+5H6tQpqvuX4TvJebL?=
 =?us-ascii?Q?RcWR2d34xvIUgkjHUqWA9VQJrD7D4PAnrUxzX/h5Jt4Kgx9N5jDnmpx4kbfS?=
 =?us-ascii?Q?uJtu/8qBV0jt1HpJfq7JvjHnkBt9wxmWizA97RDedHoQu38V5wYcHcMaNZHk?=
 =?us-ascii?Q?XN2XbleZhdvIZsMMiAbdzU2xXAB4fO6YqGv/syec0FkDQtoKqVERC2K9yWxm?=
 =?us-ascii?Q?SqKWJJTKq4AudO5rqKtyh/yROXZjT6NdgaXCje/mMCOKpr4B0QRO1Xck1BHH?=
 =?us-ascii?Q?cvcdZSc336LrF+z+xIUnoBq8JJJswizf02p93kiwpKotA+h+ArndMUHNJeJj?=
 =?us-ascii?Q?BbzVMiI4ny4LhIR3m5eoBX26v/I5AzVQiThBKzhR5hcnwW8Er7AIK1lN3i7a?=
 =?us-ascii?Q?u/voW4k1z8WKi2HJeJb/r35+mMI9/e6do2IZIrJ4SyAftn5+tQ+hOZHjIF13?=
 =?us-ascii?Q?fAdSCK06bCliuov3xIpz0a+1zxkSVb+Wh01ZbuLFMzZZ4/Gw96nvWlsEuM/z?=
 =?us-ascii?Q?bHOpFknLTIIROmUHn5EG5RRgIctdnDIogl8CFyYFFL6KffdZhkovjajv7EDa?=
 =?us-ascii?Q?garU2lubT8fopAhfwIEWZ7ViVo3B/AwAzk/IkyUEYjNtqg7Uew1y5SoWfOow?=
 =?us-ascii?Q?cZKvPZi/2FogrsK+cJBxO5hPTFDDilZFkevjrOfNbwEo3aGJIlpmY0YA4Yi3?=
 =?us-ascii?Q?F8TsUgaEuEdsEN3wdhPvnx5UZ+uvknNvISVeQVdA8uTJubsfm2n9y4IBsgOb?=
 =?us-ascii?Q?s2rzfHxpN//+xaen9TgzKhSsdADcv09rmyQfi8bi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0da3745-c702-4f9c-d2f8-08db8372c83c
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:28:41.4077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cX6ex/y2DGT9IAbbsKu4THE7SgUJxzl0KBYOYpyYA7en6B3rYbO7dXtQuM1pxUC6mnvvCpkay4h6GLvJuTDMOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4206
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


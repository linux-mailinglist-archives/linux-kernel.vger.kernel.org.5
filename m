Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380627C973B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 01:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjJNXQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 19:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbjJNXQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 19:16:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC6FA9;
        Sat, 14 Oct 2023 16:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLGyp/QXjAcKxY21jzVWYMtN6pvQEvtUXaSy2U6SMDlACXVqCF4FKVXpsqUUpLloOM9qFcdwl4+DM+FQF9eG40vBOWEKoinxyQ0QEe8E3bYzkBW1i6XazvOm4nDM28eVYywJvatk/z7bOiBweDQxV+SnD3yJ76YG0nlBKUFIg/TKZUnPDXcGHwbvNWhIb4rsZHx8FKHw3kKcdmHB5VbsZBqEcQyW+ODXvEikj5oy4FkiV/uYcrXfo1XcXeZEBBzFhWkdfSW+Jd362Ck0oxvP4Mf/rNXfIsRPDLA7GHro7oPItqZX+qk559jNbVqkyb24Vh4kjfLgwGto24kAWeaeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7phfv2AECfu4XRK0UbrG09T5zphg34HPY4Afe4I9tc0=;
 b=klx2KuQMnPV9xWGDjvLkZimBj4M7z7AX9nzO90IAMyt+Mmf588TvvNSEdGAWFwu6Vw8w4riTqsimk8pzv1NScUN6mGPYhWBjcqvPAXo0YtRHaLhl7ZnShV5Ix6HFJCpwpxGs9umY2rzgCDJdqlLYh0GFGE5geOegcRaBleHu0U8xXo8pSmjn871s6g55ncL9iJhsGtkE/tYop/7neAWIE2fwUbQqPJ35f+A3Prc+Y9xhG9KYYFtTNdY4WTG6oGm4D0ChfwPyXrHF3953X+jG9Swek7S8uoRK+llARqbvp+hCUyFtXncVz+JExa23pN1MG5NqeSrjquBrj8Px2VKLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7phfv2AECfu4XRK0UbrG09T5zphg34HPY4Afe4I9tc0=;
 b=KhDNe63Bn+lmd5e1csjLs78UDUitPWpmPibdgT0vmZX91gt4vGP9dBVjHFdprhqg4etqGQLbJ76R59HQXlDjhL3n5tpnXd4+CzjESXzhOllOSlHh3akqTdaqqZeqT4XUXSoHxRN4hlDeJhIETeVAsmfaOPM7Jb/3UGttcnWqufE=
Received: from SA1P222CA0077.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::24)
 by BY5PR12MB4950.namprd12.prod.outlook.com (2603:10b6:a03:1d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Sat, 14 Oct
 2023 23:15:53 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::e3) by SA1P222CA0077.outlook.office365.com
 (2603:10b6:806:2c1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Sat, 14 Oct 2023 23:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Sat, 14 Oct 2023 23:15:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 14 Oct
 2023 18:15:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 14 Oct
 2023 18:15:52 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sat, 14 Oct 2023 18:15:52 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        kernel test robot <lkp@intel.com>,
        "Tarak Reddy" <tarak.reddy@amd.com>
Subject: [RESEND PATCH v3 2/2] remoteproc: enhance rproc_put() for clusters
Date:   Sat, 14 Oct 2023 16:15:48 -0700
Message-ID: <20231014231548.637303-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231014231548.637303-1-tanmay.shah@amd.com>
References: <20231014231548.637303-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|BY5PR12MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: 32db848b-a55b-4002-ea0e-08dbcd0b8341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+1/Jbe8K2E4m1HJVnT/tnq9/N4lFdaSXiNrE5/hRTWoiwFBDoUQ6sg7sUnqsB3E5TM2SpgPH3AsovWe09JHJiBQU/CrMz9taYPAQq0vfhn8cH/jEz51i615kzP8BLPgBn2DWEwZ9t0L/OQWmtOVbznlbMIsRJSfGvwqIKRI+oY83ncd2vQLqbWQi1uSNIR+bFK3k0e02xq72UV6zLhYjlUzncojCi/mjg9ObGfYeRGZ2krbfwkOjZIKSqR8RLP42prjookIjd5bAuge2BVTzlWn1h/OXmr3rq5ajLL/YEiy1BrkD2EJ/UMKHgueSqrKW71iHzVlyK6jd0jsVGFTylkhrs46ys3xbAWX2Z2LfE/le19qkYPTOwAtWHFAZT2MVapRwPldWRxtuzOZHDB5gAWZol7ihuQh7K1L9weBycbZC/ocXolwmqHLaSuVGnTPPgveJQhjTGyYGMYxxXQcIoJAXuqhpi9BcZJvm7zeySzBypcS8+cwX0EAoX0Tdp4aDhKQe3S3FhHBJ+M/mNwvagQ5Q7Th3ZBh6ZMtpSIow4uo6oNo8uOh3KwSmj7OLe1xgb74op5Z53eBkHbVE1vyTIl1gvNiIsQYGETq+ezDoIgYL6IHmGjVImFVBFIFoCzw/V7pz+DLN/4puvuvUFOsFBvVnuQZjlmNjLcrSay5HYCDJCz+dw1t8Ih+jortxJHTDON85XZ/WFANjwo90ePUFieWyZYUyAo87MpLuL5ZmE5gIMqO+c8HIP0t6wlGadh7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39850400004)(396003)(376002)(346002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(110136005)(70586007)(316002)(70206006)(54906003)(26005)(1076003)(426003)(336012)(83380400001)(36756003)(2616005)(40480700001)(356005)(82740400003)(81166007)(86362001)(36860700001)(47076005)(966005)(478600001)(6666004)(41300700001)(5660300002)(44832011)(2906002)(8676002)(4326008)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 23:15:53.2901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32db848b-a55b-4002-ea0e-08dbcd0b8341
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4950
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enhances rproc_put() to support remoteproc clusters
with multiple child nodes as in rproc_get_by_phandle().

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303221441.cuBnpvye-lkp@intel.com/
Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/remoteproc/remoteproc_core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 3a8191803885..3d95543971b5 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2559,7 +2559,22 @@ EXPORT_SYMBOL(rproc_free);
  */
 void rproc_put(struct rproc *rproc)
 {
-	module_put(rproc->dev.parent->driver->owner);
+	struct platform_device *cluster_pdev;
+
+	if (rproc->dev.parent->driver) {
+		module_put(rproc->dev.parent->driver->owner);
+	} else {
+		/*
+		 * If the remoteproc's parent does not have a driver,
+		 * driver is associated with the cluster.
+		 */
+		cluster_pdev = of_find_device_by_node(rproc->dev.parent->of_node->parent);
+		if (cluster_pdev) {
+			module_put(cluster_pdev->dev.driver->owner);
+			put_device(&cluster_pdev->dev);
+		}
+	}
+
 	put_device(&rproc->dev);
 }
 EXPORT_SYMBOL(rproc_put);
-- 
2.25.1


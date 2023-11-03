Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0667E0861
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbjKCSoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjKCSoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:44:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18486D6A;
        Fri,  3 Nov 2023 11:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmWdk9cHziZ6E/20m1SaeHpNZDjhq0TINqO5k5gVq4ngrfyzvaivRSUGkuuPi1qg2youeZiptuujxCMKDqvmm5H1kKEG6juwJucZeMFPJo34avq4RUpKxoEhBV/y8NlrFy35wDYFfRB7Vhlzp10aS8XMmfv2+15auKC2SbxsOxrpq1AQpfqonP4qL8zICtMDB1e8iwsN043wxBk0WhmC9WTdK5nCHAMsKpGFqGCaNOXVMcugEmkFITIofesagoo1RLdCvU+i2zVYrbUDKJDtUpsJ6IyfaMc2CJo3o7kei3p+Bxx6p74eT0TyA+PqQzR0H9dfxhXa17Dn/MpSeSb8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LhsGfsLxMuPDe+MNkpY1lKJXyuQEv/AFtrE1y74pZU=;
 b=Yg2XiE93X35Num0WH3kwLU8ImRL3p4ia6lJn1E+GO+59OQUZmqllP5YHhUSLMUKFFspzp0IZuIh6aGXWHtqtJcFgfbnYp2NdTW8kmxZbiI+qHEvD0q6e5oQD7ujRUXG3ru7b0r/ghdtydv0NR2Tsy+8ZYooCp1EaiSWQptYspfYqxzgovik9DhA8/6rn9bctW5FaDuZS3ZwUgT7QOofpizI64CJi3QajToIxrWpf/21jTVpl+MlDUBN5k+mOOlHuw4RslrSazCaCSIrACJg7FGMcJPouX+91Tsk0nBMFtkyIGUS+uc5teIU7MEDm3jDkHanhRO52ZJeHs1cJAJ6n1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LhsGfsLxMuPDe+MNkpY1lKJXyuQEv/AFtrE1y74pZU=;
 b=TzhUeYEq+LBy+9n3uMUhipGJPAWxmWWdKlGAk5PT5WgtfJvBavr1ajoS8H9V06I06lV58EiOtTQu2LNSRyJd1xLyRsopK4xMenfH73+YxbGcFtexZj+j/ZhLE0sKT0ni8CLxvGNFnXyvTsoVzCclmqmsDjFQWKZc+jucfPdK7Ro=
Received: from CH2PR15CA0013.namprd15.prod.outlook.com (2603:10b6:610:51::23)
 by BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 18:44:08 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::3) by CH2PR15CA0013.outlook.office365.com
 (2603:10b6:610:51::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 18:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 18:44:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 13:44:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 13:44:06 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Fri, 3 Nov 2023 13:44:04 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>
Subject: [PATCH] spi: spi-zynq-qspi: add spi-mem to driver kconfig dependencies
Date:   Sat, 4 Nov 2023 00:13:51 +0530
Message-ID: <1699037031-702858-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|BN9PR12MB5068:EE_
X-MS-Office365-Filtering-Correlation-Id: bb209b03-daf8-4a6f-35f1-08dbdc9cdc93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yctbtr58Fv03CQPkCB40IJRf2e+gDSCyKk/SBAM0U7NPTlBD46D/vHrPVCFjzky0U8hKPDilQGwxd6ZZhWKzlefy/pgOIDGyoo8ehvu108DUiGRk8hqe/pDaL8B/aOn+zSqx9WwbBHWo/cYRZHBoHUu/SrwIdJz0qYKHQHxqILUm+K/kl4uzyjIuOfKKLOuxfBbCoy+W0T0Vk9PS0UMvjJVd9z4Ip/5DF06lZZDkC9uP2oJqXcMkOfI0+YXNsO4Elpi9lswN4NpU6FU22Z1jMVKxsoxlU2lTzacv2V5EObI/gt5LmbLvZRtJDlbmX/OkTK7AbjBxHTfYYz73u/j8hFm0Uh54k/uCkFL9VDDizmu/zoAL2omM7q1R0OuCyfsaaXx3G8cBtuVuTpuWIW4ZvByBE+DRzYOjFEQvz+Opz/hYbpAPt0GJOnWN+RZq5CGibkbCqCH2JuaqLV4YkURyFvaFv6hCFSm4Vei1UXHCDP6OwSB4S3Ajg2CntDW//1ZO0tVzQz5FzhSpqWc7eb8Th561DATywEaIRpZOSoKu08xSUsSmu9cr+DXI6IV+GHNfxD2m3Y6LkaKluCdDtU6e6S0xIMkx5fTVubKvH0YUYhPkJ2KaELBYBSLWAIhQOC5q+NEXBFOfKhLxagbUDcTWXUsEFI7FVD+oPlT396qn9sGEYrMPptrEIsiWUVEBzaUKlMOYHGl3yhFNF+vY603j62af3/qypAxYwXV38HnMobyGKNFkZA3KH9dlIt05TnSN1rrSVwVFdUUO2qLffkIK7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(64100799003)(46966006)(36840700001)(40470700004)(86362001)(2906002)(4744005)(40460700003)(36756003)(26005)(41300700001)(426003)(2616005)(356005)(81166007)(6666004)(36860700001)(336012)(478600001)(82740400003)(47076005)(70586007)(54906003)(6916009)(70206006)(316002)(8676002)(4326008)(8936002)(5660300002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 18:44:07.5919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb209b03-daf8-4a6f-35f1-08dbdc9cdc93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5068
X-Spam-Status: No, score=1.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>

Zynq QSPI driver has been converted to use spi-mem framework so
add spi-mem to driver kconfig dependencies.

Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index c7b8596cf990..1336815a0c2c 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1158,6 +1158,7 @@ config SPI_XTENSA_XTFPGA
 config SPI_ZYNQ_QSPI
 	tristate "Xilinx Zynq QSPI controller"
 	depends on ARCH_ZYNQ || COMPILE_TEST
+	depends on SPI_MEM
 	help
 	  This enables support for the Zynq Quad SPI controller
 	  in master mode.
-- 
2.34.1


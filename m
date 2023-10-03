Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A713E7B6253
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239191AbjJCHOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjJCHOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:14:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4A5A4;
        Tue,  3 Oct 2023 00:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3cviPoGURDV6RsVYgpLYOVfFLeKji3qu3E9EIB5dwx/WLApw3A0jF2BlxDLsPvQZ9xRd+WCNEb/CfgA63QNwfEl8z9k2o9tfPt/IubPR47Oqiv5UTy4ADfRsUYBRLcOcb/g3r4gvHqKL5w+GIrOxonsi9AZEptu9qIgRfcgfHiWmsBn+Xt2TlVGB8m0ZiObfPslxj+lqrr5vJg8KSWiR/S/pWVQ94RoKrWwUzz5+kw+JWCExDXTXgNsZLap9J/Y1qnsJ256Mix7d2tjoiDh8DCQNYpjkgXBHFrIhYTTVZotF7tQfgjnltmz/DDG3KGz6Mc/56xbc2HdNjxipQbh+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/k980w2eIv3ycUw4/5JhKiMuC4vObrbFQ1upOkl/LQ=;
 b=YWLaoy0HFKO7S4XUUDO1R/AYwLkC+7lFLtB5VM6+GGtkt8Tpefg3br4UObDDjVr+rT1jI4Scuef+HgFleNHyvPJRJFJti1Y8rRcz0UVbeSN2ouyrRggthr/ln6NB3g+qNM7pcl/OBZxvrjfREi0jVAlQgyYEf0NO+cXAT77yAegRnM+67lVAxlMuCmXvE4dtFn7nujJTksrMKIG0LZXXF/KHqYzXWpXcprfwcxTfIuuSVzYUS6NLkTohsomBJfuukEecFE/qyP4z3jDQoW+Ufx8Aik8PobykvIw9E+4Y3+YJsFPo4lo3BwyYi9lKxVKOdcuCKTmFqCMe7s7csIjA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/k980w2eIv3ycUw4/5JhKiMuC4vObrbFQ1upOkl/LQ=;
 b=ro8jZ1yqTraPw80C17eb0myXmlWMa+UEx+BX+x5Uimit/qZOMLMyBFpRDHK2v64nhGfHa0RoKrnxSab0V9fGyTvvxH1M7Dmb+xuPLDIOkeYs+1osvuf341POIgQBj0olyrau4K4maJbkj9dYQoeXQEB1jVAUECOdpuOvKhBReGQ=
Received: from MN2PR04CA0020.namprd04.prod.outlook.com (2603:10b6:208:d4::33)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Tue, 3 Oct
 2023 07:14:13 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:d4:cafe::41) by MN2PR04CA0020.outlook.office365.com
 (2603:10b6:208:d4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Tue, 3 Oct 2023 07:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 07:14:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 02:14:12 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH] fpga: versal: Add support for 44-bit DMA operations
Date:   Tue, 3 Oct 2023 12:44:09 +0530
Message-ID: <20231003071409.4165149-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: bbaa571e-0ff9-4685-94b5-08dbc3e058a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CoUFg68ru9GHALbqaJT8n0ImnFngHBlS5xmjh0hsbo3uby6FuiFW6MaZccv9gGd+zFtQRzsfHwZGWdEgPvR1IkFNdyU2Sh87LED7lEy1Z+ypuR8TotrDbB4BLagsRB4dXqE6TFpYHu48bmxTI4ZfNsAt9EIzxtdgzxyCbQgCQHTbC9gabmI/sa2CzJe88oMmCsI/5WEqoGVLWA8Ayglvv3OhU9yl8vd612xd29Gl305IFlxx+PXa1s0aNSw6Bd5GjSpzs/3oT7ZqDZi6BO37f4fpllu40ie5xNAkg5r12+YUlWjddq3rEcPcwKm95MgRZqTiYtQgO4T0z3kTSo1Afkk7MAf2j+QkrqV62JUWFFlRhbmIKR6r+I/1WEwGWB84AHI2HZx6ltVjfXvnPLVTLk3wrBRxpLmE1jq33pTqFY3GwI7ldH+7WFDfgrNkZZaZeDwAKmCE374NKdaSPFlkSUDDTRcIU5Sb4OWWrewP8kra3KA0zgVpXVw/UPcuTvkUks9e5C5MBQJtKR+0hsVOaotKRD38RGutLGhXOIevO0sqvShSrfRcCDMmhF8+ah8J0wQcPRtWe76aS59aJmWIpXfLgsvpop/BbLt7j6kJnogiCd59nVuHkWMJmuUr5hWw2Re6uoolIAHacFe0VUtA20VBDQhgYgH21UEzDquBiPlwcnxPF0sMcpH6EG2l/L7l2drcXyL9iGBlWVzrS0zEleNPGC7J1u0cdSkJzl48+Si97vLmNgYxYfeZyLXdEhwu3x1ZZPtSfNf4jj/FbbQ/j+4AktJUvbs6UKfGUCJYCDjMg7CygBzXv/XwC7KxPU6a
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(6666004)(478600001)(36860700001)(47076005)(103116003)(86362001)(82740400003)(81166007)(356005)(2906002)(4744005)(83380400001)(426003)(336012)(26005)(1076003)(16526019)(2616005)(36756003)(70206006)(70586007)(110136005)(5660300002)(41300700001)(316002)(4326008)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 07:14:13.0056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbaa571e-0ff9-4685-94b5-08dbc3e058a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
X-Spam-Status: No, score=-0.7 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing implementation support only 32-bit DMA operation.
So, it fails to load the bitstream for the high DDR designs(Beyond 4GB).
To fix this issue update the DMA mask handling logic to support 44-bit
DMA operations.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/fpga/versal-fpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
index e1601b3a345b..3710e8f01be2 100644
--- a/drivers/fpga/versal-fpga.c
+++ b/drivers/fpga/versal-fpga.c
@@ -48,7 +48,7 @@ static int versal_fpga_probe(struct platform_device *pdev)
 	struct fpga_manager *mgr;
 	int ret;
 
-	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
 	if (ret < 0) {
 		dev_err(dev, "no usable DMA configuration\n");
 		return ret;
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851397D88E1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjJZTYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZTYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:24:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A02187
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcNR3pRFLuuWajTNEDTdeVURBUaXv1ioifa6QFKFTXbMh5mgM/Cj/8VfmhRWMUIJaUXeS8uh1O2jyIbXUMCXMypCTZ3Y33e0vzvxpFXJY4hxIn9LNvSYCZA0brCbgNoeGOIbXq/GEh89PApkqiBNZPSxYtbnlSMSJtrBy6L+pN4F821CMV4UZBY+sxfSCo2mGAaiicuwN4y3JCLBa2y6vBLl93h4dSTlx6j/i6nRuV5qsfQMVOxM8IoAW6SFJx0gPCDVQR5NUBqQijru69G4ihaRjXIcSahf/f3Np0vI98D6DD6TcSkkgMup/Gu+g5zkUqtXPO/XRZNob0vxLKZoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjcmEdeR4zDCQQarlb1vdPwNrqplS8mRkmIwyj+n/WU=;
 b=fk2mKsoNA8PSvYx8CKGcaAnevVFSykFKS9wt72Oo6z1TlMfaSKYqjwdWoJOu9z9P30alUugW45Fu13AHkdBL3wQBYYkC/RFIbrhdV+1U3RK8EQqTluPuVf++SNtzq6WVSmBQpxxaQgA4IHWDre+tbdlXnO0twddYrcvpUu8/JNyQnng50MexMG6nA/sf8XCrRudcSV++jJhnLoliH1WD4uj/Nz6NNV7YRk0iJOauk8uN7CHx9ag0CfbHV5rGex5n5CIwqhX0nAzMIH3PFP4ieaxkFF8y1IEkCmagTH2I8jdioKzdbWUzlULlMtgPYRJCgToSh6jwKIhUCpHcpR2V5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjcmEdeR4zDCQQarlb1vdPwNrqplS8mRkmIwyj+n/WU=;
 b=tYGtIwVvA1LmgMwFzehhkda5JhQTOZkr4tP+21w4mdY9XEu4UAMU1Zycc+fAdGc/oA6s3DwC+dQgZuKqThe5xx5O8Noa2LvzE3ejuQ1nW0CKxeJccuYib7iTFZuR4ddgVXSV1Iv7V/rJt0P+eyyW0zIn5DOCCl0aiHxiNiYqvnI=
Received: from MW4P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::15)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 26 Oct
 2023 19:24:04 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::f2) by MW4P221CA0010.outlook.office365.com
 (2603:10b6:303:8b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 19:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 19:24:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 14:24:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 14:24:02 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 26 Oct 2023 14:23:59 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <linus.walleij@linaro.org>, <tanmay.shah@amd.com>,
        <mathieu.poirier@linaro.org>, <nava.kishore.manne@amd.com>,
        <ben.levinsky@amd.com>, <roman.gushchin@linux.dev>,
        <marex@denx.de>, <ronak.jain@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH] firmware: xilinx: Move EXPORT_SYMBOL_GPL next to zynqmp_pm_feature definition
Date:   Fri, 27 Oct 2023 00:53:58 +0530
Message-ID: <1698348238-2320426-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 85410b7c-cdb9-4817-4d5e-08dbd6591dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svNAf0J1QJiX+svKNvjCCYf63SWV5msYOD6DTm268K4WkGIFvwl9wQs/m0KJ2Vc6+1GyqXI/2PGbPW8SqH/iGkffk8WQJ/jmHhnEEnQ4aYcMSW4l+JH85Hkqwfcco0FtXQoqVkNSxw7Th9k7JBt7uYpX45rAJormYcvpgOXhYCFbiMkcTRCncpkw0UVbidfZXqpJi2hWeO4bef6i+AvFZfNE8qkIVbaxhxF3SHm/aW2vOYaXMSy4H7M8WHM/HdDP3TaXGctuaEfuWHIHvAswBEqn4tQs/bvC3eruEGbBw+SX+ZtEIKaeW2ULrWm6dNddcCT9Q+Hfv99ttM1US5PI8oj4RgsCqmyy0QLn30oJdoa5hkP5qag7Yg0uDzsWvdOK5nlKQVJrKOV2eLL4Auq+eqgg8W5JmOU9s9/oh9uAzF2DehXeJp45gxnF0/SFJogU6HDZPFnOonVlDRkTdA1F9hP8O1mPRcIl1JHIDKoJdFHCkHex7qgWxM0Bvh5/RGAg6bPfzwCanpz5yIkhyMj5MSmJTAGxIk8dP7klci6K0DR8nN/zgEQAoj0OV6ntzcKefbERRmxw1+CsWipNtEqDDu3e41EkNjRYVXo6U31VQtidZAbbg5eZPGT4hwdNrevMhfA62Iua8RavQEB28tm3JMRVVYf64qvrirNq3z2GdR8bnJwXuHFJ+x3m+C5CbWtDVhV9G1I/t3LJ0nRGZvA+7VVlyX0esbWCvdINZH27nTmSjzJE1wd/UQJUfO/Z5cv9McX4Het+Jq71PbhKA1pOEZeontqVHA67wGiciqRq1Jg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(1800799009)(82310400011)(186009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(110136005)(54906003)(70206006)(316002)(478600001)(70586007)(8936002)(921008)(40460700003)(8676002)(5660300002)(86362001)(36756003)(40480700001)(2906002)(4326008)(82740400003)(41300700001)(426003)(336012)(26005)(81166007)(2616005)(47076005)(83380400001)(36860700001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 19:24:04.2209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85410b7c-cdb9-4817-4d5e-08dbd6591dcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
X-Spam-Status: No, score=1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

As mentioned in Documentation/process/coding-style.rst:
In source files, separate functions with one blank line. If the function
is exported, the **EXPORT** macro for it should follow immediately after
the closing function brace line.

So inline with guideline move zynqmp_pm_feature export symbol after its
definition.

Fixes: 218f01a80aea ("firmware: xilinx: always check API version for IOCTL/QUERY")
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 4cc1ac7f76ed..b0d22d4455d9 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -226,7 +226,6 @@ static int do_feature_check_call(const u32 api_id)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(zynqmp_pm_feature);
 
 /**
  * zynqmp_pm_feature() - Check whether given feature is supported or not and
@@ -246,6 +245,7 @@ int zynqmp_pm_feature(const u32 api_id)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_feature);
 
 /**
  * zynqmp_pm_is_function_supported() - Check whether given IOCTL/QUERY function
-- 
2.34.1


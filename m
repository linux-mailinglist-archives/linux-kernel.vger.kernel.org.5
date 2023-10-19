Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098357CEFDB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjJSGHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjJSGHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:07:40 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD538116;
        Wed, 18 Oct 2023 23:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqRoeEedrx6losrgCCdVJJ/sDd4PJqQGotdSZCPZiBqxnO2NdBXrHc9lXwyr4Bnh70fPtNLb+kMf5FTCWT3RkirdmmQ5dgi6bfU2ulFj1NobDpUyCIYHAENo0QCEWQZeZjBD+fjlinqM8AmA8wh+lBp44lG2PS3vG4zx3n2CYnFNDuevvW/zixNvZHeRW3dIbKk8BiYMqLmXYHqbqZS3uX3QsAHb99hvsS7ENdnCyWxBGsDg9kg6po088crJIXmgYcOQcRVBQ4VhAD4Hg0iX55eSebxtcXhwaU/74atPnMdl4LqHACnLhvJrXkgUdlPZGDV6DMesAPdDbVFkslQx6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqiQxZyeK7Brz0Iu5BP0YywdYsG8vDPqqiZaQc5xYEA=;
 b=dAmQ683pBLjbgbM3ux4/T64/pIboln/dy17lSEKU3XbrbctHca957mHr6JIVp5A4pm0+VtB2g8zlxBRWNXspgcaDqkZ/boGT8no7/k4GFGCfwOuxHZV9xHSI9RbEqQMfw3CuaEcig/2BaU0PzJwg4ED/6d6LOwSxNjzu23hD5K0pfQOh1hJ1Q6hnT7YFn6KmnQS5FMfBnVc/CxiFyzsVptaHPD2PFZ9z2bC98hGVVqPN4NHZ2f19djfgiuapYZlwyklLsYzAXMSN+lt0ign9uoo9FXHzMcxgciQ/v41OzQ/vY8XmQ++1oJ3Ab3Lho5zIJzgLfvKmnbDVKdYPMpH1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqiQxZyeK7Brz0Iu5BP0YywdYsG8vDPqqiZaQc5xYEA=;
 b=soUttBYT/mLiS2R2LxmPWi3GPwzgONR+PC+aC8QF6Aq+TrczdrutOuChWmC64b5uGXGbC4MQP/Sryj/V5IVO2j5LTcKFV/tF6Tn/EF/vt7t0NJ9gLkh9lcj0FwkAPPHZX2B2OMDfJM6tqLeE/M8q7J8TM+K0dl8omSFMxTrXUvM=
Received: from DS0PR17CA0019.namprd17.prod.outlook.com (2603:10b6:8:191::8) by
 LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.36; Thu, 19 Oct 2023 06:07:36 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::d7) by DS0PR17CA0019.outlook.office365.com
 (2603:10b6:8:191::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Thu, 19 Oct 2023 06:07:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 06:07:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 01:07:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 01:07:32 -0500
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 01:07:30 -0500
From:   Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <praveent@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 5/5] MAINTAINERS: Add maintainers for ZynqMP NVMEM driver
Date:   Thu, 19 Oct 2023 11:36:51 +0530
Message-ID: <20231019060651.23341-6-praveen.teja.kundanala@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231019060651.23341-1-praveen.teja.kundanala@amd.com>
References: <20231019060651.23341-1-praveen.teja.kundanala@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 6647c2ec-62e8-4154-7ee1-08dbd069b137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ckkPxVTZoHn9qE0utLsYp1HuAkV3lozSBldTk9xAn66JPK/UIslPrqGIBAJnx/ku/3pX//wcxmblzrhynHpEpW67f7g7vqcnFyJb6ZzpPR7T+vRipAzxH41CytPUYyiyYr4fJ5idLJIDY9GIKiB48YWLdsrS3Qv8AxrBOi5vXtZXKMrFq1Jz5N3KaLu8/V/duPvMaIG1Wf0gyXBARTmotV9tlFs52kfOi4xbxpdpwE+S1sISCOoZySC+Gu78qDlh9UQ4NHKSJ/pHLC5i52DAKaYCMD8GgF68cGD1aWATcjsQnGKN3/lSKGSaDXF8EW36qJPmJldoEU28qgVAF4OYeiFWyLaCmwXWPTVBql9c794AqLyjnqFs+DULY+h40UGn1TqH9rQdBpCnBL5O8b82AkY9V4SoTDpCUU+3cxk0FjcSC51LTSD/0ITvv/9t8AwgP4Ej9aPnJOw/fq/y7qUO8beN5cGNJFWCfqmtfQqpSurURiFcJ+GK0JiOJkGyrQT6NDbA5AQFxB7r23rmeWS8gqyzjrreHbVcXL38W0tmQP1baLB7bqhSYVQQZ6t+jwmDae8wvRDc4Rd5/4oWrNFKb9P/4Wl3sh9mBvRMlFpHvPls3D96OxdGAXdig+vIpLwkUKqeYe7pVjZDHX1eqLDhg+auy818gkyvYH+tERdP6LrW1YDGc/TrnR9AHEB9/Cd0O/qIncI7rsGBl98dTwq/NOcAn/IqGcKtUCwVyLYXJlTlFcZuojrNTcxHQx1B9uuCosI6nfF7dstzXkHA+X1qbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(103116003)(70586007)(70206006)(316002)(426003)(47076005)(110136005)(6666004)(36756003)(336012)(4744005)(2906002)(478600001)(4326008)(8936002)(41300700001)(36860700001)(40460700003)(26005)(356005)(82740400003)(8676002)(2616005)(40480700001)(86362001)(1076003)(5660300002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 06:07:36.5623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6647c2ec-62e8-4154-7ee1-08dbd069b137
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers for ZynqMP NVMEM driver and driver document.

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..c3370a8a7709 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23765,6 +23765,14 @@ M:	Harsha <harsha.harsha@amd.com>
 S:	Maintained
 F:	drivers/crypto/xilinx/zynqmp-sha.c
 
+XILINX ZYNQMP NVMEM DRIVER
+M:	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
+M:	Kalyani Akula <kalyani.akula@amd.com>
+R:	Michal Simek <michal.simek@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
+F:	drivers/nvmem/zynqmp_nvmem.c
+
 XILLYBUS DRIVER
 M:	Eli Billauer <eli.billauer@gmail.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.36.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557807C8211
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjJMJbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjJMJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:31:34 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4838B7;
        Fri, 13 Oct 2023 02:31:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0/GDvNPieOu/WXPUSDlgf5xVnyU448TTazUJZAL3gaoviV61FDbV/n3VLFRnOUzsWNV/nHbbjoz6QHfHb0+1A/50zE4Nuw28ea1zI9HiefF6QTqew4Z3WyeBzSClW/Jse/5T4CKGG+XuueNP8hcUHmlqGUsycYpZh9rrvb4c2Z5kIR+QBOR91QJl7sWEbjtWDdTpenM8vAMEvxIMm4Zyj8oBNdWppnmpyunwwOAV16QE0KgBa3WhUTAYqjJv78CzfSeJzOxusAdOOTmAkcogTGfV93MnJgM7vz3hgnGmdODs0quEyoc7yeAPK8S4NTtpmTo9csfXUT+otgF7Nbkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtm4mCjJG2vTyXh4yyH4CW6eg0lezfO+4SJo+3d2wd0=;
 b=e8nHjbKWVW+ka+kny+i82HBlyV5M8uN85LhGWScolYr46yRFgOy0D0Zuwa9B0mjhkwmzlx18jMR5UIYMSVgnmwPQYL+CCRJhyJRQJqPVERm5xJNNNvkFphJdpArDALSGW5ShzYSYBefmAiq+G6JvEEB8GBhMuRQjQzoiVOTa88NxC2VzrcP4BVpAjnjZZdGVoIgLmcy81nuEIfTLptGUCLyp0hGWtwcDIR1SYGzupOsZcw2CCs1BSgWaeP6dXTnnW8XWs0+VNjRotvBYNvqPXktLEdX/yJR0OKbcmuYDP5FWw3lX7M/WCR9Jc0ooDcENcWLh+wdcMa5UfrQtRiA64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtm4mCjJG2vTyXh4yyH4CW6eg0lezfO+4SJo+3d2wd0=;
 b=1NZfnS22T9o3seKJFPCudQLJvI7r/XG1Dv/TXxqRljehIRQSR71Ky8xKdStd6KPblZSzkr0/wVBgwt4W+qdQSWojSbRvVr9eNv5mHSCLgf2PZdKqbNKwGYRJieJZ1mYqMbn2Ip12yW81XseY+DEnhm71LY/+HxoDcB3jrTqATUQ=
Received: from CY5PR15CA0074.namprd15.prod.outlook.com (2603:10b6:930:18::28)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 13 Oct
 2023 09:31:29 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:18:cafe::5e) by CY5PR15CA0074.outlook.office365.com
 (2603:10b6:930:18::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 09:31:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 09:31:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 04:31:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 04:31:28 -0500
Received: from xsjapps55.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 04:31:27 -0500
From:   Kris Chaplin <kris.chaplin@amd.com>
To:     <kris.chaplin@amd.com>, <thomas.delev@amd.com>,
        <michal.simek@amd.com>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>
Subject: [PATCH 0/2] w1: Add 1-wire master driver for AMD programmable logic IP Core
Date:   Fri, 13 Oct 2023 02:30:11 -0700
Message-ID: <20231013093109.37165-1-kris.chaplin@amd.com>
X-Mailer: git-send-email 2.42.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 1547f34d-ebbe-45c7-1168-08dbcbcf2e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ytrwNlNRWfwkuKQh+201PrQoxX8PXg32p2acQjDlUf4nu3CgmDGgO6KQPVfwCFgLtFp1aViVIq1tIzC6DWM6vPXKtZBsSYrguZc8sF5dvzAWnDTKEQnslzj1qTErTBB7SJ/zpBkcKzBG3xvcOpyjmr22w2ok5fIom8FhMzmEdHUGuelFG0I4TIIAcJjJskm5WSMLS7ouiZaay4gv9DEfA+n/BmMqsSpohlVuzy6kmnJ1ltMyC6oKpvn7i7xQGnwTg6NX45kbRCyKWRGeT6fL8J6JTDSj6Cw3BEjbHij8Rg8vJhifKUPEqRUMZ3OaCWEl/eqsgarOa1+bSHR1gvMuiouWO6jhTnGoxE0IZ5GDuZyFoppRIyqCi7E2PIJdkbfUNIDRglRIq2xr6H3RG//mhdeTK4oqQRPiKYdl33IVr21Mr8np4VHjVu9T+zvUugauhZB3tRaW0fPKg9iQuCD/JkPFTCFTtlnl3c0JWNLTBUaZAcSDGSYy3oG6/2hr5gaGMPQjxsho43PRMD5vh8QtmtQHg9X496x4XYp0KCsupJlrMD21GmUQzxtB/h7VoBcb8CEdM5RNHI5Qfs56KEnUa2SGdp4DZwItd04cYZSUASDkEEmJxyb5GLNFZl/jioCcwEtPrgGRJYgxGyTvV4eXH0jx2RrquXC4Z1cPBlITee3hmuLlhJR6l5MAZVCzBY3jhjpK+JeT80gr/cxlpaWh/nT5PKmhRl1HB7Zb/mVZ3d/0n4cTRc8MnTDmVC+zc4lPrhIw1GRuvXuG1Ez8Pb6EQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(86362001)(81166007)(36756003)(40480700001)(2906002)(4744005)(356005)(6666004)(4326008)(8936002)(41300700001)(478600001)(44832011)(8676002)(5660300002)(54906003)(2616005)(83380400001)(40460700003)(1076003)(47076005)(110136005)(70206006)(26005)(36860700001)(316002)(82740400003)(336012)(70586007)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 09:31:29.7172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1547f34d-ebbe-45c7-1168-08dbcbcf2e49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a master driver to support the AMD 1-Wire programmable logic IP block.
This block guarantees protocol timing for driving off-board devices such as thermal sensors, proms, etc.

Kris Chaplin (2):
  dt-bindings: w1: Add YAML DT Schema for AMD w1 master and MAINTAINERS
    entry
  w1: Add 1-wire master driver for AMD programmable logic IP Core

 .../bindings/w1/amd,axi-1wire-master.yaml     |  44 ++
 MAINTAINERS                                   |   8 +
 drivers/w1/masters/Kconfig                    |  11 +
 drivers/w1/masters/Makefile                   |   1 +
 drivers/w1/masters/amd_w1.c                   | 422 ++++++++++++++++++
 5 files changed, 486 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml
 create mode 100644 drivers/w1/masters/amd_w1.c

-- 
2.42.GIT


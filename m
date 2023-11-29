Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF17FD598
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjK2L1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjK2L1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:27:13 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DE584
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:27:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdjJaAbPHwrxWAzThb1VC7dEwWWgh/cJMCmvk7qhIDHHSEk9XD8YDAwQQmYKaUger1MiBTeeDCCXyxJxqjwaoPNlrUjYPn9XqDIcLUAIlK5zoiTovcxbErSMtbAvgDf6umpvffLT/4F9ahQAoSlH5c7a8kNRCsOLGgJJ11eVw4jfkskFlp910iJISfkmOGNvd9msmfwlJpld7tvVdG5TPjxVxCSX+enzuDpcpnFv8Xof6KmHcC1yOZ8vEPT/1JuKdcKEI1ETT3sviH9b6iEmvbWpXMGlgZ/8x5SppsXCbgkdpMovl04kldx3xJsn/Dp27GPdkpt+K8V7sEv2nt//vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2HfPf4mZTLgJGxq81Ee1avf+/RJceBRBzdu3zwKH5A=;
 b=CzI2dCZ3uiBlTMYEN11+837Sy7WFxUXg1TzAMWnqrYKm8cC3xuidfFBapxtqsgU947v7v5VWmewTnJKgFMv4nDIjWAjZeCZg0qttx1a7d6+Di1cze0fomUrGs7y6d+16inR1usYPyO97rLRyviRe0o0i8Gj9Oo5Cdzm1w6QZ2Ngl7+FhAPYFUEFZw0GiXwG+Y/jSZ/5zIa27BFTuYHTR+WQorum7qh5oQ8D0Wj2hqh9z0dnc9Gbz8q56VkwtUwMeQghiXqghNUeFnNFjnh1lUywxKJDCQBpnyqN7QkPkqdk+AF/ua3digPIa81MIpUXMsUR0a7VwTpSR6BM8RiJupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2HfPf4mZTLgJGxq81Ee1avf+/RJceBRBzdu3zwKH5A=;
 b=0ohXS54ScnmF1fbi+rH/Zr6N0llA4LRpD65MXoaU4GJTtYecOQAjh+w9AeFUV2aMCcaTUobnRQLcUWrhPwOzD3/9pYCnh6sIJKw2G/OG0WXotCkoyt3BquC/Ag8QzcBA8Ku8kAbsjBPX1MUoXjeNqTQlnnEpY/C7gB+KBIVzCIw=
Received: from MN2PR18CA0030.namprd18.prod.outlook.com (2603:10b6:208:23c::35)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 11:27:16 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::22) by MN2PR18CA0030.outlook.office365.com
 (2603:10b6:208:23c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 11:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 11:27:16 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 05:27:16 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 29 Nov
 2023 03:27:15 -0800
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 29 Nov 2023 05:27:14 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <nava.kishore.manne@amd.com>, <sai.krishna.potthuri@amd.com>,
        <robh@kernel.org>, <marex@denx.de>, <arnd@arndb.de>,
        <izhar.ameer.shaikh@amd.com>, <ruanjinjie@huawei.com>,
        <linus.walleij@linaro.org>, <shubhrajyoti.datta@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v5 0/5] update for versal net platform
Date:   Wed, 29 Nov 2023 03:27:08 -0800
Message-ID: <20231129112713.22718-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: a978a243-4e5b-4a6e-177e-08dbf0ce2452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TvHmus01ahZRdHdgpabIW9Oi62HZJ/aBTl4Y2k/rI6RYDHa6yuqAKa7oIeIwdavmq758eFe2IS6radeNICRFMc2cWjOYRi9n9+EiA1ldeg0dmmNUiGcYqil4hA6Ob0rP+GjDDL6neZzibN1Bgtvuq5W1uY13LP6eAx27LIRT1u0ImP4XMBb8A64WslC8cIEkyguP8gIH65wQ0pdaYP/DM+oVuby3fWQ/7+6xJz+NoED/v3/dXWuEl3cZ2Iy/RfmOaGWeNLq7kfGVeXiAhZZj4uHD7Z+OJqtxLlKDy88wpJSSRe7WYr/R4DgzmffV16A7DD92lCuJFtbtFhG+x6MMMzCUhIvgrCoWBS9aoMfKrVwQctMyRwn6DpYwZbtWMqWARlfNE480AWV0+gl9IujfHonQqrVpkxEqb8Ut4G9WpBmVfIjT6rF6DKMDYGu1nEODiEXpkxYikXJ8JSJ8V5xltqRyPlZVBIBZ9k7NRGyDVG/O7emlqKu08hFoS3gmaE19cv+8FWskpW04ncgKApMnf/vuhb6NYH3VyVwFj9ONi2VF6eOLOSUVEiufG89vZSZkerTpDHkTGVzArD4K1VikXmyXySXPI3xdkx6SUygn49dX4rX5prCL08fllAYCTIpu4Abtc9tEoZdbXvfpGIqEG5ALegLicCaOUBT47QIjPfFB2iMCjIjOajA5dNQztNKpd7cKgemhOmonpY1fSLn18vAuOSJJLjj4UcQFAU1VH/AZauPrKn2SLhn668nIcE1rv1xqfzKHxNAwGxnK0/+aPbryEqwV9P8l1oVbSjcz99CgnPYJ0PyPtq7enKH7874xmdQ4LA+CZKgNCauFFwyWBgtJDpEToSK4eCXyVa8ksaY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(356005)(6666004)(86362001)(41300700001)(81166007)(82740400003)(966005)(36756003)(15650500001)(478600001)(40480700001)(1076003)(2616005)(921008)(5660300002)(26005)(54906003)(426003)(336012)(6636002)(316002)(110136005)(70586007)(36860700001)(70206006)(2906002)(83380400001)(4326008)(8936002)(44832011)(40460700003)(47076005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:27:16.5877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a978a243-4e5b-4a6e-177e-08dbf0ce2452
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update firmware and SoC drivers to support for Versal NET platform.
Versal Net is a new AMD/Xilinx SoC.

V1: https://lore.kernel.org/linux-arm-kernel/20230929105558.11893-1-jay.buddhabhatti@amd.com/
V2: https://lore.kernel.org/linux-arm-kernel/20231004094116.27128-1-jay.buddhabhatti@amd.com/
V3: https://lore.kernel.org/linux-arm-kernel/20231016111301.13369-1-jay.buddhabhatti@amd.com/
V4: https://lore.kernel.org/linux-arm-kernel/20231109070021.16291-1-jay.buddhabhatti@amd.com/

Changes in v5:
- Fixed warning: passing an object that undergoes default argument promotion to
  'va_start' has undefined behavior [-Wvarargs]

Changes in V4:
- Used variable arguments in patch #1 for adding support for additional
  arguments

Changes in V3:
- Addressed formatting related comments
- Removed below patch to update maintainer of event management driver from v2 patch series
  https://lore.kernel.org/linux-arm-kernel/20231004094116.27128-7-jay.buddhabhatti@amd.com/

Changes in V2:
- Removed below patch from V1 patch series
  https://lore.kernel.org/linux-arm-kernel/20230929105558.11893-4-jay.buddhabhatti@amd.com/
- Corrected maintainer name format in patch #6 as per tool requirement

Jay Buddhabhatti (5):
  firmware: xilinx: Update firmware call interface to support additional
    args
  firmware: xilinx: Expand feature check to support all PLM modules
  firmware: xilinx: Register event manager driver
  drivers: soc: xilinx: Fix error message on SGI registration failure
  firmware: zynqmp: Add support to handle IPI CRC failure

 drivers/firmware/xilinx/zynqmp.c        | 329 ++++++++++++------------
 drivers/soc/xilinx/xlnx_event_manager.c |   8 +-
 drivers/soc/xilinx/zynqmp_power.c       |   2 +-
 include/linux/firmware/xlnx-zynqmp.h    |  16 +-
 4 files changed, 179 insertions(+), 176 deletions(-)

-- 
2.17.1


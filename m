Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8147E6A5A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjKIMHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjKIMHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:07:16 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654AF2107;
        Thu,  9 Nov 2023 04:07:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUBWLh+uZ6thwxc0y6kEK+CJZjiegSDSd9VGaqcQfhSHlI40Nsg4GDs3Zv3seoeOd9FxH+tr38p8gR8NdHg0Fm5DoWZKMoAlYpHRi4TeAWvLZJGGpUSApacnXqfuU3SEygNBMQuDcbYdyzO+Iws3a5v/SMD6gdgAZ4O2FMxqoinCnFUP9jdxbZBpT8HyM7ui5bfnbdMjpB867tT0lVk6ulBPUi27BE/fFTZB6nilROgb0AlcLqihVpvUCeIhFIa7iXDroLxKC5U0FflAMDghSqYoEFFc304nfekIspxx6pjfIGOgqn9wVWnqmb5o5MGy4MqsNOXar+hPiHmNnPzetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYPC5aA5vCT0RpUFzi3Ffqik11yqzDWUr5NuVUz8Hmg=;
 b=bXWv5OtdJcnBY6uq8sd/CbWhB58rSKFs5RJlpO3BcKRuHmMNAVQ6hFcwc0Qdry2+/iO9t0oVtvXQM3JEp5Ali7zarooPSEKK7N9qdcU/OStvn88QiwB8Vh71Hm/kt9CsSih+snbXl+gBtReMHZuB3Nalr2kKxNBl0WEbNPuomvjMIiatHyrl4fucfLz5KlcriGUL+jmt/mXqjxR4PfnEDwrETOJ1o5aweCyzcoNN6SMSJD4fHfI1On+6GHdngE+PWOgm6ODzYSoJKZSGcyP/8Fa9nC5PhHgbG0DeOWyPs+G8QbVza5SCpnJcxZVrci+0mhjbIe8mIEEMebvNh7z1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYPC5aA5vCT0RpUFzi3Ffqik11yqzDWUr5NuVUz8Hmg=;
 b=ll+aRmDgQv8SJJa9FBMPiR+kQOSWp8fzCtiTfOJLmv+UEkai9TFFFD2xs47GOKj3YqWSMn+sBy5ESMhueuMczhzhPiveeSiqrgYIsS7KXhXKOwu5+DhM9VeXnC8mGZAMXnHPAUy2ho+27mrfMj8ulTpa/7W3GxNvk0VHYFF/gEQ=
Received: from DS7PR03CA0201.namprd03.prod.outlook.com (2603:10b6:5:3b6::26)
 by PH8PR12MB6722.namprd12.prod.outlook.com (2603:10b6:510:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 12:07:11 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::fa) by DS7PR03CA0201.outlook.office365.com
 (2603:10b6:5:3b6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 12:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 12:07:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 06:07:07 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 06:07:07 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 9 Nov 2023 06:07:06 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@amd.com>, <olof@lixom.net>,
        <shubhrajyoti.datta@xilinx.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH RESEND v2 0/2] update for versal net platform
Date:   Thu, 9 Nov 2023 04:05:54 -0800
Message-ID: <20231109120556.29348-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|PH8PR12MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: 56704525-18cd-4dc8-6ad0-08dbe11c671c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+pJ3NedeTRDQUzBA2/rYPb9rKbm26ytI/wBgV5dV8JECbWfvVs+WeKE/bsxFXGUaW9bWPbvuu/KlwmXOMR9y0mHO5jw94CHehKatlXSNuzCMF5C2vAuoJ7x0UDhn94W2Z+lK97/Fmkjzh90Nvm2MVmMeDjySWje1YBxol76W3oKraw9Xfj4J8mbWhJyKkLL8sYj79avCOuDwFD3oScMzvOivL+WY7EjgOVBQnNljXF1acraohQUL9yDwsfhV26XaNOxgcbqEiCN1RNqdLcnVhZzCX4BgBvxfXw3uScXhhSgkckO1vkPXTyNIsZjVoL+Kaxd/RV2YjCYyrt0I4oqZ+Oq6wmdpkXpHr9Ehfw80pNEZloQvgPy8wzO8NhF8reLTelPSGUgkosu5LfiVKYqgc8P6t37k6vj+r+c6PinJ5FPM2B4EN3X2CsrpUQfjdj+hnIzOYHgPDXMviz7yx8CdD62sKJfPrWXwPYdyK6eCGIjA8/ZMsIa5ghTKryt6JDk21s5AW1R0QxirtielBIU/wI9YMn2et1odyk/umYF/krR6ruGxNQTD0kMosngCzsUHulY/njm4nWciuynRJdkrklR+BjUfEI4zDz6hZC7YckdNo3kT0BN5RZfVg4gRlvXO9nvkfJbh/QxOW/GNULUsuc2+pWFEhbwlMq8qpmvH7kGt0mr7GeeOeFbxbVbWMDtG7IBAhSwOhkvPs26vxkvxIaAXr9By/MVp9dbGJPMGFP9WS2MrkVaypnddfMAFOJVn9kQ1Dpg12N3r4zhPo1OCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(2906002)(15650500001)(356005)(4744005)(40480700001)(4326008)(8676002)(41300700001)(81166007)(83380400001)(36860700001)(86362001)(47076005)(82740400003)(336012)(40460700003)(70586007)(426003)(70206006)(316002)(44832011)(1076003)(8936002)(5660300002)(2616005)(110136005)(54906003)(6666004)(478600001)(966005)(26005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 12:07:10.7525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56704525-18cd-4dc8-6ad0-08dbe11c671c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6722
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update clock driver to support for Versal NET platforms.
Versal Net is a new AMD/Xilinx  SoC.

V1 link: https://lore.kernel.org/lkml/20231016113002.15929-1-jay.buddhabhatti@amd.com/
V1->V2:
 - Updated logic to use fls() to get max width of divider
 - Added fixes tag in patch #1

Jay Buddhabhatti (2):
  drivers: clk: zynqmp: calculate closest mux rate
  drivers: clk: zynqmp: update divider round rate logic

 drivers/clk/zynqmp/clk-mux-zynqmp.c |  2 +-
 drivers/clk/zynqmp/divider.c        | 66 +++--------------------------
 2 files changed, 6 insertions(+), 62 deletions(-)

-- 
2.17.1


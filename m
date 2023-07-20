Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226F175AECE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGTMyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGTMyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:54:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B62313E;
        Thu, 20 Jul 2023 05:54:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lt74DN0yGl5R5AeuQ9dq6Ir/oTOY+HI1oSCv+nBOZRUVps7W7DRe9yCl+CRryl6YtEsV/WnzhouoK3ZU/kDaN4oeJhFLE+Y+XuBQdrjs8bH6BujZwL5TBfPRhm8XzXFKKXjP6Jzn1wW9OX0ofxCvGfejwEiCAzXWroAa+ahueQiCACMRpwowVtlS8GFyVyoZFOkA61jUeyI5C2iyfqFO9MDajTtg/2ITItjCITq4qaaQv5jAU8E5HY1zVwiE+rFhbYqAOx11NDJ0R0GChggSGBIu3mo6Mq5c6SZWY3YFokC8jS+mbj2sS9gjl9q1gC+RCywOB9ouN0u+h6mn3EU7cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuhxecYpTZOjLHLR+ghoSHnBw84FK0gpK4VYQOzTl9s=;
 b=ewOUtdaERpt/2k6N3Kxjq2JNmreYPUdx7Mnnw5YonT0Oam6IReyEuTzvbpk6YhxAgiawp2Z3LNI8oiilrqfcrXSVFgAzEfaD8pBbIHNw26a4wSJk0GebkaBwKkjkUKyJjyRfFWcv6KxcWy6+y5IfMcvn6ei3khbMmaFnpHOLJkmZiPIA2IWTtz52/sCnaAiMKQxjx/nkAq9XThtjSAaK5wMRVrhN5Z7zgIQamJA7APlLxxrn5JldmUD13AtQHUVmAAf0vSXSMPzys1pzPd5/mP07dhDgkZcTnIWdUBAzUWb9DkJAbEPuI38KkSGPKmJDhqCW62bFNJG2eN3TlvDXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuhxecYpTZOjLHLR+ghoSHnBw84FK0gpK4VYQOzTl9s=;
 b=y0K/hv1CBT2rtzBI55Qo7EcsiPAVkNsXTvHKhrxJMRV1UgPrUkK2ul/hIQtryiV+ae4+oE+XDidUS3BhVkhEzobihUV9qJbVbBmKkHI2u7YG6Bwk9GbfdLfcqrmayoH3qlv4mRPdlbbZdJJKyLBzaurrZAJAtKSfxy9l/lX8hos=
Received: from BN0PR04CA0144.namprd04.prod.outlook.com (2603:10b6:408:ed::29)
 by MW6PR12MB9019.namprd12.prod.outlook.com (2603:10b6:303:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Thu, 20 Jul
 2023 12:54:42 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::23) by BN0PR04CA0144.outlook.office365.com
 (2603:10b6:408:ed::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Thu, 20 Jul 2023 12:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Thu, 20 Jul 2023 12:54:42 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 07:54:39 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <nchatrad@amd.com>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH 0/7] AMD Family 19h Models 90h-9fh EDAC Support
Date:   Thu, 20 Jul 2023 12:54:18 +0000
Message-ID: <20230720125425.3735538-1-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|MW6PR12MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d85a8c4-ac35-42c7-119a-08db89207c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k2PVq2782o20B894OOxmQpitpT0thjB2zbyXuFVgTunij129rHAcZjsBobU2HfB6P1pJrksvs9R31X8VvDCHWdhXV/b45Wz6IJkEmyRKnn8Tp8pHPeflDesnMava7HUnAeFzu0nHakCKJGL7MtoEJjfps/2Ve9m6z5TZF+UrA0FBO9giypjsBmcTyIRwexgY5rkCyNEUX2BGUIzpbbYbfUm52aMeAtII0OCkQFuVYFZMfERs4+ZoUmTrkU8WlBEIKOHC3V+s+jaivY84S27M3buicsL49OU+FOQ+C122KdB6lrSsSUVjSbNrcmmAIKXbhjGuiHdVhh3C5ngBaLNbzP+ybSbEKiSfKnyPISSfM7SARyXD5bblHCzHm7+JCKrkIYL9hu5BHx7weTES437/sK4ysUgG1RgddksBY4sePHKLdecrt+3kW7MlYBg51VL75yKc620gmyfbaP2pbkwIT1xfL/GkQCj5nqf9ZeeZ1Md5f4HY2i7RcRUJZneewJulHjz1R9wqezJM8YBdoIvsrXwKzL7adPi/FC1FJeiosVce/6QF2YfZS/X4vzOFxD+08X49j2eQNiC3Zz2VcL4QwdvvYiZgHr2iTV3GlAoSaY6mCO4f9ftaaYbuvgaz6L+DCMER0ZNFwAii5bgixWxtl44pPdmj27VAn6DsS879VSkSK6J7JDhTdaBPyCr4SLcodFWHz5AKa+x5fMjp1MsPBqDZsMeSFp4lvDmT6aukl5IPlBt69/oO15EW/IaNWbmsU1Qe43yU8JOOOToa15kE+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(7696005)(6666004)(40460700003)(356005)(186003)(336012)(47076005)(16526019)(36756003)(40480700001)(426003)(2616005)(1076003)(83380400001)(82740400003)(36860700001)(26005)(81166007)(110136005)(54906003)(5660300002)(70586007)(70206006)(316002)(4326008)(8676002)(478600001)(8936002)(2906002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 12:54:42.4167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d85a8c4-ac35-42c7-119a-08db89207c8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9019
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Support for AMD Family 19h Models 90h-9fh.

Patch 1:
Add MI300 PCI IDs to the AMD NB code.

Patch 2:
Remove SMCA Extended Error code descriptions, because some of the
existing bit definitions in the CTL register of SMCA bank type
are reassigned without defining new HWID and McaType.

Patch 3:
Add New SMCA bank types MALL, USR_DP, USR_CP.

Patch 4:
Add HBM3 memory in the enum.

Patch 5:
Add Family 19h and Models 90h-9fh Enumeration support.

Patch 6:
Decode error instance get_inst_id() to pvt->ops

Patch 7:
Convert ondie ECC DRAM decoded address to Normalized address

Muralidhara M K (7):
  x86/amd_nb: Add AMD Family 19h Models(80h-80fh) and (90h-9fh) PCI IDs
  EDAC/mce_amd: Remove SMCA Extended Error code descriptions
  x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP bank types
  EDAC/mc: Add new HBM3 memory type
  EDAC/amd64: Add MI300 Enumeration support
  EDAC/amd64: Add error instance get_err_info() to pvt->ops
  EDAC/amd64: Add Error address conversion for UMC

 arch/x86/include/asm/mce.h    |   3 +
 arch/x86/kernel/amd_nb.c      |   5 +
 arch/x86/kernel/cpu/mce/amd.c |   6 +
 drivers/edac/amd64_edac.c     | 261 +++++++++++++++++-
 drivers/edac/amd64_edac.h     |   2 +
 drivers/edac/edac_mc.c        |   1 +
 drivers/edac/mce_amd.c        | 480 ----------------------------------
 include/linux/edac.h          |   3 +
 include/linux/pci_ids.h       |   1 +
 9 files changed, 269 insertions(+), 493 deletions(-)

-- 
2.25.1


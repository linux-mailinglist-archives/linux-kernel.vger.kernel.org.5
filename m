Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86263755F61
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjGQJeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGQJe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:34:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC81198E;
        Mon, 17 Jul 2023 02:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZZEZODVHc6Sv68/Iaj4+dz7U4PqEtmeurRLnE3ff2UZhhZVmENaXZXizSLIaVlX41Smj4oKIxGXRDW6PZyehYFzoj5dTx1GGWQELc+8qoQbag0d10VrU2nVQeKy5ew4xlm4ecJM2aQSAyFOCHTUGV7yqvaUYbrQKss8gQECh0bOnjN92nX8EIRTBmSHx4ImWYJbbvsIPIo6vVAwEPIbtRU5S89uOH1LD6f3GJEIBCWCsZciuL3j7ahe37BjPLW0GtgAmUk71NsqgL8ZXHORg/xWjwDYU9/Z7RiM0TD++AHmUegWrYcUYI/ywTNePBPj3CpHPpS5+10ctwYzzRpzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1H+uCq1Ok0GnIROa6ixv0eDfPYskD0ojuSztD5PKkU=;
 b=JGXq/gVGMV8jX5waZSreRCk1hKUa0SWI5uMC4TEGnR3BZKGIqisbi2GCAMzDEzM8iG9hBqbpODkWml2wkDpIt3IbYlZL2mZ4Xf25G5yb+sdQ8uZv52BtzXxPpV/azOFarEWVkyVtQ4oCAxiqPF7acvXix9Y0bjGk+/jL3q0pWHA27lKBLdLYYXI8yOy4lIvZRyruhm2VJBNYuRtDL+cegb3kOPj9WpNQleiRo7CEU+eGYO+INRczPxQ8FTyULR2aAySiT/Ti5xFJPRo95AH4CIpbAXKpo7NdQrFhoKWHsGdQbiXHfIsqDh3xraEVIyaNCVkKcv9cCGOEAyiSqeh+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1H+uCq1Ok0GnIROa6ixv0eDfPYskD0ojuSztD5PKkU=;
 b=JRoZP/CM6BAptgzF4+uGp/WMY/k1wsC/t5eL9VR6KRxw2v3O/0WnqTNyNm+xuyN+2rce4tkyEJ69lNimEzdzw3YTPs6H/QGbIZpCUWXCffSB/6xFxJVOUgJ74lV+u0Vg0Fxr8fAhAZGMmPEDNoNyf/LAm+0InlOoxjBKSi7CDY4=
Received: from DM6PR12CA0012.namprd12.prod.outlook.com (2603:10b6:5:1c0::25)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 09:34:04 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::92) by DM6PR12CA0012.outlook.office365.com
 (2603:10b6:5:1c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 09:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.44 via Frontend Transport; Mon, 17 Jul 2023 09:34:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 04:34:00 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 17 Jul 2023 04:33:48 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>,
        Marek Vasut <marex@denx.de>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <saikrishna12468@gmail.com>,
        <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH 0/4] ipinctrl: pinctrl-zynqmp: Add tri-state configuration support
Date:   Mon, 17 Jul 2023 15:03:43 +0530
Message-ID: <20230717093347.3869167-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: ed65288f-de9b-4a1a-f765-08db86a8f5b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWFnT78F1Rr/zwveoBCu2+fWvrp1FT7Rt8WpPreGCv3FXNXyIAAoHkD5VKG3AMVdGHveeA4A4jR8LRCrqm62k635WKa+NLlD01vudNEV4ygqhTB0xWUnXBqV28U3z2lGXts5ValT50uSZn05NQcsOw/lYfzW2qNP0SsL87Kcr2AmIFuSWSBSZs46/A+poygzICavhTgcEBqaTg9awx1G1oR3iIvgxoAo/Tp6ULIem5PLzDBdi/KfaW54trzf+yKtyNxX4zvA/+uNyohZtG5r2Xxc02Htnrs0Ww7znaLUKNqDwaZaYBVhSxlpa9ahHKRuVYuNdFb7+m8LqdlZznybPamUHJZZl/lzfIxDFq+TMMrRNxX3JqlWNggRAff4KiF+98Y/scJfDB3ntjC8QtjEcoOVl/TR1YKbBH7Wk0i9+FlFSREKdFAHniyjpxAxbZdDRKJvSQTyiibsHDx3rGsFdK8AoCFu1vHoATKsy9I6desjoJWGp1eeMNXRumNgoheqbeLR88SagVlCD5WdWm9Q6jpk1E0O9MqfrJTO1uGuHj80PUOSu8hmfdOe1TcXduCDNjTejoBh4/uBGv3fG8rtScgBPCI7kTP5TXZVTxVNHz0XodBAl+OHbZsKVQjVN3DJVbbD+EO4vVWTooo/BeDFpxde/KJ6qSklxOfpqoO6Sd88DRoxuZ32XFjXJPjSMVM6g+KPYXVEzEzf+EQzELOT9WSoGqCDYEVQuNOdGEDyHrEHkcHNWHUs+PZ3xS1MePDfkjtgPeIUaQtQRL4Led3QbeZfV5t90rq19kPa8ETYHS8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(86362001)(2906002)(103116003)(36756003)(7416002)(40460700003)(40480700001)(186003)(336012)(36860700001)(426003)(47076005)(1076003)(26005)(82740400003)(921005)(356005)(81166007)(70206006)(6666004)(54906003)(110136005)(70586007)(316002)(2616005)(4326008)(478600001)(41300700001)(5660300002)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 09:34:03.6919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed65288f-de9b-4a1a-f765-08db86a8f5b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171
X-Spam-Status: No, score=1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl driver support to handle 'output-enable' and
'bias-high-impedance' configurations with proper Configuration Set version
check. This will ensure system not to crash even if older Xilinx ZynqMP
Platform Management Firmware is used.
Initial Commit details:
Commit 133ad0d9af99bdca9070 ("dt-bindings: pinctrl-zynqmp: Add
output-enable configuration").
Commit ad2bea79ef0144043721 ("pinctrl: pinctrl-zynqmp: Add support
for output-enable and bias-high-impedance").

With the above patches, using these pinctrl properties in the device-tree
cause system hang issues with older Xilinx ZynqMP Platform Management
Firmware, hence reverted the patches.
Reverted Commit details:
Commit ff8356060e3a5e126abb ("Revert "dt-bindings: pinctrl-zynqmp: Add
output-enable configuration"").
Commit 9989bc33c4894e075167 ("Revert "pinctrl: pinctrl-zynqmp: Add support
for output-enable and bias-high-impedance"").
With the latest firmware and driver changes, driver will ask firmware if
that feature is supported or not by checking the version. This way it
works with all Xilinx firmwares.

Dhaval Shah (1):
  firmware: xilinx: Add support to get platform information

Sai Krishna Potthuri (3):
  firmware: xilinx: Add version check for TRISTATE configuration
  dt-bindings: pinctrl-zynqmp: Add output-enable configuration
  pinctrl: pinctrl-zynqmp: Add support for output-enable and bias-high
    impedance

 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml |  4 ++
 drivers/firmware/xilinx/zynqmp.c              | 51 +++++++++++++++++++
 drivers/pinctrl/pinctrl-zynqmp.c              |  9 ++++
 include/linux/firmware/xlnx-zynqmp.h          | 15 ++++++
 4 files changed, 79 insertions(+)

-- 
2.25.1


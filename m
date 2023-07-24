Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE8275EE2B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjGXIqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjGXIqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:46:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C59CA;
        Mon, 24 Jul 2023 01:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLyV9fIBaZroZUNtiuDsWeqLCbPW5QHmA8hb/8g0zwbC7L/+VCLkou3GQ1H29KkmgXVw1IhMbPX7v7xn8uYAvENRJ4rkrluPFaAOP5Z9ALPmz3LWitnloBfk6q8bWSYA9TyvZa3VVpdI1DHHiWq6rebuDrryZQ9uEyYgYdqUx/bNg5DokxBzmXHXP34ebJgXttr+5uI5Pb28p3fiJm9BrLMNxCwNqOyqpXKwoUyrGHFOOJth2Y6Kry2HGae7yffh7uc1G8X/562zMJe/G5IBGzSEPNq1UhtnGhqlBUdaiDDH2yW5U8Rkhp/VGj1mNZ72Fj1Chl25bCaU56JWG0xGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygPwbMLorCrENHCPSM80waOr1TaAAgdgK1lvAaxuwiU=;
 b=MiBBoVoL7E4f0LUWPCei1cDxcrX4mkJcbr++0bWa3uvqiAWYAZNrrNGWK10V3aJRYJkkighgpWG3yYWZ9COUtFcLztVcXQKzyPECWYbp8W1sZKz6VcF9yi0ZeS/dV+wnALPZE1h0K81pACb8ex8mzbE/9KBLp3QhZnZpdbVoN+lLRaf6uiOlLc5WRQcj68mpegszWtAf2ulFUbhCVfmNF3FPndmk6EP/WAxr2UyFKOVLJcWtp0T3JNZ1uSFpEKcZbDV3dMkWhzMpd35VYeA60WI00MPuwilcmQD2bsHyliXGKzel+htDeOb1+67BFwbhp8LPHzREcqiaMf4/W9p0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygPwbMLorCrENHCPSM80waOr1TaAAgdgK1lvAaxuwiU=;
 b=czWbRJhjcQdaolOaL8NEGk+8EeqOYnkQelfpmpcRawGw3Vh0t+b0IOr31PE72pX+SYbdGhRDJjilJtE0a7nwgqghjFCMp2ldjMfuWdL8j49/Wy+4I6gStSAdzhtCHTOcBg8urFneHrw4kLScJBPqgiR9Pnffp9GZd72pMeXlFnU=
Received: from BN9PR03CA0793.namprd03.prod.outlook.com (2603:10b6:408:13f::18)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 08:46:13 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::23) by BN9PR03CA0793.outlook.office365.com
 (2603:10b6:408:13f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Mon, 24 Jul 2023 08:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.24 via Frontend Transport; Mon, 24 Jul 2023 08:46:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 03:45:59 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 24 Jul 2023 03:45:55 -0500
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
Subject: [PATCH v2 0/4] pinctrl: pinctrl-zynqmp: Add tri-state configuration support
Date:   Mon, 24 Jul 2023 14:15:50 +0530
Message-ID: <20230724084554.1924378-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a256e13-3c79-4606-9760-08db8c226f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKkCI09SDriXTuUdpPmBDoQgy1AS0LmUL7mrvij84F6SMJbW8F5SWK0XEadYhBjAEGrjJcqK0jZQmBojxQ/PFQuzmH4Unpoi96rbGMP3Vmj0S1/dxqOh11KBlNSak41iZt8T5Qvee5USR7venj1551pd7TP9a5vg55m7RG8lVK5rua2JKEuKWmnanZxDFPECfFhcLFJq1pfem+VQeQhmh+HV8dx9ra4b2gP/gkgOZtG7t+phjsTKFmEvbPEriB9Nqc5S4Tm/W/Oy2H2v3Sq4ZHCTQaL90rHLb/WJIkcIGgRrCcZHCFotIecQexRNqQafiA6DBX+8LmKTn6gsUqptnIkLTXOKEd7tM2pfpCdE3bNSKmXooU5LdkLL0Zdg79zpe+XzXRX0+Rb6vBnejv2EqVJ7EvWsAQ6gxNz1PInxV+ZU0PX0NrhDYURnPI1kT2QRRirGY4L0MCQWa/82u4hTkG2ZOrWyNUH9kmEbHTjuhr3FDdJI19R2mWGOwn+gJ2GrT2tPBpokOuxSQdrKlwXPehTynDUCvYrGVSJ55dtBs/R2vggLARMh55W74V27DtZ7yoBiLwordmjKE7Iw/P0c65MYBe6UocMT0IMXEwTIASmcyjPnsyRUB5I7ZI7eqU+jUYcnmnqjX1lxhXR/2s2DghOao55y3pVwZNfiKE2fIpoEgkcRy8YxV9RS+f2Oaz6JyY9gOtv/eKnEK5LmzaG4imiyxW9fP5g5tC6WaHcxd8cXWsxjCtyrKY7KkjKfs4p2DjtiW9ufe/bVpxtv7kb0VHdSpGxlgf+zWbEN4uPwOA0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(86362001)(82740400003)(316002)(4326008)(478600001)(54906003)(41300700001)(103116003)(70586007)(70206006)(110136005)(5660300002)(7416002)(8676002)(8936002)(6666004)(2906002)(26005)(1076003)(186003)(336012)(40480700001)(81166007)(356005)(921005)(40460700003)(83380400001)(36756003)(36860700001)(47076005)(426003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 08:46:12.8646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a256e13-3c79-4606-9760-08db8c226f68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
X-Spam-Status: No, score=1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

changes in v2:
- Updated commit description in 3/4 patch as suggested by Conor Dooley.

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


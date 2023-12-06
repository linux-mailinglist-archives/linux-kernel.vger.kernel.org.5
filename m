Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C9880683E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377026AbjLFHaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjLFHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:30:21 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78DB122;
        Tue,  5 Dec 2023 23:30:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBXDCjLmlZH34FJlpHavtbpJAzxPhuBXfJyk0eaAOCS9eIiDno/Wm+1aVeY9BMFXlDJlPAJ4nV2JZKtcQr1IYSu8CQAXmyxaKi85NJfwuFVSiycStaN4fWn0pZtruBmfnnmJ6JjZOZfPm8uH6mlA7T9MOzhRhTLrBma5mLWunvZK20zX+Kv3Qw3EgvyCsErjBx+U4ipcD7G4WAJtiyLRWbm/gmFM8CjRpsU3NDnv+LiP+ALDtKxG3RQ2QlKLEGxgJrWN334WkNLWvFn9QE1HYuE+8zeUmkKBBnyFaqh8DKkMkC25mxU4RSrIy2jCH3xykNvaqBasu6qFR7BCEFaxJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LBQSltf/OuAZAA9ULfOf6/A0ofBoKAwEgYhsLQhqIE=;
 b=f0+8QAcKlSfp3SZj76yHy4h0SL4jrhNwD60vWNPE3/RKrXC4uFIFstvh7z50RIzwN/QUrwPwXKNMdSKxpftbsfNDigtwAYznj90ouX1q193z5igtcbT6hDE3DMxAJCGLodRr9hGbNIyT+8+5/NRbw9suEcIbTb6dsKg4DWLoOSEyPBPS4ywu8i1i9AIPFjKRYrb7J0MgcIAUN/OxW7uOhlK8/Y9GiiCHzPX+PuL/l36aSYm6Yb5IWEd60DVPlmW9XD53habJ2TAWCWoNLYHBb0oWEkSMPm+bGfEBc4Dd6/ojqAgbe5UNQzlQ9UbOnzzGMg1GRAj1Au6seu3n08dGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LBQSltf/OuAZAA9ULfOf6/A0ofBoKAwEgYhsLQhqIE=;
 b=fUE3/BWd3/me426geUIGYHgl1ojXyg9FHG3ka8DGk0sR0vKH1dm5pDC3ohANuZB8GUc/OSaRpLPaBi0C2+fz/X8pgCHyngV2BxUfkXGnb7BPu2At0tkCtA3L8ALazXdUcwRR/uzQ4/D9VmZBl8ugSi3gcQCYFn+7/BHVXqxv1jI=
Received: from MW4PR03CA0217.namprd03.prod.outlook.com (2603:10b6:303:b9::12)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 07:30:21 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:b9:cafe::fe) by MW4PR03CA0217.outlook.office365.com
 (2603:10b6:303:b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 07:30:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.2 via Frontend Transport; Wed, 6 Dec 2023 07:30:20 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 01:30:15 -0600
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <hdegoede@redhat.com>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexander.deucher@amd.com>,
        <Lijo.Lazar@amd.com>, <mario.limonciello@amd.com>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v15 0/9] Enable Wifi RFI interference mitigation feature support
Date:   Wed, 6 Dec 2023 15:29:38 +0800
Message-ID: <20231206072947.1331729-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|BN9PR12MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: e75513e2-bf47-42ec-485a-08dbf62d3404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I7JyOu4YB/qWG/04CJl19LwJQFd+A9ThrANVEr7GuZOL77jVxANYz/Ebfg34zKvDd/NUoaz3C4ZFcNjlxlqS4wAXn+AEWMkR9Qbq53blOsSygDFLyzT2E2vmRgXSExloE4N4AA1yJrwogiOG2q90pumIg9j9Ce0kRmSg/cn3tzSIa3Jeckc0bioIeMU3EXbLFzBAroW+jMDKmvKnGYyb4MkxlAaxX80gV2W6D2LTQp/Ne2UHSGhZCcny8UdoZvw0pFktG5AZK4+o70MIFHyLnCkOVGGqqarBzXSYvHnrzbNOQKo6vGWdzbH+B9lYN8i5LaPHhk6ZF2oTf1cGx8lpxj0Tah8O8ZlKX2jpbgxwVRYX9vT4xw/JY8mU3FEcglzu/umlr82oHuGiAC0a7ijmeedPkoRQJc93Ce8+efLjUBsvNm31QiHnd2951+jUNwf+B+HNX9w/QdAG7pGRH0h6OERkVaHG3/x/gj8TMHeDaeZYtGGsvjVvjAIRO5/pcyViNqgfZStvDi02ASf8l3T2WPLgJ62uKixUDIRs+7Y+kzjeqd2UA0KktSV25Biwq2BKrQy9laip6vrKG4DRvoZOPDBxLpMyUUI5bT6cyeFcaSRmRvotlH/c1una/SKz24WxqqXUvoPN47YUUgzy+j++WOy0q3BNqhjJ++k5QjvjYQlD57En2bIcrPt1eOtiGDhokoC5TGNJTOgpttQBkD1yvp4tU0CybAY7oBSQI0tdx6mUjDqmeRLtMckG0D93A9QuwDO+V0inksvZNSAPbB7oEUYl9OmTUGcS2fSz7JG0Fgc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(82740400003)(356005)(81166007)(478600001)(5660300002)(2906002)(40480700001)(36860700001)(7416002)(47076005)(83380400001)(86362001)(426003)(2616005)(40460700003)(26005)(1076003)(41300700001)(36756003)(54906003)(70206006)(921008)(110136005)(316002)(70586007)(7696005)(8936002)(6666004)(8676002)(4326008)(16526019)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 07:30:20.7995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e75513e2-bf47-42ec-485a-08dbf62d3404
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to electrical and mechanical constraints in certain platform designs there
may be likely interference of relatively high-powered harmonics of the (G-)DDR
memory clocks with local radio module frequency bands used by Wifi 6/6e/7. To
mitigate possible RFI interference we introuduced WBRF(Wifi Band RFI mitigation Feature).
Producers can advertise the frequencies in use and consumers can use this information
to avoid using these frequencies for sensitive features.

The whole patch set is based on Linux 6.7.0-rc4 With some brief introductions
as below:
Patch1:      Document about WBRF
Patch2:      Core functionality setup for WBRF feature support
Patch3 - 4:  Bring WBRF support to wifi subsystem.
Patch5 - 9:  Bring WBRF support to AMD graphics driver.

Evan Quan (6):
  cfg80211: expose nl80211_chan_width_to_mhz for wide sharing
  wifi: mac80211: Add support for WBRF features
  drm/amd/pm: update driver_if and ppsmc headers for coming wbrf feature
  drm/amd/pm: setup the framework to support Wifi RFI mitigation feature
  drm/amd/pm: add flood detection for wbrf events
  drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.7

Ma Jun (3):
  Documentation/driver-api: Add document about WBRF mechanism
  platform/x86/amd: Add support for AMD ACPI based Wifi band RFI
    mitigation feature
  drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.0

 Documentation/driver-api/wbrf.rst             |  78 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  17 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 208 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  42 +++
 .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     |   3 +-
 .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     |   3 +-
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h  |   5 +-
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   4 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  48 +++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  22 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  13 +
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
 drivers/platform/x86/amd/Kconfig              |  14 +
 drivers/platform/x86/amd/Makefile             |   1 +
 drivers/platform/x86/amd/wbrf.c               | 317 ++++++++++++++++++
 include/linux/acpi_amd_wbrf.h                 |  91 +++++
 include/net/cfg80211.h                        |   9 +
 net/mac80211/Makefile                         |   2 +
 net/mac80211/chan.c                           |   9 +
 net/mac80211/ieee80211_i.h                    |   7 +
 net/mac80211/main.c                           |   2 +
 net/mac80211/wbrf.c                           |  95 ++++++
 net/wireless/chan.c                           |   3 +-
 26 files changed, 996 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/driver-api/wbrf.rst
 create mode 100644 drivers/platform/x86/amd/wbrf.c
 create mode 100644 include/linux/acpi_amd_wbrf.h
 create mode 100644 net/mac80211/wbrf.c

-- 
2.34.1


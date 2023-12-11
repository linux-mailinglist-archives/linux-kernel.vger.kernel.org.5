Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1F680C5A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjLKKHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjLKKG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:06:58 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2404BD;
        Mon, 11 Dec 2023 02:07:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/y7PXmIgrvRQo5kjmoMe46iYpFkXFQ6KpY6DggVEQPgb2gDD5h45kLGD+9zKVPw+jiAx4mf86krYTgTshm+bjWGfL9ynEstaR1yCvTPsUZhEH8bI2J9GUsac9XkNouYeaYYfqrj/CNpGXFAkhXNsIUHGGGfGvkvkkdbf6o3UhR1X/nA7otCpOyV31F48LqyoH2x4dKBGXsxkaTn+YXsl5ChKA4UffxWqwjN2zTyRQ9KrMnRUH8Rle0XnNQ4V+Uwkm3kMYgQyOGR+704HmeU66nwTnQ07U6DkWMiE+CFNd/8wj22X2di/lHBOjgLZgqs3pOI/lL5Z0ru5k0qQ8ZC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR27tgm6pm7USJ0c+MyqTqUItz0figTESG5k6fIdbj8=;
 b=V8yALb98Sote/EAO9VT0H54q5T3CUvsxzfGnHGUE7c+KBbCnSYEzcQellp7qZHxVCJyYXpOqmxgKAdyCoOoAogxOMt5x6xOtQ326DsLoJ3jE/ALQClgSwRegWv1bdtD++XNHzkCs764qDxAmyPEcD8zQiTtG5vh+eSgqbGNsZoggVqPTR58VIBTfvXJrxryQG0HRk7QUvEH4M5KTbZBdTSXg1NbFkDApXEc81vLUiR5o1ZytYUWRwQZCo4OpVir2gNZcfKA0DsJF41g9RFBNyMmIYyFDyTm5VubkspUeUk7jHWaz3n5Mu1SECN85/GZo8hDMXfx9H++wSe+HjFE36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR27tgm6pm7USJ0c+MyqTqUItz0figTESG5k6fIdbj8=;
 b=3TBBaR9Y8ZcVY+R2iX45DVJgBSGhz3LquQcYLsii/oqA7sRGFyZM1ALkHN5MY1LdbLzLMcuJA2am6UCoJLG1OBV4DRXOvF8nvbeYIOqPTJ9l/k/A7xdMc/i5rDRKxGg1UGIiwSgn6554n2VQQwOI4SEJgoSN7W3acGZwycttjFQ=
Received: from MW4PR04CA0304.namprd04.prod.outlook.com (2603:10b6:303:82::9)
 by SN7PR12MB6671.namprd12.prod.outlook.com (2603:10b6:806:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 10:07:01 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:82:cafe::ed) by MW4PR04CA0304.outlook.office365.com
 (2603:10b6:303:82::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 10:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.2 via Frontend Transport; Mon, 11 Dec 2023 10:07:00 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 04:06:55 -0600
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
Subject: [PATCH v16 0/9] Enable Wifi RFI interference mitigation feature support
Date:   Mon, 11 Dec 2023 18:06:21 +0800
Message-ID: <20231211100630.2170152-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|SN7PR12MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2a1e0d-a18f-4a7a-ebd8-08dbfa30ead0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PpPigyA8KJ3enPW/tjJeVh4FYDlBancZXlejfvoocrtcXiBn/dw9T8wyixTUbgK/wn94PA2fqK9bCVFP0/kcgx8eOMLdLdX4lvlyDMFGhJE+PHWnkBL8ZJnEGj/04g8BBx0Khk1HY2IizdtCTGCa089sMZ4+s2Si9uWuyBqBF0u9jHiaDjSfuOYx5FiUPYX/U0oRN4mRcQOAoOqOJ5rfC9u3wx3Pc3N9C3nqasXIoiAx+VJuqhFdJJbdGWcWPOo6dEDqfD6WpzyH86k1ozGgHDdfxEigiMx+eaNkh1U8yXYmliGdY6AhcL/zGXJcqVpKvEZr5OzOe2UYhVJY6oemv8b3DA3Al0y2xyo2uUjcbZkCinKTBc59S0v/V/GJ/Oq4GbDPNMV2D1cE3okGW1ISNr9wWyqy5OueQtpCnBivHISXjHAz3EYdKEWG1PI3JcCi4JeH8ffYusKoLRB/gmT4oVSMTuT+0KuVupgGSvBG4CXeu6nUUM4F6XZsIagjf2HSsgq/X0F+IjNJ8WNItCAAV/458Lkfhuv4L/N0JPHxMUPzxFQ79BlnLOiipnzEgaZh7KB0Us9UP9BmheJsKs1QzuCJsG8uXd1psa9zT5l3Mq72Lwtq3+JlPHNul8EUldPzyJ38xpQW18pd483l0IUd4eehcgcWXWLY3i7oDuqcNId+xG5zLExkD6AF4eL2AA0I201eNHRk+TJy/eGlZpudIpP5J1gZmlQ0WK0cBuJYOSCV/9CP3LRs4xvGvWhxivluQ6rTkIV7Ydl9vE3puzuSI5KVVDjb7NOaVaWbTDTsiZo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(41300700001)(36860700001)(16526019)(2616005)(1076003)(426003)(336012)(26005)(83380400001)(47076005)(82740400003)(36756003)(86362001)(921008)(81166007)(356005)(5660300002)(316002)(8936002)(8676002)(4326008)(2906002)(7416002)(7696005)(6666004)(54906003)(70206006)(110136005)(70586007)(478600001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 10:07:00.6273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2a1e0d-a18f-4a7a-ebd8-08dbfa30ead0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6671
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

 Documentation/driver-api/index.rst            |   1 +
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
 27 files changed, 997 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/driver-api/wbrf.rst
 create mode 100644 drivers/platform/x86/amd/wbrf.c
 create mode 100644 include/linux/acpi_amd_wbrf.h
 create mode 100644 net/mac80211/wbrf.c

-- 
2.34.1


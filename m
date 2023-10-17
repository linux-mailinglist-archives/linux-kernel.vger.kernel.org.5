Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBF47CB893
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 04:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjJQCzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 22:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbjJQCzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 22:55:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A78B0;
        Mon, 16 Oct 2023 19:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNr9fxDUTvxNhaNXJBN0q2qNxxydbKakNUjCLOfzaFU5E8VVCrqg+GX8FZ7vUsLfGiCmMCggrp6xK1KOrTtwxO0tXdsF/MXXBldzUbHl76MxGd+ayojcqFaRXIzDaj2pPCUSMm7KnNVz0NwhBANmXebMu7ei5sfGywjjltVi7Htr8CHLwayjk++++EzIQsmbjgzp/eJAiHjAUtPto1n58GBRSNuRkmAybCzZiOPWbvFouFytfYDmerjTuBfJvYSz/BVtaHUWubew+pNrombHgBm0KnlT8v2UweXRx3rsZMQnbgweHXQBigWXbDjaxGTM3MSqfjFjm7pG2bBaf1udbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+gEJ/RF2Wvl5nPJwbgZLAAi7HZR0Ydoj7azxY6+1BY=;
 b=Ql+SJst0JCecnU8Ko6RP8hmUSdM3GAFNbL4B/KlODvpXxojWcJCNxtAlRNBzKRdcsAMbS0OERb1wQeVc27FbyrS9XA+ZWyTzxwD+KTUpxtspheSCVrxL8gUf0atE5+6vfFD9PK3eaD1rUSTPxosWB5MoDRL3BCdYv3NmICo8KZNr69KSAqeV9arM7awiWvmnPLC7qMGRKwOAPRcrDX93TDo1UQzzq0AbKZlTlRvlei+Cwgr8ww+cXLszL2/0875y29ZI3i0HqG/gFqNLldZ88qWgRNtKn2+kPQLLom9SnBvZt6+CT28g+irG7Y5zt9lDQxSTQ59HVdCyN3T+iXZz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+gEJ/RF2Wvl5nPJwbgZLAAi7HZR0Ydoj7azxY6+1BY=;
 b=ATQuUcn13Wh4k2B8UntBovBg24cTMX0BpuZMYVi60ZQ5YJnZFM82EFbcWkFnCy1lRgDEnNwXJqMWurOCSai5z75+zkoYH5d6uz/7Xhh4xiryvKRbf54GgQKTkpbFGM7aCY1Ps/39IcDbK4PXaMGKKY7KvxEjnyWUO9VQZDfRfUQ=
Received: from BY5PR17CA0038.namprd17.prod.outlook.com (2603:10b6:a03:167::15)
 by BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 02:55:02 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:167:cafe::5b) by BY5PR17CA0038.outlook.office365.com
 (2603:10b6:a03:167::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 02:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 02:55:01 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 21:54:56 -0500
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <alexander.deucher@amd.com>, <Lijo.Lazar@amd.com>,
        <mario.limonciello@amd.com>
CC:     <majun@amd.com>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v12 0/9] Enable Wifi RFI interference mitigation feature support
Date:   Tue, 17 Oct 2023 10:53:49 +0800
Message-ID: <20231017025358.1773598-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|BN9PR12MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: fdee2507-71eb-4ceb-3bdc-08dbcebc7507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jTUkXdpgZqBWXO9tLemfFTWYY1kpTyTL0I+zLsc8yiWZbA/YSMrfhgqPJpF9hJPiWfFthVYUSvRanYsyaCkvI43x4OVKRAr/lf/tvVHTGOkac8yeu0WZ1TnCmcU3WE/TQiX80/xX/JDxSp0HR7hvIdcGvyspOpVeMeXkDtX6z2tIDGPSE0X8jriyyqIZzLhZ5sg9k6gmv0bj62LrxddP7YDjnnM5DXMet9qpvhsxLN6rEOQeL2V6hzgtwiHPRGzjtotBXsCUYmGtfbZEkphRTa0i0EnKBhsUbEH6M3rlUsG+2mV8uD6Y/c3pyzlTHnv6CqF9Buwhsp39lS16TDsKIb/Z4IaHFr/bLifRTdUFZbIfdoXf4NV+WLEChIlnsfe9O04CBpwVXh+RH+VlvJvxFKsj1SL0bdb2Qb+HAtRh1NC9GK5WzlkFF9PSbQONEtq893Oh0loMTEt0H6PeDdvBRdSxLvPiYKwzW7Sf0ozifKE34465lTD26RCkpCe71G5hvd/2fV+PeMkA8+/EnqubchIhLYEAGr2IDvzJ5otekwJ/rfGGFJ5RMivftY6okFJJAUKuB3yg4QD5/FXV6GuclwwLPt2uYGtc4KwFYWckv6Cbq+dQLFJKdPVsuUAzxAnMLV1TOTJKT0oKqJjaJ8AYX4kc9mtLR0aA2vEEgF+77yEd2Et7cjhMwNKfgT1VXCF121B7YQlEa3gF+oU8+rpHZPeEH4nXDXWEdx62zXP5zTD6rvUxxyT5ymT/4XweSzFHdqMZHCMwMcn7UlYgUqcDPOcogkbLtsFEKunzepsfVko=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(356005)(921005)(47076005)(16526019)(82740400003)(426003)(336012)(26005)(41300700001)(83380400001)(36756003)(2616005)(86362001)(81166007)(1076003)(36860700001)(2906002)(7696005)(6666004)(40480700001)(7416002)(5660300002)(6636002)(54906003)(70206006)(70586007)(110136005)(316002)(8936002)(40460700003)(478600001)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 02:55:01.3920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdee2507-71eb-4ceb-3bdc-08dbcebc7507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

The whole patch set is based on Linux 6.5.0. With some brief introductions
as below:
Patch1:      Document about WBRF
Patch2:      Core functionality setup for WBRF feature support
Patch3 - 4:  Bring WBRF support to wifi subsystem.
Patch5 - 9:  Bring WBRF support to AMD graphics driver.

Evan Quan (7):
  cfg80211: expose nl80211_chan_width_to_mhz for wide sharing
  wifi: mac80211: Add support for WBRF features
  drm/amd/pm: update driver_if and ppsmc headers for coming wbrf feature
  drm/amd/pm: setup the framework to support Wifi RFI mitigation feature
  drm/amd/pm: add flood detection for wbrf events
  drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.0
  drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.7

Ma Jun (2):
  Documentation/driver-api: Add document about WBRF mechanism
  platform/x86/amd: Add support for AMD ACPI based Wifi band RFI
    mitigation feature

 Documentation/driver-api/wbrf.rst             |  71 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  17 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 214 +++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  33 ++
 .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     |  14 +-
 .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     |  14 +-
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h  |   3 +-
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   3 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   9 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  60 +++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  59 +++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
 drivers/platform/x86/amd/Kconfig              |  15 +
 drivers/platform/x86/amd/Makefile             |   1 +
 drivers/platform/x86/amd/wbrf.c               | 422 ++++++++++++++++++
 include/linux/acpi_amd_wbrf.h                 | 101 +++++
 include/linux/ieee80211.h                     |   1 +
 include/net/cfg80211.h                        |   8 +
 net/mac80211/Makefile                         |   2 +
 net/mac80211/chan.c                           |   9 +
 net/mac80211/ieee80211_i.h                    |   9 +
 net/mac80211/main.c                           |   2 +
 net/mac80211/wbrf.c                           | 105 +++++
 net/wireless/chan.c                           |   3 +-
 27 files changed, 1180 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/driver-api/wbrf.rst
 create mode 100644 drivers/platform/x86/amd/wbrf.c
 create mode 100644 include/linux/acpi_amd_wbrf.h
 create mode 100644 net/mac80211/wbrf.c

-- 
2.34.1


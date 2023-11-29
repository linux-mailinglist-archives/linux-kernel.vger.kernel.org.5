Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59E07FD1F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjK2JOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjK2JO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:14:28 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E99C2107;
        Wed, 29 Nov 2023 01:14:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2cfFHHeDeFiCLooG5ULV4Y5cWTQwS5qQTrWUOBOv2GsxM89hfAxRH/51uSmaGbmlGSHMxUftpTvLkWRULx0p8MQVx1FcZ3e7lCH4gQGiFPMqhW0IbzDLFRjwua1jlsnfRJJDnCqi5H5xdrSVgzZvb400/tuTyb1I7Y9p2PV1iqMmwcudD6rzES/iYaKp/F4gDE5wpRjHFYMAL5ieNQaHxZ2M5UqGOJuh8nPrhS520rv4di/QSra/Jptp918wVmrcEH322VeqdPryJR3q+GrFhcDXdecigeSFZoEreyCiAWU9zfQo3QPKA7leHJZLWRVwRQlPhZVv8erp3mZELWn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoJPycadL82MEI2NmZi8qBF6BV+yEdYWmuTJ1CoC2/M=;
 b=kodnF05OJgZ/HM1KXjFhxvr2bTBvQMF3/K6us5kY4xlJqtZTxsCeX+pABQRRnHObFup9wjLVGbxTo1N8g0T/NtEKRWWkWHaOCq3j3ND5R4qLTttq5f8dJc3KfgE8Sxg9taBqijwsBq/tJdqvasoutXhfJzws89Py2hUtZscM08EVfpBqc+tVv5N5pwUKonS4FUdUXMbB1BAJxEtSymPolOZmJzQW8mUpAOSd5sZ6uwxVnyXuiL4op34eR7saGw+g7NjDzqRuUpQxRNzxWVzfbYpKeKwPQ7wqK45RGih6Whs5Q3OOkifwwQ2nsI5wWM2BRHJifRTiTQEyzKbND2JUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoJPycadL82MEI2NmZi8qBF6BV+yEdYWmuTJ1CoC2/M=;
 b=BV5S/+sY4iqbk5DdyQkGGUID3iq2+dOdI9XHir0+OPNqy6hKsZlNj03jRqOLdxjfGh2fvd+RCqfKRNAydsU5YZBvt877dLX+LWcoEg3VjDrIZsnRaIFmsoqifAeMUmEry7Sjri4KPmVDcn8frJJyKc/TpuMwjQciEqccQ0McaLQ=
Received: from SJ0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:a03:39c::19)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 09:14:23 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::5c) by SJ0PR03CA0344.outlook.office365.com
 (2603:10b6:a03:39c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 09:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 09:14:22 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 03:14:17 -0600
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
Subject: [PATCH v14 0/9] Enable Wifi RFI interference mitigation feature support
Date:   Wed, 29 Nov 2023 17:13:39 +0800
Message-ID: <20231129091348.3972539-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: a23e42c6-29d0-4c35-7e64-08dbf0bb9366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BI02vUAwkV8Ji/5C2edrJ05MzeATiaEXAIMdcueNp+7xVqdTaxDYvW8lHCdg1ctvYXaC+CT/LmNkpENpHOZFQLvaaNai+aTR7UpahgQWRk3ZuLv+/diGPizYslWAhFVmf2Usij9q7RuQfWi33T5EHpTFrid6A7hH4fCWLNGVgcr3MREpHvkHOI/ySTU7+zyHRXhehfrTSYICsHeYBrpCGAyK8W/mfr3ZJaq1IdzBxcsBxYsULuf9B8XUNxWY8jmricbIsKqXHoMWxxa5/bNawiif6JsvcIzpvD/ytB/lfEjPSv/zigz8eBedYwyLA39xE2Twy9VHhcuHiJ79e/DQx7vjGukpRlgHtnI8fudsORkc0SsJMDIeLXUjAzqRfPiHnNHEw8nCQEfmtySwnv27s5ZPVFYD/hdbJPloQqJRn+p4uLqNVHojvOe0tZMMzF/NwEuyYbNrrduF3bH5v4DN2eh9ikTCZIn6zFADIXDZzq0hqk0J/d66cvLJ5qKSofrwDfOGw4IND3zS0spPqvAOodt/pF37FhRpBMCN34uXN0Qvk+q0oo0+nvRwlIkrM+QIcAUEgm0JkrWUfUIWPf+FWzwGsyDMRTTd7FSjMEDZgS67JVFhxP3LxcDDoFGaWOCk9qIZC8N6EGGCMA0v6vzuaUCmxPO+c5LryD9jBEyLZtE4PnGhmfg9nZykKNC6PZpyhzchoGl22xjxhXxhMUFwN1e8z9FnHup3lXc3G7dTrl7M/GvRO4Uiajv+6P8w72nDaBdkcTK58hYMnUWn42xbLQpUapv28wjr5pgvUWC8jg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(46966006)(36840700001)(86362001)(16526019)(81166007)(356005)(2906002)(921008)(41300700001)(47076005)(36860700001)(26005)(4326008)(426003)(7416002)(8936002)(2616005)(54906003)(70586007)(1076003)(7696005)(6666004)(110136005)(478600001)(70206006)(5660300002)(8676002)(83380400001)(336012)(36756003)(316002)(40460700003)(40480700001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 09:14:22.4013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a23e42c6-29d0-4c35-7e64-08dbf0bb9366
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292
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

The whole patch set is based on Linux 6.7.0-rc1. With some brief introductions
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

 Documentation/driver-api/wbrf.rst             |  78 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  17 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 208 +++++++++++
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
 drivers/platform/x86/amd/Kconfig              |  15 +
 drivers/platform/x86/amd/Makefile             |   1 +
 drivers/platform/x86/amd/wbrf.c               | 337 ++++++++++++++++++
 include/linux/acpi_amd_wbrf.h                 |  94 +++++
 include/net/cfg80211.h                        |   9 +
 net/mac80211/Makefile                         |   2 +
 net/mac80211/chan.c                           |   9 +
 net/mac80211/ieee80211_i.h                    |   7 +
 net/mac80211/main.c                           |   2 +
 net/mac80211/wbrf.c                           |  95 +++++
 net/wireless/chan.c                           |   3 +-
 26 files changed, 1020 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/driver-api/wbrf.rst
 create mode 100644 drivers/platform/x86/amd/wbrf.c
 create mode 100644 include/linux/acpi_amd_wbrf.h
 create mode 100644 net/mac80211/wbrf.c

-- 
2.34.1


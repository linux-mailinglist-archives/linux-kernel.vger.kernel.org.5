Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E04780478
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357604AbjHRD11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357580AbjHRD1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:27:17 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FE22684;
        Thu, 17 Aug 2023 20:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EecBCNjpcl86pHCOlGvMmwKEsVsWq0x9s7uNZO9bKz7R6XM9kP20Sf6zMonTcSEX+dVZbA/xcykKi53wpTGKIgppaIuzbb0IybE3w92mSLZIFKyWAChqkE9ycBn3eX8Q46YP7NA19PWlW97P3oE6hFWrFBP72wN753PjQQdpWupZOkJfhv+aCL7W8Vwltvt0hThrFLAvsFnQ7+dKjSVzeqZvJxoAc+EHgLA2ox2SMxc7sT0CxVsSgwKyLOjGUNmFvfpN7AZGbmWCU0CWh+eg0QHps2gke7vK8sgeyXGZi2xaHClobPGEDJpph+Ds1ZdQGRBOBxEA3+5LpvW0RM4u+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0B+3MWM6N9PGlcrXt+gaqTSeMr8OkzHx7VUQS16hnfE=;
 b=kb7/pSao24p4miCPeRGg+nU7uxS00TMNDxU4taFg9qMMUjaSlKNSNiHQHho+Z88W7QXX7srlXAgacJVyhAxhAKXX4XKyL52AenucjRI23FaZO6xTBUXDfIfXBPhInq7uus4gbPQvkMS66De/NXLo8z4QDaMp/PI7aZsrJHrixdsKX5yYlGVyJupNBDhv7NL2vglBGKKGMitYXcx258WUDPnZEY6WBfb0mf/FA2lOCauSgHdP4NHkdwhHmkyNnnFZxsMVunzy0Q4Nl/U1UgUCl9v7Fi/RrCxDVh7TUqAJGwHm06mLWuKswxUpYs/pdwu7hDEJ/2bawiZES29SbRsAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B+3MWM6N9PGlcrXt+gaqTSeMr8OkzHx7VUQS16hnfE=;
 b=UetmnGgWdZZ0c6RkiqH5jTOYRuFdUke2YREPxH+rJMAdx57jgrlTbdVjuXpY2PF8ru1HLr2NQBgQDKEuVhsFtMhEgPZQ/pXvjMel333lMM6UF9VXEIeg4GUzsDd5RFgmp46t7ymIdFDhcp+TIOCEFgGWzM1sRFlrtnDMBTtTg0M=
Received: from SA1P222CA0162.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::13)
 by SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 03:27:12 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::82) by SA1P222CA0162.outlook.office365.com
 (2603:10b6:806:3c3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 03:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 03:27:12 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 22:27:07 -0500
From:   Evan Quan <evan.quan@amd.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <lenb@kernel.org>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexander.deucher@amd.com>, <andrew@lunn.ch>,
        <rdunlap@infradead.org>, <quic_jjohnson@quicinc.com>,
        <horms@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        Evan Quan <evan.quan@amd.com>
Subject: [V9 0/9] Enable Wifi RFI interference mitigation feature support
Date:   Fri, 18 Aug 2023 11:26:10 +0800
Message-ID: <20230818032619.3341234-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SA1PR12MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: c82cbb9b-aa3c-462e-98ba-08db9f9b032f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2k5zjiat4qmgszNMWwwAB24lVkWaG2sMFDC4Ru12TaEDujSxdrv7KDAkYr86BHFNkVI4hkPh/E+yP9tGEhnIm97d1XQkYwtUybPHIFTfPWV/olnkQ8QdXLch42DdNeAbgGJgCISR4uQGtPIjzZEJwa5KgP0IngumHVWUHCUOYenIFo8dgZjL7TtuV4Cs8CpEU4JOZ2k3y98e25DeZRWWoLEvzODFpYefz2+Wn3cnGyGovY4MALAfzjwsyH/APtRSKGpLKhUFCiMmCnoZGHd5+3Kl5VNICOiFjDj+Dur9S02becKk2y4+6PEoIufshsbY4zhcOrABWrXfn/jqOn6F9PwVSrGduam/ynPrEAA53RxL8MNtVvIpcUopAgOg9/6Y9LU6o5VeYg8LWRo7OAsGUNO98dILn04Y6vQewlj1MagVcmfEMMDFDyHdZki1GyTvD62JCnbzLc5rQ1vUTsemLAxZ29pKjoXRVAlUTbebljjlVk7hwKwb2QuiXOaf/+rVTA/dnM4ObB58MCdNNyfEbt6uS3l1vR1D7fuOwt98GV57wJ+qqbZ98WVpTIB7giJ2Zaklw7jGl5tVuS2GTl9hcQwKBUX5byaIwotCBZY3y72pQ8kdoAFoLdro0xsvHEHYW6Oa5lCdKDN2C2IyyqvJ1UBzyxAmYHkEAljE5hiyGWj3iVjgfe+qW5vMq5qAlqkxoNlUKd8dURndZ5wbwpTRVHk9sSCk9qsGQ0oG7NVp9uhSRhv+NhFfKo4MomrkPK/YWaWkhqrhO/P+cdY+ULpIqCp/YVhLOXlil9OqghaB20dfVMKaq79hYq6ydcGp72qqAe+qkhFMO0GqthfyV+eJ9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(426003)(47076005)(7416002)(2906002)(83380400001)(36860700001)(336012)(110136005)(70586007)(478600001)(70206006)(54906003)(6666004)(7696005)(316002)(5660300002)(16526019)(2616005)(44832011)(1076003)(8676002)(8936002)(41300700001)(4326008)(26005)(86362001)(36756003)(82740400003)(81166007)(356005)(921005)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 03:27:12.4630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c82cbb9b-aa3c-462e-98ba-08db9f9b032f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to electrical and mechanical constraints in certain platform designs there
may be likely interference of relatively high-powered harmonics of the (G-)DDR
memory clocks with local radio module frequency bands used by Wifi 6/6e/7. To
mitigate possible RFI interference producers can advertise the frequencies in
use and consumers can use this information to avoid using these frequencies for
sensitive features.

The whole patch set is based on Linux 6.5-rc5. With some brief introductions
as below:
Patch1 - 2:  Core functionality setup for WBRF feature support
Patch3 - 4:  Bring WBRF support to wifi subsystem.
Patch5 - 9:  Bring WBRF support to AMD graphics driver.

Evan Quan (9):
  drivers core: Add support for Wifi band RF mitigations
  drivers core: add ACPI based WBRF mechanism introduced by AMD
  cfg80211: expose nl80211_chan_width_to_mhz for wide sharing
  wifi: mac80211: Add support for WBRF features
  drm/amd/pm: update driver_if and ppsmc headers for coming wbrf feature
  drm/amd/pm: setup the framework to support Wifi RFI mitigation feature
  drm/amd/pm: add flood detection for wbrf events
  drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.0
  drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.7

 .../admin-guide/kernel-parameters.txt         |   8 +
 drivers/acpi/Makefile                         |   2 +
 drivers/acpi/amd_wbrf.c                       | 294 ++++++++++++++
 drivers/base/Kconfig                          |  20 +
 drivers/base/Makefile                         |   1 +
 drivers/base/wbrf.c                           | 367 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  17 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 213 ++++++++++
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
 include/linux/acpi_amd_wbrf.h                 |  25 ++
 include/linux/ieee80211.h                     |   1 +
 include/linux/wbrf.h                          |  47 +++
 include/net/cfg80211.h                        |   8 +
 net/mac80211/Makefile                         |   2 +
 net/mac80211/chan.c                           |   9 +
 net/mac80211/ieee80211_i.h                    |   9 +
 net/mac80211/main.c                           |   2 +
 net/mac80211/wbrf.c                           | 103 +++++
 net/wireless/chan.c                           |   3 +-
 30 files changed, 1331 insertions(+), 6 deletions(-)
 create mode 100644 drivers/acpi/amd_wbrf.c
 create mode 100644 drivers/base/wbrf.c
 create mode 100644 include/linux/acpi_amd_wbrf.h
 create mode 100644 include/linux/wbrf.h
 create mode 100644 net/mac80211/wbrf.c

-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D255F7B2283
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjI1Qfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjI1Qf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:35:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E6C195;
        Thu, 28 Sep 2023 09:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDhQbw0/V221LcwuhKX8bQ+G3x01GyzLEg9V8BC0IfE4Mbn83HbKTNHkUqOLbiVuWVKVvzdozPJrBKb4vxEQIo46XWqXKR+XNv7lPrW8LoGYoSWLwqfFTN3+GvVDQucUp52OAm+d+P8/1q+nR4l5ylPenQCt7xaYQ4rwGqqA/DQBFo1U70gCZvf2H5FjgPNwdPX/oVNQCL4yIWBUuiLiHryxFcqWh/f/gAzLE5xdfknLKxPkAreKpeVKjks5O9koi46yKigBXWaPxzegqVS1bKaJKk73RVwQM3fl7Xn8Fh2U+eytmjUYQtr8KjxFRF4EkvKYP9h6N+w6BSpOWck5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msE6PVmGHUAAp15pg8K81/Il5h4cdQ0yPxlDh/WT2mM=;
 b=JI1KwzEydT+O32EYHvbL1FGcNf8nWY3kdnFAl1eWvjZJnsdO0uwY45ziQdjiIb47CdgPtbT8HxpaMUgTjsWMwgPV2PsmJ09ohZq4GbmBaqd4JTzjq+J97JA++Wbn38FeBhr4It22y1yGEFDujFx+8QP37oQ8FW//IX+HsKzF+Qku+YEdZhRdEEUxmySjEuTstvYysajnCz6I9/ZPwt7xEaDoMTzr9TghIy0Xzdf5nB1Q898bKMUdviZBrVb4vsIZgGekXXytyubSMBjfuul+m/52msXaLpMFmbG0iKcZzeufoPqKCclQswBAs1Rqz8NkHClRHC3Y9kscv3eNwBi18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msE6PVmGHUAAp15pg8K81/Il5h4cdQ0yPxlDh/WT2mM=;
 b=xAk7rFgP3gLISGOi05+Ag5KiMmGa/52K0PKvKO+zm4saObOzKsVmD3SwnUpW+y0KqNvklJ+5pXovy/zen3c83nObX8MpYAmPrLa4kqrwuEKB8UPkUcgDEJESaJgHtulCftlx0ys5SjZvHhQ1sDkZgCjyjAC/MZpLeOau6b6ih60=
Received: from SA1PR02CA0013.namprd02.prod.outlook.com (2603:10b6:806:2cf::11)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 28 Sep
 2023 16:35:21 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::de) by SA1PR02CA0013.outlook.office365.com
 (2603:10b6:806:2cf::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 28 Sep 2023 16:35:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 11:35:20 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <amd-gfx@lists.freedesktop.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Alex Deucher" <alexander.deucher@amd.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Jun.ma2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/3] Fix Navi3x boot and hotplug problems
Date:   Tue, 26 Sep 2023 17:59:52 -0500
Message-ID: <20230926225955.386553-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 003c61a0-a7db-408b-07cf-08dbc040e88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfmBVzJMWyOGnrfHpdn+NYrZQC901JYdWmSjUCzDbWiIhNd+yrdmduNNz5uk3VoLr6AHHaxHhFnikpLFdaPA7+iuCokJCxv1brw+5UMHS322z1IBVgBHgNy6IkuxswUWPkFDy6HARF1HNR88tfWO3b5IUaU5LYfSRzxliBTdiA7MUtt3PI1moi2bz7nSojgkHZyWpIeznYB3EqRWhczE2xs5crnKBt5avG/885ibm4DvYs4/H1l7DROcZT+ZG9FRV5RKCD30J1ir8OaTV8bMbP2m8yHDJqn5IBmA50k+EuQLXzOX4QoP097Zy7taIgcoALfr38P6mwY1HoTLy75D8f+XxugGl5DdtpUtDUCewG7Fsa1xp7kwYH+Hhh7BK3D5cRbleTpjlZ9vSuEhWdseVtV4IQGef26GMcOTjYh3YSZAWY/1+PtrLmw1/2VNJOfGxoJAxaHzKdxvmamgrgSUYqVuEWM8cP5mEEfyyhXCM1VwJZsE1IHjZDT8JdZvQHpTu4OLrmoU7qFUnZggxZ8P7Dm862E+niUId8y0EneFzTDeecmRIQ1zq5RjE5jHPkYL+33+pSFeyb3Hx3+OiCJLKWNQyPaJNZCxjir8BbOtjIdNCj3IYYKZkKc1Nf8OZW2GZSQlBTODYwlG4YwWQ3l09+nBq9mUYIBrDSPfnAAiPD9HmOTP4y+0lzPhbQcj5AWuT+Iw7QR943Qkkc3JCwMmYXRuT69bEWwZaUDE/NwgEi3HZNHGd1Aq/OWI65pePDqWltRHNBEcFKaEJIhZeomn0Sd1DL6C4Fbcf1ttigJe3SU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(40470700004)(36840700001)(46966006)(44832011)(4744005)(2906002)(70586007)(54906003)(4326008)(2616005)(70206006)(6636002)(316002)(110136005)(7696005)(478600001)(6666004)(1076003)(36860700001)(83380400001)(26005)(16526019)(426003)(336012)(41300700001)(5660300002)(8936002)(47076005)(8676002)(356005)(81166007)(82740400003)(40460700003)(86362001)(36756003)(40480700001)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:35:21.4363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 003c61a0-a7db-408b-07cf-08dbc040e88c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some OEM systems multiple navi3x dGPUS are triggering RAS errors
and BACO errors.

These errors come from elements of the OEM system that weren't part of
original test environment.  This series addresses those problems.

NOTE: Although this series touches two subsystems, I would prefer to
take this all through DRM because there is a workaround in linux-next
that I would like to be reverted at the same time as picking up the first
two patches.

Mario Limonciello (3):
  drm/amd: Fix detection of _PR3 on the PCIe root port
  power: supply: Don't count 'unknown' scope power supplies
  Revert "drm/amd/pm: workaround for the wrong ac power detection on smu
    13.0.0"

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
 drivers/power/supply/power_supply_core.c             | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.34.1


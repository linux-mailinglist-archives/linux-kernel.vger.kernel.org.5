Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9477E7CC856
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344110AbjJQQFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjJQQFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:05:50 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF45CF5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICo5vNJwiGUnwWVfwVsPFYwjT84+hRZNt2twDQIH4VC6j8oonQkwpkJAB4IwKoK3U/Ynt/glAZtRF3SiHkiGoRYxHY5r8PQGF8JbepJtIbcOD0uB/Ind+ja98sy/OQyMNFSNMaV6uo/6L/8VAr3jhmrFXLr7sgV0pO8lY+/EV7XlcsoPF7336QWdQRvlXv+IttYSY2ERT3pL8176BKY2VbqS4EirG+G8xGD8iHyMrhzwbj5i7OgWSL2uRpkHWos0TE86wa7BJx9n4hW/q5jHHDA+xsOs5uxTCwabsKqnCgLdANZs+nDPCwAePOqt5yAMiknbCFmWPAGur7OqeIrwWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjRoFrRITAMV958qAdhatMYN9rKHGyC9sue6IzmrEZ8=;
 b=nogWPVoeT1scMJKLMssngot7XUbNJVyx/YzdsR7mg2ioxiRa1Yk59UgS0rcyRkwOqpn9eBcJjIbTk0OMEKG9E/xH34GunrGsFIgJyQoMAdxL7xlGePMVT/T47EO+2ndospdDwW0qzaG8ufg6rpSrZ0FtEJ7cWuMFbPtpEWgPWzWJKzHYIaiBdU14x4x0viIagkGwDAjUYCor0ojwggRUAuPxlcL3hdlqaGh6najNAcLmNQNXb8Br7UMxZgpoxJNQYwlMEoAzuro+qaWw3f5v+djxFpoiup9z3paE3X2zFkxbsLiG6KDg0a5SXONr/ZFZ0LWguhImkCLJXB/11HrNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjRoFrRITAMV958qAdhatMYN9rKHGyC9sue6IzmrEZ8=;
 b=D1cYH/z2qLIctlbdN6IZzRiatxWce0Mt0dE0oRFtkEeYxjvz64SWMqEdFCeleV4x+sWCntmgCzKR4zGUKD/iCZIHlR6pFrreQooMPmS8/1NB4TmZI91sCQLiepVBu+geCGwNyYeGz3qaxiTr5u1Y4MWFsXmRkK+0RgrdCAtMl2k=
Received: from SA0PR11CA0153.namprd11.prod.outlook.com (2603:10b6:806:1bb::8)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 16:05:46 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::b7) by SA0PR11CA0153.outlook.office365.com
 (2603:10b6:806:1bb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 16:05:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 16:05:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 11:05:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 09:05:36 -0700
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 11:05:34 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <puneet.gupta@amd.com>, <Nipun.Gupta@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>, <git@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v7 0/7] cdx: provide sysfs interface for cdx device resources
Date:   Tue, 17 Oct 2023 21:34:58 +0530
Message-ID: <20231017160505.10640-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ea624e-377b-4000-88db-08dbcf2aec5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CBSf5DzyzpUOvCFKsADebIcKaHoRLPRRYvu0LXaQjjfeg9fatJqDwdZea2bkEmUBBAkzXtJv2gRVqYbOWA+0W+EF7pJp2NXBlwDUNy/zG0/rsCWLDoC6HSRLHhXmhesYNNTSVjl1xg/1PiivysEn54PW02QsctoGfwpKOZYvFGAG8IW0TzZCJZ3eX1Ci1bVUCbItA0cDbORfeoM8LzMa9acE6yF8ilLFwgISakRgj/Qq8wpVXTCPqtg88zaDI8GpGkkMPiDdRMamTP8q2xq/M5J5ehMx4yyaj6K2gNfeU6tQBhpxvXG16nZ0MnqtOLozFLyxGThRGw9N/fG9KZYZRmx2S2bsHr2xWphkBmHe0503angMgr0mq9RNDGEPhPCLty3fjnuU3Vw8y13pmEJ+I11AXAnJ86VI/3YzMdyD3lQ7n3rJEsee4dP6hmzIHke5OGGbkxw2bM9wtIEgDfQnnTR1wFkRkYsev71NRckeY79XzDSARItVNU1FeQT56rxRdUk1WIuk60MFfy/BnM6+D1L1/pqrT9lBj+yzkEQdKs6bbeoH2BpZ1DTk1aQkxWarb1BLMvc2kppnATgP1tDXXZbkqlSTfWYjeucuKZRlMIuPcMPuEKjls7jd7k3QcCSU8x/1ue5HWlgs+T4JvQ3OUKUlnzYx1OoduThmzDD9DeTaPuvr/qX6OPasCjDT9arwEGdPdWrYU4WsoMOOO8ifSKuCcG80hYhjuKglLNcITNjRWV3g+Mi4CRDIQWypOkM/Q4Ykr/jjKwie6F60negOzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(70206006)(70586007)(110136005)(316002)(54906003)(40480700001)(1076003)(36756003)(426003)(83380400001)(82740400003)(356005)(81166007)(47076005)(86362001)(2616005)(36860700001)(478600001)(6666004)(41300700001)(44832011)(5660300002)(336012)(26005)(2906002)(8676002)(4326008)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:05:46.3716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ea624e-377b-4000-88db-08dbcf2aec5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provides sysfs interface to
 - enable and disable of cdx bus
 - reset all the devices on cdx bus
 - subsystem, class and revision for cdx device

Changes in v7:
 - Create symbol namespaces for cdx subsystem

Changes in v6:
 - Register cdx bus on cdx subsystem
 - Remove bus attributes enable, disable and reset
 - Add new device attributes enable visible only for bus
   device.
 - Use reset attribute of cdx device for bus reset.

Changes in v5:
 - Rebased on Linux 6.6

Changes in v4:
 - Make ida as static
 - Improve commit message
 - Add sparse markings for the lock

Changes in v3:
 - Remove local cdx controller list from cdx bus system and
   instead use platform bus to locate controller
 - Use ida to allocate unique id for registered controller

Changes in v2:
 - Introduce lock to protect controller ops
 - Split sysfs entry enable to enable and disable
 - sysfs entry enable and disable take bus number as an argument
 - sysfs entry reset takes bus number as an argument

Abhijit Gangurde (7):
  cdx: Remove cdx controller list from cdx bus system
  cdx: Introduce lock to protect controller ops
  cdx: Create symbol namespaces for cdx subsystem
  cdx: Register cdx bus as a device on cdx subsystem
  cdx: add support for bus enable and disable
  cdx: add sysfs for bus reset
  cdx: add sysfs for subsystem, class and revision

 Documentation/ABI/testing/sysfs-bus-cdx |  66 +++++-
 drivers/cdx/Makefile                    |   2 +
 drivers/cdx/cdx.c                       | 264 +++++++++++++++++++++---
 drivers/cdx/cdx.h                       |  22 +-
 drivers/cdx/controller/cdx_controller.c |  20 ++
 drivers/cdx/controller/mc_cdx_pcol.h    |  54 +++++
 drivers/cdx/controller/mcdi_functions.c |  31 +++
 drivers/cdx/controller/mcdi_functions.h |  18 ++
 drivers/vfio/cdx/main.c                 |   1 +
 include/linux/cdx/cdx_bus.h             |  41 +++-
 include/linux/mod_devicetable.h         |  10 +
 scripts/mod/devicetable-offsets.c       |   4 +
 scripts/mod/file2alias.c                |   8 +
 13 files changed, 506 insertions(+), 35 deletions(-)

-- 
2.34.1


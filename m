Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29BD7C7D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjJMGJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjJMGJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:09:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F612D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7fP0GVTicH8OUdqz8cxHDCEjgimtn4M8yEglFr4Dj9TKyzFsHu535RxT0C1SgZQK4367bDxN7OeAQKtVf+nMACG8D2yUjCxKikgiRQ2zVAAbRSo65pm+dR4aQgQfxn7lS9mU/GYn1cFiRkez7GTzh7Va4Uy3PrDVOEftJgF6+EzetUxFhWsIS7N2lSModSdd624Y0VxGFwnYSlwZSfbldXAK++Z0yPSAmKaDLRmAMyt+65rK2tz794/Cx6/RuD2AYg0mfg8GWFz+YALDos0pNEY3U2Twy+GOPeWTFszsUKjVMWNglLAyuQyX6k8u++QNkcqUI31ykqtr7TorOH7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4E7kD7R4hXSSirIqVw3YOakaFEMOn1J7rewgKViCT+M=;
 b=aCG0PY/RKd3odmsLOa90J+D081aRjp8VoKfuFEvp+Ys2ZW+NNwVoq8NvdZzZp2pzkvSwk7hLA5q/v6pDh6i3TuNOUPhxUJinwJDWH667pHpEYa6QwmzvtSBbhMDYj0rBG2o9FyFl2ihIJ5KM0j8YO5rtQi9eWflHMlJIAC/DFzcteW/szJlaAD0mrHr1EiXl2Rj4ksTvV8PIn8qnX2/mV8XyaHCkBejQhblGZUD8wobSe64ylMvoJVaqmG/JYoHIFjsyp92oHobLhRB6HeF1o2l4oj0h9R/pNohxcQ5tSqQ5Cz/nkkddIoeNEd5hcAOe2/nlNaeCCYl7kFVcVsxItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4E7kD7R4hXSSirIqVw3YOakaFEMOn1J7rewgKViCT+M=;
 b=TPIpJMOO2WEmSCX/U3nB6P9dw08X1uo3c1TDShvpuekAqtoivTv5ROe4Ma8xlcaFelCkvKDqvdvr3Hvg5rekb8fsWs6gq2RmwtBivzGlcbhpHd4gmJZI3EpbbWQuPGR9VL3actHSi6Gra3E5sZLo0S9xOHaQmZBnPM6cvo8UN+0=
Received: from MN2PR02CA0031.namprd02.prod.outlook.com (2603:10b6:208:fc::44)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Fri, 13 Oct 2023 06:09:15 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:fc:cafe::f1) by MN2PR02CA0031.outlook.office365.com
 (2603:10b6:208:fc::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.31 via Frontend
 Transport; Fri, 13 Oct 2023 06:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 06:09:15 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 01:09:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 23:09:12 -0700
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 01:09:09 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v6 0/6] cdx: provide sysfs interface for cdx device resources
Date:   Fri, 13 Oct 2023 11:38:44 +0530
Message-ID: <20231013060850.424929-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 47122eda-ef47-4750-97fc-08dbcbb2ed72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NvUho6QRCS1D6PSANth3ZvJjg1qEW6x22w5CrwIMWWH4FEbtBqFeUnn6VTHVu/VWUaqYykBy1wYG8I69J0v1U6lL/orKiv6dzQZ0jFbAhNZgNvAon9UwDInjYQZsFbGCRzMQSYTan8hk6f/3CkLKy1/aP5al7NJH8O8xLuEk1hed2m6IxJyu1YIqclIaMmqSyzxb7yBG8lYsdh47925CpoEzAo45Opr3r9E8FkX1UORTOhVlYR8oW0DROuU35miCI/g9bdgdc8pZcsh8OR48Vx4h3CcY5jJTMnV0cDXofT9VmkEvZ2kELwv1MgZgSkhrIWKHJ042uVpf8M2F5ysOwQ2SIxcKWGO2P3mlHB4QFI9HRv+aWNuGZ8zGm9jggw8caCkCP4iCEeMr5GDWFyiWZl/dVZ8UMxFLceBijXA9K5nCl462MS7xVRuNA/743U4CdLKWMTSUSJNV9FEwGWzDdTHm++HwdsZZa2SEq2dFXukrrmdYDfWDFIFNgr96OpSF3BL/ZrLlJsgDgZ1mkqY69dMNLFX4mDhR95i1c844PUwJexW/gpoaKzNIHvQlYL7g2XjRD5ZVhRncyBoxV7sZIs8vsX7JdDuc0t4u4Em0fowW4MYnnJp1gDdy6v3LK7Xw2YDfJJwMc3h6j6U7csjXaNIzWgo76JOqTVLlF1N+jWGhcEK8SyzfL/BBaO0Y+YM0mQ7jjMX+Y+7lEYQ8kTTcqSH9D+hF7bNnSMViHihcA5Ewjl327NjWYGHH7TdKhle1LVN8Q6aUuzX6pfsNWpFS0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(2906002)(8936002)(4326008)(8676002)(5660300002)(70586007)(70206006)(54906003)(110136005)(316002)(478600001)(41300700001)(44832011)(6666004)(2616005)(40460700003)(26005)(47076005)(336012)(36860700001)(83380400001)(40480700001)(426003)(1076003)(36756003)(82740400003)(86362001)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 06:09:15.1072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47122eda-ef47-4750-97fc-08dbcbb2ed72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400
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

Abhijit Gangurde (6):
  cdx: Remove cdx controller list from cdx bus system
  cdx: Introduce lock to protect controller ops
  cdx: Register cdx bus as a device on cdx subsystem
  cdx: add support for bus enable and disable
  cdx: add sysfs for bus reset
  cdx: add sysfs for subsystem, class and revision

 Documentation/ABI/testing/sysfs-bus-cdx |  66 +++++-
 drivers/cdx/cdx.c                       | 258 +++++++++++++++++++++---
 drivers/cdx/cdx.h                       |  22 +-
 drivers/cdx/controller/cdx_controller.c |  19 ++
 drivers/cdx/controller/mc_cdx_pcol.h    |  54 +++++
 drivers/cdx/controller/mcdi_functions.c |  31 +++
 drivers/cdx/controller/mcdi_functions.h |  18 ++
 include/linux/cdx/cdx_bus.h             |  41 +++-
 include/linux/mod_devicetable.h         |  10 +
 scripts/mod/devicetable-offsets.c       |   4 +
 scripts/mod/file2alias.c                |   8 +
 11 files changed, 499 insertions(+), 32 deletions(-)

-- 
2.34.1


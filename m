Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5080D7FD016
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjK2Huy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjK2Huw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:50:52 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE6610D7;
        Tue, 28 Nov 2023 23:50:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ph0X4XcL6KO5KbiHnb3+mbRq7AJZf9qlKiO/YuntSmS1u5xrJ1NQyxhQ43M5eu/ko8zN1KY/ju4TH73kjxvno7Rhz07XXa0BSJp9/a9fnV9Jqpr/BLOXUKyKMN6K7VlxTGllCM+ONkKXxNCz/2MVgWPIEcyqzcDRQ8tZiyhCxhgEADlPkteGq9D7yD1oRXuW1sa2v1hgibRA22v5jLKiRno1XNO7M+q5pRCyY7yMuksilJUMDmuintBS9lOrRRuMZxnnchU72TdEQD2DyZWCdogRcT62Q375K+3QONnC3k3zvvFFVs12DOq7+hpK8RU8yu+g54zIZxo96B1tnuBrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jotPp52wsy68XXO/cJ+xg/jwKymaHZM4+6Rfjd+XuXI=;
 b=N9fQqluMj0JEIAOUBMBK929Q7l1Gk2LKMC6SLoyjZW+9OmBO4qqvp5QErHJStPKKXTQV5sI4Z1dyhXMm9RSnFPGq8n9HIveA9XpJg+Kj1QZlYxcbmW/s0X+ZhKmjm6SUqhbDML86C99Lx+ABYpxFh8rvCxpWsCxpX3nGgHLY9grZL+VM0/bIqHECJPFLR/ExuLdwZF/FJz84x9k+S+KN8yrnC0Lbdyvv21kiK5SYt0eXLwFuSeVrwmGSf7qk3UBddpv/OQRurYNNQ9tnKPvcc7Ehf6CcLNQdvk6cavC3IoE2fFwBbjcqcWiathROdqHTDu4UTXgAuyBFYNb15OuPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jotPp52wsy68XXO/cJ+xg/jwKymaHZM4+6Rfjd+XuXI=;
 b=Gu5aoVh9GInweMmqIuSyVdh6DGetg5pill5OabGozU0W9H2Gpf7DplDK1Oe65mTOwnywdMkdXm1PhN0yTYqiVHibZJVo0d4E5OVSyX74oMH0FVCgg8yxO5tdqRzmjPp2qSD0+U3qtX3xo6X+6qm9Rk3kSpiNpTCoNdOov+O3r00=
Received: from DM6PR07CA0047.namprd07.prod.outlook.com (2603:10b6:5:74::24) by
 DM6PR12MB4545.namprd12.prod.outlook.com (2603:10b6:5:2a3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.22; Wed, 29 Nov 2023 07:50:54 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::86) by DM6PR07CA0047.outlook.office365.com
 (2603:10b6:5:74::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 07:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 07:50:54 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 01:50:52 -0600
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 0/4] Persist FRU memory poisons
Date:   Wed, 29 Nov 2023 07:50:30 +0000
Message-ID: <20231129075034.2159223-1-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DM6PR12MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2f8436-f149-4da5-9f9b-08dbf0afea73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNWRMmrAkokjAe/XhqM9DNNaKAxfS+Ccj58C0qnlBS32I/YM85hyiQvp5LuJzY7owi14kz2DemKBLezcgaGyy97ddKFU65vNIf9aNiX1sMQFmb3mf0paXI43Oo05ZfftF9IkGE2ohLQmr8u7IP4Px2oBDrFqWQGIyLz1kI0NQFMO9+q1Z8yYCGgF/RBHTuuc8bWBxQ03MH3LFBV2z0YsYRshkuLldFjq2LdbWoo4MoVBa3qS7SkT8BI4OsdCTm6krPWYWQYqUiWQKS1joT82/NvOzmJAOBTM+a9aKvwjwj20kxo1/gUVRU7S2gTxFOpp28gPV7d2DcSfpZVm7FcIMY5F8WFn5Ye9/xf4q70klDZ8v3QbhaZ4RItLbnmmTY4jiRlsPZ8eJb0Vm++8M92eycaGExnT7/5f+45vBFxJiW6V9R1HrfzzXGQbtVEaHXMp1NzX/EdeOplL0ZQre8SIAfplFBnzGc1WLDONhM984SrYr74x1JRCvumZaCvJXm3StP5npUPK/nny3Wb7c38OT0+CcnKlGULGZ862wwgsM4WlrDbcRoXUxP2KSHM1oMXRdGXay92h6jZG+YMhhrpsFftx5jrcL+SxhbdfQDdxiF9Jp9YJlWkkNjSVbH82qcuV4V04uMtpwHuEgntvsj56v1Xhxnc4v9fJw9bWdxzdPtRnK8eLhhwA3Ou+orgDFrdpBRnQiYkJdrmI2YemaBjXWIrp9BT66KYijtzopEUMD2ZIRaMxEyUIci8BlKJjOrAI1HhSWAnY+33KJWOoi66slw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(356005)(47076005)(81166007)(40460700003)(26005)(16526019)(1076003)(2616005)(54906003)(70206006)(70586007)(6916009)(316002)(2906002)(4326008)(8676002)(8936002)(5660300002)(7696005)(41300700001)(6666004)(36756003)(478600001)(966005)(82740400003)(426003)(336012)(40480700001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 07:50:54.5352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2f8436-f149-4da5-9f9b-08dbf0afea73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4545
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

This patch set is based on the patches submitted
https://lore.kernel.org/linux-edac/20231129073521.2127403-1-muralimk@amd.com/T/#t

MI300A has on-die HBMv3 memory embedded on to socket. Upon reaching threshold
of memory errors socket has to be replaced. Define the criteria to identify the
Field Replicable Unit(FRU) based on number of poisoned pages in the socket by
persisting them in a non-volatile storage.

Notifier is registered to handle the FRU memory poisons and poison count
incremented based on injected MCE errors until it reaches maximum number of
fru poison entries.
Sysfs entry per FRU will ease the use to look into the poison details.

During boot, Read the ERST records for identifying the poison address and
retire all system physical addresses in that HBM row.

Patch 1:
Add an API to get the maximum CPER record size to be stored in NV storage

Patch 2:
Add FRU memory poison module

Patch 3:
Add sysfs entry to print the required error information from poison records

Patch 4:
Add documentation on FRU memory poisons.

Muralidhara M K (4):
  ACPI/APEI: Add erst_get_size() API
  RAS/fmp: Add FRU memory poison CPER support for Error persistence
  EDAC/amd64: Add sysfs entry to read FRU poison data
  RAS/fmp: Add Documentation on Persistence of FRU memory poisons

 Documentation/RAS/ras.rst        | 122 +++++++
 MAINTAINERS                      |   8 +
 drivers/acpi/apei/erst.c         |   9 +
 drivers/edac/amd64_edac.c        |  25 ++
 drivers/ras/Kconfig              |   1 +
 drivers/ras/Makefile             |   1 +
 drivers/ras/fmp/Kconfig          |  18 +
 drivers/ras/fmp/Makefile         |  10 +
 drivers/ras/fmp/fru_mem_poison.c | 595 +++++++++++++++++++++++++++++++
 include/acpi/apei.h              |   1 +
 include/linux/cper.h             |  24 ++
 include/linux/fru_mem_poison.h   |  17 +
 12 files changed, 831 insertions(+)
 create mode 100644 drivers/ras/fmp/Kconfig
 create mode 100644 drivers/ras/fmp/Makefile
 create mode 100644 drivers/ras/fmp/fru_mem_poison.c
 create mode 100644 include/linux/fru_mem_poison.h

-- 
2.25.1


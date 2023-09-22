Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A057AAF4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjIVKTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjIVKTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:19:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38955BB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbCuHq4qrIY7GiQQJWk4ceTJNE1wqWNYzYh0Ub+fDZUfvsmQ7zMqvaJBNzxiI4m/YI2aAIBEmDzDKWqCLibNdhGbFdF9EUbdDZkmKx1ClGeWWoKfp+a3rJ1hU9WVt8L7TlDr+TTBB33YTfqDbsHtWD8/LW2TOEGAXJkNCaIc9izGsqqD8bF/sFtYc5fLBG3zZXCc9ugnnrxgUP1m203k6A0kEMb5Ua8I+KsUJZX5+M7hxSPTUfYwVQJgRR/7xyMAHWUp+U0hnswyBkrJ7IEVtEeOLdzyvyvmJ8qk/Kqxp/JT0clizAoCJ2Q0qIMKaMqW1FpR4NAnJ6GCnW0JYGhDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObM5gJxrupHJ9rpLLcTBV5aoeIFQq/F3d5+Ev8NSYYo=;
 b=b+jLSlh1ywIiRrS70C8xMLwgOzhUIWYZpQ7jBDcka9WRq/nlLAQu+Mpsfp3X6wjGWyZOKfTiEAa+kYOqNJzBz/ba2sYJqDofF9GmLHc7QzvOjqcpRi8WJmODEXWrWTDrs/f4asz8jn2v+DGAcTU3Tvs05RjObQPeQJC6rbYz5OiSpSGWZWOeGpo/uPP6wewnwyM0Jo3wlFznEnJHJaCTJXmUjMNzkM0PVAdbCv1TYT9gxetH3vSKKnaXgUuDXuG4y+XfXXkCELh7DfVZ4CDJI7KP03vgl9PqzmCWb2NhGSjnRQ5NYw1WbBKMVATPDzED0rondg+gbZXk4bjMMhSIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObM5gJxrupHJ9rpLLcTBV5aoeIFQq/F3d5+Ev8NSYYo=;
 b=yXxFMG7bqpyr2QYI5R+8t7+lk6m1xB7ZCGGbWY7m2QO+mVLnU5G7VpCXHhYbgGYMLipFyN2q05U6PGMj+nuGYfPxtKQXho9LZOTa5gEsOfoh+Yb9NtOmu74JqZR9FQxW0M6mD8CrN85qDbYsCPKJyTiQiNZ2X/oMNDxeBKcyXMA=
Received: from DM6PR13CA0030.namprd13.prod.outlook.com (2603:10b6:5:bc::43) by
 CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.24; Fri, 22 Sep 2023 10:18:58 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::bb) by DM6PR13CA0030.outlook.office365.com
 (2603:10b6:5:bc::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.12 via Frontend
 Transport; Fri, 22 Sep 2023 10:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 10:18:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:18:56 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 22 Sep 2023 05:18:54 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v5 0/5] cdx: provide sysfs interface for cdx device resources
Date:   Fri, 22 Sep 2023 15:48:23 +0530
Message-ID: <20230922101828.33456-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|CH0PR12MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: c071dfca-6e91-4201-5182-08dbbb555513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXPtnPNZOGgxemqyq2ZLwNPhgKAdbJfJGZdb88fGi1fiYldAkBmm0KhsWG2IijwB+LEEHwry1eyvwDhFNCmnJ+xLY+n8LID0qFn9HR7u5zPjFcwwDiqb1uiPCPuXBLRU38Oak5+7EUQHrpjYN/JiiiBttvF90jTWvGiReh/QPwD0lvmWG9INQPwgQeeQceRk8625B6V8Cu+KJ1kI0PaGiva/7ZHK8pEThExLwyL0QAPPFGg5FfYhX2RVgr6UIGuEIrcuWO0Hiafpnjd8ThbOOELTqpe+SVykqnxDqzlzpdBcbDT8i2LFVYQjaVSQqFJiTSgRy6Cjp5SqwzdrcJc8f1/f+y8/q5+e0uniCi1PAlp6EDQmq1+auacHkhR0OwAPzgd2zbRWtQSXD6wiwgBn/MU6R0ANeCAIwUQs8pFoWGBCKy5Oe9+UkHWjcj2d1arw2l/PhUf2C2p4FCD8VLe8EeLg8PDsJEn2JgCwXXj2Hv3FNITx4W4znrDN5c74sPHVUJKYHJH/BOiv08nyNr4mnEOSu1it39W04GDWiuxyqMbWWmsMWugLcWFyw0lcFX+hGXLyaKbLcHhaY9QjdltSDfHRbxVp8g2LCkfZ8epZYuadtpcPgqG8I2wvPcMbfVE1YZV4/fxoQ2He6vXT/Gk4upoqg/iE/Qt0ZgHIwwhDql29vRffArZEFYK0L8+2qKhwMulR9K/R2ygeMAgByQX47QYihKGpHO7TReWuPxjOK0pydBN15RizNOOs95mGiURAtCvHRD7ajPbYPr7GgmfTFTTkjOMoiDf8eoJMmNqXZOHp9X4v9hBBejofaNokHtsW
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(186009)(451199024)(82310400011)(1800799009)(230921699003)(40470700004)(46966006)(36840700001)(40460700003)(6666004)(82740400003)(26005)(336012)(426003)(1076003)(70586007)(70206006)(110136005)(2616005)(86362001)(478600001)(47076005)(36860700001)(81166007)(83380400001)(356005)(8676002)(36756003)(4326008)(2906002)(8936002)(44832011)(316002)(54906003)(5660300002)(41300700001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:18:57.5907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c071dfca-6e91-4201-5182-08dbbb555513
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provides sysfs interface to
 - enable and disable of cdx bus
 - reset all the devices on cdx bus
 - subsystem, class and revision for cdx device

Changes in v5:
 - Rebased on Linux 6.6

Changes in v4:
 - Make ida as static
 - Imrpove commit message
 - Add sparse markings for the lock.

Changes in v3:
 - Remove local cdx controller list from cdx bus system and
   instead use platform bus to locate controller
 - Use ida to allocate unique id for registered controller

Changes in v2:
 - Introduce lock to protect controller ops
 - Split sysfs entry enable to enable and disable
 - sysfs entry enable and disable take bus number as an argument
 - sysfs entry reset takes bus number as an argument

Abhijit Gangurde (5):
  cdx: Remove cdx controller list from cdx bus system
  cdx: Introduce lock to protect controller ops
  cdx: add support for bus enable and disable
  cdx: add sysfs for bus reset
  cdx: add sysfs for subsystem, class and revision

 Documentation/ABI/testing/sysfs-bus-cdx |  87 ++++++++++
 drivers/cdx/cdx.c                       | 218 ++++++++++++++++++++++--
 drivers/cdx/cdx.h                       |   8 +
 drivers/cdx/controller/cdx_controller.c |  50 ++++++
 drivers/cdx/controller/mc_cdx_pcol.h    |  54 ++++++
 drivers/cdx/controller/mcdi_functions.c |  31 ++++
 drivers/cdx/controller/mcdi_functions.h |  18 ++
 include/linux/cdx/cdx_bus.h             |  41 ++++-
 include/linux/mod_devicetable.h         |  10 ++
 scripts/mod/devicetable-offsets.c       |   4 +
 scripts/mod/file2alias.c                |   8 +
 11 files changed, 513 insertions(+), 16 deletions(-)

-- 
2.25.1


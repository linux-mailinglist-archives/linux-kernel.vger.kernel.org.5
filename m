Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B517B30F3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjI2K54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjI2K5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:57:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350F91B2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2+fQ9ZIyAD63y+6S1Gzx3efEh8GBrj+s8tsqkyAmhtlyRlNwHtOnZdmvZnPLUxGDOkzowmGCVOyuMcZmFoIHOTmSq5Af7HIyw36ft+yc8B3KnXJ8e0EGQHKIHaKqPtJ6m4RL/zAXJiC5+FlN8MDRrdMz+OV+Fx4EoL2K1G+HQTQxLGnq7BRD7O42fho8O5hGP1wHRaPVE+MREyW+w8DB9ETJHgrRjqUCeMmr+PIs9H/9+aKSOlAiTHxXtB3g456DI6zieiEHXYdm+dtY38FW/ydDU+zpNlbOkgSuh6deiQnXVTFcqAN1Pcvy3abqxeO3eEh5L96OnDxI3ueilvGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfOPOjylN1iizpfHZSAe5fGp2m35jhpuBws/iFw1LYQ=;
 b=KlqcJEZpHgVOWuSdxBuvvknC601P/Mq53xoh1qytQtIQXF+GbH4tcn2fDBgUvlJw2h+ZfvePlut3cb8uiFkkdlcZfeKiHE7nXg1/b4Qebj+YnViR4TKumTudw+yt6jgZHTHZuXgriKMH0dZiY9nxe9y8EkMILvh0kG0p5NQXH9/JI3qX7ilrNp6n9zpEy+gdOcC7ovvKhKyFGbiqA+jWGUMB5SeYHMzmmpcRm5WCK/w+pWljBIY06T2K8wi2VYfAwhmGrYQfc4Gq1EXXSet/Gsj0/qmDamt3RSUoyTfHtBI8PGxMtq+7pCHXFmwLS76OhG4XCEjx528LTwkdlx06gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfOPOjylN1iizpfHZSAe5fGp2m35jhpuBws/iFw1LYQ=;
 b=hr4TFGujH/5+lSyc7U95Kict+6DZWfBuss4u4bbp10UUwkp3D1/uUPBdLMk7hiJS64g8E0vx5cIbVWXrAluocbklPdIBCVDofRZrlZnDXnh/c3rVBTCViGMzTyZXhhQGTCmdFQfUeoJ82BQdCj32Cj0B2Kdds/ypJdZ+9WAjxrY=
Received: from DM6PR11CA0037.namprd11.prod.outlook.com (2603:10b6:5:14c::14)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:57:33 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::ad) by DM6PR11CA0037.outlook.office365.com
 (2603:10b6:5:14c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26 via Frontend
 Transport; Fri, 29 Sep 2023 10:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 10:57:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 05:57:30 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 05:57:29 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <tanmay.shah@amd.com>, <sai.krishna.potthuri@amd.com>,
        <nava.kishore.manne@amd.com>, <ben.levinsky@amd.com>,
        <dhaval.r.shah@amd.com>, <marex@denx.de>, <robh@kernel.org>,
        <arnd@arndb.de>, <izhar.ameer.shaikh@amd.com>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH 7/7] drivers: soc: xilinx: update maintainer of event manager driver
Date:   Fri, 29 Sep 2023 03:55:58 -0700
Message-ID: <20230929105558.11893-8-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
References: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad29348-f216-44d7-ae98-08dbc0dae25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VBrTZeQlzLvzzihN5WDJxSHYZGBOStgCslsqs2EAtOD+/zli9KR92IyKwSC90UWkJajzhOVPVXk2e1LTYB8ZNtR/Om+W3poYLVsJXOkh/f7L9otIEr7hVPft4S4jPbJbgD6HwLQ8u7MkbNVQLaPliqhbySpVjf/cE4VMuX/Y/d3aWc3tbxxesTRCoa/rj7QzmVN8jHsihcU0fMMHOw1yGQrVMhQnVXRVgvUaG9hB6pGBN0jIduyv/v89Vc+5YjIUhbH0myd0NrshOpqsdgFTbHLqz4VGUiPX9kgE3anv0mpe6Flz79EXD6tteFwygJF9FG5mJfS76a62YXWw3wy6Y1FLK24nGVNp4EkRFAxhXZuWnz48wa35h0hBv+6kGjVqcxjFdpRwOarTsHHUHtre1upNNV6mrelLgHwlCHPKG5b10rtrzYhWcLrIbt4wmFsgjdE3OxNT54QzCV6hbhvgk4PvoP9eACj7qZI8kO/fcDMZjjDuz0myxZP0nrYYZfs8b1C+cxS0L9fa8knGPBJrl6/e6NL6rexceXIS0VK7jPo2U5YcoXC1pGupxvgPS58tBMtoLZ1rSTsDxz3aCQbfACQAc+0AAqehAZeLrHbcjDQ16T5lpCEBffDXc0gHf47oF1Pddo1M4W2BYyuixtsptMY9v4iO9oex5hz2c7Z1LsUDOgA7inzCkpgVNUVtNXr1hZJ98OmhiyGMdmt4wpRW3+OLUEtX+S28y7kdyXvlXmmF8Z+qk7Yry5bBK8fCSQLBOBecI0aQ9qunJTNt/1ieycs5aX5QFoqSxsSaDKJp0Sw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(4744005)(2906002)(40460700003)(2616005)(86362001)(36756003)(40480700001)(6666004)(478600001)(47076005)(8936002)(4326008)(8676002)(82740400003)(426003)(921005)(54906003)(356005)(36860700001)(81166007)(41300700001)(5660300002)(44832011)(1076003)(26005)(316002)(83380400001)(336012)(110136005)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:57:33.5379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad29348-f216-44d7-ae98-08dbc0dae25e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added Michal as a maintainer of event manager driver as Abhyuday is no
longer in AMD-Xilinx.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b19995690904..8da1ef5f80f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23671,7 +23671,7 @@ F:	Documentation/devicetree/bindings/net/can/xilinx,can.yaml
 F:	drivers/net/can/xilinx_can.c
 
 XILINX EVENT MANAGEMENT DRIVER
-M:	Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
+M:	Simek, Michal <michal.simek@amd.com>
 S:	Maintained
 F:	drivers/soc/xilinx/xlnx_event_manager.c
 F:	include/linux/firmware/xlnx-event-manager.h
-- 
2.17.1


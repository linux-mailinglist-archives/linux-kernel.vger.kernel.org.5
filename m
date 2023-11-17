Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA147EEE85
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345722AbjKQJ34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQJ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:29:55 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B0EB7;
        Fri, 17 Nov 2023 01:29:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSsj0fM1UWGnrYq9drAsvAblH3IcOtWn5hLTHXrPSaYtuOi70XKTo0Ofk6+Pmq1a6X9/pjeAzsu2eV5/xu09mBf1TFLOUy06jXyocUXOjTfb/vRUJvhfpjFeSxWXb6aaGhaYVHGTiTntyk+9leuB4S6Vv9xAX6c4yl3P1tB70IlT3FNyYMfqqLq/laddCc/TYsFebjHK3LxbtLKEXXaW4lmkYLvB8sTVbJGkeYmmdULGX6sPmnkUY6EyIz97kAvxbXyZpRCb4pcBfe7MYYKfqey2BQmfbDZgAexO/RfzdB5+PYLYJwFQuG9ksyuKKYP724BL0WqzTlaSvTfZaBkWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkEhiGiDqnEXrg8HH7qjpcPq9TcHtMJL+CqisOwhSGI=;
 b=ErvF2GdFvUjBJ/CZKWGPLRaw2BSeoo9zYK0+j5IzoqDgB1hBxPJigE1pb7P37tWkcLI8NITwyegf847BFlwsDD50W9RtpouVeeRNan4ogHXW1mOxmDE6N4ubbHt6/YvjcdV5k1ZACQKMsZlKcF6I2LE2QawMH0qLmGW8yZXDBM1CozB0qZ6630v6D+P15vJxQC3CgNYT8BtOxCor9Zfz1Suak4fgf8KIHPTup8libdfXzRNgBVxoeFYL6WPARUxTH7DKX35dS6QbxWX2QgIlncGxvl67IT/Vvh/P0hLQEFhUjeSyzyOAMy8ubiFweu1VKyvuUAFNv8MwSkfvCMi6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkEhiGiDqnEXrg8HH7qjpcPq9TcHtMJL+CqisOwhSGI=;
 b=cyMhWO0c1QLl7XplFDRA6eZLqFJmNoii4DBwgiZPlYGxd2uRPrKKbwv635V5f2zyXRyrmUtahDj1NEtxX8cBH/8LGr1R4PeQQ4hGtlCMn+k+rG/OgLtGweNADdCMVG64k1Qnooln6MbDkE5h3lMz2QtpNEq6ob/fnL7XJFs4RHw=
Received: from CH0PR04CA0038.namprd04.prod.outlook.com (2603:10b6:610:77::13)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 09:29:48 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:610:77:cafe::44) by CH0PR04CA0038.outlook.office365.com
 (2603:10b6:610:77::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Fri, 17 Nov 2023 09:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Fri, 17 Nov 2023 09:29:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 03:29:47 -0600
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Fri, 17 Nov 2023 03:29:43 -0600
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC:     <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <appana.durga.rao@xilinx.com>,
        <naga.sureshkumar.relli@xilinx.com>,
        "Srinivas Goud" <srinivas.goud@amd.com>
Subject: [PATCH v5 0/3] can: xilinx_can: Add ECC feature support
Date:   Fri, 17 Nov 2023 14:58:53 +0530
Message-ID: <1700213336-652-1-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: de510556-d2b6-457c-3925-08dbe74fbe56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApBcScNu/PNTr/xuimu9KrqSs8x1A+ifX9vNYZZ5vbdRt+GdqYADrH91kHPZeG06iTDpZMYTX3Wctmm5Fxrw6wUywY1dxBVyjdJ7wjUk6oEGj5np8nFD1g+Cigubdy5bItQLlBSpT3ng+1RnLZ0zLmKKojHOPz+u0c/sRxZO0Ia07o5j2UUXlqveeWzjVpJlZUZ0ouFIhkSL4Ec+7eksYRH7mQltJ8G7gooHgmJoi2mwQRtwl5fmGQpqBpOcYfnTerpl5HK+B9KpmEzVFc8NZdtH4ra3HBZiZwKX/rxmXZd/ErfutWBXfuX4cIwHT0fHRqR0JRXICtgflbpi0wA2BbmXQQ7bSk/7Y1LPK7Ygd49udDmzUPPlzW8lA8Ngl+8YWbLExImTpdrj7yVmRZJJ6QYbEp4EOR7hIsml9d4dP66WCCQj4wTNwKWI3aTND5feSUFIl+tKrlxe7Xlh0wGt29/o8TNGCB8bfSbsxsJf3l7uUiMTEH/eoBnDTnaL+g83yAQDO5GVIWBBcCNj4OXku1CcHsqj8q98hYyBtsc6oZ2/IZgGgTFzrYuPMi5CXKSkqR7vMGYT1QkggAPu89lbcQWgWvEw4g4WaxpWdJn2DszHCMEtbGz3Sw3R1xjDZcsFfnb03qaRQE6sJpOjk6fVZ1ylBlBHk7S2vZdtURY7YtmPVtMs7S+4+jxsKfUbsylVyMTzWaRsbbm2wWACSgR93wYW5ZD5O0MlK13in8iZcWyoeg73iNCQtZBigs/LAeg0JQFaRTcyE8soh8Ervx1ROeKSaytubosB9+5ZNcm30XEQ4vYhNhu2K6lJ9cBhRi2EmbnzheXBoJ/p7/CKUPMhEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(230173577357003)(230273577357003)(82310400011)(451199024)(186009)(64100799003)(1800799009)(40470700004)(36840700001)(46966006)(70586007)(40480700001)(70206006)(110136005)(54906003)(316002)(2906002)(356005)(6666004)(36756003)(478600001)(40460700003)(8676002)(4326008)(8936002)(5660300002)(7416002)(86362001)(2616005)(36860700001)(47076005)(41300700001)(26005)(921008)(83380400001)(44832011)(81166007)(82740400003)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 09:29:48.4186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de510556-d2b6-457c-3925-08dbe74fbe56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ECC feature support to Tx and Rx FIFOs for Xilinx CAN Controller.
Part of this feature configuration and counter registers added in 
Xilinx AXI CAN Controller for 1bit/2bit ECC errors count and reset.
Also driver reports 1bit/2bit ECC errors for FIFOs based on ECC error 
interrupts.

Add xlnx,has-ecc optional property for Xilinx AXI CAN controller 
to support ECC if the ECC block is enabled in the HW.

Add ethtool stats interface for getting all the ECC errors information.

There is no public documentation for it available.

---
BRANCH: linux-can-next/master

Changes in v5:
Fix review comments
Change the sequence of updates the stats
Add get_strings and get_sset_count stats interface
Use u64 stats helper function

Changes in v4:
Fix DT binding check warning
Update xlnx,has-ecc property description

Changes in v3:
Update mailing list
Update commit description

Changes in v2:
Address review comments
Add ethtool stats interface
Update commit description


Srinivas Goud (3):
  dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc' optional property
  can: xilinx_can: Add ECC support
  can: xilinx_can: Add ethtool stats interface for ECC errors

 .../devicetree/bindings/net/can/xilinx,can.yaml    |   5 +
 drivers/net/can/xilinx_can.c                       | 159 ++++++++++++++++++++-
 2 files changed, 160 insertions(+), 4 deletions(-)

-- 
2.1.1


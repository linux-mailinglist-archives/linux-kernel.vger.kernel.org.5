Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8CC7EE1A8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345197AbjKPNk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345057AbjKPNk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:40:27 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C22D6A;
        Thu, 16 Nov 2023 05:40:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpNeiG1fTcGxRYvOL9FkXWthBolzCkUGOa7TthpPxTge01pUFoKsDaU746fTmRijToVPKxBCOdZ9a3GoW+X0O5XLzprSGFMJ/PbxxKm/ArrkrnCoB+Yl94eLILLY/YRUnTvBKhMrdh5MwnT32hOtDYg8QLqaLW7S29cug4ABL80GdAmEQideWXjjVBGAKoUKln3lViqHoxTfCLaXm/Zrk63frLWwoZ6JEOiPwM6WflwuYukZxo/qi/PoZoW2GRv7L6OyuqGsFJPOjGHiCQD4xjusDd7I2tAXSlW553iEdesuQbNlYKjidIYg1Xne5X5ZyP7JgOymNQHStm27GBuVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWW0Iyu4yUEA1f+RICUrUJBFcZQBj1tcYe55vPXlfeM=;
 b=noBwJJPGG/uPzbAEE44UtuzmIR/HIW9WOOchp4Eh/nls6B8TsU0Apz20o6eNWp7ZR3HPwSczfWANW8Wt91Dw2cCEvv3dwLsePba7TMqmauH1RyUh4SfZfEDn4T3yWpsdjcK2E0Ic4IytugvC1i7Csa++tgUMWQeVXq/A2OhpGjVh/muwfatr7zskAbq4zua+pdT3DYKNJKNqBa7QAwae+xyRXwqtHJgHB/ZzHTzlEPZ9fK9tMfqEGMsbkHYWwmfzt/yZDHcCRhhpplYBF0pj9JlQ5hYRfPCKZKSBYiYY2t4ylkdTSmjFF5Lr9Hrr6/2gVRHNXQvLfgNfeUm12S4H7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sunsite.dk smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWW0Iyu4yUEA1f+RICUrUJBFcZQBj1tcYe55vPXlfeM=;
 b=DFF8E0dYhDkWjbj5gS7Yl+errGtwB4WEf1rq5aUXV/Ivse5nLTCquA6/tWUg38O/3/c8bJ+LHs1a0aBh1iT+n6ndfJNSXtoI2JS6pcsJUmxySPJ2g4gmbcKFEp0d4TtakXC0YO+iaMvF4KSuy/2dkSv3kTYZeZL4RgUsGYFdh+w=
Received: from CH2PR12CA0006.namprd12.prod.outlook.com (2603:10b6:610:57::16)
 by BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 13:40:20 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:610:57:cafe::b0) by CH2PR12CA0006.outlook.office365.com
 (2603:10b6:610:57::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 13:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 13:40:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 07:40:17 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 07:40:17 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 16 Nov 2023 07:40:13 -0600
From:   Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To:     <git@amd.com>, <michal.simek@amd.com>, <jacmet@sunsite.dk>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <christophe.leroy@csgroup.eu>,
        <rdunlap@infradead.org>, <airlied@redhat.com>,
        <ogabbay@kernel.org>, <linux-doc@vger.kernel.org>
CC:     <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
        <shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH V4 0/2] Use dynamic allocation for major number when uart ports > 4
Date:   Thu, 16 Nov 2023 19:10:01 +0530
Message-ID: <20231116134003.3762725-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|BN9PR12MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5c0474-e79d-415c-bc89-08dbe6a9929b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CaeOfN9Bx1nZ6IuhKd2GHw33Wm1PP84fUdnpx2IwpfAxiXVk9wBQpVH4l/dDSG3nrshWNbD+Ux/oIRsqg2vSKfDl297MtU1LhCqp0JVpZyX6PYpIXI9U5SqPpLlFYxTvrdJobgwZGakCC7+t802llv78jM5R+cCqO1cXBpa8IwcrD4USrjkAVyuDpItEJzK6YrUhZUMqVnmA4CWo386ms8GN6XrBJUGo25ADmx9aPGWKk5VoNWCJP35ATIVBXZc/BqCVSskS0NQyibDuRaPiUADATRiJ/+VcLjGvW1nrvefoq05fRoJ5J4QkzazTHeCCl6GiFntCAxxR6SqUi5NCfXeSBfY3tSpf6E+0Ss3WVvuvg8/wGy+z1i8Jk7vOkwmmzhuR5UEt1YKKVdY5BfnSAvo55zzYLwl1UK43Xli/0lLrYMggoGkPZjSNNitLaifoDKE1MtrBSLA/v2chS8JFBsGKlsBW+8mlLnUIerHNjo2SRkNgowcufxIkD9XD83mVvYu8EV8CjoG6NvzBMxGWKyWsQbhfli98xyojj6YnTyRxNwqzdoScMYs3Gqp/z2EZGT60gavQx7Qlz4N9AAOHOMdmOHrodPrhTj9szYw1cKRbx0bh91Da5T0YcwLDjVrWT8EeLJoBPGdVAb4S/MtaZD2UvsC67EYuzqIerEZuTQRPoq5MtiYDODZFHgLoBIizntG1wju3+6PbhTy8jErRI01cQXnGqVsO1xCQIg8PHT/NgWCwFMofzjGeGPQMqjK8awuA7Q85s+03l4Z69Zy8Li5r5UvwFbKicSSDm30O1xjBPZAbI0N5pWkLmLktozYIxiWbPlXtDoUQzoSODJ5DPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(6666004)(40460700003)(4744005)(478600001)(921008)(2906002)(7416002)(316002)(110136005)(54906003)(70586007)(86362001)(70206006)(5660300002)(36860700001)(356005)(41300700001)(81166007)(44832011)(47076005)(36756003)(26005)(1076003)(2616005)(8936002)(4326008)(8676002)(40480700001)(83380400001)(82740400003)(426003)(336012)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 13:40:18.5504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5c0474-e79d-415c-bc89-08dbe6a9929b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ttyUL major number allocation details in documentation.
Use dynamic allocation for major number when uart ports > 4.
---
Changes for V2:
Introduce 1/2 patch.
Update driver to use either static or dynamic major allocation.
Update commit description.
Update description of SERIAL_UARTLITE_NR_UARTS in Kconfig.
Changes for V3:
Fix typo.
Move description to above of ttyUL.
Remove parentheses.
Changes for V4:
Fix typo.

Manikanta Guntupalli (2):
  Documentation: devices.txt: Update ttyUL major number allocation
    details
  serial: uartlite: Use dynamic allocation for major number when uart
    ports > 4

 Documentation/admin-guide/devices.txt | 3 +++
 drivers/tty/serial/Kconfig            | 3 +++
 drivers/tty/serial/uartlite.c         | 5 +++++
 3 files changed, 11 insertions(+)

-- 
2.25.1


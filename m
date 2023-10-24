Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8277D5449
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjJXOtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjJXOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:49:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E83A111;
        Tue, 24 Oct 2023 07:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtKqL/cO2yH36hKO5htnc28mAmugTGReSACRnJc5zCYVNJSfAo8h0/Sp2Hzs33Yz47ZNnzgFJLYqCAMnzqeXEq/Gp4nyXIWz1t7ofYaeMDgTGTmUaLce5I0Xg8XlrvHJRsGNdAMB4ZPohDvofCc/Jnk+ij0CmFj42Xo+8iiTGjjEFkOr3qc1WOlv2NaPIKGSPd0+WKQJity4iYLciPAGyACaExB+jLPDeUvnFKL6Gstd604XZKSXsjmVv7mDOu+dOirPPSsNrThj6dP+KPFyl4P7AgLVu6QvkazhFr9aGMQVezYroo9nrSpvELCgdEfloxTwfNGoYTo5K+ite8/aHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLonJK7F+AyNL6Gbtd2QP9D0eJwmTC7Zj7rlI078qLg=;
 b=aRFcB2MMpMi8gSMrJz2Ar2EGLGz4eFyHxKlelQ5rU3UHJF0KvYbXKqrrEeKM+nxBwPiKa1C9jzJejrBhoyWKtgGwHe3eWiLvzrixvqHly3T7h4Qt3UALo7Y4eQjm+h3s6ynFu2YD04PmmvnQ2bExOBvEU/VxzybHH7Bmd3ZOV2BX5LXM//CVOagA9HEgxzPs6IbWTWDdnuIh8+O5LneV1a/h2pN2CGcFo91l132zx4jvSUbqaMtTG0d900R1uTGqh7gy7wsWDrTcqBRymh+EDWimgwXqkEEhL1ruhsfBR5xbDVCtoFMmh6+U32KgV+nCgeMSOkqi1kuoAc2bMy12Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLonJK7F+AyNL6Gbtd2QP9D0eJwmTC7Zj7rlI078qLg=;
 b=uFANhXjQVVNobRk97ikR6ZHZLA7GyaaodAHW0W3ST/tAYterSDLSxETUOHAysoHw8R7QUiP3AvaSfKLV/STU/9iVj4IccT9BEqImc/GKER3EbNlfd8qSfqa8lM6HsrpBRVqsbeoe0s+43k1qeupgZgCPEzxg0TWme3vZKgi+e1s=
Received: from CYZPR11CA0009.namprd11.prod.outlook.com (2603:10b6:930:8d::12)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 14:48:55 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::b2) by CYZPR11CA0009.outlook.office365.com
 (2603:10b6:930:8d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Tue, 24 Oct 2023 14:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 14:48:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 09:48:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 09:48:54 -0500
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 24 Oct 2023 09:48:50 -0500
From:   Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To:     <git@amd.com>, <michal.simek@amd.com>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jirislaby@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
        <shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH V3 0/2] Add rs485 support to uartps driver
Date:   Tue, 24 Oct 2023 20:18:45 +0530
Message-ID: <20231024144847.2316941-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 0996a78b-7324-4c23-6a9c-08dbd4a058f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 54u6F8/rCXJBajw6RJFKgVpTIaocDmzNE6ZTET5RC48q6vIFPUBnHARDljACtVYuGzNi3m54lkVgRxJ0bcKFmek+gMv5NIOBFoG2323P4HrOE7AcF3LOY/zjl5PjXsE7UEvrsTHiMM+57yvWhHiuFrTe3ajWw4o55BxtAmnf/dzKkYTfZx8JXLgdPj93UuODmb8hOiEXbxJ93gXeVRxW5rxOyaFXCp9im+x/K4nF6Fb7O0Wmio+NJ9Ox6NJB4svf29p3bVYXdCo9vQun02mstW4SVXOGSzokrEiIII6xcFBHtRxeemckPK+okrzAg5ObWm03n0pYa8xcu5Q65AkPJorsZFCW3BC/WJDM/tduM0KMtJTL47HdYt4ex4hXpq3IoqpVFTpw29M3L4yJvAX32U5dGwona+zfp0AptqF2gGXpAbw3/hgVG4n/0pQNiksFc80AB2Iaedz1kfv5hQcPHRhj4r8sYe7UFns/FYXT2D0PBSGjVr2WI1qc+/O+i9gm39BVkLZlMTmmg5TK9SuyTBb2A755EUCQ2zBIS/wioMxlV1Yi2s06he6yMWJQv26P+k8iuAVnDZXuADeBtA07csZF2btnU2F7HlirndXWhJPIYJhplPZ4XFNneY60uRjXRYhiIpyS2ucBaeTB4mOmhIT9+nmaGHcer3oIZewndie9/2sTZg68rTLofvNBpdVsiHbZCGn2C+81XBiRsd8x649ub2lkR7oA3c5rKTZsKX42qc+RPtboCB1hzehhu94BC5tETzi2cN8/6ryOfpeHEdGWfTIzTAVXspFO+TTb81I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(356005)(36860700001)(81166007)(36756003)(82740400003)(6666004)(110136005)(2616005)(26005)(478600001)(54906003)(316002)(83380400001)(1076003)(70586007)(336012)(47076005)(86362001)(70206006)(426003)(921008)(44832011)(41300700001)(8936002)(4326008)(8676002)(40460700003)(40480700001)(2906002)(7416002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 14:48:55.4454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0996a78b-7324-4c23-6a9c-08dbd4a058f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional gpio property to uartps node to support rs485.
Add rs485 support to uartps driver.
---
Changes for V2:
Modify optional gpio name to xlnx,phy-ctrl-gpios.
Update commit description.
Add support for RTS, delay_rts_before_send and delay_rts_after_send in RS485 mode.
Changes for V3:
Modify optional gpio name to rts-gpios.
Update commit description.
Move cdns_uart_tx_empty function to avoid prototype statement.
Remove assignment of struct serial_rs485 to port->rs485 as
serial core performs that.
Switch to native RTS in non GPIO case.
Handle rs485 during stop tx.
Remove explicit calls to configure gpio direction and value,
as devm_gpiod_get_optional performs that by using GPIOD_OUT_LOW argument.
Update implementation to support configuration of GPIO/RTS value
based on user configuration of SER_RS485_RTS_ON_SEND and
SER_RS485_RTS_AFTER_SEND. Move implementation to start_tx from handle_tx.

Manikanta Guntupalli (2):
  dt-bindings: Add optional gpio property to uartps node to support
    rs485
  tty: serial: uartps: Add rs485 support to uartps driver

 .../devicetree/bindings/serial/cdns,uart.yaml |   6 +
 drivers/tty/serial/xilinx_uartps.c            | 180 ++++++++++++++++--
 2 files changed, 171 insertions(+), 15 deletions(-)

-- 
2.25.1


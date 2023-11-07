Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3247E47F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbjKGSMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343901AbjKGSJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:09:01 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8562A8F;
        Tue,  7 Nov 2023 10:08:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7Sl9otDKet0IbnhOBQH6Wk9DQzzx2vqtRFdZYg61JIYoUMxd9xl7yo2dzmTgwYNrPh4hXRiMGHSHNyH5xMUcpOxLuZZEcLNzC4is7f0z9GUH5GuFw25wjAnUXwd4jkhXra8iqu2hUN2qlaNvTFQ/z2DmwxiWe6Q3yZ4PJYuc0KDJPi0jrCc+4m4zhXxxcrKoPasbKiPG/c1rQRqkAjnJzdlmV+3ZtwqF7WfjtdMjEYlMVEJja/3YfqtU27PHsICPxkeN3/RwV58+wFNOHTqmBF2abo3mvzqCOcK4NhuNP2ewbuzTnmQR0jLvPNYi3tIYd9aHBmxCe+ik+kmbMkcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4mRU53y0dqC3uaRoCbDQ1YkAjHv1Pf+rCTKVce8BIc=;
 b=jp43SYwOG9Th8HfvYM/zo6RJry5t7OoelwchQMiZ/ZW+DCYA2qOta/rGW3+oFRWH+5Q7j3/gN74KxTCQzB4uZkh0d8ILq7KoBudxiWbl3pmcpQ7ZWUfGy6B7F/qYO/oGvnuITi0+cKnFDEhWQr7dhoSgLBBn8/h9C4xo4ftBmj60cOjou4RI59NMWiSJTJaVDRPEuTHP69wT96KWJBAbKhevmw8umEozQo3x4Ea5TmhyOVyR1WsA3/XHWC6aKNCt0ypos83TNRcvGkFvTOgk+RYrclwOJhkkM+DaB2Tx8HpZOthM8LFEibWFh2oRgmeVCGbl2NOtjm9pwDtsEw/o8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4mRU53y0dqC3uaRoCbDQ1YkAjHv1Pf+rCTKVce8BIc=;
 b=P9Hf0Bt/d2DbNjKyNJ4xFNO8gdF/aS0yEEeuP24H795INAaJMqmoBtGQQyQryp9KTan74TFNX3OggzY6VTQtQtl8oBRctpGnZ6HjGJfoxFzQ5LNrpktq6Bl2HmNxqSevGT0jAjK53jzGFDgbjavGy8VM90i/77P+HtLU+lkQUOY=
Received: from SA1P222CA0183.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::7)
 by CH0PR12MB5252.namprd12.prod.outlook.com (2603:10b6:610:d3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 18:08:54 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::55) by SA1P222CA0183.outlook.office365.com
 (2603:10b6:806:3c4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Tue, 7 Nov 2023 18:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 18:08:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 12:08:53 -0600
Received: from xsjapps58.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 7 Nov 2023 12:08:52 -0600
From:   Kris Chaplin <kris.chaplin@amd.com>
To:     <kris.chaplin@amd.com>, <thomas.delev@amd.com>,
        <michal.simek@amd.com>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>
Subject: [PATCH v3 0/2] w1: Add AXI 1-wire host driver for AMD programmable logic IP core
Date:   Tue, 7 Nov 2023 10:06:50 -0800
Message-ID: <20231107180814.615933-1-kris.chaplin@amd.com>
X-Mailer: git-send-email 2.42.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CH0PR12MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: 70cd50d2-8d67-4a52-4cb5-08dbdfbc9a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xx8JcdCcziLt2SPe+LGhxM04lIwBGz31GoDWj+d7MxKsoYXiAuYkzyyfazXjSP/G1DPVB75rSEB8oVyRsIETZW61GfeIQ/vZ1KaZcIWH4xEqoP17Ki8DDJbhgdqwNCn36HNU4hFmKUWUHhSwSkk5x8JC5Q0D6XY3SOzK1ATCftA5AmknsVkj7q+Rp4NFoe2MNxQIDOB5H4p9I/UuaKLBX/DeBHxxRF8WBqrLqMcUO9yy8Hoqfp7IA5Lr4VscEjnO9rYuTQDlZOg/spna/1N/VNXTLxaqdR4EO7yhMWuDFssgIEjI+kKmh19zEssHWLMfE3rujPPE/cjjnNGnISnSiDR/JiLc+JM0AAczZGY8+B2CeReiSvV0zpNG7Z2SDbRp7j+EO+I2WdEANb8f5AoCskjkapyPj2xY1vBN2K6OJ5UJNW3r/hYGqV+eqGrAAnG7UYk8xlnYD8KEEJwFgOeEFDIJpJufstzbgIpiGmTZnWi6cgrlT8IuZZ9K3QYwxAc4QgvSyOzm7f2WI3hiQlTTRnIkQbaZthe7eHAuOcUBhW25HABg9QU7PJK3s3t2eqwI6G4BodEsPdSbILw1jmrD0eQLhtA/Po6A5XGt5vvWaPkJNe+jRja3hpLJVmLodUSljhtYErhV3a5FH70DQQ5lCTn/IRF8DA1dbclGSM1WIxanpMUglG6+uLt+q5k04WtVtHnrpQjDW7iIPiiiEJkUfOAAuViUvFYkxFbr2EZICfIGVPNV8Ee3zpbR5CHC14rHzSzkmDodHsTkco8ZAbt0Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(83380400001)(36860700001)(47076005)(36756003)(478600001)(44832011)(8936002)(4326008)(86362001)(41300700001)(8676002)(2906002)(110136005)(356005)(82740400003)(316002)(81166007)(70586007)(5660300002)(54906003)(70206006)(26005)(426003)(2616005)(1076003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 18:08:54.0590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cd50d2-8d67-4a52-4cb5-08dbdfbc9a74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
 Updated binding patch commit description to specify that version is detected
 using a register in IP.

Changes since v1:
 Updated IP name and binding to axi-1wire-host and filenames to match. Comment
 pruning where operation obvious, additional comments where not. Unwrapped
 helper functions for register read/writes. Removed un-necessary device reset
 on fail to add device. Fixed duplicate clock disable in remove function. Move
 bus master structure to per instance. Improved hardware testing with multiple
 w1 instances.

Add a host driver to support the AMD 1-Wire programmable logic IP block.
This block guarantees protocol timing for driving off-board devices such as
thermal sensors, proms, etc.

Kris Chaplin (2):
  dt-bindings: w1: Add YAML DT schema for AMD AXI w1 host and
    MAINTAINERS entry
  w1: Add AXI 1-wire host driver for AMD programmable logic IP core

 .../bindings/w1/amd,axi-1wire-host.yaml       |  44 ++
 MAINTAINERS                                   |   8 +
 drivers/w1/masters/Kconfig                    |  11 +
 drivers/w1/masters/Makefile                   |   1 +
 drivers/w1/masters/amd_axi_w1.c               | 395 ++++++++++++++++++
 5 files changed, 459 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
 create mode 100644 drivers/w1/masters/amd_axi_w1.c

-- 
2.42.GIT


Return-Path: <linux-kernel+bounces-961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB68B81489A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6781F23E22
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2062D046;
	Fri, 15 Dec 2023 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dESna8OA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48BA2C69E;
	Fri, 15 Dec 2023 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJUtQdHXF9spiIFK0fKWkEc7LVHkaH0FCWEqiPx/LMbQ4OoT6Sok7DJzNTOUlMmp8pXYLhHjWdHPS2kO68zfL+exlzU6XMd94f+NoPkDzWRz4BawWRwKnAKMWNzCiANFLW63U+1k6QTlClgd5r0T8x3t32HZfyZWjhSpYQMt3Uac69BFsL+kSuZel+h/N1h/OURqQKZAZH5VlpYIAODyqvnHmFKWewTt+o7ZV1H4+3cN4Cszg+N1QMAbTYOUyDM8AyC3MAhapD1fPCxwragtuGe4vM9mDcOIc+WxWxY5yQcK3Mlw/X0ONqY08zkKNTQ9WL5kyReIraxaMcU9KGWMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pp+uVqdx3/A+HL0vTh6BiMKiR14oJU28unK0aiRH9E=;
 b=ogWeJ1UoxLk79cU0vsy5Foc7jnVpFDEQHzcHEhHPLMGF2lYwZo70TD5kXLOL/aJv14O1uRLgPMXaXdjsz9FKuNoot+rpHyGE22FbQd9TJj7eY/onYPoCCqmUrfF+KfU/+RsZbnuuCGYIu1EyonxA33o32cS8Ro+qnjJK67FoG9CemnKRuJqKemoHr05yq8YDLM3aYKAydaU8NSOc19siBngyzK57wLxOmKJ0Oebcz1O+bX8UBfnu2dzGPjDGrijhqkIVeNAk/teu0wsj4wD9dnj8h8u5hJRGkk9Dd1eEQ5VfvUVhoq1z+FtCjIbtHbh030+FU0ECHN1vyMQz+TP+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pp+uVqdx3/A+HL0vTh6BiMKiR14oJU28unK0aiRH9E=;
 b=dESna8OAFbchxCjIE+7m8Nfe8xhJ764ODa+fHh7Zbd7aK4cBYNIwTlqXYhER9FY3/sbUj5e/dsVJ8PUgYZaFrgmEvUiJ5c1BOLGuO0KvK7WzSZY6iSMLB4LWbLqkLcB/R2dYBFqaqoF90jtJoVN67QyX1OWO50mzS+QMmFN8OBs=
Received: from DM6PR14CA0060.namprd14.prod.outlook.com (2603:10b6:5:18f::37)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 12:56:51 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::2c) by DM6PR14CA0060.outlook.office365.com
 (2603:10b6:5:18f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 12:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 12:56:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 06:56:39 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 06:56:33 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 15 Dec 2023 06:56:29 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V6 0/3] Add rs485 support to uartps driver
Date: Fri, 15 Dec 2023 18:26:24 +0530
Message-ID: <20231215125627.1691573-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b33426-d34a-4d1f-2e57-08dbfd6d4e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZFyHX3Sw9t6X9H8Jef/nHvn8JRD8LBpjoTFvgdRgm0iY13TBZ3kXSeZDWi4rnUTHt/5yG629YzvW3Hjy7JXkWYxTXP/lRSQiP7unujWXNVhgkqsGFTN78uTSIcJf9wLNBaszamaOpNcaLVA3IjZN924G8Gpqs5+TrPqrgvtN8bEQ63vUlIIn7p+MIUEKUQJeyTilrMPs5xlDKjIdrd+FPAoxcz/7R3MuMTjwI6Y1nGGdZqUZFNYGnh/ZP1XRktvy4YRa+/F8rFkpecN8uMlzcj7mH5PZWlZdGDpanfJ7lcwHbzML0+S5j3e0Z5aPOl8kfLxBgktAzTddNNZhjTrPJTBZfzU4wb4mPL31CcGGdVM1dFc69VeBCLG7L0lg0whI6/oK0DmM+85J0FWSS8UC7x6ePrGbZb5dVi1eZ1eay9lKTfm9jY2ebRiAvQk3TLKl/6+gZaMhutRpub0Tb6An2oxhI/gqPGG/NqKGeO82NdcrSIssi28V8qDOfm/lflUdF57QIq2dvYB5IEeu6SarEpInBOOZtzM79vBsLbCasi8UZAIm2EKJCBG+12zWRvXncEKQFylXV/A21lWWqo7Or0L++KQcYeqRZ8xsAxtkU7hdqJ7SiNJGtKQU6ytK2ZlzHth+jPF/huXznaDr0EeQ2yDcXv0xaCOy517ZJHJIfT7DJep1d2lCKO+6sCAAHSvZR3HmRk7yoxdsdF5NRHQBSOMVWS1TYd36+dyHLI5MWQu9DqN2HF5OZ26zthqRJXygcdZOdx4dLPQbM69gIUJ9ztUfVTCsKivCzWP8GF5xJ6g=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(36860700001)(47076005)(81166007)(356005)(82740400003)(2906002)(7416002)(921008)(36756003)(5660300002)(83380400001)(336012)(6666004)(426003)(1076003)(26005)(2616005)(478600001)(54906003)(70206006)(70586007)(41300700001)(86362001)(110136005)(4326008)(8676002)(8936002)(316002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 12:56:50.7399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b33426-d34a-4d1f-2e57-08dbfd6d4e36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

Add reference to rs485.yaml.
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

Changes for V4:
Update rts-gpios description.
Create separate patch for cdns_uart_tx_empty relocation.
Call cdns_rs485_rx_setup() before uart_add_one_port() in probe.
Update gpio descriptor name to gpiod_rts.
Instead of cdns_rs485_config_gpio_rts_high() and
cdns_rs485_config_gpio_rts_low() functions for RTS/GPIO value
configuration implement cdns_rts_gpio_enable().
Disable auto rts and call cdns_uart_stop_tx() from cdns_rs485_config.
Use timer instead of mdelay for delay_rts_before_send and delay_rts_after_send.
Update cdns_uart_set_mctrl to support GPIO/RTS.

Changes for V5:
Remove rts-gpios description.
Update commit message and description.

Changes for V6:
Update commit description.
Disable the TX and RX in cdns_rs485_config() when rs485 disabled.
Hold lock for cdns_uart_handle_tx() in cdns_rs485_tx_callback().

Manikanta Guntupalli (3):
  dt-bindings: Add reference to rs485.yaml
  tty: serial: uartps: Relocate cdns_uart_tx_empty to facilitate rs485
  tty: serial: uartps: Add rs485 support to uartps driver

 .../devicetree/bindings/serial/cdns,uart.yaml |   1 +
 drivers/tty/serial/xilinx_uartps.c            | 252 ++++++++++++++++--
 2 files changed, 229 insertions(+), 24 deletions(-)

-- 
2.25.1



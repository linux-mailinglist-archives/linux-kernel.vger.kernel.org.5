Return-Path: <linux-kernel+bounces-3263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAD0816A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962731F24428
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B141125A6;
	Mon, 18 Dec 2023 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kBy4/w6y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E311111A1;
	Mon, 18 Dec 2023 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGWHZnx8DSTpjC1sAv2f+dmZY0yhbSWGA0/knvFQsk12d7oepRv7Obh5FsbF+ttBDuDvsuD1MHmJEtQ3p6bK/T8ztb3Hr3STe5DW2eWl5dzuJLWKCkpT4Oca+7y8mvAXazzOvtUgEOJa2EGo4rWEYfHRF+WX8WXqdbYQ/0qYeksKDFrvoQbENKUScwTO+hquVbsQnQ8M5XG4/zjYY8rYfJ+pIMZOcw42ZSeUE6KS1Ek5R6DEXZLlqn6Iz7DH+L0ZcztGph8Bt4cwOFCnvlUsquR25x8Vtaq9J6N3cU1XmoBy1D3dQXk8Nvt7YWxHcP5kAHBg90bacO7ZvecaMoCZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XoW3fYs4bwy9GGWQ7Rz4sujnt3Vr/Lr9djlf/teSQ4=;
 b=fXfNcJrWdgmJ4ydrQmk6axVjrnBD1Obk625hIIKMvjF4cCpRM7rWmqOUZqx4g+Q1f+pHLHaT57V5sTn7dkl5XuZ+W86aKcjmlZAdY65JV6OxiymhJ0U0mvu9P0lWL9fWi44eQ/MdYuQIOdhSN74i0FeyQaUUjK805mzZTSO9EKdvAT1G1eD1UW9yWLqj82K7tGx4SU4QewyJTStJ++RvgRGfEcbbWdZOSwZkkYZ69v0owREkKTz5aLH+iNkbMNuhp68uef5U0k+od38SLTOQ8fK+hArDU6jc5sg5TWHO4KnRF1SjVX6whv0zUO2SlVY76IQq0ds+/POAMt5Evv1jqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XoW3fYs4bwy9GGWQ7Rz4sujnt3Vr/Lr9djlf/teSQ4=;
 b=kBy4/w6yUlFa73VKI3yMQDG0Is4/z1YW+eQVZIlpbJxxJjb9ah6T/JxJqsGCPdKZd/kfnqwosPBYkInos+Uc9yuvbJs91jJBHArxsnff+ERC5NK0+eQJVwYd7pdwSrkQT6XyTLPBD5Vg/sqebaNF8fP0Yum8ubYiAVhqQQSk7Hk=
Received: from DS7PR03CA0050.namprd03.prod.outlook.com (2603:10b6:5:3b5::25)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 09:44:23 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::e7) by DS7PR03CA0050.outlook.office365.com
 (2603:10b6:5:3b5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Mon, 18 Dec 2023 09:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 09:44:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 03:44:22 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 18 Dec 2023 03:44:18 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V7 0/3] Add rs485 support to uartps driver
Date: Mon, 18 Dec 2023 15:14:12 +0530
Message-ID: <20231218094415.2503672-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a421ba2-ace9-457c-0422-08dbffadea74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o+X/BIakESu6BUuf/FXDb+eyUuQGxJRszImSaImVnKno6z+QNHFExR3NLmjCGiHm1FzvEqVNQcImFeJMJ8cgduf6naHY2eQV0lzeV4AG0T7rKVKJH1AbYZIYhjrrti46hQRZ+PFmwZjZCvpOTkBagPneGZUL5BomSDRIwqjfzcAZej8b+ERqFH+VNuQJ6blAOrz5hxHHTmi8pQMbUKvkAA6bih9dC38Yjiw6k+3yY87TJkAwTFlgg+YnBbveCMPtiDGjeaj0skMgiZylFpBqhg4GvF9ZS+x+BPT0r9BDQf+jj9GH0RVVT91g3t5ICqPzpoJRFwgQ8QnYxG/0rskrJmV7Urq7ElSN++mAR5Blg9NG73B9nSIfSjPfcQHesjJMrJqqmya5y+Zo7Nn5DRM6TK5aZW79U/iqTe+2+l/+Dkcu0qByZEOG4svH5FodYrxDI+Lt0Uy3C7x/CMKTTGVPidLfy4t2eSLx+nvXbLNncD2QAlYxNTrNdAfbUxZPLI+3dcalajfY+Ft1ndg9cMPjnyVKyAApgtXhBknriO/A9vQz2ad1Jz40JXTizHLTavpKjtrl5jhwCPxe6wK6CyzQjWQkwxU7i4q5kRN0TwBxQiTbIG7thQaUfRe32gjy6J4AWz0SDORbKeoTRRj2D1ML4HEXlWDJzRzWwmAsllmhctJd1hTHXrkEmG8WaP/7KXSmNQw9Fm693SJarJnybE/o9a/vsmZ4di3We3SIn5F73Un4O1mp7IqVu8MsXBB0EZQWO7LkyKlTr1M2ijKOvW5RDzTjQOsce7b9NVZKKhqxdrk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(46966006)(36840700001)(2906002)(36860700001)(7416002)(5660300002)(921008)(41300700001)(36756003)(86362001)(356005)(82740400003)(81166007)(70206006)(70586007)(426003)(336012)(1076003)(26005)(40480700001)(2616005)(83380400001)(110136005)(316002)(54906003)(478600001)(6666004)(40460700003)(4326008)(8936002)(8676002)(44832011)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 09:44:22.9860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a421ba2-ace9-457c-0422-08dbffadea74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993

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

Changes for V7:
Update commit description.

Manikanta Guntupalli (3):
  dt-bindings: Add reference to rs485.yaml
  tty: serial: uartps: Relocate cdns_uart_tx_empty to facilitate rs485
  tty: serial: uartps: Add rs485 support to uartps driver

 .../devicetree/bindings/serial/cdns,uart.yaml |   1 +
 drivers/tty/serial/xilinx_uartps.c            | 252 ++++++++++++++++--
 2 files changed, 229 insertions(+), 24 deletions(-)

-- 
2.25.1



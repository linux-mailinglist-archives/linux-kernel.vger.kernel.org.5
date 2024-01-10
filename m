Return-Path: <linux-kernel+bounces-22049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A00E82986C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28751C25683
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0FC4778F;
	Wed, 10 Jan 2024 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="it8f+H4q"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9A347A78;
	Wed, 10 Jan 2024 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YG5p/mqxzOyeU1bCWqf8fEcygmAwpjzX4u6cDtqa6dk2u+V6HHypjjjaf/v3Rwe7g3an0FewZ5jxs1wqRsoiSv0z4cvSOy5ePb+/Eo8+yiXKlIcWZnzNqUkm53BhmGn6xuDHN0qqPN/UnHDTXvg3SoFbCQv2XDsD38H5+SXLxOqFSiPWXuo1AHo9vs8dC9q/c89vHnH8ypk5RMLvOa+ypofEfe+yARR6E+0hrbhS7CyUVAYvT4LAZfeKcj4o5uN5gSjnn6A9Yw8fKFyZBI0gS7KQBZtkH2a6SoLT7xA3D2gPjcjgAlDKtAdi7KoPoJB5jv81Td5fRIDPjuE/34nJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtkApiJQ7VPIz+Veqy5BeL0QJwsccGWIlv493zV/cfA=;
 b=oYmkRVV0TI17K4LB4Hq5PvR+b2wbc5yf5DcvJI2P1GcWWbLC1f9o8nYdldoLs3oHeXn2QEkeEQgQU0AHwnnffle2/xUJ/QbIlEqU3sK+b3B7fFd3+wJJzI1SIWVv33DQCulTIgXOT+J32yRJuUxp3H+sV22rRAZ+HP0MXs5HfWnxXzNp+p/pbAuWbhoZ9WLpqsroKiLZu1Gnkupiu4vGL0ez394Uc5UBl1qDiGLSE3cG5mTehMQfe//Gy4BpfM5uWLk+mDnTcrP6mR/0S2TDRcEJE86X+yuZvNG6bqjscK5cd85guzml6azgcUTxRu0D90xkDzr8WmqIjEwyqeF3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtkApiJQ7VPIz+Veqy5BeL0QJwsccGWIlv493zV/cfA=;
 b=it8f+H4q3wUyJc79cHaQb7ceefgIoip/qncV9U6LiN0BoekCJxesVVYzvvKm8RP75IOXyEMXRv+WSlROcIFJN7+sAqeSCf7Gno708W+HMyV5T8MueVEZa9T3qt49SGc04CDhQYijkuRUM0FeE7SXkJ5+hqbP/p9EnpMe3ABhTBY=
Received: from CY5PR13CA0020.namprd13.prod.outlook.com (2603:10b6:930::28) by
 MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 11:11:40 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::3d) by CY5PR13CA0020.outlook.office365.com
 (2603:10b6:930::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 11:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 11:11:39 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 05:11:38 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 10 Jan
 2024 03:11:15 -0800
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 10 Jan 2024 05:11:12 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V8 0/3] Add rs485 support to uartps driver
Date: Wed, 10 Jan 2024 16:41:04 +0530
Message-ID: <20240110111107.3645284-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 74652069-a780-4561-f571-08dc11cceb35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BqHmhnJGFn4medeMtKkq5AiYBoS5lr70QKRYXPBgmUUtbM74sWNleUTlSJPXJMWzT6ZKM1j5tIkmRFOV6L1hfA+d9AtWkqyiXO+NSkM3Us8qv5qI6Zh02Ri+fQ/LpRqMJJmhQDKqmRy7M46RyotFOLaKwCV2ZUBKAOLvCe4JSt++SzB3O5uWjlZyQ7OFV2gt7DR+bugbiEoOtIiXkpWS0OGgkG7tL7xs+9Re0eYdIahozEOm/e5OMjY2OG79o+iCpSgHnRc+3Gt642EShngsMJnyUEPfxsIsApnUx0+w/5nVU3vc4bfw6YNt1KcT/srn/tG7qmK1w/ZVGjA3nhsS5JTdQzzW5tdirTQuHx9WSwSJm6Qtp7Seg9KXayN6paO4lgnSqGQykRwOsv0XR2zn1LidxOVesxNEHhayth5WkEpYEPZGqV8d86Ht2GMitj2PoLuyv5NCoaZzbDLy6/Yd+9bZOv/n4FVth4tuhLnrRNCqPv/+qodg0/lF5GRb4s0ia0LUskzgkrW+oOQ+iFzQEcoGNnLajiYKIciflACxdW2LiGMZ/8bMTbPgv9xqkP9xBOJj4dOU/Q70QG0DDr+UuvMgQtnXYEYProGY9heOhzCruLULnbWiHZQjSA6L6/JK8eqt1ZL/RPkU2vQQvzOL/eeUV7qY75XzoFcnI1QoTTozs6oQ0QPiuOczRmtR1abKKcnvoPqzDxwnPncbnlCbxPm542th7hfkfCIVKj/BnJvhp1MGdHKqPEJgVrTja7nQOzfINWuUfJ+NB1jpAxPK3otPiViLASLH68rISNktEus=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(83380400001)(921011)(336012)(316002)(2616005)(426003)(26005)(1076003)(82740400003)(36860700001)(47076005)(4326008)(8936002)(8676002)(7416002)(44832011)(5660300002)(54906003)(110136005)(2906002)(6666004)(478600001)(41300700001)(70586007)(70206006)(81166007)(356005)(36756003)(86362001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:11:39.5856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74652069-a780-4561-f571-08dc11cceb35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666

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

Changes for V8:
Use hrtimer instead of timer list.
Simplify cdns_rs485_tx_setup() and cdns_rs485_rx_setup().
Update argument of cdns_rts_gpio_enable() in cdns_uart_set_mctrl().
Add cdns_calc_after_tx_delay() to calculate required delay after tx.
Add hrtimer setup in cdns_rs485_config().
Move enable TX Empty interrupt and rs485 rx callback scheduling part to
cdns_uart_handle_tx().

Manikanta Guntupalli (3):
  dt-bindings: Add reference to rs485.yaml
  tty: serial: uartps: Relocate cdns_uart_tx_empty to facilitate rs485
  tty: serial: uartps: Add rs485 support to uartps driver

 .../devicetree/bindings/serial/cdns,uart.yaml |   1 +
 drivers/tty/serial/xilinx_uartps.c            | 271 ++++++++++++++++--
 2 files changed, 249 insertions(+), 23 deletions(-)

-- 
2.25.1



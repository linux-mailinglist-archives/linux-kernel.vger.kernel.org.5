Return-Path: <linux-kernel+bounces-29773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 437BD831339
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673D81C227D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20292BE67;
	Thu, 18 Jan 2024 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YCwsSkn5"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61BFBA22;
	Thu, 18 Jan 2024 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563631; cv=fail; b=F4RSZbCIpCNg3zd0YZJGtCWyeuXwG9u6hL+WE07N1iVGfY8myGgzQaAKKHr+JSwr0eJDdm1lz333Mc0q9R0B1Q7oub4XjZ40iURpKWrYwtg4PGkU9/3wpyNLQuTpx8SgRKkHy5qKBPbuFNtX7xpE+/nRPf6SBtPB3VA2N4MSmls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563631; c=relaxed/simple;
	bh=ObdAGXl8hDVKweTPjf3F2NYkEQQcupd3H9Ba+DFMVpc=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=MUEuEEQUkeGYbN69fErqRnw40XLnpCSpD5xm2htiipobAyLt/XvWoZBUKuhvrEjPjl5iRfKHQ9bBgMhUTSD8wKiZ8TswdLqeb3764kcuhTVuTRDb3wFuaKLg7CX4b1isW6w//uCwpt62+7Lm5905TdFvIuKrnVFsOEIhS729njU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YCwsSkn5; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAoEjw+H9USgtW4hf0fcvci1wjFUC48Ozx2borAT873XPekNna8xhdX4oZ/taGAIg912nGSxItdpnlu7rT3yVSJHG/dJcFQbxdoBG8SWZPlIoWmjbBE4kRv/qBh0/jO5jcz8GdbhmGFGXZ89K6yrZ1kkmAoHp5rPLnCkeYiOkysCgAheEql9wfua/+ldX9Zf5P7IOi2O5c0xxvH6+gFwwn8fC+Rs65ugOeL/lastEBAuhZdt2MgiGj/AbpdcOfdyQXXEssdY/1QKYSRvs3AKoPYBiwCLBjKDrOm/MBhg3i8qD/029cSuYjY+q1DfLTX1UzQAiKIY+RwL/9yXPsXCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teFDFgSvfiCUHmISG+d2ssYfvvjIo0dn2SBtI1384Bg=;
 b=JdPLnJgUZVp6yWvtEQPKG6qF+YvNebzaQA77c+PFxJRl4hpFqwRQ8UnW2AiRL1hrbQi4cbeG3Kd7KgNP9bTQMS4eeiEgNqYI167MhL+dOY0xF+0t7xXvJ5CrzGw0oiEKr0nWLsxQlU/djY14rTXMx5IDvJupFe0TY9X3IHmKnsvyCIqys7KDhToZ+5kulMXPT3p0f718+SM2110k+kCLLFspVSP1x9O+vvDHyNVbUgtMC8TXv529MTMiB+IcpXS7fBE7POJ6BeU9Rx6ekOwKBjwczi5ieOQLw2aW3tqLT+l62Vj/cL9E7U9M4ESnD3AMyH2wBC6918qbEbk77ieUCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teFDFgSvfiCUHmISG+d2ssYfvvjIo0dn2SBtI1384Bg=;
 b=YCwsSkn5qv3CndFOrz6jQewhO9njDqq9KPsn5SN/RIiUpCvxW68a8xPWs5NDVDeIugjxSOvCBQ2gHUbZhrezXLcFl81vGzWzaf4GUA7aL8kfixgdtT0oFVogNuk71ZDU3/8vNKkybqYmWcoyz/eQ1Z2UHQVWbCsonCGPdiALAn8=
Received: from CH2PR14CA0003.namprd14.prod.outlook.com (2603:10b6:610:60::13)
 by IA0PR12MB8648.namprd12.prod.outlook.com (2603:10b6:208:486::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:40:26 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::2a) by CH2PR14CA0003.outlook.office365.com
 (2603:10b6:610:60::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 07:40:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:40:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:40:19 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:40:19 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 01:40:15 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V9 0/3] Add rs485 support to uartps driver
Date: Thu, 18 Jan 2024 13:10:00 +0530
Message-ID: <20240118074003.2334348-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|IA0PR12MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2482d3-f15a-44e1-a60e-08dc17f8bc6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lT7gjjeycuwt09Dlwq34hbSSwjAr1Q3+MgSSUfVe3B5gnNC2d8g2MEGoPRW1IZLRtFcyvGz5H5ICuG8jDbuanEz1+yXiTsCT3VVK+DKyJB8Ic/WAJRlwCHILjQdRUA5k9E8qwam0EMa0wasknoGQafeo8mUEIgKTq2/U0sT+KKNJ+mjpG1nrQfxFWd2zuTtPo1E7yK+koBWLOM6ANQe2InQmZ63HJ8CCVcDfG0kTVIQSAPAy8XjZeOZmRSiW/paI+AvZB6Ds3hDYYYYHxrwO7dGV9McpM3aE4jOkjj3iYsHDObR3vyp2MdmkdSk1XR0J7EeyvdGby5z7KQhsZr/A8nCAHT+aX2PUNzDdt4UnC0uyJgnkwwBpInjGvTjwb8hkQVTurzO52qhK9xgFTJJxEpo44RsKSC1TE6iccbpKyDnAZJCxYewnCpeY1D0QE9TLecDYsJdyrMz0ljagJGdhtRDn3rUEvYl/RmnrQlCYRGpYfCuPf8ukwRDM2qfUHkm4/c14KxiW8B+NcnXRNijajNInuk6Q+TTk5bb0QFlmb6OBFaVOfJqE4jg31tD9iBwg7NXAgr1TCMTkcJMo1pASDGKP/cgsbXKuCVXal4UMIbgGZ/Jm3dBZXAhjP7bMvwxxDIkiM8R+AWQVP3NlteywGnZ0DbEfc9/dVcUd7GUJNc91v+5Jmb7t60EMxnXCRARUTWqdF0aXocyG2SmSaXgwy69hTmX0MQ0NJPWmIJzuarFFnTbQ+9vI0w3Rr4/8MSnghzjCVms/BEZYnPclmQBq4DXPCWtsTP7YjlkwX/7XSmI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(426003)(26005)(1076003)(6666004)(83380400001)(336012)(86362001)(36756003)(82740400003)(81166007)(356005)(44832011)(2616005)(7416002)(4326008)(5660300002)(8676002)(47076005)(36860700001)(316002)(70586007)(70206006)(110136005)(54906003)(921011)(8936002)(41300700001)(2906002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:40:25.9330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2482d3-f15a-44e1-a60e-08dc17f8bc6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8648

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

Changes for V9:
Update return check with uart_tx_stopped() in cdns_uart_handle_tx().
Update description of cdns_uart_handle_tx() and add clear TX Empty interrupt
comment cdns_uart_start_tx().
Remove stop tx timer.
Remove hrtimer_cancel() call from cdns_uart_start_tx().
Handle gpio case separately in cdns_uart_set_mctrl().
Move hrtimer_cancel() call from below to above in cdns_uart_shutdown().

Manikanta Guntupalli (3):
  dt-bindings: Add reference to rs485.yaml
  tty: serial: uartps: Relocate cdns_uart_tx_empty to facilitate rs485
  tty: serial: uartps: Add rs485 support to uartps driver

 .../devicetree/bindings/serial/cdns,uart.yaml |   1 +
 drivers/tty/serial/xilinx_uartps.c            | 235 ++++++++++++++++--
 2 files changed, 215 insertions(+), 21 deletions(-)

-- 
2.25.1



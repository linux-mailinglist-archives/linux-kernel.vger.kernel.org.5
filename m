Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B1D80C403
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjLKJMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbjLKJMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:12:13 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B50EB;
        Mon, 11 Dec 2023 01:12:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvX47tTaRbSqBbHH11Wcp/4V/gIBTQei1M6nCEkcCuXf+CvQ5kGwFaYtzZhMJPvXMtC00VLH8HVfZdawx3p52BZ8LSqQGAAbkaSVkPLIfrIRqOzbEvzMAbkbmYdODJ6GTW1cim5U55x0doayVrksxMAhXL2eHwmuEdQ6W1/LJqTZLOUOr8J1W0xuTvKZdbLIG9hvgfOroSKL6Iad69G/sCn3WCEZTSfBk4xcCiw5/bNr8pFgCpq6omzcnpdFebJo14u0UV3gJ5QsouPsi1UftGTxu1ZckiKRA3d8SvGlbPsLFClrZBFB+WgKwJqHzne+X3uwceOHg6kPZTyVqVKT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+gKDeWgzW7wZ5y86lT4ZJtdyxIx3WO+aFyhdw+b7NM=;
 b=Uj7UiRV018ikyXZ4B15ilbyfKoHO7VYoH7zdQTtPA2B+Exb0hwnAS9EmDhWzJ9w/MBWBRo564k+8UuV2DZlYM4TJrjQLAa8IixIsRPXrGG5+HYoji+wfak9dJCInk8wa47sBPMykK66VYH3oxTHK7LTNp+9H0dNZ0adEw0lyN/rcYxt7NKb7ut92ENXfRa4W+8yeEDQjeh43snnOeXw+c3T5N7zOZQtS/4QGVhXm9N9iw4nOtBT56Gk3MN2fCEM1y37/9lFjZ4/Yu9JVZ7EN8syWphW75N/uNKAe1YxwVdLQkWuTG4DeDkP3AueLosAHcAOXEllRTZJdsdgZLtm5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+gKDeWgzW7wZ5y86lT4ZJtdyxIx3WO+aFyhdw+b7NM=;
 b=wLi5/vFknakoD7laVHoZ6F5hG4jJN3zCjtf1k4KqUBrGm8a41G7f0A9F+RsFK0FFjlfDO4qIIWRLcjZXJA+K3NT9Ii3DDGjHCoavyr//ENgmc4SlpWN5ihVO1L3lSYkRKJ6iOmFzvu9pInX0IKYs9WBK9BdsMYQSLEsYMtpgIdo=
Received: from DM6PR13CA0071.namprd13.prod.outlook.com (2603:10b6:5:134::48)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 09:12:18 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:134:cafe::95) by DM6PR13CA0071.outlook.office365.com
 (2603:10b6:5:134::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.21 via Frontend
 Transport; Mon, 11 Dec 2023 09:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 09:12:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 03:12:11 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 11 Dec 2023 03:12:07 -0600
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
Subject: [PATCH V4 0/3] Add rs485 support to uartps driver
Date:   Mon, 11 Dec 2023 14:41:56 +0530
Message-ID: <20231211091159.58564-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: a462d3ac-a0fb-49f5-fc8f-08dbfa294627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qo7akERdEPHX7oOMHu4ap8j7T77DP0+/Y3fAee2SaXMFDMxAW2Cwv6q3ex8cJ3tSKhufEuGLTX94vxM41Kxdc2tiADPapshI7uRsVro4hKTaFyXGkUND+6l/kHhDmGq5VJtOw0U80DlsuIN8nEbnLXkboyiHQxt8RTs1ziAhqqIryJrEC05ed1DCd7/98iKdaejL81u0CzgSq9A4gXW4mv16TrWOl+ld3EogM9hlle/GpP68z6aW7G103pwJkey5SdwzevEdNOMU/FQngE+8D9fSe0VCn0+agdtmQLN3/pD33ptYb6NGQ7Lm4/TmP9EfdOEzArvMTeIbm7WoLIFgCkveg2OWfz7ZaIRwhe+tidALX14KyXvWj+W/k/IusyfR9DHgfjEhMdLDrS4DNRO9FJWGDdVh3RBVJU+vPQvMM5XPfoO4Fl6RdF23M9QrSFvnXrOGs7C52ZI98sKEkfyF5/lvcl+qn0s9VE1LqsXupD+gzABxwoKNKJ1SL44GHKJpc/bKagASQ/Kzb3H7yspozAx3dgCfz2Aees6ofApPc9cogYU8319SAkWeyzaQOpbwpA6POjTvBUjWoNsHnEAhwUONXM+Exqg5Bja+gXRE6hB8Jbb0HocHZGh2R9zEF0soSHfMFwoIeMKu8B8huvXsz7Pk+frogDAukv73DhL4GBb8uKR1TaqeB23YdUplGKDPmsBeNA9vYFTIX2c9zFhhGMWHpGydNam+9tqELUYjf0vHnvMfMiTbHFL0PLJsixmAPyFeaDsMN66M8Rf4HfmNMPUQUo6SD4mpUAmF5dp9aP4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(40460700003)(426003)(1076003)(26005)(2616005)(336012)(6666004)(36860700001)(83380400001)(47076005)(5660300002)(7416002)(44832011)(41300700001)(2906002)(4326008)(478600001)(8676002)(8936002)(70206006)(70586007)(110136005)(316002)(54906003)(82740400003)(81166007)(86362001)(356005)(36756003)(921008)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 09:12:17.9748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a462d3ac-a0fb-49f5-fc8f-08dbfa294627
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Manikanta Guntupalli (3):
  dt-bindings: Add optional gpio property to uartps node to support
    rs485
  tty: serial: uartps: Relocate cdns_uart_tx_empty to facilitate rs485
  tty: serial: uartps: Add rs485 support to uartps driver

 .../devicetree/bindings/serial/cdns,uart.yaml |   5 +
 drivers/tty/serial/xilinx_uartps.c            | 244 ++++++++++++++++--
 2 files changed, 225 insertions(+), 24 deletions(-)

-- 
2.25.1


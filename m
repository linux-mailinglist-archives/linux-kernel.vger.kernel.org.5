Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A2A81123B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378961AbjLMNAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378977AbjLMNAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:00:32 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C81111;
        Wed, 13 Dec 2023 05:00:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nV6uBGZac56hKDvAzExld8fQSQx7Mde+kRbYIYU98SazNI+Ao0xtf2bBLDfBnoZel65oe6XseLce7apM2jtUvklfi1hAmSYayppv7+Rsx00mq1myvfZfpzAqUzCrpmWdtQGJmkT3N4WDvo+2eBz5xTNIQ1ZRwF3qVGyV2ZiIjHxhpc83f2/qWTuQx/V2OQUyQUE+vRfxBEFZO3IG/O+mDIzMmOQbmUy3l+wYClSOPnOOsayPN+9kztErzEfOIn0irDoyIMuSRTwWIbukCjQ+P1eJfTJE1r/f8/x/69zgOh+RikQvtq7vwLq5EV3DI/CPa2+23TrftEBTJf1ivhWiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IjFzzzvWzho3lrTGlNnztCJPd9qCUlvIuKE7281IF0=;
 b=Q7TQfJNnsVSkqiSVJr+FFIBiM71JMcYiMcjEU9aY5J5HHtXTTLrJKnS59GxmULyUU3S6VqyUL+YExTRvL/TyOypkq5hGTuQFE/WTbQfJc8yJocVbqcsdr2vff4LBUNMhiFsmk4Z3UQUUh81I5PfHEZ0EpBxk9N76mse0WY4ptOAXXybC6Cph4Dn2iz5fmYj7mjcqN71YdLP+Ugff3TRHSJP1lr2E7RthWQif3RseEcEHRSH/DxZpDa9HXNPEmVd4xvJIVaZNjpcsWJYmE3+wZuTQ032y2Mug95yyIARf5G2oU1xwfygHhQsDRmrH3IklPj57mGlji+AaOsAu/MTUjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IjFzzzvWzho3lrTGlNnztCJPd9qCUlvIuKE7281IF0=;
 b=hWaCamrZcbctkEk2MpdODRekFbkqR8GSIqJ2V0iwMJpVdiKnA84Cnr2jDBm/Iey0vbRlWgNQRuhshPYvkCr8NWXE0eAq+oBZd7PQHlrZqxcs2wBMvSTlHPMLxIy/0oKCOJ/mnHPh0149VWHNn1ceqGTa45HrGt2aBQFhlcF2w28=
Received: from CY5PR13CA0034.namprd13.prod.outlook.com (2603:10b6:930:11::19)
 by DM8PR12MB5415.namprd12.prod.outlook.com (2603:10b6:8:25::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26; Wed, 13 Dec 2023 13:00:32 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:11:cafe::fd) by CY5PR13CA0034.outlook.office365.com
 (2603:10b6:930:11::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.8 via Frontend
 Transport; Wed, 13 Dec 2023 13:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 13:00:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 07:00:29 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 07:00:25 -0600
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
Subject: [PATCH V5 0/3] Add rs485 support to uartps driver
Date:   Wed, 13 Dec 2023 18:30:20 +0530
Message-ID: <20231213130023.606486-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DM8PR12MB5415:EE_
X-MS-Office365-Filtering-Correlation-Id: 850b581f-43de-4533-df4a-08dbfbdb7da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPZl4MuWh76jUqvT+0H7WAuVD/QAqOQAgcO6rFk4JhTUHTuQkfFj+QxzQ+9Kkklad12mjxOfDGoQM8fAPTW9+P1JYCzRipFkkCgQEtLaFTc4IR6LhZafGuGXG8eQL28mH132zc59dSfE0nEca6H2k9QwQMtChcoy9dvVJwoHgi6d+lpEV3f2zYyHy1LlnzHcpJ4vxMkedGDKtrjN/ykQ9lg8Z+fNAyMCe28Uc1V47ODLdCGct+tlyCjHwZMndjIZyaUeKfr3EwfxiHE2iUxtwJjp21XwFSDLVylTB6fl005Pxhp10I5NLVE5hJB5fol7EZNiTApyIriLAdbPPYGeCLZEh39BLfJH0UjGQvCNm5t+T40yEVDApCkPwyHHCl3gr/cDIddUnKtR5Iz484wRLIyvka+6qpxkjsB6wkF7njvSy7ILSmUuhNWrLhoj1bHwkAg2SwR372obEbUkIIvuf/yDGLVhaL1ZJn9Wy337Z7DH5cGfpigocJ+hmLOcxOc6Lrr52A591xkBBAmVBmfzH/ntYQSyY9+GR+0hlcRUqt0PDZJ0iNdAz+ZKslkSQilFCyrNrqBnGcOmKEs36DZWCOrCG+WYcki2+oi3HLArzqFaRk/1Uj1ATm7y7q16HBzDb2yfJiC4RkGzIYzJp2zjAEzNv7B/zyR8P8ijwadvd1gXntTN0Q8NGg3jvR11fHbIqhNV/yMAEPOiXFBqbPxHn/lxYXO7USfd6rvB1CfHUuouCpGloYFpMohlKHj+G9DeWnj1mPg0xifuMvOyqptd0eosllOAGo9EKMkeBYLGqaQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(1076003)(426003)(83380400001)(26005)(336012)(6666004)(478600001)(2616005)(40480700001)(4326008)(41300700001)(8936002)(8676002)(5660300002)(7416002)(36756003)(81166007)(44832011)(2906002)(47076005)(82740400003)(356005)(921008)(40460700003)(70206006)(86362001)(70586007)(36860700001)(316002)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:00:32.5770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 850b581f-43de-4533-df4a-08dbfbdb7da5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5415
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Manikanta Guntupalli (3):
  dt-bindings: Add reference to rs485.yaml
  tty: serial: uartps: Relocate cdns_uart_tx_empty to facilitate rs485
  tty: serial: uartps: Add rs485 support to uartps driver

 .../devicetree/bindings/serial/cdns,uart.yaml |   1 +
 drivers/tty/serial/xilinx_uartps.c            | 244 ++++++++++++++++--
 2 files changed, 221 insertions(+), 24 deletions(-)

-- 
2.25.1


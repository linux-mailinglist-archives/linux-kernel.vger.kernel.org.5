Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C7A80C40C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbjLKJM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbjLKJMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:12:23 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B5F11D;
        Mon, 11 Dec 2023 01:12:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKCnOefClAjoQ8KlP85C1+HIIviWJE+tFyC/Isg9EZPBzx/o5GbGy4u6unJo44BiiSDg4WGGa3hk2kQJ82lEhuhxKpUlLdNDxs4EACHi1AZvTtKhJDaOyQ0uAaAMqMiOWy6i0BAKDNQPJHjS1/+e3nPRoMS2cEPNYAEDjupiMZB5cIFS8VIVWOYQFK4CHGhmBPhmjH8Q9SrK0k5XTZrXxkMy5/fP9kUXWpE4fLmPnMlplQarENyXe2QmiCgvIDVqyz8Z80nX+L4bS9x2FCXzQFbUlln/4sA1ZH+mOwQlkct2S8ao7j6EUyDvnUC+aSUVLJstoUbSFYOB2BXkrkxnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPuJXr4jFyUZuQzFR2XMlqr4zF056PKr3b0n8ocnNAA=;
 b=csovJb5D8BFbiR73wCNm4MNQmyXUsP8sTPvulOPIQRUw5IAlSSUwmqUioEUyK7Xj9zToABJsAICqNY88myQHsBaUY47TI3vKKW0pgR5IKi+tCEo/1opL+HXOyhUBFplsc9WAs7VYRs2eCbSKMt/o0oY2xUm1e1ukv+tYQuNBsdQLe5eMZrGWIqER3a3QhEonigUmYYzLZN3jHoxQNaV+/7IRRq2Rt3MMZknJWSI7X556V7GR98/lDfvJlEprt626RrLgsfYtSY8fC2t0Bi5IlYuz0pxfdKQd8C8aGh2cTdZPRQXmSjZEE6hKhluQ0jGqTtHND9m9ZvAvrVFQsKD1uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPuJXr4jFyUZuQzFR2XMlqr4zF056PKr3b0n8ocnNAA=;
 b=qSs+dhKPDqJs2pLVo27DwUentFndteJzqDkCoefNzuQD5aUtOitgwq64D/bZiCX07bWvUIwkVX7lWlsKJRkO0ye2exOaqEEIEWOs2mviY0wRQ698SRwwaWQfkV37JpltWp0n3YgVk5tFTUSA5dc8p9Y5cyz0XvmBbN2g7FmAKxg=
Received: from MW4P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::16)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 09:12:26 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::70) by MW4P223CA0011.outlook.office365.com
 (2603:10b6:303:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 09:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 09:12:26 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 03:12:23 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 11 Dec
 2023 01:12:22 -0800
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 11 Dec 2023 03:12:18 -0600
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
Subject: [PATCH V4 2/3] tty: serial: uartps: Relocate cdns_uart_tx_empty to facilitate rs485
Date:   Mon, 11 Dec 2023 14:41:58 +0530
Message-ID: <20231211091159.58564-3-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211091159.58564-1-manikanta.guntupalli@amd.com>
References: <20231211091159.58564-1-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|CO6PR12MB5426:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c88b51-8af0-4d5a-2006-08dbfa294b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIWQfhcetVkz467Z/SMrgKvsQtBHHPdUBJ851mbd3d/H9HSeBjMmv9ySuoXsG27f59fh/gSXKqiVI1GRsAYx0Q5+zUNOHJpApyNOus81ImTLBoY/LANJhwCddTez/EsPZaGUZ9KmpWk0nkXUmy+rKVCB+KB1cn1STb/1dHtZYMjgoLN1BzEY8UJxTVwQDcEblHJ6AGKhlcJAxkBU6MevEL57K19CcGOXDMxFzAq9E07bpHqLAmb/N3ZjSVdt9h+owNOZWknmL0byeCRRiaEO0SFdc9kh0PWUegiXZx4ibwtlzzW5iMUC4JIsnQh7+bExYPYmbdqIHD7WIdBDYDCyiYNhCiitmW+F3VFXnMdQrwhfjx+BKEC1y2z4Of/DGglpbY/anLeYM4l2XFfblA8oO062aHW940fzTQKy3x1WU7CX1TCWsyXHJQnxQLS+CcpXukzemq3pupQhYVih6q8pgK0freU/dZjuc2373EGayDTgStn2bwa13cbBb1gMkxUo4m1dvFYZXjJ5YANAy+4d7i9zEps4gl6jOG11mugVgdmXmni5uCxyXR/klBrvaM4ngkq1moBlCvzlGj6Pj7amqJEpNfwJFkJkqiTVdXyU8hyf6q8k4AF5OzD+WoBVPwXhC53ASGIE5n9vMr2MgeNecIo9CjJnmImMuqUWSj2ZSRCc2ijE88RZNjwDJkYnD/lsgsSqtH5xh596P9aOyn+42Ygs1iw9vVtJrD5WTgzRviQd/XVUMyGMBu1WH7gMEtKiKCM+0RWxkmd428CeC4rXr5/6QeUBFXZMTSmK779cQ/I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(7416002)(40460700003)(2906002)(41300700001)(36860700001)(110136005)(36756003)(86362001)(82740400003)(356005)(2616005)(336012)(426003)(1076003)(26005)(6666004)(478600001)(47076005)(81166007)(83380400001)(4326008)(5660300002)(44832011)(316002)(70586007)(921008)(70206006)(54906003)(8936002)(8676002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 09:12:26.3074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c88b51-8af0-4d5a-2006-08dbfa294b30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocate cdns_uart_tx_empty function to avoid prototype statement in
rs485 changes.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes since V4:
This patch introduced in V4.
---
 drivers/tty/serial/xilinx_uartps.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 66a45a634158..f7fc2de8778d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -305,6 +305,21 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+/**
+ * cdns_uart_tx_empty -  Check whether TX is empty
+ * @port: Handle to the uart port structure
+ *
+ * Return: TIOCSER_TEMT on success, 0 otherwise
+ */
+static unsigned int cdns_uart_tx_empty(struct uart_port *port)
+{
+	unsigned int status;
+
+	status = readl(port->membase + CDNS_UART_SR);
+	status &= (CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE);
+	return (status == CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;
+}
+
 /**
  * cdns_uart_handle_tx - Handle the bytes to be Txed.
  * @dev_id: Id of the UART port
@@ -626,21 +641,6 @@ static void cdns_uart_stop_rx(struct uart_port *port)
 	writel(regval, port->membase + CDNS_UART_CR);
 }
 
-/**
- * cdns_uart_tx_empty -  Check whether TX is empty
- * @port: Handle to the uart port structure
- *
- * Return: TIOCSER_TEMT on success, 0 otherwise
- */
-static unsigned int cdns_uart_tx_empty(struct uart_port *port)
-{
-	unsigned int status;
-
-	status = readl(port->membase + CDNS_UART_SR) &
-		       (CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE);
-	return (status == CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;
-}
-
 /**
  * cdns_uart_break_ctl - Based on the input ctl we have to start or stop
  *			transmitting char breaks
-- 
2.25.1


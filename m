Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3170E7EDBFE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjKPHaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbjKPHaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:30:19 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632C7120;
        Wed, 15 Nov 2023 23:30:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRB8wN2+sttdr4ulM9z5Ig9+dR8eQgZ26hT/6v0dPuhmUmtUXdtFisyFQnOz/ZPPyzzeelmODi1cJadQJizFF1/erhIFFM5YsA/2p4I+oUK2gFQKJlsTcREtR/L9XBLoNzEKKnfgzH6Mhxr8f7FQe92CsZm8OcUSIfgGCdQKEQj4Qo/pAuUqOoQZ+NLhgikYjKA/b+lFel53TNI/ZXS9zdlr/UvplilaI6XxpfXVIIUxp0rqbZ5epbsFKS/hSzsig+1loiDPEYwj4K7UhmxMueiGP/btCuZYx5Gf/Pnqyk8MCSN0cerTL78AocvL1Fwq+Pe8ujMAwspxDWBaUfzgDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbxsJ4nEKinyfe52jtbkxV//9NLzxkjEFzgjHWqEIwM=;
 b=KszHIaklZURYsNeRZo/wVsJZWBV/rHkB4ztBIG17dAqadJXOEUQ5FOOkMIUVYG+j/nE8wTA8s9EPvgyaPo7zYb7htzuZyq/KKPEum8vu/lZIjXgCWpA/Y0oWVNWTV9zj6o85MQE1cw/LvkXW8hYCDbZgpZgr2pwPofRis7JEUMo2s+gooMvr/jjCZsXdNTMB6iF9Ej1UYvUP/vXYu/zmCtHAe/FBrhj8KyGODghnAKI170rrb9nXr3AMwEP6PXpwpFIQ1m2f3jA6suDfIJ8lDZflBQlQXhOBJKgW6IIhGmWm2JJf/x6D/IgPeM4CIaL3IcqNva++JR0uLrW0u6SVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sunsite.dk smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbxsJ4nEKinyfe52jtbkxV//9NLzxkjEFzgjHWqEIwM=;
 b=1xVoe+dZ/QfdhWrUZiG0hsnKyiGnUDLcHJcHZoVPEPr13EWa7Xcu7psf5skh4t4S5NCT3MwLf+MVDNGywHTj8CE+JQrfFFdcSBQtD4oiedDMsnDX6LoA/6nL3htOu03HZOCRt5skgPRH130LO+o19kBgZzHpfVkb5iBjIsRmWMY=
Received: from BYAPR06CA0003.namprd06.prod.outlook.com (2603:10b6:a03:d4::16)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Thu, 16 Nov
 2023 07:30:06 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::44) by BYAPR06CA0003.outlook.office365.com
 (2603:10b6:a03:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Thu, 16 Nov 2023 07:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 07:30:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 01:29:58 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 16 Nov 2023 01:29:40 -0600
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
Subject: [PATCH V3 2/2] serial: uartlite: Use dynamic allocation for major number when uart ports > 4
Date:   Thu, 16 Nov 2023 12:59:15 +0530
Message-ID: <20231116072915.3338387-3-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116072915.3338387-1-manikanta.guntupalli@amd.com>
References: <20231116072915.3338387-1-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 48dbe2ed-f58b-41d8-09a4-08dbe675da68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RVIPCdGAU3wy6NpCJF7PQT8INcUpnTUYXv1NS5xDlYpIXz8lIVzzc7jY+WntJb3JyZiFxWOr/59hxSrx81TLBqBRnlxEAehlF79/S4i/adqz3vHRXviclI1LKoHgPD+cRvcxHC+ohWiqJYLIWZAtwPSyGX5r6HSpGYlMy8QLMl3UPgqWFCMIYGE/6qpKSv95vC5dQXlYCSueVN5XF2gwSFSj+5+ZKV0CsHmsng23+xxGNwv1xFLGGuG+o6UZ4rbllExIW2DHQ/W5iHzuiB2JpxUwa5Ad6yaOVtIXHItDoJIUeZS4xcs0IbTmfl3zlqT1dyHKPoyY+hiCUigB6FrViZVud8kLbhPFMCHlkw9gUgATMzQ+vEpHm5w3WFMZ+Q/DQEpHSnDeQWEo0ukw8vMqHBKnfk9X4X6YzN/E7CuJjQunXr7tP0+I2ZdxKibSZ90+fhJqw7HltFUYG8WKTeB27twNNmPrHg6i8qIOM3O9Wbp0vw8TSo3G6N4AIFC7CsFUsIuJnX0SIUNVFOkG5fxSTDw+j12TA04GC5OTXnsBxkapqt1pv2QfiXX2Fy86itbA3xnJGaSxymNKLOlZ22SdCWIOAs6GkGHfrSTZxm52DVUEdsjAwgU6uKgOhdnWJCQtzItrNbz1RzohWiF3m3MHxLYxUNNW7xTxs1aFlO/JuT0HyUi+RJgikiUkJ0lP1AGgeUV5b5lMJZFQ/UrHhugXq5cZWiHOWwb8CyUOAvhjFcfJXLQXarRVIYaVbhXnXtR9f1jKx4I2gm0zOKH4qUmOwH9V6Tno9lH9TACLaSI8yW2acwMce0zuKCY2ng8zELNOoQw8FDszyfnyC5wD8rNWzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799009)(82310400011)(64100799003)(186009)(451199024)(36840700001)(46966006)(40470700004)(41300700001)(921008)(47076005)(316002)(36860700001)(70206006)(54906003)(336012)(426003)(40480700001)(26005)(36756003)(83380400001)(1076003)(82740400003)(356005)(81166007)(7416002)(2616005)(5660300002)(2906002)(478600001)(966005)(44832011)(70586007)(110136005)(6666004)(86362001)(8936002)(40460700003)(4326008)(8676002)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 07:30:05.1464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dbe2ed-f58b-41d8-09a4-08dbe675da68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device number 204 has a range of minors on major number.
uart_register_driver is failing due to lack of minor numbers
when more number of uart ports used. So, to avoid minor number
limitation on 204 major number use dynamic major allocation
when more than 4 uart ports used otherwise use static major
allocation.

https://docs.kernel.org/arch/arm/sa1100/serial_uart.html

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Update logic to use either static or dynamic major allocation.
Update commit description.
Update description of SERIAL_UARTLITE_NR_UARTS in Kconfig.
Changes for V3:
Fix typo.
Remove parentheses.
---
 drivers/tty/serial/Kconfig    | 2 ++
 drivers/tty/serial/uartlite.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 732c893c8d16..c3c82b740078 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -532,6 +532,8 @@ config SERIAL_UARTLITE_NR_UARTS
 	help
 	  Set this to the number of uartlites in your system, or the number
 	  you think you might implement.
+	  If maximum number of uartlite serial ports are more than 4, then driver uses
+	  dynamic allocation instead of static allocation for major number.
 
 config SERIAL_SUNCORE
 	bool
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 404c14acafa5..66d751edcf45 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -24,8 +24,13 @@
 #include <linux/pm_runtime.h>
 
 #define ULITE_NAME		"ttyUL"
+#if CONFIG_SERIAL_UARTLITE_NR_UARTS > 4
+#define ULITE_MAJOR             0       /* use dynamic node allocation */
+#define ULITE_MINOR             0
+#else
 #define ULITE_MAJOR		204
 #define ULITE_MINOR		187
+#endif
 #define ULITE_NR_UARTS		CONFIG_SERIAL_UARTLITE_NR_UARTS
 
 /* ---------------------------------------------------------------------
-- 
2.25.1


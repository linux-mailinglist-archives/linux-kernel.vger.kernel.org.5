Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83017EAD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjKNJdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjKNJdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:33:41 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F65A1BE;
        Tue, 14 Nov 2023 01:33:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIJzcpP3MqmFMwiE0ghPH5dyD0xwwadjYhLbPXdji0X1QbX378N7Dv6N4yweF5aCHnX0IDkMbGVrCjbnOzUIPyvVszfgAvkRoHBdkpzgTjcVhnaXMi+diD3JK6stJkcB+xjVEPdiJ9fOdLFf+od6Vj2P3BrbzN2IJ71zciJHlQtmOOrJX2ZQXPmOrjXYuz1yJyY5nZzEhGIigNE35d7ynpSN3MVbT/nyNsocu8t++plMzJsLMscDd6O4IKcg7P/9sYxxaFIF9nb+HkIum85wPPNtOMFKw9ZTV104HHmzjkE9J+8/rrx0bCR5ioRC+uUgIgC8qUpcyGR5uZBtzQY8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wf26LuPwMrrCLn4aSWXWgoaHGclFRYNi2o0RKZWR4vE=;
 b=CyPRwL6IRTzA7wIPBl4dzmMowwOsmrxpKhCW1L9KQF2XEwBXoLrQiqmI201Yi81SamNh22o/SvNqUySi45Rrq/tXvf7QoeqxDPKkhLhmz6FrTktfX+eN6fwkLaNR7/N3VkSxRq02yCMe4Pt8K/2mgsR/wmvMd+x4zZIo4We6xp3UOPdphMi4Xr4/TcKfRUIFBXzOUdLa5fVTOurPsNHUHHdc6mqrS4sGdk5jZo8Nb5jxbfBmnbiJWNmopCVZuQKhddiJ+n0oEiMIhZi8uZsyPHJ5pjCAX/P//zn4ccroX5p1xxga2W76mpXOTjpua2EisGmue+aJLtCLBb4cJ+/iaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sunsite.dk smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf26LuPwMrrCLn4aSWXWgoaHGclFRYNi2o0RKZWR4vE=;
 b=Jp29hjQlybwkC3pH1Cba2+Q/BV+0oZ/wbtJ+JJNS+BV3DBEx8KZ6VU4rrTouoteTNNDgr2GUEQerITBdiYZing7Z0I4dwXXKp0z9E7WT4aIz9qQInkMmXlF3zW4o5E6ngBx4tsjj2bkvySuGU2YuIzyW5uJ4ZA4fh14g0wKEyYc=
Received: from CY5P221CA0162.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::28)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 09:33:33 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:6a:cafe::4c) by CY5P221CA0162.outlook.office365.com
 (2603:10b6:930:6a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.32 via Frontend
 Transport; Tue, 14 Nov 2023 09:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Tue, 14 Nov 2023 09:33:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 03:33:32 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 14 Nov 2023 03:33:28 -0600
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
Subject: [PATCH V2 2/2] serial: uartlite: Use dynamic allocation for major number when uart ports > 4
Date:   Tue, 14 Nov 2023 15:03:03 +0530
Message-ID: <20231114093303.2718141-3-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114093303.2718141-1-manikanta.guntupalli@amd.com>
References: <20231114093303.2718141-1-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e95a56-c706-4ef3-22aa-08dbe4f4c4de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LBoeoClLeflPZlAX517oUW2rQmcupotq+hXSBMQKWE9JMcSMYdqO4SIM6y/OVoUhGalbGf5loNKgvdzFCwfD/HNenCOhD0rVop2K/1jex4OJXeJlmih/7qSNlBbocIuwGaYt91UJhyhxyUY0bAcZoDqhDxhkX2H+7SBzC/HIjDkx+1Nd2C8MTPKel2yVAuzqwHhvAAZihe5IQgb73hJqHswgIlozi7ZJL9Y3JYLWKZ1k2fvP8qArN0W+xOvF7dTNn1M9iOkhDWAmAoHUsba+SCSoADRPxHZUlG2c1usXrR/L5CYTcv4ZB5/N61iyLGOH8ZneJwyPp3Ad4KuvSFJT0v5q1bidtwudA15ZGT84nK2oncNEbJFpYzgFqmuYQbE7ESc4GmUIUM469hTQbzTD78GFV9UYx65qlPK4KYcu1NU9e3mpevyQkWPbA/JyqwWr5oOmr8wR3IH6CyNbpBYTa+oJikzzugC1zxy/kdvaGHzZx3DNTynoSy3/oxr/AHz95C4IUXuXck7snysQyqF9I9K6ryTrCD/t5Q8kA+BRdyXUJOmkYUh9MqGDwZscbXbcTb2hmR6Y3wlTnTOXe3NvYEk86k/t4vozZIMhJCuYApwmVVUP1nhLJa5vzFi+slEwlwuDMuzaHmfZzOjcw0ijfmXEIiC1wl1ys4vrVd0QQ4QBHZrlvmQTBUknrOQSxfHdPpSbEB7nmhu+jr4/CanbkN4A/umSDELhoLGvUqUTNhNCN4RczNhQuk+zg2RBvain5bxW8RrdOmaYo/pxbAB8+xO6JXv0808qDbJOTuNDXl3509Q+328iKvWQym4oMbM8
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(1800799009)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(921008)(40480700001)(40460700003)(70206006)(54906003)(110136005)(70586007)(81166007)(82740400003)(356005)(36756003)(86362001)(36860700001)(83380400001)(26005)(426003)(336012)(1076003)(2616005)(6666004)(2906002)(41300700001)(478600001)(966005)(316002)(44832011)(5660300002)(47076005)(8936002)(7416002)(4326008)(8676002)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 09:33:32.8008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e95a56-c706-4ef3-22aa-08dbe4f4c4de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
---
 drivers/tty/serial/Kconfig    | 2 ++
 drivers/tty/serial/uartlite.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 732c893c8d16..368c63066a86 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -532,6 +532,8 @@ config SERIAL_UARTLITE_NR_UARTS
 	help
 	  Set this to the number of uartlites in your system, or the number
 	  you think you might implement.
+	  If maximum number of uartlite serial ports more than 4, then driver uses
+	  dynamic allocation instead of static allocation for major number.
 
 config SERIAL_SUNCORE
 	bool
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 404c14acafa5..517f1f34143d 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -24,8 +24,13 @@
 #include <linux/pm_runtime.h>
 
 #define ULITE_NAME		"ttyUL"
+#if (CONFIG_SERIAL_UARTLITE_NR_UARTS > 4)
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


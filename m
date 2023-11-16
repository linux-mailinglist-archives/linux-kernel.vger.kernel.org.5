Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F096D7EE1B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345253AbjKPNkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345237AbjKPNki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:40:38 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEB1D6B;
        Thu, 16 Nov 2023 05:40:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDUzuNM2J6l8UAnaVJS9pucDwHeTF5ToTnzoc2YaKdDZo7Aal7q55Ngf/3vGJ+vcsswaPsYKt+9dituH7tb57McUYTSyPq5nmAoNu25SGpzSJ7tIKcuO98f0B/DRSY0I5kxsMujHAFH3sQnmzq9elpA6NvNLfYAjdreiDv8iG1an+vv2bpA85ikzRPabWxhKJRANlN6d+YmpDSjU8qt6vnax0jEhYiVedLGwJsaQuLrmpUmqSR7V3ZYQFTQ2btoQ84C5Xxgowstbs3tYswD6Pv3YWP2tXnOrrzXSygBDqGlckgR3nb8WnxGHBpsGMy8VHaJV2FfxErMLGK8+jNoSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l21PNP1vluL6YjRe5U7aYOqpJssT+8SA43+k0n1exyw=;
 b=GRonEG+Q8nfJd9n8QaIEV7tc6djKU9Qrn8EYSZmZe4h4PT0ClMcSN2SNCTzYwyitmBU4Se79p6puy8Cu7DRv0okKR5ON5g1qqD81slNDXV5A+X4lUlDH826l5sWEhedef64+Ntwa3XcdmAcoTYqWcFH/mkM4cL6twlPePeuRWAtUXicVuBpgDYSowhuaTBXbmosN0XyH3bJ04DzErFrbpBFAwoSL0y9dw+cY+UdvHQlloXZ6FIRFlspUR1lg0Qxvq1UB+/Nf0revt0NcEGeErkVqO/r+t8HvQ3EStrYLAjh4Afhmjet5sm1pa8p6vKc4pDqEmC4HRtIW7DdDArPbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sunsite.dk smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l21PNP1vluL6YjRe5U7aYOqpJssT+8SA43+k0n1exyw=;
 b=g1QNoJuZrwnvENnXCNPO5g8KtbrPRekLWet3eCkV1RoqVQyWjIXUpo9ZKHl5L8V9f2IwCAKnSOpvu/sakEnzLEz3QqVZWoDzXyLb7cZpWyOHEvXzrVI2dcVJ7josqTqMiS9HxEose3ziWYkcgPANckL3B9sa+Oq7QPyIgdcg+cc=
Received: from CH2PR12CA0017.namprd12.prod.outlook.com (2603:10b6:610:57::27)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 13:40:31 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:610:57:cafe::76) by CH2PR12CA0017.outlook.office365.com
 (2603:10b6:610:57::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 13:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 13:40:31 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 07:40:30 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 05:40:30 -0800
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 16 Nov 2023 07:40:26 -0600
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
Subject: [PATCH V4 2/2] serial: uartlite: Use dynamic allocation for major number when uart ports > 4
Date:   Thu, 16 Nov 2023 19:10:03 +0530
Message-ID: <20231116134003.3762725-3-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116134003.3762725-1-manikanta.guntupalli@amd.com>
References: <20231116134003.3762725-1-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2457e8-ba4f-4e1e-d874-08dbe6a99a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtaoMv9Lr4MnTVFvCOpdU47JcvXwmnhl4Acin/3kA7wULgqB35dATZ/HNHwh/DwS2Mgwbe/i1NAkIAOjfpuI3pEKgYwZ6q6gRbcwcpudxZQ7dPm4Uss+ZGeEbs8YUv0SQsPM+eG4UI0bTil1aE5TNyqwyAPWmX+W6CWPVCRzKO11et86tiKLch12LbN7Fs45OBh8nOBA37R8zd26PhePBnvZjbeG3zbtSEBcZKcq+QME12jbt3U6DN4kT3rqfkgLbQmkkdaw5Pw6CUtles+nQewHzMpQ3Zh1hU3q2JDnylSPPxxpCxhvZ1RV2pbII064bb9xuSWGwx+4PERF3iu8Hb20npXoxVGzsTXPdDKvIyXdqNe9WR+WJbZ+LTMHdmY5yuMcWACp9I3flmvdygSVLAliEyXGK1vAa5CPqFou0n6e8ujkILS2bn1H9aDsixq4PsmyngftYOp7eoKW9sYN6IZU1kgPxlxeeIQoRHDhugzJ7M8VZ9uUaCyV9zI/qh7rf0y02VOeWN3HrbGxMTZkryvBdDlVdtEgaU2M0WHrmjj06+2WH+sXh4EIx+YqOjvWO9pcjDV0ASX+KkaPnKCMB6F8xwqjkavR2j6tIeLpsscerU52f2ATuvfilG0STjaKT9mUElQwlda9J7Uw/iPhXkqnKrqev3D6xOFijxq//DHiglFti1X7MmfGhGz0E8fMyhPBkmJ+ODaj+uP5BtmTj9lxIg345f4VAQ0kPMGxOc8eQlBVZk+zONl/3uI5QSstfAJvjjU2JKBIKp5t9GrlV59HxJmAJjd/rtrki1ZKIil4hqeCcVErFCAMP86iDwjIIs5ipjeHGzjJgs4y8q9wGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(64100799003)(36840700001)(40470700004)(46966006)(6666004)(8936002)(8676002)(478600001)(4326008)(54906003)(70206006)(70586007)(110136005)(316002)(40460700003)(966005)(36860700001)(356005)(81166007)(47076005)(41300700001)(36756003)(921008)(2906002)(26005)(1076003)(426003)(44832011)(2616005)(40480700001)(7416002)(83380400001)(336012)(82740400003)(86362001)(5660300002)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 13:40:31.5036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2457e8-ba4f-4e1e-d874-08dbe6a99a51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
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
Changes for V4:
Fix typo.
---
 drivers/tty/serial/Kconfig    | 3 +++
 drivers/tty/serial/uartlite.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 732c893c8d16..8b1f5756002f 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -532,6 +532,9 @@ config SERIAL_UARTLITE_NR_UARTS
 	help
 	  Set this to the number of uartlites in your system, or the number
 	  you think you might implement.
+	  If maximum number of uartlite serial ports is more than 4, then the
+	  driver uses dynamic allocation instead of static allocation for major
+	  number.
 
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


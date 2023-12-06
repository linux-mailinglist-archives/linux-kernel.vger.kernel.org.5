Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D80806843
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377064AbjLFHa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377060AbjLFHaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:30:25 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F025E12F;
        Tue,  5 Dec 2023 23:30:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoglLm8YuU9ApqtLKvqyrV1bIae0hrPx/K9hN2tbd3L2lR1UbkapyMYtrqx5iB1zYv5bq64Rf+h3UY6ubkT84QXiIjZxRAL1ECLjF94ZCaAEpQ00E9W9eLRhs6uaddAtMig+xnNGoaDpyP0sdossSVUtsdlgtuAC1EUH5SPRQwzHBMBYme5iZg6APJI4dcJkwz7STUAw+HfMjKF+0UDTrLElFBnUoBf0dS2dVMkCVpcUT9Yj5jeBNsG5rC3Uwd9xtlID3PfJ/h0/v0qcdcibG/LGPIlwvm5My+6oXO8K/KcfzEXvUnix9yPrDIeUuBsDaUt23SzyOC5Nj/sQQE9t9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zz/TBKhkWzx7xHDx4OIsaPHgdi9iNmI2bKVeONk4Gs=;
 b=ijtWxhwjTl3AFLMuEKb0Ei1PmEA3SqFg5yKl40l5MaxZyxm+H0HhQCUfJC1OD/nehhYesnhcwYqW3MonngO3fxBDNSpxXtpzXRgWbh0VqH2QBzS3o0aOT8xpvPTJakbgsccuE05TiJdyuVIGJNSW+fz7r0WR/5S7wBFS0AuRgc7Gel3vpiNvpG3XJ/BbBB3Daq3qx3qcozXzMpamB8RP9RRvE2/YKZqiL7/4qFd/ioOR0N8x82pHDuDwsbpE+AqZVtihhvSwP0ENnIFeWSxtBSwoJRJePxsrAcwsfM89AkhdUPREOQzFR0el0KbV/UKMfXHes2lM4uPaxIgIddWEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zz/TBKhkWzx7xHDx4OIsaPHgdi9iNmI2bKVeONk4Gs=;
 b=ULanw5IFEpGuGV79zFYlFqsiXkwyxVq8/vb/d3mQ8+6uGN88fnYpzidSqZ6vrEnD91L+0MyyRc6zcyX6LdwxK0kJe8mTnBXy3EiCtWp/WfFaq0GUaZp3z6LomdBbYl4frJIHtTNQNPdEryK8bVfG5cCnlrPRl17bX35/sI9gV5o=
Received: from MW4PR04CA0220.namprd04.prod.outlook.com (2603:10b6:303:87::15)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 07:30:25 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::60) by MW4PR04CA0220.outlook.office365.com
 (2603:10b6:303:87::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.35 via Frontend
 Transport; Wed, 6 Dec 2023 07:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.2 via Frontend Transport; Wed, 6 Dec 2023 07:30:25 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 01:30:20 -0600
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <hdegoede@redhat.com>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexander.deucher@amd.com>,
        <Lijo.Lazar@amd.com>, <mario.limonciello@amd.com>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v15 1/9] Documentation/driver-api: Add document about WBRF mechanism
Date:   Wed, 6 Dec 2023 15:29:39 +0800
Message-ID: <20231206072947.1331729-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206072947.1331729-1-Jun.Ma2@amd.com>
References: <20231206072947.1331729-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e59235c-09c1-4f9c-280f-08dbf62d36b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiVVQUt3xx+uj+MpEOapm3SppDQ6RXcc6dDNYHbCXHBtXRD2cEEMsgcxd/u9cnuyXIeco9Y/XPvusCT4zfsrIjqRCGqHKHXlCkSo9/+6DzeHlfNuRd3oRdZvB/RJxR2QPCtc4J0PQ/Oj0pFG65maEclNgv0Fdp95zqxP3qPKeJIsXqYQrZiMhKUolMBQD5laradMfB7+mnV0RUz7h0Vz2T+6mVTSnXinQ76FnLJEO3PRgStVzIpywEX/3W+HmTR/Vpoerlkh5PWw/rC4DUdIw3XGDEBFij1xpM/c6dfnwVGPDrXfDp9/832nmD57mUTIrpeWCu19AM0TcO28+O4/yPksGdhI/NY5yxNepG9INqx7AQXknvbO2e5BZ4Uwq0WcwlozIwLlWF+8pkA8bubSOMUso3i4CQ4kQdU+T0SD0UjA8fyiKpQr3enBBg1gz/JSw8zwc3WlchpPsGSSdApKleiLfVA2+IQH7OJkDHXFDv0wceGtiqucPEDEfifq56nVPbCMZn0TdFjTWfurfkwCkWsuN9BHgQtD9gv8gGoPGu57KMho+UuvBaGPQEJeYFZf7k/Ja6TiQ5SGlm4wsvw5hhm++5+or+RefQr/Eo4KdDu3ez2Tvsz+kV2ucXy/jIyu+eSkWNyTaE01TaruFayAmjwkCxkTVsM6WvpjV2RFz7ui7mBHU3iEzbYINAJQO1I7lm6n3hb670Jmy4Rhu4rubWfFSXQpqOB/rmNhksoOgDLJu5a0FWEH4Xpm8hCD3lKlBQEgXm7BbegZqHjsLsxr2P/0aO54i/pOjQH/LH00p4s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(426003)(83380400001)(478600001)(2616005)(26005)(1076003)(336012)(16526019)(6666004)(7696005)(110136005)(316002)(54906003)(86362001)(41300700001)(8936002)(36756003)(70586007)(70206006)(8676002)(4326008)(36860700001)(40480700001)(921008)(7416002)(2906002)(5660300002)(356005)(82740400003)(81166007)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 07:30:25.2738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e59235c-09c1-4f9c-280f-08dbf62d36b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation about AMD's Wifi band RFI mitigation (WBRF) mechanism
explaining the theory and how it is used.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/driver-api/wbrf.rst | 78 +++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/driver-api/wbrf.rst

diff --git a/Documentation/driver-api/wbrf.rst b/Documentation/driver-api/wbrf.rst
new file mode 100644
index 000000000000..12793bb1abce
--- /dev/null
+++ b/Documentation/driver-api/wbrf.rst
@@ -0,0 +1,78 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=================================
+WBRF - Wifi Band RFI Mitigations
+=================================
+
+Due to electrical and mechanical constraints in certain platform designs
+there may be likely interference of relatively high-powered harmonics of
+the GPU memory clocks with local radio module frequency bands used by
+certain Wifi bands.
+
+To mitigate possible RFI interference producers can advertise the
+frequencies in use and consumers can use this information to avoid using
+these frequencies for sensitive features.
+
+When a platform is known to have this issue with any contained devices,
+the platform designer will advertise the availability of this feature via
+ACPI devices with a device specific method (_DSM).
+* Producers with this _DSM will be able to advertise the frequencies in use.
+* Consumers with this _DSM will be able to register for notifications of
+frequencies in use.
+
+Some general terms
+==================
+
+Producer: such component who can produce high-powered radio frequency
+Consumer: such component who can adjust its in-use frequency in
+           response to the radio frequencies of other components to
+           mitigate the possible RFI.
+
+To make the mechanism function, those producers should notify active use
+of their particular frequencies so that other consumers can make relative
+internal adjustments as necessary to avoid this resonance.
+
+ACPI interface
+==============
+
+Although initially used by for wifi + dGPU use cases, the ACPI interface
+can be scaled to any type of device that a platform designer discovers
+can cause interference.
+
+The GUID used for the _DSM is 7B7656CF-DC3D-4C1C-83E9-66E721DE3070.
+
+3 functions are available in this _DSM:
+
+* 0: discover # of functions available
+* 1: record RF bands in use
+* 2: retrieve RF bands in use
+
+Driver programming interface
+============================
+
+.. kernel-doc:: drivers/platform/x86/amd/wbrf.c
+
+Sample Usage
+=============
+
+The expected flow for the producers:
+1. During probe, call `acpi_amd_wbrf_supported_producer` to check if WBRF
+   can be enabled for the device.
+2. On using some frequency band, call `acpi_amd_wbrf_add_remove` with 'add'
+   param to get other consumers properly notified.
+3. Or on stopping using some frequency band, call
+   `acpi_amd_wbrf_add_remove` with 'remove' param to get other consumers notified.
+
+The expected flow for the consumers:
+1. During probe, call `acpi_amd_wbrf_supported_consumer` to check if WBRF
+   can be enabled for the device.
+2. Call `amd_wbrf_register_notifier` to register for notification
+   of frequency band change(add or remove) from other producers.
+3. Call the `amd_wbrf_retrieve_freq_band` initally to retrieve
+   current active frequency bands considering some producers may broadcast
+   such information before the consumer is up.
+4. On receiving a notification for frequency band change, run
+   `amd_wbrf_retrieve_freq_band` again to retrieve the latest
+   active frequency bands.
+5. During driver cleanup, call `amd_wbrf_unregister_notifier` to
+   unregister the notifier.
-- 
2.34.1


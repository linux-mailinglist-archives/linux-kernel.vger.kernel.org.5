Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8DC7DB3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjJ3HTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3HT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:19:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68933C6;
        Mon, 30 Oct 2023 00:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=en5pj6ciu6Tqo4Xt27Prc10OPN/Wh36tTMv9Xe6tWQzoR7IRS3+b8oQ+XkudZChkuw3LtvH3FPRgGKEavIdXhTtwe+omW/1EiP+lGVWvXjzFWnU6Rkyhz8iSO34ukqhh3DHIhcK3wAAOazL4Q9qA1TWznPt3CY63QtcY/qdP9MKEtOsFN42rtTy1X2XcDvon/9bWjPSnJpOcO5hmG5Gklb3TTKrW6rdEHwM1pRhBqmbFJksQDnKCBJKTZStgcvs+CTxL2cmIghYBdoK2lnby4GSo2PZwzXgmgxvrqgsGCzJctqFtaE99Pw47qnbxfrpOKtF7oDRRVqxce315bqrIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYDOEnOoCbHRG4pqw+lZEWsipQyW9j44PHNf1bcJykk=;
 b=Fqg24bPLn7cDldgf4pt1Go7DsVpk7Ig+WDjm9slBewDNb9rayXv/gwvgzz88HW9yuFEneIAPGBbgt2tEukiBKO+QkFbCCzdMN/lHaIe4l0s8R7s25La2BU84PIKX3ZKbWbRasCw3zx77wGDy6rk/AyJIkwQIfVOeC0OqFGejK8g/dyksfclVhOdQPES0K0Zsycapr5JBZ5g5M3MaHBPGDN3ZWsi45PPc5vcE7jIReDG+VGqIjaCtXI6FLP3EgTM7ItDQpLKnXtPxfwwgDgjrw5Ko7WEU1HrQ+9xW+Iuvtglodr883UWv5ulP3y6yPxz4dySrkaKHaUKIYzeuz6zOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYDOEnOoCbHRG4pqw+lZEWsipQyW9j44PHNf1bcJykk=;
 b=jw2JxEAEtzbifR4jQyFkGGeIb6TAouIorGd7yCj+yzRcshsYeh1nrlBTSzlyO2ucre4c4tlCe+w0w2hh1gm3iMem+BAimzPmEJjDLp92zZTn3j45xBRFgIvt9E3mLbsHRTJJsBYrKUKjBPdIBBfIU2E37mC0nDbdEfv+HDE6fAQ=
Received: from CY5PR15CA0198.namprd15.prod.outlook.com (2603:10b6:930:82::14)
 by CH0PR12MB5043.namprd12.prod.outlook.com (2603:10b6:610:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 07:19:21 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:82:cafe::50) by CY5PR15CA0198.outlook.office365.com
 (2603:10b6:930:82::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28 via Frontend
 Transport; Mon, 30 Oct 2023 07:19:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 07:19:20 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 02:19:15 -0500
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <alexander.deucher@amd.com>, <Lijo.Lazar@amd.com>,
        <mario.limonciello@amd.com>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [Patch v13 1/9] Documentation/driver-api: Add document about WBRF mechanism
Date:   Mon, 30 Oct 2023 15:18:24 +0800
Message-ID: <20231030071832.2217118-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030071832.2217118-1-Jun.Ma2@amd.com>
References: <20231030071832.2217118-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|CH0PR12MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: cc05b90c-c019-4c0d-60bc-08dbd918896a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNCQe/2Qp8uZTDgFxrRhcJQosOWvMg8eKeWs8Sz2VlSq0B6kBhnQe8la3kNwRQ3+mGRMPWtcMZREEoeAZETdOkIlQGTbNJd31d6JtXxg2nZZnZv4MojzRw4bckhRMM4A/kjhCwpFRa/69KBRH9HatuRZwF2tfqExSSGD6BQ2CHQZNK7LQOgklm9h+vXmub6lmng+w+5vB5NAkaroBPaVLy6yuzGaNBfpJV1trRcTIzfi577p6bFxJYfwaLoE9lPGpOd8pK/GIbXqW/p3Ovb0m1oupC0PGUhYlyTBW+IqvQtMBnpiDWWfn58swudxozR89kNyw2NVexL/1DUBidlVLunGH8FjEl7nJXsbMV37diOGhY+OJd5uGCzjYc/d/du+geB9j1EGS9vnabfzcr33li/6cLTiZWOJhTOQG8ldU5+vDFAc5CfZtloITShxFLew+v1O4ilIxD0t1AfCnsyY9gF0A70OIsdVn/NZsAA2zef3vVUgGocQ5eNIcGHXMGAscVpLAr9WJL6kN+Swigdmz1DyiJhjp9AQgBm7Ij1mt5k+rZc2pqy/CvRZ4/TEMZnL9jZBD4mD1DA1TKnLchaM+goGEsr/29WhxN0iDBeyH52Zw/WDNC+m1TrjFEhfyYGLugFKp6zAne/NxKqsTDjZk80q73ZSsN38wU3MHucWkYUvX/rD/LkCM1PVzds/fGwyJifzeOibS+n/QOap64A713wdISDKWMmi33C5v2V9rCuzNBZIxhTkShwUTWP0yZbWCBROAOJEYgONUgnWxTbL0GZRFyIIGC2VPKVgeQf89rE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(921008)(1076003)(16526019)(26005)(40460700003)(36756003)(86362001)(40480700001)(356005)(82740400003)(81166007)(2616005)(336012)(426003)(7416002)(83380400001)(2906002)(478600001)(7696005)(36860700001)(6666004)(47076005)(8936002)(8676002)(4326008)(316002)(54906003)(5660300002)(41300700001)(70586007)(110136005)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 07:19:20.9855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc05b90c-c019-4c0d-60bc-08dbd918896a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5043
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation about AMD's Wifi band RFI mitigation (WBRF) mechanism
explaining the theory and how it is used.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 Documentation/driver-api/wbrf.rst | 76 +++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/driver-api/wbrf.rst

diff --git a/Documentation/driver-api/wbrf.rst b/Documentation/driver-api/wbrf.rst
new file mode 100644
index 000000000000..52527e76cad4
--- /dev/null
+++ b/Documentation/driver-api/wbrf.rst
@@ -0,0 +1,76 @@
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
+.. kernel-doc:: drivers/platform/x86/amd/wbrf.c
+
+Sample Usage
+=============
+The expected flow for the producers:
+1). During probe, call `acpi_amd_wbrf_supported_producer` to check if WBRF
+    can be enabled for the device.
+2). On using some frequency band, call `acpi_amd_wbrf_add_remove` with 'add'
+    param to get other consumers properly notified.
+3). Or on stopping using some frequency band, call
+    `acpi_amd_wbrf_add_remove` with 'remove' param to get other consumers notified.
+
+The expected flow for the consumers:
+1). During probe, call `acpi_amd_wbrf_supported_consumer` to check if WBRF
+    can be enabled for the device.
+2). Call `amd_wbrf_register_notifier` to register for notification
+    of frequency band change(add or remove) from other producers.
+3). Call the `amd_wbrf_retrieve_freq_band` intentionally to retrieve
+    current active frequency bands considering some producers may broadcast
+    such information before the consumer is up.
+4). On receiving a notification for frequency band change, run
+    `amd_wbrf_retrieve_freq_band` again to retrieve the latest
+    active frequency bands.
+5). During driver cleanup, call `amd_wbrf_unregister_notifier` to
+    unregister the notifier.
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D450F7FD202
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjK2JOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjK2JOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:14:33 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCF11BDC;
        Wed, 29 Nov 2023 01:14:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2jls8+xceaUq+zmXVR1ym8Qu2vq/2UP6erDdfDqSP9D9G85qRGARU60eFVcGfnEdS9m8Rgj+NTVetDCWeGTIEYQClmWrQXGukTisVAxNjo7k/Pur8iAPER8/XFMHPCQyp+6h7UW8jGv1Oa2x/NYfQ+GjUuH7Zzh2EqdvWyoTsJAWZCHoNtwfCgHwunSDUBfR+MONvofvEiB8PAs0C2akosTYzgmdnBhEHyk9FAJWIj92cJciBC1SpSz9EzTdOCsCkLPhPeNKnlBpUZndBbaIGhC0uA0ZzIu9XFO5QhnB9YPiQ9tQZMOttWrkTxKAOGcPW5uDC6tHiEmIyiAghdqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbYANmssnII81GCFDHN4Q7992LrDQ1SmxcSBrprIeZg=;
 b=THOjTKepXjPXsKyYsh+CKM+SEnClWsHJeABOHeAvKTFuGs1q0Igp7LMwZweRcCa7A+9KY+wQvnESflv/xxXEScLbX/BXHDitBtaGdSEc1+bmAtPjt4J0cM+kLRU4rpN2xCWDEFip6NH/Gics1y3hx+UIbsPbTxIUccuFIhQgPpykSHGcQJWD5NYn2jxIno2YAbQieGAtgQjMhTYVuXfiXq+OtUXRpSjg7/SBTfjKXUJI+Sd7aDPNS1TsncWuc17rjUrFpzJ34NlrmtHMrwgM9U1JEqYppRGv5yDZzDUEo16XhGicQKODP8CadqAYVuXV8+9+i6VwhvhH9MRDVD5h7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbYANmssnII81GCFDHN4Q7992LrDQ1SmxcSBrprIeZg=;
 b=gK6kY7MN86z+FLRCUWLNF4CDr+mjAzjflveMTcWXQRlxq4lRNiGQ0H0Dkuac5h7n5lIiWoTpSnf0rh7fHQYoKIteswagqiilcmf2VD9D+DLpkGX6MPjo02RU4LuhyMceh0Q6QpAHi+sTeiG8Lfx1a96O2UD7RLHgSThrT4oRCSA=
Received: from BL1PR13CA0085.namprd13.prod.outlook.com (2603:10b6:208:2b8::30)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 09:14:28 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::1) by BL1PR13CA0085.outlook.office365.com
 (2603:10b6:208:2b8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 09:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 09:14:27 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 03:14:21 -0600
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
Subject: [PATCH v14 1/9] Documentation/driver-api: Add document about WBRF mechanism
Date:   Wed, 29 Nov 2023 17:13:40 +0800
Message-ID: <20231129091348.3972539-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129091348.3972539-1-Jun.Ma2@amd.com>
References: <20231129091348.3972539-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9fa9b0-4104-4a5f-812e-08dbf0bb9675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ziJvnGfaqJiO7SIEXO16CnItJNpFLOPLEVCJf7XN3Q45h8xBuSit8a29O7cGqpp8HsW68I23v1PodKiaFGO3hg3ahmrh7wUrs/mCNhwwq0eJaF6fmIpL5oboVF/Jwq4OcySveE3kotIbyM9cRMeFOmic4Oyj1id8Op3frojuWSOY+i58BIOeJvyt+nYHefv6rwY8olcSC52FMHkWSQRoza3mjm6MOzvVfCIJTohlwpWZuT/xMSqE7oHScn7bi7Sz/7TahGZlCvRiq2eETM0P1J/cQJYh+nug4LRfXPC2Sla/To7u4NyEHoDSDYvidg+nbRscRbFatSHtGkwC1c5yCVIU4XnEnD0NhmNSHzH60ncNAAsxnow1wADrEgC6s19ON7yz6lrS6GNNQdSs//fq96GHgOxhcZnrLof6njRNM14L+n0V1hZrNFoUv+d1F1tieHitoFMvyufr2p6Ol1W8uSOEL5t65QNmU6yDMuyLUZgz9cV7FIIXPFu9OCBDbn1Vio+GyA8NrNCmdX6I7Jh2dTSHvmm+3bKjvn+Daf4wy+G+1JZLfGYs5fJ3FuhlcRoNjWss6xQ8VTq4Nz92mCqDFzSsT/INmhz3xxrHaXffcpyHJ+2iYDEtNoFnJofpsSTKP6LcfCq3bWer3GJYCkaYOevDUkEGvgSLaa/vFoTYN8zvTdZxGlUHTz7NvmpG62IGaThu0zqSK1EFAgE+4QF0XtUIA5i6azIa5cF4j25E7ky/630obeCoFaP4FZQvDgLH3kAQAHe78n9im0pABoit01AN4Y+YgCY8/KT9oIwMX4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(41300700001)(36756003)(1076003)(921008)(81166007)(47076005)(356005)(83380400001)(426003)(7416002)(5660300002)(82740400003)(70206006)(336012)(16526019)(36860700001)(26005)(86362001)(2616005)(70586007)(2906002)(7696005)(6666004)(8676002)(4326008)(8936002)(478600001)(40460700003)(316002)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 09:14:27.6422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9fa9b0-4104-4a5f-812e-08dbf0bb9675
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962
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

--
v14:
- Fix the format issue (IIpo Jarvinen)
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


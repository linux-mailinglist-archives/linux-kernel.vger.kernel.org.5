Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB3D7D8723
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345204AbjJZRDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZRDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:03:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B293F1AE;
        Thu, 26 Oct 2023 10:03:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfXeeQGM5ZaC54BS9sCxpimo55IrGWKdP+MUxG4gY7p4CK6Baszkc1rfcJecRTe0uj5mM1kGq76KS+r25vo4aQHnDWyaZpTPUvf9H/j7/rZdwuSNKWMcj3RpCrvhO0Dx1lfKHt6r2Dh/Jq2t5bXpyAHgvA7GAPius/qLOM1X/hF5n/l7mWsLeki7B25Lq1rqLWg4PDBuRF6gchE+yp5G7fT+d+PNPXHtBtSpGE5INtvCoun3grCDu6xVSSPiWlG9AURUdtnqFXmVluRPhfcH9Gkyd/n1VabRGRgS6N8Ej6A71GCwZs/1/g17GGWfLs7cPXPHOQgP2h0AFl1s3uh7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gqpZRTKbezAhXhfFJVDy/c/wxyVZ2csRDXirWwXxko=;
 b=FtxDa9sQwIPRXMQtbLUzmlny3XcLsNRXsPSCGJlxFWXhARi2NEuYgnCz99alsIoItG/BgsUQbKjwS6W1WzVGbpKQiEKI8izsc1jpkJ1ij564co9IOZjRyqf2EH1OlbvoDtk4HfX/lpn7Tr7fPFMMoIKrBXixGwUbhbIZOVMXLYT55QwWXuEl+1lckUXIYYQxg5tJUaVxf5QWU5eB7Urpe84rB25XYdhrpwff6e46qLh4VV7gsHPKSHTqi5/8MHXZuxtbmS+5g7gr/tFigaE5a5Cw7HFZlmeS1FjxlSnbXpViv9GLV0fhUkKaO7cdwDU+d6Jd5qoPD4O8blhi/m5qtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gqpZRTKbezAhXhfFJVDy/c/wxyVZ2csRDXirWwXxko=;
 b=DDwzhl9mB2nX1/HduNhFLv1gj37qSTJOBVQBnayIkQrppgIWQKsGvEvXCSzCE/CEOPat+leuvByFb8G3gB16Y62DYJcYaSiacu6yps4P7A3CFk61gCxrAJU8ZSPMYbq3ar1YqsuXISh6NMNcthuouPQlHkoWUeboVv5T32VBZN8=
Received: from MN2PR18CA0005.namprd18.prod.outlook.com (2603:10b6:208:23c::10)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 17:03:45 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:23c:cafe::ef) by MN2PR18CA0005.outlook.office365.com
 (2603:10b6:208:23c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Thu, 26 Oct 2023 17:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 17:03:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 12:03:43 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Len Brown" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sandipan Das <sandipan.das@amd.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/2] Fixes for s3 with parallel bootup
Date:   Thu, 26 Oct 2023 12:03:28 -0500
Message-ID: <20231026170330.4657-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c10c76-fdb2-4346-f92e-08dbd6458390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XqGBLEHbLDsAdmcEUtsUf4GtLcCLpSkLuVai3qY3YqJ69PXNHhJPQ7Sex3eHY3KdfXlKBdnDZVcDpTQ0jvFedvbPElLqbBihj1LXBgcm/lFfA1sVIwkeT1tZqpkqoA0xmAbJGEzsOHPURUyMaLrTkT23ELXj7Zf+NbDkc3JjuTm0o7u14CV72EZnf9h2iEvmVH+TLkrBghZe4xiVHvfxgv23ZMQrq5dKah58E+9uRCT6cAEc9rT2Notu+Jfh3kfdbdN5LX/cBe6QSDJvyGUMXcoz/LUZjrjkaWQa8HA+ACgcTkQqg81L2ufyzVo1iNfgwBJV4IGzvutpHFVFs7QalrkIEU323M0WKHe8UXWU6JU7I7jlqA4zVRiPJtXsANjn4wFpTnhs3FCh+UxDeI97JaCPYjE+fg6yFb00ZPSuUSTgNAhZdDfioI3XAk80n4h5RCPnsh/4jWFer+zJhPkfeF8X1HxthXKdfWX6UnL61/AaNtdtg6bgCoVZFZHdBJ1fuqY7bxJmtfzanVThX377EGQ7lPMfvywDFmN3JDSB8rNCxZv3PoOplR4uF8My9zal1NNZsOfdfHj18lAPe2xoTjZcJtw8DcBaT2YCFoP2q0LyS80lpB+cY7fBkKK/EANpO2e3BEsmByYE26RG2jOYDOKusQ/8UAwN+NfPgxQCfVogNp7MSHIYy146ePDiwITsqKJJNWFH/Wb8UNYqcr+auF0+VfuXoE3/BPSjv8/JVLSAmjcYPgMlhfgO/EeA9O8+zphTjXsf9uK0Z24jMy5o1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(4744005)(83380400001)(7416002)(110136005)(54906003)(8936002)(70206006)(8676002)(70586007)(5660300002)(4326008)(316002)(478600001)(2906002)(41300700001)(44832011)(7696005)(40460700003)(6666004)(1076003)(2616005)(26005)(16526019)(426003)(336012)(40480700001)(47076005)(36860700001)(81166007)(36756003)(86362001)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 17:03:45.0992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c10c76-fdb2-4346-f92e-08dbd6458390
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parallel bootup on systems that use x2apic broke suspend to ram.
This series ensures x2apic is re-enabled at startup and fixes an exposed
pre-emption issue.

Mario Limonciello (2):
  x86: Enable x2apic during resume from suspend if used previously
  perf/x86/amd: Stop calling amd_pmu_cpu_reset() from amd_pmu_cpu_dead()

 arch/x86/events/amd/core.c   |  7 ++++++-
 arch/x86/include/asm/smp.h   |  1 +
 arch/x86/kernel/acpi/sleep.c | 13 +++++++++----
 arch/x86/kernel/head_64.S    | 15 +++++++++++++++
 4 files changed, 31 insertions(+), 5 deletions(-)

-- 
2.34.1


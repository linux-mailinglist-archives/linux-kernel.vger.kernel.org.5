Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B557CE13A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344486AbjJRPcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjJRPch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:32:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64F7114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clNpQy5ZybGfdVjI2sKzIxRKmWpuzX2t0fMpvx+gtGr6SdUPC4mHrXl5pKMa8b8DqLnPfteTwDyz5c0OaQFge4/w+Gsm3R5UvaQxoyDzrGmJs/Vp/F5HCBwwnaUme88ndNW3u6vUA9LRRZc6LsddGgat8OubVIfSJyfaHFDJKMuabd6RkKuprPmBwoMqgb1mlBGxlM1qgl1AIc0Y17eCJJYIjAj/oGjmQXOcvp2IPW596LhXumYxTIGMCK+6n6ZRNhTzJ/6Cc90iilwhunel7douEx4Jh9lha9kABb8qq1h+2E/N/EM6QmyAhs/hrcvNFmdfZZykckfwC+ubAZWyVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4EGmEG7/6VTSsdQ95kDL3H+dHVvpGu9d8qKc+oIY+I=;
 b=AgXkfxaz5NN2az36eZOBWUJ3V1J6QcnydNd0R4y148BY+dpzaz/gzvL1G4ExrEUuRJci9+dlt42o331CYIcWJ6bFhCTSKvpJ343JmLh+yRPi3uZ3BEYmIoE9zZfswBfm79Y/p3RuYAJPEgfHfXUY9j8wK4IXdhWoSyCqHuUyt1bwLPC7Edh92FjiCIYZgxcOrMP0EFTa3wnhwg9wl8YzKksp9F72OrfEB/mChcmP0kmOpmYpML5IjbbOTf3BjwA73cHEwcJwIkbaU3wDKmxqbEtL+pAk/Y+pmo1kUEjZlY0baJ4ojqHpKNg1WFHRdAdkm3cW1OE8g31pk7fTRRQjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4EGmEG7/6VTSsdQ95kDL3H+dHVvpGu9d8qKc+oIY+I=;
 b=Cl5teZ2eVqGH/sCiuMwYQzFpmIrzDnu/BxbHiIASf/XVswi86yp1E+xQxUHWzcGlhvbwoWPg28J7hrqI3kr2E66VC1FklXRJ6PzANwpmYhfAj5Upc0zzUmWdorc5vvhpxaFg2tz6RyTj3zkHVEZImjLxmvYy/tNpC0cj7VkC/Pk=
Received: from CH2PR18CA0024.namprd18.prod.outlook.com (2603:10b6:610:4f::34)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 15:32:33 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::f0) by CH2PR18CA0024.outlook.office365.com
 (2603:10b6:610:4f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 15:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 15:32:32 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 10:32:31 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Hamza Mahfooz" <hamza.mahfooz@amd.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <kasan-dev@googlegroups.com>,
        <llvm@lists.linux.dev>
Subject: [PATCH] lib: Kconfig: disable dynamic sanitizers for test builds
Date:   Wed, 18 Oct 2023 11:31:47 -0400
Message-ID: <20231018153147.167393-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9b12ee-24d8-449f-8024-08dbcfef7267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mctP/W0JJzx5e8Gr0LMtnjvwecDuaiSjxQc0JAwdrUEgI52ao7heP2qJs/AjRaI4uxNjKcIaX+a1XmQMzQlJtdnbVrrGycazbHE1wn96wX6pI0Q2cfZIw2CiXtq1rthkYADckm0zVE2TePGJpAHpiPKoAXoBhWfnyX+pOmXs9UOSC+d0fbquVKZigbwzmUVMYBKcXz0gNi/89TjBK9jAKvq2BsPenHLB64J2/lDXjmQenYpwl4yD8Wa35NiE7nSVE8HnDo76kO5loD6dRNuwNmdNKBk1Xt3OGN7QeqUIno1XnRwTpQpnwnFx3KHzYOq6EST32iFZ2sucXBby52HRrrYUKDqrCW4Jm58KWtbYfISxDwAE0aBoQhDBbzX52bem1tvFaQuz4X5LKDK+Ps2Tfk0achvSMrv/2l+prssuff5qgOjo/nSloRtApFj/5maql8HfesCs/5u2C7oGxlomGWQCheLWWzZDh3e6V46io/T8Nro5/6FQE3A8dDDmzR1noVwOKUaXFgA/8ivrDPKE2iylFq9+5TYhqnkMKmFZ1hFGtWkALLSIEe0PdlNcc3DhAHgoGJOn5hMh3G7bPD+v869QZ3S2Un8xw1QvLav2vTL6IEmOjndxKQO5qJbL3VPQ/K6EosnmjiYUbsXy+knDtKWAJQVOlPs+bdNLZY4gAavafsMD7gAqgQF3SGLKugGTdDCe7RtgFjowSarCHVFN5U1S3Q3+l5a7ySo0pGs446zEBOzjk1SSCxuz3oMBcX4nCzvUAczYtEA42WlHwUW96IedgvNk8m+W9qIZaNHOIKQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(478600001)(40460700003)(70206006)(70586007)(6916009)(54906003)(336012)(36756003)(40480700001)(16526019)(81166007)(426003)(1076003)(26005)(2616005)(86362001)(83380400001)(356005)(82740400003)(36860700001)(2906002)(7416002)(316002)(47076005)(41300700001)(6666004)(4326008)(5660300002)(8676002)(8936002)(44832011)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:32:32.5794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9b12ee-24d8-449f-8024-08dbcfef7267
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan, kcsan and kmsan all have the tendency to blow up the stack
and there isn't a lot of value in having them enabled for test builds,
since they are intended to be useful for runtime debugging. So, disable
them for test builds.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 lib/Kconfig.kasan | 1 +
 lib/Kconfig.kcsan | 1 +
 lib/Kconfig.kmsan | 1 +
 3 files changed, 3 insertions(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index fdca89c05745..fbd85c4872c0 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -38,6 +38,7 @@ menuconfig KASAN
 		    CC_HAS_WORKING_NOSANITIZE_ADDRESS) || \
 		   HAVE_ARCH_KASAN_HW_TAGS
 	depends on (SLUB && SYSFS && !SLUB_TINY) || (SLAB && !DEBUG_SLAB)
+	depends on !COMPILE_TEST
 	select STACKDEPOT_ALWAYS_INIT
 	help
 	  Enables KASAN (Kernel Address Sanitizer) - a dynamic memory safety
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 609ddfc73de5..7bcefdbfb46f 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -14,6 +14,7 @@ menuconfig KCSAN
 	bool "KCSAN: dynamic data race detector"
 	depends on HAVE_ARCH_KCSAN && HAVE_KCSAN_COMPILER
 	depends on DEBUG_KERNEL && !KASAN
+	depends on !COMPILE_TEST
 	select CONSTRUCTORS
 	select STACKTRACE
 	help
diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
index ef2c8f256c57..eb05c885d3fd 100644
--- a/lib/Kconfig.kmsan
+++ b/lib/Kconfig.kmsan
@@ -13,6 +13,7 @@ config KMSAN
 	depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
 	depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN
 	depends on !PREEMPT_RT
+	depends on !COMPILE_TEST
 	select STACKDEPOT
 	select STACKDEPOT_ALWAYS_INIT
 	help
-- 
2.42.0


Return-Path: <linux-kernel+bounces-2738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A7781612F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3B81C22050
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7534653C;
	Sun, 17 Dec 2023 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IgrZOgnD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7B047A5C;
	Sun, 17 Dec 2023 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQfxuCRN5wrltdmcwuB+SjB1VOMhRn8i2mFenJM6vzlgvcN90Qh9ViEyGTC/x6qA+g1rIGFTfrGG/gvpYQjN4jGWuA+Faz6+eW06sXy+66s9yoJrAPGnfOxbUxtCNVauqDKcL23ZgJq6EcpN1RnQQT4Y3gJy0WOKgxd3V7J9kC3U4jETUZpm76fwWQn1+TOcvrqq8JrX5R4PuV2gs+y6gne3va9hPq1LVkg8HanQZfHE1OYkuelgqxwtodoGMkj7q5m6XL2bhi42o3r0ahNz8L8+7SUop6c/yhh4v702ia37KfdLW7/wKibRUVb2GMpS0/AfETrnauPyfPm7uGfh7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VD3UllOtxeqm9Vn7A8dxCtCmEfsAX22mdP/Bzdq6uY=;
 b=XPkb5665AiW8IUvTGVgokO6YWuhdwxHdDPhWDFPCAUML9dc5S1eM+zvBsxazHDaj9gxhr+6mdhO0T09WHWqX35e1O6i9/UTODBOnNTAb167B+Vya4k5wftvKcWZLEHUQ6Yi1BdV69mRXwJXn+8s4BUCQ+7AuzNDyW1RoEhWOqsEXtWyzt0NM9zWBsyrZ3fWLa3NzHA2PJ9m3seiS5/g4WOBWTvyVNxkFf9wMAmhdMJBoB70KNwjSGatXt/aL6CKcmiB0+J5lP2KmYE7763dhRj/tjdz5mzJvvGm6g5Tn+b1zu7vFrJlw06UEAknbzhcHh6AGp/6snqFOFfs5qhREkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VD3UllOtxeqm9Vn7A8dxCtCmEfsAX22mdP/Bzdq6uY=;
 b=IgrZOgnD90qTuvkGGAjCGw4VZ0ptZPbl6uE13jIdj4j0ufUYm7mmDmD0WA361fVd0/4l8MPLXNGita2QpdlFLbicdN31ApGAhnsiuJLDrh/BNxs2y4BOdI8JxCv5QledE+2GaZMB50WLRKIPkCfHKclmwXhSRFcl8TppVw7jXls=
Received: from BL1PR13CA0169.namprd13.prod.outlook.com (2603:10b6:208:2bd::24)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Sun, 17 Dec
 2023 17:25:58 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::54) by BL1PR13CA0169.outlook.office365.com
 (2603:10b6:208:2bd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.15 via Frontend
 Transport; Sun, 17 Dec 2023 17:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Sun, 17 Dec 2023 17:25:58 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 17 Dec
 2023 11:25:53 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<namhyung@kernel.org>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <eranian@google.com>, <irogers@google.com>,
	<mario.limonciello@amd.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 0/3] perf/x86/amd: Miscellaneous fixes
Date: Sun, 17 Dec 2023 22:55:42 +0530
Message-ID: <cover.1702833179.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 11bc04d3-5778-43b0-9136-08dbff253bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BDUscNMq8/Kzi+D1h7ksW18TYW1Vk+Uizy3SoSP4Q2zHytLy12awgXHeNtTnnHA0g900ld2aauuRYNjXWGpjvwELHWg36m/RQJ7dhwrwN+5Y3rukxseptORGOGXkt9c6dE0mRvAbRw/UXiUiJxsJwCLTY74zfnipZxeRRYWL9E3qTN/4S2XDJebUp0pB/9pT25v5euwYn6A+APSnOcc3S973ZosFL0HZB9rTJirf2VJgqduw9eHfcWqheG3+t93xAVDh4Molmu5t2Fnwv1nDuS44/SBXdIdhkHaluG9P0JvHLxt7tU+lFgWaEpVoieUmdtHx0BJRoWRnlRkBrKsJiE0InHmEJfkZn2gLpe6jJ1g/cejb+C6EedJK92qekwLILHeip8bK6ERKRLndB1GyHsdTfSjbEAVnkI1tQC34ECsPc3fmZC9sgU4lbvVUWggAc43+5FagP56TxvWlcNW9JfWhPOrrIqSV/k7Jfr30C/pPNT2HzsPOgpxPPU3PIF2GhtQRFAopCWgfqcflpBpzKsdwFNkXiL46X9grB9bIYN13BJnU5pXWeTpBSAjsBxWPgmPg6C6A1dHX3KXdOpglYIdGUDQ7Hm+NGlNQyeIxae3DPXjpLMyWOZhgBYOmqrvhnHk75RVzes8+phckUuYpsuKfiCvf6he2XS4oAFv8tV6Zl4vx0QLl4bxSSqmtoAYORQNNsh2I0u8KwAne1bCAaWIbDeZyri+FiQOIr7z5AAZmzFlAt1WySfIDyR0quobIDva6RWMod6Yk9EyUuNbE1w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(40460700003)(47076005)(83380400001)(2616005)(16526019)(426003)(336012)(26005)(36860700001)(316002)(4326008)(8676002)(8936002)(44832011)(5660300002)(4744005)(41300700001)(7416002)(478600001)(6666004)(7696005)(2906002)(54906003)(70206006)(70586007)(110136005)(36756003)(81166007)(356005)(86362001)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 17:25:58.5837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bc04d3-5778-43b0-9136-08dbff253bdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087

Contains fixes w.r.t usage of LBR Freeze, Erratum 1452 and a bug in the
CPU offline path where PMU-related registers are reset.

Sandipan Das (3):
  perf/x86/amd/lbr: Use freeze based on availability
  perf/x86/amd/lbr: Discard erroneous branch entries
  perf/x86/amd/core: Avoid register reset when CPU is dead

 arch/x86/events/amd/core.c         |  5 ++---
 arch/x86/events/amd/lbr.c          | 22 ++++++++++++++--------
 arch/x86/include/asm/cpufeatures.h |  2 +-
 arch/x86/kernel/cpu/scattered.c    |  1 +
 4 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.34.1



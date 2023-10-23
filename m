Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0413D7D3B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjJWQAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjJWQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:00:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4270410A;
        Mon, 23 Oct 2023 09:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA5MkIbeNxVtJVRh9UyXTZZRs1zZb13LevSrsAXvNAJ9qLBCgYsLposUhdRx3C9ej2C2vbvD5y7OdzUrXZV9k8dWSu4UU9lh491wgRmGCwXHdoNVUvTpexYSXHYYsbVh6P9teDVUN+zMsZedThqn4a3WB83sOZ1z6pn9X4ONJ6wbySt+ORkaLhRb1BjqGcvGKHo+ZDoV/VU/rmErJXPxCf33UA4xZb2SIk5rfRkjuOhEXymGvYB8VyHwbQplscGJJr/5m8C4z8fz5QECIT7r9fXf01eMLnmwd8OgH7GvibtCsTXZciWufGZxjqO5x/jccB5l8m8Ue0Ry6/8SfCzXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjE+1X/6vsi6hiUnSUXDDKP7fT8SRdgB2WfQICSRwnU=;
 b=nBqn5Zho63V7iwzvoiiYoaBXEgH8yddRa9GDtJbQIAfrwOs/JbIoEXgfYQl89uqVGh8h4NPWp22u04XPL0mOToZqDn/RvCTRvOTthQz9dq0KcTHK/JtkJnkBuRtUay8SEEV8yVFYaYc/pE7soBZWamDofmNAlybHMAtTXbfKQ6LbAmXQogO7JbbH6p+T7XfwdWjWHjitY08dIY18/j5Sduc2iQzEPf8vKWNx0xSdARfCKDfKgjRwlpefPNPKzsnLnNw5h+XD5ufBKYwylVzkTsc38BfmTiNmkizFIjRsIyhpBmyPhTxQ1FbLnlD9Lv3cCfEEhCzsEbEZIDnuFXDgpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjE+1X/6vsi6hiUnSUXDDKP7fT8SRdgB2WfQICSRwnU=;
 b=Ak78w11333zzThSbX/eihusfXujaQ3fTk6pREGW2A7aa7HKAott9IT1x/8bhozss6VXp5cADjyn7oSJpJnoSLwBYl/kpbC3gyRtTjhWyjTsfU6wNghamu+mVcaZU2hLXuxw1AK9GnU474jtIwuFTKop1VcLS9mO5Xpb1D5aInpA=
Received: from CYZPR20CA0010.namprd20.prod.outlook.com (2603:10b6:930:a2::18)
 by SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 23 Oct
 2023 16:00:38 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:a2:cafe::98) by CYZPR20CA0010.outlook.office365.com
 (2603:10b6:930:a2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 16:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 16:00:38 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 23 Oct
 2023 11:00:36 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-pm@vger.kernel.org>, <rafael@kernel.org>, <pavel@ucw.cz>,
        <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 0/2] Fixes for s3 with parallel bootup
Date:   Mon, 23 Oct 2023 11:00:16 -0500
Message-ID: <20231023160018.164054-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d0bc83-1d93-4d9d-827c-08dbd3e1334d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7PtozRF1OrrekfOc7/2ZvUYddHhN3tWZwsfZrG6ELhLJbrgEdYr2yPoIgimAIefg+KLoETInsiPvSMdum6jHTpPnEVoA8+RwUksFRfH5Ek22c4guYmPn1gKDjyXlvKou9PkGHhOK5rzgJC1v1dAhNJMbVviGfG8fcYXVRqzESDJdsPvqAldGlt0kP0lqT+qh2pijgrXDypyIzH8KCv9261/TahGB5VxmTygEyYPnWaMKf+IPNkK2PY6Vh4V2evjGjhD1Ql7flis9yFvHglNdq7ewWwJSvqUtOAkyP0gAjg77ES0xWqbi6EZmWmy6EDbwwUZNuEMr07jspA55j21b32Ghx/o4ii288uv75t8+VxTKjU8d/2VhJkTCIuVYAdvT3QuPCki6uOwX42bqU88QFE/xuoqOXwgsu9ta/0MNfBMtmaln1fSelA8dKEKILHc1im8rGWjx8A4yaRoVmez2nrPHLxm/NeVNjCD5WzN5uj2qMWsCURc7GDAlXrm4H2y+rPzZbXkVWKSGBXsR1izYpDDyVF11k4FS61N2Ybb76csQKZEEo+y3kBb759+mNQOa5VkmZ7+zs/+bQWMvvlmqOr9wfqH8zHLIbhiRtzNeussw1qYP5uZ3ddKcHcqYj8niRfjkAvchT3b30wbGJ7ElLn57EwyY2Web944BM38DVD7dgI3436/NPXSCo23KHTgjF2rpUj6ubQIerKI7TIas3gPC0pWGVuzkBR9eE8TuqBLdgwLmvtMnSNCrk38Uq9d/XrY6oncPHnvApzvaUJzww==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(4744005)(2906002)(36860700001)(316002)(6666004)(54906003)(81166007)(82740400003)(70586007)(70206006)(2616005)(356005)(16526019)(110136005)(7696005)(478600001)(1076003)(40480700001)(47076005)(426003)(336012)(83380400001)(41300700001)(4326008)(44832011)(40460700003)(7416002)(36756003)(86362001)(5660300002)(8936002)(8676002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:00:38.3783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d0bc83-1d93-4d9d-827c-08dbd3e1334d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
  perf/x86/amd: Don't allow pre-emption in amd_pmu_lbr_reset()

 arch/x86/events/amd/lbr.c    |  3 ++-
 arch/x86/include/asm/smp.h   |  1 +
 arch/x86/kernel/acpi/sleep.c | 12 ++++++++----
 arch/x86/kernel/head_64.S    | 15 +++++++++++++++
 4 files changed, 26 insertions(+), 5 deletions(-)

-- 
2.34.1


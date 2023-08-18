Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076AF780B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376650AbjHRLpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355002AbjHRLpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:45:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881A82723;
        Fri, 18 Aug 2023 04:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFpkxWMS4ZWBvoPx3Mt7CX/mWiNGxm3XbPFROnQzs1ondhhNkwqHLDgVFL4znAEnkWxJtxp31Ko0UxEPnv/Ci9z9VqoGH2GBf9yJpRNXaWmJRIKiprOl51tswJruUrnXqrxjzAxvTTQDjYW8EJqq8DNzx8LQu1ro/M24sag/iwgazbrr8goCMqaI80T8+1+zo76jmd9TzRwcD3MR38cgCINEulv//AVWwtkuKF2ttrpPxuDa1MUknu7dy00ruau1XehBz5Hep79/oNMyLLxfQVGw/qcmkZdYPpYWLxB0H4U5qYBX0pnyZbHOJPWS19uflhi/2exeM+5qxX8JERuZQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRoRoRVGwdEY++IpuLEjduAwHTaTYLKBCeZdkfBhZ5I=;
 b=nKVoOEKmq9EYozbRv58ECeJ8QcVeFDeQ5GmCY0iMjW5ajx3pe+2FavfZ2Bk8HqkwmJoZqhV4v4HdcRmjR0o/mpFjSNOYBKNdMLRq59pIZeTYs1lhjW/VI5zDyPJEdaPLcm3lYciBPwgKz7U1EQGgVBkpct3YOy7S/vxxr6JLlxECCnrPzd4iPe2nKTjtsGl7ak/vmCErTTTsvURoyXxeg9iShMfkCw+LytKjQOUT+2Lbj/HOGn3tyWdBt3qbzJUWGjyOwd6BXW4pQX7CBfq0GmZX51ycwqgMq86ZrYZ+1r2uCMVbm5xlXFOuaNBkBtxI3QGwkSc7ukVVEw3rDjqYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRoRoRVGwdEY++IpuLEjduAwHTaTYLKBCeZdkfBhZ5I=;
 b=TbBeL2WAg7xdXANKLpF6/v73BL/n9nPjjv/qEUBS11LkUIiR4IB7PlBy8MdB/tdSWWtrgJOv9t33zNxSKK3d3pvQE/kIdly2U4m/ZJTB0jmhwl+HlxbWOiprHuO/yCIiQjFNpoPZE5KdpVQi68eAyJ1VO7NbELK1U+UzIJ/5Y6w=
Received: from MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::12)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:45:14 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::c5) by MW4P221CA0007.outlook.office365.com
 (2603:10b6:303:8b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 11:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 11:45:14 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 06:45:11 -0500
From:   Swapnil Sapkal <swapnil.sapkal@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH v1 0/2] amd-pstate-ut: Fix issues observed after loading amd-pstate-ut driver
Date:   Fri, 18 Aug 2023 11:44:50 +0000
Message-ID: <20230818114452.66780-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c0c375-660b-4b2f-027a-08db9fe09615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZA3vDCce2hEW2cStWZI49VZGZrc4hymmzBea3Y4FN9jQrS2Y8OztMGoeHALeyiZgVaKjbi5NsgJRFaK44zL5bj8ff60p725kY7QjkwrfbbQExaszw6/yclb2HH5osIe2GwmBB+147ZByNhEz7a9gwGE8blQv+7u8QhmpNLrd0GIRxdPtBTeXRaBsK1p1Z70+wPX72ZnHOdPomeIVYmaX5M+yAaMFg4N3Vv7+un+tdUqypj04HRFMYllDAzTTV/PCpyVB088u1iYzecXifzF6c9D8RoeBrtKoakAfRf+nDOZYpGEPr/ei5UwvLVLg3n7QZmqWxKReBYPF0fdWGXsHl2ARpzOPdDgvEjAxauebvoGR/meLyMwPV76M2WIX64vy5HLyaSudRfBGXHrYzvRglojywlohqN6zJ1qZVVwqMfbiZOegbWQ63tDdXftuU91dprbWR3kqO6ijoN0A3tGCksN7YbbU6ocTBIAdB6PbN5SxZwfDZpZsk9adRHYSNbDOBV65SPyskJuXjshsyyMj6+0p/b3Xuqs69dmIGyG8vZrh/LiOpAqdTrypLgPA/frcd/CFwISL64A5T7azywox+l592iW6Pi3dZXVr9EP8Fd8CElKmeTP9C7XADz71kYR8PTfGxQ63+NDuELF8lj4g89aa4jfX3Pn914EuPhUyrwRbkNaXBm2xXM6MCDt8DQQoNnej/vBkslbSFzeSMvpD0Q3BGGjs8d01Kh+YMv9zwQyDMfVTMekP0aj/BTmgUEdflmO0OnPAceworoClO2QhThlpzFyLo3qTAdSSZrvE+y8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(6666004)(7696005)(40460700003)(86362001)(16526019)(336012)(426003)(1076003)(26005)(40480700001)(83380400001)(36756003)(36860700001)(47076005)(81166007)(82740400003)(356005)(2616005)(2906002)(54906003)(316002)(41300700001)(70206006)(70586007)(110136005)(44832011)(5660300002)(8676002)(4326008)(8936002)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 11:45:14.0788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c0c375-660b-4b2f-027a-08db9fe09615
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes amd-pstate-ut which is currently failing for two
reasons:

1) The code for amd-pstate-ut was written when CONFIG_X86_AMD_PSTATE
was tristate config and amd_pstate can be built as module. In
current implementation the driver is built-in and previous module
parameters are removed. But amd-pstate-ut still try to read old module
parameters. Therefore, test fails. First patch fixes this issue by
removing those module parameter references.

2) In amd_pstate_ut_check_perf() and amd_pstate_ut_check_freq()
functions, cpufreq_cpu_get() is called to get policy of the
cpu and mark it as busy. In these functions cpufreq_cpu_put()
should be used to release the policy. As cpufreq_cpu_put()
is not used to release the policy, any other entity trying to
access the policy is blocked indefinitely. One such scenario
occurs when mode of amd-pstate is changed. Second patch fixes this
by calling cpufreq_cpu_put() wherever necessary.

Swapnil Sapkal (2):
  amd-pstate-ut: Remove module parameter access from amd-pstate-ut
  amd-pstate-ut: Fix kernel panic due to loading amd-pstate-ut driver

 drivers/cpufreq/amd-pstate-ut.c | 46 +++++++++++++--------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

-- 
2.34.1


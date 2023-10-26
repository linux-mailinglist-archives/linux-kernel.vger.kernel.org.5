Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C1B7D808D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjJZKUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjJZKT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:19:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08805183;
        Thu, 26 Oct 2023 03:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjDQhk3BTaHf1puXXQfel6WxZYnn3ln4YU/tiEzw+JUNK+aYoEpxsfVcHeJbMGXmGkvxyMHMtnE8lRrE3i8Ak6K7F32XOAAb1/MlgPKoyqIA3/TDOpUCQ0JuJUUoKY0ejnZJMI6n3XACtanfpDZ4Hle5+yyRuSnh3KHBZEcHywi56kMOJpXylvWvhQO1VKGsihQlECtBreXRLEFOsabEYeXEa8MIGA+DiHI5atVRaRIj78xBDnP8PZoN5viIptGL+vJf7KL8MoqWkAUX6pE793ZvGZuKugwgO0iZxKEsU+fH6iyaJxnyGcFk1D/Ki7HWGvYmATTWI9Vno/H40pmVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7A2msJK1mMVWEzK13eh7HgWcAo7c5Sy4eqyfHOUS7tA=;
 b=NrWAOuRuDs1B0BPx/K82JlwL5OIB2Bw/8tNDpGT3BNOCAO1ah5nPbtQoP7xoz1xCE4TkMssjAOkh8WOJVKSkbu1qHShLnGxDUdB6O+DtCI7nSYgIVcne3LrOpbLiLjiA54Bh3cLXQW8+JYaG+SoLID6vq/pVchOpXZAo8w6Z3SlKhTFN94de/E+bbndbRmIMwUzPuxUG1z6NyrfV5fXkNftY0yev4/oV1EYAq9vGpDhPf0Bzhse4DsLUk/TA4qlxUnuqu7rgxOKcNbgNBii6yItelERWe4uLHbZxq2O+zcWooybjBzVwh8CYWufLKk1bFROOb1qDW9/G/vtXGCYnGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A2msJK1mMVWEzK13eh7HgWcAo7c5Sy4eqyfHOUS7tA=;
 b=RmZw4eyDp30p74ecssv7BkYVeLNOTlqWHP+fCNQx3ra3E9grpRdlTmW+VFMLG0NaJdMnILLLfcmYCXem3T3Sy5mKqrZUFlVA0wlGSK8+0pa1tNGDjNK2UDc/xeCM2dJcZzA5h7fHBEn5zYpiKexbcOZMhXcgN1V0sW1WHVGBDsM=
Received: from SJ0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:a03:39c::21)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 10:19:49 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::84) by SJ0PR03CA0346.outlook.office365.com
 (2603:10b6:a03:39c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Thu, 26 Oct 2023 10:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 10:19:48 +0000
Received: from BLR-5CG13462PL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 05:19:42 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Wyes Karny <wyes.karny@amd.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <qyousef@layalina.io>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <lukasz.luba@arm.com>
Subject: Re: [PATCH 0/2] Rework interface between scheduler and schedutil governor
Date:   Thu, 26 Oct 2023 15:49:27 +0530
Message-ID: <20231026101731.2q6u4mhfhuqrnmbk@BLR-5CG13462PL.amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013151450.257891-1-vincent.guittot@linaro.org>
References: <20231013151450.257891-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 4927dabb-780d-4de0-7f4d-08dbd60d15a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFVD75QTFMRb+mFH7rnBylkNsOrlVNDOvTXYp5tVzNGcG3DyWyYaE3JFrS8WYBWwoOMmy/Ob8CflsQ0FCAsDLVmauDP8vQ4PccJQ4YsDFSYb2J4SnOwOkSzVadaDniBu8TKaflsWUmNm2vLRWHigs0aTwHw7c9oRXJlR3q/3eXYsGjumn/JD74J2YBmLsqkXfRn9E4zlkDBg2pYTbcN2xoP2O58iFmTUEcVtjYwry1GFcmZK5NzlF/8UCP2OyRC6L5+MI0qZXlTJpv9Fd7a/e/XzGmj8FS0GW2leZLsH6p+Szjs596Q18mT49POSgt/OvBRxicawcs85QFTaV/I8+trMziYLU4pTEZLCsbN8PMnQYglrgrg1euwU03saRd2KsacadSm+EH6iM03QXSwz8xWWBsnAHskDAs0lzfFwobtGVXg4I5chxpThRG264nKR5PNYKlIHQe+GVEpnlTBP8hUwyixFJdzXcetKPG7LjUvdMIO+1I+1Vj6s5WFVbASEz88JG03ApkugWRAZm1mRvDbLMVaDR328twpRCrqsRgSBeXakIJ8YGk5i5+W0kIqPrvgau1+hd98XPzOS5qs6llflwVXE7+AbJHa3lDoldOQEL0vgUV5ZBcLwRRUQjzlkpPmxFAJ1m4cKeg70sPuSFvPpJgMM+dO+uxAGH4KtZv5WoQg2+qgHeH+MVeNapK+P5z7BU8DUEWsI+tqxWpbJqZmN6+LMysYTN+LZ5G5Yub70dj22FQ3CvQSn5IqvSUxR3HMjJ3gbdFKzNpSeV/DOfGB44CG2Wkk5+FBnyUQE+VVizvExadLOqqntx+Px8MkL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(82310400011)(1800799009)(451199024)(186009)(40470700004)(46966006)(36840700001)(26005)(66899024)(478600001)(1076003)(7696005)(426003)(336012)(6666004)(316002)(6916009)(40480700001)(54906003)(40460700003)(70206006)(70586007)(36860700001)(47076005)(86362001)(16526019)(40140700001)(966005)(44832011)(356005)(30864003)(81166007)(83380400001)(7416002)(8676002)(4326008)(2906002)(8936002)(82740400003)(5660300002)(41300700001)(55016003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 10:19:48.7777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4927dabb-780d-4de0-7f4d-08dbd60d15a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 13 Oct 17:14, Vincent Guittot wrote:
> Following the discussion with Qais [1] about how to handle uclamp
> requirements and after syncing with him, we agreed that I should move
> forward on the patchset to rework the interface between scheduler and
> schedutil governor to provide more information to the latter. Scheduler
> (and EAS in particular) doesn't need anymore to guess estimate which
> headroom the governor wants to apply and will directly ask for the target
> freq. Then the governor directly gets the actual utilization and new
> minimum and maximum boundaries to select this target frequency and
> doesn't have to deal anymore with scheduler internals like uclamp when
> including iowait boost.

I ran a duty_cycle (one cpu 1) test which does timed busy and idle repeatedly based on user input.

I used below bpftrace program to trace effective utilization:
bpftrace -e 'kretprobe:effective_cpu_util / cpu == 1/ { @eff_util[cpu] = stats(retval); @eff_util_hist[cpu] = hist(retval);}'

Below are the results on AMD server system:

--------------------------------------------------------------------------------+ -------------------------------------------------------------------------------+
                           Without patches on 6.6-rc6                           |                             With patches on 6.6-rc6                            |
------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
busy: 0%, idle: 100% :                                                          | busy: 0%, idle: 100% :                                                         |
                                                                                |                                                                                |
@eff_util[1]: count 4923, average 22, total 110935                              | @eff_util[1]: count 5556, average 10, total 58857                              |
                                                                                |                                                                                |
@eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
[1]                    6 |                                                    | | [1]                   14 |                                                    ||
[2, 4)                10 |                                                    | | [2, 4)                16 |                                                    ||
[4, 8)               862 |@@@@@@@@@@@                                         | | [4, 8)              1628 |@@@@@@@@@@@@@@@@@@@@@                               ||
[8, 16)             3782 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [8, 16)             3896 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
[16, 32)              52 |                                                    | | [16, 32)               2 |                                                    ||
[32, 64)              44 |                                                    | |                                                                                |
[64, 128)             40 |                                                    | |                                                                                |
[128, 256)            38 |                                                    | |                                                                                |
[256, 512)            43 |                                                    | |                                                                                |
[512, 1K)             40 |                                                    | |                                                                                |
[1K, 2K)               6 |                                                    | |                                                                                |
------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
busy: 100%, idle: 0% :                                                          | busy: 100%, idle: 0% :                                                         |
                                                                                |                                                                                |
@eff_util[1]: count 5544, average 974, total 5400203                            | @eff_util[1]: count 5588, average 972, total 5435602                           |
                                                                                |                                                                                |
@eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
[0]                    9 |                                                    | | [0]                   17 |                                                    ||
[1]                    0 |                                                    | | [1]                    0 |                                                    ||
[2, 4)                 0 |                                                    | | [2, 4)                 0 |                                                    ||
[4, 8)                 0 |                                                    | | [4, 8)                 0 |                                                    ||
[8, 16)                0 |                                                    | | [8, 16)                0 |                                                    ||
[16, 32)               0 |                                                    | | [16, 32)               0 |                                                    ||
[32, 64)               0 |                                                    | | [32, 64)               0 |                                                    ||
[64, 128)              0 |                                                    | | [64, 128)              0 |                                                    ||
[128, 256)             1 |                                                    | | [128, 256)             0 |                                                    ||
[256, 512)             0 |                                                    | | [256, 512)             0 |                                                    ||
[512, 1K)           5532 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [512, 1K)           5571 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
[1K, 2K)               2 |                                                    | |                                                                                |
------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
busy: 10%, idle: 90% :                                                          | busy: 10%, idle: 90% :                                                         |
                                                                                |                                                                                |
@eff_util[1]: count 5073, average 102, total 519454                             | @eff_util[1]: count 5555, average 101, total 566563                            |
                                                                                |                                                                                |
@eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
[1]                   10 |                                                    | | [1]                   21 |                                                    ||
[2, 4)                 6 |                                                    | | [2, 4)                10 |                                                    ||
[4, 8)                 0 |                                                    | | [4, 8)                 0 |                                                    ||
[8, 16)                0 |                                                    | | [8, 16)                0 |                                                    ||
[16, 32)               0 |                                                    | | [16, 32)               0 |                                                    ||
[32, 64)               0 |                                                    | | [32, 64)               0 |                                                    ||
[64, 128)           5057 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [64, 128)           5524 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
busy: 20%, idle: 80% :                                                          | busy: 20%, idle: 80% :                                                         |
                                                                                |                                                                                |
@eff_util[1]: count 5112, average 198, total 1017056                            | @eff_util[1]: count 5553, average 201, total 1118650                           |
                                                                                |                                                                                |
@eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
[1]                   13 |                                                    | | [2, 4)                22 |                                                    ||
[2, 4)                 6 |                                                    | | [4, 8)                10 |                                                    ||
[4, 8)                 0 |                                                    | | [8, 16)                0 |                                                    ||
[8, 16)                1 |                                                    | | [16, 32)               0 |                                                    ||
[16, 32)               0 |                                                    | | [32, 64)               0 |                                                    ||
[32, 64)               0 |                                                    | | [64, 128)              0 |                                                    ||
[64, 128)              0 |                                                    | | [128, 256)          5521 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
[128, 256)          5092 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| |                                                                                |
------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
busy: 30%, idle: 70% :                                                          | busy: 30%, idle: 70% :                                                         |
                                                                                |                                                                                |
@eff_util[1]: count 5136, average 297, total 1528840                            | @eff_util[1]: count 5548, average 297, total 1650683                           |
                                                                                |                                                                                |
@eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
[1]                    7 |                                                    | | [0]                   17 |                                                    ||
[2, 4)                 8 |                                                    | | [1]                    0 |                                                    ||
[4, 8)                 0 |                                                    | | [2, 4)                 0 |                                                    ||
[8, 16)                1 |                                                    | | [4, 8)                 0 |                                                    ||
[16, 32)               0 |                                                    | | [8, 16)                0 |                                                    ||
[32, 64)               0 |                                                    | | [16, 32)               0 |                                                    ||
[64, 128)              0 |                                                    | | [32, 64)               0 |                                                    ||
[128, 256)             0 |                                                    | | [64, 128)              0 |                                                    ||
[256, 512)          5120 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [128, 256)             0 |                                                    ||
                                                                                | [256, 512)          5531 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
busy: 40%, idle: 60% :                                                          | busy: 40%, idle: 60% :                                                         |
                                                                                |                                                                                |
@eff_util[1]: count 5161, average 394, total 2036421                            | @eff_util[1]: count 5552, average 394, total 2189976                           |
                                                                                |                                                                                |
@eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
[0]                    2 |                                                    | | [0]                   16 |                                                    ||
[1]                    9 |                                                    | | [1]                    0 |                                                    ||
[2, 4)                 2 |                                                    | | [2, 4)                 0 |                                                    ||
[4, 8)                 0 |                                                    | | [4, 8)                 0 |                                                    ||
[8, 16)                0 |                                                    | | [8, 16)                0 |                                                    ||
[16, 32)               0 |                                                    | | [16, 32)               0 |                                                    ||
[32, 64)               0 |                                                    | | [32, 64)               0 |                                                    ||
[64, 128)              0 |                                                    | | [64, 128)              0 |                                                    ||
[128, 256)             0 |                                                    | | [128, 256)             0 |                                                    ||
[256, 512)          5148 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [256, 512)          5536 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
busy: 50%, idle: 50% :                                                          | busy: 50%, idle: 50% :                                                         |
                                                                                |                                                                                |
@eff_util[1]: count 5226, average 491, total 2567889                            | @eff_util[1]: count 5559, average 489, total 2722999                           |
                                                                                |                                                                                |
@eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
[0]                   10 |                                                    | | [0]                    2 |                                                    ||
[1]                    0 |                                                    | | [1]                   20 |                                                    ||
[2, 4)                 0 |                                                    | | [2, 4)                 6 |                                                    ||
[4, 8)                 0 |                                                    | | [4, 8)                 0 |                                                    ||
[8, 16)                0 |                                                    | | [8, 16)                0 |                                                    ||
[16, 32)               0 |                                                    | | [16, 32)               0 |                                                    ||
[32, 64)               0 |                                                    | | [32, 64)               0 |                                                    ||
[64, 128)              0 |                                                    | | [64, 128)              0 |                                                    ||
[128, 256)             0 |                                                    | | [128, 256)             0 |                                                    ||
[256, 512)          5188 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [256, 512)          5526 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
[512, 1K)             28 |                                                    | | [512, 1K)              5 |                                                    ||
------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
busy: 60%, idle: 40% :                                                          | busy: 60%, idle: 40% :                                                         |
                                                                                |                                                                                |
@eff_util[1]: count 5303, average 587, total 3115494                            | @eff_util[1]: count 5549, average 588, total 3264071                           |
                                                                                |                                                                                |
@eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
[1]                    2 |                                                    | | [0]                   17 |                                                    ||
[2, 4)                 8 |                                                    | | [1]                    0 |                                                    ||
[4, 8)                 4 |                                                    | | [2, 4)                 0 |                                                    ||
[8, 16)                0 |                                                    | | [4, 8)                 0 |                                                    ||
[16, 32)               0 |                                                    | | [8, 16)                0 |                                                    ||
[32, 64)               0 |                                                    | | [16, 32)               0 |                                                    ||
[64, 128)              0 |                                                    | | [32, 64)               0 |                                                    ||
[128, 256)             0 |                                                    | | [64, 128)              0 |                                                    ||
[256, 512)             0 |                                                    | | [128, 256)             0 |                                                    ||
[512, 1K)           5289 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [256, 512)             0 |                                                    ||
                                                                                | [512, 1K)           5532 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
busy: 70%, idle: 30% :                                                          | busy: 70%, idle: 30% :                                                         |
                                                                                |                                                                                |
@eff_util[1]: count 5325, average 685, total 3648392                            | @eff_util[1]: count 5542, average 685, total 3796277                           |
                                                                                |                                                                                |
@eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
[0]                    9 |                                                    | | [0]                   15 |                                                    ||
[1]                    0 |                                                    | | [1]                    2 |                                                    ||
[2, 4)                 0 |                                                    | | [2, 4)                 0 |                                                    ||
[4, 8)                 0 |                                                    | | [4, 8)                 0 |                                                    ||
[8, 16)                0 |                                                    | | [8, 16)                0 |                                                    ||
[16, 32)               0 |                                                    | | [16, 32)               0 |                                                    ||
[32, 64)               0 |                                                    | | [32, 64)               0 |                                                    ||
[64, 128)              1 |                                                    | | [64, 128)              0 |                                                    ||
[128, 256)             0 |                                                    | | [128, 256)             0 |                                                    ||
[256, 512)             0 |                                                    | | [256, 512)             0 |                                                    ||
[512, 1K)           5315 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [512, 1K)           5525 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
busy: 80%, idle: 20% :                                                          | busy: 80%, idle: 20% :                                                         |
                                                                                |                                                                                |
@eff_util[1]: count 5327, average 780, total 4160266                            | @eff_util[1]: count 5541, average 780, total 4326164                           |
                                                                                |                                                                                |
@eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
[1]                    8 |                                                    | | [0]                   17 |                                                    ||
[2, 4)                 6 |                                                    | | [1]                    0 |                                                    ||
[4, 8)                 0 |                                                    | | [2, 4)                 0 |                                                    ||
[8, 16)                0 |                                                    | | [4, 8)                 0 |                                                    ||
[16, 32)               0 |                                                    | | [8, 16)                0 |                                                    ||
[32, 64)               0 |                                                    | | [16, 32)               0 |                                                    ||
[64, 128)              0 |                                                    | | [32, 64)               0 |                                                    ||
[128, 256)             0 |                                                    | | [64, 128)              0 |                                                    ||
[256, 512)             0 |                                                    | | [128, 256)             0 |                                                    ||
[512, 1K)           5313 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [256, 512)             0 |                                                    ||
                                                                                | [512, 1K)           5524 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
busy: 90%, idle: 10% :                                                          | busy: 90%, idle: 10% :                                                         |
                                                                                |                                                                                |
@eff_util[1]: count 5424, average 877, total 4762032                            | @eff_util[1]: count 5548, average 877, total 4869975                           |
                                                                                |                                                                                |
@eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
[0]                    9 |                                                    | | [0]                   17 |                                                    ||
[1]                    0 |                                                    | | [1]                    0 |                                                    ||
[2, 4)                 0 |                                                    | | [2, 4)                 0 |                                                    ||
[4, 8)                 0 |                                                    | | [4, 8)                 0 |                                                    ||
[8, 16)                0 |                                                    | | [8, 16)                0 |                                                    ||
[16, 32)               0 |                                                    | | [16, 32)               0 |                                                    ||
[32, 64)               0 |                                                    | | [32, 64)               0 |                                                    ||
[64, 128)              1 |                                                    | | [64, 128)              0 |                                                    ||
[128, 256)             0 |                                                    | | [128, 256)             0 |                                                    ||
[256, 512)             0 |                                                    | | [256, 512)             0 |                                                    ||
[512, 1K)           5412 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [512, 1K)           5531 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
[1K, 2K)               2 |                                                    | |                                                                                |
--------------------------------------------------------------------------------+ -------------------------------------------------------------------------------|

Thanks,
Wyes
> 
> [1] https://lore.kernel.org/lkml/CAKfTPtA5JqNCauG-rP3wGfq+p8EEVx9Tvwj6ksM3SYCwRmfCTg@mail.gmail.com/
> 
> Vincent Guittot (2):
>   sched/schedutil: rework performance estimation
>   sched/schedutil: rework iowait boost
> 
>  include/linux/energy_model.h     |  1 -
>  kernel/sched/core.c              | 85 ++++++++++++--------------------
>  kernel/sched/cpufreq_schedutil.c | 72 +++++++++++++++++----------
>  kernel/sched/fair.c              | 22 +++++++--
>  kernel/sched/sched.h             | 84 +++----------------------------
>  5 files changed, 105 insertions(+), 159 deletions(-)
> 
> -- 
> 2.34.1
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CB97EF932
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346223AbjKQVJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQVJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:09:40 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D6D5B;
        Fri, 17 Nov 2023 13:09:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJ8sHXJfTWmaChe7C9Iuou7ui1zPDa9M1DaHOJ+vsGIsRL+Be4f7BsQjd6eZ/CvcnnTsTlbJrAjVBo2TIOGAUlHUS1nJ/ZQwS4e/qkWCdHyy/ILE36JmSG4f9VDW1v7XJNp6SF3E1jdAnUgNWnNWbRTDDKvt21xLSLa8q9Ip/6KXTl+Oa8oRR52cqBuxve6LG85yieyzlKc1FDxcl4ykXVZb3NhtVTY+E5D5OsoDcC5SdDV0JRk5ZrZRBEwTl5Kv/8ypjVUI6NhR5u+ULTM8O3ojUM/S/N3WQL0wOGztzqVjcUKWKudMQ4sUQqqQkdiZsZ7vYFbV/P0kYbDLIFQ4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFjVBSYbKgfE2Bz/hC5nGqwjQMdNyTyT0qijuDVXIy0=;
 b=duWF1LpR67FjaTYDndrSogNxRHNnmsXgCybEhLg3GUGihmCJD7sE3LSHyIf/IQvxOEL3/AdQ/YUWovYMa0KEpMgvH/+2UgFH924cOmAmsoJUDO3p4uVKtCBEnMe8yiMc67FsUs+8IxMkMbkNi9y0CygS6ALry5spT2j7suXfUTo26Tr9rp/xTCEWmKgTMyvaC4qpeXcYCwX/Jo//gNuYFdiEdcOuybXNCfXPUfWfNAM5EYKSMiaHa0RuLuWtz+7QX6gStDnN9wjCgh8xXOtg6myNBhFg1QuSTxGxBOrMiSz+wKlFM4aXGIOnMIJdyHXwY/WSe5QW0IOCrBUsWegBlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFjVBSYbKgfE2Bz/hC5nGqwjQMdNyTyT0qijuDVXIy0=;
 b=W6u6acKbD0t/2j9nQ2Zm/Tc/3O7GrUMIGaRoiZZ/uHBwLHWbg2gfrRV320Ud5a0+ivgB7MD2jBQMFNLlWkG2YtbklNT9zamhdYgKh/AX+mOwKdISpGhCkh87pT4khx7+U/Hv0Rzxu85VJWK3NV/hN6htuYrosRA6s7XelP1LTSQ=
Received: from MW4P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::25)
 by DM6PR12MB4960.namprd12.prod.outlook.com (2603:10b6:5:1bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 21:09:33 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::b7) by MW4P220CA0020.outlook.office365.com
 (2603:10b6:303:115::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Fri, 17 Nov 2023 21:09:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 17 Nov 2023 21:09:32 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 15:09:30 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <tobrohl@gmail.com>,
        <aalsing@gmail.com>, <Dhaval.Giani@amd.com>, <xmb8dsv4@gmail.com>,
        <x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/4] Extend time to wait for UIP for some callers
Date:   Fri, 17 Nov 2023 00:32:16 -0600
Message-ID: <20231117063220.65093-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DM6PR12MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a33e4c4-1b6c-4ae4-edb7-08dbe7b17f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUXEEU8JLmrbNDgVcCcqLKP+l6sNvP5UHZnjdoVxaJU99v9L/T6S8zou0tI022uS9cUwrN1OJx4odG0xopXyf7L4yOpNo+PmLqGV3jn15m1Y68q8WrrAwSFoFJX0kZ3xPoFp+421FgxuFdN5TefbXJ4fzwbgkZCKDbdkruNMIH2fRvEjvvKsarOU/VVcP59rT57YxYUPtzz17tttXzKj8ReOSOuBSZ9moOGg7ymdYKAe7jEdSPjcyY2E3afUMI00gfkOGNzOUOZM1+0XNyhoAVizVujojAODmI46LJt+QxoAYhyExD/EM+65dpLJ7kCmPcpB54uvc+jteNYQ0wOFGu6D3tWZLVkeGjDSYq4bMUWSCzJ5fQPTDOQe2v2WL0j391wwe7MEpL49uU2XqboCzAw0F2yipKnMmHfk/4kNMWGvKMMIyvq4iowodOSr0X1uTNPjaqZO9S8slsYjIJqB8PtayCmjMguPogFzrx4eQvZ8jG9d1WwFyl9Aw98f2ydsLg+2MVgHfSV4HdUbHxObjlnYqDrNdNP054CvvEHmXuoi6TNT5sUD1GxPPc2vdlhivCqtP+DxmtdQ1hRkoF1FmE/21ItzOEtqZPm9d60ZIcwOh1CNLjKz+UNszMAWlFdxGVDUgx6yD+rP6u5NjfNf6FS9/ALlhn6em/U5zqBr6uNoowjGUrmgh4nlUIScOIV0ijiYdPRguHAFNHPQTWzDWQsRC/lyj3Y2kdWC+sl7HNTtbbIYu81PX0OHfxraMsf8
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(70586007)(70206006)(110136005)(41300700001)(316002)(54906003)(86362001)(5660300002)(2906002)(4326008)(40460700003)(8936002)(7416002)(8676002)(44832011)(47076005)(81166007)(356005)(36860700001)(66574015)(426003)(336012)(82740400003)(83380400001)(6666004)(966005)(478600001)(40480700001)(36756003)(1076003)(16526019)(7696005)(2616005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 21:09:32.7923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a33e4c4-1b6c-4ae4-edb7-08dbe7b17f09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4960
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of users have reported their system will have a failure reading
the RTC around s2idle entry or exit.

This failure manifests as UIP clear taking longer than 10ms. Affected users
have reported that after this happens the clock jumps forward to 2077, which
is presumably from epoch + century bit.

Users who used a debugging patch provided by Mateusz Jończyk demonstrated
that this has taken upwards of 480ms in some cases.

This series adjusts the UIP timeout to be configurable by the caller and
changes some callers which aren't called in an interrupt context to allow
longer timeouts.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217626
Link: https://community.frame.work/t/responded-fw13-amd-fedora-39-system-clock-advances-50-years-during-overnight-suspend
Mario Limonciello (4):
  rtc: mc146818-lib: Adjust failure return code for mc146818_get_time()
  rtc: Adjust failure return code for cmos_set_alarm()
  rtc: Add support for configuring the UIP timeout for RTC reads
  rtc: Extend timeout for waiting for UIP to clear to 1s

 arch/alpha/kernel/rtc.c        |  2 +-
 arch/x86/kernel/hpet.c         |  2 +-
 arch/x86/kernel/rtc.c          |  2 +-
 drivers/base/power/trace.c     |  2 +-
 drivers/rtc/rtc-cmos.c         |  8 ++++----
 drivers/rtc/rtc-mc146818-lib.c | 35 ++++++++++++++++++++++++----------
 include/linux/mc146818rtc.h    |  3 ++-
 7 files changed, 35 insertions(+), 19 deletions(-)

-- 
2.34.1


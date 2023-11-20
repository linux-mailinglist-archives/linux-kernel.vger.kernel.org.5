Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5887F1579
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjKTOQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjKTOQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:16:24 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA818F3;
        Mon, 20 Nov 2023 06:16:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4kJMsYsvICIKhF6nRmsAtGr1OGHo2SlSNBO26WIltKu0IrLNFiCelEYjh8v73qtJ56JBOAOcnuFC57R910j6eM1rCOMMDmaGons+FJohTkwCTHuHtQrLQPOUvu3k9fKVJs/wc3g2zIdsH7ZCi2Vae4oJl3JOugSWSc0bocAHSjA6myz0dHT/Lakt38MNiqm/qQyBjYfzDMtobjFFZnxWUqCia6Y/+BjeJlqQ3QkpvsTa/TUG5TmhacN7sZYfEAkrVjNXKrAe134q6dotap1wuUzfl5cfnF6FyCHKT4nuUooxNi4qc4jDuudHNO66zwBSZoPRcj0IItXnPasoLi8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAOXC3Il6zKPkQArYBn3GUkotyZsIVw4geGYUAOIKzI=;
 b=G5XDCrpG2CKUKov1e7VPYUT1Dt90gYmoY5LBL0piXAEzg6gQLHXrkwgltyLH5PMwRxruIsFmkJzXinuGPWgzb8jGYJ+Bi63AOXtaPK0KUweC69O+23yCpo48o915q2kMQHzv+zkdZwwbMvNZmsTESHrVRFj/bhYP6FfktjWbQsd9oB4eMOvuZ6Bhz9dm0DrN/tn9eM7is8iOiyfqGOUrs4OOuStegXdvVDEvD52TA0ttSeI3RiwSwOcApZbOs80qSi1HnB6vON3KM9oZfBKY+1OSoEOsoo4J5qG+vp3qTv3aiN57SEQt2OR7WlkZaYLdT+5vYCFCQivEJ2V2UGZlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAOXC3Il6zKPkQArYBn3GUkotyZsIVw4geGYUAOIKzI=;
 b=NoJs5afJZfQhgdXvvu73Ie0QtcuRfyJM8OTlPpyGKng3eIkkwfr31c+ahpwG6InszO35HiR1KdFF/l/RjGjjhUttvivvkRXzgJEGYsafCRENUSzR8OwArXz8ZT1THpntoGBezPUqn2aVgQyPhKmbwgDAna/4h2oDKPdGcWchUdE=
Received: from CY8PR12CA0063.namprd12.prod.outlook.com (2603:10b6:930:4c::26)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 14:16:18 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::95) by CY8PR12CA0063.outlook.office365.com
 (2603:10b6:930:4c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Mon, 20 Nov 2023 14:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 14:16:16 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 20 Nov
 2023 08:16:14 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <tobrohl@gmail.com>,
        <aalsing@gmail.com>, <Dhaval.Giani@amd.com>, <xmb8dsv4@gmail.com>,
        <x86@kernel.org>, <dhaval.giani@gmail.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v2 0/4] Extend time to wait for UIP for some callers
Date:   Mon, 20 Nov 2023 08:15:51 -0600
Message-ID: <20231120141555.458-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8c04d1-df87-4f95-abe7-08dbe9d342bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TLB7BqK5iOSndhCXCw9adsYFv2+ZqnmOpmaNe0/bIMfaHI62MbFDFIw+sWeowp7SFAXp3ZUjKXj2wLEb1e/tEM9a3UBwMeDTnLn43Qb4SL4QHSSz8g3Vc8mq0sPnvdmPY4MU3lVwskTySGeQPB6m9WCP8EiYWScCYYt69nS5C37mX0Vul7vGeAdB4SCJ5OS0izA8LJ/zw+zavQH4N9DPM7NQ+1nZw+qKGW6LNfI+az9+DQkfAIYJOQbt9DV13cvPTu3y6OIEGMhSZySU3I0OpwiRwO4kYcW32m5zVTzB+sSU6K+H5kd3KgIdhR1jbWbSJo4HdAkApdCnU+wVNK1JfB2E2KH8YNq8oJEEDaZrlQrGcR3WKIKihFFaIoZC3qguZsEjxsQw/Hhb3w6QRILnfIWIHlpdFBXE+79WWVdkA6UcmSOeVlPUvq55EEUdxIzUEbYk7omcBSAjCmc9g/2WaQXBFdK/+MHJeS9hJHWKmmFLk+X/u3x5q+Ju7kBBIPGFthTDpLuFx+l6Lm+hCZTE9ly4YsVAtgaLdQQdTSaYtt+ygR+FSnXjmsJ0sPU257KVxwlFaCz9VnHctv9LvBX6MTFVC/0PnZq/0wLNKB+MTjOcv+cFhwakVKKbbgG88bFRFvRSQ8QiSaiQxpEIyLoDn1SKdpIY0rteS/2zjaKNbTNjLyNft3sMBWxzQru9a5ViXyk472/QIXafZViOxumY7CoQUOp049s+nVmDv7ETMliZPk8Jw5Xl2ClP7QseBKyxGEDq6OqGOiTaeK4oW4AgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(2616005)(1076003)(426003)(336012)(82740400003)(66574015)(26005)(16526019)(7696005)(83380400001)(356005)(81166007)(70586007)(70206006)(40480700001)(6666004)(478600001)(110136005)(47076005)(36860700001)(54906003)(316002)(86362001)(7416002)(44832011)(5660300002)(40460700003)(2906002)(4326008)(8936002)(8676002)(41300700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 14:16:16.9151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8c04d1-df87-4f95-abe7-08dbe9d342bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of users have reported their system will have a failure reading
the RTC around s2idle entry or exit.

This failure manifests as UIP clear taking longer than 10ms.

By a debugging patch provided by Mateusz Jończyk it is shown that this
has taken upwards of 300ms in some cases.

This series adjusts the UIP timeout to be configurable by the caller and
changes some callers which aren't called in an interrupt context to allow
longer timeouts.

Mario Limonciello (4):
  rtc: mc146818-lib: Adjust failure return code for mc146818_get_time()
  rtc: Adjust failure return code for cmos_set_alarm()
  rtc: Add support for configuring the UIP timeout for RTC reads
  rtc: Extend timeout for waiting for UIP to clear to 1s

 arch/alpha/kernel/rtc.c        |  2 +-
 arch/x86/kernel/hpet.c         |  2 +-
 arch/x86/kernel/rtc.c          |  2 +-
 drivers/base/power/trace.c     |  2 +-
 drivers/rtc/rtc-cmos.c         | 10 ++++-----
 drivers/rtc/rtc-mc146818-lib.c | 37 +++++++++++++++++++++++++---------
 include/linux/mc146818rtc.h    |  3 ++-
 7 files changed, 39 insertions(+), 19 deletions(-)


base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.34.1


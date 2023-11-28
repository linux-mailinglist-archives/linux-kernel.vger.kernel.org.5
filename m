Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA96A7FC2D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346323AbjK1Oqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346317AbjK1Oqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:46:35 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4043D6D;
        Tue, 28 Nov 2023 06:46:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay23RgrgoUDBgZAcNx9ph0hgBVZEj1zPUa5Idg4k9ZiM7XzcYajKzUdgvuMLItFI4S3diLw3aeRRwmYIbNCnP5e6cDYz+HVIcWAXn1nNuDk/5VfB5OuLBJvNidGU7CZkvUo81MSIuChlcyRs4TqqsfYUJfKZ+DaOxxLIC7T8VGyBm7xQvp0kvHfv/zdZhXI5tNjJuDrLpAcLrTz+/6kkDiIY++PK37dbjeKxMckubx5Shq0iPdIUx6FN/zLMMuRF92NDAEVd37pZ9r9Z5sjIeFsUjMEqcaG6BmTRahBvUnY+tXgAP79+1QiDBQ2JKa/SPPZ8euqO0xTxJqDlzY9reQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XYRjI85l3XoStfjzk+xdJAsFHr3djJ/4PNC0Gp5mbw=;
 b=jVQlqFLaLE+OwJAPqylDWpKKN1BkNeSVfkjA8ehsH504aG2UawwILoct8QKpTPvUXUnL1V1uNkG3UsVOk27V+1jrRr2s7N/fjxnt3TfRR/LKoTW5TsU5ffoHy/zWuQAEPAN43ZvV5a3dC8mk5hV2JFj3xSWuHFh112CJfGF/J/RtuZqgKXkeHELzgeJKXXfSvC1AiHiJnhBgcPlhPPuR4OlZvqxz5VUVGPhGCQcx0JcXsGATDWwSLck3ZDgra9FQLgRdbZjlctWTVG4a/S4mOwC4W3BvPxSL+Mt2ZxJfFfHg8YP0XuCsVDGazpiBtU/ocwP0S2xeryFH/BytA711ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XYRjI85l3XoStfjzk+xdJAsFHr3djJ/4PNC0Gp5mbw=;
 b=K5t6ay4ee/K9KVxhWe1tzgEL8WOSRu/wGwsYojcA/7+y01iQJ2+StddEYX1C8AWhNy1Y08Nc6OZWHADYf2kkBLutF4AYygDWdoXpCZavqPdWi4QFJ3L/USUyj/h/ZdGdyowwEiObbI1m5A/S9VPQaHZfGmRyp9MMzfaAaEIM+1A=
Received: from BY5PR13CA0012.namprd13.prod.outlook.com (2603:10b6:a03:180::25)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 14:46:39 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::7d) by BY5PR13CA0012.outlook.office365.com
 (2603:10b6:a03:180::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.17 via Frontend
 Transport; Tue, 28 Nov 2023 14:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 14:46:38 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 28 Nov
 2023 08:46:34 -0600
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 0/4] Extend time to wait for UIP for some callers
Date:   Mon, 27 Nov 2023 23:36:49 -0600
Message-ID: <20231128053653.101798-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f924ded-8169-4b3b-cdc5-08dbf020d3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adIhOoFaqtslCzu5l7rdE12wyiLlgnhivxOIYoQ5fig+QgHlT+K19L1+QbNgiwtttGSiOrebi+gCj0P8TKFayEmpMCUzGFc7vhMTjYHD3HbbjMiBJcn6bKU3L848Kp+8M855oN7MDocrAQMB01LFoXmtH5JVOO2UbBxx2FMyyfuvb1yYgm4OH69SMfZFee+hHYa2y9u4Y/IldGJmWzLutuRgUUEtPmRmpuvAV0AH7kEqwOqA7SDTu36PbxdvLJmoYE77SObP5xL2X0jV+n661Ohh7+R+Ztzmvn3c5BzJTbW/n3wccmVBsRb3r+S8oJly7LUmDxPMmFf/+KEr1NdcGMqcXpWnAqHE52kby0Vpwl6iUIL4ZiQ1BhSeJyk88oZpYSe0xqNLZaXgE4TbAd0IT3Ng0Qoc/xQDFMbNsFXPAl6Gn5mqM1Jhwd7wSnCluzc6UYaISWNPeSbcBDt05zsxfkMkFb5nbzTXi70hga814XX9Ju/n9CBQbJ5fU+HlBe9vrX67HJ+qwRWZcPqSN4oKq+9LpQN/4xSR2ilPRE9zpFKKKWsN9FZ0/QRUmZlqovTNBBRiIv3BmJSHjQ6sNghvfjMaybwQsx97GTflkMHqG+obUKnAWoT3s7xCJrsz/zBInqyia8HY0AJctekdhp2xvT2InrIXvSg1ceA+8Onvt0W5VRxFbWIlG4L5elX4U7r6y1DrRpxs9qRy2rDbFaepXJmoY89MXYBDmrh7+aWgAIQbhzE2J4PFKAJsP980B1xS1pQVg4LFDafRC5BljO2wBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(46966006)(40470700004)(36840700001)(40480700001)(26005)(6666004)(16526019)(1076003)(336012)(66574015)(426003)(2616005)(40460700003)(81166007)(356005)(82740400003)(36756003)(86362001)(7416002)(5660300002)(44832011)(41300700001)(2906002)(7696005)(47076005)(36860700001)(83380400001)(70206006)(316002)(54906003)(8936002)(8676002)(4326008)(478600001)(70586007)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:46:38.7805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f924ded-8169-4b3b-cdc5-08dbf020d3fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/rtc/rtc-mc146818-lib.c | 39 ++++++++++++++++++++++++++--------
 include/linux/mc146818rtc.h    |  3 ++-
 7 files changed, 41 insertions(+), 19 deletions(-)


base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23BF80F657
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377121AbjLLTQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376960AbjLLTQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:16:56 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBE083;
        Tue, 12 Dec 2023 11:17:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtEp/fYqpBiSzTvn6doFB1ycTFdNXxeEpPfv24Tsp+WRBnIreD/Xete2k1ZBX7y7/taI0DvsNY9xl2KtWpeD7EF92Jl10flsPrTD3tdOhNQVHmZbrd6art8/hquPpzLaoJM7FhXkVBbX8jTUUvSCOejrKlVkSxNO894745xbN9bJn+ktoA9+R9k94mqk78VIpH+b4ZfgKNGR2BwsPHSgRsuaCqsW6zuKq2h9gEjg4qKy6Lyt0GmWEm8Aezwy/50AYnGlQZ7Mal9AWerd1V0zkUBScpeEQ6tQbBJkWlLnt8TmxuwH12AMQxDG6oDLB8QdUcukFb4VPKep0KrSE2DAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUhthFUhBtxuA8moBvPCU0uOEKOUhr+O84ytXzkrkPg=;
 b=nFPdCrFyXK8E6BPUHm7qv79iwWQ8jGgzh6rO1np5c7foFD2ELmBo0d+nIiFFkvUm6D85HNkYGOsPvUU59yirRIKG0GxBMfEsbHi7BtsZ96bj0wT1koVqLhUzVeYMSucFcUmzlN+MZaTui18wDm9ZcgzdxH+wwXEeclWl0JU/6NdhX3Qbxi+b1gS9IOO9XhU0KB7R96GaTHzAkeOx7OcdUkPBbtVp7qCtKNTKq+T2JokjXANH/4uCvj8m6nTQX9xctW1ZErRL0E55wIsVX0HThJ5w+7SwekwqkOxlC5inCztgiVHCq1H0r/dYy0Q/qV+OlZJbMINlKLHomYFMgiQgAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUhthFUhBtxuA8moBvPCU0uOEKOUhr+O84ytXzkrkPg=;
 b=Zlf7Pz/tdo1pPx6TTgzHLQ9VwC2BMcRWl1d2+g9PMsfww32lPCFINXQ8dcqOnfy55OF/cy4eUOHfKOapj+ZAH1jWe6KsOfJK3sLQWeGD0Gfgm8FiyMmeJyJvc4iE9KImFKdbhn246aalddHZSrTJFMQKHW69EBhy2LrI/13umoM=
Received: from MW4PR03CA0014.namprd03.prod.outlook.com (2603:10b6:303:8f::19)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 19:16:59 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::9c) by MW4PR03CA0014.outlook.office365.com
 (2603:10b6:303:8f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 19:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.7 via Frontend Transport; Tue, 12 Dec 2023 19:16:58 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 13:16:55 -0600
From:   Sanath S <Sanath.S@amd.com>
To:     <mario.limonciello@amd.com>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <mika.westerberg@linux.intel.com>,
        <YehezkelShB@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sanath S <Sanath.S@amd.com>
Subject: [PATCH v2 0/2] Add support for downstream port reset(DPR)
Date:   Wed, 13 Dec 2023 00:46:33 +0530
Message-ID: <20231212191635.2022520-1-Sanath.S@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 685307fa-ec63-4a67-6424-08dbfb46e9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3lLYVpnrvlOYBtnNCOH64C4I0EIFaupkeLCj6anv/YlB7M7QlgxHdFI6Mjb268vYV+jetccO9AXvHIiRY/CtB4Us8jQNXIfPbZyw8T6aUj0Qpp+J9SJz4h290TzroTTF2qYcLKrkhZK1wsuPB7dKPEtjk6Kwhmhu3TdqV8Vt9WojAOWwW6Z+T8zwNTbYyztKmHIZi5pfFONGDkomJadGB2oCgy71p1DbNxUxxhRujv/WEtlUiLz7deZ18lw0CoRuWWGTFFiDIOaTsGFOBnsXavB7moWe0yIARr8wXuUOKLvLfJzHqHYBaCvgYf+8lMCP3A9sASdn8x5Og27AKQ8MlBeVsjEm7SVhgWR9cVfBfKqj/9or5WB52Ck/J9OzA8OMXa2QVeIGHtkrPgmScT+0yqEPigOylJdZBsB/QgAanjetJwtOtYd4t5pLX1gFKFN9MFM1iJMCHv1fSqfKnFJdAQhCqi0q3iYrl6ruCsXcO7nBo4gMIC9rkwrXLpHNPV/ss9yx3ry/P3aBKURt663Lpxv0XHFLAAnfgxnalL0dduHTGym2++szYqCawoaAXXdqtG9udxQSxVf7uR8wh7Y4wdTBWtE5+8COCG1X0OYY56HFtm9Po6mhGuMglyGaEyzD9sQjyEAWFm+cHocaRhiCNnnKp3pqMAICZBOdTbn2Yw/spsO+yvYSA/gT1lAc46mNN1zYk/dDjqZIUbstrFVgyeGHh5NATMJJ+0y3Lg0xqEONLkch6xkb9/s34VlHLyB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(336012)(40460700003)(16526019)(426003)(83380400001)(1076003)(7696005)(2616005)(47076005)(36860700001)(5660300002)(4326008)(41300700001)(8936002)(4744005)(2906002)(110136005)(8676002)(478600001)(26005)(316002)(6666004)(70586007)(82740400003)(70206006)(86362001)(36756003)(356005)(81166007)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:16:58.8090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 685307fa-ec63-4a67-6424-08dbfb46e9b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tunnels created by boot firmware results in incorrect PCI resource
allocation, which results in failure of extending daisy chain.

This series aligns with windows behaviour of performing a teardown of
tunnels and resetting the downstream ports using DPR during the init
sequence.

Changes since V1:
 - Perform DPR only for USB4 routers.
 - Update kernel-doc and return value to -EOPNOTSUPP.
 - Limit delay range to 10-15ms.

Sanath S (2):
  thunderbolt: Introduce tb_switch_reset_ports(), tb_port_reset() and
    usb4_port_reset()
  thunderbolt: Teardown tunnels and reset downstream ports created by
    boot firmware

 drivers/thunderbolt/switch.c  | 35 +++++++++++++++++++++++++++++++
 drivers/thunderbolt/tb.c      | 11 ++++++++++
 drivers/thunderbolt/tb.h      |  2 ++
 drivers/thunderbolt/tb_regs.h |  1 +
 drivers/thunderbolt/usb4.c    | 39 +++++++++++++++++++++++++++++++++++
 5 files changed, 88 insertions(+)

-- 
2.34.1


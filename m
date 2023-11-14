Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24A97EB025
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjKNMsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNMsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:48:37 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7761188;
        Tue, 14 Nov 2023 04:48:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWROQTQjmNwHDaix/jFfsGCGFTtPFSViq8UlpfW/JCurnXTDyzdh8L8pR7sxe2mBF9nxJwANqwljVValhHDe9buTibS0ONxO7wnps8WbogMBR8Mtz25ExFywDRPoxw7a8jgmyVrT59bsHvvxrNsPXJtvFuCDRi2NHvq+6dcFFQsDjB10FIu0SGm17UHZjpBn2Eye/Kj7QQDilnh2hzDhMVm/Hvwe/Gq1Uz/B/RFM3mGkHh0SqsPMevVXrwXCIFDAHuWXHyyHB5P/BPgWhvxqmzDXUlV7/OOEzSMka5xmmJuHrpTg7+56EY+1zUoH+CZgGQboH/kl+/0J/TQGvYJSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3M3Huc8bbRTfLdwdImM50O4HJXuZ+qWoYqr9Ai3pQOU=;
 b=JUL/pcqHdlBHREcBkrCXWee4TIq4h9QYFlpVFz/0vKahVdwyVKrGdyE/QhZHf8CHX1b1x6A3Swe3hn++wLkEeyQlWOjT+1sF8BaNgr8z+pQCZ81SV6QRAInK6tklHeMFGdzDyNGjRAca37VjrPwH/ZHuUb+X9C1WaD5TZMCUjmEwmRRWLXKNmo030LaJTuC1giGWpy4705YYt3AOwPHzY9SBv6icpt/WaQvUS4p/YkpVQo1hxZMemFm73q5I0A5qp7U0ln5e6TZ9akIIWtW2BZnmFTdGQW0V/W2OlIVPvxBj355OdBco4UIzewvfvz1vCVm6QZ56x2D1Wl91zFkxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3M3Huc8bbRTfLdwdImM50O4HJXuZ+qWoYqr9Ai3pQOU=;
 b=3kNvftOduzwrhfaU95upHxc9BoXrwvRF0selIv2bcdP1Y4mS7baPiu7GfW5rXJGVSlgRaSFC+H1p/iJ7EcxcmHUqj9qsdW1TnXms6dznrdgUAY2surpM6BjhZGnykSnAaQSwIDLj2xTneIa5SPX9vF3ASqyfZ2bXYNSys3kRSiE=
Received: from CH0PR07CA0020.namprd07.prod.outlook.com (2603:10b6:610:32::25)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 12:48:31 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::ff) by CH0PR07CA0020.outlook.office365.com
 (2603:10b6:610:32::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Tue, 14 Nov 2023 12:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Tue, 14 Nov 2023 12:48:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 06:48:30 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 06:48:17 -0600
Received: from xhdmubinusm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 14 Nov 2023 06:48:13 -0600
From:   Mubin Sayyed <mubin.sayyed@amd.com>
To:     <krzysztof.kozlowski+dt@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>, <michal.simek@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <git@amd.com>, <mubin10@gmail.com>,
        Mubin Sayyed <mubin.sayyed@amd.com>
Subject: [LINUX PATCH v2 0/3] Add initial support for TTC PWM driver
Date:   Tue, 14 Nov 2023 18:17:45 +0530
Message-ID: <20231114124748.581850-1-mubin.sayyed@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: a08f59cd-8c61-4c1f-dda9-08dbe51001b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sp4vTbk6bYrJs3NAKVfg3KhKUsZ7zTYEfUJ5IBJawQl1xoIPJUSFhSTJ2oIIDirXpBczQzEorUBZTQj0Gpzc9AzfmKx7vLidHT3yiUP+H5A4rosLhQ0hjczMymshkfNkZViEjxKd4luHWf+S7a3cS94CxnJp4segDtHYo8Bxlz0Zyr5EgEUCg+sIa26PLM57ff8QDfRGOGqgD983HUShiFcbXMzLWuXBcoKQwGLpeCVugWAD23NVuWbv/WZjvxsS5ruzP1PsqNS+7d2v056NEl8kbdt8HhQ13aSy8yEjh1dkfa93EnH6VnWDth93zP4HiMsBxE/guenM/bnWsXMFlvu4jXYHPEuJPSbuh9kUwRkWlxGTUSEIwWcUnCigwtKSXJfABRSOmkMKZVvobq6R6hMMFzImo+0BKyUuqKo3eoPQ5L/kZlCa02b6wzWN+bpnnbVk+9jTk9VbGRrBd2wHcZEtgmqqsyZ45vfK6+TDWnchQDf2e0Vt1M0wLH8mHErhQJlxECH3532KMZnaBc80F3as/eShL9gujNqHdYUe4jDjXjHswMgGaTdPlskN1e6g1aZxQWl6WbumEP6SsLzU4Z2oECm4WPsS/1ekJ7hSzFD+k63xXhNyqvZYhRqPB/YMkYYvkdNL8cmHCLtenTO56tlsw3q4fNXLPacGfklIpPkbbVUuMu5hJVeUaAPaar9AMFGIDzwYUiiPflJ8IpbO7vM0dyoOa2H2ZGfw3JwosVLyS8srdXCaUQqkNorLoCfM
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(8936002)(8676002)(40480700001)(40460700003)(54906003)(2906002)(4744005)(7416002)(5660300002)(4326008)(83380400001)(966005)(426003)(44832011)(36860700001)(356005)(6636002)(82740400003)(70206006)(86362001)(316002)(36756003)(41300700001)(478600001)(45080400002)(6666004)(47076005)(336012)(70586007)(110136005)(81166007)(2616005)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:48:31.3168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a08f59cd-8c61-4c1f-dda9-08dbe51001b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds initial TTC PWM driver. New driver would use same compatible string
as that of drivers/clocksource/timer-cadence-ttc.c.

Specific TTC device would be identified as clocksource/clockeven or PWM
device based on the pwm-cells poperty. Clocksource TTC driver checks for
pwm-cells property, if found, it just returns without acting on it.

link for v1:
https://lore.kernel.org/lkml/DM4PR12MB5938774A495A246EE5557BEF9DC69@DM4PR12MB5938.namprd12.prod.outlook.com/T/

Mubin Sayyed (3):
  clocksource: timer-cadence-ttc: Do not probe TTC device configured as
    PWM
  dt-bindings: timer: Add bindings for TTC PWM
  pwm: pwm-cadence: Add support for TTC PWM

 .../devicetree/bindings/timer/cdns,ttc.yaml   |  22 +-
 drivers/clocksource/timer-cadence-ttc.c       |   7 +
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-cadence.c                     | 370 ++++++++++++++++++
 5 files changed, 410 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pwm/pwm-cadence.c

-- 
2.25.1


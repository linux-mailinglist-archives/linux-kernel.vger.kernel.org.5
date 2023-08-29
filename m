Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7AB78CCBF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbjH2TOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbjH2TNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:13:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC34B8;
        Tue, 29 Aug 2023 12:13:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdhH6yzdpD5bqxjMQdhsnX5QuSMi5ouRr7m5IVHUzkek4+EkqlfDUYxCAeYlRJU1Bwoh0sRmV3L0Aeyn7ra1GFqTHQ2NqtDjwoLIgRavJDzKvHrTw5jRrgNIEPC0xdBudGSDdYQ7/nyWqbsdBuE+PyoCYpr5Xtq22jjrsaaEFnwe4tCaqG0jEaRDRorZbQ8MfiHPpV13dJFh+PAHB2bq8uG91S5CRFUbh1xo33y0HW0csshcMy7BXFifhGmuhqAOO2Ti2I4kPVWHx7Ya3r/hiUJmFM6Dt9Mkku8jPI+CGgIRzzlLiib+vaPIjGLVdryBYc9/v4vOkKT5vC8ZfEJRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QY5y0Rs/40NNgVl4c5GTEIwNXSixODlg2UL3cMgQos=;
 b=kz+8PJYO701AyFlWcvF2TZ6h6xvf8Dub+FsP9jno3I2fz5cXl7s3s3EgNIzwdzJClFP0uNJSo8POZDdcsP13e6m2B7CadVtzMBam9X2M/3V07xMFuF9nZ+97h5/aK+wPOQvSLnyyvQXAHaUeIzuD/wKDa7wI5O3kTmz/mvCGf3zpMC8QpTRODw94/oEEj0EBG9uUVkgKwI8CN/5Z94awVc61s5VUehCd8nptu8jlHNmTxjxnT0ej0KVgwu3UaW+evm0wnXPmaUzFSrTNt42mTGg/yCOnPjP6jzGmaew653bXTxLNZhoZmIMVZ8NQbGl09K/1lPPT0yOxMCjQv9vxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QY5y0Rs/40NNgVl4c5GTEIwNXSixODlg2UL3cMgQos=;
 b=ybws6WvTCmh6ulsRoaG0ixH+MYqP5NKZnifHZEw/GZ2iVGEFDS3QcdnViAVG7viC3cPWxdjFbyOMelDQjgWfFv2wAAGopJqQtT9yP/ZHL+ouS2Vb90bLB2Ggvj1qsDvZdPxeM+oI3Q1frgTEKKun0ALXZPAtVEvNFiX58GE/keg=
Received: from MW4PR04CA0063.namprd04.prod.outlook.com (2603:10b6:303:6b::8)
 by DM6PR12MB5005.namprd12.prod.outlook.com (2603:10b6:5:1be::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 19:13:33 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::7) by MW4PR04CA0063.outlook.office365.com
 (2603:10b6:303:6b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 19:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 19:13:32 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 14:13:31 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <linus.walleij@linaro.org>
CC:     <Shyam-sundar.S-k@amd.com>, <Basavaraj.Natikar@amd.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <regressions@lists.linux.dev>, <lucapgl2001@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/3] pinctrl-amd powerbtn handling regression
Date:   Tue, 29 Aug 2023 11:56:24 -0500
Message-ID: <20230829165627.156542-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DM6PR12MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd76740-0798-4f37-00da-08dba8c40980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZUvEieg7cEGZiCEwSgvI2zShkOeJztQ/K01OAaBmU3CV1/OK3/GLEIApF4leeFzbFOBVOm6shrDeUfrVV6CXlnRZHlMiPY6Qeo3mE1BsjKn27nWR8udyI2c8BHeG2wGpifxMcX/MARj6zMYHavpgfObVM24j0GcL6reWTxYCJ77W8QbDsu7F1bt1WGE00VgZ/XMa5mpw5I6KtRHUAqQfUvFH7tR0EcgWu6z6oF7sxVt0IZVK1RAU4pelUXxLWEIp7NGCxi7fDASqpMx64jDp32L7LNI/0Gphkjr0jrjjXve55h/1b0KZirdXMtLH8/4TXA7lDsXN+JRXz6+5QW5So8/LPFzFVBtLzLI3Qg5xKRBinjA0QrA5dncIpIV9eNwZH7Xl1Svj3x/uzgpMT9rQitjXNDExZfyjCN6FycJUCgLFKgEwsue9I9s+cqurD4FYAgXNzym/MAf+pXlMqbrNPEYLEtP32ZgAbB+V915uQRWB/SWJ26URDTyENZClwai4YTMj0UgG0TDspoG5hklnKmO9grLiKAWx2R4LyWZ1dBSclxeAqn/mKBeDxoSGb6vvBoD/xlz8r0DEZ06CqTwSO8DSCwi1mJMKuA6T69G5nvBYju3N7axLlDDq66M0mNJBc54F+4BmPqbkfOc2V0wkZqJWAbTjHm/9oaSHiYvVHUSi8uv6U8w3ClmDDQHt+9pGekvv4K05tuYkdWs4VBUbKBi+s7Tpw+ti6E7vGTVdhjGeY5AgalFfRH576kddjzGqKUgP+SFegqbGfnoFV+MIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(66899024)(6666004)(7696005)(2616005)(1076003)(40480700001)(44832011)(40460700003)(5660300002)(54906003)(8936002)(2906002)(6916009)(8676002)(70586007)(70206006)(4326008)(86362001)(36756003)(41300700001)(316002)(82740400003)(478600001)(81166007)(356005)(36860700001)(26005)(47076005)(16526019)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 19:13:32.7934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd76740-0798-4f37-00da-08dba8c40980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5005
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD GPIO controllers have a bit in one of the registers that sets debounce
to meet Windows certification requirements.

As many platforms ship Windows they enable this by default.
Linux was not using it until a bug fix commit a855724dc08b ("pinctrl: amd:
Fix mistake in handling clearing pins at startup") aligned the register
with the intended values.

On systems that program GPIOs through _AEI and handle interrupts in the
GPIO controller driver this makes them behave like Windows.

On systems that don't program GPIOs in _AEI, the interrupts aren't handled
by the GPIO controller driver this causes the GPIO to get "stuck".

It's stuck because according to the spec the interrupt is supposed to be
cleared by driver when the button is pressed less than 2s.

However as the GPIO doesn't trigger an interrupt, it can't be cleared
until another GPIO that is handled by the driver (such as touchpad).

This series adds handling behavior from the spec, but as it's not ideal
on the reported platform from the lack of interrupt to handle set a quirk
to revert the debounce behavior back to old behavior.

A module parameter is also added to let anyone else affected by this debug
it.

Mario Limonciello (3):
  pinctrl: amd: Clear `Less2secSts` and `Less10secSts` for GPIO0
  pinctrl: amd: Add a module parameter to configure power button
    behavior
  pinctrl: amd: Add a quirk for Lenovo Ideapad 5

 drivers/pinctrl/pinctrl-amd.c | 70 +++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-amd.h |  2 +
 2 files changed, 72 insertions(+)


base-commit: b4e880a8d840e2b64937ab47ad518185c07747e3
-- 
2.34.1


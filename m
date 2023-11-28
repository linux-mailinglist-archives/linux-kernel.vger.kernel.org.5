Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C72F7FC27C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346346AbjK1Oqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345841AbjK1Oqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:46:39 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6675C10CC;
        Tue, 28 Nov 2023 06:46:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atOo0kGInHztqzvQ58facD6fG6cteSnANyXzTNom+p0PO07H5w1GP7/Sij0rBsGHG2absooKTzAPEj9kAkdYp5nwecQUmPTdm+25KDjNZehX8c8McVNhFnYxxVExSoCiwGKpKEvZfa5s0b6/FtPuvYrDrCBDlH9JeQDhgzmlTHpD0vpdQZGbEBre0lDFXxVFJE1o+njqNV6UeF6FSis8Zhxph0mmMM1ROWzI7zrINxjMDrsIlBimnGgCFjjrQvZGuxM80qAR70C/iZPVGDiEalKgCvksEUAhBfzibwhhgEhK015LBuc6r78+V3+QSNmTnRcGW+RhDfyY6qebY7OUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koPpbArlYcE4vPhoQ+Ikg770yizTTTEAbSY0aTCnKVY=;
 b=C0EV6i7VZTrBz2sbwuZP2OJ4Q6+o21oxCatcrNBo/ufIeEj7zPVN8xDEuW0bBHQWngln/6pTAvUJIczxuctUvWPZdR/axStq93VYNQ3txW+opxkc713bo2FNia7ly+CkRtSVY8kp16bgspE2U39lU8wZRXgLAQeOszlzGZPf+OXiHP5LmRT9nJALiYFC44ZT+fkACC+IcNlF+VEREM7NfhJ0gkraL7fvUu2TYQGMOFbNs9JIvTxjVcWKp5QCAq+8UnC9OcCtp8lZewwgOCK5b17y4XLA0kDKMeIHogZJ9CAaeGhUJZLPt4TLUDpg4To3EnvwOEgUfgZQiD0Rm5xGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koPpbArlYcE4vPhoQ+Ikg770yizTTTEAbSY0aTCnKVY=;
 b=p0IaIJVib06pY5t7ytv/n9xYsp+YVobF0DEp+Onh5EG1zBQsPtZd2hVwrQ5u76OHIg+j+ryW/767gI7kQnW9XY49okz+543jNzuZ8WGZCh3PdnY4JQUhJ/l7njMqKQ+qIZR9+mAgLmEE/643BKxsvVmA8phvnbrhTGk+NVKK3CI=
Received: from BY5PR13CA0003.namprd13.prod.outlook.com (2603:10b6:a03:180::16)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 14:46:42 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::57) by BY5PR13CA0003.outlook.office365.com
 (2603:10b6:a03:180::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.17 via Frontend
 Transport; Tue, 28 Nov 2023 14:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 14:46:41 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 28 Nov
 2023 08:46:37 -0600
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
Subject: [PATCH v4 2/4] rtc: Adjust failure return code for cmos_set_alarm()
Date:   Mon, 27 Nov 2023 23:36:51 -0600
Message-ID: <20231128053653.101798-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128053653.101798-1-mario.limonciello@amd.com>
References: <20231128053653.101798-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 0626876e-76e5-410d-e253-08dbf020d598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Csee8n+vbtvsnQD57UQ0mDOyLsyQ4iF1hJ5AvrvhmMmUIYpRBGO/Yt0XCpj0w2k+nNhkxV7AbPbdj25zD3dKPZBL5Qj7yawxSJKRJpmUG9BMeJHAkqyNikWmGCb0g3e8G5ZYloQ6MJkX8E4GqobZJe2i3yqr0F3uTENTdt2d+yCWzB7BcFcjuLUflWMzuZTZYVLinCdhE+HJKAoxv1MY93gB4kq+kR38mgswN+1g9XjNYjLjGKN46WusCzJwe3Ff0PydeQoxrbuBCFaiJRdHyfWMC8nHYKOxJv5zXFl9zZocUMrWDZLxmGt3hhg9khk00RcY3UZOlVEkQ+kAOccLMSFPHARGTVeKezxsYZuOCxyEpzlgC5Jst4i052RpSBWMuzoOlBOOEiRwI2ic4XoXkRNyWYcy7HqkdfGMSeTly077aQOLdcTsb93ofvMAOWgFcKeIOUpJUGftyKp29kCyBZgq+pAoDis5lZgUygTasN/heEi0HHnQdlg+dtlNJCB2YuzDEzFyv9sZivtiozpk8Vc7Zauv1SoMZ6rByGLJIldzEtB6TGoxqWgur4d2iKjIF7YCPmQV+nyINOFClsPoCIHw0kK7YyIkfOYbuoJTbzRsLjIIqws2zuQMtv4fwc9QVXES6yyxfT1Is515WOBPG2I2ljBCJ0byz/EYn2jNmSEPE15006ExXUet7LQ/SHKYHvqWgvL1pxA4NshHQP2wAusvHemgeJMfiWO4Eag9XaEfL4xZnBzFTtV56vWzQ3l5qOvcdp0UvBJ5B4jSkNHZzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(81166007)(356005)(82740400003)(478600001)(36756003)(4326008)(41300700001)(8936002)(8676002)(86362001)(316002)(54906003)(110136005)(70586007)(70206006)(1076003)(26005)(16526019)(2616005)(47076005)(66574015)(426003)(336012)(83380400001)(7696005)(6666004)(36860700001)(44832011)(40480700001)(2906002)(5660300002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:46:41.4680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0626876e-76e5-410d-e253-08dbf020d598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878
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

When mc146818_avoid_UIP() fails to return a valid value, this is because
UIP didn't clear in the timeout period. Adjust the return code in this
case to -ETIMEDOUT.

Tested-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Reviewed-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Acked-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: stable@vger.kernel.org
Fixes: cdedc45c579f ("rtc: cmos: avoid UIP when reading alarm time")
Fixes: cd17420ebea5 ("rtc: cmos: avoid UIP when writing alarm time")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * cover cmos_read_alarm() too
 * Add stable tags
---
 drivers/rtc/rtc-cmos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 228fb2d11c70..391f91d3d144 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -292,7 +292,7 @@ static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 	/* This not only a rtc_op, but also called directly */
 	if (!is_valid_irq(cmos->irq))
-		return -EIO;
+		return -ETIMEDOUT;
 
 	/* Basic alarms only support hour, minute, and seconds fields.
 	 * Some also support day and month, for alarms up to a year in
@@ -557,7 +557,7 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	 * Use mc146818_avoid_UIP() to avoid this.
 	 */
 	if (!mc146818_avoid_UIP(cmos_set_alarm_callback, &p))
-		return -EIO;
+		return -ETIMEDOUT;
 
 	cmos->alarm_expires = rtc_tm_to_time64(&t->time);
 
-- 
2.34.1


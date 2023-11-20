Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0CD7F157C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjKTOQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjKTOQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:16:25 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF0B112;
        Mon, 20 Nov 2023 06:16:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RULUSfo8EtKIsH91vVf2Dd+va+bhnRouNTcyTJFx8j+qekEiFUUKtzqh8PakThUBQvwIsgkw5rKopQHN29OxjeN4on/2/Taiw+dG0NLmADM9qejJq1DetdmlSmEPzAhTivP2yQS2GKA69A/jeA7PJOBpLhfW3rczKKOipaggsx1JK9F5HEKEKj34rxrguWIyzF++3BOpHxj5rFphl2UqvW6HcAn989ds7lhwJBpY4RmQW/3nensQFo2BkfBpzpzDtxB7DUYVWWlEQ2dWqTuzDy0goVutiFWNeQhpuJV7pbtq156tY0+Q22KUwRaR1hThM56xBlmVy9ic0P36Zqa4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoO2hsj6V7V8s3YNmSkGpN60ZmtwaHkyVi9LGkFRJGE=;
 b=iN9oW2Q22lfuwP0DaHSWgDztLv75lv5BS/59Epn00FkWB5dVShSB8OgtFAiQqHsNYQEO0ms0vAe2jOffEmns2JXESCIoKsdxNz9Sn9836e+7OCFOREj4zd3DBq4bBeWkGpvl0BIlcl2CcRjSK8KEAMD4wZ5FMOXxAlB8e8r1Yx6rn1K+sxXHvoD5yD9gjyrdLZJAUIgKOOhPCf16wKGdLCZ0gEdzVyqTx+a9fRudJlihmJPz0vr4oYb2jyGdIuo4AFUpr8B5n9+iKVsBvWZosYCLBgHgc7j0HuwXjBwB0m8RsWwbOa1uOBqzB7lAs4Ml0GXri+F/n6D2RNe2WHzgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoO2hsj6V7V8s3YNmSkGpN60ZmtwaHkyVi9LGkFRJGE=;
 b=WXAb1aj7NzTc4lWQ6bPrMGpR0bUVIsYidkOyD1dycSFFLL6nei3g0Dv57Eg7vwp7jUxrHm6cVHaEjx2mC59yMvN2iHN2RDulk+PMwQxavID+lJHpEi2JEsHXCTHUmWwcZBFVRQCDoRLy0nbuoDX/eP6YDkAKAj95JBLIZbTz8po=
Received: from CY8PR12CA0071.namprd12.prod.outlook.com (2603:10b6:930:4c::22)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 14:16:19 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::9d) by CY8PR12CA0071.outlook.office365.com
 (2603:10b6:930:4c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 14:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 14:16:19 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 20 Nov
 2023 08:16:17 -0600
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
Subject: [PATCH v2 2/4] rtc: Adjust failure return code for cmos_set_alarm()
Date:   Mon, 20 Nov 2023 08:15:53 -0600
Message-ID: <20231120141555.458-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120141555.458-1-mario.limonciello@amd.com>
References: <20231120141555.458-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ee09bf-3549-43aa-4ebb-08dbe9d34403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P14lE1DbBPSO+WKrAh6RO8nILE6ZwaOSDwQj7c9rxRzsOeTNSwEq7eco3bHJkKzUvRKhcqwfJkC/URGzPON3AG4I4/jbdFvcyuZgEzNKn+WM5hPzB+Il0p9pFVdxDm5E/gqd5Vy4MqmuerF77Dyi8SvaqskwuoBsJpiwQwKmpEoCXVyL0wc0JUQsGxj7O5VUVDFon9C+7zAAwBjqz/EF33YwN3RXhKxF1xQn7s+NqFAiDm0lwbPH7kcqH7WenyLf/T1hBOQfSD7FP7L5dlyUiCkGqQgBdfgCt1gqldubWt0864So6kvQG+1LGDRAZuOD2EzWzpgGOj3ImrZYTCbgjmgK/2Cfzs23DTH7rdp7gxvo63vB4/SrnZXc3bt4ssZl/9xWUF17KRtSWAyyMTl14uZ90YnCDY3CbKgWTXwPCIIEjZcTbTKdyaOFRqEtp/IjHkQQVToErAoy3QXUDwgqoqrTblznVUB7353OFgFybvmm9us/+8l0GCs1pQUwXfFYSd7jBHl0L1CZ2aHZNOvCaBBzf6GL1wVGWFHA42dQb6Vl1aDywQ8vzi9QPUYHY2LMwAzjDEP6FwhLvM9B17xz2Mek0+YwCCnf4u5pzSH0/SgwXdvYBp/HNBIr9EOEMNbeEuqPxecEpT1UFOdtFwipdLQzaJ+KzUDJ4F4xtUeotQT0g2ot3jp+dhdLqVsqV8/ZKSSfJCEr+XLmodSdjfbQTknpcjBzjkAg8UeuThEFXLeztC4XTOw46C7j+AcE1evJzeLGE42ditb0sLWbJCbs9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(70206006)(70586007)(110136005)(54906003)(316002)(7696005)(36756003)(6666004)(426003)(336012)(478600001)(2616005)(16526019)(1076003)(82740400003)(81166007)(356005)(83380400001)(36860700001)(86362001)(47076005)(44832011)(40480700001)(26005)(2906002)(5660300002)(7416002)(4326008)(8676002)(8936002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 14:16:19.0402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ee09bf-3549-43aa-4ebb-08dbe9d34403
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mc146818_avoid_UIP() fails to return a valid value, this is because
UIP didn't clear in the timeout period. Adjust the return code in this
case to -ETIMEDOUT.

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF24802090
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 04:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjLCDZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 22:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLCDY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 22:24:58 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED93D129;
        Sat,  2 Dec 2023 19:25:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0mmMj1iYygOWIT41Jz7XyLcAididk7sses968+cA5hCn4F0+vgdv/8yZo/4kdrAhcwmjp9R9vf2qqElisAvh0EeqjWfg6zCQE9voazO2bRJCCJQ5pGmHf1nyTSb/6fLxlxkOPkMaaSjo8Lz4JCXDMCO/pjKiiE3IBWkBMjdfvxmj0ArIQXlkhTgf8Uz5iKAFlPSGXqmV4uwhr1vGnHRcqpa/oUNlYeuoS0ngqwLb//eON0I1eS1GG04ZFCvd3o0ddIK6hJgoOWpJkHQkc0i8xoBvped0tLMWJ7U1HSCF0GhIkNgW8WZr8cCMfmenhUGZ0kcRPHd0D1efyagt2GNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkNnhou1V5ivCfCa5w9PIWPJQIN4sko9TxRljLDGuNc=;
 b=fKwYcgpXtjiRLjC8krrimGeBYGItzJBE6YOCdtLOWqxurDjMtHH0Ax5FuvG5FIs6lT+opaUvMo9xai2mN+8i8qhIJXAvOjm2q4j7B0XiGI6VXmGndmanSCWQ1eVXZDw4Ss4ZSDjMVvEmuTm/KlD8L+bTFIjQLdoX019sqAN7Wwh8YpCVoTffhpzKjEs+s3GOqb74mdj7R4EEwy8bgVsDVZ1/VSIqL4diOLN5yCcYLmoXBQ1pVvukkDx+go44GQvfwqvvuOk4iq8/lXpdPamuAHmNbKTXvD60IVDuDh8awfUvJAwEF86w2U7mJhKIO0AKm/8QU+/0xo9Zq2j+vOLjLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkNnhou1V5ivCfCa5w9PIWPJQIN4sko9TxRljLDGuNc=;
 b=q33j4/Mq/PceW3wtIXNFoTfADLRfwkSzg4Aqhx69FuULBIjN+kxUyW2RMxENUErqDk91fEO/KoJ4KM/9PNj2C7mQfmPPBC0KHRNDLX09B8Ir0zFU6292Jh16hYvbKgiBsn3Q2Wv194wwDWHX+BocvMuTUDu+vIa/p8GEppk+VnU=
Received: from BL1PR13CA0246.namprd13.prod.outlook.com (2603:10b6:208:2ba::11)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Sun, 3 Dec
 2023 03:25:01 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::b5) by BL1PR13CA0246.outlook.office365.com
 (2603:10b6:208:2ba::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.18 via Frontend
 Transport; Sun, 3 Dec 2023 03:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Sun, 3 Dec 2023 03:25:01 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 2 Dec
 2023 21:25:00 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Marcus Aram <marcus+oss@oxar.nl>,
        Mark Herbert <mark.herbert42@gmail.com>
Subject: [PATCH 2/2] pinctrl: amd: Mask non-wake source pins with interrupt enabled at suspend
Date:   Sat, 2 Dec 2023 21:24:31 -0600
Message-ID: <20231203032431.30277-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203032431.30277-1-mario.limonciello@amd.com>
References: <20231203032431.30277-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|BL1PR12MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: ad35fcfa-3ec8-4cb1-f4c9-08dbf3af6f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkU2i3/5BWJ0F6VTqPFwD4doCvcQF3zI2GfJnk8dqgG6BZ8efWhiSUyN5AuEg0dZ54huW26oWq63hZgcjiR4Ob+GTzmba2jVUhRzCGgzwnQk2O0EXG91vnM++sgDYhb7DVefnZHdIEU25Pa5bugQAR8vIe39Th2rd8IwlGlpowRYHhW2V5M1Ahclll4qbZekLT6rwZUNTPy9QJKrXdR++ncMPrJtXkbPWoq6okoauh4yuGld4DutjnW+U6GscPPIxDRdT2irEVftyQXZ+d0QlnlPCxgHoinr167DrokLgqFTmAtLVid2f3od2UlB4MSk6G13wuzu8tA+VrTslHqSAlCGizEa9HJrbtB9eCK54a1R6rSaj8jEbDqychdRDkg0pleO0wWcM36UKaM177yMe+5jNGDeTksL5ez6s2kJlwALhiiT916XvZLhQJMFSJmRsJPWoyIP41838jUs4AsGXca5y9EN5upM9x0ToRfX25wvGwUT7Li8jF4wGdJ5BLT1C6XtLz3b7Q0BAtGxqtwX03zfdUH3M1ijHuD6qZRlmrT1FeSSqyi5t4GAL6h7HuvHo1/BEWWwin1jJKj1u8iSxIOxKXqrCRmsUVvDmMrVU4EsGW1XAFFFXCVpKs3z5YheokMgY0S4QyyRWNIcBjq11Xd7afQ5GNNaB8n12FQkiVsPKhiqwsJqpFZ/wl1Lsbwr3wnemBv0eriMsUs+NZKzkbqxd0kfF8WH2xK8ze1WrfJiVG0B+VVHvjbBu4iF2FRI
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(5660300002)(40460700003)(44832011)(86362001)(4326008)(8676002)(8936002)(2906002)(15650500001)(41300700001)(36756003)(2616005)(40480700001)(1076003)(356005)(81166007)(82740400003)(426003)(83380400001)(16526019)(336012)(966005)(478600001)(26005)(7696005)(6666004)(47076005)(36860700001)(110136005)(316002)(54906003)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 03:25:01.4466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad35fcfa-3ec8-4cb1-f4c9-08dbf3af6f48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a pin isn't marked as a wake source processing any interrupts is
just going to destroy battery life.  The APU may wake up from a hardware
sleep state to process the interrupt but not return control to the OS.

Mask interrupt for all non-wake source pins at suspend. They'll be
re-enabled at resume.

Reported-and-tested-by: Marcus Aram <marcus+oss@oxar.nl>
Reported-and-tested-by: Mark Herbert <mark.herbert42@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2812
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 9 +++++++++
 drivers/pinctrl/pinctrl-amd.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index fb58acb843d9..03ecb3d1aaf6 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -923,6 +923,15 @@ static int amd_gpio_suspend(struct device *dev)
 
 		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 		gpio_dev->saved_regs[i] = readl(gpio_dev->base + pin * 4) & ~PIN_IRQ_PENDING;
+
+		/* mask any interrupts not intended to be a wake source */
+		if (!(gpio_dev->saved_regs[i] & WAKE_SOURCE)) {
+			writel(gpio_dev->saved_regs[i] & ~BIT(INTERRUPT_MASK_OFF),
+			       gpio_dev->base + pin * 4);
+			pm_pr_dbg("Disabling GPIO #%d interrupt for suspend.\n",
+				  pin);
+		}
+
 		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 	}
 
diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.h
index 34c5c3e71fb2..cf59089f2776 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -80,6 +80,11 @@
 #define FUNCTION_MASK		GENMASK(1, 0)
 #define FUNCTION_INVALID	GENMASK(7, 0)
 
+#define WAKE_SOURCE	(BIT(WAKE_CNTRL_OFF_S0I3) | \
+			 BIT(WAKE_CNTRL_OFF_S3)   | \
+			 BIT(WAKE_CNTRL_OFF_S4)   | \
+			 BIT(WAKECNTRL_Z_OFF))
+
 struct amd_function {
 	const char *name;
 	const char * const groups[NSELECTS];
-- 
2.34.1


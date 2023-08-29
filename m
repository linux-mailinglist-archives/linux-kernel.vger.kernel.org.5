Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD2078CCC1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbjH2TOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239768AbjH2TNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:13:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A111ED7;
        Tue, 29 Aug 2023 12:13:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rqdhjyyq9NNzIsmedmGkDBZ9De+SN/6CHuifz7GL97BXFw2+vtzjMtXyDkNezVT4fkq1NJeYGx0qfOecoa1VOJRJMgMVRxJeNBJILkwj1IatkJFZfbq6hH6qGr8lVmrUG4mMvCOgbYoN4ejUAwiW9ZzzQSA6cXypD6A16mCUHO7owEFujKaeQKewB6lwlJ5wtrD2DJrEWf7d36kXnqegipqWmT569rlbcMcb0PacODK15JwdN18nTrXqrPIP5+5EJxphZeD/8UrFj+DKbxNShUWPHpupWGSvOCe26U+WSiCuYpRn5L8LLqJbl5p4irHFoIOeYet0yDK+MU9Sdz3LeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5z0BMCrWmGusv1J7dh76sj6hcVi/iU3vAuCKEIES2I=;
 b=bfpS9VHG3u/oA4LKFgkGCO2Fcl1ehTeOXlrjFMu3OmhjeBqwWA8kvqMB647K1Cm/GjzgAiuAzzidlgIMVF+Dsq8i5nABJwTTR7bNZyvHO02d2OTjWc/I9+miq5tfR6+7wPvRbGaFvNhXwh6MsRXavzpdvGlVm+SO+oAAX2oFYXwF7gna6z9qfPbjUz/dC7dck4Z2ZDcFfWA+dTaJg9bRFParAOAP7e1kU8Ci6A3C05peZbQMQFg5usU/TJayw3q3eW8+mJs3Iky2yakAVTnlb7FGW7yezYnFykdAHRyvQJuHWthlaIo0UFLF2dPhdF+0dyOh1AYmEZ+fmBPjn4i9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5z0BMCrWmGusv1J7dh76sj6hcVi/iU3vAuCKEIES2I=;
 b=gv4LzS7qDcwzYeV5HeahjLwYccNMdq4pRX+cBM+Gvn5piGtHpOTde9V7k8xdQOQhur2oPwGlhEyD5jbw029ly2Ck8ecghj2MKjcfs9G3zlGeLsNRCITyHRooip9SV2lexJyeTkzq0EuAER+uyB9IGYJ5X5f4hgQVg1kEjs3Xp2g=
Received: from MW4PR04CA0065.namprd04.prod.outlook.com (2603:10b6:303:6b::10)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 19:13:36 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::10) by MW4PR04CA0065.outlook.office365.com
 (2603:10b6:303:6b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 19:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 19:13:35 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 14:13:33 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <linus.walleij@linaro.org>
CC:     <Shyam-sundar.S-k@amd.com>, <Basavaraj.Natikar@amd.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <regressions@lists.linux.dev>, <lucapgl2001@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/3] pinctrl: amd: Add a quirk for Lenovo Ideapad 5
Date:   Tue, 29 Aug 2023 11:56:27 -0500
Message-ID: <20230829165627.156542-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829165627.156542-1-mario.limonciello@amd.com>
References: <20230829165627.156542-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: d6bb0c98-1d01-41c7-11a3-08dba8c40b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BbPQ8aHZCuBh6kQKZOQqn3IENaG27qGCL82ekcH4nh1lBoJ8bbonNOcN36XKs1CqeSKBRMjR2N50O2in11vGA+lAnP7icv+wyF0zVefN+/w0kNYCZu8D8pAI5zDacqwPUrhmyl1AR3nsYvjVVZCpOpsBl6R+L0tXBMcwCF0IsyutbBirpPWhJNlkef5ZvOqAbYIHp2UdoTW3VglB2YzCVt20cSbMpuMeLMTUyYdmY9r0jU1WWXhogVPlzORcCjHWhdBUSWJlrP5yP9HYrwWkYorI4fuQrC8Z3noIUW7uQPJVDJUxZgn3yywuXWD9mVuZVwHmNeFdeRl6Eb673WzCYXdEO75jnPD/5xkjh8I36ippaOLcT1kH67WPqWC0NTFl9WcVJD2n6sbor8uXn+gvPLV115j27SVVeMMclOUyG6WfvNtXZXWTa0VEes00MA3mrRGnMl//RjA1v2Cgt0ijfSIqPjAxsmg/mo2yh890d8bSo9NpqsPywILFevZZowdkWakN9tRAWVOjCcqjSwY1aFfM7GKcJBSRJGLcpT4GwuHm+OknK458NkxwVV+ZjmEbhJYLv0H5JdUw4UHw2aU6s0YMGc5emJ23AWLj/3DqvudL0nIQ2wVqcRHMY3WW4wsNhDSMxbiSlYxB6N1aCn7HZ/TpzHG3rTpSY+aCsGSDQiLIpRVISZPjTG7mxrxm5iQ7X5JwHqrDiZOpHXcXupg9FGY62S252O3ZYpDZLntIf8XMSKlDjAImbsekxS/Qo/1/X4s0LCFb4j2ybU6TQeAO4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(6666004)(2616005)(1076003)(7696005)(40480700001)(44832011)(40460700003)(2906002)(5660300002)(70206006)(8676002)(4326008)(8936002)(36756003)(54906003)(70586007)(316002)(6916009)(86362001)(41300700001)(82740400003)(83380400001)(81166007)(356005)(478600001)(966005)(36860700001)(47076005)(16526019)(26005)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 19:13:35.9028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bb0c98-1d01-41c7-11a3-08dba8c40b58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo ideapad 5 doesn't use interrupts for GPIO 0, and so internally
debouncing with WinBlue debounce behavior means that the GPIO doesn't
clear until a separate GPIO is used (such as touchpad).

Prefer to use legacy debouncing to avoid problems.

Reported-by: Luca Pigliacampo <lucapgl2001@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217833
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index a2468a988be3..2e1721a9249a 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
@@ -41,6 +42,27 @@ module_param(powerbtn, int, 0444);
 MODULE_PARM_DESC(powerbtn,
 		 "Power button debouncing: 0=traditional, 1=windows, -1=auto");
 
+struct pinctrl_amd_dmi_quirk {
+	int powerbtn;
+};
+
+static const struct dmi_system_id pinctrl_amd_dmi_quirks[] __initconst = {
+	{
+		/*
+		 * Lenovo Ideapad 5
+		 * Power button GPIO not cleared until touchpad movement
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=217833
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82LM"),
+		},
+		.driver_data = &(struct pinctrl_amd_dmi_quirk) {
+			.powerbtn = 0,
+		},
+	}
+};
+
 static int amd_gpio_get_direction(struct gpio_chip *gc, unsigned offset)
 {
 	unsigned long flags;
@@ -1084,8 +1106,16 @@ static void handle_powerbtn(struct amd_gpio *gpio_dev)
 {
 	u32 pin_reg;
 
-	if (powerbtn == -1)
-		return;
+	if (powerbtn == -1) {
+		const struct pinctrl_amd_dmi_quirk *quirk = NULL;
+		const struct dmi_system_id *id;
+
+		id = dmi_first_match(pinctrl_amd_dmi_quirks);
+		if (!id)
+			return;
+		quirk = id->driver_data;
+		powerbtn = quirk->powerbtn;
+	}
 
 	pin_reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
 	switch (powerbtn) {
-- 
2.34.1


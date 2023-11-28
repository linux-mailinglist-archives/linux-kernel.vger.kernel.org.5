Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C058E7FC249
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346335AbjK1Oqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346303AbjK1Oqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:46:36 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0C28E;
        Tue, 28 Nov 2023 06:46:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7Mgffdz2hC/s6zCct7HDqjYDpCYwKCtNVv9lGYsWU2HYrhz1dl/f98ztRVhztkFbbkoCrxt87oA1ccbEfFLnadhJx3p2JH+AGnCylCrmOl4n5wC4qocOmMBtuFQh66/PGbzrvoXhRJURcEMOCCcoblur2VkEW5FY4yRN9buHJhwOALrJhLBbLSGdrHUzrgYCRhflv6fObzJGSmBbCoz0Ah11svbhGKGZU/xM5z4MN3DNERleAoE5mAbBSYJMc9MPGANq9XdUpedcI2WkDF+I4C7/VYJhHayTk/MbjWdNsx8wL/1IbjV5knL2+hFzVweJUuDK10RnK/HH7OwVunCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9ZrCFErcBAy7Yk6qivLfS3bEBNFGYcPShN6qVOcVYQ=;
 b=GWVhftJxAnjeHG18fbGelcmh3UkRFm4gXVb2H6TB3tZ82KsGg/aKL+8y/cDFDSfDj/sjJAN9KxtvjELfEFPtb2NoKLHoHq7Go71oHxoqxXAJlLSF3XXHY1I+GiF2M76um1I5g8lYbeFr0vC7VEsGRyUIVvGLSWruAkDWn67RHgOzGnxaDtraqaQjxC5wI6LC+tkOXVK8NAF+amVRq1sWpL2HR+NDS+Efc2Iz4YQYblX928Xw3OFC1ITlWqKKMp2JrKcT0J+fLZgux9XD2DQUtXWS5fwiB5g4lGJ1u4IgmsTyeMf5z1ZhjHkwpMWb9UVkrRwXyHvG+kMx95bE7cJl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9ZrCFErcBAy7Yk6qivLfS3bEBNFGYcPShN6qVOcVYQ=;
 b=3rS+6oCsX2U4QZ/30geX/AKk48QMkBcSKQ4wdIcjo9XTGWReU15fZrhC+qIg0y+/gpWf49YtZQXXDYShbX+dPJGl1eH3XG0C1LV89EGqREUOJSrZlsD1vxVR2APzvaluULNwUXXA/50TKtxzNVxQVkXIZca+kxW/iX4OrbNmdLc=
Received: from BY5PR13CA0026.namprd13.prod.outlook.com (2603:10b6:a03:180::39)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 14:46:41 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::8a) by BY5PR13CA0026.outlook.office365.com
 (2603:10b6:a03:180::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21 via Frontend
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
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 14:46:40 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 28 Nov
 2023 08:46:35 -0600
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
Subject: [PATCH v4 1/4] rtc: mc146818-lib: Adjust failure return code for mc146818_get_time()
Date:   Mon, 27 Nov 2023 23:36:50 -0600
Message-ID: <20231128053653.101798-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 71eb3626-0c07-4b2a-e696-08dbf020d53b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsyCSoGX8NGGGu7BQDlwvWP+9FHEI8s6/3mjsHLeCFMnSxmshg5Ty7R/CVL66FULH+gPkQc21IabFfmzEtQOGyhw3KwCfRQE+XhMrQR6mKbu/OWzUVnfMt8vUBFEy0EI6r0bxL637/rId12Xwxwr1Pjs9Dnqvz3AY7pcrjwMi17jp2bQdjlsELKCJL1n20WZS3z30SZ3d16IiReob647+KOnQ9lp0h+jbIf5ljxQWZDn9QezLI8r3Nm/FDmZcaARXwGKCoKDKrAQC1qgKbhy/48trCbxqvOT9yJhH+lakVCJa6Sc/zlHiPyGHf2rCVLa962HoH9TDAYcVpU/qUtPrAUdtwvfeV7QsJeCzP7Fg7sOE2jMCS4gBPG4kl9BcER1WLXGZ+xuR1qZSW8ZjTFGOmrkh+OOOdUZrRzw3pOo0SdJp+CN3INHZeCkywuSKhRG2qGAkab5/66Wd77q3bILuzfWNvUpYwxSyMONmPps+NAKGU07Wx//p7Mf7ArmhfSSSW98Ds+kVheA13wTwXU75ZigeZJc6tnu8h/o/tpRVM+bDQ3khgFScN0NSzEPdmiPCe+/XMisb9mq+jVVq+2bwCbemT9Bg8R4ddl8TGVJ/BzXBY2Pc1jPfSGzjQITBc+PxHrG8a6+CURbX7DR2/18LwjxubCkiXP5fMaZJC+Da4eQijqpCr7CPAgbPxow8ueMt28a3DcoH2fE0XpsoNUNKjmJ++e4jkcSdJcfOUm8d9u9AdqR+/Fv/+l0PqBDooAriV7k34MLaJ01LthyWZydOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(6666004)(8936002)(8676002)(4326008)(7696005)(54906003)(70586007)(70206006)(316002)(110136005)(40460700003)(478600001)(81166007)(47076005)(356005)(36756003)(41300700001)(1076003)(86362001)(26005)(16526019)(36860700001)(44832011)(2616005)(40480700001)(2906002)(83380400001)(336012)(426003)(66574015)(7416002)(82740400003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:46:40.8587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71eb3626-0c07-4b2a-e696-08dbf020d53b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953
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

mc146818_get_time() calls mc146818_avoid_UIP() to avoid fetching the
time while RTC update is in progress (UIP). When this fails, the return
code is -EIO, but actually there was no IO failure.

The reason for the return from mc146818_avoid_UIP() is that the UIP
wasn't cleared in the time period. Adjust the return code to -ETIMEDOUT
to match the behavior.

Tested-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Reviewed-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Acked-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: stable@vger.kernel.org
Fixes: 2a61b0ac5493 ("rtc: mc146818-lib: refactor mc146818_get_time")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Add tags
v1->v2:
 * Add stable and fixes tag
---
 drivers/rtc/rtc-mc146818-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index f1c09f1db044..43a28e82674e 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -138,7 +138,7 @@ int mc146818_get_time(struct rtc_time *time)
 
 	if (!mc146818_avoid_UIP(mc146818_get_time_callback, &p)) {
 		memset(time, 0, sizeof(*time));
-		return -EIO;
+		return -ETIMEDOUT;
 	}
 
 	if (!(p.ctrl & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-- 
2.34.1


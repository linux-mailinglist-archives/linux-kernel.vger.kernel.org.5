Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E0880772B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379779AbjLFR6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379053AbjLFR6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:58:42 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129EDD62;
        Wed,  6 Dec 2023 09:58:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apFncT64ahdQHTiuVIAltreR4cTIpiHXcCxoDU0QenRmz5sTLV2rsjYdyzwwZD1UEglMU046vBy6NBr2l1URqwu7D285A+cAIJtf7x9DULOt4dFKgS2DzA9GWeMUPubxRhz7K/7lvXdZg6UDrAP0WChvSF+CPHo9dEWm3mDEE52Bx5z+XBgvOtwfmWlMicPm2DrFshjISCV3SKNbvtA2UzrUFhXMdE4R1y7s3fKMWJyWaL45bUSPks1P0ejIX5T4OeqstaG/noENt1aBeM3bORbG93tVbo33elxd/1EvsQZw+kEwr+fLViZR1TAckSEsrt8EFC46EWLgrDCwHSLspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6ddM0n9CKVFEHqrcOU/WeQVuxcnxXw4Bp7h8fskh6o=;
 b=JAkD67TeCN6z4v241T1irpbPWlSwHvi4j/1ei31NDwqFEGB8pcbEEkKUxL48W7otr2qROPsPFdnbWmh8JOnIDiBBEJiWPoSOfigHL3pFKe34WEGh62wDjhdaTQbVdBknIKDExxh/1reXNvaFaSsJ0HzfqLfAX03luArDDJ8QeLDzcUdcW1icWkK6xxnOADVPQc2XbSeNq4zuNN1dmi3EJE3YMdjv9qkoQXiEphcIC3vdk/OtTrULkL+ecDyP2fuqxG1dm8pHtQ75NP635PQ2pnZhs9ToVpblbkT1ElHxjWujaJ2hHma31/c6N5cjAEwWF4b8rVP8pOU9GpaS04Yc6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6ddM0n9CKVFEHqrcOU/WeQVuxcnxXw4Bp7h8fskh6o=;
 b=zGnHc5cYNJEuTPHZej0YU8V+CuGZ/G/K3MJ/AVxQqx1rzfE7wWGrWnLtIisZbRPTHujONoClV/qP1FftFKpxOf1DVUpPw/TTxKcgsE2Iy4fGVa0+E06hN7OSiHvqQ5++15blTsHFbA3Eja9frMwLu/FgxWLsvZn+vLsD30ODF94=
Received: from SA9P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::32)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 17:58:44 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::5) by SA9P223CA0027.outlook.office365.com
 (2603:10b6:806:26::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 17:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 17:58:44 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 11:58:43 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH] Input: i8042: Quiet down probe failure messages
Date:   Wed, 6 Dec 2023 11:58:18 -0600
Message-ID: <20231206175818.2568-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|MW4PR12MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c7e405-af07-4a04-2d78-08dbf684fd20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ppXZCTz7v/NOxEdpXoqQa8cNO3pmsG4PI4bzIgz8pCg0eMKgD72itOli/9uXM9DJvSWc4Xslw0tKmCapHry1InFZXGid7CNbiEfHG1JLOpFCvlDqtA3ZdZCQcDwv2t7a010uHHwEzKfhLx0NBB+ZHHgcBUMSWSf/zawEKpzrsNlhUzftfI8dMSlc8N1/sOmgPFoNNtp7m+qPvqmDnvolQCdF2+dEWZO6P58q8BVDSUiBwBJqBp31XXsjhwXH1+eRVaq1u5Gfmurcr7R/Oi/X9E9I8E8RwDIhCA3J/bxgiGizMEFkuS425sast5sAa/Mk5miLi1qwU8yVjndi6//5Bo66XYNxjdriOnlvWKngWo8FW1bdUVfhPwqttXomEp+FG20iWvIxqnO3EDaj5mnhkDQKxAWSWbSyItXu6R45qxoLz8TgbawozGAUdgWfsABVa78wxlbNjlbnof4wrXajxv75USDkDqhkOnCLazgnijir7/b3WKprjUhHQ8X8C+k1BCPLqAM0yCDuO2rOK0Soqsezw2w8SXxQM3IgaDHAIe1Qj/VvWl3uGGX3s7ir/LiMR5r43MOAPgUriOElyesdJFbnNITXMn/SXEcSo77SE/GueskG2gtXmJCFokabF/cCd13chx4P8R4pa1Y8QTcOVVhGZ4LnNyow2liSkCvZYQDHAQrlpe8tjjnJhfLW4BFuEawqO1i+WQkMsPNuqZs10Ux0Qf0+x1JjMQ6HreypMHUAM/ZA6sLcZNOb2CnTmKDjkxk7sF5Dc0DfySWWu3v0XnGLU6lcICkKNUaKkk/YSiN+wa7MKU4wkdh5Y2fC9+k
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230173577357003)(230922051799003)(230273577357003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(46966006)(40470700004)(36840700001)(83380400001)(426003)(7696005)(40460700003)(6666004)(1076003)(2616005)(16526019)(26005)(336012)(316002)(70206006)(70586007)(54906003)(6916009)(40480700001)(15650500001)(5660300002)(2906002)(4326008)(86362001)(8676002)(8936002)(36756003)(44832011)(41300700001)(81166007)(478600001)(356005)(82740400003)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 17:58:44.5292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c7e405-af07-4a04-2d78-08dbf684fd20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Framework 16" laptop doesn't have a PS/2 keyboard. At bootup the
following messages are emitted:

i8042: PNP: No PS/2 controller found.
i8042: PNP: Probing ports directly.
i8042: Can't read CTR while initializing i8042
i8042: probe of i8042 failed with error -5

The last two messages are ERR and WARN respectively.  These messages
might be useful for one boot while diagnosing a problem for someone
but as there is no PS/2 controller in PNP or on the machine they're
needlessly noisy to emit every boot.

Downgrade the CTR message to debug and change the error code for the
failure so that the base device code doesn't emit a warning.

If someone has problems with i8042 and they need this information,
they can turn on dynamic debugging to get these messages.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/input/serio/i8042.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 9fbb8d31575a..95dd585fdc1a 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1008,8 +1008,8 @@ static int i8042_controller_init(void)
 			udelay(50);
 
 		if (i8042_command(&ctr[n++ % 2], I8042_CMD_CTL_RCTR)) {
-			pr_err("Can't read CTR while initializing i8042\n");
-			return i8042_probe_defer ? -EPROBE_DEFER : -EIO;
+			pr_debug("Can't read CTR while initializing\n");
+			return i8042_probe_defer ? -EPROBE_DEFER : -ENXIO;
 		}
 
 	} while (n < 2 || ctr[0] != ctr[1]);
-- 
2.34.1


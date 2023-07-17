Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7D1756E09
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGQURc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGQURa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:17:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF05136;
        Mon, 17 Jul 2023 13:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxbsm8urHMHV+5i99i5K6NoHIzaP3jPvuPtpnQUWrtu/zeTWR0fCAIVbRv0/36xoiJFp47ncm4uwOJQYKy4OtTLGEVp+1XinVwTeMmPBZUuV1gcVwN/9M6W2MB6HFFJxDjZGWF1H/iimqafBZDl6KULN3EjPqw2lY0GrkNoHBD/iCo44QgUqMlHEG83w/2EKENs7duYl8RS7RfZibVvsIIUyCk+cm10yilAFT14hzlOM3AuYcEXfjmBoRWQbhC9K+3Cz+LXorTZNHH2L833uNP+1Sr+dYYWsu8f4RhpCL2U3KMpRsUNi+qGDZ3gy+JSZC30Vlchx9D/XjkH74Rhgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VE9o0hv/nbjZB1OM8aYpBrpIPBSq6QBWPXfz6KOhCi4=;
 b=UV163DQivx8c9SjnVT1G8BAQqLp+ch4Y1ql8609mqwgdMl4GO9xX+E43Vm1pV6ctmxT1SepK2TpxJ3+0bUpRBUbAimKuiCoGDQ0pW6AxPVwAoXIgE3OJNgfMArjRUuFoWPXLQqbhLaNPVQkNT6Gjoxh7KxNP2FJHFnAU1aWXgT8kU3xCWJgaBj7olxalx8eTWVOV1qR+La4epujCG3noYqYiFCdGv+FJg4Y0TE6KQ16C0spyVjTPghQcmG99jUCAcw2e3WTy2s7Z8mGuxzrgHEgHTrVER+MBcdKyXJQUqXRERC/fa1gysKxAIYWc5TMdymtckyfR8h01xqG9fpgkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE9o0hv/nbjZB1OM8aYpBrpIPBSq6QBWPXfz6KOhCi4=;
 b=2P++FXBcvvE7kxgBPuyF/PIewBCMboaWWkwvmLkyBHLFJn6zlhyOW8Ox3hJ6satUjChZbRWTnWdoEpy9FmB3Jqrjlu01OBqDfeTujs8PtjsrH9+pxBi63EYa96u55JHY+FkZi4q2FyO84iCcqcVIGaFuIqnY3Pjvo0Gq3zLFGy4=
Received: from BN0PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:143::24)
 by SN7PR12MB7420.namprd12.prod.outlook.com (2603:10b6:806:2a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 20:17:23 +0000
Received: from BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::cf) by BN0PR10CA0021.outlook.office365.com
 (2603:10b6:408:143::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 20:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT112.mail.protection.outlook.com (10.13.176.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 20:17:23 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 15:17:10 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <linus.walleij@linaro.org>
CC:     <Basavaraj.Natikar@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mario.limonciello@amd.com>
Subject: [PATCH] pinctrl: amd: Don't show `Invalid config param` errors
Date:   Mon, 17 Jul 2023 15:16:52 -0500
Message-ID: <20230717201652.17168-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT112:EE_|SN7PR12MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 23544864-e083-437e-ec51-08db8702d4e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmjcbGwPchXO//OGoEYYqodPvxnUU0mnyN5TANIUFzeB81pwhK380oiPrbp4JfBuZqdUYqGhz5we8T0qhQvvYm4QH7N545JVhmBcWQKHx8UyOwaJCocMv4Agr4E0p8wK/z39z5AGFoXeyG7W3NEZasNGk1QpnI5fdpWAckYcPUbY9woV+oTKvnqbSfaUYp/jYFA0aie6NFfdFOGMNf58KiLnxdim5Ik/Zbx4A0Mx3rjdRtXgGa9nJ4jRLi6rnu92UDjmSdDwD9LY5wOvf8Za4mF6IpsVStRlg0IitasgicMvkIRpb+uTelRGmqK6T0jiFCHKojVr0xbGlVChwqD5amwplYzQnwGoJpIaQaT4c3qsMhG+DxHuxak9cQqzzN9HNjWZFRbuhTsabvWQlipgiS+UsoBWVr0Ep8ktPC2dMpTouchtbWLaZ5o+genY3mB3mUSYJpALZKyn9U60uByJlXW+BBq2XGV1UE+98w3yc23PZn9tjZd2Gb8CWkwTtTBv1KLCFGYhndeqeHLa6hkk6BWxj13scmnuj+T0KGgvMabjKjBtLTasr4NBE0S/SRKwTdceEDqAK8UM5DjtuVGZRcaANW+1q95xzbPujf9C9oSt8WmByrtQOoSMhSQP/YbqKY/ZqmU38SHXfQ5T8z6Xyy2AZQet5Tf6D3TItZbtkSeRgFEg4Ul6gQ0LT6JQhFjD7GXPLJEj1GNl1kclksw9+yvGbHbLBtkcudnkqhvZUXijqxiu8odv0ePVphpeOVtUK5PfcK/SLKj9UZTKX/mfdL1Qxl2ZRgnMh/mxettzfzg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(86362001)(2906002)(36756003)(44832011)(40460700003)(40480700001)(186003)(16526019)(336012)(36860700001)(83380400001)(426003)(47076005)(1076003)(26005)(2616005)(82740400003)(356005)(81166007)(70206006)(6666004)(7696005)(54906003)(70586007)(316002)(5660300002)(6916009)(4326008)(478600001)(41300700001)(8936002)(8676002)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 20:17:23.3848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23544864-e083-437e-ec51-08db8702d4e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7420
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some systems amd_pinconf_set() is called with parameters
0x8 (PIN_CONFIG_DRIVE_PUSH_PULL) or 0x14 (PIN_CONFIG_PERSIST_STATE)
which are not supported by pinctrl-amd.

Don't show an err message when called with an invalid parameter,
downgrade this to debug instead.

Cc: stable@vger.kernel.org # 6.1
Fixes: 635a750d958e1 ("pinctrl: amd: Use amd_pinconf_set() for all config options")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 4a8c1b57a90d6..20bd97a603d9c 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -748,7 +748,7 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 
 	default:
-		dev_err(&gpio_dev->pdev->dev, "Invalid config param %04x\n",
+		dev_dbg(&gpio_dev->pdev->dev, "Invalid config param %04x\n",
 			param);
 		return -ENOTSUPP;
 	}
@@ -798,7 +798,7 @@ static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		default:
-			dev_err(&gpio_dev->pdev->dev,
+			dev_dbg(&gpio_dev->pdev->dev,
 				"Invalid config param %04x\n", param);
 			ret = -ENOTSUPP;
 		}
-- 
2.34.1


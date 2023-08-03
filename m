Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E090C76DDAB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjHCBzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjHCBxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:53:25 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2972F4C16;
        Wed,  2 Aug 2023 18:50:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOSSRIbgxNI/10z05H3U49rRcFF1JbJl9SXQvzPQoRYDjil1FcK0XqWLEfq97kxBLTx17/gxdmzoqt2KnYi3k8fOBLsj+rKAF6UWfaC5jo7BOamd562MuJL/9RlVxa4MboNHrBy+IOZ+ExH9GaAROFyZJfQCRUYlj5DD39NtmX6b61GlHHjHDO6LCfjl7h96O2PhIqY2dYPWXAdKUpnhL7tf/WcjjZQb0h+gx/wMQNm15iVPz06ImigBN+LtHtzgwDlox7wv/k0fz+93C7ARQt377n29JfB3Jl+sTPqP4ry0CHILl5dHDeVu5nGpSoMXGHIwZF+V4KI51rhqfuF2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6j7G0wHpGT5TV5mFGYDuSed9aFAeuI1Qx17cWQMASQ=;
 b=Ad3KlM6XtXGXMx9o9ozi4OzyFZPpXr33ZIfJBFbNKBNEURIxw3+mcsUtdCILpmI3xjwqU9FN3x8BLA2eY2WBE09HeQEzv946aEIOlhWPWkYZ6wkjboHZNl2NQsS338TKoCQCKFQyR+2Bjz7lb+u5DGD5lkE47iVF5iTTwa3y6u4DNy/HBGRWLrA8V3dHj1uqLM8hufNCatN+jETFlWBfVk4L8R90q3bZ8EoQ+w9yT5v+EUfJFSm2hYMmaiP0DQx8nbVh76nq7vVPeETLmC/FEP0AnkPeFattv6EpmcPeuNoib70dIQNg76Hp0WxaO83eLQ1gO8ZkcUj47HxAcovwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6j7G0wHpGT5TV5mFGYDuSed9aFAeuI1Qx17cWQMASQ=;
 b=ZzJ6PF3O11ONChv+vRKVjtgw2wNbX5Hhmbqici7WzYo8Cfe4IdWfebg5C4EmPLT/B1HG9+GNTkSgy7/DGqUTpFb5oladD9KYjsUTdd/Nb0ZysrxhwL0+ltcVv27MRt6ETe6crxZUpz0F9y+U9QpOfYwvWJtzELz/id/h2wssUvA=
Received: from DM6PR14CA0064.namprd14.prod.outlook.com (2603:10b6:5:18f::41)
 by CYXPR12MB9427.namprd12.prod.outlook.com (2603:10b6:930:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 01:50:34 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:5:18f:cafe::a4) by DM6PR14CA0064.outlook.office365.com
 (2603:10b6:5:18f::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Thu, 3 Aug 2023 01:50:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Thu, 3 Aug 2023 01:50:33 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 20:50:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <jarkko@kernel.org>, <peterhuewe@gmx.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <Jason@zx2c4.com>, <dragonn@op.pl>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/3] tpm: Drop CONFIG_HW_RANDOM_TPM
Date:   Wed, 2 Aug 2023 20:50:15 -0500
Message-ID: <20230803015015.915-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803015015.915-1-mario.limonciello@amd.com>
References: <20230803015015.915-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CYXPR12MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d319ca-2b16-4d24-530b-08db93c406be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: leJya4SXqPzlT9O0LyNMTlqkCUGnMEY1nK77s9l3DIGIliNPeG8QqAmpGzGYWqUQUwy3X9TugxkOl5WLFlYCN4zoo/f6ucBxy7UuwrKCRWJoNSuZaKzxK2WrBdpoMLUT9jY3DBPsY/TrSFMCCwa+sxIRZy9kYjvvNb4RJjRJN+3uxekd7Z9OmQ3MIQK6qcnRg50hbX/v1YL+yHnTakj60nmJVpye9olBEfpyxXB/aToNcRJZ7pSBfkvpbeZ60SrR/BD2C03F2qoRaVGYDYVJBmsHIcUr0UHS9aTISWSjk6ymrExyyM+AWhqB47yBu2FczUF6keZU0G2XAWO0d88BQQr1Mo0aBn1ZhR7e2loY3e/DOL82FXKCSA4revm8QKOCcWqHRMdEkUT/qVubQz22HSssP3n2Z2MCLCTfJrX8hAJx6+F8nj781FWwtZ+SFchPW1EPJ7jT/KqgpfKoMZdVnBUCetGfFUrDrjKkaABhpvPRc/iwrMyWYTNfanoKIyUc/cN/fmUE6bvhqH9CL5CXJkt9XJqCwpHnaqlpPzU3Jx2b8kc3RN/iTY04dvjzcyAlr+vgviQuGXy/biXIW38bYX2DONEFFIW5Lli/SRdpWBkoVhqGMg7QRh/hklKDAJcpsvOycthpUTkH/L7F9hCBd3j8rfQWM8W64bLq5NPIsyh4C0A0cD2rUeYXGPBN4c6nZ0vOgGOqQ+tWg/wnaXXH0kko/Qb7EhdblkkV2Hvv4HXbr+0QxNNFpo/jFqe1czsW1hx13PSBnwNop5xih6VspA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(41300700001)(40460700003)(316002)(4326008)(2906002)(70586007)(70206006)(44832011)(8676002)(8936002)(5660300002)(54906003)(356005)(81166007)(82740400003)(1076003)(26005)(36756003)(186003)(86362001)(336012)(16526019)(2616005)(426003)(83380400001)(36860700001)(47076005)(478600001)(110136005)(7696005)(6666004)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:50:33.7347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d319ca-2b16-4d24-530b-08db93c406be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the behavior of whether a TPM is registered for hwrng can be controlled
by command line, drop the kernel configuration option.

Cc: Mateusz Schyboll <dragonn@op.pl>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/char/tpm/Kconfig    | 11 -----------
 drivers/char/tpm/tpm-chip.c |  6 +++---
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 927088b2c3d3f..69aaa730dc208 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -27,17 +27,6 @@ menuconfig TCG_TPM
 
 if TCG_TPM
 
-config HW_RANDOM_TPM
-	bool "TPM HW Random Number Generator support"
-	depends on TCG_TPM && HW_RANDOM && !(TCG_TPM=y && HW_RANDOM=m)
-	default y
-	help
-	  This setting exposes the TPM's Random Number Generator as a hwrng
-	  device. This allows the kernel to collect randomness from the TPM at
-	  boot, and provides the TPM randomines in /dev/hwrng.
-
-	  If unsure, say Y.
-
 config TCG_TIS_CORE
 	tristate
 	help
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 8fb42232bd7a5..0d69335743469 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -533,7 +533,7 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
 	if (!trust_tpm)
 		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
 
-	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) ||
+	if (tpm_is_firmware_upgrade(chip) ||
 	    chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
 		return 0;
 
@@ -639,7 +639,7 @@ int tpm_chip_register(struct tpm_chip *chip)
 	return 0;
 
 out_hwrng:
-	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) &&
+	if (!tpm_is_firmware_upgrade(chip) &&
 	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
 		hwrng_unregister(&chip->hwrng);
 out_ppi:
@@ -665,7 +665,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
 void tpm_chip_unregister(struct tpm_chip *chip)
 {
 	tpm_del_legacy_sysfs(chip);
-	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) &&
+	if (!tpm_is_firmware_upgrade(chip) &&
 	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
 		hwrng_unregister(&chip->hwrng);
 	tpm_bios_log_teardown(chip);
-- 
2.34.1


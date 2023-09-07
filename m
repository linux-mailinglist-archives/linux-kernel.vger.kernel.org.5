Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68078797C46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344351AbjIGStt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242133AbjIGSti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:49:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0490CF;
        Thu,  7 Sep 2023 11:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rbk06MvtZkAoN9DHb802aDgXXWtnfOnEFGhEKLgXR+r7maUYkfKVrwXy8drMvD9j9AwgksJJUxDpZ7SEQj+JEheEoVJwhXaCoZnUL/BPnkrLwzwoX+XQN7+zIXhkuU7kFzsUcMJo6uo2S0XmzjOMmLdyRVI17dGbq7mvnTGOLfjVBMaTUWNHFAu18MlTl0pwdahjJTALssAS2hdd865HX5fazc16QVbtT8oQMMFKPTOcmqO0aS8d6veMkV6f5M0988sYGKENJYScBCllXfsjYZ0An9ch4xT1k/vAccMECGgvx7d5Hz6BgtpeXiG6tqXEGnFLiKxCxOjehb1UEKLiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbumWYeolBPsI3Sm5htbXd2inrZxxC3FUBCqll0xqzA=;
 b=AIisX9TmsJhDGM8MQBVPL/sVS6gxccXSUx0Y+JjgJH8iL1Q236YC7cGWSNp+UUEREdAwvuN5EunBM2GbBaU2+w0hS8IAEF9a9w8rZOtzn9jIzpV6oOmFF4dhozMirrfN19VfdD1/draroWujQIuf8Shb/6ugsHMqhxRSl71VRcDKJFHIBOTomnerVJwP48sXjVsgo+4/wyyD8Hg3g1Ay8nSClSbGIMpKnY3LjMggeZSbqqhlobBtE2IE1Kzc6LTpQDR73N2dRMiCQGqLIWX13TrfX/knluV618fj+bg4xvOUPvRB57WVfNxz86dvGvRc/vL1DozKYPZWZRNvUs4Grw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbumWYeolBPsI3Sm5htbXd2inrZxxC3FUBCqll0xqzA=;
 b=TW1kJuplVUeFMSaUjLbeHe7gYClsUHyusf/KLgclXrLvQAhqctU88Q1HJCQ1fM/3+VGNJ0fgKkDbXS0xtMhIV9SuLvzh51FJFJUEsYE5fE83Rx/8LO+z1ud6/rFFIeY8Epthk/ScWZlVvpgEM61IVzynCKqmQlP6mZxXDMTV6aU=
Received: from CH2PR12CA0020.namprd12.prod.outlook.com (2603:10b6:610:57::30)
 by PH7PR12MB6786.namprd12.prod.outlook.com (2603:10b6:510:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Thu, 7 Sep
 2023 18:49:31 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::65) by CH2PR12CA0020.outlook.office365.com
 (2603:10b6:610:57::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 18:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 18:49:30 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 13:49:27 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <thomas.lendacky@amd.com>, <john.allen@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Rijo-john.Thomas@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 4/5] crypto: ccp: Add a macro to check capabilities register
Date:   Thu, 7 Sep 2023 13:48:45 -0500
Message-ID: <20230907184846.47598-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907184846.47598-1-mario.limonciello@amd.com>
References: <20230907184846.47598-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH7PR12MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: d3930886-9968-4fad-ffb2-08dbafd32b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3bc6xOe3QWswppchvWv4qdcrSnPX9nSvHt/WCGcbE3PoKCbcVYlSms3Ekf9HCocdNMbpZQ9m8AKkL3HN44wjRI0xrSjwAWXAeRIWf+z8pxvlcZlJLZFMRb6M5BUSN6qOPYnlMLsKKAnPUmNxe7c59D9r4QaQJ+KS+X5Ezu/Kh2PQ6OiJ6r3MSBkKepW7yq2cB4gX6OyWU++Cb2KvC3JPcLR3xI+eV46V24Nf+AXGOENxEpaLNn0qlLthBQx2Y+t6BjH2Lj5WXIfRbqxpkrMy29Edex12sygsZDW7tGthPDU9Jy1X82UX0c0hIIqIXyGxjumKrlW4hnRhQNdYOQnCNEOPBXhPlG7BMwT1dOCm/ap+V1sOFCAE3oedy63K7mEFnEAnpCqo4qjyxWueLh+rAq7M/ZAiQHFqKJ+o9yQOsbb/th0Al+b2TT++XJn733Rcykgg/02GBa5QdnNIF7aTmiwVsTWM2WiNlRttBF/6igU4TPqLxEnQjhEF9Tn4N+42DoQG9IVTQFNDnjZwlSXnSIWuWtgJECBYcMEshL4UWrJBDz8S46aft1UROlRl22ZieFdHtPI+j0Wn/q1wx9PuA1dgUm8lyTiCIxjHc0kONAX9mIYHpu7lbE/vaiwgiHJGR2q9A3EyczA5RrJfFrSxT5a7tz8dul1QimNBM5Wmnc4Ilz3mOH9khpNJbwzMPCv5zs0WfOAo/sxZOJ0aeMBjkSr1MuSWpgtO9+zo2k06OcFFJHZ4Wv7KVN53Y6J0/F1s2UOuwvAUrAIUx5y36qrCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(41300700001)(8936002)(83380400001)(40480700001)(44832011)(6666004)(478600001)(2906002)(5660300002)(110136005)(70206006)(70586007)(8676002)(316002)(4326008)(54906003)(2616005)(1076003)(7696005)(16526019)(26005)(40460700003)(36860700001)(426003)(336012)(36756003)(81166007)(356005)(82740400003)(86362001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 18:49:30.2423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3930886-9968-4fad-ffb2-08dbafd32b57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6786
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Offsets are checked by the capabilities register in multiple places.
To make the code more readable add a macro.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/psp-dev.c | 6 +++---
 drivers/crypto/ccp/sp-dev.h  | 1 +
 drivers/crypto/ccp/sp-pci.c  | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index f9f3b3404f87..5f61b23695d5 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -157,7 +157,7 @@ static unsigned int psp_get_capability(struct psp_device *psp)
 	psp->capability = val;
 
 	/* Detect if TSME and SME are both enabled */
-	if (psp->capability & PSP_CAPABILITY_PSP_SECURITY_REPORTING &&
+	if (PSP_CAPABILITY(psp, PSP_SECURITY_REPORTING) &&
 	    psp->capability & (PSP_SECURITY_TSME_STATUS << PSP_CAPABILITY_PSP_SECURITY_OFFSET) &&
 	    cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		dev_notice(psp->dev, "psp: Both TSME and SME are active, SME is unnecessary when TSME is active.\n");
@@ -168,7 +168,7 @@ static unsigned int psp_get_capability(struct psp_device *psp)
 static int psp_check_sev_support(struct psp_device *psp)
 {
 	/* Check if device supports SEV feature */
-	if (!(psp->capability & PSP_CAPABILITY_SEV)) {
+	if (!PSP_CAPABILITY(psp, SEV)) {
 		dev_dbg(psp->dev, "psp does not support SEV\n");
 		return -ENODEV;
 	}
@@ -179,7 +179,7 @@ static int psp_check_sev_support(struct psp_device *psp)
 static int psp_check_tee_support(struct psp_device *psp)
 {
 	/* Check if device supports TEE feature */
-	if (!(psp->capability & PSP_CAPABILITY_TEE)) {
+	if (!PSP_CAPABILITY(psp, TEE)) {
 		dev_dbg(psp->dev, "psp does not support TEE\n");
 		return -ENODEV;
 	}
diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
index c4e125efe6c7..03d5b9e04084 100644
--- a/drivers/crypto/ccp/sp-dev.h
+++ b/drivers/crypto/ccp/sp-dev.h
@@ -30,6 +30,7 @@
 
 #define PLATFORM_FEATURE_DBC		0x1
 
+#define PSP_CAPABILITY(psp, cap) (psp->capability & PSP_CAPABILITY_##cap)
 #define PSP_FEATURE(psp, feat)	(psp->vdata && psp->vdata->platform_features & PLATFORM_FEATURE_##feat)
 
 /* Structure to hold CCP device data */
diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index d1aedc5c1a68..300dda14182b 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -84,7 +84,7 @@ static umode_t psp_security_is_visible(struct kobject *kobj, struct attribute *a
 	struct sp_device *sp = dev_get_drvdata(dev);
 	struct psp_device *psp = sp->psp_data;
 
-	if (psp && (psp->capability & PSP_CAPABILITY_PSP_SECURITY_REPORTING))
+	if (psp && PSP_CAPABILITY(psp, PSP_SECURITY_REPORTING))
 		return 0444;
 
 	return 0;
@@ -135,7 +135,7 @@ static umode_t psp_firmware_is_visible(struct kobject *kobj, struct attribute *a
 		val = ioread32(psp->io_regs + psp->vdata->bootloader_info_reg);
 
 	if (attr == &dev_attr_tee_version.attr &&
-	    psp->capability & PSP_CAPABILITY_TEE &&
+	    PSP_CAPABILITY(psp, TEE) &&
 	    psp->vdata->tee->info_reg)
 		val = ioread32(psp->io_regs + psp->vdata->tee->info_reg);
 
-- 
2.34.1


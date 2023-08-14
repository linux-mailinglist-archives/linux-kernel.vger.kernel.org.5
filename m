Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA2177B0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjHNFyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjHNFxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:53:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229FBE6D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:53:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyExlA4IEJb6fGX5/IK2ZzERodkplnoHJBFAma7Pt6DpaUHqPP0tBamu52LljGHD61FTVZ1uRtPm1PgkFJvH3vE0VpBBH6xicTytK+hYDjgq02Dz6Fdqaba6CYFs0Tr5km/mU7H7XX6+UZMyHM/9/2oDFkC6NSImfQsmk0Earw2vkKRDxGtAwrIQHexIZmro6c8yEQfx2BpYdJhczCYGd4xU6yRm5dPWz1BqQUDb0Z2Sxfv8xUVXGZvGOLZMkJA55jJ26h4fmdEDhsM2A07SdPXV/7RhaYknFEr4Y8DScgv4X+jrDs2j6ARF5EJFITU2APkyENsU0cbbSUK1O2ifBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DzlqpvKnjzcpr+/IDzgWVqdLTcaEcryhxNTMyU5Ir4=;
 b=jPwGzxOVLxa60N3GXT9QZlcNCzVgd5soJ6LuGxEF3YrSbcP5JwQpcF1qLgmQl9qjC2yVgaldj1aKKU7ba3nI0l67UHa4RbqsiRbrs3C6cMl5vkVWajaqx7SCUYiZSXl94WVYrIbTSgB49gBh5I35givv4RBS7g67U4mzUMWUJKTQqP6e7SmrveXf/Q4yUlwzFmagZdp9drkmDEUE6NWJU5dlZOGopXX8QpRuLCLX32dwqxuGvrw2n0iQ6/n/dNFcAHYaeEhR2tvOGEVwncHV9tEHSVjvGavSsYlni5l8mMXV0yXtwe5J5ckvciokTmOqP5GkY85V123+uMq2w8c46A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DzlqpvKnjzcpr+/IDzgWVqdLTcaEcryhxNTMyU5Ir4=;
 b=Xh1MSsBRpaEynTWA30DZQHbDzyzSdRB5d8Od/lOkvrgQMTLGQA/VTXPofu1CBmKVy5QXx7vrPuoe/jYJRt1xNVe2YXvw2lWAv70FdDQhXcfq4Ag08ssQIXpIACAn1cub5ir9ptFLPmRbStRUJk+FO55J+U+ivR7qK6Qq71duyhM=
Received: from MW4PR03CA0250.namprd03.prod.outlook.com (2603:10b6:303:b4::15)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 05:53:52 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::da) by MW4PR03CA0250.outlook.office365.com
 (2603:10b6:303:b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 05:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.13 via Frontend Transport; Mon, 14 Aug 2023 05:53:52 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 00:53:10 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v4 06/14] x86/sev: Cache the secrets page address
Date:   Mon, 14 Aug 2023 11:22:14 +0530
Message-ID: <20230814055222.1056404-7-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814055222.1056404-1-nikunj@amd.com>
References: <20230814055222.1056404-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 875a2759-bac7-4a65-da3f-08db9c8ad68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HeTQ+Myyf5V78PtHRI/ASC4zA2wmdIJ/ff5ckBxDfZcgoXcjpxCktRvdzUSuA/odfVj+04xz2tEPF9pcJY0BJ9kdp6itAp7S67lha0m2p3+pmvVmLkuPEzgChC6eKqdijobCcN9tDl2MBXF7k6JnGxCfzfqzYC5dqJMa7o+X63qng3M/N6ieEDENTf672i7Z83tlQhXYGzMXvXTVPV+M1iMutJZxTtwF6OQyRsYn/ceDMDyGWovbH0xwVm+w7VR+VoMb0bBDG/fQ24GewDCNkIxI77LPO12VIy4gYKONCuCa8X4FcyK7N+DgOhEDtP6CR7a9iW9M32+MIlOUAzuoB8S2ugGYM+7Cn2ssTjbSg82rqTHZdWR00lN53AjTLC/F/9PzgRvFAHQR5teZPRNvpn7Nlsym93DGXcUcxLCEjv71qmu9JZLC8Kryvp8s63ytbSR2HKHwRaLdTT3Aw84Mwqo5KW/piX9x+cjttWhlDe6q/NJYmS9j4oxkGBHpfPqi7GUxtRjfdsXhLFrEW51/dGTwCQ61tsog76a+V6ISgwVGvheO33OCQexlqiQRLupkkXCUakqd4O2y2aBMtpJC/yvh14LGk3x/+EEtaK17YzM/WBblYRGMUi5AnPVnBrhcjTfSdWgEe687r8PeRwgbcHOQ5DDcJMpRRas50nsdfQJwc/3DUK6B9i7+RBjCkAqO0YOOgjhFwwJiEdT2ElQ8f0N1C2FsQr2ZaY9OhTFXqt9TfqBSmYORD5fGoplwTTL/2ZwDv/gPhj7UkSJqgrL9sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(186006)(451199021)(1800799006)(82310400008)(40470700004)(46966006)(36840700001)(70206006)(70586007)(54906003)(316002)(110136005)(41300700001)(16526019)(8936002)(8676002)(5660300002)(478600001)(2906002)(1076003)(336012)(426003)(83380400001)(2616005)(26005)(7696005)(36860700001)(47076005)(4326008)(356005)(81166007)(40480700001)(82740400003)(36756003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 05:53:52.0182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 875a2759-bac7-4a65-da3f-08db9c8ad68a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save the secrets page address during snp_init() from the CC blob. Use
secrets_pa instead of calling get_secrets_page() that remaps the CC
blob for getting the secrets page every time.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/sev.c | 52 +++++++++++++------------------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a10cf9f21e22..a63a3edf13d0 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -72,6 +72,9 @@ static struct ghcb *boot_ghcb __section(".data");
 /* Bitmap of SEV features supported by the hypervisor */
 static u64 sev_hv_features __ro_after_init;
 
+/* Secrets page physical address from the CC blob */
+static u64 secrets_pa __ro_after_init;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -561,45 +564,16 @@ void noinstr __sev_es_nmi_complete(void)
 	__sev_put_ghcb(&state);
 }
 
-static u64 __init get_secrets_page(void)
-{
-	u64 pa_data = boot_params.cc_blob_address;
-	struct cc_blob_sev_info info;
-	void *map;
-
-	/*
-	 * The CC blob contains the address of the secrets page, check if the
-	 * blob is present.
-	 */
-	if (!pa_data)
-		return 0;
-
-	map = early_memremap(pa_data, sizeof(info));
-	if (!map) {
-		pr_err("Unable to locate SNP secrets page: failed to map the Confidential Computing blob.\n");
-		return 0;
-	}
-	memcpy(&info, map, sizeof(info));
-	early_memunmap(map, sizeof(info));
-
-	/* smoke-test the secrets page passed */
-	if (!info.secrets_phys || info.secrets_len != PAGE_SIZE)
-		return 0;
-
-	return info.secrets_phys;
-}
-
 static u64 __init get_snp_jump_table_addr(void)
 {
 	struct snp_secrets_page_layout *layout;
 	void __iomem *mem;
-	u64 pa, addr;
+	u64 addr;
 
-	pa = get_secrets_page();
-	if (!pa)
+	if (!secrets_pa)
 		return 0;
 
-	mem = ioremap_encrypted(pa, PAGE_SIZE);
+	mem = ioremap_encrypted(secrets_pa, PAGE_SIZE);
 	if (!mem) {
 		pr_err("Unable to locate AP jump table address: failed to map the SNP secrets page.\n");
 		return 0;
@@ -2093,6 +2067,12 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
+static void __init set_secrets_pa(const struct cc_blob_sev_info *cc_info)
+{
+	if (cc_info && cc_info->secrets_phys && cc_info->secrets_len == PAGE_SIZE)
+		secrets_pa = cc_info->secrets_phys;
+}
+
 bool __init snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
@@ -2104,6 +2084,8 @@ bool __init snp_init(struct boot_params *bp)
 	if (!cc_info)
 		return false;
 
+	set_secrets_pa(cc_info);
+
 	setup_cpuid_table(cc_info);
 
 	/*
@@ -2256,16 +2238,14 @@ static struct platform_device sev_guest_device = {
 static int __init snp_init_platform_device(void)
 {
 	struct sev_guest_platform_data data;
-	u64 gpa;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return -ENODEV;
 
-	gpa = get_secrets_page();
-	if (!gpa)
+	if (!secrets_pa)
 		return -ENODEV;
 
-	data.secrets_gpa = gpa;
+	data.secrets_gpa = secrets_pa;
 	if (platform_device_add_data(&sev_guest_device, &data, sizeof(data)))
 		return -ENODEV;
 
-- 
2.34.1


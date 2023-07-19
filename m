Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9481D75A2C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjGSXW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGSXWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:22:25 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F43268D;
        Wed, 19 Jul 2023 16:22:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAehErivdl0MnBQQuBctUXbMWuJqMmkPP/sR4EN3R7QUOaJzo1QXm61nzjMXk/DrDyQXW94OlSQfZpZ3Jr8t9AymupHQE6ZIvxf5A4vF7doIi8qcEf9zoe2PdK//yv/H63cO7DLku/hV7QCK+TTxdaGhuxLqm0jkGsBdcW/LDLPF1e7kkpjrGwY6Nw6ZylqsOwwbAuCsIcN91gBpFGeWlHEtz+Y4IrNQ6u1IlUgRjDEsPYJrJJe2Q8HCe4y7CNOjW6WZFLVKp52JLABc6YT//J23liM5MZswiIpKss+AwA67d/ZEFpoMGMGlvHqDJaXQcSJI9EOjutg2c5UWBoITIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Th6/t3mREpZEsSW4UhPaIsUf+aPY0ugCbYGGZAF13nI=;
 b=g7LsqhF5foAb2VUYNroKt7PHpuT4hwsMO9G1vPWAislrBoWGlJlyQv4VutFzSodKyj3+XA9100jL3nXZMC2Z+xMyvXbX1In3nS4YwOYReMws9umAtIlYSGSlrqoZBrjlYFpNpht92AV62jIfWYQ13xLpON8qi8nJAcV5t29BEuWwYQtHa1Ji4e4biWz6+MYIAKVvTSgUpgXORBUlB+gnOg9PfKszyfHmKG/t/JPdOtJllE1Uv+66R7L0Q8kBkVZfZnIvzxmLEcT+cDN6RkDrui92HHPS2EHLUCnk0gUcrtcB57LgNYclRtzX38Tefi5/+ok9vhKL4vcUMD6dAKcmew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Th6/t3mREpZEsSW4UhPaIsUf+aPY0ugCbYGGZAF13nI=;
 b=RgXEcUugFTlIPxzQq2rcerrioJIW83v7Utn1ZZzsObrgojD2p5lVpiUk8OIux6Xp1JsQvIaMFvzVY8IunqZJLMBOhXiQugy0zxjiguY1SGxQqt+RDMT0JQsfcYYiuKhwdsATv19p5r4UlG1FqXGjNZcLvpREdTVs6Gp6Xv6najU=
Received: from DM6PR02CA0062.namprd02.prod.outlook.com (2603:10b6:5:177::39)
 by DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 23:22:07 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::1c) by DM6PR02CA0062.outlook.office365.com
 (2603:10b6:5:177::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 23:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 23:22:07 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 18:22:04 -0500
Subject: [PATCH v6 5/8] x86/resctrl: Unwind the errors inside rdt_enable_ctx
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <pawan.kumar.gupta@linux.intel.com>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>, <babu.moger@amd.com>
Date:   Wed, 19 Jul 2023 18:22:03 -0500
Message-ID: <168980892326.1619861.2405779251348138586.stgit@bmoger-ubuntu>
In-Reply-To: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
References: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|DM4PR12MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: cac4c581-50c2-4519-b385-08db88aef86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQHIaSHsrAzt2Lt+PNg6amcJX6kxOmTc8Wf817vCRAkC4s255yLHX26qvOK7Lb3S8On1GaUjgzzRiNxYIqzmKE9Q+BwHaRJCcg4YPn2k6aOZdfMukqzlu06IR0ABB43skT6kS36gyMRgDxj7ZAsPDdT7SHcZ0A0lhZQAAC9e0YCj+MPJWXiW8h2TTSn4sQ0owotR/0Q0IFIFCByIiKSMDXl7/mbvtooI+l5vcnpu8iABb3z+r55JCKBqJINbpC04cKkhyNtBD/deN3UqbaPiP119KGE1xXqAdPee4MX12hZYIwxrkTNTHAegmPklGH8tsM3HSIl44L2xgGc10xMFyubiLXuG0SBVoNaVPbU09DtJMuxohQYbES5bgjaNufPgjiqyG5YywqIYyCeiBiDBm7OyDryiBmDzQGSvT0Os7epulshujQKc3Bgwx/MIR73BL3w8H1NpMiQQiMp/6NQE5aRP+r6GNSMe3U+J9EwxFVP3cbEECKF85pNzNKyw+NH8r1EzOi4uZDxvkoC+uIzdUcuQ91Hyz1iv+HkObTC74dCCsWyysHnrA4+/SqmkVs3V/85G1lyP1hLquiPZX+6nPY9TH7YchQqv5YI0OsLTN5BS+XuOHEG6pUHuXwOGIzIHjDgnD7HtvuMq7V7YS+cLrgW7GgIbE0PXurBg6AKjvLyjAoIoHffOsbh9p0Dnuv7o/K0lf1PuPYaWvboRg9Mpm0zZgzA4k55Ih+8747hS8Jmg0I2SYI0fP9hetnqbzoIAz0o1lUBqHJkdZYxv8Oo9LV/PxQU9bCXFhSSy5eiM1SA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(103116003)(16526019)(110136005)(478600001)(54906003)(186003)(26005)(336012)(9686003)(83380400001)(2906002)(70586007)(33716001)(41300700001)(5660300002)(8936002)(7406005)(8676002)(40480700001)(44832011)(7416002)(16576012)(356005)(81166007)(82740400003)(70206006)(36860700001)(47076005)(426003)(86362001)(4326008)(316002)(66899021)(40460700003)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 23:22:07.5720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cac4c581-50c2-4519-b385-08db88aef86f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdt_enable_ctx() takes care of enabling the features provided during=0A=
resctrl mount. The error unwinding of rdt_enable_ctx is done from the=0A=
caller rdt_get_tree. This is not ideal and can cause some error unwinding=
=0A=
to be omitted.=0A=
=0A=
Fix this by moving all the error unwinding inside rdt_enable_ctx.=0A=
=0A=
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   31 +++++++++++++++++++++++-----=
---=0A=
 1 file changed, 23 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 3010e3a1394d..9a7204f71d2d 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -2381,15 +2381,31 @@ static int rdt_enable_ctx(struct rdt_fs_context *ct=
x)=0A=
 {=0A=
 	int ret =3D 0;=0A=
 =0A=
-	if (ctx->enable_cdpl2)=0A=
+	if (ctx->enable_cdpl2) {=0A=
 		ret =3D resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);=0A=
+		if (ret)=0A=
+			goto out;=0A=
+	}=0A=
 =0A=
-	if (!ret && ctx->enable_cdpl3)=0A=
+	if (ctx->enable_cdpl3) {=0A=
 		ret =3D resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);=0A=
+		if (ret)=0A=
+			goto out_cdpl2;=0A=
+	}=0A=
 =0A=
-	if (!ret && ctx->enable_mba_mbps)=0A=
+	if (ctx->enable_mba_mbps) {=0A=
 		ret =3D set_mba_sc(true);=0A=
+		if (ret)=0A=
+			goto out_cdpl3;=0A=
+	}=0A=
 =0A=
+	return 0;=0A=
+=0A=
+out_cdpl3:=0A=
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);=0A=
+out_cdpl2:=0A=
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);=0A=
+out:=0A=
 	return ret;=0A=
 }=0A=
 =0A=
@@ -2497,13 +2513,13 @@ static int rdt_get_tree(struct fs_context *fc)=0A=
 	}=0A=
 =0A=
 	ret =3D rdt_enable_ctx(ctx);=0A=
-	if (ret < 0)=0A=
-		goto out_cdp;=0A=
+	if (ret)=0A=
+		goto out;=0A=
 =0A=
 	ret =3D schemata_list_create();=0A=
 	if (ret) {=0A=
 		schemata_list_destroy();=0A=
-		goto out_mba;=0A=
+		goto out_ctx;=0A=
 	}=0A=
 =0A=
 	closid_init();=0A=
@@ -2562,10 +2578,9 @@ static int rdt_get_tree(struct fs_context *fc)=0A=
 	kernfs_remove(kn_info);=0A=
 out_schemata_free:=0A=
 	schemata_list_destroy();=0A=
-out_mba:=0A=
+out_ctx:=0A=
 	if (ctx->enable_mba_mbps)=0A=
 		set_mba_sc(false);=0A=
-out_cdp:=0A=
 	cdp_disable_all();=0A=
 out:=0A=
 	rdt_last_cmd_clear();=0A=
=0A=


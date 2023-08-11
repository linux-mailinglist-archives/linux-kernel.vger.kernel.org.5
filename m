Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4182779846
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbjHKUKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjHKUKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:10:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD57430C8;
        Fri, 11 Aug 2023 13:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyR8FrULCpaLzDAgp9009e993JSMiJT7+GIvNvGOiYTm1Yc/c82WPwMFV+J5v0sogRwd+be6xoPjJ9Nu77U0ydNZXxNmlroMCTi52VSHVDtu14MYT+KQFku3GNN9LTGhj/AkYsKyYnSZHiS/RqMvKni5xh5zYxbsva4cS/H0peoItVUZDdY4ikGW6erhE5WMVCLJFyb9Rf2iMmBbOwCz8a4qV99W3hVTkbyN/2Cx2qjiAgDo5GAY0tH6mkEzJZfoEgk9Zsas2qgPy49jYLctoYuKagUGclt9IJrxrxvh5LVWXiTl7QF1jC/Splp3Jj9VBWIpbgFll94Bac7U+bexMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmP59P+VoRcJuuAk9hmDW41PRaO7VF5n6xJW5fOcJVc=;
 b=nX3UH1q60ldgTKrVid3NR9UJbRRYJ5TFJ0yNpS/6TBfsifCNLjeNWh761VX7m/81FAg0xIrj6Xqi318Pr+KQOShoutqKEigS8VKaRGpdj8VeSdD7MxPdooNtJcvBQF2HGtqYXJFM2TN4njDK22ZMhR8eDaJwcdUjCwux8FR/a4JLJzgc/4V3vlsGl+ZtZeI7sI4b2y28YaOUuUCWpaeSoz/aI2dEnG6vnwBpea+SiMwhKK8nTnbvlkCgAMVM3yh4VNHd+nysacLyzcbYTFw9cZdMgdGH8CJr6GGdt211xlYu2EGNIiK3j2wq8mZHta07R6hwmx35KD7d83qCCSwAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=csgroup.eu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmP59P+VoRcJuuAk9hmDW41PRaO7VF5n6xJW5fOcJVc=;
 b=mGsAvfZpdab+ye+vdFOfeCwCSTnQRyo50QHACx/r6lMZl6TfPoWgORoV6TEH1IG/AkCYezh8/HAjwybiyu8dF349WPZuSUrHFCY8jCTjzWNqjd38HlzVBCEzT0uZbmowVich+XHVbvT3T8YFPuptv6PpP4tJSZh8sH8yWHTNTeU=
Received: from SJ0PR05CA0109.namprd05.prod.outlook.com (2603:10b6:a03:334::24)
 by PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 20:10:36 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::7) by SJ0PR05CA0109.outlook.office365.com
 (2603:10b6:a03:334::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.18 via Frontend
 Transport; Fri, 11 Aug 2023 20:10:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 20:10:36 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 15:10:29 -0500
Subject: [PATCH v7 5/8] x86/resctrl: Unwind the errors inside rdt_enable_ctx()
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
Date:   Fri, 11 Aug 2023 15:09:53 -0500
Message-ID: <169178459367.1147205.14975628669652538089.stgit@bmoger-ubuntu>
In-Reply-To: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|PH7PR12MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 668a550d-66f6-4143-7546-08db9aa70690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePde88xC62ieSkVvBG/8kIyM+Cr73Hyld77lRL+o5sWzV3eISpiW0DBM7BvhFYUdOAVbnWkNhslhMzx03olQP7CCw5DGGsE0I7oeCGUn97eBy0rM0b6/7bIenHtYb2dobEgHzJsZAG1Vx+xGbSd+mKVk/cze44Z4LjcRCdKLI7R2Z6V4ZVDtlBy1wzzu8zd3VzmQjeHclsHL0OXRgr1ws6y5JLcjQwTLhZkKk2/Zq1OT2P9h8PYw5J2KsrljXpn7ruHxCne4eoCIl0i3Zs/y2trPaj0YRMUAPiAzHgUj8HlMTaBVx/DlZ0rt0y3P99UikfuVwFSzVUfTi6dQBJLJWIFYpW5vXIHMWhmQ4FxnuYTaH0g6voVTMyxFg61zDs6Gdm8twBieXJyzSh4zeGAQw/V6RetFO6uKc4ju+eDWWPMCBTZBOwsApTYn36+wjoXtT0+QFw8uCOuaSjxKa9z+YHPq1W5Gvk8l4NMBPq70Wit+cyJlo09UnzGS5eETYcaXPx7yR07BcMzziSxHvde9abRMaKkcey9djLpY5Mtcc4pV9sHvNFi7giD0g9Skjbe30q3wKQhrFshsBgcmv3HIFZxjgvsLYbhX/WcP7TDxhmIX6mGgWcU8s4517DzkLRflfzw9C9G74GVy9imo3NKBqWK0cJQQe1MTp9uYVT/A5+xS9lSp0p8ZofK9zWyxYBv4wYCIY2QHo3XE8oKfA7ONncnae5n6l2sSlAYwv/rWxLASN8BvMBzz4Kqhlb3hALtX+PtywZrewTvXtUQ97PJvsJmwUvwnBc/W12KTHX+5Zqs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(82310400008)(1800799006)(186006)(36840700001)(46966006)(40470700004)(40460700003)(4326008)(7416002)(356005)(16526019)(7406005)(81166007)(336012)(33716001)(41300700001)(44832011)(426003)(70206006)(36860700001)(47076005)(70586007)(40480700001)(5660300002)(82740400003)(83380400001)(6666004)(316002)(54906003)(110136005)(103116003)(8936002)(8676002)(2906002)(86362001)(16576012)(26005)(478600001)(9686003)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 20:10:36.1997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 668a550d-66f6-4143-7546-08db9aa70690
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdt_enable_ctx() enables the features provided during resctrl mount.=0A=
=0A=
Additions to rdt_enable_ctx() are required to also modify error paths=0A=
of rdt_enable_ctx() callers to ensure correct unwinding if errors=0A=
are encountered after calling rdt_enable_ctx(). This is error prone.=0A=
=0A=
Introduce rdt_disable_ctx() to refactor the error unwinding of=0A=
rdt_enable_ctx() to simplify future additions.=0A=
=0A=
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   44 ++++++++++++++++++++++++----=
----=0A=
 1 file changed, 33 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 3010e3a1394d..0805fac04401 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -2377,19 +2377,44 @@ static int mkdir_mondata_all(struct kernfs_node *pa=
rent_kn,=0A=
 			     struct rdtgroup *prgrp,=0A=
 			     struct kernfs_node **mon_data_kn);=0A=
 =0A=
+static void rdt_disable_ctx(struct rdt_fs_context *ctx)=0A=
+{=0A=
+	if (ctx->enable_cdpl2)=0A=
+		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);=0A=
+=0A=
+	if (ctx->enable_cdpl3)=0A=
+		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);=0A=
+=0A=
+	if (ctx->enable_mba_mbps)=0A=
+		set_mba_sc(false);=0A=
+}=0A=
+=0A=
 static int rdt_enable_ctx(struct rdt_fs_context *ctx)=0A=
 {=0A=
 	int ret =3D 0;=0A=
 =0A=
-	if (ctx->enable_cdpl2)=0A=
+	if (ctx->enable_cdpl2) {=0A=
 		ret =3D resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);=0A=
+		if (ret)=0A=
+			goto out_disable;=0A=
+	}=0A=
 =0A=
-	if (!ret && ctx->enable_cdpl3)=0A=
+	if (ctx->enable_cdpl3) {=0A=
 		ret =3D resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);=0A=
+		if (ret)=0A=
+			goto out_disable;=0A=
+	}=0A=
 =0A=
-	if (!ret && ctx->enable_mba_mbps)=0A=
+	if (ctx->enable_mba_mbps) {=0A=
 		ret =3D set_mba_sc(true);=0A=
+		if (ret)=0A=
+			goto out_disable;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
 =0A=
+out_disable:=0A=
+	rdt_disable_ctx(ctx);=0A=
 	return ret;=0A=
 }=0A=
 =0A=
@@ -2497,13 +2522,13 @@ static int rdt_get_tree(struct fs_context *fc)=0A=
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
@@ -2562,11 +2587,8 @@ static int rdt_get_tree(struct fs_context *fc)=0A=
 	kernfs_remove(kn_info);=0A=
 out_schemata_free:=0A=
 	schemata_list_destroy();=0A=
-out_mba:=0A=
-	if (ctx->enable_mba_mbps)=0A=
-		set_mba_sc(false);=0A=
-out_cdp:=0A=
-	cdp_disable_all();=0A=
+out_ctx:=0A=
+	rdt_disable_ctx(ctx);=0A=
 out:=0A=
 	rdt_last_cmd_clear();=0A=
 	mutex_unlock(&rdtgroup_mutex);=0A=
=0A=


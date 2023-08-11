Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E5A779848
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbjHKUKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjHKUKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:10:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172A730C8;
        Fri, 11 Aug 2023 13:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TohYvuRzy0colFOGkylCp0sL9OPyy9kSrYi6yvsv0Q421yUZ1zwaxmYuAr0xpgnylTSgy65Mh7vJOctc9dO+5IXWgtOlqpl1+R/tO4ePKkubHOaN3J9GmjBHjQKF+4tASWDwHTAmOaUNOpNvA5HXz16yv7Glvhx1Hhj+qdWAfIzPK9c8zePBHSqUaMnN/Kt8jRMP9qDbBUxwefY6y+lb2rCkZUa/m5aJ3VUnKOOh6oT0xj1+quTYnq5OilOWRSEd5JakeQeet89DXlorMYAN/HYpBsEsV1Rz2vkMnEgEKLPibUEmOaaPeBenqcrL29d//v7yaHppoYHP4hy4oxO1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfgYOsCGtiaBFc0QyKVPj6KYurATlWLcaOnrA1ibq6o=;
 b=OgUUG2UyfwSKOm+X05fm761f4BhumpuByLxcUyLbTUtcqWzmJnOfUlintLk58NSsLOy5c717yVTX1AqPd1+EpBQxND2sVCBT71CYoNGnMpaxp//DWTnmz/OXZR18/VhdJLWJno/ngCw6xLrSxWzhQCX5VXjd6wh7ngFiIbUF3+8xY8xLF7XDCgEzO0TZ+NAHFUPv/cnJkU5p05lBIO5gYo0iihVDMXOlG7eriBvUIv0AAVPE7aC6BqkAauLvi1WorINWtGqt9HhZeRly+VIXaMjuXwcHEzbVCa46hKoceYv9AmaJmsZSd3/8EX9UP9sMOtk3ZkFKOOoPJqw32mbFJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=csgroup.eu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfgYOsCGtiaBFc0QyKVPj6KYurATlWLcaOnrA1ibq6o=;
 b=cI0nl/Eq9K+c0L4uhZwq5adBLgW3qBwuAO03lbPGbJW4S0xQ8b7JsQktzXMeHybHBcFv4Ml1Y79xzYcrjMDS/j3q1ZIN3RhPYYqlH1NAvtRVzDnpdWo1Dg+RV4GXhAY7Gas+ZAfC6IL+ayeMJZZ+knImtm8VyJlQIgWlyTI6SJ4=
Received: from BYAPR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:74::29)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 20:10:46 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::c1) by BYAPR05CA0052.outlook.office365.com
 (2603:10b6:a03:74::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.15 via Frontend
 Transport; Fri, 11 Aug 2023 20:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 20:10:45 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 15:10:42 -0500
Subject: [PATCH v7 6/8] x86/resctrl: Move default control group creation
 during mount
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
Date:   Fri, 11 Aug 2023 15:10:36 -0500
Message-ID: <169178463637.1147205.7411319721706077266.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf14f01-f2d0-437a-a155-08db9aa70c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZSUqi3/lsNHBMuA2zbvsGw6Hv/pQJEAaCthU6I+kfAebe/9PL65fDqk7NzGQaTpKchDZdXPH0kO+cW59UFlYqgiAHJF/MWpYirXGBR0h2j7eatMlNh1Hcj5ODie0WXeaGW7HNap7ZJLnd3h51NFxCeGXMt7d9AYVKGuAdA4gEeqR+exDW3rRZ4b2L3FoMaIL9FPEyhVFjZ66SajdErOBZP6JBb6HrZLnbxrWL7vcoeWd+D6BB4WhgCG8U8AUKfeEt4vNbXeCtCMnw0cVvslO543S2mFmcacOg0Vg7x1TGPaVAhTpnzp9WDGUJVYAiVgtECUiUzY8/6iHWSSBsu6DP5d3MNwCwi8CKx+9AG/6bW+WRj+MLBRoCrzUST5PQTq4dbl1mOVh/P6i0d/aROFHW9+x0BC5zD0EkgOKhevENr8RJpOkO77hfvvABralwKg+fqX28n+FkfIU0+3RdT0wLl0sc+/FEWBksApV67B3Jp1LX4h0Coq0toXyDUOHd6jA4Z3XplRW1N4tEZplg+FdLZztpfqB/oU1KzQLXxbcv/WxLuyt8xN/d+Fgdep6MEuApvBQe2PApCy06fBKLEzd3TIEDQJziFjzdOak+yp7UFTP8OHj3ly6/PSu2KykdzONvjfkNwvoPGyCmyENSdSgWzgKe51plIp3ABZGRoiPJOCR6Qg8rEtyup+n8ikzqFlmr4+p1r0/ktVTPZMU4LzRWmvlWA1g/gyhvxHWnhKNAonvzAvOkLEo+kleKXiTNZRVrBueKdbOdLg80mOi2OzjRu6lqcXSFkLcbNFz3nt9DE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(136003)(39860400002)(346002)(376002)(82310400008)(451199021)(186006)(1800799006)(46966006)(40470700004)(36840700001)(36860700001)(2906002)(54906003)(7406005)(7416002)(9686003)(4326008)(47076005)(70206006)(70586007)(110136005)(83380400001)(478600001)(86362001)(426003)(356005)(82740400003)(40460700003)(81166007)(40480700001)(316002)(103116003)(8676002)(8936002)(5660300002)(41300700001)(44832011)(16576012)(336012)(16526019)(6666004)(33716001)(26005)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 20:10:45.5674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf14f01-f2d0-437a-a155-08db9aa70c2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resctrl default control group is created during kernel init time.=0A=
If the new files are to be added to the default group based on the mount=0A=
option, then each file needs to be created separately and call=0A=
kernfs_activate() again.=0A=
=0A=
This can be avoided if all the files are created during the mount and=0A=
destroyed during the umount. So, move the default group creation=0A=
in rdt_get_tree() and removal in rdt_kill_sb().=0A=
=0A=
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   50 +++++++++++++++++-----------=
----=0A=
 2 files changed, 27 insertions(+), 24 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 37800724e002..2bd92c0c3b0c 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -602,5 +602,6 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)=
;=0A=
 void __init thread_throttle_mode_init(void);=0A=
 void __init mbm_config_rftype_init(const char *config);=0A=
 void rdt_staged_configs_clear(void);=0A=
+int rdtgroup_setup_root(struct rdt_fs_context *ctx);=0A=
 =0A=
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 0805fac04401..a7453c93bad4 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -2521,10 +2521,14 @@ static int rdt_get_tree(struct fs_context *fc)=0A=
 		goto out;=0A=
 	}=0A=
 =0A=
-	ret =3D rdt_enable_ctx(ctx);=0A=
+	ret =3D rdtgroup_setup_root(ctx);=0A=
 	if (ret)=0A=
 		goto out;=0A=
 =0A=
+	ret =3D rdt_enable_ctx(ctx);=0A=
+	if (ret)=0A=
+		goto out_root;=0A=
+=0A=
 	ret =3D schemata_list_create();=0A=
 	if (ret) {=0A=
 		schemata_list_destroy();=0A=
@@ -2533,6 +2537,12 @@ static int rdt_get_tree(struct fs_context *fc)=0A=
 =0A=
 	closid_init();=0A=
 =0A=
+	ret =3D rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);=0A=
+	if (ret)=0A=
+		goto out_schemata_free;=0A=
+=0A=
+	kernfs_activate(rdtgroup_default.kn);=0A=
+=0A=
 	ret =3D rdtgroup_create_info_dir(rdtgroup_default.kn);=0A=
 	if (ret < 0)=0A=
 		goto out_schemata_free;=0A=
@@ -2589,6 +2599,8 @@ static int rdt_get_tree(struct fs_context *fc)=0A=
 	schemata_list_destroy();=0A=
 out_ctx:=0A=
 	rdt_disable_ctx(ctx);=0A=
+out_root:=0A=
+	kernfs_destroy_root(rdt_root);=0A=
 out:=0A=
 	rdt_last_cmd_clear();=0A=
 	mutex_unlock(&rdtgroup_mutex);=0A=
@@ -2659,7 +2671,6 @@ static int rdt_init_fs_context(struct fs_context *fc)=
=0A=
 	if (!ctx)=0A=
 		return -ENOMEM;=0A=
 =0A=
-	ctx->kfc.root =3D rdt_root;=0A=
 	ctx->kfc.magic =3D RDTGROUP_SUPER_MAGIC;=0A=
 	fc->fs_private =3D &ctx->kfc;=0A=
 	fc->ops =3D &rdt_fs_context_ops;=0A=
@@ -2830,6 +2841,7 @@ static void rdt_kill_sb(struct super_block *sb)=0A=
 	rdt_pseudo_lock_release();=0A=
 	rdtgroup_default.mode =3D RDT_MODE_SHAREABLE;=0A=
 	schemata_list_destroy();=0A=
+	kernfs_destroy_root(rdt_root);=0A=
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);=0A=
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);=0A=
 	static_branch_disable_cpuslocked(&rdt_enable_key);=0A=
@@ -3711,10 +3723,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall=
_ops =3D {=0A=
 	.show_options	=3D rdtgroup_show_options,=0A=
 };=0A=
 =0A=
-static int __init rdtgroup_setup_root(void)=0A=
+int rdtgroup_setup_root(struct rdt_fs_context *ctx)=0A=
 {=0A=
-	int ret;=0A=
-=0A=
 	rdt_root =3D kernfs_create_root(&rdtgroup_kf_syscall_ops,=0A=
 				      KERNFS_ROOT_CREATE_DEACTIVATED |=0A=
 				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,=0A=
@@ -3722,6 +3732,15 @@ static int __init rdtgroup_setup_root(void)=0A=
 	if (IS_ERR(rdt_root))=0A=
 		return PTR_ERR(rdt_root);=0A=
 =0A=
+	ctx->kfc.root =3D rdt_root;=0A=
+=0A=
+	rdtgroup_default.kn =3D kernfs_root_to_node(rdt_root);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static void __init rdtgroup_setup_default(void)=0A=
+{=0A=
 	mutex_lock(&rdtgroup_mutex);=0A=
 =0A=
 	rdtgroup_default.closid =3D 0;=0A=
@@ -3731,19 +3750,7 @@ static int __init rdtgroup_setup_root(void)=0A=
 =0A=
 	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);=0A=
 =0A=
-	ret =3D rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BAS=
E);=0A=
-	if (ret) {=0A=
-		kernfs_destroy_root(rdt_root);=0A=
-		goto out;=0A=
-	}=0A=
-=0A=
-	rdtgroup_default.kn =3D kernfs_root_to_node(rdt_root);=0A=
-	kernfs_activate(rdtgroup_default.kn);=0A=
-=0A=
-out:=0A=
 	mutex_unlock(&rdtgroup_mutex);=0A=
-=0A=
-	return ret;=0A=
 }=0A=
 =0A=
 static void domain_destroy_mon_state(struct rdt_domain *d)=0A=
@@ -3865,13 +3872,11 @@ int __init rdtgroup_init(void)=0A=
 	seq_buf_init(&last_cmd_status, last_cmd_status_buf,=0A=
 		     sizeof(last_cmd_status_buf));=0A=
 =0A=
-	ret =3D rdtgroup_setup_root();=0A=
-	if (ret)=0A=
-		return ret;=0A=
+	rdtgroup_setup_default();=0A=
 =0A=
 	ret =3D sysfs_create_mount_point(fs_kobj, "resctrl");=0A=
 	if (ret)=0A=
-		goto cleanup_root;=0A=
+		return ret;=0A=
 =0A=
 	ret =3D register_filesystem(&rdt_fs_type);=0A=
 	if (ret)=0A=
@@ -3904,8 +3909,6 @@ int __init rdtgroup_init(void)=0A=
 =0A=
 cleanup_mountpoint:=0A=
 	sysfs_remove_mount_point(fs_kobj, "resctrl");=0A=
-cleanup_root:=0A=
-	kernfs_destroy_root(rdt_root);=0A=
 =0A=
 	return ret;=0A=
 }=0A=
@@ -3915,5 +3918,4 @@ void __exit rdtgroup_exit(void)=0A=
 	debugfs_remove_recursive(debugfs_resctrl);=0A=
 	unregister_filesystem(&rdt_fs_type);=0A=
 	sysfs_remove_mount_point(fs_kobj, "resctrl");=0A=
-	kernfs_destroy_root(rdt_root);=0A=
 }=0A=
=0A=


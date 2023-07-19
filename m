Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE0175A2C3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGSXWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjGSXWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:22:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E841FF9;
        Wed, 19 Jul 2023 16:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzwR/WxAJb8trhv8YHGD3/vEPsMp49LYmEhSHpECkkBkJDShVVLcams2HAzrrvS0euZPtfga3nRJpp3Ra/ThXGcFe8we+ca5cWXBI3l1JcD5X3Piq3LQ+iNIcTCLCFfV07zUoEzadNAffPODONFPCXu+Tvr/ivki1oQxY9r9DtL6Ed9oaJJS0qO1BZz/bUzUJI49AHhVrFxfhmd+1URYKIqb0w1jguQGTUNYaHv4ETg0QkcGNy1U55FemO3q3/l+ane5yYGXemwW/XgmP2OXHTMFwRWrTE4v6ldhgIpp3W9yVl7lKUh6oNFdTNWaKeMOdZfXuR3w3F7fSYfQ9w2lNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrD9V2/prOMs2/duKMdtxaSRbb0w0K/uqb3zoiUjYlg=;
 b=MBWO4z1p9w7vg/55/lNcMEnRqN52Nka4N8dKehg51Vq0K9/M9dPTtHUjCTB4kBcOnFtkVX6xqmQxctN9iRtG916xqBSHg8N535lhMkWntjxGj4AcPZZRgvXt1xDEAqwrVU1wmsCHBlZEsWT7a5Vrvs0QmBr/4EZM11K1QgAiuT4uvw3yL4cYQN+7a6j9UQGDsiLE0QQXFsNSDmRTPtqndqw0g5j+8N69aezAf1dVe2Db5kLneSCjiphsWd78DiStupiDZVkJnPKFhdWtim2N7NabaXKecUR1vWERFeSp3/MUBWZzaWFkVROpmzkdNNr21aaDhZd7fQ021GDFCGGPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrD9V2/prOMs2/duKMdtxaSRbb0w0K/uqb3zoiUjYlg=;
 b=JifsHEmMMFrEfyDp4GM2y+5FliKNFZa4UZjHSNJqOwGRX14rp5rA8p4mCW9sWFGNkH9kuzSGK9CZZxorS6LTG+bONAkyrilo0Z1gTcdpSPHXURbByvwvaK3h4SHg6ghCWILjndgm13PPV9Rp9Yk9wiLHbWlyiMPM6gzFBuknx4I=
Received: from DM5PR07CA0098.namprd07.prod.outlook.com (2603:10b6:4:ae::27) by
 IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 23:22:16 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::f8) by DM5PR07CA0098.outlook.office365.com
 (2603:10b6:4:ae::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 23:22:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 23:22:15 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 18:22:12 -0500
Subject: [PATCH v6 6/8] x86/resctrl: Move default control group creation
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
Date:   Wed, 19 Jul 2023 18:22:11 -0500
Message-ID: <168980893158.1619861.8945141367681744527.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 48509f08-1341-4f2c-e3b2-08db88aefd39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSH5z4GsSB0gEfynm4UUe7x2nJDTxt0pFhm0uQHx++ucEK8tO8ly36qiRzCkJuQ9SfYFSJdM4VZ9Z7+5jv4vDF4syH4jf2Cnm9xvukRkQUv4VcaPNcGxRQ1F3Wfg5F29oGoSxxXvp9xVAPZMOXQyFSequr/K+xZe1JNn+uNUEOOTu0EPtPJFmsziuAAQOcBK3u5/hozlTYyZ7eN1qeANurNNpD/g9qnaEIe7w58E2/jkXTUSMsSKgYlorbEpDiTBskThHdxnU0PNaV6c0qK2O6H0cCHynTCet4b7gPhAw/3GKthPBMJzqaFg18aKYZK5Q5M5D56np2+LHNPYX+meEQhOfLDaH8qv//VHW8gbDXjQri25Tdgtfbs0gAsPSdi46wf5wNw6nAO8O/d8fwm6Gv9Jf4ba36wSuZLyAd1GhrzcSIwTxU8xO/pl1UN49uhmUM6FSBF4sOkcNQ82+vmJOxhWCDoNLo5XDfjHYbpNQN3LBBD4/X5CsBdE6vNmE4C6W23IMpSGhlDItsMWJ//QoGTwgzNxn0jFtNBNWStJ4lLrQqE+TpLF/0cyDj2WLK0YPwNGVA5zDwuxa4dczpLdEg6Az7J5+15bMdMe79YkD3OedC1/wkBUs90b+29uiTtQ6yli1R7D3hrQniEUGqSlJenMDCkODKCAgc2QcTC9EUkQXKhkND0Y0u3/LJefgGuR8eNEi3Zh1zf71pHXc+SMzSI7ePowEt1Dxdx0McD/Dn8jHWr4+vn2F9VpcSutKts7k9xMbreH3Q7JzfgrH/pOy3Q33ASmPDAa/dY1XJQOI4U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(376002)(136003)(396003)(346002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(7416002)(86362001)(2906002)(33716001)(103116003)(7406005)(44832011)(40460700003)(40480700001)(36860700001)(186003)(16526019)(336012)(83380400001)(426003)(9686003)(47076005)(26005)(82740400003)(81166007)(356005)(16576012)(110136005)(70206006)(54906003)(70586007)(478600001)(4326008)(5660300002)(316002)(41300700001)(8936002)(8676002)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 23:22:15.5611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48509f08-1341-4f2c-e3b2-08db88aefd39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301
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

The resctrl default control group is created during kernel init time. If=0A=
the new files are to be added to the default group during the mount based=
=0A=
on the mount option, then each file needs to be created separately and=0A=
call kernfs_activate.=0A=
=0A=
This can avoided if all the files are created during the mount and=0A=
destroyed during the umount. Move the root and default group creation=0A=
in rdt_get_tree and removal in rdt_kill_sb.=0A=
=0A=
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   51 ++++++++++++++--------------=
----=0A=
 2 files changed, 24 insertions(+), 28 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 783c3e36633c..885b656d1088 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -601,5 +601,6 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)=
;=0A=
 void __init thread_throttle_mode_init(void);=0A=
 void __init mbm_config_rftype_init(const char *config);=0A=
 void rdt_staged_configs_clear(void);=0A=
+int rdtgroup_setup_root(void);=0A=
 =0A=
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 9a7204f71d2d..e0570bce76a2 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -2512,10 +2512,16 @@ static int rdt_get_tree(struct fs_context *fc)=0A=
 		goto out;=0A=
 	}=0A=
 =0A=
-	ret =3D rdt_enable_ctx(ctx);=0A=
+	ret =3D rdtgroup_setup_root();=0A=
 	if (ret)=0A=
 		goto out;=0A=
 =0A=
+	ctx->kfc.root =3D rdt_root;=0A=
+=0A=
+	ret =3D rdt_enable_ctx(ctx);=0A=
+	if (ret)=0A=
+		goto out_root;=0A=
+=0A=
 	ret =3D schemata_list_create();=0A=
 	if (ret) {=0A=
 		schemata_list_destroy();=0A=
@@ -2524,6 +2530,12 @@ static int rdt_get_tree(struct fs_context *fc)=0A=
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
@@ -2582,6 +2594,9 @@ static int rdt_get_tree(struct fs_context *fc)=0A=
 	if (ctx->enable_mba_mbps)=0A=
 		set_mba_sc(false);=0A=
 	cdp_disable_all();=0A=
+out_root:=0A=
+	list_del(&rdtgroup_default.rdtgroup_list);=0A=
+	kernfs_destroy_root(rdt_root);=0A=
 out:=0A=
 	rdt_last_cmd_clear();=0A=
 	mutex_unlock(&rdtgroup_mutex);=0A=
@@ -2652,7 +2667,6 @@ static int rdt_init_fs_context(struct fs_context *fc)=
=0A=
 	if (!ctx)=0A=
 		return -ENOMEM;=0A=
 =0A=
-	ctx->kfc.root =3D rdt_root;=0A=
 	ctx->kfc.magic =3D RDTGROUP_SUPER_MAGIC;=0A=
 	fc->fs_private =3D &ctx->kfc;=0A=
 	fc->ops =3D &rdt_fs_context_ops;=0A=
@@ -2821,7 +2835,9 @@ static void rdt_kill_sb(struct super_block *sb)=0A=
 	cdp_disable_all();=0A=
 	rmdir_all_sub();=0A=
 	rdt_pseudo_lock_release();=0A=
-	rdtgroup_default.mode =3D RDT_MODE_SHAREABLE;=0A=
+	/* Remove the default group and cleanup the root */=0A=
+	list_del(&rdtgroup_default.rdtgroup_list);=0A=
+	kernfs_destroy_root(rdt_root);=0A=
 	schemata_list_destroy();=0A=
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);=0A=
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);=0A=
@@ -3704,10 +3720,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall=
_ops =3D {=0A=
 	.show_options	=3D rdtgroup_show_options,=0A=
 };=0A=
 =0A=
-static int __init rdtgroup_setup_root(void)=0A=
+int rdtgroup_setup_root(void)=0A=
 {=0A=
-	int ret;=0A=
-=0A=
 	rdt_root =3D kernfs_create_root(&rdtgroup_kf_syscall_ops,=0A=
 				      KERNFS_ROOT_CREATE_DEACTIVATED |=0A=
 				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,=0A=
@@ -3715,28 +3729,17 @@ static int __init rdtgroup_setup_root(void)=0A=
 	if (IS_ERR(rdt_root))=0A=
 		return PTR_ERR(rdt_root);=0A=
 =0A=
-	mutex_lock(&rdtgroup_mutex);=0A=
-=0A=
 	rdtgroup_default.closid =3D 0;=0A=
 	rdtgroup_default.mon.rmid =3D 0;=0A=
 	rdtgroup_default.type =3D RDTCTRL_GROUP;=0A=
+	rdtgroup_default.mode =3D RDT_MODE_SHAREABLE;=0A=
 	INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);=0A=
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
 	rdtgroup_default.kn =3D kernfs_root_to_node(rdt_root);=0A=
-	kernfs_activate(rdtgroup_default.kn);=0A=
 =0A=
-out:=0A=
-	mutex_unlock(&rdtgroup_mutex);=0A=
-=0A=
-	return ret;=0A=
+	return 0;=0A=
 }=0A=
 =0A=
 static void domain_destroy_mon_state(struct rdt_domain *d)=0A=
@@ -3858,13 +3861,9 @@ int __init rdtgroup_init(void)=0A=
 	seq_buf_init(&last_cmd_status, last_cmd_status_buf,=0A=
 		     sizeof(last_cmd_status_buf));=0A=
 =0A=
-	ret =3D rdtgroup_setup_root();=0A=
-	if (ret)=0A=
-		return ret;=0A=
-=0A=
 	ret =3D sysfs_create_mount_point(fs_kobj, "resctrl");=0A=
 	if (ret)=0A=
-		goto cleanup_root;=0A=
+		return ret;=0A=
 =0A=
 	ret =3D register_filesystem(&rdt_fs_type);=0A=
 	if (ret)=0A=
@@ -3897,9 +3896,6 @@ int __init rdtgroup_init(void)=0A=
 =0A=
 cleanup_mountpoint:=0A=
 	sysfs_remove_mount_point(fs_kobj, "resctrl");=0A=
-cleanup_root:=0A=
-	kernfs_destroy_root(rdt_root);=0A=
-=0A=
 	return ret;=0A=
 }=0A=
 =0A=
@@ -3908,5 +3904,4 @@ void __exit rdtgroup_exit(void)=0A=
 	debugfs_remove_recursive(debugfs_resctrl);=0A=
 	unregister_filesystem(&rdt_fs_type);=0A=
 	sysfs_remove_mount_point(fs_kobj, "resctrl");=0A=
-	kernfs_destroy_root(rdt_root);=0A=
 }=0A=
=0A=


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8DA7CC2DF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbjJQMSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbjJQMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:18:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D4A122;
        Tue, 17 Oct 2023 05:18:03 -0700 (PDT)
Date:   Tue, 17 Oct 2023 12:18:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697545082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L6km3Sh9wIcYQP6WPxZSQoZNa+tTYsygjABCHssKrL4=;
        b=zDwgecM0hxYNLe1ommnlxHvlVEFVCVD0LCHkkTj7YuvOeYRXy7evVZfL+2AUq+7y5sXSTH
        CyAchVBFRzhsZoikLVdDeHOu4ClYj0RabWX3cZumwpP77CezAHEAhVDk+TubkW8pGFFeYe
        yt/9XCpNh7u2KI5eKwsGeA0F/QTANO3H3eN86JyGSLM4Eu5tiSkQnTqPCoSME+ZnGNAbbT
        5D6kPYh+abHOWWJMKBk4v9LeE5shtZ6Ac+vGpt4SgbiYyTdiK2iCnd54ZH5uNtr/Q1w7GR
        nducTe+KCz15zRvWtwyix4LdZZjL27CyoZtHh132C7V7roUWgGzDYzPkyxd/oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697545082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L6km3Sh9wIcYQP6WPxZSQoZNa+tTYsygjABCHssKrL4=;
        b=QDy47XbeqySm5nAOG+z56sJM35LTGe03zT4Dj1/aExuXG4D60ZJzPqCLLgZUocBMxYmCod
        OiFMKAifzHTAB6Bg==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Rename rftype flags for consistency
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Peter Newman <peternewman@google.com>,
        Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        ilpo.jarvinen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017002308.134480-4-babu.moger@amd.com>
References: <20231017002308.134480-4-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <169754508166.3135.16975634975193796362.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     d41592435cde9a658a1bd3b3fdfeb8db7b330d78
Gitweb:        https://git.kernel.org/tip/d41592435cde9a658a1bd3b3fdfeb8db7b3=
30d78
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Mon, 16 Oct 2023 19:23:02 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 17 Oct 2023 11:59:14 +02:00

x86/resctrl: Rename rftype flags for consistency

resctrl associates rftype flags with its files so that files can be chosen
based on the resource, whether it is info or base, and if it is control
or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.

Change the prefix to RFTYPE_ for all these flags to be consistent.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Link: https://lore.kernel.org/r/20231017002308.134480-4-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 10 +++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 44 ++++++++++++-------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index 0ad970c..ba46111 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -248,10 +248,10 @@ struct rdtgroup {
 #define RFTYPE_TOP			BIT(6)
 #define RFTYPE_RES_CACHE		BIT(8)
 #define RFTYPE_RES_MB			BIT(9)
-#define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)
-#define RF_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
-#define RF_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
-#define RF_CTRL_BASE			(RFTYPE_BASE | RFTYPE_CTRL)
+#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
+#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
+#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
+#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
=20
 /* List of all resource groups */
 extern struct list_head rdt_all_groups;
@@ -267,7 +267,7 @@ void __exit rdtgroup_exit(void);
  * @mode:	Access mode
  * @kf_ops:	File operations
  * @flags:	File specific RFTYPE_FLAGS_* flags
- * @fflags:	File specific RF_* or RFTYPE_* flags
+ * @fflags:	File specific RFTYPE_* flags
  * @seq_show:	Show content of the file
  * @write:	Write to the file
  */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/res=
ctrl/rdtgroup.c
index 09141f1..125d12d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1716,77 +1716,77 @@ static struct rftype res_common_files[] =3D {
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D rdt_last_cmd_status_show,
-		.fflags		=3D RF_TOP_INFO,
+		.fflags		=3D RFTYPE_TOP_INFO,
 	},
 	{
 		.name		=3D "num_closids",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D rdt_num_closids_show,
-		.fflags		=3D RF_CTRL_INFO,
+		.fflags		=3D RFTYPE_CTRL_INFO,
 	},
 	{
 		.name		=3D "mon_features",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D rdt_mon_features_show,
-		.fflags		=3D RF_MON_INFO,
+		.fflags		=3D RFTYPE_MON_INFO,
 	},
 	{
 		.name		=3D "num_rmids",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D rdt_num_rmids_show,
-		.fflags		=3D RF_MON_INFO,
+		.fflags		=3D RFTYPE_MON_INFO,
 	},
 	{
 		.name		=3D "cbm_mask",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D rdt_default_ctrl_show,
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_CACHE,
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 	{
 		.name		=3D "min_cbm_bits",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D rdt_min_cbm_bits_show,
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_CACHE,
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 	{
 		.name		=3D "shareable_bits",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D rdt_shareable_bits_show,
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_CACHE,
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 	{
 		.name		=3D "bit_usage",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D rdt_bit_usage_show,
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_CACHE,
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 	{
 		.name		=3D "min_bandwidth",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D rdt_min_bw_show,
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_MB,
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
 	},
 	{
 		.name		=3D "bandwidth_gran",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D rdt_bw_gran_show,
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_MB,
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
 	},
 	{
 		.name		=3D "delay_linear",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D rdt_delay_linear_show,
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_MB,
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
 	},
 	/*
 	 * Platform specific which (if any) capabilities are provided by
@@ -1805,7 +1805,7 @@ static struct rftype res_common_files[] =3D {
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.write		=3D max_threshold_occ_write,
 		.seq_show	=3D max_threshold_occ_show,
-		.fflags		=3D RF_MON_INFO | RFTYPE_RES_CACHE,
+		.fflags		=3D RFTYPE_MON_INFO | RFTYPE_RES_CACHE,
 	},
 	{
 		.name		=3D "mbm_total_bytes_config",
@@ -1852,7 +1852,7 @@ static struct rftype res_common_files[] =3D {
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.write		=3D rdtgroup_schemata_write,
 		.seq_show	=3D rdtgroup_schemata_show,
-		.fflags		=3D RF_CTRL_BASE,
+		.fflags		=3D RFTYPE_CTRL_BASE,
 	},
 	{
 		.name		=3D "mode",
@@ -1860,21 +1860,21 @@ static struct rftype res_common_files[] =3D {
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.write		=3D rdtgroup_mode_write,
 		.seq_show	=3D rdtgroup_mode_show,
-		.fflags		=3D RF_CTRL_BASE,
+		.fflags		=3D RFTYPE_CTRL_BASE,
 	},
 	{
 		.name		=3D "size",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D rdtgroup_size_show,
-		.fflags		=3D RF_CTRL_BASE,
+		.fflags		=3D RFTYPE_CTRL_BASE,
 	},
 	{
 		.name		=3D "sparse_masks",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D rdt_has_sparse_bitmasks_show,
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_CACHE,
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
=20
 };
@@ -1931,7 +1931,7 @@ void __init thread_throttle_mode_init(void)
 	if (!rft)
 		return;
=20
-	rft->fflags =3D RF_CTRL_INFO | RFTYPE_RES_MB;
+	rft->fflags =3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB;
 }
=20
 void __init mbm_config_rftype_init(const char *config)
@@ -1940,7 +1940,7 @@ void __init mbm_config_rftype_init(const char *config)
=20
 	rft =3D rdtgroup_get_rftype_by_name(config);
 	if (rft)
-		rft->fflags =3D RF_MON_INFO | RFTYPE_RES_CACHE;
+		rft->fflags =3D RFTYPE_MON_INFO | RFTYPE_RES_CACHE;
 }
=20
 /**
@@ -2075,21 +2075,21 @@ static int rdtgroup_create_info_dir(struct kernfs_nod=
e *parent_kn)
 	if (IS_ERR(kn_info))
 		return PTR_ERR(kn_info);
=20
-	ret =3D rdtgroup_add_files(kn_info, RF_TOP_INFO);
+	ret =3D rdtgroup_add_files(kn_info, RFTYPE_TOP_INFO);
 	if (ret)
 		goto out_destroy;
=20
 	/* loop over enabled controls, these are all alloc_capable */
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r =3D s->res;
-		fflags =3D  r->fflags | RF_CTRL_INFO;
+		fflags =3D r->fflags | RFTYPE_CTRL_INFO;
 		ret =3D rdtgroup_mkdir_info_resdir(s, s->name, fflags);
 		if (ret)
 			goto out_destroy;
 	}
=20
 	for_each_mon_capable_rdt_resource(r) {
-		fflags =3D  r->fflags | RF_MON_INFO;
+		fflags =3D r->fflags | RFTYPE_MON_INFO;
 		sprintf(name, "%s_MON", r->name);
 		ret =3D rdtgroup_mkdir_info_resdir(r, name, fflags);
 		if (ret)
@@ -3727,7 +3727,7 @@ static int __init rdtgroup_setup_root(void)
=20
 	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
=20
-	ret =3D rdtgroup_add_files(kernfs_root_to_node(rdt_root), RF_CTRL_BASE);
+	ret =3D rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BASE);
 	if (ret) {
 		kernfs_destroy_root(rdt_root);
 		goto out;

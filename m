Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393E97CC2DC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbjJQMSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjJQMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:18:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801BC12F;
        Tue, 17 Oct 2023 05:18:02 -0700 (PDT)
Date:   Tue, 17 Oct 2023 12:17:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697545080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0JU3NqWjgwykZxeiRbyFGvYyb+ANvfSQfxPKkBi3l0w=;
        b=urnxCNelCbDcmdmG5882YuploNlv1LOaVbKOsTkHcvSbN3ylO7lQuCQeKk6+8C5XaqnuJA
        I1BIKuhR89JBVXN7XtqYf8+1NC8rpmtPdprzTyxzYEXWcLVHK/P2NJikGC25f6cYhpRAVr
        gEIarPHiSfOiUidI8F0vuEn/8Oo0LyaDA4fo3r4YospRWn4Eld8YGVRAjQ5SJJVt3q/HIj
        MVk5zUBVzzU2Ji+4T4lmJQx8ym8pkWV/LqY3MYojtWRyaVfQ5RErglYCPHRnomdO7oVa1C
        a0rSPUtHL4kwTuIfrn2CUFHMMM7U+AnTmQmSd9BjHwmL6tRPIZGVll5U7wwxIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697545080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0JU3NqWjgwykZxeiRbyFGvYyb+ANvfSQfxPKkBi3l0w=;
        b=tD5TP2Bgkn7yNWhHOeVZVscjKmJslmwdAWjx7FN1hcy9bFwGHOiIvYUcWZvop7BGVTlWsq
        +gAvSu6NjOJS+XCA==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Introduce "-o debug" mount option
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Peter Newman <peternewman@google.com>,
        Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        ilpo.jarvinen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017002308.134480-7-babu.moger@amd.com>
References: <20231017002308.134480-7-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <169754507967.3135.11415385807971392786.tip-bot2@tip-bot2>
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

Commit-ID:     cb07d71f01017b7c2885ed629da9b973cb56b1d2
Gitweb:        https://git.kernel.org/tip/cb07d71f01017b7c2885ed629da9b973cb5=
6b1d2
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Mon, 16 Oct 2023 19:23:05 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 17 Oct 2023 13:07:17 +02:00

x86/resctrl: Introduce "-o debug" mount option

Add "-o debug" option to mount resctrl filesystem in debug mode.  When
in debug mode resctrl displays files that have the new RFTYPE_DEBUG flag
to help resctrl debugging.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Link: https://lore.kernel.org/r/20231017002308.134480-7-babu.moger@amd.com
---
 Documentation/arch/x86/resctrl.rst     |  5 ++++-
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resc=
trl.rst
index 178ab1d..68f1161 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -35,7 +35,7 @@ about the feature from resctrl's info directory.
=20
 To use the feature mount the file system::
=20
- # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps]] /sys/fs/resctrl
+ # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps][,debug]] /sys/fs/resc=
trl
=20
 mount options are:
=20
@@ -46,6 +46,9 @@ mount options are:
 "mba_MBps":
 	Enable the MBA Software Controller(mba_sc) to specify MBA
 	bandwidth in MBps
+"debug":
+	Make debug files accessible. Available debug files are annotated with
+	"Available only with debug option".
=20
 L2 and L3 CDP are controlled separately.
=20
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index ba46111..b816b90 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -59,6 +59,7 @@ struct rdt_fs_context {
 	bool				enable_cdpl2;
 	bool				enable_cdpl3;
 	bool				enable_mba_mbps;
+	bool				enable_debug;
 };
=20
 static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
@@ -248,6 +249,7 @@ struct rdtgroup {
 #define RFTYPE_TOP			BIT(6)
 #define RFTYPE_RES_CACHE		BIT(8)
 #define RFTYPE_RES_MB			BIT(9)
+#define RFTYPE_DEBUG			BIT(10)
 #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
 #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/res=
ctrl/rdtgroup.c
index 55da93b..84e0f45 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -59,6 +59,8 @@ static void rdtgroup_destroy_root(void);
=20
 struct dentry *debugfs_resctrl;
=20
+static bool resctrl_debug;
+
 void rdt_last_cmd_clear(void)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
@@ -1892,6 +1894,9 @@ static int rdtgroup_add_files(struct kernfs_node *kn, u=
nsigned long fflags)
=20
 	lockdep_assert_held(&rdtgroup_mutex);
=20
+	if (resctrl_debug)
+		fflags |=3D RFTYPE_DEBUG;
+
 	for (rft =3D rfts; rft < rfts + len; rft++) {
 		if (rft->fflags && ((fflags & rft->fflags) =3D=3D rft->fflags)) {
 			ret =3D rdtgroup_add_file(kn, rft);
@@ -2395,6 +2400,8 @@ static void rdt_disable_ctx(void)
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
 	set_mba_sc(false);
+
+	resctrl_debug =3D false;
 }
=20
 static int rdt_enable_ctx(struct rdt_fs_context *ctx)
@@ -2419,6 +2426,9 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 			goto out_cdpl3;
 	}
=20
+	if (ctx->enable_debug)
+		resctrl_debug =3D true;
+
 	return 0;
=20
 out_cdpl3:
@@ -2623,6 +2633,7 @@ enum rdt_param {
 	Opt_cdp,
 	Opt_cdpl2,
 	Opt_mba_mbps,
+	Opt_debug,
 	nr__rdt_params
 };
=20
@@ -2630,6 +2641,7 @@ static const struct fs_parameter_spec rdt_fs_parameters=
[] =3D {
 	fsparam_flag("cdp",		Opt_cdp),
 	fsparam_flag("cdpl2",		Opt_cdpl2),
 	fsparam_flag("mba_MBps",	Opt_mba_mbps),
+	fsparam_flag("debug",		Opt_debug),
 	{}
 };
=20
@@ -2655,6 +2667,9 @@ static int rdt_parse_param(struct fs_context *fc, struc=
t fs_parameter *param)
 			return -EINVAL;
 		ctx->enable_mba_mbps =3D true;
 		return 0;
+	case Opt_debug:
+		ctx->enable_debug =3D true;
+		return 0;
 	}
=20
 	return -EINVAL;
@@ -3723,6 +3738,9 @@ static int rdtgroup_show_options(struct seq_file *seq, =
struct kernfs_root *kf)
 	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
 		seq_puts(seq, ",mba_MBps");
=20
+	if (resctrl_debug)
+		seq_puts(seq, ",debug");
+
 	return 0;
 }
=20

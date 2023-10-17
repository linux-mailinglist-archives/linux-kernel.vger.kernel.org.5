Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113CB7CC2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjJQMSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjJQMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:18:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4893E12B;
        Tue, 17 Oct 2023 05:18:00 -0700 (PDT)
Date:   Tue, 17 Oct 2023 12:17:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697545078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o70cCE9g0ryKQI1VtXZcY2oshzLla63ENfUv/mZxCFs=;
        b=HSs+Q5YGMpzW7Z/7K1iNjriHd09moX/9Bq8zg3jYRMm10aiKJvzrM+5EAzCR7gjEOVMm2n
        jfbBLfzbKpEzuT6GhsvayxNbfWr6gbldBdtX4X9cv+9PqO6W4Z8+snxG8awy7zh+lM/VEH
        YqbEjKCskI2rendN4ik7+Z1SfnPBMduYU2vCVIiDD6iRup9UN+O5EHuXUiQgHdlI2bkLpD
        Szwp8ozlMfBfIgkV7r7t8hB1A3Z94cG3qXEkTNOMh36vvp2GRYhZo2zzK0D0ZeYWM7SVfG
        ZeBvKgJaYnQxIJny+IId3Nkz/GrFt8UXAPboDUoW9KaxFg2T3x00s8QdovgYkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697545078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o70cCE9g0ryKQI1VtXZcY2oshzLla63ENfUv/mZxCFs=;
        b=x9nMaxkY/JFGv5+59crpscrBlclKMo6klOSvuhnCcclQ7MRgu3rLm76F6GpGSN9p32Agfs
        A7lx8IyDDKv9JnBQ==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Display RMID of resource group
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Peter Newman <peternewman@google.com>,
        Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        ilpo.jarvinen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017002308.134480-10-babu.moger@amd.com>
References: <20231017002308.134480-10-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <169754507762.3135.4057525266393369343.tip-bot2@tip-bot2>
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

Commit-ID:     4cee14bcb14881aae81d60f106a335c68553ac1f
Gitweb:        https://git.kernel.org/tip/4cee14bcb14881aae81d60f106a335c6855=
3ac1f
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Mon, 16 Oct 2023 19:23:08 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 17 Oct 2023 14:05:40 +02:00

x86/resctrl: Display RMID of resource group

In x86, hardware uses RMID to identify a monitoring group. When a user
creates a monitor group these details are not visible. These details
can help resctrl debugging.

Add RMID(mon_hw_id) to the monitor groups display in the resctrl interface.
Users can see these details when resctrl is mounted with "-o debug" option.

Add RFTYPE_MON_BASE that complements existing RFTYPE_CTRL_BASE and
represents files belonging to monitoring groups.

Other architectures do not use "RMID". Use the name mon_hw_id to refer
to "RMID" in an effort to keep the naming generic.

For example:
  $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id
  3

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Link: https://lore.kernel.org/r/20231017002308.134480-10-babu.moger@amd.com
---
 Documentation/arch/x86/resctrl.rst     |  4 ++++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resc=
trl.rst
index 7412252..a6279df 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -376,6 +376,10 @@ When monitoring is enabled all MON groups will also cont=
ain:
 	the sum for all tasks in the CTRL_MON group and all tasks in
 	MON groups. Please see example section for more details on usage.
=20
+"mon_hw_id":
+	Available only with debug option. The identifier used by hardware
+	for the monitor group. On x86 this is the RMID.
+
 Resource allocation rules
 -------------------------
=20
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index b816b90..a4f1aa1 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -254,6 +254,7 @@ struct rdtgroup {
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
 #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
 #define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
+#define RFTYPE_MON_BASE			(RFTYPE_BASE | RFTYPE_MON)
=20
 /* List of all resource groups */
 extern struct list_head rdt_all_groups;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/res=
ctrl/rdtgroup.c
index 5f6d6ba..69a1de9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -795,6 +795,22 @@ static int rdtgroup_closid_show(struct kernfs_open_file =
*of,
 	return ret;
 }
=20
+static int rdtgroup_rmid_show(struct kernfs_open_file *of,
+			      struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	int ret =3D 0;
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (rdtgrp)
+		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
+	else
+		ret =3D -ENOENT;
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
=20
 /*
@@ -1868,6 +1884,13 @@ static struct rftype res_common_files[] =3D {
 		.fflags		=3D RFTYPE_BASE,
 	},
 	{
+		.name		=3D "mon_hw_id",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdtgroup_rmid_show,
+		.fflags		=3D RFTYPE_MON_BASE | RFTYPE_DEBUG,
+	},
+	{
 		.name		=3D "schemata",
 		.mode		=3D 0644,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,

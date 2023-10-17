Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C030D7CC2D7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjJQMSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjJQMSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:18:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54EDF2;
        Tue, 17 Oct 2023 05:18:01 -0700 (PDT)
Date:   Tue, 17 Oct 2023 12:17:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697545079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tRii31kzoOkxgXH61iIPFY76NO+CH3zPM7DZu/1Zwk8=;
        b=PneOKyJGVIgKTQZWtRM75n4ER7fffExek+XmAGakg20zhvjyn6sI0pqYkOFr1nDiZzeO/Y
        5MLU2ILgdn9oauCNTsravWx1Ze7PhVea3nK1CSbGcYknkKhL+nYrT5FtUCK1C/uW0JxhRK
        fRqhhUDNzVOXuWvtmPjOjWH2Cb0MiCbsz1ZGHPBlw0hZxbyp8r45tnDLaYZC0Lu4XO7EsA
        pcmL42oyDKRoWsrPirtYtz/Vn1DOi1E0coH70Ht6lSZm1qXUPQQSf06fTLGpoIQpdnf6ye
        DXMTxiBe54D/per7GoVUxaRHxn36k8TqsJXmiBRlwjn7dUbcDdbmfEBYCDo73g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697545079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tRii31kzoOkxgXH61iIPFY76NO+CH3zPM7DZu/1Zwk8=;
        b=rQaGNMKk4ildL9Baw/2SDksVrWQ3S/2Dgp4Y/k10MawKOQt2mNTwH/l4GwyhP+J/HQjtrZ
        NBQRcIpFuXLeN2Bw==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Display CLOSID for resource group
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Peter Newman <peternewman@google.com>,
        Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        ilpo.jarvinen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017002308.134480-8-babu.moger@amd.com>
References: <20231017002308.134480-8-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <169754507899.3135.1095916049785753629.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     ca8dad225e237493f19b1c5d4a8531f13a9b078f
Gitweb:        https://git.kernel.org/tip/ca8dad225e237493f19b1c5d4a8531f13a9=
b078f
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Mon, 16 Oct 2023 19:23:06 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 17 Oct 2023 14:05:14 +02:00

x86/resctrl: Display CLOSID for resource group

In x86, hardware uses CLOSID to identify a control group. When a user
creates a control group this information is not visible to the user. It
can help resctrl debugging.

Add CLOSID(ctrl_hw_id) to the control groups display in the resctrl
interface. Users can see this detail when resctrl is mounted with the
"-o debug" option.

Other architectures do not use "CLOSID". Use the names ctrl_hw_id to refer
to "CLOSID" in an effort to keep the naming generic.

For example:
  $cat /sys/fs/resctrl/ctrl_grp1/ctrl_hw_id
  1

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Link: https://lore.kernel.org/r/20231017002308.134480-8-babu.moger@amd.com
---
 Documentation/arch/x86/resctrl.rst     |  4 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resc=
trl.rst
index 68f1161..7412252 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -359,6 +359,10 @@ When control is enabled all CTRL_MON groups will also co=
ntain:
 	file. On successful pseudo-locked region creation the mode will
 	automatically change to "pseudo-locked".
=20
+"ctrl_hw_id":
+	Available only with debug option. The identifier used by hardware
+	for the control group. On x86 this is the CLOSID.
+
 When monitoring is enabled all MON groups will also contain:
=20
 "mon_data":
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/res=
ctrl/rdtgroup.c
index 84e0f45..5814a0b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -779,6 +779,22 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *=
of,
 	return ret;
 }
=20
+static int rdtgroup_closid_show(struct kernfs_open_file *of,
+				struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	int ret =3D 0;
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (rdtgrp)
+		seq_printf(s, "%u\n", rdtgrp->closid);
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
@@ -1881,6 +1897,13 @@ static struct rftype res_common_files[] =3D {
 		.seq_show	=3D rdt_has_sparse_bitmasks_show,
 		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
+	{
+		.name		=3D "ctrl_hw_id",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdtgroup_closid_show,
+		.fflags		=3D RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
+	},
=20
 };
=20

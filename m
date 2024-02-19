Return-Path: <linux-kernel+bounces-71832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBCA85AB37
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF1C1F22433
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966C454BD2;
	Mon, 19 Feb 2024 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jfS1Dk93";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wGFwjTPo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D76537E9;
	Mon, 19 Feb 2024 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367863; cv=none; b=ThVRmP07uv4uX4I5y0RPUzQDFxyQXCxdsF1kEluXQPW1lQuPTRqhufBnHxWYoCCDB/sfFBm2U27zeDAfIGOX3HT+ngXuxnM7iV1WZjMa76SgtRU0GkcMnTi3Xq5e921XLNPO93NeZpUhyRFQSEcx1aPRKhRjA7jQcq+IREgeRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367863; c=relaxed/simple;
	bh=q7Z0zDf2sHYGuXHOEP78pHQ8wLIL1eLFN1+2JS1vUoE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cbcFG5NYgT35gNtTTdSDz0lw2nloxdLTKWCRM7kWnIYmppj118KAJMb6LsykxZMUfBAe2xMMc9NxK/Sl6nwJGoRC5ynPUzB4qcSBY1MdgWvzU+0KpKYuyLthw/WAyCHA1fD/PxW/0LPHHnIYps8FwigoWxnq2liLF8p/zEtKhKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jfS1Dk93; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wGFwjTPo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W69O648/cDrwBZrR7qGW2NNfJAmJ741ypx6S+2Sk2nA=;
	b=jfS1Dk93ysIOl/Sb4LWIPpMrph65dSW54hT6zisF6r2z47OfcwEtxV1e/25tLOmYZm9fMO
	QrP/i2797ns/syNc1+EFDcLFrdu3Thm/8r0YSL4S1atbJP5Q/JXh2uekydvBCTAdw+g5pf
	yorAbrppbfywCWmcaSybYmAD29EmuknuoaMwffXyYtWvrLgG+mH1ody0Ts1UB4kt4gcjbp
	5/WJMUrNJK0Qy0kjTm9PzKcEPd0sX+E/yYp68Yxk6QDr1+eLK7nWgE6XZITFUiQK39v49g
	a1FqoLuHBJpFgoiO/40yozptITK7E+DJOPpwzytaKjQaADBAViA+2xp1ny/euw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W69O648/cDrwBZrR7qGW2NNfJAmJ741ypx6S+2Sk2nA=;
	b=wGFwjTPolkL/rQjzPMC9zB1OEKdtsCDZm1/KyijH6B9jaJDZnAYkiqM/KIvAdXHZovcMB3
	F2UjMIJuu/mMEODA==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Move RMID allocation out of mkdir_rdt_prepare()
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-5-james.morse@arm.com>
References: <20240213184438.16675-5-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836785924.398.3184776632833650588.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     311639e9512bb3af2abae32be9322b8a9b30eaa1
Gitweb:        https://git.kernel.org/tip/311639e9512bb3af2abae32be9322b8a9b30eaa1
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:18 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:31 +01:00

x86/resctrl: Move RMID allocation out of mkdir_rdt_prepare()

RMIDs are allocated for each monitor or control group directory, because
each of these needs its own RMID. For control groups,
rdtgroup_mkdir_ctrl_mon() later goes on to allocate the CLOSID.

MPAM's equivalent of RMID is not an independent number, so can't be
allocated until the CLOSID is known. An RMID allocation for one CLOSID
may fail, whereas another may succeed depending on how many monitor
groups a control group has.

The RMID allocation needs to move to be after the CLOSID has been
allocated.

Move the RMID allocation out of mkdir_rdt_prepare() to occur in its caller,
after the mkdir_rdt_prepare() call. This allows the RMID allocator to
know the CLOSID.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-5-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 35 ++++++++++++++++++-------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 4ea5a87..f455a10 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3312,6 +3312,12 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 	return 0;
 }
 
+static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
+{
+	if (rdt_mon_capable)
+		free_rmid(rgrp->mon.rmid);
+}
+
 static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 			     const char *name, umode_t mode,
 			     enum rdt_group_type rtype, struct rdtgroup **r)
@@ -3384,12 +3390,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 		goto out_destroy;
 	}
 
-	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
-	if (ret)
-		goto out_destroy;
-
-	kernfs_activate(kn);
-
 	/*
 	 * The caller unlocks the parent_kn upon success.
 	 */
@@ -3408,7 +3408,6 @@ out_unlock:
 static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
 {
 	kernfs_remove(rgrp->kn);
-	free_rmid(rgrp->mon.rmid);
 	rdtgroup_remove(rgrp);
 }
 
@@ -3430,12 +3429,21 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
 	prgrp = rdtgrp->mon.parent;
 	rdtgrp->closid = prgrp->closid;
 
+	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
+	if (ret) {
+		mkdir_rdt_prepare_clean(rdtgrp);
+		goto out_unlock;
+	}
+
+	kernfs_activate(rdtgrp->kn);
+
 	/*
 	 * Add the rdtgrp to the list of rdtgrps the parent
 	 * ctrl_mon group has to track.
 	 */
 	list_add_tail(&rdtgrp->mon.crdtgrp_list, &prgrp->mon.crdtgrp_list);
 
+out_unlock:
 	rdtgroup_kn_unlock(parent_kn);
 	return ret;
 }
@@ -3466,9 +3474,16 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 	ret = 0;
 
 	rdtgrp->closid = closid;
+
+	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
+	if (ret)
+		goto out_closid_free;
+
+	kernfs_activate(rdtgrp->kn);
+
 	ret = rdtgroup_init_alloc(rdtgrp);
 	if (ret < 0)
-		goto out_id_free;
+		goto out_rmid_free;
 
 	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
 
@@ -3488,7 +3503,9 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 
 out_del_list:
 	list_del(&rdtgrp->rdtgroup_list);
-out_id_free:
+out_rmid_free:
+	mkdir_rdt_prepare_rmid_free(rdtgrp);
+out_closid_free:
 	closid_free(closid);
 out_common_fail:
 	mkdir_rdt_prepare_clean(rdtgrp);


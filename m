Return-Path: <linux-kernel+bounces-71833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDA685AB39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32EBDB25E41
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D9054F8B;
	Mon, 19 Feb 2024 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ITcQVtQu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r9r6QyGj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F0853805;
	Mon, 19 Feb 2024 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367864; cv=none; b=Wcwhh2k1TNsejuIwGY09yDqsrE5QWR494OvsL+yLJ+hJTy/XrmW2uYq+zmvjWNLcihQGdnrJNkeYbUhCysYDmkagz2xkrEH5rDLan6fJE0tcaBLM3wW+ujoFFlIMrp+0W/G0lOxbMzaXkvZLYZJFjzpxnmC5m7+xpo6MIvech0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367864; c=relaxed/simple;
	bh=WCORwWdgbnnKQewSn/5SZtw1kNBcXmb3yv93ydSiP5Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bFV+5jQ1GUmLy8BIO1IrRMUE1RNIPUUtVE/oJHoe1qGLUtbCVez4oHjfaKoZR1Ch/K0TC5H6VpEGTRi24GLiU+QXBvZTyX+Q0h1nlcC0P3Cd7uSBCBeVQmXwkTQKRWKcd0gNsBL8O0heczwaNxi8HCH/JNPsLDDzdJovTvb/UMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ITcQVtQu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r9r6QyGj; arc=none smtp.client-ip=193.142.43.55
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
	bh=P8uQUEP7sHBDAE6xDrwE50fmOGZvNATtQCG6BlfpgkI=;
	b=ITcQVtQuZQBtY+EWvSyp5Xrssk2bEtYhnU+7iKivsTzKQ6opuBZgjtSVsarIVpFRvFo4Jd
	kLcanE8j/XOPHhrN+X7cGiQdSqWVxJRaCnNO4ucMtb33bpVhaCyF3nyPqNpfhAdsuwSl1o
	2aVfMC3QUc1BJ7hXtmPsr7p51rhWiI7o+KDsOmISmcBSPeJe5plzx2xF/xXvE3ekqaCI5R
	ELIOeqKHMCEa9atv9J5sLyEj9d6+f+lpeJ/RDB6EVFslPzbdm/FPc4mr4Khx2dLhoYaRlG
	Otd45aRs+cGSXfr6fDQQCod9kHr/o+92vDtVm6xKwlJ4GltM7q3vgKFNSbLncg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8uQUEP7sHBDAE6xDrwE50fmOGZvNATtQCG6BlfpgkI=;
	b=r9r6QyGjR085Snx1JxAdIRfoM/FlHXVV1XdBp7/Wfw301CRnAntYJZb8Gf+TKWyvqx4k+8
	WFliF8xhZbdphgDg==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Create helper for RMID allocation and
 mondata dir creation
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>, ilpo.jarvinen@linux.intel.com,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-4-james.morse@arm.com>
References: <20240213184438.16675-4-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836785987.398.10687382192378795242.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     b1de313979af99dc0f999656fc99bbcb52559a38
Gitweb:        https://git.kernel.org/tip/b1de313979af99dc0f999656fc99bbcb525=
59a38
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:17=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:31 +01:00

x86/resctrl: Create helper for RMID allocation and mondata dir creation

When monitoring is supported, each monitor and control group is allocated an
RMID. For control groups, rdtgroup_mkdir_ctrl_mon() later goes on to allocate
the CLOSID.

MPAM's equivalent of RMID are not an independent number, so can't be allocated
until the CLOSID is known. An RMID allocation for one CLOSID may fail, whereas
another may succeed depending on how many monitor groups a control group has.

The RMID allocation needs to move to be after the CLOSID has been allocated.

Move the RMID allocation and mondata dir creation to a helper.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-4-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 42 ++++++++++++++++---------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/res=
ctrl/rdtgroup.c
index aa24343..4ea5a87 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3288,6 +3288,30 @@ out:
 	return ret;
 }
=20
+static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
+{
+	int ret;
+
+	if (!rdt_mon_capable)
+		return 0;
+
+	ret =3D alloc_rmid();
+	if (ret < 0) {
+		rdt_last_cmd_puts("Out of RMIDs\n");
+		return ret;
+	}
+	rdtgrp->mon.rmid =3D ret;
+
+	ret =3D mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
+	if (ret) {
+		rdt_last_cmd_puts("kernfs subdir error\n");
+		free_rmid(rdtgrp->mon.rmid);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 			     const char *name, umode_t mode,
 			     enum rdt_group_type rtype, struct rdtgroup **r)
@@ -3360,20 +3384,10 @@ static int mkdir_rdt_prepare(struct kernfs_node *pare=
nt_kn,
 		goto out_destroy;
 	}
=20
-	if (rdt_mon_capable) {
-		ret =3D alloc_rmid();
-		if (ret < 0) {
-			rdt_last_cmd_puts("Out of RMIDs\n");
-			goto out_destroy;
-		}
-		rdtgrp->mon.rmid =3D ret;
+	ret =3D mkdir_rdt_prepare_rmid_alloc(rdtgrp);
+	if (ret)
+		goto out_destroy;
=20
-		ret =3D mkdir_mondata_all(kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
-		if (ret) {
-			rdt_last_cmd_puts("kernfs subdir error\n");
-			goto out_idfree;
-		}
-	}
 	kernfs_activate(kn);
=20
 	/*
@@ -3381,8 +3395,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent=
_kn,
 	 */
 	return 0;
=20
-out_idfree:
-	free_rmid(rdtgrp->mon.rmid);
 out_destroy:
 	kernfs_put(rdtgrp->kn);
 	kernfs_remove(rdtgrp->kn);


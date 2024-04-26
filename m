Return-Path: <linux-kernel+bounces-160248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6154E8B3ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1A7AB20D68
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A263F172BD2;
	Fri, 26 Apr 2024 15:10:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63A8172BC1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144248; cv=none; b=U/n/+6JSL2V6szYM3zTPHXgDutt73sG8oxgDFcsTHbLwhiq44dwkeN2cV+KHJ/JjG0otbpyo0yUlayaIm35Wg+9jcvOMF1TorVQZmaNUc49lvSS5nAN829O2jG4rukdxBCB4UU07JPz7tvwSwmuUDsSxn8kMX+7racQMVeSBVl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144248; c=relaxed/simple;
	bh=hX+Pi0uWtticanANrvdQL8nKhRDqlgNKxiF6qD7pQA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jb2jbSRcv6UGx7UaHqK/Ddm0XNFAkB22Q8m333QxhTtDwbdhaI8iJ0WubYxCCdy6W6M52CZvNFKdtjOgr4tIG4reYNq5Yp6HJXmnnYXn2SthoCS6eknOenmhblosRsQlThHjj6SlrKYJbpDlGTSDHLW9UHIB3cLgQE+98lBjuyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CA841682;
	Fri, 26 Apr 2024 08:11:14 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5561D3F73F;
	Fri, 26 Apr 2024 08:10:43 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH v2 30/35] x86/resctrl: Squelch whitespace anomalies in resctrl core code
Date: Fri, 26 Apr 2024 16:08:59 +0100
Message-Id: <20240426150904.8854-30-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426150904.8854-1-Dave.Martin@arm.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <20240426150904.8854-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch.pl complains about some whitespace anomalies in the
resctrl core code.

This doesn't matter, but since this code is about to be factored
out and made generic, this is a good opportunity to fix these
issues and so reduce future checkpatch fuzz.

Fix them.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes in v2:

 * New patch.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e78fa33c87e2..5cb0d6f805bd 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -991,7 +991,7 @@ static int rdt_num_closids_show(struct kernfs_open_file *of,
 }
 
 static int rdt_default_ctrl_show(struct kernfs_open_file *of,
-			     struct seq_file *seq, void *v)
+				 struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = of->kn->parent->priv;
 	struct rdt_resource *r = s->res;
@@ -1001,7 +1001,7 @@ static int rdt_default_ctrl_show(struct kernfs_open_file *of,
 }
 
 static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
-			     struct seq_file *seq, void *v)
+				 struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = of->kn->parent->priv;
 	struct rdt_resource *r = s->res;
@@ -1117,7 +1117,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 }
 
 static int rdt_min_bw_show(struct kernfs_open_file *of,
-			     struct seq_file *seq, void *v)
+			   struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = of->kn->parent->priv;
 	struct rdt_resource *r = s->res;
@@ -1152,7 +1152,7 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 }
 
 static int rdt_bw_gran_show(struct kernfs_open_file *of,
-			     struct seq_file *seq, void *v)
+			    struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = of->kn->parent->priv;
 	struct rdt_resource *r = s->res;
@@ -1162,7 +1162,7 @@ static int rdt_bw_gran_show(struct kernfs_open_file *of,
 }
 
 static int rdt_delay_linear_show(struct kernfs_open_file *of,
-			     struct seq_file *seq, void *v)
+				 struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = of->kn->parent->priv;
 	struct rdt_resource *r = s->res;
@@ -2017,7 +2017,6 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_closid_show,
 		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
 	},
-
 };
 
 static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
@@ -3420,7 +3419,6 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 			rdt_last_cmd_puts("Failed to initialize allocations\n");
 			goto out;
 		}
-
 	}
 
 	rdtgrp->mode = RDT_MODE_SHAREABLE;
-- 
2.34.1



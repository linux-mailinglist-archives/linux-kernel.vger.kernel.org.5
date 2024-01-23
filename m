Return-Path: <linux-kernel+bounces-34988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63521838A31
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130632877F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC3358AC1;
	Tue, 23 Jan 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="XS/Uh0iJ"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88505822D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001689; cv=none; b=qL7xfFavtSW/BBf2Bx6CTl9dP8Mp+Y82rcKaw7o7vKvU84aVE5VU+o5tvm3oQ4ENsSRNbLRYCDd69pPwUbTBbkgeQxCnL8NvGD+xw0rCuVneszmVb0+bjo2uRDmm44q8ZqIZeBuG3jk19j25gMnwG+a0Ds215erQNfaEmnk0h4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001689; c=relaxed/simple;
	bh=7C+tIDAexxZtGUr88BRAtpwjZhSDpQTHpgA/Tvvz8pE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uImfW+mF+ZRDRvcf0FE/lH2++JVRhv7YE+SlblCVNiJn9+CIml5ldsAOB+H3/Q0Juyo3+r0F9DZbXOTvHUwiDul5BALRnxM7k4xowa7a4E+gPBxXRr1ZahA7EaU7OhXi9j/vdZaS6AyBSsyICysQBLxTm75YSRmAS0gRfbVZmJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=XS/Uh0iJ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6de424cef01so1978236a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1706001687; x=1706606487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CJkjXjTnrwSkzf7VwgN4WhxQt30ievtg/kefs5USDPY=;
        b=XS/Uh0iJorVptS03/u+UFJN+KSIIFSp9eCUFBGIA37rnVHIqG4AWowTdmCfjc+9wi/
         t2dIoDL09B3yHW5ynzErHlDlVEw4Wy05CYoGCqUz3DYhfj9M5Jnyx25FOylgwEROim6m
         9EK8iJewUKCpd3LqLEJOgdCeQwD1WQFSdBRmpjlie8jr+ehTzS/a6698KN9jbYhxPb8V
         SISEJFKhm4XmSKCQrU8iWGiN2mhUSRor9bgtPyFYX3wTIcKVEDfx9zXcfVxEVuh9WP7n
         O8n67zzLZIJCytnUew/QJm8Oq/SNLn6M0wcAJT4LMoyDvDjs1Jh1VlxylswImmie39gA
         gkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706001687; x=1706606487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJkjXjTnrwSkzf7VwgN4WhxQt30ievtg/kefs5USDPY=;
        b=GlMfRSVjsthWASX7p8CPpr/1rOzzMrchmlJbyTUK0GF162Fqd/gIwyNa1TLIn7DHH3
         1nLAYz/lUYLacnhS3/DmeXNWb3lmeINkcwOFQlYaBax2bYm+F4v0RzDQr5JiF/Itf9ff
         wFDjximO/pPPbfTrrAZno/HM5U5kxYM2pT4uXltOnLqgwhGmpN5PSOvIURsANEBlOpG+
         DFxDD0jdoiCDfmHow1jLRIZ2PrCxGNIEaZF81sFVPAb9N2HtjbwrOBwraveXm5S+BvRv
         u3RisZEA0EVpc5oxxCmYWtRUYVH8tH285QlnEw3mTZwyqdygrZEQlYDvwRTiZDJMqNnf
         hZhQ==
X-Gm-Message-State: AOJu0YwVBF0vaxTQ1hpSxzE1APqlJdk2N8RQLCzs8hhhdcutOqRgAXmc
	lSa9CHcrqukrOiNvYfMtMdsXxEDaaUd9W5szp0NG3++heJB75sCUWLADAs0f8H8=
X-Google-Smtp-Source: AGHT+IFmXJgW/PKwd6NkpxU9tb92tOBTT2q/7+VmrKX6hyGA19UL+ZJ/YLynF2HbzhSFschVMFHZiw==
X-Received: by 2002:a05:6358:60cb:b0:176:2f2:1c5a with SMTP id i11-20020a05635860cb00b0017602f21c5amr4868638rwi.30.1706001686799;
        Tue, 23 Jan 2024 01:21:26 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id i15-20020aa787cf000000b006dbddea71e2sm3650707pfo.79.2024.01.23.01.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:21:26 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com
Cc: fenghua.yu@intel.com,
	babu.moger@amd.com,
	peternewman@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 2/3] x86/resctrl: Display the number of available RMIDs
Date: Tue, 23 Jan 2024 09:20:23 +0000
Message-Id: <20240123092024.1271882-2-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now we can know the total number of RMIDs from:

/sys/fs/resctrl/info/L3_MON/num_rmids

But for users, they don't know the number of available RMIDs. Especially
when llc_occupancy is enabled, though the monitor group is removed, its
rmid may not be freed.

Users may confused that though the number of control groups and monitor
groups is less than num_rmids, they still fail to create a new monitor
group, so add a RFTYPE_TOP_INFO file 'free_rmids' that tells users how
many free rmids are left.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 16 ++++++++++++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a4f1aa15f0a2..4b0392bd3a65 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -117,6 +117,7 @@ struct rmid_read {
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
+extern unsigned int free_rmids;
 extern struct list_head resctrl_schema_all;
 
 enum rdt_group_type {
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f136ac046851..edf8b6e1017c 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -51,6 +51,11 @@ static unsigned int rmid_limbo_count;
  */
 static struct rmid_entry	*rmid_ptrs;
 
+/*
+ * This is the number of available RMIDs.
+ */
+unsigned int free_rmids;
+
 /*
  * Global boolean for rdt_monitor which is true if any
  * resource monitoring is enabled.
@@ -299,6 +304,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 			if (!--entry->busy) {
 				rmid_limbo_count--;
 				list_add_tail(&entry->list, &rmid_free_lru);
+				free_rmids++;
 			}
 		}
 		crmid = nrmid + 1;
@@ -327,6 +333,7 @@ int alloc_rmid(void)
 	entry = list_first_entry(&rmid_free_lru,
 				 struct rmid_entry, list);
 	list_del(&entry->list);
+	free_rmids--;
 
 	return entry->rmid;
 }
@@ -362,8 +369,10 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 
 	if (entry->busy)
 		rmid_limbo_count++;
-	else
+	else {
 		list_add_tail(&entry->list, &rmid_free_lru);
+		free_rmids++;
+	}
 }
 
 void free_rmid(u32 rmid)
@@ -379,8 +388,10 @@ void free_rmid(u32 rmid)
 
 	if (is_llc_occupancy_enabled())
 		add_rmid_to_limbo(entry);
-	else
+	else {
 		list_add_tail(&entry->list, &rmid_free_lru);
+		free_rmids++;
+	}
 }
 
 static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 rmid,
@@ -737,6 +748,7 @@ static int dom_data_init(struct rdt_resource *r)
 	 */
 	entry = __rmid_entry(0);
 	list_del(&entry->list);
+	free_rmids = nr_rmids - 1;
 
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 577d870ac45f..1eac0ca97b81 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -925,6 +925,15 @@ static int rdt_free_closids_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdt_free_rmids_show(struct kernfs_open_file *of,
+			       struct seq_file *seq, void *v)
+{
+	mutex_lock(&rdtgroup_mutex);
+	seq_printf(seq, "%d\n", free_rmids);
+	mutex_unlock(&rdtgroup_mutex);
+	return 0;
+}
+
 static int rdt_num_closids_show(struct kernfs_open_file *of,
 				struct seq_file *seq, void *v)
 {
@@ -1775,6 +1784,13 @@ static struct rftype res_common_files[] = {
 		.seq_show       = rdt_free_closids_show,
 		.fflags         = RFTYPE_TOP_INFO,
 	},
+	{
+		.name           = "free_rmids",
+		.mode           = 0444,
+		.kf_ops         = &rdtgroup_kf_single_ops,
+		.seq_show       = rdt_free_rmids_show,
+		.fflags         = RFTYPE_TOP_INFO,
+	},
 	{
 		.name		= "num_closids",
 		.mode		= 0444,
-- 
2.25.1



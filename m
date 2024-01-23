Return-Path: <linux-kernel+bounces-34989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1419E838A32
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B919228B087
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDF95A104;
	Tue, 23 Jan 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="cBRGXvP2"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5045A0E6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001692; cv=none; b=MRiu8OHY4AjyYc4gajZfvTahpSlqWsMFPxfv1IUTvd7OcXoWVvlBZLpVlKfIw5yItqX6NTJrSLkTAw9h2xgqHsL8UuzTSu3GL4WtXiyMw0WTCFpteTzxlX3WDJtzJkUHFKMxWIUlKHhSgwAcEovt5AFzNVO5DhD0T29qG3R2Qnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001692; c=relaxed/simple;
	bh=kdjTVDnt3T5rMo3cn2OSR3tL1n1pa7btbCx55IWmczM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U9IUWW8JY5kCb42r2BfwpZYvlkdthl+qBtovmy6RMSkIehCAc4PjDDOatsoqYNXGF4l65jawS8Pe7W5OnkGRHxGqknmTmaXEIHf3ncNgbeeWoqQ0e9tR5eycX/q2oKsTt9K4lF8td5+EzwXUPg404AHMHDK+8ZXG5SR9yaLCrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=cBRGXvP2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6dd6c9cb6a8so254273b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1706001690; x=1706606490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8mS8d8vBcR03ufqO/xF4nBQTf7/wmjAomjX8LcNRSg=;
        b=cBRGXvP2X0oPEjeR6Psmi0aaMHXROkwDez6uRSjNTkxdN3P7pR4KrmsJuThkflFXw4
         sdOwUp31IAKrMO82MxiYeqFCcV2AOGSh7xm/XM7jMc75d2B67IW+Asr5zwykuZh7mwtj
         EsB8En1Tkh+tJfHpyHIyltItXD0EDrcVnDDGVM8q62/nGddISw0ZvD8bYaTlvSl1IbN3
         6YwX8RDWLN9oax6nKzrraqjFMOFtgIcv/Kl/cHFuyleFdC3NTQiWMCJf3p0ANwsFFGPM
         ENCG8O4a1HGPPJvkKG5JYPXpaleVqlivOL6L2T9k/3TczseX7MyEt6hV/ugGPgD3WW7A
         R4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706001690; x=1706606490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8mS8d8vBcR03ufqO/xF4nBQTf7/wmjAomjX8LcNRSg=;
        b=pRAr1omnYxLmxrrv1EKT6lbk0louYV3xbALnZgWE/s3gfRXVUKuCh1JVvtnxxR6Ti2
         8P1Ik3C/3jGAS+MJL4cuT52tAP0RijM9MIX4S2X6s6k4bGz2lotxHmpElRtMhH94cjdi
         GFCMLN9z4NY/3C0/+ENHH5nvbOcZbEEWa+xzX/6MUNHZhA1Scp+rzKP8WCHRWl/GJQDG
         b1heg85Op+kk+bb8mzA8LwkO6bN36iseJlj7zyf+o5RfVXjrxMPAseo19LQEibm1xkmK
         I/CSxFXrr71Tupo51kaUhOa4IIuJ+ZzDzCt8OYYd1I6eIpShFhE6v3jwcppv82kzmmJu
         eTIQ==
X-Gm-Message-State: AOJu0Ywg0japA6CqQ01YLEdbrEmzpeYRk86l5/dBbVzBcs44dLoxGVOc
	gbJt+jT7/OOAony6N6qMxmUUZ/9Kpt98kRaRwOWfxGbsu0Y6xuLyos6FHPXX1Tg=
X-Google-Smtp-Source: AGHT+IHh+0gCqdb/8AiGvV8g7049ZswTDaJnuK+mBLOXgBUgk1+DALomPUjnRkGGk5a+MSeApa2TYg==
X-Received: by 2002:a05:6a00:2d95:b0:6d9:ac71:3b52 with SMTP id fb21-20020a056a002d9500b006d9ac713b52mr3796848pfb.54.1706001690073;
        Tue, 23 Jan 2024 01:21:30 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id i15-20020aa787cf000000b006dbddea71e2sm3650707pfo.79.2024.01.23.01.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:21:29 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com
Cc: fenghua.yu@intel.com,
	babu.moger@amd.com,
	peternewman@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 3/3] x86/resctrl: Display cache occupancy of busy RMIDs
Date: Tue, 23 Jan 2024 09:20:24 +0000
Message-Id: <20240123092024.1271882-3-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If llc_occupany is enabled, the RMID may not be freed immediately unless
its llc_occupany is less than the resctrl_rmid_realloc_threshold.

In our production environment, those unused RMIDs get stuck in the limbo
list forever because their llc_occupancy are larger than the threshold.
After turning it up , we can successfully free unused RMIDs and create
new monitor groups. In order to accquire the llc_occupancy of RMIDs in
each rdt domain, we use perf tool to track and filter the log manually.

It's not efficient enough. Therefore, we can add a RFTYPE_TOP_INFO file
'busy_rmids_info' that tells users the llc_occupancy of busy RMIDs. It
can also help to guide users how much the resctrl_rmid_realloc_threshold
should be.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 70 ++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1eac0ca97b81..88dadb87f4e1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -32,6 +32,12 @@
 #include <asm/resctrl.h>
 #include "internal.h"
 
+struct busy_rmids_info {
+	struct rdt_resource *r;
+	struct rdt_domain *d;
+	struct seq_file *seq;
+};
+
 DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
 DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
@@ -934,6 +940,63 @@ static int rdt_free_rmids_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+void rdt_domain_busy_rmids_show(void *info)
+{
+
+        struct rdt_resource *r;
+        struct rdt_domain *d;
+        struct seq_file *seq;
+        struct busy_rmids_info *rmids_info = info;
+        u32 crmid = 1, nrmid;
+        u64 val;
+        int ret;
+
+        r = rmids_info->r;
+        d = rmids_info->d;
+        seq = rmids_info->seq;
+
+        seq_printf(seq, "domain-%d busy rmids.\n", d->id);
+
+        for (;;) {
+                nrmid = find_next_bit(d->rmid_busy_llc, r->num_rmid, crmid);
+                if (nrmid >= r->num_rmid)
+                        break;
+
+                ret = resctrl_arch_rmid_read(r, d, nrmid, QOS_L3_OCCUP_EVENT_ID, &val);
+                switch (ret) {
+                case -EIO:
+                        seq_printf(seq, "I/O Error\n");
+                        return;
+                case -EINVAL:
+                        seq_printf(seq, "Invalid Argument\n");
+                        return;
+                default:
+                        seq_printf(seq, "rmid:%d llc_occupancy:%llu\n", nrmid, val);
+                }
+                crmid = nrmid + 1;
+        }
+}
+
+static int rdt_busy_rmids_info_show(struct kernfs_open_file *of,
+                                    struct seq_file *seq, void *v)
+{
+
+        struct rdt_domain *d;
+        struct rdt_resource *r;
+        struct busy_rmids_info info;
+
+        mutex_lock(&rdtgroup_mutex);
+        r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+        info.r = r;
+        info.seq = seq;
+        list_for_each_entry(d, &r->domains, list) {
+                info.d = d;
+                smp_call_function_any(&d->cpu_mask, rdt_domain_busy_rmids_show, &info, 1);
+        }
+        mutex_unlock(&rdtgroup_mutex);
+        return 0;
+}
+
 static int rdt_num_closids_show(struct kernfs_open_file *of,
 				struct seq_file *seq, void *v)
 {
@@ -1791,6 +1854,13 @@ static struct rftype res_common_files[] = {
 		.seq_show       = rdt_free_rmids_show,
 		.fflags         = RFTYPE_TOP_INFO,
 	},
+	{
+		.name           = "busy_rmids_info",
+		.mode           = 0444,
+		.kf_ops         = &rdtgroup_kf_single_ops,
+		.seq_show       = rdt_busy_rmids_info_show,
+		.fflags         = RFTYPE_TOP_INFO,
+	},
 	{
 		.name		= "num_closids",
 		.mode		= 0444,
-- 
2.25.1



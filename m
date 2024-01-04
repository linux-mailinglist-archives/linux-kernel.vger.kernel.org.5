Return-Path: <linux-kernel+bounces-16953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B039B824672
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D351C2211A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC86025571;
	Thu,  4 Jan 2024 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4wBZuMW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A22556B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bb9d54575cso473603b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 08:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704386331; x=1704991131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j7PA7FAAH4Q8xvO+xLgGu0hJdJJaWl3qAfedkY2o//E=;
        b=U4wBZuMWMwqPX7Dk4xuTCw1dbmfw5vRHMedaI+olLsZ5Hr1+n6BVsjI2EWzAg6B/+u
         w0mdGpzgm8iIV3OhbNMZA9ayTCwnoFxKmhLbzuSFmasjXRDo9UhMI1gHdqyvJ1PwjO1S
         4RcHmRaD/4uf/Nh4+lx3hTAs3OlS3vT0JByLt2rIjYOLHEdz7s3PjL2GRB9qAlGeLoUF
         tdK7sW8zXWhoWISVjBaJ1/oX0a4RuNsRhmxe/PP+v357WEdhCD2fsy++irI9KnfF2hca
         Iue/zp5/QwvjT0oSp+Zi28iP1pr7Y+MquKNbpkxlttwm7wH3LcqJj9CGOtOM1NLZu+HY
         8B+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704386331; x=1704991131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7PA7FAAH4Q8xvO+xLgGu0hJdJJaWl3qAfedkY2o//E=;
        b=DrZ8q72qFKbq+XJA2fuoRdBmRvZiAN9bzD9gdUjQxNhFpxgJY794PnnJUWRxIRv0WZ
         X5vBeTdZL5XDlrp+edWNiIkbaKGxH5rRaPKChAuwQjLxz/UalcZIxXn6t/0zGT8GSI1M
         60AlS3MskaaoB25j7Ef8+XXD/Ye0Jphmk+SWSzBSp6Iup3FT0ly0uHBpNBUWq1Cp9PI8
         +yh/LAC/cNiiJiLeo+r/SFvtUf7RtsEU4iylVfTczwVo8aGXThoyu869yi2KtG2P6lqP
         qf1WGUAhlqngI8B7MpXnI0JT/1Xp6xcKhW6kwh/n3LHtbhK20KP2Qu8mVpn1jpWlVKcT
         sBnA==
X-Gm-Message-State: AOJu0YxR/ZOrbV3gebOzDV5d3lisI9ExtJsF965XGzyHaffWR11an9GH
	7rDPS69ff4we22HRiJRNgm8NU+lzDJ4=
X-Google-Smtp-Source: AGHT+IFvm5Vaw8ZvXn8hmLaIFW8pSESAVF6qOvMg/t+fd/ZYYfmFOb72qe2rx5auzyLBR+pwjMcGRA==
X-Received: by 2002:a05:6870:cb41:b0:204:42cc:e144 with SMTP id oz1-20020a056870cb4100b0020442cce144mr987518oab.26.1704386331528;
        Thu, 04 Jan 2024 08:38:51 -0800 (PST)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id sf6-20020a056871230600b00203fa5d55fbsm6489915oab.34.2024.01.04.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 08:38:51 -0800 (PST)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH] nvme_core: scan namespaces asynchronously
Date: Thu,  4 Jan 2024 10:38:26 -0600
Message-Id: <20240104163826.10561-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently NVME namespaces are scanned serially, so it can take a long time
for all of a controller's namespaces to become available, especially with a
slower (fabrics) interface with large number (~1000) of namespaces.

Use async function calls to make namespace scanning happen in parallel,
and add a (boolean) module parameter "async_ns_scan" to enable this.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 60f14019f981..aeda60469872 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  */
 
+#include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-integrity.h>
@@ -88,6 +89,10 @@ module_param(apst_secondary_latency_tol_us, ulong, 0644);
 MODULE_PARM_DESC(apst_secondary_latency_tol_us,
 	"secondary APST latency tolerance in us");
 
+static bool async_ns_scan;
+module_param(async_ns_scan, bool, 0644);
+MODULE_PARM_DESC(async_ns_scan, "allow namespaces to be scanned asynchronously");
+
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -3780,12 +3785,38 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 		nvme_ns_remove(ns);
 }
 
-static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+/*
+ * struct nvme_scan_state - keeps track of controller & NSIDs to scan
+ * @ctrl:	Controller on which namespaces are being scanned
+ * @count:	Next NSID to scan (for sequential scan), or
+ *		Index of next NSID to scan in ns_list (for list scan)
+ * @ns_list:	pointer to list of NSIDs to scan (NULL if sequential scan)
+ */
+struct nvme_scan_state {
+	struct nvme_ctrl *ctrl;
+	atomic_t count;
+	__le32 *ns_list;
+};
+
+static void nvme_scan_ns(void *data, async_cookie_t cookie)
 {
-	struct nvme_ns_info info = { .nsid = nsid };
+	struct nvme_ns_info info = {};
+	struct nvme_scan_state *scan_state;
+	struct nvme_ctrl *ctrl;
+	u32 nsid;
 	struct nvme_ns *ns;
 	int ret;
 
+	scan_state = data;
+	ctrl = scan_state->ctrl;
+	nsid = (u32)atomic_fetch_add(1, &scan_state->count);
+	/*
+	 * get NSID from list (if scanning from a list, not sequentially)
+	 */
+	if (scan_state->ns_list)
+		nsid = le32_to_cpu(scan_state->ns_list[nsid]);
+
+	info.nsid = nsid;
 	if (nvme_identify_ns_descs(ctrl, &info))
 		return;
 
@@ -3849,11 +3880,15 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 	__le32 *ns_list;
 	u32 prev = 0;
 	int ret = 0, i;
+	ASYNC_DOMAIN(domain);
+	struct nvme_scan_state scan_state;
 
 	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
 	if (!ns_list)
 		return -ENOMEM;
 
+	scan_state.ctrl = ctrl;
+	scan_state.ns_list = ns_list;
 	for (;;) {
 		struct nvme_command cmd = {
 			.identify.opcode	= nvme_admin_identify,
@@ -3869,19 +3904,30 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 			goto free;
 		}
 
+		/*
+		 * scan list starting at list offset 0
+		 */
+		atomic_set(&scan_state.count, 0);
 		for (i = 0; i < nr_entries; i++) {
 			u32 nsid = le32_to_cpu(ns_list[i]);
 
 			if (!nsid)	/* end of the list? */
 				goto out;
-			nvme_scan_ns(ctrl, nsid);
+
+			if (async_ns_scan)
+				async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
+			else
+				nvme_scan_ns(&scan_state, 0);
+
 			while (++prev < nsid)
 				nvme_ns_remove_by_nsid(ctrl, prev);
 		}
+		async_synchronize_full_domain(&domain);
 	}
  out:
 	nvme_remove_invalid_namespaces(ctrl, prev);
  free:
+	async_synchronize_full_domain(&domain);
 	kfree(ns_list);
 	return ret;
 }
@@ -3890,14 +3936,26 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl)
 {
 	struct nvme_id_ctrl *id;
 	u32 nn, i;
+	ASYNC_DOMAIN(domain);
+	struct nvme_scan_state scan_state;
 
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
 	nn = le32_to_cpu(id->nn);
 	kfree(id);
 
+	scan_state.ctrl = ctrl;
+	/*
+	 * scan sequentially starting at NSID 1
+	 */
+	atomic_set(&scan_state.count, 1);
+	scan_state.ns_list = NULL;
 	for (i = 1; i <= nn; i++)
-		nvme_scan_ns(ctrl, i);
+		if (async_ns_scan)
+			async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
+		else
+			nvme_scan_ns(&scan_state, 0);
+	async_synchronize_full_domain(&domain);
 
 	nvme_remove_invalid_namespaces(ctrl, nn);
 }
-- 
2.39.3



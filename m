Return-Path: <linux-kernel+bounces-95575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D064874FA6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D645D1F211E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D4112BEA9;
	Thu,  7 Mar 2024 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b="2+965/Aq"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B212BEB1
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817003; cv=none; b=nYFn1maBueiItmVMtt3VgiHix3u+y8tZvhXR9B9ud0l4yma363CLi36Y+x2jvDLJp3V7qYqRwxpwHXFH6PFldwYSEW3k8UZpUF0koMILGVOMrGqfpiIIe0ARaUymfWdw8AFomNcTQSVosAt8GBs/yauHi3NhHrgpK9DBs4e4wTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817003; c=relaxed/simple;
	bh=By3cGhdC6Ek63DjTTZSwLllLsXv/77TrQJZbdEEzLYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8ncy0vzI8ngtUIiC/ad5I6V3MXjs6PBGq+0epZC+n6YmbjaaAtuqi8hqgDr6n5CiEdHMcyqmUz0i2KU5Y8qk8ponegGrq9Fxecu6f8b+9ZW5MIbaOk49FcpRZRvrGcvQchUETjpeTVxV+8tV0puFUgUDQ7lc3i8ippMjfNCGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com; dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b=2+965/Aq; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e617b39877so724217b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 05:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1709817000; x=1710421800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mnPsGhWcK7NFH4mKOZ23/7kGcLmNyPxLIO+SQUxEhbo=;
        b=2+965/AqUB4oWcJKZqcWXa/u2Nm6FAC2g7xJkxrNtK1GGjelm7tF8Gx2YprUCfxl0o
         CUqrVJEj4HzvrBzOgQEATrXxLs9h15uEKsgzgRVlxtWSMisO+y56i/Ea05KeGv1SOwE3
         DUOOJrq0f1y9m3Lt1+6o7GRt17l0RSf6Yoa4Z5vVeS/XHXkKjY8/dWWHKoADDd3mxwDT
         4y1wSun9JIwNB3UCWxSxRatjDy5RASfDrtf/1LN5kctJIzes0BKuDsbyQoPn94yas1WY
         Oj5+ughjQSMqSvuq8gfjO5lpoB0iqUFOey/LeWgsnycuULz+Z3h55DWuQk2gzN74KcL0
         S72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709817000; x=1710421800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnPsGhWcK7NFH4mKOZ23/7kGcLmNyPxLIO+SQUxEhbo=;
        b=Tnhh0LGKuWY4Yx7OJVP6Y8Wvnc92Lq+pE3IeFgcsb0ZDoxUkdXCyBpTUH3PDoVwAEO
         /i34MerFUxhnZ+OZ9IQt8D+TJ/TuANXa5JEmNObhyi2c9XiEQ9BXAi3LV5BHYOFkgYzH
         Rhz1vg1vGSDKyyDVU1GKlDlT3PWiauPIRNJSxRavU9fsky9Q9sqjbcHYP5R8g3KzenWh
         fFGFfgArQDsM9pw1o1cT03lbq4Dq0I86mhASqyepkQ/elQtwsTcfjoSpt+0GOozDAqIL
         IW8wrpoEuHkh1kFjFPiMkwBBoexcitY+D9VJBYC7uKGmOLdIrxXcijtwqX6aAR1yhvJs
         vuOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvTlgKnDob+zVPKMmnMqqHDu7SH6zJKj4hjlIS/+UiJI02yrLT3yPpN5GCeyprVtYzEP8CrzXNZeAihVqWbBUn0FE8+dbNO+qFzy8f
X-Gm-Message-State: AOJu0Yw00H+DI71gCS0vtOnqd/OiFFK+EZ1DnIFvimach98dW3kfp5Q9
	ceCYfr0Quw1PxdSiaA7eWYuc/RAvxlAu7dZED8UiloZ2v2M1nWAVJCRoa2uLFRM=
X-Google-Smtp-Source: AGHT+IH5g2LoGNMlP35/AQokX1c+JtQ0Hu5i0oGBdjI07gwUW7p/2+zzP0ltxVfEdLjj0jrMQx6emA==
X-Received: by 2002:a05:6a20:3d08:b0:1a1:6faf:96b2 with SMTP id y8-20020a056a203d0800b001a16faf96b2mr2060628pzi.47.1709817000246;
        Thu, 07 Mar 2024 05:10:00 -0800 (PST)
Received: from xuyingfeng-OptiPlex-7080.mioffice.cn ([2408:8607:1b00:8:b27b:25ff:fe2a:187f])
        by smtp.gmail.com with ESMTPSA id z17-20020aa79911000000b006e64ee44f51sm2882842pff.71.2024.03.07.05.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 05:09:59 -0800 (PST)
From: Rumeng Wang <wangrumeng@xiaomi.corp-partner.google.com>
To: djakov@kernel.org
Cc: fengqi@xiaomi.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	tkjos@google.com,
	wangrumeng@xiaomi.corp-partner.google.com,
	xuyingfeng@xiaomi.com,
	liuzhengliang@xiaomi.com
Subject: [PATCH] interconnect:Replace mutex with rt_mutex for icc_lock
Date: Thu,  7 Mar 2024 21:09:44 +0800
Message-ID: <20240307130944.10682-1-wangrumeng@xiaomi.corp-partner.google.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: wangrumeng <wangrumeng@xiaomi.corp-partner.google.com>

Replace existing mutex with rt_mutex to prevent priority inversion
between clients, which can cause unacceptable delays in some cases.

Here are the reasons for the modification:
We execute test scripts on Xiaomi phones. Each test will have 5 rounds, and each round of testing will involve continuously entering and exiting 30 applications. Every time an application enters or exits, it will grab a trace to count the frame loss situation.
We tested it four times using the Google solution, which is icc_set_bw use mutex.
Every time the test is conducted, there will be frame loss caused by the icc_set_bw D state issue.
The recurrence probability of the iccset_bw D state problem is 5/600
We tested it three times using the Xiaomi solution, which is icc_set_bw use rt_mutex.
Every time there is a test, even if there is a frame loss, it is not caused by the icc_set_bw D state issue.
The recurrence probability of the iccset_bw D state problem is 0/450
Of course, the above tests still have their limitations, as they only tested the application in and out scenarios, without testing any other scenarios. However, based on the current results, modifying mutex to rt_mutex has a significant optimization effect on frame loss.

Signed-off-by: wangrumeng <wangrumeng@xiaomi.corp-partner.google.com>
---
 drivers/interconnect/core.c | 86 ++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 49 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 50bac2d79d9b..1fe0ee4b5ecc 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -13,7 +13,7 @@
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
 #include <linux/list.h>
-#include <linux/mutex.h>
+#include <linux/rt_mutex.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/overflow.h>
@@ -27,8 +27,7 @@ static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_providers);
 static int providers_count;
 static bool synced_state;
-static DEFINE_MUTEX(icc_lock);
-static DEFINE_MUTEX(icc_bw_lock);
+static DEFINE_RT_MUTEX(icc_lock);
 static struct dentry *icc_debugfs_dir;
 
 static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
@@ -47,7 +46,7 @@ static int icc_summary_show(struct seq_file *s, void *data)
 	seq_puts(s, " node                                  tag          avg         peak\n");
 	seq_puts(s, "--------------------------------------------------------------------\n");
 
-	mutex_lock(&icc_lock);
+	rt_mutex_lock(&icc_lock);
 
 	list_for_each_entry(provider, &icc_providers, provider_list) {
 		struct icc_node *n;
@@ -73,7 +72,7 @@ static int icc_summary_show(struct seq_file *s, void *data)
 		}
 	}
 
-	mutex_unlock(&icc_lock);
+	rt_mutex_unlock(&icc_lock);
 
 	return 0;
 }
@@ -104,7 +103,7 @@ static int icc_graph_show(struct seq_file *s, void *data)
 	int i;
 
 	seq_puts(s, "digraph {\n\trankdir = LR\n\tnode [shape = record]\n");
-	mutex_lock(&icc_lock);
+	rt_mutex_lock(&icc_lock);
 
 	/* draw providers as cluster subgraphs */
 	cluster_index = 0;
@@ -136,7 +135,7 @@ static int icc_graph_show(struct seq_file *s, void *data)
 					icc_graph_show_link(s, 1, n,
 							    n->links[i]);
 
-	mutex_unlock(&icc_lock);
+	rt_mutex_unlock(&icc_lock);
 	seq_puts(s, "}");
 
 	return 0;
@@ -377,7 +376,7 @@ struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
 	if (!spec)
 		return ERR_PTR(-EINVAL);
 
-	mutex_lock(&icc_lock);
+	rt_mutex_lock(&icc_lock);
 	list_for_each_entry(provider, &icc_providers, provider_list) {
 		if (provider->dev->of_node == spec->np) {
 			if (provider->xlate_extended) {
@@ -393,7 +392,7 @@ struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
 			}
 		}
 	}
-	mutex_unlock(&icc_lock);
+	rt_mutex_unlock(&icc_lock);
 
 	if (!node)
 		return ERR_PTR(-EINVAL);
@@ -508,9 +507,9 @@ struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
 		return ERR_CAST(dst_data);
 	}
 
-	mutex_lock(&icc_lock);
+	rt_mutex_lock(&icc_lock);
 	path = path_find(dev, src_data->node, dst_data->node);
-	mutex_unlock(&icc_lock);
+	rt_mutex_unlock(&icc_lock);
 	if (IS_ERR(path)) {
 		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
 		goto free_icc_data;
@@ -598,7 +597,7 @@ struct icc_path *icc_get(struct device *dev, const char *src, const char *dst)
 	struct icc_node *src_node, *dst_node;
 	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
 
-	mutex_lock(&icc_lock);
+	rt_mutex_lock(&icc_lock);
 
 	src_node = node_find_by_name(src);
 	if (!src_node) {
@@ -624,7 +623,7 @@ struct icc_path *icc_get(struct device *dev, const char *src, const char *dst)
 		path = ERR_PTR(-ENOMEM);
 	}
 out:
-	mutex_unlock(&icc_lock);
+	rt_mutex_unlock(&icc_lock);
 	return path;
 }
 
@@ -643,12 +642,12 @@ void icc_set_tag(struct icc_path *path, u32 tag)
 	if (!path)
 		return;
 
-	mutex_lock(&icc_lock);
+	rt_mutex_lock(&icc_lock);
 
 	for (i = 0; i < path->num_nodes; i++)
 		path->reqs[i].tag = tag;
 
-	mutex_unlock(&icc_lock);
+	rt_mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_set_tag);
 
@@ -698,7 +697,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
 		return -EINVAL;
 
-	mutex_lock(&icc_bw_lock);
+	rt_mutex_lock(&icc_lock);
 
 	old_avg = path->reqs[0].avg_bw;
 	old_peak = path->reqs[0].peak_bw;
@@ -730,7 +729,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 		apply_constraints(path);
 	}
 
-	mutex_unlock(&icc_bw_lock);
+	rt_mutex_unlock(&icc_lock);
 
 	trace_icc_set_bw_end(path, ret);
 
@@ -748,12 +747,12 @@ static int __icc_enable(struct icc_path *path, bool enable)
 	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
 		return -EINVAL;
 
-	mutex_lock(&icc_lock);
+	rt_mutex_lock(&icc_lock);
 
 	for (i = 0; i < path->num_nodes; i++)
 		path->reqs[i].enabled = enable;
 
-	mutex_unlock(&icc_lock);
+	rt_mutex_unlock(&icc_lock);
 
 	return icc_set_bw(path, path->reqs[0].avg_bw,
 			  path->reqs[0].peak_bw);
@@ -791,14 +790,14 @@ void icc_put(struct icc_path *path)
 	if (ret)
 		pr_err("%s: error (%d)\n", __func__, ret);
 
-	mutex_lock(&icc_lock);
+	rt_mutex_lock(&icc_lock);
 	for (i = 0; i < path->num_nodes; i++) {
 		node = path->reqs[i].node;
 		hlist_del(&path->reqs[i].req_node);
 		if (!WARN_ON(!node->provider->users))
 			node->provider->users--;
 	}
-	mutex_unlock(&icc_lock);
+	rt_mutex_unlock(&icc_lock);
 
 	kfree_const(path->name);
 	kfree(path);
@@ -840,11 +839,11 @@ struct icc_node *icc_node_create(int id)
 {
 	struct icc_node *node;
 
-	mutex_lock(&icc_lock);
+	rt_mutex_lock(&icc_lock);
 
 	node = icc_node_create_nolock(id);
 
-	mutex_unlock(&icc_lock);
+	rt_mutex_unlock(&icc_lock);
 
 	return node;
 }
@@ -858,7 +857,7 @@ void icc_node_destroy(int id)
 {
 	struct icc_node *node;
 
-	mutex_lock(&icc_lock);
+	rt_mutex_lock(&icc_lock);
 
 	node = node_find(id);
 	if (node) {
@@ -866,7 +865,7 @@ void icc_node_destroy(int id)
 		WARN_ON(!hlist_empty(&node->req_list));
 	}
 
-	mutex_unlock(&icc_lock);
+	rt_mutex_unlock(&icc_lock);
 
 	if (!node)
 		return;
@@ -898,7 +897,7 @@ int icc_link_create(struct icc_node *node, const int dst_id)
 	if (!node->provider)
 		return -EINVAL;
 
-	mutex_lock(&icc_lock);
+	rt_mutex_lock(&icc_lock);
 
 	dst = node_find(dst_id);
 	if (!dst) {
@@ -922,7 +921,7 @@ int icc_link_create(struct icc_node *node, const int dst_id)
 	node->links[node->num_links++] = dst;
 
 out:
-	mutex_unlock(&icc_lock);
+	rt_mutex_unlock(&icc_lock);
 
 	return ret;
 }
@@ -938,8 +937,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	if (WARN_ON(node->provider))
 		return;
 
-	mutex_lock(&icc_lock);
-	mutex_lock(&icc_bw_lock);
+	rt_mutex_lock(&icc_lock);
 
 	node->provider = provider;
 	list_add_tail(&node->node_list, &provider->nodes);
@@ -968,8 +966,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->avg_bw = 0;
 	node->peak_bw = 0;
 
-	mutex_unlock(&icc_bw_lock);
-	mutex_unlock(&icc_lock);
+	rt_mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_node_add);
 
@@ -979,11 +976,11 @@ EXPORT_SYMBOL_GPL(icc_node_add);
  */
 void icc_node_del(struct icc_node *node)
 {
-	mutex_lock(&icc_lock);
+	rt_mutex_lock(&icc_lock);
 
 	list_del(&node->node_list);
 
-	mutex_unlock(&icc_lock);
+	rt_mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_node_del);
 
@@ -1034,9 +1031,9 @@ int icc_provider_register(struct icc_provider *provider)
 	if (WARN_ON(!provider->xlate && !provider->xlate_extended))
 		return -EINVAL;
 
-	mutex_lock(&icc_lock);
+	rt_mutex_lock(&icc_lock);
 	list_add_tail(&provider->provider_list, &icc_providers);
-	mutex_unlock(&icc_lock);
+	rt_mutex_unlock(&icc_lock);
 
 	dev_dbg(provider->dev, "interconnect provider registered\n");
 
@@ -1050,11 +1047,11 @@ EXPORT_SYMBOL_GPL(icc_provider_register);
  */
 void icc_provider_deregister(struct icc_provider *provider)
 {
-	mutex_lock(&icc_lock);
+	rt_mutex_lock(&icc_lock);
 	WARN_ON(provider->users);
 
 	list_del(&provider->provider_list);
-	mutex_unlock(&icc_lock);
+	rt_mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_provider_deregister);
 
@@ -1093,8 +1090,7 @@ void icc_sync_state(struct device *dev)
 	if (count < providers_count)
 		return;
 
-	mutex_lock(&icc_lock);
-	mutex_lock(&icc_bw_lock);
+	rt_mutex_lock(&icc_lock);
 	synced_state = true;
 	list_for_each_entry(p, &icc_providers, provider_list) {
 		dev_dbg(p->dev, "interconnect provider is in synced state\n");
@@ -1107,21 +1103,13 @@ void icc_sync_state(struct device *dev)
 			}
 		}
 	}
-	mutex_unlock(&icc_bw_lock);
-	mutex_unlock(&icc_lock);
+	rt_mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_sync_state);
 
 static int __init icc_init(void)
 {
-	struct device_node *root;
-
-	/* Teach lockdep about lock ordering wrt. shrinker: */
-	fs_reclaim_acquire(GFP_KERNEL);
-	might_lock(&icc_bw_lock);
-	fs_reclaim_release(GFP_KERNEL);
-
-	root = of_find_node_by_path("/");
+	struct device_node *root = of_find_node_by_path("/");
 
 	providers_count = of_count_icc_providers(root);
 	of_node_put(root);
-- 
2.43.2



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620F67DC3A9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbjJaAic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbjJaAib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:38:31 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8708EE8;
        Mon, 30 Oct 2023 17:38:28 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 3f1490d57ef6-da37522a363so299222276.0;
        Mon, 30 Oct 2023 17:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698712707; x=1699317507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqzp8UEwRJTgLaeQpU+LsOI00hLnye5kfN/uXwQ/cgQ=;
        b=buoQxiuoxLkLZDdg+P5uXTOeWrFdeKbObps0zJU3pCzxeMdfms9Ye/6KAfJbGfofSo
         2cX4kYQJ2A6It7oy6GvEDqvtpFOygJ/QLy0IAiRqNm9jBBgyVfGb0qbFEdauo32W8KCI
         K5l5vJA1hXnrgLpJyVFS8peuqXMC/Y3c4cEKH65v2ns+1NRNbxn/Scy4rN00VO8XYwSZ
         whnWw7bNNdrqRAyG0TAKcE/3ury1nXKrzRwMABEHpiV1XRKyLXRZ0UN5eF/2QX/Fw52g
         THyebKx6x3cte8fOdYxjbuRjrgoD401a2j5iQY4ArkNkSIBc2XpqXaEbpU0Vj8sZ4dDh
         HsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698712707; x=1699317507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqzp8UEwRJTgLaeQpU+LsOI00hLnye5kfN/uXwQ/cgQ=;
        b=l0z61g+TSn7yWD9vPZPPprjRAIfdG5dcNg12O5gztxgi+4HqTYPpKdcA5oXcpb/R6y
         5FXRuWFti/uXchnOK0uJbRvAcS+O+t85dou0Ju4R+uSXrC9aVftr7QAzGQkllxym+Dq4
         BytsgJfrKuMKDaADuCa/iayScBVguNzCCHkfGNXngftgn9ubKk+ZoFbbuY2NWEeQYGVm
         DrD+WYRtPFgs5aDSoEPzTPF3bWFXPDQ06oudnthorkTo7Q+gQgQswCO5+e4IYFfR9TGJ
         96uNDIrpTD/xsGzBnbeoDEZMLLhjzhevI0NxA6OjIKpara2BybtL3bsBv5moCw2VDjx2
         CkaA==
X-Gm-Message-State: AOJu0YxO23RCB2yqUS5hkoFJwV0m1OV9AgwdejMqcU1rjQoWI4lv1io4
        Irx1W+X0ZBCW6MWclU6Sc6hXDaMv7jIA
X-Google-Smtp-Source: AGHT+IFKcy1sU3dFigUiCwURyOPeE7JfdrOwJH3YBwiTqPhB7WcZjjcQyS/NuIc9Ms5Q8SWg+UlvIA==
X-Received: by 2002:a25:d1c5:0:b0:d9a:401d:f5da with SMTP id i188-20020a25d1c5000000b00d9a401df5damr11555099ybg.51.1698712707500;
        Mon, 30 Oct 2023 17:38:27 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id b19-20020a25ae93000000b00da086d6921fsm182750ybj.50.2023.10.30.17.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 17:38:27 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, weixugc@google.com, apopple@nvidia.com,
        hannes@cmpxchg.org, tim.c.chen@intel.com, dave.hansen@intel.com,
        mhocko@kernel.org, shy828301@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, Gregory Price <gregory.price@memverge.com>,
        Ravi Shankar <ravis.opensrc@micron.com>
Subject: [RFC PATCH v3 3/4] node: add interleave weights to node accessor
Date:   Mon, 30 Oct 2023 20:38:09 -0400
Message-Id: <20231031003810.4532-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231031003810.4532-1-gregory.price@memverge.com>
References: <20231031003810.4532-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a configurable interleave weight to the node for each possible
accessor. The intent of this weight is to enable set_mempolicy() to
to distribute memory across nodes based on the accessor and the
effective bandwidth available.

The goal is to maximize the effective use of available bandwidth.

The default weight is 1 for all nodes, which will mimic the current
interleave (basic round-robin).

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Suggested-by: Ying Huang <ying.huang@intel.com>
Suggested-by: Ravi Shankar <ravis.opensrc@micron.com>
---
 drivers/base/node.c  | 95 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/node.h | 17 ++++++++
 2 files changed, 112 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index b09c9c8e6830..29bb3874a885 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -83,9 +83,84 @@ struct node_access_nodes {
 #ifdef CONFIG_HMEM_REPORTING
 	struct node_hmem_attrs	hmem_attrs;
 #endif
+	unsigned char il_weight;
 };
 #define to_access_nodes(dev) container_of(dev, struct node_access_nodes, dev)
 
+#define MAX_NODE_INTERLEAVE_WEIGHT 100
+static ssize_t il_weight_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return sysfs_emit(buf, "%u\n",
+			  to_access_nodes(dev)->il_weight);
+}
+
+static ssize_t il_weight_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
+{
+	unsigned char weight;
+	int ret;
+
+	ret = kstrtou8(buf, 0, &weight);
+	if (ret)
+		return ret;
+
+	if (!weight || weight > MAX_NODE_INTERLEAVE_WEIGHT)
+		return -EINVAL;
+
+	to_access_nodes(dev)->il_weight = weight;
+	return len;
+}
+DEVICE_ATTR_RW(il_weight);
+
+unsigned char node_get_il_weight(unsigned int nid, unsigned int access_nid)
+{
+	struct node *node;
+	struct node_access_nodes *c;
+	unsigned char weight = 1;
+
+	node = node_devices[nid];
+	if (!node)
+		return weight;
+
+	list_for_each_entry(c, &node->access_list, list_node) {
+		if (c->access != access_nid)
+			continue;
+		weight = c->il_weight;
+		break;
+	}
+	return weight;
+}
+
+unsigned int nodes_get_il_weights(unsigned int access_nid, nodemask_t *nodes,
+				  unsigned char *weights)
+{
+	unsigned int nid;
+	struct node *node;
+	struct node_access_nodes *c;
+	unsigned int ttl_weight = 0;
+	unsigned char weight = 1;
+
+	for_each_node_mask(nid, *nodes) {
+		weight = 1;
+		node = node_devices[nid];
+		if (!node)
+			goto next_node;
+		list_for_each_entry(c, &node->access_list, list_node) {
+			if (c->access != access_nid)
+				continue;
+			weight = c->il_weight;
+			break;
+		}
+next_node:
+		weights[nid] = weight;
+		ttl_weight += weight;
+	}
+	return ttl_weight;
+}
+
 static struct attribute *node_init_access_node_attrs[] = {
 	NULL,
 };
@@ -116,6 +191,7 @@ static void node_remove_accesses(struct node *node)
 
 	list_for_each_entry_safe(c, cnext, &node->access_list, list_node) {
 		list_del(&c->list_node);
+		device_remove_file(&c->dev, &dev_attr_il_weight);
 		device_unregister(&c->dev);
 	}
 }
@@ -140,6 +216,7 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
 		return NULL;
 
 	access_node->access = access;
+	access_node->il_weight = 1;
 	dev = &access_node->dev;
 	dev->parent = &node->dev;
 	dev->release = node_access_release;
@@ -150,6 +227,9 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
 	if (device_register(dev))
 		goto free_name;
 
+	if (device_create_file(dev, &dev_attr_il_weight))
+		dev_warn(dev, "failed to add il_weight attribute\n");
+
 	pm_runtime_no_callbacks(dev);
 	list_add_tail(&access_node->list_node, &node->access_list);
 	return access_node;
@@ -363,6 +443,21 @@ static void node_init_caches(unsigned int nid)
 #else
 static void node_init_caches(unsigned int nid) { }
 static void node_remove_caches(struct node *node) { }
+
+unsigned char node_get_il_weight(unsigned int nid, unsigned int access_nid)
+{
+	return 1;
+}
+
+unsigned int nodes_get_il_weights(unsigned int access_nid, nodemask_t *nodes,
+				  unsigned char *weights)
+{
+	unsigned int nid;
+
+	for_each_node_mask(nid, *nodes)
+		weights[nid] = 1;
+	return nodes_weight(nodes);
+}
 #endif
 
 #define K(x) ((x) << (PAGE_SHIFT - 10))
diff --git a/include/linux/node.h b/include/linux/node.h
index 427a5975cf40..3c7a6dd2d954 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -138,6 +138,12 @@ extern void unregister_memory_block_under_nodes(struct memory_block *mem_blk);
 extern int register_memory_node_under_compute_node(unsigned int mem_nid,
 						   unsigned int cpu_nid,
 						   unsigned access);
+
+extern unsigned char node_get_il_weight(unsigned int nid,
+					unsigned int access_nid);
+extern unsigned int nodes_get_il_weights(unsigned int access_nid,
+					 nodemask_t *nodes,
+					 unsigned char *weights);
 #else
 static inline void node_dev_init(void)
 {
@@ -165,6 +171,17 @@ static inline int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
 static inline void unregister_memory_block_under_nodes(struct memory_block *mem_blk)
 {
 }
+static inline unsigned char node_get_il_weight(unsigned int nid,
+					       unsigned int access_nid)
+{
+	return 0;
+}
+static inline unsigned int nodes_get_il_weights(unsigned int access_nid,
+						nodemask_t *nodes,
+						unsigned char *weights)
+{
+	return 0;
+}
 #endif
 
 #define to_node(device) container_of(device, struct node, dev)
-- 
2.39.1


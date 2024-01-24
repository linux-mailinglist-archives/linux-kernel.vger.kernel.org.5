Return-Path: <linux-kernel+bounces-37457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90F883B057
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B0B1F227A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0650412A14D;
	Wed, 24 Jan 2024 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov/jQv3V"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DCB129A75;
	Wed, 24 Jan 2024 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118440; cv=none; b=DIVmdhqBjw3gMYb9bg/4NsaMblum2qhHcpMczN2ZKqNi2npBY6N9G1236184nt/0wGW1IvE3fTU91qE9NnwmnGJkgd+VyY6TjKrCvAJUF9AUswTUgkYzDHixSheiDUlT9URrewqaLsi0MvXRsqcllVdcP/hZLW2pSSHOHGzEWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118440; c=relaxed/simple;
	bh=TkD/7afEOAUYVVvFi9uEo60vgXmIeQpiZhHvrjTnZfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfsBoKMCeaVmNZ8zjem07qk4yba2XNBpwkmo19CrpIEVgv6R6tyywYTbzLjt1hC9qQaoborA+1vJlZg+D4COk/zMjSKFEUAicM3NEp7VyOGkeviG+bSmpIzxfNrwzYhWkCrD1ze8roXyV7RBwK26ep5GoXomxhGAYXA8lpXZdgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ov/jQv3V; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d731314e67so20452715ad.1;
        Wed, 24 Jan 2024 09:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118438; x=1706723238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2riTuEepe/mUCMr3Pq4qIV5z/xG84DnFng4TZ3aCOM=;
        b=Ov/jQv3VpXNL41tRtMMKv8I2hDUNg7UMPVVFYF7wyFqOAYMfoaNQZG0L0hATqta9S9
         k9wYPYr0q5yoUkruVXZ7FXcCQKGP6EEtCfdgB5NBq45WTTJ8dZOEHXbWDDqwVC/tlD1/
         dwgCxGv0VQSdifBa3126hEsytCYCUROknGCgc/zsdWOWzyu6N7g7+CJzecxTPVM1Luzq
         3auv1sgiCenVorlVX8doPkB9wqN/6yYimptmpmUIEuGQoM/yKV2povBpQrgtuh+7m0Vo
         f/ZmLTCAwxIpyYt+jZIJZsylhi0AXd6XnWgov8ZasQscEgFtA0+FFJ4NkqbCbVkbudpZ
         D3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118438; x=1706723238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2riTuEepe/mUCMr3Pq4qIV5z/xG84DnFng4TZ3aCOM=;
        b=YAYCE1Bh0IVTWYxaRAgsG3HxydYCrRUc1Z7InjjJwNcrgfBZeI5cKZIgXIMcfm70t2
         8nAaxmQBIN2fiNV5EK1E5dEBrRN5jSYho9+h8FqmVB3lqCH2n1ICm8Ka1DRnv4D/HzE2
         lwAZNVhnJnn6FhQ58OdE6NutMXzXms4fzOdQnfh3rZ8dgeCArq8QLJHuxo6NIgOeS54c
         nC6cHO6vi/QG0kyedoHaHYkKxz/3kgGL0Lsi9i7Q7BOp8OSNQGdoUPVRuSxUOC9NxFN0
         FCcPQhIRVx/WY4jKLHpmPKxFhZierv2Lq2LE90DMIHiefaCSUwffSyZoCEiTkTQhXRS1
         TzWg==
X-Gm-Message-State: AOJu0YzKkXjoDw3DHpe4KVHSy2hyqZFNv7Hf0BvZC/vb457zg7Fd2mTQ
	aXnsVgYcjw7+Sjg9jcuqLl83m2iEI1H0mqIOc4TdFcKrrJho0op5
X-Google-Smtp-Source: AGHT+IHPILvOnHNGuFqWVxNSI/EpMY7ZDayJzLHwYh06YXl06KCUCYCzokJKyfYpPr43PnSANBUZwQ==
X-Received: by 2002:a17:902:d48e:b0:1d4:b37a:e0a8 with SMTP id c14-20020a170902d48e00b001d4b37ae0a8mr993977plg.118.1706118437795;
        Wed, 24 Jan 2024 09:47:17 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902b08700b001d733c88646sm6965518plr.216.2024.01.24.09.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:47:17 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 2/8] net: netconsole: move netconsole_target config_item to config_group
Date: Wed, 24 Jan 2024 09:47:00 -0800
Message-ID: <20240124174711.1906102-3-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124174711.1906102-1-thepacketgeek@gmail.com>
References: <20240124174711.1906102-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support a nested userdata config_group in later patches,
use a config_group for netconsole_target instead of a
config_item. It's a no-op functionality-wise, since
config_group maintains all features of a config_item via the cg_item
member.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 drivers/net/netconsole.c | 59 ++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 93fc3b509706..5e720bcf7102 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -102,7 +102,7 @@ static struct console netconsole_ext;
 struct netconsole_target {
 	struct list_head	list;
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
-	struct config_item	item;
+	struct config_group	group;
 #endif
 	bool			enabled;
 	bool			extended;
@@ -134,14 +134,14 @@ static void __exit dynamic_netconsole_exit(void)
  */
 static void netconsole_target_get(struct netconsole_target *nt)
 {
-	if (config_item_name(&nt->item))
-		config_item_get(&nt->item);
+	if (config_item_name(&nt->group.cg_item))
+		config_group_get(&nt->group);
 }
 
 static void netconsole_target_put(struct netconsole_target *nt)
 {
-	if (config_item_name(&nt->item))
-		config_item_put(&nt->item);
+	if (config_item_name(&nt->group.cg_item))
+		config_group_put(&nt->group);
 }
 
 #else	/* !CONFIG_NETCONSOLE_DYNAMIC */
@@ -221,9 +221,13 @@ static struct netconsole_target *alloc_and_init(void)
 
 static struct netconsole_target *to_target(struct config_item *item)
 {
-	return item ?
-		container_of(item, struct netconsole_target, item) :
-		NULL;
+	struct config_group *cfg_group;
+
+	cfg_group = to_config_group(item);
+	if (!cfg_group)
+		return NULL;
+	return container_of(to_config_group(item),
+			    struct netconsole_target, group);
 }
 
 /*
@@ -370,7 +374,7 @@ static ssize_t release_store(struct config_item *item, const char *buf,
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
-		       config_item_name(&nt->item));
+		       config_item_name(&nt->group.cg_item));
 		err = -EINVAL;
 		goto out_unlock;
 	}
@@ -398,7 +402,7 @@ static ssize_t extended_store(struct config_item *item, const char *buf,
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
-		       config_item_name(&nt->item));
+		       config_item_name(&nt->group.cg_item));
 		err = -EINVAL;
 		goto out_unlock;
 	}
@@ -425,7 +429,7 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
-		       config_item_name(&nt->item));
+		       config_item_name(&nt->group.cg_item));
 		mutex_unlock(&dynamic_netconsole_mutex);
 		return -EINVAL;
 	}
@@ -450,7 +454,7 @@ static ssize_t local_port_store(struct config_item *item, const char *buf,
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
-		       config_item_name(&nt->item));
+		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
 	}
 
@@ -473,7 +477,7 @@ static ssize_t remote_port_store(struct config_item *item,
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
-		       config_item_name(&nt->item));
+		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
 	}
 
@@ -495,7 +499,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
-		       config_item_name(&nt->item));
+		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
 	}
 
@@ -532,7 +536,7 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
-		       config_item_name(&nt->item));
+		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
 	}
 
@@ -570,7 +574,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
-		       config_item_name(&nt->item));
+		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
 	}
 
@@ -638,7 +642,7 @@ static struct netconsole_target *find_cmdline_target(const char *name)
 
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list) {
-		if (!strcmp(nt->item.ci_name, name)) {
+		if (!strcmp(nt->group.cg_item.ci_name, name)) {
 			ret = nt;
 			break;
 		}
@@ -652,8 +656,8 @@ static struct netconsole_target *find_cmdline_target(const char *name)
  * Group operations and type for netconsole_subsys.
  */
 
-static struct config_item *make_netconsole_target(struct config_group *group,
-						  const char *name)
+static struct config_group *make_netconsole_target(struct config_group *group,
+						   const char *name)
 {
 	struct netconsole_target *nt;
 	unsigned long flags;
@@ -665,8 +669,9 @@ static struct config_item *make_netconsole_target(struct config_group *group,
 	if (!strncmp(name, NETCONSOLE_PARAM_TARGET_PREFIX,
 		     strlen(NETCONSOLE_PARAM_TARGET_PREFIX))) {
 		nt = find_cmdline_target(name);
-		if (nt)
-			return &nt->item;
+		if (nt) {
+			return &nt->group;
+		}
 	}
 
 	nt = alloc_and_init();
@@ -674,14 +679,14 @@ static struct config_item *make_netconsole_target(struct config_group *group,
 		return ERR_PTR(-ENOMEM);
 
 	/* Initialize the config_item member */
-	config_item_init_type_name(&nt->item, name, &netconsole_target_type);
+	config_group_init_type_name(&nt->group, name, &netconsole_target_type);
 
 	/* Adding, but it is disabled */
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_add(&nt->list, &target_list);
 	spin_unlock_irqrestore(&target_list_lock, flags);
 
-	return &nt->item;
+	return &nt->group;
 }
 
 static void drop_netconsole_target(struct config_group *group,
@@ -701,11 +706,11 @@ static void drop_netconsole_target(struct config_group *group,
 	if (nt->enabled)
 		netpoll_cleanup(&nt->np);
 
-	config_item_put(&nt->item);
+	config_item_put(&nt->group.cg_item);
 }
 
 static struct configfs_group_operations netconsole_subsys_group_ops = {
-	.make_item	= make_netconsole_target,
+	.make_group	= make_netconsole_target,
 	.drop_item	= drop_netconsole_target,
 };
 
@@ -731,8 +736,8 @@ static void populate_configfs_item(struct netconsole_target *nt,
 
 	snprintf(target_name, sizeof(target_name), "%s%d",
 		 NETCONSOLE_PARAM_TARGET_PREFIX, cmdline_count);
-	config_item_init_type_name(&nt->item, target_name,
-				   &netconsole_target_type);
+	config_group_init_type_name(&nt->group, target_name,
+				    &netconsole_target_type);
 }
 
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
-- 
2.43.0



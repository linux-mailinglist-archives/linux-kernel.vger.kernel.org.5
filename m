Return-Path: <linux-kernel+bounces-40809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEA983E658
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62705285A07
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE855A0FF;
	Fri, 26 Jan 2024 23:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDCaLsaj"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB0358ABE;
	Fri, 26 Jan 2024 23:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310838; cv=none; b=Cn/LzlgjRFmV2IXJSz3Ts8EGGjpRZX/3AN6nXFNMBY+ZpkazDERa8JEFk9IMWabNmVQrlOgZrATtCoOcy6yiizot3Lmkz41qh5pyO4rFtQ1oMrOlCFCqwncB14JCAf/AZtJV5rN/skKNYDcjP+S/zC7aj17Pg+4XlI+42NGFBtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310838; c=relaxed/simple;
	bh=HMzX7rgJBLGzBn8O3HLnD9vak9OSsdwseRcSZQv13NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLP3dbus85rACkkQq+kfgD0xmv0akpWbp6L24GiBf2AJtasaeOXU6dDZNMM6RRKdIQWTtVHlGRQYyY4chkcNzuYxincZHyve0iUJFpzrsG8X/K0QT4El9mbRPRhmggMdpExtiNOLL29ZeZCZHFHwu2be1DoKtZLBW3uhiJCyLJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDCaLsaj; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so630895a12.3;
        Fri, 26 Jan 2024 15:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706310836; x=1706915636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnkGomYm3D+fpLxdujWN99uxXSHNQWvM4sS9axkvWjE=;
        b=RDCaLsajsW9vCLrFJ8RgXaWvYl0LCx7R6pzNOPuaQAj0E5h4L/vrcPId6/yoEviw4m
         gs5nRuV11JzYXDJHM44LL5abRXn6BMxMOSSVW3XxsbEtaXE2zQytgWMT1vE6C+v+wBIL
         cFlyRdQHePpBbXlhxU66NXvYUNzxYeqJSPdrwkZPxXti1ACnIYdk/sVK5voa2dgg0ap0
         1yLe2dFlPPyEYHgp+sIEH7I558txuJYZQA4myzEY3vZNXPqajRENVbDbOnDvTtfWCsnJ
         HnEfMw4bdS7BwNTzO5s5XgIRale3/UFQebnk01717i2o1chfLpnB6MNYj6u2jTASs/gQ
         jxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310836; x=1706915636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnkGomYm3D+fpLxdujWN99uxXSHNQWvM4sS9axkvWjE=;
        b=bcppaEA22PYMp/AdNjtFLRMgtghMya8OPh4o4Qz0P01E2MTmY6oSwhQvZLL4p6Tge6
         xB+N3BW74zRCPazrjLi5NbeF4bAw8AA4bR2QphK+ZAyKmLDPlUPxCec/0YmxBFOazwZ7
         ES+2OIDqejy2UJ1L2BPu8BCl6xWYlU65/ueyUQ0tS3ftPiHP3U0NTJmwE0zvSkPOILAt
         xdqZSlKrorQPeUk6UOq0nj1kVjkGRLHC4pzza35s/Ehx3zb1l4HaflSH48c03b33GIfM
         YDNhum3aomB4BGprWx1dpUI09dryGPlOxlyDSbxbNuh9dJa2i7Hpuks6K3fdgz5jTMsO
         7ENg==
X-Gm-Message-State: AOJu0Ywu35UnWLKA4tqIKQuQddmsSJewbDxV2Q0utz3vjIATz+++G0nC
	7KG8qJSHOioDB2KpqOs2MKtnenN5IQZ/A8yI2bB33vb864Lcous4
X-Google-Smtp-Source: AGHT+IGy196ANI1JFjuq2M6xxkwRLO7pCqCc6UtQqIJgJXNZnz3586RKVwWskgYdGbu/goJgtTeFvA==
X-Received: by 2002:a05:6a20:a120:b0:19c:6dd4:9862 with SMTP id q32-20020a056a20a12000b0019c6dd49862mr649492pzk.5.1706310835938;
        Fri, 26 Jan 2024 15:13:55 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id gx20-20020a056a001e1400b006dde04c10dasm1607626pfb.217.2024.01.26.15.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 15:13:55 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/8] net: netconsole: move netconsole_target config_item to config_group
Date: Fri, 26 Jan 2024 15:13:37 -0800
Message-ID: <20240126231348.281600-3-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126231348.281600-1-thepacketgeek@gmail.com>
References: <20240126231348.281600-1-thepacketgeek@gmail.com>
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
 drivers/net/netconsole.c | 61 ++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 93fc3b509706..085350beca87 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -79,7 +79,7 @@ static struct console netconsole_ext;
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.
- * @item:	Links us into the configfs subsystem hierarchy.
+ * @group:	Links us into the configfs subsystem hierarchy.
  * @enabled:	On / off knob to enable / disable target.
  *		Visible from userspace (read-write).
  *		We maintain a strict 1:1 correspondence between this and
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



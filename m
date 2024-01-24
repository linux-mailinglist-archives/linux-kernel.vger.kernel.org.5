Return-Path: <linux-kernel+bounces-37460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C794383B05E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC1D1F2248F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0913212BE86;
	Wed, 24 Jan 2024 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTuPydUP"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9C12AAD1;
	Wed, 24 Jan 2024 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118446; cv=none; b=GwTRPNZzsVKzsUNgoPuu5XqQ6DTWiJfd4en4WALjWxdQoF/q0yPmocuCGh0J/0iAB8UVOJ8sE1vad8TELh1/GemSr7GBOOyMi+4GQOeIRxC/JwJA1XeRorJYYWRPHfNMgmsbOShLzANoHY3XZTcAWxge9iBeiiw1BBk5KCuaqUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118446; c=relaxed/simple;
	bh=2I9FInpu6eGl5WtGuSDGdlpAR1jOX87kmU3mmBWwMLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhGVuV9+WDNKf3tX4U6ErvuHbJyvSE3gOBpsxuYm4S5x83phqwQxjKMn6i4Ijrf2ioimBOfdg8waEaxqy3wMYIIccKfhvBUwFzTbY6sdAUuP0zuvPqdPhjQwD6ZzdMkJz+imqJDRA5HRvxim8geNVU8QjW54MeQKMkiTKy4Qzeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTuPydUP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d50d0c98c3so54440265ad.1;
        Wed, 24 Jan 2024 09:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118444; x=1706723244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02lzNgrCZ4Zdl0iLJ+8uXtX3qU8dkCCyd8xmzVFkf/8=;
        b=RTuPydUPx1b0DZhWnK+YSszw1oEPzH+UaFz5L07uvtoePGXqfY/xB4J5E1F9Pp6dfq
         LGvVir682EILyiHQ+dNrByMtS2ooKlD+Zvhi/rPdj1Cae6JDsM9LaXDSJBnmyryhfPMc
         qDDUgVgYw+d5OUS+8HS9h17TwPJGojia2rbAsOD3ZmjAm9GD9n7YED6dgm84ZZydzJnZ
         ITd3Pu5LizRPnj+aTWb/btle5kNhb1IJa9yS1GG8aE6xeqJiW2FalSICv8BCp5unLoz2
         Utel3EUi3vjkp03VaxvuzbQAsJTb3qCY1+ueZwdlpoyPRyJ8NGkDrdFXOBSHv22z19WL
         vZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118444; x=1706723244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02lzNgrCZ4Zdl0iLJ+8uXtX3qU8dkCCyd8xmzVFkf/8=;
        b=O/jMB/HxD5bdRWAXEodHoT7lStIiou5qmiA7dhCgPyTFFr3ufusHeVUinfck2/Qp4U
         RRRh22Tj6lxLEGNUPup2G6nzZCOQDsNj53C/gIHY/zMq+TtFRwiFttB9oapOPy8wnTX6
         iYf8o1wjvKtNMiJEIX1cIN76mOztSaAs3D+l1tvzrJXnv7QbekyFWTvULTPHnZUy7fMC
         VF2A9yfrbI2DIZ+9OnrAAuaIi5QTedLHUcusyCqslYH55h/GZs4TkdpTtFq+O9LNdOVs
         avQGdWtPSev5EZqI4UhwH8rJpG8lR0IesLf/wTRyGL7f0B/uwo3Mrb2prVa85RxN3UJp
         k2tQ==
X-Gm-Message-State: AOJu0YxxeXcQWM77vwm+YYKloKKX7NRX8evn4ZBifbA5QD1zkc3uBQlz
	tHobug7ZrgutcIfM9OAhGw5xUaGF6Mu9EttqqJWJqpXazW9ngLBI
X-Google-Smtp-Source: AGHT+IFh8roYQbN7BChoWoZRhmYZzCT8ZIbRqxs51quBI7/gZ0c8Elome2paEGINi0rmfsVzLuplbw==
X-Received: by 2002:a17:90a:e544:b0:28e:8c05:979 with SMTP id ei4-20020a17090ae54400b0028e8c050979mr2079001pjb.45.1706118443758;
        Wed, 24 Jan 2024 09:47:23 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id eu7-20020a17090af94700b002902076c395sm13730177pjb.34.2024.01.24.09.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:47:23 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 5/8] net: netconsole: add a userdata config_group member to netconsole_target
Date: Wed, 24 Jan 2024 09:47:03 -0800
Message-ID: <20240124174711.1906102-6-thepacketgeek@gmail.com>
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

Create configfs machinery for netconsole userdata appending, which depends
on CONFIG_NETCONSOLE_DYNAMIC (for configfs interface). Add a userdata
config_group to netconsole_target for managing userdata entries as a tree
under the netconsole configfs subsystem. Directory names created under the
userdata directory become userdatum keys; the userdatum value is the
content of the value file.

Include the minimum-viable-changes for userdata configfs config_group.
init_target_config_group() ties in the complete configfs machinery to
avoid unused func/variable errors during build. Initializing the
netconsole_target->group is moved to init_target_config_group, which
will also init and add the userdata config_group.

Each userdatum entry has a limit of 256 bytes (54 for
the key/directory, 200 for the value, and 2 for '=' and '\n'
characters), which is enforced by the configfs functions for updating
the userdata config_group.

When a new netconsole_target is created, initialize the userdata
config_group and add it as a default group for netconsole_target
config_group, allowing the userdata configfs sub-tree to be presented
in the netconsole configfs tree under the userdata directory.

Co-developed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 drivers/net/netconsole.c | 142 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 138 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 586945e62210..26a3bb070ad0 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -43,6 +43,10 @@ MODULE_DESCRIPTION("Console driver for network interfaces");
 MODULE_LICENSE("GPL");
 
 #define MAX_PARAM_LENGTH	256
+#define MAX_USERDATA_NAME_LENGTH	54
+#define MAX_USERDATA_VALUE_LENGTH	200
+#define MAX_USERDATA_ENTRY_LENGTH	256
+#define MAX_USERDATA_ITEMS		16
 #define MAX_PRINT_CHUNK		1000
 
 static char config[MAX_PARAM_LENGTH];
@@ -103,6 +107,7 @@ struct netconsole_target {
 	struct list_head	list;
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	struct config_group	group;
+	struct config_group userdata_group;
 #endif
 	bool			enabled;
 	bool			extended;
@@ -215,6 +220,10 @@ static struct netconsole_target *alloc_and_init(void)
  *				|	remote_ip
  *				|	local_mac
  *				|	remote_mac
+ *				|	userdata/
+ *				|		<key>/
+ *				|			value
+ *				|		...
  *				|
  *				<target>/...
  */
@@ -596,6 +605,123 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 	return -EINVAL;
 }
 
+struct userdatum {
+	struct config_item item;
+	char value[MAX_USERDATA_VALUE_LENGTH];
+};
+
+static inline struct userdatum *to_userdatum(struct config_item *item)
+{
+	return container_of(item, struct userdatum, item);
+}
+
+struct userdata {
+	struct config_group group;
+};
+
+static inline struct userdata *to_userdata(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct userdata, group);
+}
+
+static struct netconsole_target *userdata_to_target(struct userdata *ud)
+{
+	struct config_group *netconsole_group;
+
+	netconsole_group = to_config_group(ud->group.cg_item.ci_parent);
+	return to_target(&netconsole_group->cg_item);
+}
+
+static ssize_t userdatum_value_show(struct config_item *item, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", &(to_userdatum(item)->value[0]));
+}
+
+static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
+				     size_t count)
+{
+	struct userdatum *udm = to_userdatum(item);
+	int ret;
+
+	if (count > MAX_USERDATA_VALUE_LENGTH)
+		return -EMSGSIZE;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+
+	ret = strscpy(udm->value, buf, sizeof(udm->value));
+	if (ret < 0)
+		goto out_unlock;
+	trim_newline(udm->value, sizeof(udm->value));
+
+	mutex_unlock(&dynamic_netconsole_mutex);
+	return count;
+out_unlock:
+	mutex_unlock(&dynamic_netconsole_mutex);
+	return ret;
+}
+
+CONFIGFS_ATTR(userdatum_, value);
+
+static struct configfs_attribute *userdatum_attrs[] = {
+	&userdatum_attr_value,
+	NULL,
+};
+
+static void userdatum_release(struct config_item *item)
+{
+	kfree(to_userdatum(item));
+}
+
+static struct configfs_item_operations userdatum_ops = {
+	.release = userdatum_release,
+};
+
+static const struct config_item_type userdatum_type = {
+	.ct_item_ops	= &userdatum_ops,
+	.ct_attrs	= userdatum_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_item *userdatum_make_item(struct config_group *group,
+					       const char *name)
+{
+	struct netconsole_target *nt;
+	struct userdatum *udm;
+	struct userdata *ud;
+	size_t child_count;
+
+	if (strlen(name) > MAX_USERDATA_NAME_LENGTH)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	ud = to_userdata(&group->cg_item);
+	nt = userdata_to_target(ud);
+	child_count = list_count_nodes(&nt->userdata_group.cg_children);
+	if (child_count >= MAX_USERDATA_ITEMS)
+		return ERR_PTR(-ENOSPC);
+
+	udm = kzalloc(sizeof(*udm), GFP_KERNEL);
+	if (!udm)
+		return ERR_PTR(-ENOMEM);
+
+	config_item_init_type_name(&udm->item, name, &userdatum_type);
+	return &udm->item;
+}
+
+static struct configfs_attribute *userdata_attrs[] = {
+	NULL,
+};
+
+static struct configfs_group_operations userdata_ops = {
+	.make_item		= userdatum_make_item,
+};
+
+static struct config_item_type userdata_type = {
+	.ct_item_ops	= &userdatum_ops,
+	.ct_group_ops	= &userdata_ops,
+	.ct_attrs	= userdata_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
 CONFIGFS_ATTR(, enabled);
 CONFIGFS_ATTR(, extended);
 CONFIGFS_ATTR(, dev_name);
@@ -640,6 +766,14 @@ static const struct config_item_type netconsole_target_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
+static void init_target_config_group(struct netconsole_target *nt, const char *name)
+{
+	config_group_init_type_name(&nt->group, name, &netconsole_target_type);
+	config_group_init_type_name(&nt->userdata_group, "userdata",
+				    &userdata_type);
+	configfs_add_default_group(&nt->userdata_group, &nt->group);
+}
+
 static struct netconsole_target *find_cmdline_target(const char *name)
 {
 	struct netconsole_target *nt, *ret = NULL;
@@ -675,6 +809,7 @@ static struct config_group *make_netconsole_target(struct config_group *group,
 		     strlen(NETCONSOLE_PARAM_TARGET_PREFIX))) {
 		nt = find_cmdline_target(name);
 		if (nt) {
+			init_target_config_group(nt, name);
 			return &nt->group;
 		}
 	}
@@ -683,8 +818,8 @@ static struct config_group *make_netconsole_target(struct config_group *group,
 	if (!nt)
 		return ERR_PTR(-ENOMEM);
 
-	/* Initialize the config_item member */
-	config_group_init_type_name(&nt->group, name, &netconsole_target_type);
+	/* Initialize the config_group member */
+	init_target_config_group(nt, name);
 
 	/* Adding, but it is disabled */
 	spin_lock_irqsave(&target_list_lock, flags);
@@ -741,8 +876,7 @@ static void populate_configfs_item(struct netconsole_target *nt,
 
 	snprintf(target_name, sizeof(target_name), "%s%d",
 		 NETCONSOLE_PARAM_TARGET_PREFIX, cmdline_count);
-	config_group_init_type_name(&nt->group, target_name,
-				    &netconsole_target_type);
+	init_target_config_group(nt, target_name);
 }
 
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
-- 
2.43.0



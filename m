Return-Path: <linux-kernel+bounces-40812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF8783E660
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FE3AB238A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBCD5BAC4;
	Fri, 26 Jan 2024 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVQMOUP4"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3585B5A2;
	Fri, 26 Jan 2024 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310845; cv=none; b=rWAYuD2ICUS3aRM3YZUg5IU8/qBeOM4V+xRFITuHX77Xb2OQbKY5vbuZ4yUyfaoW3GtHUhRPT9v2Q+uvvNLIcve8A4SG423pA/TXSjzghWcOFb+r6/iblKy/3oVxfB15rNBTFdBTHpkPBTFfqgd/XjR2yg1X+42CbnDdHErmbW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310845; c=relaxed/simple;
	bh=ZxSvQuKIvS929xpYXb9PbVGUkIwgggEnc5f94Q8zZVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUQstiTk0aW61KNqVcQ8Eldk0T/XBqOhSc/u044MU70qbg3Nm3YxNvtjL7Z9g45/DFsNvY7Zu9yJWkjkk2kIJ/l7EoYRJ5XtW5cERQgfjsbw4OCeek1mUmoQUdvrYk99/FK5UG8BOxzuK2KscG6tnHi+y//otpfhcpQemHp8Xmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVQMOUP4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6db9e52bbccso605645b3a.3;
        Fri, 26 Jan 2024 15:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706310843; x=1706915643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvBhPn9ZH1DBkVaPM0Ti+Jleq5aPuYncHEARZsqxOXU=;
        b=bVQMOUP4iWXxu5PcRSEbqKNWNiKFrS9NrEEeKwCqcQ/UFEHZscZwq9m1Cg56klDPWR
         gWwXS+ovsd1rxX4krmwwAnW2JawvHdpjSQmt1ZRYdOEFuRRIt+yyx5exYupOEwN+qXh9
         4VeGj/akNvPHew4JKSGeiUsYgmvsNKRb0l4PxTojmaDtKHlhgEKVJoMIeGAoDXIwtG1C
         Swjf3U2u41UxA0LyKjd/qhjlIRrV+mEjqGMs6Lv8SWE0o/9E9bS60IK74a2ME+lKjbnH
         Yz3jbdKJzfrFuibIHba39gIFVEuT/mBsGYPCMGXJKSlr9BkBk5Q1vuUiFEXW/nIowiXS
         E03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310843; x=1706915643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvBhPn9ZH1DBkVaPM0Ti+Jleq5aPuYncHEARZsqxOXU=;
        b=vfiD01V8CHBeGi0EqIVZjbZ0vBSzZzE7d+55AQ+P1DODu3lprP3rX+IiflEJ98mWDt
         xmhFw2yCYdde2IYo2vuP/GooQHQfyTh6doF8IlUwousT7bJXV7uP1IuZ+u3O1YwRd/Eq
         IWBL1tx3xmYoz0wruftqJsnOgb4R6WTkCM7DXFqyjVa4E4jcpJg01G6vCfWs2caHgBYq
         sAV4kzzLwHYJJi5QaCxknFXO4oXbCquxwxAvkFwoykAcF1nm7Ln6lSrBUtTK5kUEFd3x
         gZe1QccBKgPUHkFBm2p8DhAGuaDI8czV3rjgfgmXre4UWd/meWFvEF4XDOgR147+0OWM
         YU9g==
X-Gm-Message-State: AOJu0YySGQCNFKiNTMLQ9bPbNsWq9/6ZFeIy73ctsSTIQ7j+3Hphey2m
	JBMM9OC/H+NZOS9hjQBDzf39Q5wX9xJIHHL0OnzwmQkvpdx95yBS0zZ0yXly
X-Google-Smtp-Source: AGHT+IEgteSIq6kyiudEEHxTOs9Pnacif7cBc6vgumjZuBpJNR1AUJRFNtC52YoERJFCRlQ0+z65Dg==
X-Received: by 2002:a05:6a00:991:b0:6db:c9d2:12d4 with SMTP id u17-20020a056a00099100b006dbc9d212d4mr920125pfg.17.1706310843307;
        Fri, 26 Jan 2024 15:14:03 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id o194-20020a62cdcb000000b006dab0d72cd0sm1674724pfg.214.2024.01.26.15.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 15:14:02 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 5/8] net: netconsole: add a userdata config_group member to netconsole_target
Date: Fri, 26 Jan 2024 15:13:40 -0800
Message-ID: <20240126231348.281600-6-thepacketgeek@gmail.com>
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
 drivers/net/netconsole.c | 143 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 139 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b280d06bf152..a5ac21136f02 100644
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
@@ -80,6 +84,7 @@ static struct console netconsole_ext;
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.
  * @group:	Links us into the configfs subsystem hierarchy.
+ * @userdata_group:	Links to the userdata configfs hierarchy
  * @enabled:	On / off knob to enable / disable target.
  *		Visible from userspace (read-write).
  *		We maintain a strict 1:1 correspondence between this and
@@ -103,6 +108,7 @@ struct netconsole_target {
 	struct list_head	list;
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	struct config_group	group;
+	struct config_group	userdata_group;
 #endif
 	bool			enabled;
 	bool			extended;
@@ -215,6 +221,10 @@ static struct netconsole_target *alloc_and_init(void)
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
@@ -596,6 +606,123 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
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
@@ -640,6 +767,14 @@ static const struct config_item_type netconsole_target_type = {
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
@@ -675,6 +810,7 @@ static struct config_group *make_netconsole_target(struct config_group *group,
 		     strlen(NETCONSOLE_PARAM_TARGET_PREFIX))) {
 		nt = find_cmdline_target(name);
 		if (nt) {
+			init_target_config_group(nt, name);
 			return &nt->group;
 		}
 	}
@@ -683,8 +819,8 @@ static struct config_group *make_netconsole_target(struct config_group *group,
 	if (!nt)
 		return ERR_PTR(-ENOMEM);
 
-	/* Initialize the config_item member */
-	config_group_init_type_name(&nt->group, name, &netconsole_target_type);
+	/* Initialize the config_group member */
+	init_target_config_group(nt, name);
 
 	/* Adding, but it is disabled */
 	spin_lock_irqsave(&target_list_lock, flags);
@@ -741,8 +877,7 @@ static void populate_configfs_item(struct netconsole_target *nt,
 
 	snprintf(target_name, sizeof(target_name), "%s%d",
 		 NETCONSOLE_PARAM_TARGET_PREFIX, cmdline_count);
-	config_group_init_type_name(&nt->group, target_name,
-				    &netconsole_target_type);
+	init_target_config_group(nt, target_name);
 }
 
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
-- 
2.43.0



Return-Path: <linux-kernel+bounces-51938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511D78491A0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756541C21C8E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE2B13AD1;
	Sun,  4 Feb 2024 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrvaH/MK"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB2134AC;
	Sun,  4 Feb 2024 23:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707089279; cv=none; b=HIPZeAaQijGkMncxiToZh8aBKqRW2Df8ncWx7OQesnj+Kn0J/EODM+A9e0EdAFShnMIomiYDSkX3+3TvLYrdyqKEA+QdvyWSrGXyJEeGEvEOHopBbRgTklXVMsUXJxIPGEY3URbudQvPvDHkQ2uI0HCNZ/pkaiGcFC9s7qNDGlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707089279; c=relaxed/simple;
	bh=EsPfvCdyb9fqotxxhnjVd1pr2sFgS3Srf7o6hv/vts4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOEbXLmaSW2jmR0UO/2NCEE6zgSzjtgpZabp6Nu3PYGU/gxrlNCMiNqke1czWicy0N9VmHRoxboVVkv4bQ8369P+fi9ev5zbePExltjlP10pIZVE0uhpVSrrAnKZQdufhPKn6OLJrUZecZ7+fVUWiNUYq2QSyY9Jpuys1o9PoYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrvaH/MK; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d3907ff128so3375408a12.3;
        Sun, 04 Feb 2024 15:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707089277; x=1707694077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCYkAExjd+SThE20it4/Y+M6eEB7vekvWXl2VDrzmho=;
        b=WrvaH/MKzafEnN+Eg1/tU9hhxjiT2TJyUpylOd0w7avZSz0H907YJZwe+ywNlJTyWy
         PnITU/d4B59wNdOxnmu2tWa81i6PV2Uyho4uvp9Rq3orDdC4WzZZNCobrT4NptYNs+4d
         2K9EEu78Za0nqozXHQ95w2xiaOwEm67aQChcALzCYi1tLqlwyVgYOuAFLO9ueTKZpDhf
         FHNPcEScGE803LLkf1IbIKqd1r6k+uQOwK9zX4ARI5Y5uEsMGGOPEIjwFyqSyXGeZuC4
         OTfUtLtMH58Q+Iub+ruziccfzXeRsdV2tBXtszu9DEw5AA5fGn3rWrbrD8fIR0qF7uhe
         RvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707089277; x=1707694077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCYkAExjd+SThE20it4/Y+M6eEB7vekvWXl2VDrzmho=;
        b=a/F4LjAoMdGo6Lmu/vGjgp4r6yvRCctR2XjQeNbhCp4w3Tk77NX/t381JVYDQaI8h2
         ogAuCvkCGxVckCpjx5CJovDd4c1UYq3ky5UrrQU9IXsl8BwJJWV/KNtuabxbwVx1fk9T
         VpZaFNBjLG7MCEj0mFQCcstIq0mPsxgt9hdK3XF3/Ye3+3Spa0G2phbuu3rNEDGFLBKN
         9O+5rmfa6cfsLDboCOHsPVjcfaAjlJBhn+M2BCAattfYfnB4x7RPPoSUcZezYhTrqtb1
         JaLzzwltCJTha2DUF2j7cSiMoGV8T+7BqGldacx62C6Hfh4DLWOQgIxEcYjPSuJ6ELk8
         cvNQ==
X-Gm-Message-State: AOJu0YzWaZ5K1rIfYk9aSgNscXsL3ydScX3lmfaZGge87gHF8p0p5MgC
	VyTmKv7/9NJl4AMSzhN139Q0HeKXCvH/zvrw7JpA6R4cjySruhYh
X-Google-Smtp-Source: AGHT+IFoNRwY/VXCp887f2myu/3//J2/+u9oMKDYomVvLkChlGfH2TVFoBNBpHPvaRpzlro2yHTMkQ==
X-Received: by 2002:a05:6a21:7894:b0:19c:90fc:f0d3 with SMTP id bf20-20020a056a21789400b0019c90fcf0d3mr18585019pzc.46.1707089277381;
        Sun, 04 Feb 2024 15:27:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVc2TwKkeTGLPigddVr0b0eC3edBaEPR9HcIUn3F/Ik3bk837MccfsopJPEsVyTylGomwEO070IhyKFJ29OyuwqGGxuu9s1K1Y/No3UV4JmSu8TOpqY8NUSUBYqnIENfPZ2HI/SCIZ3NZn+zExodPWKWC0SNz1OU1mEqYmxCJNupXBtSylmU5qTo4DZK106jGIYuZ62MPo9EL1L//PD
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id h4-20020a056a00000400b006e04233b0d1sm814831pfk.54.2024.02.04.15.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:27:57 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 5/8] net: netconsole: add a userdata config_group member to netconsole_target
Date: Sun,  4 Feb 2024 15:27:36 -0800
Message-ID: <20240204232744.91315-6-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204232744.91315-1-thepacketgeek@gmail.com>
References: <20240204232744.91315-1-thepacketgeek@gmail.com>
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
 drivers/net/netconsole.c | 147 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 142 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index e6c3b15fe95d..3618b9ebcce4 100644
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
+static struct userdatum *to_userdatum(struct config_item *item)
+{
+	return container_of(item, struct userdatum, item);
+}
+
+struct userdata {
+	struct config_group group;
+};
+
+static struct userdata *to_userdata(struct config_item *item)
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
@@ -640,6 +767,15 @@ static const struct config_item_type netconsole_target_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
+static void init_target_config_group(struct netconsole_target *nt,
+				     const char *name)
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
@@ -674,16 +810,18 @@ static struct config_group *make_netconsole_target(struct config_group *group,
 	if (!strncmp(name, NETCONSOLE_PARAM_TARGET_PREFIX,
 		     strlen(NETCONSOLE_PARAM_TARGET_PREFIX))) {
 		nt = find_cmdline_target(name);
-		if (nt)
+		if (nt) {
+			init_target_config_group(nt, name);
 			return &nt->group;
+		}
 	}
 
 	nt = alloc_and_init();
 	if (!nt)
 		return ERR_PTR(-ENOMEM);
 
-	/* Initialize the config_item member */
-	config_group_init_type_name(&nt->group, name, &netconsole_target_type);
+	/* Initialize the config_group member */
+	init_target_config_group(nt, name);
 
 	/* Adding, but it is disabled */
 	spin_lock_irqsave(&target_list_lock, flags);
@@ -740,8 +878,7 @@ static void populate_configfs_item(struct netconsole_target *nt,
 
 	snprintf(target_name, sizeof(target_name), "%s%d",
 		 NETCONSOLE_PARAM_TARGET_PREFIX, cmdline_count);
-	config_group_init_type_name(&nt->group, target_name,
-				    &netconsole_target_type);
+	init_target_config_group(nt, target_name);
 }
 
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
-- 
2.43.0



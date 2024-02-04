Return-Path: <linux-kernel+bounces-51939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6686F8491A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FFB28103C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EE214286;
	Sun,  4 Feb 2024 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dlhv7RTb"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22575125D8;
	Sun,  4 Feb 2024 23:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707089281; cv=none; b=UtNcBf8LzmEGHfR/JMAPiU3AJI30dzCuA/xeWjDgSb1YwipT3oa53jFg1Yfo5wFEe9wF19pHRuQwP/ePf46D1LVgiD4+S4cbAvh5z6Vg71XlaMdnIMzv5pAlOzqhQbOro+wj9gkxw5UxgIQGdZ87TtyaPsFOGGNxeW8bUWGOqAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707089281; c=relaxed/simple;
	bh=5GwH1PqDWl2CwGmvij6Qd6cD1bi7HcM6jD/BhS8N5sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORMremUX6MWJhw+zwN4fMjYu/gGkqQZfjyLkLQtjmBrnQaCjEHVmAEcHTTNb+CERUAyTPR5h4SKrULmyqGoosH3FHVSByMcOWjcDBQgGQjMlriuCzWmV9gzLJpjzGGPdtCSViPU2x4tPkTgH5m6wRmltgvq5jm/HRrc7bLmwYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dlhv7RTb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d953fa3286so26511075ad.2;
        Sun, 04 Feb 2024 15:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707089279; x=1707694079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TW8QValFS/0zkKjvlP3DgdGfC9w7hSQMfOI/aFj5gPQ=;
        b=Dlhv7RTbF24pNtn3fNKmRcfBfJlBKXhdTYo/viYKnAmM5hlEq1hd0XYSmxEpMfTXK/
         vHqKHxodIzI86158FnrkZScJVCvTG8HqkgAKHTod/8fhdmg8AjINXE/SuKjWaoKKkKh4
         klIFa4lwUsqgz7Y4Ah7j8TGjI/LFXa/Ofai8R3SQFNi311Wu/WenMjZflgSMQQaIG2j0
         h4AFEuhnrKCNoW4QwKcE5Ax7dyvKQ7e79KEq/fm4DYzcct9gHzs638er6QarLAjkIw4D
         u5Lt4NC7XfXvhFFjrFXBvUqoYtV1WdViPxLEPdJwIqJVJ6oOCZcBrYptXGI3MyoKIItx
         MOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707089279; x=1707694079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TW8QValFS/0zkKjvlP3DgdGfC9w7hSQMfOI/aFj5gPQ=;
        b=m6NJmcZkOc640HZU2UARQO1f59aCtDQe4fMBuiWeTmW13fPgmh2ddLLjgS63FjHb+h
         R7uUyxVxyrYPb5gt0MggBHuOOLm6nIRRPY5Xq04gy/Zv3AjIBZuCtDoahXE7KwMutr7I
         cf4jXq2u7ljHYno/w0HMLKgdyjW+AeBoiUgA8lWArtnpUwsNcyvdfj/bDhkFNT0o5dgq
         LcMRxh1RadR4UQztARxYtrtXQnx+9EM10RWx7XPg+037YA6n5HUNoUYkYXUQtccf9s5h
         YW300+/yRGILgZ4qaq3ZF7ve4v31kn98KhqSaPjw91msDe6A4nPVsUpVFX31AsTRmO4i
         eB7A==
X-Gm-Message-State: AOJu0YxzpPXBNH0uaphbpcGJRdxj29tBbK8JUK1iWDkU7TzqqxIqCR6v
	vvL5xR4mTwuAqSWShtSPyVlfpbwS6OzHgWOngdKCO4+ewkXPD66y
X-Google-Smtp-Source: AGHT+IGyl7zAw+9G1cbCH622HKM09vwz1t5biCOR6L6kvDYAtumJfZtMjJ0FJRNy4az4LFwc7gUN+Q==
X-Received: by 2002:a17:902:d643:b0:1d4:dddc:d38e with SMTP id y3-20020a170902d64300b001d4dddcd38emr11540531plh.61.1707089279406;
        Sun, 04 Feb 2024 15:27:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUBv7M40ptsPLrNXXgFRSvX+nrqEcP2r3wDxtSX6b60T8P/zChU1jFziUN7IahUhq1+o6zazQdTjAM7aF88D9swox/zJ0TSnXOm/PtzZSPM/PdWBNA53/j73BYxHxLkqiiqKs0J4nvAEXM32PUkSbXHl8n1kG2hkoXZWVYobSkJleNF+8+ozk8A+0A86u8Jb0gZpgi8aE+M/jBjmwJv
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902d11200b001d8ee19ab34sm5072156plw.29.2024.02.04.15.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:27:59 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 6/8] net: netconsole: cache userdata formatted string in netconsole_target
Date: Sun,  4 Feb 2024 15:27:37 -0800
Message-ID: <20240204232744.91315-7-thepacketgeek@gmail.com>
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

Store a formatted string for userdata that will be appended to netconsole
messages. The string has a capacity of 4KB, as calculated by the userdatum
entry length of 256 bytes and a max of 16 userdata entries.

Update the stored netconsole_target->userdata_complete string with the new
formatted userdata values when a userdatum is created, edited, or
removed. Each userdata entry contains a trailing newline, which will be
formatted as such in netconsole messages::

    6.7.0-rc8-virtme,12,500,1646292204,-;test
    release=foo
    something=bar
    6.7.0-rc8-virtme,12,500,1646292204,-;another test
    release=foo
    something=bar

Enforcement of MAX_USERDATA_ITEMS is done in userdatum_make_item;
update_userdata will not check for this case but will skip any userdata
children over the limit of MAX_USERDATA_ITEMs.

If a userdata entry/dir is created but no value is provided, that entry
will be skipped. This is in part because update_userdata() can't be
called in userdatum_make_item() since the item will not have been added
to the userdata config_group children yet. To preserve the experience of
adding an empty userdata that doesn't show up in the netconsole
messages, purposefully skip empty userdata items even when
update_userdata() can be called.

Co-developed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 drivers/net/netconsole.c | 61 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 3618b9ebcce4..e4d6ba0b50ef 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -85,6 +85,8 @@ static struct console netconsole_ext;
  * @list:	Links this target into the target_list.
  * @group:	Links us into the configfs subsystem hierarchy.
  * @userdata_group:	Links to the userdata configfs hierarchy
+ * @userdata_complete:	Cached, formatted string of append
+ * @userdata_length:	String length of userdata_complete
  * @enabled:	On / off knob to enable / disable target.
  *		Visible from userspace (read-write).
  *		We maintain a strict 1:1 correspondence between this and
@@ -109,6 +111,8 @@ struct netconsole_target {
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	struct config_group	group;
 	struct config_group	userdata_group;
+	char userdata_complete[MAX_USERDATA_ENTRY_LENGTH * MAX_USERDATA_ITEMS];
+	size_t			userdata_length;
 #endif
 	bool			enabled;
 	bool			extended;
@@ -638,10 +642,48 @@ static ssize_t userdatum_value_show(struct config_item *item, char *buf)
 	return sysfs_emit(buf, "%s\n", &(to_userdatum(item)->value[0]));
 }
 
+static void update_userdata(struct netconsole_target *nt)
+{
+	int complete_idx = 0, child_count = 0;
+	struct list_head *entry;
+
+	/* Clear the current string in case the last userdatum was deleted */
+	nt->userdata_length = 0;
+	nt->userdata_complete[0] = 0;
+
+	list_for_each(entry, &nt->userdata_group.cg_children) {
+		struct userdatum *udm_item;
+		struct config_item *item;
+
+		if (child_count >= MAX_USERDATA_ITEMS)
+			break;
+		child_count++;
+
+		item = container_of(entry, struct config_item, ci_entry);
+		udm_item = to_userdatum(item);
+
+		/* Skip userdata with no value set */
+		if (strnlen(udm_item->value, MAX_USERDATA_VALUE_LENGTH) == 0)
+			continue;
+
+		/* This doesn't overflow userdata_complete since it will write
+		 * one entry length (1/MAX_USERDATA_ITEMS long), entry count is
+		 * checked to not exceed MAX items with child_count above
+		 */
+		complete_idx += scnprintf(&nt->userdata_complete[complete_idx],
+					  MAX_USERDATA_ENTRY_LENGTH, "%s=%s\n",
+					  item->ci_name, udm_item->value);
+	}
+	nt->userdata_length = strnlen(nt->userdata_complete,
+				      sizeof(nt->userdata_complete));
+}
+
 static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 				     size_t count)
 {
 	struct userdatum *udm = to_userdatum(item);
+	struct netconsole_target *nt;
+	struct userdata *ud;
 	int ret;
 
 	if (count > MAX_USERDATA_VALUE_LENGTH)
@@ -654,6 +696,10 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	trim_newline(udm->value, sizeof(udm->value));
 
+	ud = to_userdata(item->ci_parent);
+	nt = userdata_to_target(ud);
+	update_userdata(nt);
+
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return count;
 out_unlock:
@@ -708,12 +754,27 @@ static struct config_item *userdatum_make_item(struct config_group *group,
 	return &udm->item;
 }
 
+static void userdatum_drop(struct config_group *group, struct config_item *item)
+{
+	struct netconsole_target *nt;
+	struct userdata *ud;
+
+	ud = to_userdata(&group->cg_item);
+	nt = userdata_to_target(ud);
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	update_userdata(nt);
+	config_item_put(item);
+	mutex_unlock(&dynamic_netconsole_mutex);
+}
+
 static struct configfs_attribute *userdata_attrs[] = {
 	NULL,
 };
 
 static struct configfs_group_operations userdata_ops = {
 	.make_item		= userdatum_make_item,
+	.drop_item		= userdatum_drop,
 };
 
 static struct config_item_type userdata_type = {
-- 
2.43.0



Return-Path: <linux-kernel+bounces-37461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0580D83B061
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7041F22C63
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A84912BF07;
	Wed, 24 Jan 2024 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh+1Hasm"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F48E12BE82;
	Wed, 24 Jan 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118448; cv=none; b=VB/Rm0scIPpH/xV1vFVUUYyfiGUHcbzR5R0mv7e+sY7lYHgwXxBkTuIUO3AiqV0T0AWVBWJFT6riLB+xwvStfyX3UfCk8XovKkaD9KZvz1b/zEFgwQch5RnKYRBXOJPz2MziQ4ASAvnjmhwV8quKxZvCAzGzFYl3VZQwljfqwoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118448; c=relaxed/simple;
	bh=Jjv/TuEFrl542Uz2oPY2+FJwkmzA1uzPImxNDC4FnrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gz9DcnNP9cuXwMqSVvqqPzaoLaV6BvUxiSL5YTRurTuv8FFUVCmHdD8o57jIyWe/snMelhq8jBg8Hu9LFQc7VbP0SsYwYFdVz7KYC8BrTp1lLSbACJrpNBXPF2iw8YsixVDxIW/vMyEiA+MKasS3kwyN/g2lM0sXpiyh534tWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh+1Hasm; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4095691a12.3;
        Wed, 24 Jan 2024 09:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118446; x=1706723246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yr4N28qTdreJQILPMIL8Vba8ZMs6hXrf/fYG9mRvfk=;
        b=Gh+1HasmqJacU8EJ00LtEwisiIY1EPc/ZxwqM8qR0eGv2aA3q/ku9pcJst0AZzD4vE
         IuPXK0+3jGTqx3WIiKW4kCT3gkOdAQxloCJmu9wUwnZrWLeok9h4L+FdNAH65j84G65n
         csHe/5O7K+/95RtY07Phff24ChEkqjT5OYLLArnY2nf+JKPpv4uvE/n7q3ZVx6LzLgm3
         S/Sfy2zNhMKu+7FQF2531l2LopBtHXvTfgrHIiMGSqfEdG7idNfbLsCku2+RwuasmBFl
         WG1VOMg56YoWJZ/CqPAYnQDu9m4S7CfO2ZpxDShS8PJsj5UJjbP8xis+/zg3eJA95QUB
         Ysqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118446; x=1706723246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yr4N28qTdreJQILPMIL8Vba8ZMs6hXrf/fYG9mRvfk=;
        b=nfBXPCLaqmneyC2b3+VgapczHM46rM6fLsB2bzaFWMy51nGnpngGPNo94GK96EHYhK
         kZJFQM/u/KT2F6V/WWKefNhi+CBaZcjqD5g0w8iTiXYBHvoNiNUDEew49fBtL4+V4Oc2
         KRe2jjHT55pVXQmfcLCtjT9eZywPGlDn/SfyOMn/k7GdxpqGsFlJB70zdfXLGcV6Fb61
         FXeRoBJoStrn/om6ShT0+2VA1P359vs8/gYGW+1g9AFWYDZa29RS20BQy5sWgc9PXGqo
         krxMWfqNA2ptGVAM0OIYY9JvonLx2ae0la6YEYlNus4rhiQ2BoORULcsmGfge+XWNVNi
         lggA==
X-Gm-Message-State: AOJu0Ywe5m/wYoIfjB0TsZkqwSSFbN7iTRtGeVPGjX/6n63cMEcTxsND
	rU5HNsEaUcAm+q0GCMPzejFzL4Lz4wtKbZv+7bNzLFmhw6C0qlbU
X-Google-Smtp-Source: AGHT+IFcM1ZqAfg+43OOysJA4KTHZItl2rd9oGtRVwM/1yHN/6BBFXY8dfTg7i7fxN8aMzUgdLAb/Q==
X-Received: by 2002:a05:6a20:671c:b0:199:a725:9b59 with SMTP id q28-20020a056a20671c00b00199a7259b59mr1075725pzh.114.1706118445804;
        Wed, 24 Jan 2024 09:47:25 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id ey15-20020a056a0038cf00b006db05eb1301sm14174896pfb.21.2024.01.24.09.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:47:25 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 6/8] net: netconsole: cache userdata formatted string in netconsole_target
Date: Wed, 24 Jan 2024 09:47:04 -0800
Message-ID: <20240124174711.1906102-7-thepacketgeek@gmail.com>
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
messages, purposefully skip emtpy userdata items even when
update_userdata() can be called.

Co-developed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 drivers/net/netconsole.c | 61 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 26a3bb070ad0..7de693d0773f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -108,6 +108,8 @@ struct netconsole_target {
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	struct config_group	group;
 	struct config_group userdata_group;
+	char userdata_complete[MAX_USERDATA_ENTRY_LENGTH * MAX_USERDATA_ITEMS];
+	size_t userdata_length;
 #endif
 	bool			enabled;
 	bool			extended;
@@ -637,10 +639,50 @@ static ssize_t userdatum_value_show(struct config_item *item, char *buf)
 	return sysfs_emit(buf, "%s\n", &(to_userdatum(item)->value[0]));
 }
 
+static void update_userdata(struct netconsole_target *nt)
+{
+	int complete_idx = 0, child_count = 0;
+	struct list_head *entry;
+	struct userdata *ud;
+
+	/* Clear the current string in case the last userdatum was deleted */
+	nt->userdata_length = 0;
+	nt->userdata_complete[0] = 0;
+
+	ud = to_userdata(&nt->userdata_group.cg_item);
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
@@ -653,6 +695,10 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	trim_newline(udm->value, sizeof(udm->value));
 
+	ud = to_userdata(item->ci_parent);
+	nt = userdata_to_target(ud);
+	update_userdata(nt);
+
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return count;
 out_unlock:
@@ -707,12 +753,27 @@ static struct config_item *userdatum_make_item(struct config_group *group,
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



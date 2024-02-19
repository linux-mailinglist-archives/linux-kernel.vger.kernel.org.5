Return-Path: <linux-kernel+bounces-71140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB4685A138
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A40F1C21B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDCA28DC8;
	Mon, 19 Feb 2024 10:43:01 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F96E572;
	Mon, 19 Feb 2024 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339381; cv=none; b=N5FHOgVSOuWj/Tsmg+0NebxBgmIepB2fGD1nkM9LDb575iehAYG35UGkAH/RvMn0rsCggNYjlCvqYV9Esy5Wj8YC9xKe/ve9K00Wpajl7DPxXTA3yH9eQEhbBQ7xHcpYkp+H5ruRx4U+6cS7hzXjCb8hl+K1IJJ49CxE+yL3iKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339381; c=relaxed/simple;
	bh=4CLsoaGfFVA/1zKd93F8iEE1yHiwZoq0zzwFSFK7zYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f9zranUPfnzXL5qJwMdDhBicfNP2f6Un9KoM7SFLbrcOXIVVlMb4y26D3pD6POSyyj+wrBCAwoeRdfENB97EAM4PHWz5WQLUeRgDT9n8AOdP0tJdIGUEHn8Hjgs+y495piVJzexxGHykGoLw+jzPhlLUkzEh7tap0kaEczfPmwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512a9ae6c02so1684628e87.2;
        Mon, 19 Feb 2024 02:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708339378; x=1708944178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqTzvsxoFQ547CowH/3MHXh9TCCgzaUG+3u9Ug3NEJc=;
        b=n6tVxBM4socclyoi1RLYOVMj7NFTm+dRyR3rxIBqxxH/Ys5wkPieJ9R2MfcnR06Ac+
         uX26bZ5zfWkLYXJjRIDbYq4Mwb2c+1+4NyOy8WZ2y6il1K9+tlYFeMkRlbr6oOOo1gIz
         bIPnpNWCeKD7sgfgMtWbl8aka/lGjMr4+W48ysFg41+3Qerb4O830NWMqpDP/N7Pzxth
         88S4gIxkqmdBYTi0f34i6mkxBkg9gpPd5szpqGXu+9PGjjrHPBF6Z/EO6/WL49J/M2Lk
         CwCPHGHKCZr6yHNAeTZrR6+znfDQDkOHvplGXIW0Az0sW3d8miYJ2lFaG+TAuZLcT4Bm
         MRzA==
X-Forwarded-Encrypted: i=1; AJvYcCVJO+V6ynY6mKYx/gvGovDl8TIwktX2ZxrNj6OCf5O2b4dX3nLwL3aG8IZ5cHiRlyx7J93JAW+GaJGygmA0E5B+wMTfnp6YIzi9RU0N
X-Gm-Message-State: AOJu0YwtlfXf3i7JaBHnaoRPhW84rVd+UMUbVb3CXyB9/5XN3SU0PDrs
	QjWmQdUrERGqXjXb34JHej62sFIZHdbpczfRgfQCVWsTTjHQtCXz
X-Google-Smtp-Source: AGHT+IG9+8s5JUxUwQV1K7/hMhfWZLtIGlS2U/M2BBaqhrmWWVstDp/HqVk5QXYnPqph9/EFGBw1yw==
X-Received: by 2002:a05:6512:318d:b0:512:a04a:52d6 with SMTP id i13-20020a056512318d00b00512a04a52d6mr4669250lfe.44.1708339377390;
        Mon, 19 Feb 2024 02:42:57 -0800 (PST)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id cq27-20020a056402221b00b005648b000e91sm478207edb.92.2024.02.19.02.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 02:42:57 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	stephen@networkplumber.org,
	f.fainelli@gmail.com,
	Johannes Berg <johannes.berg@intel.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH net-next v3] net: sysfs: Do not create sysfs for non BQL device
Date: Mon, 19 Feb 2024 02:42:36 -0800
Message-Id: <20240219104238.3782658-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Creation of sysfs entries is expensive, mainly for workloads that
constantly creates netdev and netns often.

Do not create BQL sysfs entries for devices that don't need,
basically those that do not have a real queue, i.e, devices that has
NETIF_F_LLTX and IFF_NO_QUEUE, such as `lo` interface.

This will remove the /sys/class/net/eth0/queues/tx-X/byte_queue_limits/
directory for these devices.

In the example below, eth0 has the `byte_queue_limits` directory but not
`lo`.

	# ls /sys/class/net/lo/queues/tx-0/
	traffic_class  tx_maxrate  tx_timeout  xps_cpus  xps_rxqs

	# ls /sys/class/net/eth0/queues/tx-0/byte_queue_limits/
	hold_time  inflight  limit  limit_max  limit_min

This also removes the #ifdefs, since we can also use netdev_uses_bql() to
check if the config is enabled. (as suggested by Jakub).

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog

v1:
 * https://lore.kernel.org/all/20240215112729.1778958-1-leitao@debian.org/
v2:
 * Removed the ifdefs by adding them inside the netdev_uses_bql(), as
   suggested by Jakub Kicinski.
v3:
 * Added an extra parenthesis between or (||) clauses as suggested by
   Stephen Hemminger

---
 net/core/net-sysfs.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 946caefdd959..e2a01b7b7992 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1459,6 +1459,9 @@ static const struct attribute_group dql_group = {
 	.name  = "byte_queue_limits",
 	.attrs  = dql_attrs,
 };
+#else
+/* Fake declaration, all the code using it should be dead */
+extern const struct attribute_group dql_group;
 #endif /* CONFIG_BQL */
 
 #ifdef CONFIG_XPS
@@ -1696,6 +1699,15 @@ static const struct kobj_type netdev_queue_ktype = {
 	.get_ownership = netdev_queue_get_ownership,
 };
 
+static bool netdev_uses_bql(const struct net_device *dev)
+{
+	if ((dev->features & NETIF_F_LLTX) ||
+	    (dev->priv_flags & IFF_NO_QUEUE))
+		return false;
+
+	return IS_ENABLED(CONFIG_BQL);
+}
+
 static int netdev_queue_add_kobject(struct net_device *dev, int index)
 {
 	struct netdev_queue *queue = dev->_tx + index;
@@ -1713,11 +1725,11 @@ static int netdev_queue_add_kobject(struct net_device *dev, int index)
 	if (error)
 		goto err;
 
-#ifdef CONFIG_BQL
-	error = sysfs_create_group(kobj, &dql_group);
-	if (error)
-		goto err;
-#endif
+	if (netdev_uses_bql(dev)) {
+		error = sysfs_create_group(kobj, &dql_group);
+		if (error)
+			goto err;
+	}
 
 	kobject_uevent(kobj, KOBJ_ADD);
 	return 0;
@@ -1738,9 +1750,9 @@ static int tx_queue_change_owner(struct net_device *ndev, int index,
 	if (error)
 		return error;
 
-#ifdef CONFIG_BQL
-	error = sysfs_group_change_owner(kobj, &dql_group, kuid, kgid);
-#endif
+	if (netdev_uses_bql(ndev))
+		error = sysfs_group_change_owner(kobj, &dql_group, kuid, kgid);
+
 	return error;
 }
 #endif /* CONFIG_SYSFS */
@@ -1772,9 +1784,10 @@ netdev_queue_update_kobjects(struct net_device *dev, int old_num, int new_num)
 
 		if (!refcount_read(&dev_net(dev)->ns.count))
 			queue->kobj.uevent_suppress = 1;
-#ifdef CONFIG_BQL
-		sysfs_remove_group(&queue->kobj, &dql_group);
-#endif
+
+		if (netdev_uses_bql(dev))
+			sysfs_remove_group(&queue->kobj, &dql_group);
+
 		kobject_put(&queue->kobj);
 	}
 
-- 
2.39.3



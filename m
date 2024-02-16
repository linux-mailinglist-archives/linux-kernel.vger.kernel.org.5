Return-Path: <linux-kernel+bounces-68348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D999857917
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6357F1F254B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1D61C295;
	Fri, 16 Feb 2024 09:42:21 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16EE1BC3C;
	Fri, 16 Feb 2024 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076541; cv=none; b=TFBz6ttQKvdfXgfst7tVBc9ozBVdEs+h2ZdaDSM756MltyG/3KhnK2G7kCWwgLqxtCNBw2xAnd8og3hqAzrhBkZQfdPBGjw99+hXIGxrfgz0NH0v0cd07vHz9pse0SV/+wsWEFsX6W19lfcNr+WcprdFIe67DK+aABr4eW8WsW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076541; c=relaxed/simple;
	bh=Q+JVFdprvh+ju0dZQZEF5lrVykjwRilx+UVW9MwZJ48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hsS2SPHJyRIVuW9lRr64OmKgAFnO+BjhvSiASrYhQfymQWeNrEvnnEeUS8QOVRBjTAHEnn0WKFvPpGJghQLbmwHgIL76upu5OPEhdfIY7LIxsDCtLpav1EPmvQsmdum+PyP5tmgb0A8mK1mCjA0hTlLS7XVUBOUbsyUY3EBAYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so639608a12.0;
        Fri, 16 Feb 2024 01:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708076537; x=1708681337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCgbvj1AZnKSg1pxMttRlFR5amX0BqXMrzHfMsSVV30=;
        b=gX/FcqYOxsXDz1tnbMkKEv8bOtfpkWDKWLhIGFBNyUcOMfSOc1hNyqsVqK/KcL8JRi
         0k+4+nT3gPyk5vdFBLsvbifnIMq2cwq/sJ0BPiPOMHJYKpVa1e2svx76A9oi9LgQcklB
         aTAmuD5Wj0RlXYJ+i6cVgwayYp3JxXhBhDkCGNEoIqloSU34fNQl5EAUfPeFu0UtmpL/
         6GvssS+h02YA25XgSHkMHRbTQcEoPuYGPMSM5xWofaewrdnj299UkEQc1jCwqc8N5nBC
         49dKvrz6vy/7i44X16NL0WrXu8pNBgyV5qfCOuSBkDEFVovwXxs53R+jWYgHKJzzuF7K
         aWwg==
X-Forwarded-Encrypted: i=1; AJvYcCWaF4JfM+5yOYgg997zwUe1f3m/F0vDU3vERYjJ4/GDriJkD4BBAi0mT/ge0jxivbHeMqzwCgiIkXR8ugOKDcc9J4bcESAedhv1fr/p
X-Gm-Message-State: AOJu0YwzxJs0DqcVxiIDaMXIkzCgSEaoIUbjNtk8nYw+bjV0ca15BHmq
	h5g/AfvLDkTWIdFTaFnRCtTlJsWi43DA/KtkN+LJi+iwKQicrAHC13k2oeha
X-Google-Smtp-Source: AGHT+IG/0effy0kOFKG/5drE9Apo+trse4QQ8Y+FLFMiiafHQNLF//2ZU2c4EzaxR1Wxwf5X4v9lAA==
X-Received: by 2002:a17:906:ccd9:b0:a3d:2b01:2187 with SMTP id ot25-20020a170906ccd900b00a3d2b012187mr3357841ejb.40.1708076536681;
        Fri, 16 Feb 2024 01:42:16 -0800 (PST)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id ti14-20020a170907c20e00b00a3d42c54e48sm1372189ejc.153.2024.02.16.01.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 01:42:16 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next v2] net: sysfs: Do not create sysfs for non BQL device
Date: Fri, 16 Feb 2024 01:41:52 -0800
Message-Id: <20240216094154.3263843-1-leitao@debian.org>
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
 net/core/net-sysfs.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 946caefdd959..af238026ac3c 100644
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
+	if (dev->features & NETIF_F_LLTX ||
+	    dev->priv_flags & IFF_NO_QUEUE)
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



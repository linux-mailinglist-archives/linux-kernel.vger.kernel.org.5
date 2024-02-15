Return-Path: <linux-kernel+bounces-66790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB2385618A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193B3291CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E831112B169;
	Thu, 15 Feb 2024 11:28:21 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C421612AADB;
	Thu, 15 Feb 2024 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996501; cv=none; b=XbzfzNm34l6qFzEOn9M5Wjnp2CJXiamcOnTrhBzP+x2EyNSwVJoYMMl70Z8GF1tYrSW9E3LR5i0y8rLL4v8+UMxcYoxG7HaqPK7oCf4vbIIlisJyXO569npS+AHcijzRIwJLkqJSZ1uSYCBmn4o2wdV8dwYIQ4Q/lncDo5ZUBXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996501; c=relaxed/simple;
	bh=Dp+Cq84Wj+5NY9LGhzGsuOIbQ+NVEu+tERFpSmpZ9PI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bx3MqfVcB3cuyoprteJ0c8fstmdiSvROFBK8wJaRhutS5URnC0WZtI4ZT1HzaJlo6WJgFtcWD8M+tORc2ZXy+HZZ/4HtC20jBt2d/q5q6WzxRGST79FhGcan/e/m4k7/UWANlPwKPorVdS4tSYluBb/BiLNzWmncDCRtMqXGMZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso436640a12.0;
        Thu, 15 Feb 2024 03:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707996498; x=1708601298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Y09j1ngc6D4JfQjGhKOAspK/YYGYWEbXTOGP8EVOtw=;
        b=OGL4QzOIv1+H2KjlM/e3aEDGxkgPn/8pZDIxwmEjU7SspwRICD6htjVHlWH/8T5siy
         55FZsB3DPAl1E07INN3IuOfUlgeUN9sL3IjU02hxyHpQIEffnEXKNoQjRWXqf0+U4jcB
         mV75lvbO4iriXwlzvqX/bVo4WfxzKqlGG0xYjFJ9m5ifQrxz61Qqkm/lFBFayowhBQVR
         td1sVSmZQ++zaF8QGGGoCGaXoz44qSr9lOJzVWl3rFs6suv49CB2eaFtZaH9S/P314d9
         QuoIKw3h0k1tJ+izfwbl3+nakOAiI5QH2l4T2+tJDI+tuEVRfqX6OQ7DgTfPgM7mj0yz
         K3lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYPZ3qfME41O0FIObKVrSL+D4mtVaCy1rKDrh6Parbcq5dUXnd2KqTNZO4n2FSWUp+eJv2tpS1uEAf+Y5TNUYGdsFaiznEtvG8VcKv
X-Gm-Message-State: AOJu0YxenkwZGGnrdwHAEV+pLL3uCcxrEI5fNHEXMfXM/sDLubHwHRUL
	vJtUliIADxmPLEgUpPEnptOr5grKpYFLbTekF4ozk7hF1N8q+1nV
X-Google-Smtp-Source: AGHT+IFxc9j7u/F7yTSPhZHhcGlpEerv1tdLMoPiI/44li++WR008GioEmenBxh1eqwSoa/t9Xj7+A==
X-Received: by 2002:a50:fb03:0:b0:55c:7b3b:5990 with SMTP id d3-20020a50fb03000000b0055c7b3b5990mr932623edq.7.1707996497835;
        Thu, 15 Feb 2024 03:28:17 -0800 (PST)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id eo14-20020a056402530e00b005621a9b09fbsm447312edb.41.2024.02.15.03.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 03:28:17 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>
Subject: [PATCH net-next] net: sysfs: Do not create sysfs for non BQL device
Date: Thu, 15 Feb 2024 03:27:27 -0800
Message-Id: <20240215112729.1778958-1-leitao@debian.org>
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

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/net-sysfs.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index a09d507c5b03..c79bc11a0347 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1417,6 +1417,15 @@ static ssize_t bql_show_inflight(struct netdev_queue *queue,
 	return sysfs_emit(buf, "%u\n", dql->num_queued - dql->num_completed);
 }
 
+static bool netdev_uses_bql(struct net_device *dev)
+{
+	if (dev->features & NETIF_F_LLTX ||
+	    dev->priv_flags & IFF_NO_QUEUE)
+		return false;
+
+	return true;
+}
+
 static struct netdev_queue_attribute bql_inflight_attribute __ro_after_init =
 	__ATTR(inflight, 0444, bql_show_inflight, NULL);
 
@@ -1709,9 +1718,11 @@ static int netdev_queue_add_kobject(struct net_device *dev, int index)
 		goto err;
 
 #ifdef CONFIG_BQL
-	error = sysfs_create_group(kobj, &dql_group);
-	if (error)
-		goto err;
+	if (netdev_uses_bql(dev)) {
+		error = sysfs_create_group(kobj, &dql_group);
+		if (error)
+			goto err;
+	}
 #endif
 
 	kobject_uevent(kobj, KOBJ_ADD);
@@ -1734,7 +1745,8 @@ static int tx_queue_change_owner(struct net_device *ndev, int index,
 		return error;
 
 #ifdef CONFIG_BQL
-	error = sysfs_group_change_owner(kobj, &dql_group, kuid, kgid);
+	if (netdev_uses_bql(ndev))
+		error = sysfs_group_change_owner(kobj, &dql_group, kuid, kgid);
 #endif
 	return error;
 }
@@ -1768,7 +1780,8 @@ netdev_queue_update_kobjects(struct net_device *dev, int old_num, int new_num)
 		if (!refcount_read(&dev_net(dev)->ns.count))
 			queue->kobj.uevent_suppress = 1;
 #ifdef CONFIG_BQL
-		sysfs_remove_group(&queue->kobj, &dql_group);
+		if (netdev_uses_bql(dev))
+			sysfs_remove_group(&queue->kobj, &dql_group);
 #endif
 		kobject_put(&queue->kobj);
 	}
-- 
2.39.3



Return-Path: <linux-kernel+bounces-65358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BD1854BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E08283635
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707705B1FC;
	Wed, 14 Feb 2024 14:45:44 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A135A4E1;
	Wed, 14 Feb 2024 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921943; cv=none; b=enCGne/tkc2of/ljsgx2h/pvRuox+MYi0oajJC3vxSXQu4sTbVCyxUasgyQd7QPjJkNTH5sUL9e970itWIEjw6Qfjj2Hb0djOGG2mfpxy/dxLNmv5Atd9GooFeF4MSU9fWCX7gxvBgVVVCCbDX4xRAdwKoswRt736crkq1nVaOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921943; c=relaxed/simple;
	bh=8MyxQT7/gBC6vuc7ry6wUblncxJirCttHsUs/0lAXNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L33E2wWnQ/uPhEXfRLsCeThtr2Dn/heBBMjqiExOIsgpQmwh0ZwObnTO1O3njUnTPVDB8HN+x/9s/HUaI+t4awZRQ/iK2npp804p81CKeRt7Nw7fEfwwyBDdGARL6X5ZQDzd3Wxpt1yxDIDhjKX47UCoAyNt/mHwUEI3xlreKxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a293f2280c7so787988366b.1;
        Wed, 14 Feb 2024 06:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707921940; x=1708526740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhd2wrMWsy/2+hyUeyTKyzA2QO1XJBxjRCV0ZhF1M4A=;
        b=peOcILwPoKJM+IdjLnNqXZ7jGfgeHc4JjDy1PfTGafZRU0aAoZRcoxUKWH34UAtK7X
         uqQkE4PmW6PDskDWfg07mryp0Jj1GYG5yHgxK7xjNkthNrgp2PcbflUDPo7q9/YPPcg0
         PrNM35p9d6yJtn3KXph6bgCbF5NuK5TTjs/TdyjIDULxTmsCYYz0D/59FthfViy1itdM
         hziZLI781LsG3DDNUdt0jJvDtLpMX7I0RRvnbWN+gVgPgNLYzuyJfHAvSA7UiXh+mKeP
         05W1zF6Q5IhF2GvZbyqtXn7TOKnflsA6e+40iRp5JuW0g7cpK/pZyeSb2R4KV3nceb3c
         FqXg==
X-Forwarded-Encrypted: i=1; AJvYcCXxCxc+zUtEnRB+Bs6tonpcBoPgG6KD51CieUTRyW2nAXovfDSYkmxf5Qc1qLVoo2lrGIIDZwiOtznbkdeMfy5wTRoN5SFWPfCYRKrxAY/bar9/saYAtj6Vuc20AQ2hbBdz8F5XIFmXoKxWAjSMsIqDTtxroa4WL2BwKd+Vi3drAnfkLnTxQeEx
X-Gm-Message-State: AOJu0YxpKVd6N8NkR2puNUUuhZEp7d9ZAWms8JCr4+aW9hE8cuDARcdb
	aosXubM7DnGC38rKdMmeoePKG7dJwFhJ2Y7ccveEu0nGDvKDUJh6
X-Google-Smtp-Source: AGHT+IElnGmGnTSC+OXTn2OYMpnhKwSyaIIjRsWcfzpIJQ0aMjD+Tu9o9gmBlBhtEGPZXoLMr7XXQw==
X-Received: by 2002:a17:906:6c9a:b0:a3d:1f59:7412 with SMTP id s26-20020a1709066c9a00b00a3d1f597412mr2427327ejr.72.1707921939927;
        Wed, 14 Feb 2024 06:45:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTsXHkq5jVto/WnQvCEgK7kD9VAQVdHZunDPtDhbAJSGpzLFwVmZ9VDC77j/5TOC1gTxmooMzpk8d2VIJlJlEj1Z0moiaBCtCwxscWRWaMfp8aaGf6jiBKSyvVcfOI7mofUoeaIcOZ1sqxDuFmN6usNYCpO2Fd9e6I/ACx4QMjx58h8cyMvKR88OwjLrisXlTr27uuUwFgcd9gXjKH2aWWdSZUVwCWaBvqCuXmq3loFgjzLMQxezhArspue6enbEsZts3LYOyEUTgMvsxzONiza0VMz3k3+KrxN+mNH9WZ34yc08f6Hlhr5v5E/QexC3Q4QDM92nd/jXYispbFV6YSOfBLNG81rvd/73Qj30ecnUngxM50b00K700jZizwwR0A39y4oiJ0ln5ltdCecSHh+2l1BzZp74uSgLc6lXBnoyTy2xH0a3ifYRDg0TJIf24LgYmyKOIbPj57gGaEc0SAnnKIXTtfZGRx9WCKfQXqMrnbv6dM9EOcKDMNas8h4zvJwe7eMzwvYLQtBZeM7lsTBZ3WQzF5XLHwbpMc7RMJp4OcsZRh
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id rg8-20020a1709076b8800b00a3d2f55bc2esm955212ejc.161.2024.02.14.06.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 06:45:39 -0800 (PST)
Date: Wed, 14 Feb 2024 06:45:36 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, edumazet@google.com
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
	pabeni@redhat.com, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>, weiwan@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: dqs: add NIC stall detector based on BQL
Message-ID: <ZczSEBFtq6E6APUJ@gmail.com>
References: <20240202165315.2506384-1-leitao@debian.org>
 <CANn89iLWWDjp71R7zttfTcEvZEdmcA1qo47oXkAX5DuciYvOtQ@mail.gmail.com>
 <20240213100457.6648a8e0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213100457.6648a8e0@kernel.org>

On Tue, Feb 13, 2024 at 10:04:57AM -0800, Jakub Kicinski wrote:
> On Tue, 13 Feb 2024 14:57:49 +0100 Eric Dumazet wrote:
> > Please note that adding other sysfs entries is expensive for workloads
> > creating/deleting netdev and netns often.
> > 
> > I _think_ we should find a way for not creating
> > /sys/class/net/<interface>/queues/tx-{Q}/byte_queue_limits  directory
> > and files
> > for non BQL enabled devices (like loopback !)
> 
> We should try, see if anyone screams. We could use IFF_NO_QUEUE, and
> NETIF_F_LLTX as a proxy for "device doesn't have a real queue so BQL 
> would be pointless"? Obviously better to annotate the drivers which
> do have BQL support, but there's >50 of them on a quick count..

Let me make sure I understand the suggestion above. We want to disable
BQL completely for devices that has dev->features & NETIF_F_LLTX or
dev->priv_flags & IFF_NO_QUEUE, right?

Maybe we can add a ->enabled field in struct dql, and set it according
to the features above. Then we can created the sysfs and process the dql
operations based on that field. This should avoid some unnecessary calls
also, if we are not display sysfs.

Here is a very simple PoC to represent what I had in mind. Am I in the
right direction?

diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic_queue_limits.h
index 407c2f281b64..a9d17597ea80 100644
--- a/include/linux/dynamic_queue_limits.h
+++ b/include/linux/dynamic_queue_limits.h
@@ -62,6 +62,7 @@ struct dql {
 	unsigned int	max_limit;		/* Max limit */
 	unsigned int	min_limit;		/* Minimum limit */
 	unsigned int	slack_hold_time;	/* Time to measure slack */
+	bool		enabled;		/* Queue is active */
 };
 
 /* Set some static maximums */
@@ -101,7 +102,7 @@ void dql_completed(struct dql *dql, unsigned int count);
 void dql_reset(struct dql *dql);
 
 /* Initialize dql state */
-void dql_init(struct dql *dql, unsigned int hold_time);
+void dql_init(struct net_device *dev, struct dql *dql, unsigned int hold_time);
 
 #endif /* _KERNEL_ */
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ef7bfbb98497..5c69bbf4267d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3541,6 +3541,9 @@ static inline void netdev_tx_sent_queue(struct netdev_queue *dev_queue,
 					unsigned int bytes)
 {
 #ifdef CONFIG_BQL
+	if (!dev_queue->dql.enabled)
+		return
+
 	dql_queued(&dev_queue->dql, bytes);
 
 	if (likely(dql_avail(&dev_queue->dql) >= 0))
@@ -3573,7 +3576,8 @@ static inline bool __netdev_tx_sent_queue(struct netdev_queue *dev_queue,
 {
 	if (xmit_more) {
 #ifdef CONFIG_BQL
-		dql_queued(&dev_queue->dql, bytes);
+		if (dev_queue->dql.enabled)
+			dql_queued(&dev_queue->dql, bytes);
 #endif
 		return netif_tx_queue_stopped(dev_queue);
 	}
@@ -3617,7 +3621,7 @@ static inline void netdev_tx_completed_queue(struct netdev_queue *dev_queue,
 					     unsigned int pkts, unsigned int bytes)
 {
 #ifdef CONFIG_BQL
-	if (unlikely(!bytes))
+	if (unlikely(!bytes) || !dev_queue->dql.enabled)
 		return;
 
 	dql_completed(&dev_queue->dql, bytes);
@@ -3656,6 +3660,9 @@ static inline void netdev_completed_queue(struct net_device *dev,
 static inline void netdev_tx_reset_queue(struct netdev_queue *q)
 {
 #ifdef CONFIG_BQL
+	if (!q->dql.enabled)
+		return;
+
 	clear_bit(__QUEUE_STATE_STACK_XOFF, &q->state);
 	dql_reset(&q->dql);
 #endif
diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index fde0aa244148..0a0a51f06c3b 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -10,6 +10,7 @@
 #include <linux/dynamic_queue_limits.h>
 #include <linux/compiler.h>
 #include <linux/export.h>
+#include <linux/netdevice.h>
 
 #define POSDIFF(A, B) ((int)((A) - (B)) > 0 ? (A) - (B) : 0)
 #define AFTER_EQ(A, B) ((int)((A) - (B)) >= 0)
@@ -128,11 +129,21 @@ void dql_reset(struct dql *dql)
 }
 EXPORT_SYMBOL(dql_reset);
 
-void dql_init(struct dql *dql, unsigned int hold_time)
+static bool netdev_dql_supported(struct net_device *dev)
+{
+	if (dev->features & NETIF_F_LLTX ||
+	    dev->priv_flags & IFF_NO_QUEUE)
+		return false;
+
+	return true;
+}
+
+void dql_init(struct net_device *dev, struct dql *dql, unsigned int hold_time)
 {
 	dql->max_limit = DQL_MAX_LIMIT;
 	dql->min_limit = 0;
 	dql->slack_hold_time = hold_time;
 	dql_reset(dql);
+	dql->enabled = netdev_dql_supported(dev);
 }
 EXPORT_SYMBOL(dql_init);
diff --git a/net/core/dev.c b/net/core/dev.c
index 9bb792cecc16..76aa70ee2c87 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10052,7 +10052,7 @@ static void netdev_init_one_queue(struct net_device *dev,
 	netdev_queue_numa_node_write(queue, NUMA_NO_NODE);
 	queue->dev = dev;
 #ifdef CONFIG_BQL
-	dql_init(&queue->dql, HZ);
+	dql_init(dev, &queue->dql, HZ);
 #endif
 }
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index a09d507c5b03..144ce4bb57bc 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1709,9 +1709,11 @@ static int netdev_queue_add_kobject(struct net_device *dev, int index)
 		goto err;
 
 #ifdef CONFIG_BQL
-	error = sysfs_create_group(kobj, &dql_group);
-	if (error)
-		goto err;
+	if (queue->dql.enabled) {
+		error = sysfs_create_group(kobj, &dql_group);
+		if (error)
+			goto err;
+	}
 #endif
 
 	kobject_uevent(kobj, KOBJ_ADD);


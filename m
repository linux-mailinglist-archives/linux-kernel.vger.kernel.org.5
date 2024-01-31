Return-Path: <linux-kernel+bounces-46223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D364843C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212151C24E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9462D80C1A;
	Wed, 31 Jan 2024 10:22:06 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401E0762C3;
	Wed, 31 Jan 2024 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696526; cv=none; b=nYeQcZi+vsp3qc2t6eDzxTOYux0h6+TAK2hJMQ1yppEBLhbwZdhD9r5fCiPfAwEqa8voKimplD08x0b7ox5K+nz+O4FKDBm+TOzKBZEA5fNaoCzvqRH+bJR95+3VERRWJ4rxonhcP+quSXWUmka+9wYx8dXmutphG5Ga6kmxHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696526; c=relaxed/simple;
	bh=Ew3jG/iqdLrRFnqrV7+TDchfiZaOrt/C9SUF3rcAj1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fg3bbykBx2fh/D4qSplcnH2sSKzhgngg2KfUMrJD72vxrsF6pkJKnr4pr6BE8WQ0juqW07YEtaklH9RjZDjnDFVbDLQTEyD/YjdFZfsXFjR9NvYZiDpgw9sZ7IkFQtccGwwWdi9mB95hLF53qTi60UNh3lAMVeimw81p+ckh6+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d057b6df2aso23783821fa.3;
        Wed, 31 Jan 2024 02:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706696522; x=1707301322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzz8XfgMT6sJFwrMg84o7ZbqmGEnX1hEApi1gdyPgqI=;
        b=wodxfXvSsuJaaSUn52h9Seoq7I27FCy2E7UGvol8YViRSk++EXKay/ooOCaM/mhgaS
         yrOij6nkOjAk3UM4rAkzTw7qPW8uV0/X4qbCsLTQgP3vKY3c+SG82XV+T15ZXYkWr+bs
         0Z2xAnLi7OmTrJwI6X6NOqkjVf1KuDm7LR7mT+wPD6t2asKrmupuBZmjUvgNMQiv6I92
         Egnhvjuzl29oDd4y5Lc1UdLHoC7+r7nGtapd25egWgVOeD0PWmA/LPmq9RWz4AeYcyfE
         5BtEhA7sW9xNlJ2dEyX2kr4U+DVi2qlpoCzhfci6Glq3sQsq/m2SJ34MmsC3oN8EzXJA
         kKCQ==
X-Gm-Message-State: AOJu0YzPgGpSA3Gi4Yoo54xSJ9JxdBa4ZOW901pI55/YJn7mvFgXqi//
	74+ho3e3iHjHKSo/0b6tIA6FuHUcBrXtYAOrLrK2iwOSZNjheJ3J
X-Google-Smtp-Source: AGHT+IGLJnPF79NwqQqwRXGgWQ/zUEECK2Qh/BDgCMJ5mHWScDQYsl5t7RNpOfZ7+OI03tArUNLnRA==
X-Received: by 2002:a2e:be28:0:b0:2d0:5a6c:7095 with SMTP id z40-20020a2ebe28000000b002d05a6c7095mr1006031ljq.35.1706696521851;
        Wed, 31 Jan 2024 02:22:01 -0800 (PST)
Received: from localhost (fwdproxy-cln-002.fbsv.net. [2a03:2880:31ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id q11-20020a5085cb000000b0055d15d938e6sm5596917edh.11.2024.01.31.02.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 02:22:01 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net v2 1/2] net: sysfs: Fix /sys/class/net/<iface> path
Date: Wed, 31 Jan 2024 02:21:49 -0800
Message-Id: <20240131102150.728960-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131102150.728960-1-leitao@debian.org>
References: <20240131102150.728960-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation is pointing to the wrong path for the interface.
Documentation is pointing to /sys/class/<iface>, instead of
/sys/class/net/<iface>.

Fix it by adding the `net/` directory before the interface.

Fixes: 1a02ef76acfa ("net: sysfs: add documentation entries for /sys/class/<iface>/queues")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../ABI/testing/sysfs-class-net-queues        | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net-queues b/Documentation/ABI/testing/sysfs-class-net-queues
index 906ff3ca928a..5bff64d256c2 100644
--- a/Documentation/ABI/testing/sysfs-class-net-queues
+++ b/Documentation/ABI/testing/sysfs-class-net-queues
@@ -1,4 +1,4 @@
-What:		/sys/class/<iface>/queues/rx-<queue>/rps_cpus
+What:		/sys/class/net/<iface>/queues/rx-<queue>/rps_cpus
 Date:		March 2010
 KernelVersion:	2.6.35
 Contact:	netdev@vger.kernel.org
@@ -8,7 +8,7 @@ Description:
 		network device queue. Possible values depend on the number
 		of available CPU(s) in the system.
 
-What:		/sys/class/<iface>/queues/rx-<queue>/rps_flow_cnt
+What:		/sys/class/net/<iface>/queues/rx-<queue>/rps_flow_cnt
 Date:		April 2010
 KernelVersion:	2.6.35
 Contact:	netdev@vger.kernel.org
@@ -16,7 +16,7 @@ Description:
 		Number of Receive Packet Steering flows being currently
 		processed by this particular network device receive queue.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/tx_timeout
+What:		/sys/class/net/<iface>/queues/tx-<queue>/tx_timeout
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -24,7 +24,7 @@ Description:
 		Indicates the number of transmit timeout events seen by this
 		network interface transmit queue.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/tx_maxrate
+What:		/sys/class/net/<iface>/queues/tx-<queue>/tx_maxrate
 Date:		March 2015
 KernelVersion:	4.1
 Contact:	netdev@vger.kernel.org
@@ -32,7 +32,7 @@ Description:
 		A Mbps max-rate set for the queue, a value of zero means disabled,
 		default is disabled.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/xps_cpus
+What:		/sys/class/net/<iface>/queues/tx-<queue>/xps_cpus
 Date:		November 2010
 KernelVersion:	2.6.38
 Contact:	netdev@vger.kernel.org
@@ -42,7 +42,7 @@ Description:
 		network device transmit queue. Possible values depend on the
 		number of available CPU(s) in the system.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/xps_rxqs
+What:		/sys/class/net/<iface>/queues/tx-<queue>/xps_rxqs
 Date:		June 2018
 KernelVersion:	4.18.0
 Contact:	netdev@vger.kernel.org
@@ -53,7 +53,7 @@ Description:
 		number of available receive queue(s) in the network device.
 		Default is disabled.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/hold_time
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/hold_time
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -62,7 +62,7 @@ Description:
 		of this particular network device transmit queue.
 		Default value is 1000.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/inflight
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/inflight
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -70,7 +70,7 @@ Description:
 		Indicates the number of bytes (objects) in flight on this
 		network device transmit queue.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/limit
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/limit
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -79,7 +79,7 @@ Description:
 		on this network device transmit queue. This value is clamped
 		to be within the bounds defined by limit_max and limit_min.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/limit_max
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/limit_max
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -88,7 +88,7 @@ Description:
 		queued on this network device transmit queue. See
 		include/linux/dynamic_queue_limits.h for the default value.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/limit_min
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/limit_min
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
-- 
2.34.1



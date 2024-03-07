Return-Path: <linux-kernel+bounces-95916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D248754EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246781F226C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF58130AD4;
	Thu,  7 Mar 2024 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL8Ctdtb"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B06F12D76A;
	Thu,  7 Mar 2024 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831560; cv=none; b=sb5RhrAkm8N2jYe1+/5KTx8MZpu1ecN+ABQld/prhcks0DozvTGPCNPRkdMo9QbphtVK8BR0OLpBpB/y5rSKN2z9SThlcJh06fmqqf3FLNuP1nPptM7twYuIzn3QHDvfRa4Drdp+tjDXyEw0QXFSSC488ZL/r25XuIQxDkJWDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831560; c=relaxed/simple;
	bh=lCKJCUOcpbJTmq6sx8VjS8e0okUIYSDK6ln/IsdnKII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xg9ZoGuiVvYxG9Bw3c1wvKzwtWhMPn0XOLHcx1WeLzBDWra9K1yiZbNOb9hfYpBjfIouF6YFxZUq0V9Bp2WTxaO6IXzXkhmmI/8zlhB1oBf6paADXnWyON4u7NcQFOT9Xv1OBLS5QktM+YtwgQjlJMOq6PvWTEqw+PVzJCn4ywQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL8Ctdtb; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-33e4f15710aso805176f8f.2;
        Thu, 07 Mar 2024 09:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709831557; x=1710436357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFWiokd+Aeip8+3Uvj28qY6fTKJ7gDMOKVvzVxfPJGo=;
        b=RL8CtdtbEoyTUlg+RS3mxKI2cg4J5phqprW4mygTv7ijl9F3trNirHrvE5REK47wmP
         elbs3Zp5PW9i5V0QKfD0HhdrKOo3Qtrl0K1ZIx96IUAg0RdWbq9aifk47ZCqjAwSYSQ+
         rHOCtcxlvUYtM+VQHOozn6ac918ckWI0wY+A9p2JeO9snRsT/APsxfjWxlKQolGHcvs1
         U9LYDjqHHXfpH7px+wz0fUchZjZKqGxGVjRRIEeUqX0x+t4LpWeC2w2TumkW5za2QhMG
         deS2VWbX7jqJHPVfJJIMuCfe+8dlCcRQqsYyPsFVpE0Wb0qsLunN4N1lLaXXu138cFwQ
         aQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709831557; x=1710436357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFWiokd+Aeip8+3Uvj28qY6fTKJ7gDMOKVvzVxfPJGo=;
        b=W2twAm2hm17O1seJBGnRX2Us7MDSwUNkYEr8t3oEA2So9YP5K0ANGcXYCMrPvCJUEw
         lxrYKbJ9LIFVxSK+V7yVX/EXRDgt1VmKfa4YW1hgPiH3xhioKFkXB82zv7pvL0o0jMWS
         paIW7/4infwTkmsZuRRBI4nNxSm3009GomXaEtz7DkhXXG2W7Tl842ROKE+u7QOj2SYV
         CBCIUxngNVpi/KxZWgLj2YPhAOSpWvtQtd42HnykmK2AAMzGndaZmGgA4O06zd2CaO0x
         oAppRZQBFqAd95L0LUra01MM7IK4tD58ssXS2wI2C7tXzEU4bTwn+uQyXXqGaJQ0wlyP
         Rfww==
X-Forwarded-Encrypted: i=1; AJvYcCVuospOh/YNPh5qYpcjsB4Y9gqTA/9p87oUrEEJX3KshQfMh/85EkLSyw10V/kPIhGC6QHTPHgn4KdQgIDzvIfZmJMd83p6ylK4LQAl
X-Gm-Message-State: AOJu0YzaYXDe4dKpqL8ewsuFM5VG9sqVIkpLkqaj6C+/CFzYu0+BEpbo
	hsW5QDlK5wrTtGtWKz3KY2gHrVJZEhhcA7H5zus3dHZyIPoTnoia+a7mLGL5vCI=
X-Google-Smtp-Source: AGHT+IGvzB/nXqfowb7C03hBnN9p6TFqvJDm1Fyq2y+mxHs8jaFgD9GEeCK2+2WZRb7mlGKBRusF5w==
X-Received: by 2002:a5d:58f0:0:b0:33e:6aee:6b56 with SMTP id f16-20020a5d58f0000000b0033e6aee6b56mr1198605wrd.25.1709831557093;
        Thu, 07 Mar 2024 09:12:37 -0800 (PST)
Received: from localhost ([45.130.85.5])
        by smtp.gmail.com with ESMTPSA id dp14-20020a0560000c8e00b0033d8ce120f2sm20734678wrb.95.2024.03.07.09.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 09:12:36 -0800 (PST)
From: Leone Fernando <leone4fernando@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leone Fernando <leone4fernando@gmail.com>
Subject: [PATCH net-next 0/4] net: route: improve route hinting
Date: Thu,  7 Mar 2024 18:11:58 +0100
Message-Id: <20240307171202.232684-1-leone4fernando@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 2017, Paolo Abeni introduced the hinting mechanism [1] to the routing
sub-system. The hinting optimization improves performance by reusing
previously found dsts instead of looking them up for each skb.

This patch series introduces a generalized version of the hinting mechanism that
can "remember" a larger number of dsts. This reduces the number of dst
lookups for frequently encountered daddrs.

Before diving into the code and the benchmarking results, it's important
to address the deletion of the old route cache [2] and why
this solution is different. The original cache was complicated,
vulnerable to DOS attacks and had unstable performance.

The new input dst_cache is much simpler thanks to its lazy approach,
improving performance without the overhead of the removed cache
implementation. Instead of using timers and GC, the deletion of invalid
entries is performed lazily during their lookups.
The dsts are stored in a simple, lightweight, static hash table. This
keeps the lookup times fast yet stable, preventing DOS upon cache misses.
The new input dst_cache implementation is built over the existing
dst_cache code which supplies a fast lockless percpu behavior.

I tested this patch using udp floods with different number of daddrs.
The benchmarking setup is comprised of 3 machines: a sender,
a forwarder and a receiver. I measured the PPS received by the receiver
as the forwarder was running either the mainline kernel or the patched
kernel, comparing the results. The dst_cache I tested in this benchmark
used a total of 512 hash table entries, split into buckets of 4
entries each.

These are the results:
  UDP             mainline              patched                   delta
conns pcpu         Kpps                  Kpps                       %
   1              274.0255              269.2205                  -1.75
   2              257.3748              268.0947                   4.17
  15              241.3513              258.8016                   7.23
 100              238.3419              258.4939                   8.46
 500              238.5390              252.6425                   5.91
1000              238.7570              242.1820                   1.43
2000              238.7780              236.2640                  -1.05
4000              239.0440              233.5320                  -2.31
8000              239.3248              232.5680                  -2.82

As you can see, this patch improves performance up until ~1500
connections, after which the rate of improvement diminishes
due to the growing number of cache misses.
It's important to note that in the worst scenario, every packet will
cause a cache miss, resulting in only a constant performance degradation
due to the fixed cache and bucket sizes. This means that the cache is
resistant to DOS attacks.

Based on the above measurements, it seems that the performance
degradation flattens at around 3%. Note that the number of concurrent
connections at which performance starts to degrade depends on the cache
size and the amount of cpus.

[1] https://lore.kernel.org/netdev/cover.1574252982.git.pabeni@redhat.com/
[2] https://lore.kernel.org/netdev/20120720.142502.1144557295933737451.davem@davemloft.net/

v1:
- fix typo while allocating per-cpu cache
- while using dst from the dst_cache set IPSKB_DOREDIRECT correctly
- always compile dst_cache

RFC-v2:
- remove unnecessary macro
- move inline to .h file

RFC-v1: https://lore.kernel.org/netdev/d951b371-4138-4bda-a1c5-7606a28c81f0@gmail.com/
RFC-v2: https://lore.kernel.org/netdev/3a17c86d-08a5-46d2-8622-abc13d4a411e@gmail.com/

Leone Fernando (4):
  net: route: expire rt if the dst it holds is expired
  net: dst_cache: add input_dst_cache API
  net: route: always compile dst_cache
  net: route: replace route hints with input_dst_cache

 drivers/net/Kconfig        |   1 -
 include/net/dst_cache.h    |  68 +++++++++++++++++++
 include/net/dst_metadata.h |   2 -
 include/net/ip_tunnels.h   |   2 -
 include/net/route.h        |   6 +-
 net/Kconfig                |   4 --
 net/core/Makefile          |   3 +-
 net/core/dst.c             |   4 --
 net/core/dst_cache.c       | 132 +++++++++++++++++++++++++++++++++++++
 net/ipv4/Kconfig           |   1 -
 net/ipv4/ip_input.c        |  58 ++++++++--------
 net/ipv4/ip_tunnel_core.c  |   4 --
 net/ipv4/route.c           |  75 +++++++++++++++------
 net/ipv4/udp_tunnel_core.c |   4 --
 net/ipv6/Kconfig           |   4 --
 net/ipv6/ip6_udp_tunnel.c  |   4 --
 net/netfilter/nft_tunnel.c |   2 -
 net/openvswitch/Kconfig    |   1 -
 net/sched/act_tunnel_key.c |   2 -
 19 files changed, 291 insertions(+), 86 deletions(-)

-- 
2.34.1



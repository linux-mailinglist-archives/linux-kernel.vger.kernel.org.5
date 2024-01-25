Return-Path: <linux-kernel+bounces-38621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BCD83C34D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815D928E43C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442E14F8A6;
	Thu, 25 Jan 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRy5tBHZ"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D3E4F215;
	Thu, 25 Jan 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188103; cv=none; b=H24jVoWVtu33kd2+QkN54Hx1YI0MiBUTJgwdj03rtQRo/TNJ83gP/YQ2mMgWWLxZW2Ltj/0+5u9oQP0QcqzhxZMXvijU1L5trvkEN4hZ4YuBTYHUizW5iYockypdusNC44rR4gOb9rCqqfqt8WBuoVzCswJymx0Sh+XjpTHZfxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188103; c=relaxed/simple;
	bh=SBAjvuCBFX1gEnRqXB6WXsQzS0bDOcTaJIK3LPI6hT4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=pv2pTID0ed1BYVDNeNDNP6BL2by84C1Snl+RWtO4ADVMr/1Ctxrxs/PhAaN7QV4hgNcEdvfB2f9rnwZ0Ys5qY1XQfoWz+57o8bF5BUsJWwQzeehBHWVTiAiLGnovOv/0KcAG8xduLq56W9/a567Py2ciqqMdwVex2/bnej/VLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRy5tBHZ; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-40ec6a002a7so20079475e9.2;
        Thu, 25 Jan 2024 05:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706188100; x=1706792900; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:content-language
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwMGPXHaS66rqKl/ABOtczpl+lVxCwfsnqhmIIw26GY=;
        b=kRy5tBHZM+Ojoqv/kAN14AgMRDRTViowIhk8xJMD86XZAQsgU2rRX1jEomn5+w0uNc
         CzsuTJ5zUc8CB1PWVXjpX2z1PE5hhDVgc7rY6PXZGec3wnYGpt3BLe62Rc7yrWjc195U
         p2BVK/mQ71Y0AE0vSA9QrwTjM6iPn6Wf2khZDhoB2yKrfJBcECFqP03nlZxO8Ee+Q9QW
         Jdv/WsuJ1nipPycYY6XtZUDeDdmayuTEWlFvMevp0/oAC98C9+6wR3bwTR6leKm3hEE3
         jDPYNrx63goopLpXM7ffoRFkmczc6dkcAxhcrIAlxMDf2df2aW4phr7DCAuvJhDb5ae8
         4Vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706188100; x=1706792900;
        h=content-transfer-encoding:to:subject:from:content-language
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mwMGPXHaS66rqKl/ABOtczpl+lVxCwfsnqhmIIw26GY=;
        b=a7US8KjENQStjq/vkFrkZVbVz5lolw+qtMo+Y1nNt9Sac2OOEzxGsQ+XFZb/SH+sc2
         lqxgxMif+qfgIOmsUak2RAxntI5l4QER2p5cK537BbiuUlOv6E9iL9HXCNk/UpVLq3dH
         2z835cQgOxfea76RYIXMju1qg1N/C3hG3vM3QqdkQl5Iic6L1t1Gv6Lxo1t2Ew75AYC9
         7mF571VmkL9csX6xt5AErYVcALYoWIjozjWePO0SAKMumyfmwga48CVu9ZDwGZUL4zQo
         Q8QP0yZWq+bIN+8+Dcq6zAR1w1A9Qhmr579HHlFogNSZT+tSjMxHrApFvnaqwVcUWmSc
         G+7A==
X-Gm-Message-State: AOJu0YwCWSsg0BeWEwKzg6/wrDhVMAA2QE60u+vdCgxVA1n6yTk65dpc
	ywUsz6ORXp0WZ34VjlGVBfYmkgxLGTyDdtXyslw/A3JcSpOzlpr8
X-Google-Smtp-Source: AGHT+IEHnTDwlPB9C8p5jIGnJiX6+k7pwlthItwh4JoOfAIwLjdOC9Yhtr6wUM3gTyfBvs23Z6KTIw==
X-Received: by 2002:a05:600c:19c8:b0:40d:5aa6:91 with SMTP id u8-20020a05600c19c800b0040d5aa60091mr292081wmq.127.1706188099734;
        Thu, 25 Jan 2024 05:08:19 -0800 (PST)
Received: from localhost ([45.130.85.2])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b0040ea94d2250sm2594503wms.8.2024.01.25.05.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 05:08:19 -0800 (PST)
Message-ID: <d951b371-4138-4bda-a1c5-7606a28c81f0@gmail.com>
Date: Thu, 25 Jan 2024 14:08:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
From: Leone Fernando <leone4fernando@gmail.com>
Subject: [RFC PATCH net-next v1 0/3] net: route: improve route hinting
To: dennis@kernel.org, tj@kernel.org, cl@linux.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In 2017, Paolo Abeni introduced the hinting mechanism [1] to the routing
sub-system. The hinting optimization improves performance by reusing
previously found dsts instead of looking them up for each skb.

This RFC introduces a generalized version of the hinting mechanism that
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
I also plan to add a sysctl setting to provide finer tuning of the
cache size when needed (not implemented in this RFC).

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

I would love to get your opinion on the following:
    - What would be a good default size for the cache? This depends on
      the number of daddrs the machine is expected to handle. Which kind
      of setup should we optimize for?

    - A possible improvement for machines that are expected to handle a
      large number of daddrs is to turn off the cache after a threshold
      of cache misses has been reached. The cache can then be turned on
      again after some period of time.

Do you have any other ideas or suggestions?

Another problem I encountered is that if an skb finds its dst in the
dst_cache, it doesn't update its skb->flags during the routing process,
e.g., IPSKB_NOPOLICY and IPSKB_DOREDIRECT.
This can be fixed by moving the IPSKB_DOREDIRECT update to ip_forward.
The IPSKB_NOPOLICY flag is set in mkroute_input, local_input and
multicast, so maybe we can just move this logic to the end
of ip_rcv_finish_core.

What do you think? Do you have a better idea?

[1] https://lore.kernel.org/netdev/cover.1574252982.git.pabeni@redhat.com/
[2] https://lore.kernel.org/netdev/20120720.142502.1144557295933737451.davem@davemloft.net/

Leone Fernando (3):
  net: route: expire rt if the dst it holds is expired
  net: dst_cache: add input_dst_cache API
  net: route: replace route hints with input_dst_cache

 include/linux/percpu.h  |   4 ++
 include/net/dst_cache.h |  56 ++++++++++++++++
 include/net/route.h     |   6 +-
 net/core/dst_cache.c    | 145 ++++++++++++++++++++++++++++++++++++++++
 net/ipv4/ip_input.c     |  58 ++++++++--------
 net/ipv4/route.c        |  39 ++++++++---
 6 files changed, 268 insertions(+), 40 deletions(-)

--
2.34.1



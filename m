Return-Path: <linux-kernel+bounces-61416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6867385121B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A745282DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8110038FB2;
	Mon, 12 Feb 2024 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNqPsg77"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E653739843;
	Mon, 12 Feb 2024 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736985; cv=none; b=fcePBQnk5kq8VNhvCoQmRsLfIQlAVIuw9CYP3e83S51T+a9RGfyYpnfpwy1zkwlampzarHNs0FGzVX/CFNdc84qXVgwTPcEfLyu9AGOFsger5Zwc2g9nswzDexq9ksRu03mwjLouPJ+BdlRPSr6WU6VckOx5gV4PfQSoklBIF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736985; c=relaxed/simple;
	bh=B/vUU6l5mFb5atN2Gxvu1pTJ2/VYtf83TxQKMCVfGK4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=gV6TrmKE0qTdQs65gn/QJisschLCcuuT2RmUNv2eKo71VHTL6wAT4wOY+6oHxiHUB9f4iX9kkHN3t6Dvr5iTTwtn2qmrA+xxCi+DEj6Y/XwXgxGJBYRbWbKvMz5G3gUflIq0LLg/bmn1aljCo7Td2JjzSLHgbanAHK06m+IES94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNqPsg77; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-410ec928b83so2347115e9.2;
        Mon, 12 Feb 2024 03:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707736982; x=1708341782; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:content-language
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+S0EPR8vOm7jLDF5VdoNe0DSy3+UA4PZFjWRFIIicYk=;
        b=RNqPsg77vGoZtAuodKYw9f9Da9wLcUEbhi7Qp5wS8VE29M20Wfv18LS2vEqD2dg/W7
         AraVcehvLRr/Y4hUSRfIpjKFvrKwuuhJpiaYRmbtuo+Zh6LfSJiOlOSL/VlSZCZK9sMz
         Oatw1//YbNcnPt1UVCpwlslHu9/ME2/FPi5NSu9kECL8OppaWuVHBZVAGXuZYzKqWVtw
         f9fTQLr8VjSuOVVD6tKFYTgIN4lDv+ssIWElRajQuW8XXO+XfkXtrEBGf4TbBlxV6jSQ
         NM12R6BDnnu8Dqu59SJctwyO+MRDjidyS45UjVaHowRA9i/9WmQxqru/ecR0eZdqpjZj
         ROKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707736982; x=1708341782;
        h=content-transfer-encoding:to:subject:from:content-language
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+S0EPR8vOm7jLDF5VdoNe0DSy3+UA4PZFjWRFIIicYk=;
        b=AVqC+cE6OT3tO2WOH9SQkPv0UaYH+00ROHfua08RmFAudyLBAS9PnzfIHOjiReBh17
         oUtkhb711e2pa045PvB8j6vCfX63peTPm5MCVQKMRUUZFAw/BDvK8KrvS5u6wE4a2Vix
         XKUcW2PTkFT01C9Iy/AGc775Z3kBVJ4NZoL2AMO/nGqfBY66Cen21WKc1FXhewdBECYA
         CVIrO1P42+lZagJCO/rqt7GFdUsZTVVgyCdJ/znagRvJysjvX74K+DDs4J/aB5pQxLee
         /KVyYyz7bn//xVXitjZP6jY6PoPQF48NrCNOXTS4qYl38AFtlRI+Wc4hhnkBMPC20rEN
         YGFg==
X-Forwarded-Encrypted: i=1; AJvYcCXelzU7ynGCOH79uS8Rrqzsi9BgprUYSa3wvfOzBcMrO9Ks0XaJj6Iu3RJ2RkEtgndrIkh62kBM7HPf2KhnVVHgmWVlXk755gZnLMA/rOMO7vn9HVcZ96F4YrL+JqKcw8Vw13Rx
X-Gm-Message-State: AOJu0Yw1Qd1LPwF0uyg0UVJR79PfBUiXY+tnFgDKNOvkCzWFHx5C6XUD
	OBmhevNRbE0EsAWC0rLTznrJOpqAEXR7Dy5RDYS+7VNWzSodkHj2ua3IJl/5+gk=
X-Google-Smtp-Source: AGHT+IGbal0u382TNADETz+p3NDzA/BBjpYF3hnxjzso9kOBFF8FN8iJRnOlmLbejAWAiFaheG+pAw==
X-Received: by 2002:a05:600c:4283:b0:410:794d:dfe6 with SMTP id v3-20020a05600c428300b00410794ddfe6mr5529869wmc.39.1707736981898;
        Mon, 12 Feb 2024 03:23:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVutdkgFsSKhUaFsVouHa5sfmDdI2Z99i7q+bEU9nygrBo+QoJO3X2d2xYZ+n8L1QIzCHJ3tDllzYSXpUeAFgphkh+LdZ+XXpjZWJMJagT5SkK8e7lzPUa6ghq5K0HSYgaoQsUhP1TmPzHpxwIhUlO41DLDrWcfxM6HxJnWxWRDI+8vRhKUtF/b0N7dTmp9SOI/TmUVVcXy+AaokCg2aDB9sGg7BtcmSpFkQ5wYzC5Hd/g=
Received: from localhost ([45.130.85.2])
        by smtp.gmail.com with ESMTPSA id p11-20020a5d68cb000000b0033b66c2d61esm6493711wrw.48.2024.02.12.03.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:23:01 -0800 (PST)
Message-ID: <3a17c86d-08a5-46d2-8622-abc13d4a411e@gmail.com>
Date: Mon, 12 Feb 2024 12:22:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
From: Leone Fernando <leone4fernando@gmail.com>
Subject: [RFC PATCH net-next v2 0/3] net: route: improve route hinting
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

v1 -> v2
- remove unnecessary macro
- move inline to .h file
- v1: https://lore.kernel.org/netdev/d951b371-4138-4bda-a1c5-7606a28c81f0@gmail.com/#t

Leone Fernando (3):
  net: route: expire rt if the dst it holds is expired
  net: dst_cache: add input_dst_cache API
  net: route: replace route hints with input_dst_cache

 include/net/dst_cache.h |  69 +++++++++++++++++++++
 include/net/route.h     |   6 +-
 net/core/dst_cache.c    | 132 ++++++++++++++++++++++++++++++++++++++++
 net/ipv4/ip_input.c     |  58 ++++++++++--------
 net/ipv4/route.c        |  39 +++++++++---
 5 files changed, 264 insertions(+), 40 deletions(-)

-- 
2.34.1



Return-Path: <linux-kernel+bounces-97770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E5A876F36
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000221C20B02
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2532CCB3;
	Sat,  9 Mar 2024 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/eamJyD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8D11EB39;
	Sat,  9 Mar 2024 04:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709960030; cv=none; b=evzhjcx5zGq396HpEb+Och2A5/EEk/wrEfq2DbhLI4KbaHD4tlM3WM8dZ4FuXCVM+SI9uFUsc8dz/1WzkPo491+5TK5zG6ZGS1mBuufwDqm3auWsOs45V7gBRvPhyS3dZTay75kIqqFO4uU+4qbm2LHho+1TI8S2S0ZGLAeu7Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709960030; c=relaxed/simple;
	bh=44jm/FoNGX3BH3KZJFA1CcHK0gJFNnX7Fjx+HPcXGRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8/hD3V7ikXWK6+L6XIFZcc9ZM7ZCkEnThizyujf8CIP2dEjsfCJyW8zp1I6e5yIH7EoguRMR5x8am6O5Hv6BkTG4OMZRzr9ONcnsRTv0PmKkxGMNv1ZbtB9629/ObWr6n2OznI64bd/xbjEJ0dOh6YTcnqobyID092Zr8Pa2R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/eamJyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48D4C433F1;
	Sat,  9 Mar 2024 04:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709960029;
	bh=44jm/FoNGX3BH3KZJFA1CcHK0gJFNnX7Fjx+HPcXGRA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u/eamJyDquIwExxXeNVq1f0H5ZdM/cTKeg7qv8fJX5j5FRtEd91RMf6FBG9iElrbJ
	 4WRXaxEPMG1omabv5EQ/oLDB91zckAIhkcz6JSKvxWwCbSb1qgqgBj4l9oAkgkaTBE
	 p+MWviN5NsJcElSlchtrQ11C5sjdgF0g54qPcx25D8fe1TSVp46iJZql8JYK/B294/
	 AMm5t3NM/pVyynYVdbUtS0RnWxe5kPWA99tY1zhHbwZQum6dP2wma6KR3UukWjgLqj
	 T6r7/vRaTH+LidyCqawZJ2GRb7iVAgxqTAkUcQsEyVnLmLHI+ij7rPKTRq6cBvvzpl
	 DFLoJ7xSRC3eQ==
Message-ID: <9ce73c04-ee8f-4aa5-ab15-c31dbe409401@kernel.org>
Date: Fri, 8 Mar 2024 21:53:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] net: route: improve route hinting
Content-Language: en-US
To: Leone Fernando <leone4fernando@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, willemb@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240307171202.232684-1-leone4fernando@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240307171202.232684-1-leone4fernando@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/24 10:11 AM, Leone Fernando wrote:
> In 2017, Paolo Abeni introduced the hinting mechanism [1] to the routing
> sub-system. The hinting optimization improves performance by reusing
> previously found dsts instead of looking them up for each skb.
> 
> This patch series introduces a generalized version of the hinting mechanism that
> can "remember" a larger number of dsts. This reduces the number of dst
> lookups for frequently encountered daddrs.
> 
> Before diving into the code and the benchmarking results, it's important
> to address the deletion of the old route cache [2] and why
> this solution is different. The original cache was complicated,
> vulnerable to DOS attacks and had unstable performance.
> 
> The new input dst_cache is much simpler thanks to its lazy approach,
> improving performance without the overhead of the removed cache
> implementation. Instead of using timers and GC, the deletion of invalid
> entries is performed lazily during their lookups.
> The dsts are stored in a simple, lightweight, static hash table. This
> keeps the lookup times fast yet stable, preventing DOS upon cache misses.
> The new input dst_cache implementation is built over the existing
> dst_cache code which supplies a fast lockless percpu behavior.
> 
> I tested this patch using udp floods with different number of daddrs.
> The benchmarking setup is comprised of 3 machines: a sender,
> a forwarder and a receiver. I measured the PPS received by the receiver
> as the forwarder was running either the mainline kernel or the patched
> kernel, comparing the results. The dst_cache I tested in this benchmark
> used a total of 512 hash table entries, split into buckets of 4
> entries each.
> 
> These are the results:
>   UDP             mainline              patched                   delta
> conns pcpu         Kpps                  Kpps                       %
>    1              274.0255              269.2205                  -1.75
>    2              257.3748              268.0947                   4.17
>   15              241.3513              258.8016                   7.23
>  100              238.3419              258.4939                   8.46
>  500              238.5390              252.6425                   5.91
> 1000              238.7570              242.1820                   1.43
> 2000              238.7780              236.2640                  -1.05
> 4000              239.0440              233.5320                  -2.31
> 8000              239.3248              232.5680                  -2.82
> 

I have looked at all of the sets sent. I can not convince myself this is
a good idea, but at the same time I do not have constructive feedback on
why it is not acceptable. The gains are modest at best.



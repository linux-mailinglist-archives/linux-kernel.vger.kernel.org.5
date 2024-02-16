Return-Path: <linux-kernel+bounces-68562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0841857C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E07A1F23EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6716B79930;
	Fri, 16 Feb 2024 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Vp3gMGfo"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5978B73;
	Fri, 16 Feb 2024 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708085865; cv=none; b=gq0ZblXmSi60zO0kRqYi/Q3gvyCgkcaqlHEaSdYyJCKDimsCLvaX0ijNyMn5SISdrAauxCBHnqVvXNlqITY/uhbLAPzAUQYE3L7Wqt3XceCWzeBtyJcVlyFK7xLLlbPriqgGpntahGsynEdfh3fVO6GC2A6lPIqjnJGXumBwAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708085865; c=relaxed/simple;
	bh=0v2HTKd1MhqMMkaLSnmMvrLTyR08S+pwHmoDQiG/cXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBZomeD+FijDWBWHv5IaBJDKyUfDDch47iT8D+uFb5S6PCpbO+UuPzKYu6GshCftWt/wt+OtYJmS2Wz6D9J7uRPvxQLwNLx51hFWveYqdGAg7jEMisBnaGElvCjat6r0nZX5c121FlYrQ9pvCANzQjkqZu6EmjlblGTrypiSlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Vp3gMGfo; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 9C18F600D4;
	Fri, 16 Feb 2024 12:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1708085856;
	bh=0v2HTKd1MhqMMkaLSnmMvrLTyR08S+pwHmoDQiG/cXk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vp3gMGfomSCIg29dn+sWT9Om0w471AcpLihb+qJuAr0I7SZzRWqIerOqx9L3H9gei
	 hVi/roCmn990Zrm/8kXgNUCQzXdffhTk7kpf7XBOJYUt0HMd5eypwVVCvFx4ytz93l
	 sbLWlHqPJmr1TS3MD4GcUfTm+X77Pg8/lrtXHhVp6rNphemQyAsvKeh12wNvv7gDs9
	 Qghz+F8XCsPpDUqw7sQvL57JIOKW2iRU+2KlwpIZ0rn5RIzfy3tOBhYKQtOPmKi1oa
	 Um0UxMg0tKGAsjZ3kWGpZt16OyMv3jOieFsH8QKAb3k7tMK+Ij39CLvIOhF6/D1KYn
	 rXM4KLXEeUFpw==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 0EAF7200224;
	Fri, 16 Feb 2024 12:17:28 +0000 (UTC)
Message-ID: <110f8523-4d61-4a1d-ae18-480d89e3c930@fiberby.net>
Date: Fri, 16 Feb 2024 12:17:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] make skip_sw actually skip software
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, llu@fiberby.dk
References: <20240215160458.1727237-1-ast@fiberby.net>
 <CALnP8ZZYftDYCVFQ18a8+GN8-n_YsWkXOWeCVAoVZFfjLezK2Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <CALnP8ZZYftDYCVFQ18a8+GN8-n_YsWkXOWeCVAoVZFfjLezK2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marcelo,

On 2/15/24 18:00, Marcelo Ricardo Leitner wrote:
> On Thu, Feb 15, 2024 at 04:04:41PM +0000, Asbjørn Sloth Tønnesen wrote:
> ...
>> Since we use TC flower offload for the hottest
>> prefixes, and leave the long tail to Linux / the CPU.
>> we therefore need both the hardware and software
>> datapath to perform well.
>>
>> I found that skip_sw rules, are quite expensive
>> in the kernel datapath, sice they must be evaluated
>> and matched upon, before the kernel checks the
>> skip_sw flag.
>>
>> This patchset optimizes the case where all rules
>> are skip_sw.
> 
> The talk is interesting. Yet, I don't get how it is set up.
> How do you use a dedicated block for skip_sw, and then have a
> catch-all on sw again please?

Bird installs the DFZ Internet routing table into the main kernel table
for the software datapath.

Bird also installs a subset of routing table into an aux. kernel table.

flower-route then picks up the routes from the aux. kernel table, and
installs them as TC skip_sw filters.

On these machines we don't have any non-skip_sw TC filters.

Since 2021, we have statically offloaded all inbound traffic, since
nexthop for our IP space is always the switch next to it, which does
interior L3 routing. Thereby we could offload ~50% of the packets.

I have put an example of the static script here:
https://files.fiberby.net/ast/2024/tc_skip_sw/mlx5_static_offload.sh

And `tc filter show dev enp5s0f0np0 ingress` after running the script:
https://files.fiberby.net/ast/2024/tc_skip_sw/mlx_offload_demo_tc_dump.txt


> I'm missing which traffic is being matched against the sw datapath. In
> theory, you have all the heavy duty filters offloaded, so the sw
> datapath should be seeing only a few packets, right?

We are an residential ISP, our traffic is therefore residential Internet
traffic, we run the BGP routers as a router on a stick, the filters therefore
see both inbound and outbound traffic.

~50% of packets are inbound traffic, our own prefixes are therefore the
hottest prefixes. Most streaming traffic is handled internally, and is
therefore not seen on our core routers. We regularly have 5%-10% of all
outbound traffic going towards the same prefix, and have 50% of outbound
traffic distributed across just a few prefixes.

We currently only offload our own prefixes, and a select few other known
high-traffic prefixes.

The goal is to offload the majority of the trafic, but it is still early
days for flower-route, and I need to implement some smarter chain layout
first and dynamic filter placement based on hardware counters.

Even when I get flower-route to offload almost all traffic, there will still
be a long tail of prefixes not in hardware, so the kernel still needs
to not be pulled down by the offloaded filters.

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541


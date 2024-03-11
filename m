Return-Path: <linux-kernel+bounces-99593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24637878A80
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C941F21AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7911357316;
	Mon, 11 Mar 2024 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="vYnFcRP6"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31EE56B90;
	Mon, 11 Mar 2024 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194759; cv=none; b=XVxs3ON8TLtLyYoLDgWs4KSE60vwQAZykkXbNgLLMDW+UlseKCaqihqa2BWJsiZiPQQ+UhEpRQgdYqC4IwJp0/+TNXMCRSzzVH2zZIseae9TRBLm9HsnkXJC9HJOtoNVsgH7u41e9pjVpZS+27bJv3XNAYTC8kuahRbQ4JLzo5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194759; c=relaxed/simple;
	bh=R+IxDTVIV1VoIdKEZSyusXOyCtEViHcb5yqmR70/jdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otfSzi4N5KeRFo3rJ+sNS69FjzVwxAINREA5sFSOYvG9k95ZI+66uIFBmPcVyip0OmikIgapAV8mu2beJi4e1V7hCqFhHXzUrtGCnF8NHNvVfXNhHLgRAfSVWCHgDIylca+gRuHnzXI+MFGUCAvuMnst8GmGpebunH482PYwbYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=vYnFcRP6; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 269236030A;
	Mon, 11 Mar 2024 22:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1710194747;
	bh=R+IxDTVIV1VoIdKEZSyusXOyCtEViHcb5yqmR70/jdY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vYnFcRP6nlepiX2TGdUdMK/hlrOkZMUa054TkbGZhe/BI7rO26n7W1ARTkIaLr87R
	 h12UHloYr2IRztBWNrIOpWpF2xo+xyqDhEYaioty3GzNHV+UuYWGkKG4O+4dXldRmD
	 3tkx1/6OCGxXDT8d8tqI3uozy383QuaxaUpdTRzHBbH3Maya4bqJJnupnKLRkhP9HQ
	 BBOBg2NlG0eBHTxYM9bEEUfYV9v+ewVl3hzLnfysM9vUGVIIh6DI8OWoHf1APbhQe/
	 6CWdYSqQaQGgyeyffYN9CGS1PL+x7DnPx9vS1XviOxU04OPvV+hyJOdptdTIlBXJKt
	 mIAeS2XY7hJMg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 29750200B46;
	Mon, 11 Mar 2024 22:05:29 +0000 (UTC)
Message-ID: <08ba1c0f-4496-45c1-ab77-df127ac8bf54@fiberby.net>
Date: Mon, 11 Mar 2024 22:05:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/3] make skip_sw actually skip software
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Borkmann <daniel@iogearbox.net>, Vlad Buslov <vladbu@nvidia.com>,
 Marcelo Ricardo Leitner <mleitner@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, llu@fiberby.dk
References: <20240306165813.656931-1-ast@fiberby.net>
 <20240311134435.19393f98@kernel.org>
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20240311134435.19393f98@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kuba,

On 3/11/24 8:44 PM, Jakub Kicinski wrote:
> On Wed,  6 Mar 2024 16:58:08 +0000 Asbjørn Sloth Tønnesen wrote:
>> During development of flower-route[1], which I
>> recently presented at FOSDEM[2], I noticed that
>> CPU usage, would increase the more rules I installed
>> into the hardware for IP forwarding offloading.
>>
>> Since we use TC flower offload for the hottest
>> prefixes, and leave the long tail to the normal (non-TC)
>> Linux network stack for slow-path IP forwarding.
>> We therefore need both the hardware and software
>> datapath to perform well.
>>
>> I found that skip_sw rules, are quite expensive
>> in the kernel datapath, since they must be evaluated
>> and matched upon, before the kernel checks the
>> skip_sw flag.
>>
>> This patchset optimizes the case where all rules
>> are skip_sw, by implementing a TC bypass for these
>> cases, where TC is only used as a control plane
>> for the hardware path.
> 
> Linus tagged v6.8 and the merge window for v6.9 has started.
> This feels a bit too risky for me to apply last minute,
> could you repost in 2 weeks once the merge window is over?

Sure, I will repost once net-next opens back up again.

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541


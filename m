Return-Path: <linux-kernel+bounces-127994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1ED895430
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB141F24223
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF5380631;
	Tue,  2 Apr 2024 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="lH9PsOz3"
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120297FBA3;
	Tue,  2 Apr 2024 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063198; cv=none; b=ejiJmdWHy58qrqdhxHJwd6XgrJmwWP01LfR3+Maa0lkKu3SAP5lQdN3VRgC/JNEtrq091kwQKtSYQG4BdE2FAvNJZ3DnUlag3eE8kVKMaB0Dze5hY42FF01xFIqGaS212niJlarYWsJhvbaOSGaJQoRevF5xt5lOZe+UXiEDE7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063198; c=relaxed/simple;
	bh=ub6xj0Xh88klcbMNRWQ1zWdFhSA3tZbe3MZEAc6E9Qg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fIIY8MQw7XvlSyFIbAWX4KLe42ejOg1KpstB3GsxxFix1VBNn5hBNHGCgijj7wHZfQjFyAn0Qg/CY1DZHxePz8+JlkRxSv09TKEOLgvUPL9cP8dzuk6pgYYZdvSQwYp45nPXgfB107owgk58ChcNtpRd2pFYZmgSJNNyl6pXItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=lH9PsOz3; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=eUNJb8LCQoKcNVIIIuMPrEHqJBJpIDndWy7WAX8vRgo=; b=lH9PsOz3OBIPFwi4+kztRm+R5O
	i9pd0mHRNxFIU4+TBt//dhSs5EFyxXCbjs1WGGFEdkVzjMHzbCKxIa/RFN+MouOzql1jVnf7J3oPi
	Ofzlz8j1hxIJpvpeKrFg2n9/RSprzuiohS8VvSHADS16Q45p/Xqoyt5QKqaoSBgVJBe1DUgeOhmx7
	MxXZgp9FcVVf0TBbNJ6SM8oJEYzn6XEHfh4dHfF2HNRkEC3raoZsxui+e/8K36Hh6SWiBnf20vIFg
	rP+5gZf/wdtt35IJNuQXSDP6jG4pK1bU9lE68ORtPIPyKdU5jrg3TLDj0pEsoWovc3omO/nZQ5MIa
	AVfFd7Uw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rrdqG-0003xB-KH; Tue, 02 Apr 2024 15:06:20 +0200
Received: from [178.197.248.12] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rrdqF-0004Uu-13;
	Tue, 02 Apr 2024 15:06:19 +0200
Subject: Re: [PATCH bpf-next] Fix latent unsoundness in and/or/xor value
 tracking
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 harishankar.vishwanathan@rutgers.edu, sn624@cs.rutgers.edu,
 sn349@cs.rutgers.edu, m.shachnai@rutgers.edu, paul@isovalent.com,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>,
 Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329030119.29995-1-harishankar.vishwanathan@gmail.com>
 <f2e1c5dc6f6ea2c7f046e8673dd364dd14056781.camel@gmail.com>
 <CAM=Ch04JAJDS84xYHFUfjrShwqSSc8gQ5a_sLCoRNAsf6tyjYQ@mail.gmail.com>
 <CAEf4BzZp69diFeyjUAa8-jbZatDouwSaexwuakJdXHTdHwsBLQ@mail.gmail.com>
 <CAM=Ch04BBaucesmw0MY5U2bsrtqPAjurLdLkMdxMRMB0OuOtcw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4229e0ff-777b-6afb-f0c0-a329e426d87e@iogearbox.net>
Date: Tue, 2 Apr 2024 15:06:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM=Ch04BBaucesmw0MY5U2bsrtqPAjurLdLkMdxMRMB0OuOtcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27233/Tue Apr  2 10:26:21 2024)

On 3/30/24 5:35 PM, Harishankar Vishwanathan wrote:
> On Sat, Mar 30, 2024 at 1:28 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Fri, Mar 29, 2024 at 8:25 PM Harishankar Vishwanathan
>> <harishankar.vishwanathan@gmail.com> wrote:
>>>
>>> On Fri, Mar 29, 2024 at 6:27 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>>
>>>> On Thu, 2024-03-28 at 23:01 -0400, Harishankar Vishwanathan wrote:
>>>>
>>>> [...]
>>>>
>>>>> @@ -13387,18 +13389,19 @@ static void scalar32_min_max_or(struct bpf_reg_state *dst_reg,
>>>>>         */
>>>>>        dst_reg->u32_min_value = max(dst_reg->u32_min_value, umin_val);
>>>>>        dst_reg->u32_max_value = var32_off.value | var32_off.mask;
>>>>> -     if (dst_reg->s32_min_value < 0 || smin_val < 0) {
>>>>> +     if (dst_reg->s32_min_value > 0 && smin_val > 0 &&
>>>>
>>>> Hello,
>>>>
>>>> Could you please elaborate a bit, why do you use "> 0" not ">= 0" here?
>>>> It seems that having one of the min values as 0 shouldn't be an issue,
>>>> but maybe I miss something.
>>>
>>> You are right, this is a mistake, I sent the wrong version of the patch. Thanks
>>> for catching it. I will send a new patch.
>>>
>>> Note that in the correct version i'll be sending, instead of the following
>>> if condition,
>>>
>>> if (dst_reg->s32_min_value >= 0 && smin_val >= 0 &&
>>> (s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value)
>>>
>>> it will use this if condition:
>>>
>>> if ((s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value)
>>>
>>> Inside the if, the output signed bounds are updated using the unsigned
>>> bounds; the only case in which this is unsafe is when the unsigned
>>> bounds cross the sign boundary.  The shortened if condition is enough to
>>> prevent this. The shortened has the added benefit of being more
>>> precise. We will make a note of this in the new commit message.
>>
>> And that's exactly what reg_bounds_sync() checks as well, which is why
>> my question/suggestion to not duplicate this logic, rather reset s32
>> bounds to unknown (S32_MIN/S32_MAX), and let generic reg_bounds_sync()
>> handle the re-derivation of whatever can be derived.
> 
> We tried your suggestion (setting the bounds to be completely unbounded).
> This would indeed make the abstract operator scalar(32)_min_max_and
> sound. However, we found (through Agni and SMT verification) that our patch is
> more precise than just unconditionally setting the signed bounds to unbounded
> [S32_MIN/S32_MAX], [S64_MIN,S64_MAX].
> 
> For example, consider these inputs to BPF_AND:
> 
> dst_reg
> -----------------------------------------
> var_off.value: 8608032320201083347
> var_off.mask: 615339716653692460
> smin_value: 8070450532247928832
> smax_value: 8070450532247928832
> umin_value: 13206380674380886586
> umax_value: 13206380674380886586
> s32_min_value: -2110561598
> s32_max_value: -133438816
> u32_min_value: 4135055354
> u32_max_value: 4135055354
> 
> src_reg
> -----------------------------------------
> var_off.value: 8584102546103074815
> var_off.mask: 9862641527606476800
> smin_value: 2920655011908158522
> smax_value: 7495731535348625717
> umin_value: 7001104867969363969
> umax_value: 8584102543730304042
> s32_min_value: -2097116671
> s32_max_value: 71704632
> u32_min_value: 1047457619
> u32_max_value: 4268683090
> 
> After going through
> tnum_and() -> scalar32_min_max_and() -> scalar_min_max_and() ->
> reg_bounds_sync()
> 
> Our patch produces the following bounds for s32:
> s32_min_value: -1263875629
> s32_max_value: -159911942
> 
> Whereas, setting the signed bounds to unbounded in
> scalar(32)_min_max_and produces:
> s32_min_value: -1263875629
> s32_max_value: -1
> 
> Our patch produces a tighter bound as you can see. We also confirmed
> using SMT that
> our patch always produces signed bounds that are equal to or more
> precise than setting
> the signed bounds to unbounded in scalar(32)_min_max_and.
> 
> Admittedly, this is a contrived example. It is likely the case that
> such precision
> gains are never realized in an actual BPF program.
> 
> Overall, both the fixes are sound. We're happy to send a patch for
> either of them.

Given your version is more precise, then that would be preferred. Might
be good to have the above as part of the commit description for future
reference.

Thanks,
Daniel


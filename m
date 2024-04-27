Return-Path: <linux-kernel+bounces-161047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F718B4663
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 14:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C162858D6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1464DA15;
	Sat, 27 Apr 2024 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="eOcCdVkH"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7033763B9;
	Sat, 27 Apr 2024 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714222736; cv=none; b=QKf8AmB2isr/EGYFHgyx0i3P698icT1jMnOQdrT2iBt92aCkaRBM5Ss73ptNO1J3k6c3X0dtsmYYEgrRlFKPud1BTKArNMxNvq5z4S90iIQJ43Ee6TmBgwV2RQttq+GX4XFll/lzoLPRNM6YPWVsJW8RyGgRRPn1f6KuXcP+GFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714222736; c=relaxed/simple;
	bh=oGWx1uPQ3L1tVyWtUhcgy+p+cBF1ON8qmwJmbS5l0rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijiKFrNhcfZiFvQ/B7guhnMJEjZUl+gPmoDiILLC/QGdw6OuFR7XGV2463oqQfxdLu5HcLoeLMM7Ih06iJJOv9KzYmmr9tKlutslfxD2H1lLKBagEqO42sPnorj6mHzVrwZTT+ugOejLjiW2dBm+8Q1+IAUnCwYioIb+IheDowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=eOcCdVkH; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 9A780600A2;
	Sat, 27 Apr 2024 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1714222724;
	bh=oGWx1uPQ3L1tVyWtUhcgy+p+cBF1ON8qmwJmbS5l0rs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eOcCdVkH9QkkaReDzhH5sqAdvN7pqyP5n7w8sRDliQ6IJ3doaxuzotk8klsknOnzR
	 qq/GFsIljj8Od/MnJMISHzR25JyGw5X5bvkVdwxjJn/FOFNhjIAjpkFRP8ygSgzIGC
	 9tjXA45iIE3kzaKX9LMqLH7FZu8S3hFgiAKX/GUmf+fIhO4W85Nyf7uWbWV8rkd8QQ
	 Rjqx3M4y5pS1k7NIbykfLTYa3aiDNOo75Uc+RG5DW0SdbrxFCNRHnHA8o2Z1NIcvOp
	 5WbdU09i5qmevBX6W6lJY1z2hT4qElte4jMV8uO0Zq1IVPd0UEDRBDnAhgq4+CyQuf
	 FIvmVpdMYt+IA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 5626120257D;
	Sat, 27 Apr 2024 12:58:38 +0000 (UTC)
Message-ID: <ab165657-2c69-4b30-a371-6ad7fd28c539@fiberby.net>
Date: Sat, 27 Apr 2024 12:58:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/4] net: qede: avoid overruling error codes
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ariel Elior <aelior@marvell.com>, Manish Chopra <manishc@marvell.com>,
 Jiri Pirko <jiri@resnulli.us>, Pablo Neira Ayuso <pablo@netfilter.org>
References: <20240426091227.78060-1-ast@fiberby.net>
 <20240427114813.GG516117@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20240427114813.GG516117@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Simon,

Thank you for your review effort.

On 4/27/24 11:48 AM, Simon Horman wrote:
> On Fri, Apr 26, 2024 at 09:12:22AM +0000, Asbjørn Sloth Tønnesen wrote:
>> This series fixes the qede driver, so that
>> qede_parse_flow_attr() and it's subfunctions
>> doesn't get their error codes overruled
>> (ie. turning -EOPNOTSUPP into -EINVAL).
>>
>> ---
>> I have two more patches along the same lines,
>> but they are not yet causing any issues,
>> so I have them destined for net-next.
>> (those are for qede_flow_spec_validate_unused()
>> and qede_flow_parse_ports().)
>>
>> After that I have a series for converting to
>> extack + the final one for validating control
>> flags.
> 
> Hi,
> 
> I'm fine with these patches so far as the code changes go.
> But it is not clear to me that they are fixing a bug.
> 
> If so, I think some explanation should go in the commit messages.
> If not, I think these should be targeted at net-next
> (and not have Fixes tags.

Since I don't have the hardware I didn't try to construct commands, showing
the wrong error code being returned. I could make up some hypothetical commands,
and simulate how they would error. I assumed that the bug, was clear based on
the list of possible return values for each function.

As an example, in qede_parse_flow_attr() it validates dissector->used_keys,
and if an unsupported FLOW_DISSECTOR_KEY_* is set, then ede_parse_flow_attr()
returns -EOPNOTSUPP, which is returned to qede_add_tc_flower_fltr(),
and only check for non-zero, and since -EOPNOTSUPP is non zero,
then it returns -EINVAL. So if you try to match on a vlan tag,
then FLOW_DISSECTOR_KEY_VLAN would be set, and cause a -EOPNOTSUPP
to be returned, which then gets converted into a -EINVAL.

All drivers generally returns -EOPNOTSUPP in their used_keys checks, and
this driver clearly intended to do that as well.

The -EINVAL override was introduced in the same commit as the above check,
so it was broken from the start.

Another example is 319a1d19471e (blamed in 4th patch), Jiri added
a call to flow_action_basic_hw_stats_types_check() across multiple drivers,
and since -EINVAL was returned only a few lines above, then he assumed
that he could just return -EOPNOTSUPP, but that return value gets overruled
into a -EINVAL. It is clear from the commit that Jiri intended to return
-EOPNOTSUPP, but this part of the driver didn't follow the principle of
least astonishment, so that function could only fail with -EINVAL.

I think it's a bug, when another error code is returned than the one that
was clearly intended, but it's properly a low impact one.


> Also, if you do end posting a v2, blamed, is misspelt several
> times in commit messages.

Sorry about that, will fix that if a v2 turns out to be needed.

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541


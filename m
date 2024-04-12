Return-Path: <linux-kernel+bounces-142335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0418A2A51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE771C20B50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB4864CEF;
	Fri, 12 Apr 2024 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="F+glp38T"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D70D4BAA6;
	Fri, 12 Apr 2024 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912488; cv=none; b=LpDfKOW5dVyhRVpwTOJdD7IijQZ4l854UXkwsNQPK8Q6U5c+34NneH5wVZRncYo3sZecyUtPmqdm5LSz+VWRs3sqeBJkOO2lPXjf3BCHr/yWfhBmVzcTN+fBENtmp3f+RPgMVv6+7IiF3zauoL45cuDPwm1EMCmo/lL+I9RzUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912488; c=relaxed/simple;
	bh=oSQzEuk4s9AcL1UwAAfxZUSg769yULNpTsVoPBjtjoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5yTel4B5ElHD4prO4KBG+BAgXhuU4jbFjZ+qw2x1Sb64qFas/Q9ySco5afAPboR3kr6Ry4AHbCANrr7rCVRG6sHBPlJeG5b/E3huaPQbcD+iHmf4C9iv2tlqETeRdtsU71EN3DtT/4lJAIVEflaSqJSLdvekMB15eXAWn7x2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=F+glp38T; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 21D74600A2;
	Fri, 12 Apr 2024 09:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712912481;
	bh=oSQzEuk4s9AcL1UwAAfxZUSg769yULNpTsVoPBjtjoE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F+glp38Ty9t0DUIWXuiuaz6SGhlmthGyyeaQYCDgtMa8MYCNAWUDOiWp5p+oXP7Ne
	 a80/By8NgXRiOsDo5jwa9xC5HNKR3kKG6DCm0f0voMGjRW2t1a1gZdsbloSmf5y0Rn
	 By7DaBomBGd3A59qrajodySq9zuwSf+zEig1qJCMu1MWm+3vZ+dy/Ux+hoQ9+zK68a
	 jx61gVEw4uhMn2A0VnGhivurPJMG3SmS0kOWUFgPw+2x33i5n483BAwxE0+l+xyYBH
	 GH9ug9V2sp6FDosEkNIwPDkrmnUVWReLQA/do2oyFUPCEjYBWlCftIntH0Vs9XGoUU
	 BnpGx5I9jF0sA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id E146C200B1B;
	Fri, 12 Apr 2024 09:01:15 +0000 (UTC)
Message-ID: <27ac48c0-b19c-4104-8ec9-08232e3f42f6@fiberby.net>
Date: Fri, 12 Apr 2024 09:01:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT implementation
To: Suman Ghosh <sumang@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Geethasowjanya Akula <gakula@marvell.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>
References: <20240410134303.21560-1-ast@fiberby.net>
 <SJ0PR18MB5216D2276BA11D5C5E31D6A6DB042@SJ0PR18MB5216.namprd18.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <SJ0PR18MB5216D2276BA11D5C5E31D6A6DB042@SJ0PR18MB5216.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Suman,

On 4/12/24 5:34 AM, Suman Ghosh wrote:
>> 		if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
>> +			val = match.key->flags & FLOW_DIS_IS_FRAGMENT;
>> 			if (ntohs(flow_spec->etype) == ETH_P_IP) {
>> -				flow_spec->ip_flag = IPV4_FLAG_MORE;
>> +				flow_spec->ip_flag = val ? IPV4_FLAG_MORE : 0;
> [Suman] Do we need this? If user provide the command "tc filter add .... ip_flags nofrags" then the above if check should not be hit right? If we are inside the check then we always want to set IPV4_FLAG_MORE right?

In iproute2, the "frag"/"nofrag" is parsed in flower_parse_matching_flags(),
it sets TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT in TCA_FLOWER_KEY_FLAGS and
TCA_FLOWER_KEY_FLAGS_MASK.

Back in the kernel, in fl_set_key_flags() (net/sched/cls_flower.c) then,
directly translates TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT into FLOW_DIS_IS_FRAGMENT,
while only setting the key bit, if the mask bit is being set.

There are therefore 3 possible cases:

- `tc flower ...` (no ip_flags frag or nofrag)
    (match.key->flags & FLOW_DIS_FIRST_FRAG)  is false
    (match.mask->flags & FLOW_DIS_FIRST_FRAG) is false

- `tc flower ... ip_flags nofrag`
    (match.key->flags & FLOW_DIS_FIRST_FRAG)  is false
    (match.mask->flags & FLOW_DIS_FIRST_FRAG) is true

- `tc flower ... ip_flags frag`
    (match.key->flags & FLOW_DIS_FIRST_FRAG)  is true
    (match.mask->flags & FLOW_DIS_FIRST_FRAG) is true

The `nofrag` case will still have the mask bit set, and hence pass the entry condition.


 >> 				flow_mask->ip_flag = IPV4_FLAG_MORE;

Yes, you should always set IPV4_FLAG_MORE in flow_mask, but not always in flow_spec.


-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541


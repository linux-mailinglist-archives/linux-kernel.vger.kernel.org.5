Return-Path: <linux-kernel+bounces-168008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC238BB22B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF85282DA9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3300B1586C1;
	Fri,  3 May 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Nm2drleW"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B715820E;
	Fri,  3 May 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759707; cv=none; b=F5yQUq6QIznQlENvf1pEm1TTgg8XOvqjuAez80178ExRpUNNlfDDeQt3XVZoE1shcamvLwEcCns9GT+j6AXABMsbMEYmjHzBhFDLoY1gtG9xe7TDzFharg1/XDNPVuKPQzUB7I7hrV6jN49o031EGwWapNPSE8e3mvdE0SJTTZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759707; c=relaxed/simple;
	bh=lpjffUs0KsD4f1OIdu+oOs418PzFZ7RJRguA69+8Ufg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyN/TCJki3tQVdoIVIe8kfqiqyaHcXkpDIJRvVQwV6DtJfVus5H4IP8Fesb6PWdi8Lq7CiwmG7+030zTTHZ2wbewvtF8G5xx02D7RVlMbVNyMEcXf17wApE1OeE1OIceZFc7N5NMBSny7oikuzpre3ByjHDb8/Vw+ShhiZuMNkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Nm2drleW; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C234D600A2;
	Fri,  3 May 2024 18:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1714759701;
	bh=lpjffUs0KsD4f1OIdu+oOs418PzFZ7RJRguA69+8Ufg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nm2drleWzUli4rPVRzHIxWXPNsM1P7Lh/mZEVcqcpPgnUhoWJdBr/p0F7y3LbVz+a
	 4T3o8u8ds+dMOu9SiMtVXNN6U1M/8dna+PH56Vj/GFcwvHK5HmU8BAxhDVnR0/pfg3
	 77htbJMnUJyvVyvAKBaAgzTaohiq+SZDxHhec75OsZ2QVs+MOxOZTBCwCG/yknxwT6
	 xwemhYv+LxkMeCbLbtVa3UO/P+L0/M+1foLt37LqEcfu4p4YZG/99PZ+hHWt/1M+/2
	 sqVqoRuDnKJMkAkDzHfP3hf2Zj6pDZmpquWoDm3YwcjjXAP3UbzdzYu8qDDqhXssLG
	 5uQpZiVHj2voQ==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 5823420146D;
	Fri, 03 May 2024 18:08:04 +0000 (UTC)
Message-ID: <80089193-33e8-4601-bdbc-71d10ff1ab58@fiberby.net>
Date: Fri, 3 May 2024 18:08:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: flower: validate control
 flags
To: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
References: <20240416144331.15336-1-ast@fiberby.net>
 <PH0PR11MB50139E3BE2709C5BE7F4AC78961F2@PH0PR11MB5013.namprd11.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <PH0PR11MB50139E3BE2709C5BE7F4AC78961F2@PH0PR11MB5013.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sujai,

On 5/3/24 5:57 AM, Buvaneswaran, Sujai wrote:
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>> Asbjørn Sloth Tønnesen
>> Sent: Tuesday, April 16, 2024 8:14 PM
>> To: intel-wired-lan@lists.osuosl.org
>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Eric Dumazet
>> <edumazet@google.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; Asbjørn Sloth Tønnesen <ast@fiberby.net>;
>> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
>> David S. Miller <davem@davemloft.net>
>> Subject: [Intel-wired-lan] [PATCH iwl-next] ice: flower: validate control flags
>>
>> This driver currently doesn't support any control flags.
>>
>> Use flow_rule_has_control_flags() to check for control flags, such as can be
>> set through `tc flower ... ip_flags frag`.
>>
>> In case any control flags are masked, flow_rule_has_control_flags() sets a NL
>> extended error message, and we return -EOPNOTSUPP.
>>
>> Only compile-tested.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_tc_lib.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
> 
> Hi,
> 
> I have tested this patch in upstream kernel - 6.9.0-rc5+ and observing no effect while adding tc flow rule with control flags.
> 'Not supported' error is not shown while adding the below tc rule.
> 
> [root@cbl-mariner ~]# tc qdisc add dev ens5f0np0 ingress
> [root@cbl-mariner ~]#
> [root@cbl-mariner ~]# tc filter add dev ens5f0np0 ingress protocol ip flower ip_flags frag/firstfrag action drop

Thank you for testing!

I think the issue you are observing, is because you are missing "skip_sw":
tc filter add dev ens5f0np0 ingress protocol ip flower skip_sw \
	ip_flags frag/firstfrag action drop

Without skip_sw, then the hardware offload is opportunistic,
and therefore the error in hardware offloading doesn't bubble
through to user space.

Without skip_sw, you should still be able to observe a change in
`tc filter show dev ens5f0np0 ingress`. Without the patch you
should see "in_hw", and with it you should see "not_in_hw".

With skip_sw, then the error in hardware offloading causes
the tc command to fail, with the -EOPNOTSUPP error and
associated extended Netlink error message.

Also see Ido's testing for mlxsw in this other thread:
https://lore.kernel.org/netdev/ZiABPNMbOOYGiHCq@shredder/#t

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541


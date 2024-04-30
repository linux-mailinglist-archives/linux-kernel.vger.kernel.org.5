Return-Path: <linux-kernel+bounces-163767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5548B6F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16E01C21A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75C4194C7F;
	Tue, 30 Apr 2024 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="QekGRbRV"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F46613C9A9;
	Tue, 30 Apr 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472648; cv=none; b=Q6m8F1RM0IcNlkYAEiAMl2dzkysHJzvuBb/vayh+im6XOsTeg+m9obA2wvL8rS6GLfPOa9MYznZnT2LmUkb1CfFZ9rDHszpYW60RZbWoyGJbbC4gUlNhoTGtJcBFQd28vS2qV19IXVT09FwZ9Ae2Ue/hvAlrZdL4N25eWuRdS20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472648; c=relaxed/simple;
	bh=+MFexaJbpSMwTWSnIHH5vnHOlwmWoklXLMdCQXminoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9uKNsCPGC5zB1d4NZKDQaCwrEE3/L5rdndBhoOvEtQ317lwKJ+EqGuxDbO7uhZp2rZtqy6tJgoVMYY4yrIc4WUdfu9mkCaeeiV90jGSGrlPPaQ2wWGIwgL97QNytJdX3MuRXHpEhui4NdjlXDeHCQ5//+x/kL0KMyxgqWBlmcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=QekGRbRV; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kjZA1V1xyHNaOMbVHyEyXScL1QCT+bsaH3gS+8qzZ/I=; b=QekGRbRV7/rJqAZQO25Wd9MED5
	579e3bYIselVop5rDJg0Y66AMj9qr+P72Ba57tb3vgHjkRBuPc+dywl00NVFzEH5t4BLDVvN7aeqv
	8RtD3u7SaqXcwuaTt2V01PP16G5So5MHVn5kCVOCJ4KgBMlR8Fopqr013SK5FchtOkv8=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s1keP-00AETz-1b;
	Tue, 30 Apr 2024 12:23:53 +0200
Message-ID: <e3a3a499-11b3-4906-b0f1-b94e70825ca9@nbd.name>
Date: Tue, 30 Apr 2024 12:23:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next v4 6/6] net: add heuristic for enabling TCP
 fraglist GRO
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
References: <20240427182305.24461-1-nbd@nbd.name>
 <20240427182305.24461-7-nbd@nbd.name>
 <e590ba4608c9810d3d75fefdcbba9f2a02c23a0f.camel@redhat.com>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <e590ba4608c9810d3d75fefdcbba9f2a02c23a0f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.24 12:12, Paolo Abeni wrote:
> On Sat, 2024-04-27 at 20:23 +0200, Felix Fietkau wrote:
>> When forwarding TCP after GRO, software segmentation is very expensive,
>> especially when the checksum needs to be recalculated.
>> One case where that's currently unavoidable is when routing packets over
>> PPPoE. Performance improves significantly when using fraglist GRO
>> implemented in the same way as for UDP.
>> 
>> When NETIF_F_GRO_FRAGLIST is enabled, perform a lookup for an established
>> socket in the same netns as the receiving device. While this may not
>> cover all relevant use cases in multi-netns configurations, it should be
>> good enough for most configurations that need this.
>> 
>> Here's a measurement of running 2 TCP streams through a MediaTek MT7622
>> device (2-core Cortex-A53), which runs NAT with flow offload enabled from
>> one ethernet port to PPPoE on another ethernet port + cake qdisc set to
>> 1Gbps.
>> 
>> rx-gro-list off: 630 Mbit/s, CPU 35% idle
>> rx-gro-list on:  770 Mbit/s, CPU 40% idle
>> 
>> Signe-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  net/ipv4/tcp_offload.c   | 32 ++++++++++++++++++++++++++++++++
>>  net/ipv6/tcpv6_offload.c | 35 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 67 insertions(+)
>> 
>> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
>> index 87ae9808e260..3e9b8c6f9c8c 100644
>> --- a/net/ipv4/tcp_offload.c
>> +++ b/net/ipv4/tcp_offload.c
>> @@ -407,6 +407,36 @@ void tcp_gro_complete(struct sk_buff *skb)
>>  }
>>  EXPORT_SYMBOL(tcp_gro_complete);
>>  
>> +static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
>> +				    struct tcphdr *th)
>> +{
>> +	const struct iphdr *iph;
>> +	struct sk_buff *p;
>> +	struct sock *sk;
>> +	struct net *net;
>> +	int iif, sdif;
>> +
>> +	if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
> 
> Should we add an 'unlikely()' here to pair with unlikely(is_flist) in
> *gro_receive / *gro_complete?
Not sure if unlikely() will make any difference here. I think it makes 
more sense in the other places than here.

> Should this test be moved into the caller, to avoid an unconditional
> function call in the ipv6 code?

The function is already called from tcp4_gro_receive, which is only 
called by IPv4 code. Also, since it's a static function called in only 
one place, it gets inlined by the compiler (at least in my builds).
Not sure what unconditional function call you're referring to.

- Felix


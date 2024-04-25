Return-Path: <linux-kernel+bounces-158487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0958B20D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B7E282728
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7A512BE8C;
	Thu, 25 Apr 2024 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK7Xx8a2"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212E62AEF1;
	Thu, 25 Apr 2024 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046415; cv=none; b=BQhljfNrwtB9vgpbjVbgdICshuxuqAqMzO2q2eaeoREFdgHnndfhjWdNRwhqy7FtBXRJFF+75PZpAScmJDmGESZBky/JdFUpQHegc6s7Wsg96Q8sKyEpKYeeEVBK8rQmZ+mzXKQGJCIw0e2kmO/XrVjeW8AblbBbTWNM3J3R6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046415; c=relaxed/simple;
	bh=oJa4kb3Kz9wgSUPe/rm+Nlzw45qoV5stUA7tiv6CscQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pve8EzN0HDmtE/6F4NoBdJN3PQ5tPzRHld9X9Pwl4fFwXkWiux5RMAE2U5BEsg2WmzugJT102bCHwDhS3vGMOP7egBDWQwTd7ybrAssti9WxGqWT27QyoEjJp7Af9gEwSG7eN6BVhaAS+YHxBp/6nzr/D8A2KBlO4fiZBEqJ8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gK7Xx8a2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34c1fff534fso243726f8f.1;
        Thu, 25 Apr 2024 05:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714046411; x=1714651211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmSv2NabfVRN93/JWDRnVa5o0cjs0rYBm8wWbEM93Fo=;
        b=gK7Xx8a2NY2Esp4UkzvNlma+o7wcG6+S/YsrjCtrBg6MtWMdyx9MVrc+Sisyr6dEK/
         dh2a2x+IGmwPfaOwdcK0qFPt80T11VapKbtXp4FLHby2fB57yPeaPeMsT741s6DafcsL
         3sX7fdCxxXcRnUUlklSIhXAsM0SIFOF5GahRJGsqIKWH2seh4e0x17Ch0ZBAxUCIN/HM
         X79OtKaHrqFDG9zr0l94SZw6xnwmdZhzYylP3XmTYx+qraTM715gop/6V2XfOm8g3gn1
         8WLlY/NlBu4PnN8wtBCSQB5hdyahQhKo+zeli4Qu0bkd+TrQmRzy5ubnNB1skbLRDenR
         9JBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714046411; x=1714651211;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OmSv2NabfVRN93/JWDRnVa5o0cjs0rYBm8wWbEM93Fo=;
        b=nh9v64ZkC1NiETP3TtHW6pmIBaxOVIKq1RTSz1a8b0tz1X72NYiLjnB+3UM3hbyRrl
         AMv6v2w6c9aXpyBOSkSXjgSCwRNlk95OrmleRbWCRoMILu+1LLvvDNzoqqUM0NFMW52v
         FsxmpZUvZk5gR23eSB7aSfSM+dZ4pKhTIQTtZB88BRsXA+4Sr1BFqi2KEv62xG9Ehcgs
         TV5kVzFV58IEVcFGz9B3dh9LdQhcaaMWMXi8CtmEvR+3R74fAsokw6XqTKhbMdQR0Bn9
         LF4HXb76+YqvW9Wjb0fdbNuZ5xO13/4mq8F1hJ9Y6jrX2jzh+g/y3/UIdBzGTBny+NKf
         PNNA==
X-Forwarded-Encrypted: i=1; AJvYcCXhGfiSaI/jb5NCRk4KBN91niYh/4u7EoVxlF/28Winc9nFL1wnERQXu1U2vyu5rN06qcHLyEE+xi80RNKzARf9ypTM6JUluOY6LIJ/BubyhuRBEv/JMCLfFGzm/vvTRgPcONhP
X-Gm-Message-State: AOJu0YzjuPV8jH3rgHYZUY3+q2jzdAyiDtAbsMLskVUwWZGAKKtzF6rH
	uLfPOfy9PZuKUCfJvo7aakPvIvCfWg/wOHxCOWR4iF0oMH9rxLPD
X-Google-Smtp-Source: AGHT+IGfZZN7fEK9LT/HxlkpZR3WbvDW9Spsppbw/ph1pcMEUk3V8zg0fMbYbmEBrvT5gdK0Yn9NwQ==
X-Received: by 2002:a05:6000:1a43:b0:34a:5663:410 with SMTP id t3-20020a0560001a4300b0034a56630410mr4506887wry.5.1714046411120;
        Thu, 25 Apr 2024 05:00:11 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id e37-20020a5d5965000000b0034a44c615ddsm17752847wri.88.2024.04.25.05.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 05:00:10 -0700 (PDT)
Message-ID: <b330dfad-1ba6-4172-a76b-b965221b15f6@gmail.com>
Date: Thu, 25 Apr 2024 13:59:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3 1/2] net: gro: fix udp bad offset in socket lookup
 by adding {inner_}network_offset to napi_gro_cb
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 alobakin@pm.me, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240424163045.123528-1-richardbgobert@gmail.com>
 <20240424163045.123528-2-richardbgobert@gmail.com>
 <6629bcc9486a3_1bd6b02949c@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <6629bcc9486a3_1bd6b02949c@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("udp:
>> additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in the
>> complete phase of gro. The functions always return skb->network_header,
>> which in the case of encapsulated packets at the gro complete phase, is
>> always set to the innermost L3 of the packet. That means that calling
>> {ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
>> gro_list and *_gro_complete) when parsing an encapsulated packet's _outer_
>> L3/L4 may return an unexpected value.
>>
>> This incorrect usage leads to a bug in GRO's UDP socket lookup.
>> udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. These
>> *_hdr functions return network_header which will point to the innermost L3,
>> resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
>> encapsulated packets.
>>
>> This patch adds network_offset and inner_network_offset to napi_gro_cb, and
>> makes sure both are set correctly.
>>
>> To fix the issue, network_offsets union is used inside napi_gro_cb, in
>> which both the outer and the inner network offsets are saved.
>>
>> Reproduction example:
>>
>> Endpoint configuration example (fou + local address bind)
>>
>>     # ip fou add port 6666 ipproto 4
>>     # ip link add name tun1 type ipip remote 2.2.2.1 local 2.2.2.2 encap fou encap-dport 5555 encap-sport 6666 mode ipip
>>     # ip link set tun1 up
>>     # ip a add 1.1.1.2/24 dev tun1
>>
>> Netperf TCP_STREAM result on net-next before patch is applied:
>>
>> net-next main, GRO enabled:
>>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>>     Recv   Send    Send
>>     Socket Socket  Message  Elapsed
>>     Size   Size    Size     Time     Throughput
>>     bytes  bytes   bytes    secs.    10^6bits/sec
>>
>>     131072  16384  16384    5.28        2.37
>>
>> net-next main, GRO disabled:
>>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>>     Recv   Send    Send
>>     Socket Socket  Message  Elapsed
>>     Size   Size    Size     Time     Throughput
>>     bytes  bytes   bytes    secs.    10^6bits/sec
>>
>>     131072  16384  16384    5.01     2745.06
>>
>> patch applied, GRO enabled:
>>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>>     Recv   Send    Send
>>     Socket Socket  Message  Elapsed
>>     Size   Size    Size     Time     Throughput
>>     bytes  bytes   bytes    secs.    10^6bits/sec
>>
>>     131072  16384  16384    5.01     2877.38
>>
>> Fixes: 57c67ff4bd92 ("udp: additional GRO support")
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> ---
>>  include/net/gro.h        | 18 ++++++++++++++++--
>>  net/8021q/vlan_core.c    |  2 ++
>>  net/core/gro.c           |  1 +
>>  net/ipv4/af_inet.c       |  5 +----
>>  net/ipv4/tcp_offload.c   |  3 ++-
>>  net/ipv4/udp.c           |  3 ++-
>>  net/ipv4/udp_offload.c   |  3 ++-
>>  net/ipv6/ip6_offload.c   |  6 +++---
>>  net/ipv6/tcpv6_offload.c |  3 ++-
>>  net/ipv6/udp.c           |  3 ++-
>>  net/ipv6/udp_offload.c   |  3 ++-
>>  11 files changed, 35 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/net/gro.h b/include/net/gro.h
>> index 50f1e403dbbb..1faff23b66e8 100644
>> --- a/include/net/gro.h
>> +++ b/include/net/gro.h
>> @@ -87,6 +87,15 @@ struct napi_gro_cb {
>>  
>>  	/* used to support CHECKSUM_COMPLETE for tunneling protocols */
>>  	__wsum	csum;
>> +
>> +	/* L3 offsets */
>> +	union {
>> +		struct {
>> +			u16 network_offset;
>> +			u16 inner_network_offset;
>> +		};
>> +		u16 network_offsets[2];
>> +	};
>>  };
>>  
>>  #define NAPI_GRO_CB(skb) ((struct napi_gro_cb *)(skb)->cb)
>> @@ -172,12 +181,17 @@ static inline void *skb_gro_header(struct sk_buff *skb, unsigned int hlen,
>>  	return ptr;
>>  }
>>  
>> +static inline int skb_gro_network_offset(const struct sk_buff *skb)
>> +{
>> +	return NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark];
>> +}
>> +
>>  static inline void *skb_gro_network_header(const struct sk_buff *skb)
>>  {
>>  	if (skb_gro_may_pull(skb, skb_gro_offset(skb)))
>> -		return skb_gro_header_fast(skb, skb_network_offset(skb));
>> +		return skb_gro_header_fast(skb, skb_gro_network_offset(skb));
>>  
>> -	return skb_network_header(skb);
>> +	return skb->data + skb_gro_network_offset(skb);
>>  }
>>  
>>  static inline __wsum inet_gro_compute_pseudo(const struct sk_buff *skb,
>> diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
>> index f00158234505..9404dd551dfd 100644
>> --- a/net/8021q/vlan_core.c
>> +++ b/net/8021q/vlan_core.c
>> @@ -478,6 +478,8 @@ static struct sk_buff *vlan_gro_receive(struct list_head *head,
>>  	if (unlikely(!vhdr))
>>  		goto out;
>>  
>> +	NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = hlen;
>> +
>>  	type = vhdr->h_vlan_encapsulated_proto;
>>  
>>  	ptype = gro_find_receive_by_type(type);
>> diff --git a/net/core/gro.c b/net/core/gro.c
>> index 83f35d99a682..c7901253a1a8 100644
>> --- a/net/core/gro.c
>> +++ b/net/core/gro.c
>> @@ -371,6 +371,7 @@ static inline void skb_gro_reset_offset(struct sk_buff *skb, u32 nhoff)
>>  	const skb_frag_t *frag0;
>>  	unsigned int headlen;
>>  
>> +	NAPI_GRO_CB(skb)->network_offset = 0;
>>  	NAPI_GRO_CB(skb)->data_offset = 0;
>>  	headlen = skb_headlen(skb);
>>  	NAPI_GRO_CB(skb)->frag0 = skb->data;
>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>> index 55bd72997b31..2daf635ab99e 100644
>> --- a/net/ipv4/af_inet.c
>> +++ b/net/ipv4/af_inet.c
>> @@ -1568,10 +1568,7 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
>>  
>>  	NAPI_GRO_CB(skb)->is_atomic = !!(iph->frag_off & htons(IP_DF));
>>  	NAPI_GRO_CB(skb)->flush |= flush;
>> -	skb_set_network_header(skb, off);
>> -	/* The above will be needed by the transport layer if there is one
>> -	 * immediately following this IP hdr.
>> -	 */
>> +	NAPI_GRO_CB(skb)->inner_network_offset = off;
>>  
>>  	/* Note : No need to call skb_gro_postpull_rcsum() here,
>>  	 * as we already checked checksum over ipv4 header was 0
>> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
>> index ebe4722bb020..be8ddf6da88c 100644
>> --- a/net/ipv4/tcp_offload.c
>> +++ b/net/ipv4/tcp_offload.c
>> @@ -332,7 +332,8 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
>>  
>>  INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>>  {
>> -	const struct iphdr *iph = ip_hdr(skb);
>> +	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
>> +	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
>>  	struct tcphdr *th = tcp_hdr(skb);
>>  
>>  	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index c02bf011d4a6..1399fce82b3f 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -532,7 +532,8 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
>>  struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
>>  				 __be16 sport, __be16 dport)
>>  {
>> -	const struct iphdr *iph = ip_hdr(skb);
>> +	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
>> +	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
>>  	struct net *net = dev_net(skb->dev);
>>  	int iif, sdif;
>>  
>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>> index 3498dd1d0694..fd29d21d579c 100644
>> --- a/net/ipv4/udp_offload.c
>> +++ b/net/ipv4/udp_offload.c
>> @@ -718,7 +718,8 @@ EXPORT_SYMBOL(udp_gro_complete);
>>  
>>  INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
>>  {
>> -	const struct iphdr *iph = ip_hdr(skb);
>> +	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
>> +	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
>>  	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
>>  
>>  	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
>> diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
>> index b41e35af69ea..5d6b875a4638 100644
>> --- a/net/ipv6/ip6_offload.c
>> +++ b/net/ipv6/ip6_offload.c
>> @@ -67,7 +67,7 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
>>  		off += len;
>>  	}
>>  
>> -	skb_gro_pull(skb, off - skb_network_offset(skb));
>> +	skb_gro_pull(skb, off - skb_gro_network_offset(skb));
>>  	return proto;
>>  }
>>  
>> @@ -236,7 +236,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
>>  	if (unlikely(!iph))
>>  		goto out;
>>  
>> -	skb_set_network_header(skb, off);
>> +	NAPI_GRO_CB(skb)->inner_network_offset = off;
>>  
>>  	flush += ntohs(iph->payload_len) != skb->len - hlen;
>>  
>> @@ -259,7 +259,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
>>  	NAPI_GRO_CB(skb)->proto = proto;
>>  
>>  	flush--;
>> -	nlen = skb_network_header_len(skb);
>> +	nlen = skb_gro_offset(skb) - off;
>>  
>>  	list_for_each_entry(p, head, list) {
>>  		const struct ipv6hdr *iph2;
>> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
>> index 4b07d1e6c952..e70d60e0f86f 100644
>> --- a/net/ipv6/tcpv6_offload.c
>> +++ b/net/ipv6/tcpv6_offload.c
>> @@ -29,7 +29,8 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
>>  
>>  INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
>>  {
>> -	const struct ipv6hdr *iph = ipv6_hdr(skb);
>> +	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
>> +	const struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + offset);
>>  	struct tcphdr *th = tcp_hdr(skb);
>>  
> 
> Only udp code is affected, as only that can be used as tunnel.
> 
> For bug fixes, let's try to avoid touching other code. Also that vlan.
> 
> As a minimal patch all that is needed is the following, right?
> 
> - add the fields
> - store in inet_gro_receive + ipv6_gro_receive
> - read in udp[46]_gro_complete and udp[46]_lib_lookup_skb
> 

This approach is smaller, thanks for writing it down.

What do you think about doing this and still writing to
inner_network_offset exclusively in {inet,ipv6}_gro_receive? I still
prefer it for reasons discussed in the previous series. The code line
in vlan_gro_receive will still be there, but that will be the only
addition to your snippet.


Return-Path: <linux-kernel+bounces-76984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093E685FF7C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A971F1F24D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA68156963;
	Thu, 22 Feb 2024 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srgcWdDm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F2155A25;
	Thu, 22 Feb 2024 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623308; cv=none; b=FrTUr0389ih9sfS1+/tUb/m+ZhcXvgILW8DlJOs0ho2APE3jpbfZyzwkoMzzFdYDF9/qxOxbs7/px7Q7CfwUmx3/Iedd/XT4SSQe6Arpg//sstZvAXiM1TLkDcTdTVYhP8+SZfJOeHWJmR/LdInwV5F6ypgYBL7qgY9An6g+qZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623308; c=relaxed/simple;
	bh=Rm3KmX/20MyE/pBe5XIZLZ0qukDoVnPD2x9pciHFLFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AZUiOK4RTrehl+exHm3jikSX1el2G5LML16i9QDKcSFtfyHMulo8iTke7onDEllvup1mGl1KzB9K4Ms90BxBww80Hul4aL55NTdurvyVU9wz6boeMY90TteREWU0hywz/jBedyEc+DPwx2YZpuk0U7vkb3g8FiD1nY7g7hVzLf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srgcWdDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBE3C433C7;
	Thu, 22 Feb 2024 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708623307;
	bh=Rm3KmX/20MyE/pBe5XIZLZ0qukDoVnPD2x9pciHFLFw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=srgcWdDmx1hgkOzRUfnrR0kcZAcKlleQ0mZra3FYOa3lYq6klC7Gqiw+5TqxV2c+6
	 Wzcb22pw8FguskCFYzoajzxulhI9S9Ld4Dw7lr/knSUzSbwvp/9Z1LvS0jPZt0NmP8
	 aLZZoe/a9iDcH6ZhoF67PhnexKWaVGgawt9nO2medZXLSeJNBjgjdGayjR96tyBUB2
	 UgVmm5k0P53WMwhMtJ15+1T6mXyD9gQ07U+pxTmr6oH5q3xjW/hSnliJVGBSnNQpKU
	 vXqp9h1UygOYV9Gw8lZSQjun3h7wfT8s+I5skovh+Sih2Rfl21tRqmydLz43dLoqrV
	 uXYegx11fhmgA==
Message-ID: <1161ecf9-9db7-42b5-a277-d92b2672dc89@kernel.org>
Date: Thu, 22 Feb 2024 10:35:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: ipv6: hop tlv ext hdr parsing
Content-Language: en-US
To: Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9b82bb29-9316-4dfd-8c56-f8a294713c16@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <9b82bb29-9316-4dfd-8c56-f8a294713c16@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/24 3:03 AM, Richard Gobert wrote:
> This patch introduces 'hop_tlv_hdr' and 'hop_calipso_hdr' structs, in
> order to access fields in a readable way in "ip6_parse_tlv".
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/ipv6.h | 16 ++++++++++++++++
>  net/ipv6/exthdrs.c | 30 +++++++++++++++++-------------
>  2 files changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index cf25ea21d770..61677946ed46 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -151,6 +151,22 @@ struct frag_hdr {
>  	__be32	identification;
>  };
>  
> +struct hop_tlv_hdr {
> +	u8	tlv_type;
> +	u8	tlv_len;
> +};
> +
> +/* CALIPSO RFC 5570 */
> +struct hop_calipso_hdr {
> +	u8	tlv_type;
> +	u8	tlv_len;
> +	u32	domain_interpretation;
> +	u8	cmpt_len;
> +	u8	sens_lvl;
> +	u16	checksum;
> +	u64	cmpt_bitmap;
> +} __packed;
> +
>  /*
>   * Jumbo payload option, as described in RFC 2675 2.
>   */
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 4952ae792450..5db624299da4 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -114,7 +114,7 @@ static bool ip6_parse_tlv(bool hopbyhop,
>  			  struct sk_buff *skb,
>  			  int max_count)
>  {
> -	int len = (skb_transport_header(skb)[1] + 1) << 3;
> +	int len = ipv6_optlen((struct ipv6_opt_hdr *)skb_transport_header(skb));
>  	const unsigned char *nh = skb_network_header(skb);
>  	int off = skb_network_header_len(skb);
>  	bool disallow_unknowns = false;
> @@ -890,15 +890,16 @@ static inline struct net *ipv6_skb_net(struct sk_buff *skb)
>  
>  static bool ipv6_hop_ra(struct sk_buff *skb, int optoff)
>  {
> -	const unsigned char *nh = skb_network_header(skb);
> +	struct hop_tlv_hdr *tlv_hdr =
> +		(struct hop_tlv_hdr *)(skb_network_header(skb) + optoff);
>  
> -	if (nh[optoff + 1] == 2) {
> +	if (tlv_hdr->tlv_len == 2) {
>  		IP6CB(skb)->flags |= IP6SKB_ROUTERALERT;
> -		memcpy(&IP6CB(skb)->ra, nh + optoff + 2, sizeof(IP6CB(skb)->ra));
> +		memcpy(&IP6CB(skb)->ra, tlv_hdr + 1, sizeof(IP6CB(skb)->ra));
>  		return true;
>  	}
>  	net_dbg_ratelimited("ipv6_hop_ra: wrong RA length %d\n",
> -			    nh[optoff + 1]);
> +			    tlv_hdr->tlv_len);
>  	kfree_skb_reason(skb, SKB_DROP_REASON_IP_INHDR);
>  	return false;
>  }
> @@ -961,18 +962,20 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
>  
>  static bool ipv6_hop_jumbo(struct sk_buff *skb, int optoff)
>  {
> -	const unsigned char *nh = skb_network_header(skb);
> +	int tlv_off = offsetof(struct hop_jumbo_hdr, tlv_type);
> +	struct hop_jumbo_hdr *jumbo_hdr = (struct hop_jumbo_hdr *)
> +		(skb_network_header(skb) + optoff - tlv_off);
>  	SKB_DR(reason);
>  	u32 pkt_len;
>  
> -	if (nh[optoff + 1] != 4 || (optoff & 3) != 2) {
> +	if (jumbo_hdr->tlv_len != 4 || (optoff & 3) != 2) {
>  		net_dbg_ratelimited("ipv6_hop_jumbo: wrong jumbo opt length/alignment %d\n",
> -				    nh[optoff+1]);
> +				    jumbo_hdr->tlv_len);
>  		SKB_DR_SET(reason, IP_INHDR);
>  		goto drop;
>  	}
>  
> -	pkt_len = ntohl(*(__be32 *)(nh + optoff + 2));
> +	pkt_len = ntohl(jumbo_hdr->jumbo_payload_len);
>  	if (pkt_len <= IPV6_MAXPLEN) {
>  		icmpv6_param_prob_reason(skb, ICMPV6_HDR_FIELD, optoff + 2,
>  					 SKB_DROP_REASON_IP_INHDR);
> @@ -1004,15 +1007,16 @@ static bool ipv6_hop_jumbo(struct sk_buff *skb, int optoff)
>  
>  static bool ipv6_hop_calipso(struct sk_buff *skb, int optoff)
>  {
> -	const unsigned char *nh = skb_network_header(skb);
> +	struct hop_calipso_hdr *calipso_hdr =
> +		(struct hop_calipso_hdr *)(skb_network_header(skb) + optoff);
>  
> -	if (nh[optoff + 1] < 8)
> +	if (calipso_hdr->tlv_len < 8)
>  		goto drop;
>  
> -	if (nh[optoff + 6] * 4 + 8 > nh[optoff + 1])
> +	if (calipso_hdr->cmpt_len * 4 + 8 > calipso_hdr->tlv_len)
>  		goto drop;
>  
> -	if (!calipso_validate(skb, nh + optoff))
> +	if (!calipso_validate(skb, (const unsigned char *)calipso_hdr))
>  		goto drop;
>  
>  	return true;

In addition to restoring the const that Denis commented, this really
wants to be multiple patches in a set. Also, it would be best to have
selftests as well that exercise the code paths.




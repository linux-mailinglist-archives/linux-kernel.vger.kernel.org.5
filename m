Return-Path: <linux-kernel+bounces-74512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2998E85D554
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D91B1C2295E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389453D98E;
	Wed, 21 Feb 2024 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uorW3VS5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qT70EC1s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z4kYwUEL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vIC4n8//"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68E3C493;
	Wed, 21 Feb 2024 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510807; cv=none; b=LKwjK4mS2kuMDAfYkef/Tu/kNw/WCxFfpYG6AFby/+YC5GNtDmfQ34AqYG76U4wYPVS3mISo/C0HpkosOOKmFWzmlxz8d83Q4rqC+EoCDWj+Cg2RD3xf1S3x+mDenWAR5gdVf43yrEcZLop8KW2NF6aM8PJmizraokZ9kRFfffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510807; c=relaxed/simple;
	bh=ZWZGKUDl6RZGBEdoSWzt3+EqUDhpEXpPugj6iZGn7m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AjaPJWTBRO5RmQx2u8JbVP+pxknQdpysSav3NmilQoaHhzcXbzwyTYlWVfG85DyCWulCQxfsMkFBq6jp3joen+zZtrljjCAIKxPF3lLwfSTgxMf2rHZZspn3Es+g6hUHR3SY2QVW8eifC52ykRYgVkoszEaJpIVAD5bKE00LotI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uorW3VS5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qT70EC1s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z4kYwUEL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vIC4n8//; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E653B21E3B;
	Wed, 21 Feb 2024 10:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708510804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJXFVArpT3O61MOA5anWtuT7A38MsNK9KzOtcIoD6Ao=;
	b=uorW3VS5DCOUlb7azuHT4M+blSdNcOUpc48hfNEG149gyWotAqolFzcFAwJxlREA1ftbjc
	7IRVex1gqg0mMoD1yZYjRd/sz2AgGQQ3MYaK+Gf5aNUhcZxVB4aSM1c/tsMibm7PwgtZAv
	qSJ9z0y1Je/fRc0YIRLtkly3KW+KoKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708510804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJXFVArpT3O61MOA5anWtuT7A38MsNK9KzOtcIoD6Ao=;
	b=qT70EC1sNhhoRPqRfYuQ1khz5WBhOCrd65cHo/v5zwsjRrkYMc+atY+kWyitbFzJJru0RZ
	UrLqkdYjHkb7+MBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708510803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJXFVArpT3O61MOA5anWtuT7A38MsNK9KzOtcIoD6Ao=;
	b=Z4kYwUELR9X4cfjksi0vYVuqY1Q0pDLUvgMsMh7Q9t0lq77wX/iAqnhgEZdfonrXZR4guW
	8+ohv1D6NYGojvwOJ6O9dK476eH3/IYpjfntUAZMiMrzPymUFBUdE3nHEHMVXs3b7Jt8oK
	ab0PGbfs69dg8gX0BbCkbRZZZhEH8h4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708510803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJXFVArpT3O61MOA5anWtuT7A38MsNK9KzOtcIoD6Ao=;
	b=vIC4n8//yEE6lEa50Cpcho9qZqz4Mv90jkCDL8TIt+B4O3fxBegosXdXoR3dmm+4fueuL1
	FcdKpHv3QIPfWLAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 647F0139D1;
	Wed, 21 Feb 2024 10:20:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id bYu0FFPO1WUlFAAAn2gu4w
	(envelope-from <dkirjanov@suse.de>); Wed, 21 Feb 2024 10:20:03 +0000
Message-ID: <6fd57afc-f88c-41b1-b31b-f96579145827@suse.de>
Date: Wed, 21 Feb 2024 13:20:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: ipv6: hop tlv ext hdr parsing
To: Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9b82bb29-9316-4dfd-8c56-f8a294713c16@gmail.com>
Content-Language: en-US
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <9b82bb29-9316-4dfd-8c56-f8a294713c16@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.09



On 2/21/24 13:03, Richard Gobert wrote:
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
You've forgotten to contstify your struct here and below

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


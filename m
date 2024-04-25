Return-Path: <linux-kernel+bounces-158784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1338A8B24E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2A3281997
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07CD14AD24;
	Thu, 25 Apr 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoMDjhYe"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDE237152;
	Thu, 25 Apr 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058243; cv=none; b=od2f8co8tZGkga0hBLBjxo32olpr1kyMmDGNTJnayWArkOGUsElR/aKyBV30ZflDsbNljc7KRO/LYYLVPezA/U8WjfwX7+oI0YPGqnB+jqjyBQYt/z4nd7jM42To3cEsA5txP+4Gte9ill/Yy+dhOBPXqb14sTjZBPorX84JQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058243; c=relaxed/simple;
	bh=NyXHvmLZz8zCA1WSNDr/ZsGXkco2uGIpPV6bacmAaJs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nHIZs/M5Bdy76g20yT2skYtHzGS0S0K9sxR66u5ioaYZYYWSq8B59gG7qTEtQ0Ap3iJVld/lASurJoWU7NshP4wvG68ece+UtVG1kfPDKTyl1+bOan3xecll27peN2QgcMqb1KoNVC+VapK+nUHeqSL71CeI6W3q7VKGogxEbzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoMDjhYe; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78f02298dc6so96953285a.1;
        Thu, 25 Apr 2024 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714058240; x=1714663040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x75rcgd1WZX02fFS2R1uxG8FYxRqmmpdo9LK26BpYN4=;
        b=FoMDjhYeU6BPTOSrt4grvKlv7ejx59wPtdIUzgI5VeYi6Gy0Z+5w1Tz4SezylGCEyp
         GvLhGAGVhGbqxSAyDquyQ7weR+LmYPHR9S518cQAmanLfYPEU+Yhw1Qizbjer0aVyhkj
         Kj/8VfoTwxXFSCgwGLFU1hH6wR+49jw5DToNE97XCCcXucns1J59kvuuhil1Wi5XmA8n
         euqMMo3h0z/0gdw7LRbYt/h8aRzTdX/vw2Om92qOB6QBsDocsfEhp5mRLEa4q+3edlY5
         DCRMFQJgFzN2/2OoHzzCzlLaN3qSVILfJ+9URCZagBccxYJtW6lK/QOmnfuAVd72WQ+l
         ulHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714058240; x=1714663040;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x75rcgd1WZX02fFS2R1uxG8FYxRqmmpdo9LK26BpYN4=;
        b=Amk3ziZ334LYQSZ+y/Teo7DVWNYaLNwAbK5zzuwSEUUC1t2reRmzdR89n+RuBgbfWU
         DSuqZvt1nEoooLasXxAl74W+23CLX8Le008IVl0WkJG+ZnEml9kieaQGZk/TFpYVYIQI
         xOVkVJkiIF9ujyyNVSaF2CLkL5H62CzQh0CT5sapHJJzxLcgFJM1xK8odUgemD8UtCfH
         0Yp+MDlG1YPhap9/U0MQT0m/nXoZDhd6mbxqJeMwwd7GsTNFbgwsXom2U4mgHLNTRILe
         /Z2RZ7djdwfboYDxxE08QNuxdiqVNN57lGYoKKBIF50yIKHOYBraHQZyPKsV0AM/oVny
         D6jg==
X-Forwarded-Encrypted: i=1; AJvYcCW98O+ZvM4ZQXXxonmjCgDzA5GBgIW8CfmTuNlWBl9xtvAav1dhY41eaKWAp9m2JgeJ/tbBO3j/K0DJ7RAd+Q7TuoIBT9aiR9j5zL25FlO3YPT/fGMlWzDB5DIjyuPxA2Ke/dhh
X-Gm-Message-State: AOJu0Yw07j+owuGNP5Mmmr5hcCIWx2F+ho9BsMwv/iGhdw0lWmnOz2tr
	3UWwEIfQpby/gmZx08BUkJQNP1UtmA6qp/kRiX1arBbW0zopaPKKsvZENQ==
X-Google-Smtp-Source: AGHT+IFBfCpZhQZ7/W7MKJfETDSIG6OSdQZI9Jd/FO1VQetL9CAUU/ExHdb2gA7cfilvzV1Lp1ZS2g==
X-Received: by 2002:a05:620a:31a2:b0:790:9666:5c8a with SMTP id bi34-20020a05620a31a200b0079096665c8amr4921395qkb.19.1714058240597;
        Thu, 25 Apr 2024 08:17:20 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id k6-20020a05620a07e600b007905e4a1ae1sm5635698qkk.96.2024.04.25.08.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 08:17:20 -0700 (PDT)
Date: Thu, 25 Apr 2024 11:17:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, 
 netdev@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, 
 linux-kernel@vger.kernel.org
Message-ID: <662a73ffea9df_1e1a162941e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240425150432.44142-3-nbd@nbd.name>
References: <20240425150432.44142-1-nbd@nbd.name>
 <20240425150432.44142-3-nbd@nbd.name>
Subject: Re: [PATCH v2 net-next v2 2/5] net: add support for segmenting TCP
 fraglist GSO packets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Felix Fietkau wrote:
> Preparation for adding TCP fraglist GRO support. It expects packets to be
> combined in a similar way as UDP fraglist GSO packets.
> For IPv4 packets, NAT is handled in the same way as UDP fraglist GSO.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c   | 69 ++++++++++++++++++++++++++++++++++++++++
>  net/ipv6/tcpv6_offload.c |  3 ++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index fab0973f995b..e455f884190c 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -28,6 +28,72 @@ static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
>  	}
>  }
>  
> +static void __tcpv4_gso_segment_csum(struct sk_buff *seg,
> +				     __be32 *oldip, __be32 *newip,
> +				     __be16 *oldport, __be16 *newport)
> +{
> +	struct tcphdr *th;
> +	struct iphdr *iph;
> +
> +	if (*oldip == *newip && *oldport == *newport)
> +		return;
> +
> +	th = tcp_hdr(seg);
> +	iph = ip_hdr(seg);
> +
> +	inet_proto_csum_replace4(&th->check, seg, *oldip, *newip, true);
> +	inet_proto_csum_replace2(&th->check, seg, *oldport, *newport, false);
> +	*oldport = *newport;
> +
> +	csum_replace4(&iph->check, *oldip, *newip);
> +	*oldip = *newip;
> +}
> +
> +static struct sk_buff *__tcpv4_gso_segment_list_csum(struct sk_buff *segs)
> +{
> +	struct sk_buff *seg;
> +	struct tcphdr *th, *th2;
> +	struct iphdr *iph, *iph2;
> +	__be32 flags, flags2;
> +
> +	seg = segs;
> +	th = tcp_hdr(seg);
> +	iph = ip_hdr(seg);
> +	flags = tcp_flag_word(th);
> +	flags2 = tcp_flag_word(tcp_hdr(seg->next));

Vestigial, now that flag overwrite is removed in v2?

All this code is very similar to __udpv4_gso_segment_list_csum. But
the zero checksum handling in __udpv4_gso_segment_csum makes it just
different enough that I also do not immediately see a straightforward
way to avoid duplicating.


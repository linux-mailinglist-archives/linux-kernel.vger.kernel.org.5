Return-Path: <linux-kernel+bounces-130598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D668E897A4C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6ED28A343
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7417C15664A;
	Wed,  3 Apr 2024 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bMjpQfbV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CIQGSrnF"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3400153BF3;
	Wed,  3 Apr 2024 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178002; cv=none; b=XV8d7gCfz48laHKaS+kGhiSGC/2CjtfuhbaM6LSn46gEGtioFFImvQHaahOxsYq6ZpqEfla+gU383yw577qRXEksSax3B7LC9ougV01eFKe0QWPJ0D4ZMvPAu/UKR64G68ijMwPhqKi5jacAl04M87cr6GpuBvzF/CATkoA6kfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178002; c=relaxed/simple;
	bh=z2aFj7Yero9UEAl+EmXBknvXwFagdYrg8gO/nPAA5PI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=YxH7PfYQJdLJBaRKZo/lvdfNWmn78kCSvfAfkZnUNmolscKQdGA44BXMJhMSYgFIcVFbmIS9FOrnFcGJFk3cA0ejoSprfWe/t48sz8H8lPDb3qGaQrpsLBW3BZX7i9+kAwJ83T98IGYG9FQ8/5RMzTTzePG45HPlYB9Qv9Y+RtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bMjpQfbV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CIQGSrnF; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 506BD180010E;
	Wed,  3 Apr 2024 16:59:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 16:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712177997; x=1712264397; bh=TkyKpF4n3C
	q52s0X3ZL3E7R1KrZzCnoADc0YqLDsh/k=; b=bMjpQfbVCi8Fq8X/stkrxnmNLa
	a9eEqq1QgwOAfhJa8IBNoTc9TmPgl8k37iGa3Plj+yL82KuU/DHLiW+B0EgYL82c
	02tVQS6fGmyZwYLxqYe78UZVRUV2mMN5Esd/08WwqhNyFJnJG5un/99DDmFMwWJW
	Az5K6oBjccQ59rLVezsvSSIgR8itvVTkbtC7jvrMY7NfxDzqNxrboKzUGqXNJQNi
	YyEsWKJ6or2z1WSTEA2riV00U8oJRsjYk9nuZTZA0u6iQkwzng051T0bgvZmXXPP
	VRHZnfJUFtIoxLojPbaHAglzRdn7e1lXGHeVQhMviK/+OorI/43OpHbHQFVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712177997; x=1712264397; bh=TkyKpF4n3Cq52s0X3ZL3E7R1KrZz
	CnoADc0YqLDsh/k=; b=CIQGSrnFZRNZgMpARGSyCT5M46ioL1XGSw7MA0g7Rydv
	zQYYjGI4sejaWCkb1bXdvVklGyJXheHuMfcxVjySSplR2bL7EkH3oyVUTIcl3Gai
	GRPNR2tZJraIWZvwn5KzpR22QuKSAe+H/q/bRz04wgH0bXdpjj0tB9CO4CCBuABc
	JG6u7OvcvJPWSiT9jPR78+639l1b3s8ex+E/W3xiVe/aTUxK9Sv6x4pVOmIGaBI3
	2bEcxjq0cO+cB5msjHtB12nJhcKNH0JPZEy/brteYOce2+8Nno6d0bwX3DLJrcdy
	m4VzX7YEp2FHkgYzSIWEumxrId/cRz6NUlyjxfgMOQ==
X-ME-Sender: <xms:TcMNZvjGxtVaQ7lJjPrnjJiTRcLqVvdevj2JGj5ygxkyvaxZTq-XgQ>
    <xme:TcMNZsCj-2Cg0iMiPgYRpqHhfvGdEB9yBlad668jZ-4CemOPfrP93fsBvHPVn709S
    WLbvOnbNIIlgnQNirg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:TcMNZvGQo8zIv4XpkRoy1AW70Hn1lLnDuoKeh7BaArgh2j3x8KRF4Q>
    <xmx:TcMNZsSo7PaGRkdKyfCOrEEhQYGxMzdS9B_wky1316eTKOsQGv_gzg>
    <xmx:TcMNZsy3V4u7Ht2CEsSf1pQF8CxUAU3s06Fo95V0PBgEmgUVe73JZQ>
    <xmx:TcMNZi4mcfwK233dblrueIHu9lqApYhCEdnUP2bH5oTQyYtwjBFpWA>
    <xmx:TcMNZoDtsp2EnYCMaV-GyvV6o6vcniCi6pZD5YwF8kZEoqBIUsKE_tNZ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 251F5B6008D; Wed,  3 Apr 2024 16:59:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <701f8f93-f5fb-408b-822a-37a1d5c424ba@app.fastmail.com>
In-Reply-To: <20240327152358.2368467-20-aleksander.lobakin@intel.com>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
 <20240327152358.2368467-20-aleksander.lobakin@intel.com>
Date: Wed, 03 Apr 2024 22:59:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexander Lobakin" <aleksander.lobakin@intel.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Cc: "Yury Norov" <yury.norov@gmail.com>,
 "Alexander Potapenko" <glider@google.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Michal Swiatkowski" <michal.swiatkowski@linux.intel.com>,
 "Marcin Szycik" <marcin.szycik@linux.intel.com>,
 "Simon Horman" <horms@kernel.org>, "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH net-next v6 19/21] pfcp: always set pfcp metadata
Content-Type: text/plain

On Wed, Mar 27, 2024, at 16:23, Alexander Lobakin wrote:

> +static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
> +{
> +	IP_TUNNEL_DECLARE_FLAGS(flags) = { };
> +	struct metadata_dst *tun_dst;
> +	struct pfcp_metadata *md;
> +	struct pfcphdr *unparsed;
> +	struct pfcp_dev *pfcp;
> +
> +	if (unlikely(!pskb_may_pull(skb, PFCP_HLEN)))
> +		goto drop;
> +
> +	pfcp = rcu_dereference_sk_user_data(sk);
> +	if (unlikely(!pfcp))
> +		goto drop;
> +
> +	unparsed = pfcp_hdr(skb);
> +
> +	ip_tunnel_flags_zero(flags);
> +	tun_dst = udp_tun_rx_dst(skb, sk->sk_family, flags, 0,
> +				 sizeof(*md));
> +	if (unlikely(!tun_dst))
> +		goto drop;
> +
> +	md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
> +	if (unlikely(!md))
> +		goto drop;
> +
> +	if (unparsed->flags & PFCP_SEID_FLAG)
> +		pfcp_session_recv(pfcp, skb, md);
> +	else
> +		pfcp_node_recv(pfcp, skb, md);
> +
> +	__set_bit(IP_TUNNEL_PFCP_OPT_BIT, flags);
> +	ip_tunnel_info_opts_set(&tun_dst->u.tun_info, md, sizeof(*md),
> +				flags);
> +

The memcpy() in the ip_tunnel_info_opts_set() causes
a string.h fortification warning, with at least gcc-13:

    In function 'fortify_memcpy_chk',
        inlined from 'ip_tunnel_info_opts_set' at include/net/ip_tunnels.h:619:3,
        inlined from 'pfcp_encap_recv' at drivers/net/pfcp.c:84:2:
    include/linux/fortify-string.h:553:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
      553 |                         __write_overflow_field(p_size_field, size);

As far as I can tell, the warning is caused by the
ambiguity of the union, but what I noticed is that
it also seems to copy a buffer to itself, as 'md'
is initialized to tun_dst->u.tun_info as well.

Is this intentional?

      Arnd


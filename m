Return-Path: <linux-kernel+bounces-158109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 444568B1BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03708285B64
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12E76BFD4;
	Thu, 25 Apr 2024 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OmT1VuBa"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E537333998;
	Thu, 25 Apr 2024 07:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029513; cv=none; b=Md22pDxep22JTVByJfE/aYXOlCTktk8ODYA7Xa1R7KeMPm3OodnTmgwO/Cld/MJ0peM3X2VN0eck1vcPEanfoa3CXV8enc4LJ3qnoX6e3+wu8JWjiVRecGyAPzktu6bTmWV7ARphrSimpwh6d1/QC9ONidec1ngYowi4CSFXvro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029513; c=relaxed/simple;
	bh=CtIzOs4AG5fWmfykaA38i3gD9xUZxwUdbW+TQ3DYecE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1xV9+6bwgjduRb2Qmg6xK+PyVbHMJdGtRtTvpWpkiSiJdmdgPPR1jUjnedCP6FSTh3OXxCHJi3QsNibki+VW8zSK7ttLzxnMBgxRzCZNgLzrF4kK5vz9c9po1YePG8U8u4usAlalNiB/vQe8FnJtnTpqukvGBO33t05ipQHfM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OmT1VuBa; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D67431140106;
	Thu, 25 Apr 2024 03:18:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 25 Apr 2024 03:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714029510; x=1714115910; bh=TgLiFnIKrdny1qGtk4AXJIMvNsfr
	yUNeTWa7cQZ7fhk=; b=OmT1VuBaVvA/s+cW0JDJLKN+eIFPi1SnFx0wxInfBHLF
	83CI8SPqDCTzmkU+XTnT6dAkjbP1OwCKxFcrMbKmJE2gxJXMA4HSDXt3H3YJyLAl
	nByrQipK5wX0t6AnOdZQ/FGUk89vnmAVRN0Tdso4sPC5pIhJJmCFsOYUQRyMxUZF
	zq2DsC9WN8wfiNBrC66B8VEnygq9MJsjpZ+kUJ4Tcslfy1p4PhYTQaBeYnbEU4N7
	SaJH/2W7WamBT2IJwOJZya3xvzNJdwvdXO7+MkFaG8ThRABYZLUo2ZutngQR5Gmf
	0aj2umTCzSNAnL6JL4Rnz1LYWLAPnn/uj60x8eYM6Q==
X-ME-Sender: <xms:xgMqZlBaMuTJKKkN7-0nughPSEjS_fBERJmxp5X4KWvAIrgbjpolrg>
    <xme:xgMqZjhwSlCC67GT3FJrBRiABskeY2ogC0uGs8YVQEQPZMCW-H_mAQYa95ounrJ0U
    WA_vJHgkOKg094>
X-ME-Received: <xmr:xgMqZglwhAtKqMM_QGW7NclKg2_GAJxaWj-3SI0GHVtU9O-W9Nfutm-_DDvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeliedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeej
    geeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:xgMqZvw1Oz-JTNvS0BIPkhUv_BBACV5wTuyVIWkYsdKkG18qDoKM-Q>
    <xmx:xgMqZqQoSqfkV28ueM8VVvldqs5fwdCeK2JMzkQVo5NUvPnPAv5fRg>
    <xmx:xgMqZiZCLQswcQ60GLmpOFYLDCHJ5N0tuRnNqbqRT4q_REuyngHzTg>
    <xmx:xgMqZrTfWM2jhK9ukc91SCh0lxXYLooOLZqiGHhhy-rUAryJ3h_I7w>
    <xmx:xgMqZmYq0KhSjIJFv9ZBzgXWDy5UD4-33dvMM90y99DyrIPR0nWyEjZs>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 03:18:29 -0400 (EDT)
Date: Thu, 25 Apr 2024 10:18:22 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	horms@kernel.org, i.maximets@ovn.org,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/8] net: psample: add tracepoint
Message-ID: <ZioDvluh7ymBI8qF@shredder>
References: <20240424135109.3524355-1-amorenoz@redhat.com>
 <20240424135109.3524355-5-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424135109.3524355-5-amorenoz@redhat.com>

On Wed, Apr 24, 2024 at 03:50:51PM +0200, Adrian Moreno wrote:
> Currently there are no widely-available tools to dump the metadata and
> group information when a packet is sampled, making it difficult to
> troubleshoot related issues.
> 
> This makes psample use the event tracing framework to log the sampling
> of a packet so that it's easier to quickly identify the source
> (i.e: group) and context (i.e: metadata) of a packet being sampled.
> 
> This patch creates some checkpatch splats, but the style of the
> tracepoint definition mimics that of other modules so it seems
> acceptable.

I don't see a good reason to add this tracepoint (which we won't be able
to remove) when you can easily do that with bpftrace which by now should
be widely available:

#!/usr/bin/bpftrace

kfunc:psample_sample_packet
{
        $ts_us = nsecs() / 1000;
        $secs = $ts_us / 1000000;
        $us = $ts_us % 1000000;
        $group = args.group;
        $skb = args.skb;
        $md = args.md;

        printf("%-16s %-6d %6llu.%6llu group_num = %u refcount=%u seq=%u skbaddr=%p len=%u data_len=%u sample_rate=%u in_ifindex=%d out_ifindex=%d user_cookie=%rx\n",
               comm, pid, $secs, $us, $group->group_num, $group->refcount, $group->seq,
               $skb, $skb->len, $skb->data_len, args.sample_rate,
               $md->in_ifindex, $md->out_ifindex,
               buf($md->user_cookie, $md->user_cookie_len));
}

Example output:

mausezahn        984      3299.200626 group_num = 1 refcount=1 seq=13775 skbaddr=0xffffa21143fd4000 len=42 data_len=0 sample_rate=10 in_ifindex=0 out_ifindex=20 user_cookie=
\xde\xad\xbe\xef
mausezahn        984      3299.281424 group_num = 1 refcount=1 seq=13776 skbaddr=0xffffa21143fd4000 len=42 data_len=0 sample_rate=10 in_ifindex=0 out_ifindex=20 user_cookie=
\xde\xad\xbe\xef

Note that it prints the cookie itself unlike the tracepoint which only
prints the hashed pointer.

> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  net/psample/psample.c |  9 +++++++
>  net/psample/trace.h   | 62 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 net/psample/trace.h
> 
> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index 476aaad7a885..92db8ffa2ba2 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -18,6 +18,12 @@
>  #include <net/ip_tunnels.h>
>  #include <net/dst_metadata.h>
>  
> +#ifndef __CHECKER__
> +#define CREATE_TRACE_POINTS
> +#endif
> +
> +#include "trace.h"
> +
>  #define PSAMPLE_MAX_PACKET_SIZE 0xffff
>  
>  static LIST_HEAD(psample_groups_list);
> @@ -470,6 +476,9 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>  	void *data;
>  	int ret;
>  
> +	if (trace_psample_sample_packet_enabled())
> +		trace_psample_sample_packet(group, skb, sample_rate, md);

My understanding is that trace_x_enabled() should only be used if you
need to do some work to prepare parameters for the tracepoint.

> +
>  	meta_len = (in_ifindex ? nla_total_size(sizeof(u16)) : 0) +
>  		   (out_ifindex ? nla_total_size(sizeof(u16)) : 0) +
>  		   (md->out_tc_valid ? nla_total_size(sizeof(u16)) : 0) +


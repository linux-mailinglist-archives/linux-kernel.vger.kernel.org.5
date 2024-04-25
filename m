Return-Path: <linux-kernel+bounces-158797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDBA8B2506
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992AC287A10
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE9A14AD36;
	Thu, 25 Apr 2024 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LMh4SoTK"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4E514AD0D;
	Thu, 25 Apr 2024 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058713; cv=none; b=iRWesEYQC/ZlbK9HnY5Wy893QLr7ae1eIYWbqv1V7yYdT/gIfN03rL2FE4EBNvno2S1vDvJLGGy6sJ9mxu1fuHn/IEbu8skFgScP6ltKPwhaIVX//fWjNoO1prUpP60F7jP9JngXgO2K9FHClWt9AyXiJKkI/9+TPEQoH1cxxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058713; c=relaxed/simple;
	bh=D1YZtZoG/iorYX0P4Sd27XTodaOqG0lZGJunJ+yYmEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDOxBzrTP7UiunZxQqUE7f9eJG5wq/63YukTHkZkxEdzMGqO9/gGqO0UTm4IwQXZC8MM/+ezx1f+A4vCFsV1mJb/rz10FiGpgQH1NQF2Iwr13Tw7dKMcxtBfx/cffqnZqGpBeDhGp/QvoO+mj7yQpBSEUYDUDig4a4HAmOdqKVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LMh4SoTK; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 7399A1C0007D;
	Thu, 25 Apr 2024 11:25:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 25 Apr 2024 11:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714058708; x=1714145108; bh=X57KbIDS0KjetKwJGCKi+ngre7Ua
	Muq40Z/WbGCU/SI=; b=LMh4SoTKIn8IuTnRGPlthrieGlUHIuBboCGoivfxAwnX
	hJthLeCY3qo85efbCPE/PfQEicez/HThLVYte1Rdcwz3pGi0MwigQntgDESeLnI6
	/YW25M/Gj1yynfFwlypJbg/F7s9ucKf2V7w83k9hm4RdQYuCacHlHqVIRmn91BIR
	SW6WpgVNFBgv4st8OzvQPa8KbPDqGkiHt1QVHgmJ+DDujat8wIpolybRlQaq/IRK
	Dqd8TT53jZ1TkwZFv+oPao9wX8QlZAlDZdjw6YCwkfSwQpEhoq5GKsumHQW3FYwW
	UeyAcSlurrvnu/m6vp4EdnJxKcKA85roG0LENTBYNQ==
X-ME-Sender: <xms:1HUqZsyZRa2DNABfbHgcgjs-z2W803i-usJGhTjXFSsXvPBj7PRNaQ>
    <xme:1HUqZgTg1UY7pAP-zjzGCDm8vxnP7bmNemnTisp7sn95YgcgQVOYNDsNBGJpU3jB_
    67tvHvKoCWBoc8>
X-ME-Received: <xmr:1HUqZuVRZEOFO3m_xrzKiqn3NjoSlQi0VAutkeIowF1JkmyWaf4H7gk1YYhj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepveekteevgeehheeuffeikeeuuddvueehkedvjeefjeeuveejffejveeivdeu
    tedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghh
    sehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:1HUqZqgISi10DlSEGqiGPELARNnbMTLw0ZaDwPXuEw740f1yt0BS9g>
    <xmx:1HUqZuBjcLPVC9n62zedoE3BkA6ItGx82PSRTIkbziKORnTc6W-MMg>
    <xmx:1HUqZrJi_DNUJLd63QQaqnKvSZSHq6l0Ky-3Z2C65-18zG3pv75YFQ>
    <xmx:1HUqZlCD16031XrOi_suWl2x8m1J9w3t4KfuuCh1AOOYxg2pnU4oXw>
    <xmx:1HUqZvKFGOOOOmm4fdon-uNGqc5eN480707kKmmWNLQC36dnpZWfLXpX>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 11:25:07 -0400 (EDT)
Date: Thu, 25 Apr 2024 18:25:00 +0300
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
Message-ID: <Zip1zKzG5aF1ceom@shredder>
References: <20240424135109.3524355-1-amorenoz@redhat.com>
 <20240424135109.3524355-5-amorenoz@redhat.com>
 <ZioDvluh7ymBI8qF@shredder>
 <542ed8dd-2d9c-4e4f-81dc-e2a9bdaac3b0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542ed8dd-2d9c-4e4f-81dc-e2a9bdaac3b0@redhat.com>

On Thu, Apr 25, 2024 at 10:06:20AM +0200, Adrian Moreno wrote:
> 
> 
> On 4/25/24 09:18, Ido Schimmel wrote:
> > On Wed, Apr 24, 2024 at 03:50:51PM +0200, Adrian Moreno wrote:
> > > Currently there are no widely-available tools to dump the metadata and
> > > group information when a packet is sampled, making it difficult to
> > > troubleshoot related issues.
> > > 
> > > This makes psample use the event tracing framework to log the sampling
> > > of a packet so that it's easier to quickly identify the source
> > > (i.e: group) and context (i.e: metadata) of a packet being sampled.
> > > 
> > > This patch creates some checkpatch splats, but the style of the
> > > tracepoint definition mimics that of other modules so it seems
> > > acceptable.
> > 
> > I don't see a good reason to add this tracepoint (which we won't be able
> > to remove) when you can easily do that with bpftrace which by now should
> > be widely available:
> > 
> > #!/usr/bin/bpftrace
> > 
> > kfunc:psample_sample_packet
> > {
> >          $ts_us = nsecs() / 1000;
> >          $secs = $ts_us / 1000000;
> >          $us = $ts_us % 1000000;
> >          $group = args.group;
> >          $skb = args.skb;
> >          $md = args.md;
> > 
> >          printf("%-16s %-6d %6llu.%6llu group_num = %u refcount=%u seq=%u skbaddr=%p len=%u data_len=%u sample_rate=%u in_ifindex=%d out_ifindex=%d user_cookie=%rx\n",
> >                 comm, pid, $secs, $us, $group->group_num, $group->refcount, $group->seq,
> >                 $skb, $skb->len, $skb->data_len, args.sample_rate,
> >                 $md->in_ifindex, $md->out_ifindex,
> >                 buf($md->user_cookie, $md->user_cookie_len));
> > }
> > 
> > Example output:
> > 
> > mausezahn        984      3299.200626 group_num = 1 refcount=1 seq=13775 skbaddr=0xffffa21143fd4000 len=42 data_len=0 sample_rate=10 in_ifindex=0 out_ifindex=20 user_cookie=
> > \xde\xad\xbe\xef
> > mausezahn        984      3299.281424 group_num = 1 refcount=1 seq=13776 skbaddr=0xffffa21143fd4000 len=42 data_len=0 sample_rate=10 in_ifindex=0 out_ifindex=20 user_cookie=
> > \xde\xad\xbe\xef
> > 
> > Note that it prints the cookie itself unlike the tracepoint which only
> > prints the hashed pointer.
> > 
> 
> I agree that bpftrace can do the work relying on kfuncs/kprobes. But I guess
> that also true for many other tracepoints out there, right?

Maybe, but this particular tracepoint is not buried deep inside some
complex function with manipulated data being passed as arguments.
Instead, this tracepoint is placed at the very beginning of the function
and takes the function arguments as its own arguments. The tracepoint
can be easily replaced with fentry/kprobes like I've shown with the
example above.

> For development and labs bpftrace is perfectly fine, but using kfuncs and
> requiring recompilation is harder in production systems compared with using
> smaller CO-RE tools.

I used bpftrace because it is very easy to write, but I could have done
the same with libbpf. I have a bunch of such tools that I wrote over the
years that I compiled once on my laptop and which I copy to various
machines where I need them.

> If OVS starts using psample heavily and users need to troubleshoot or merely
> observe packets as they are sampled in a more efficient way, they are likely
> to use ebpf for that. I think making it a bit easier (as in, providing a
> sligthly more stable tracepoint) is worth considering.

I'm not saying that it's not worth considering, I'm simply saying that
it should be done after gathering operational experience with existing
mechanisms. It's possible you will conclude that this tracepoint is not
actually needed.

Also, there are some disadvantages in using tracepoints compared to
fentry:

https://github.com/Mellanox/mlxsw/commit/e996fd583eff1c43aacb9c79e55f5add12402d7d
https://lore.kernel.org/all/CAEf4BzbhvD_f=y3SDAiFqNvuErcnXt4fErMRSfanjYQg5=7GJg@mail.gmail.com/#t

Not saying that's the case here, but worth considering / being aware.

> Can you please expand on your concerns about the tracepoint? It's on the
> main internal function of the module so, even though the function name or
> its arguments might change, it doesn't seem probable that it'll disappear
> altogether. Why else would we want to remove the tracepoint?

It's not really concerns, but dissatisfaction. It's my impression (might
be wrong) that this series commits to adding new interfaces without
first seriously evaluating existing ones. This is true for this patch
and patch #2 that adds a new netlink command instead of using
SO_ATTACH_FILTER like existing applications are doing to achieve the
same goal.

I guess some will disagree, but wanted to voice my opinion nonetheless.


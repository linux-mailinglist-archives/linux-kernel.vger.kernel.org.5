Return-Path: <linux-kernel+bounces-163940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965C38B7658
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B5928236D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BC017107A;
	Tue, 30 Apr 2024 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G144KZ0m"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAEA17166D;
	Tue, 30 Apr 2024 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481642; cv=none; b=TSVpLFydhGwS/exO79Jkk6+5FZDgA7cP5IlhDy6NY/aAVFndymFnL1FNFhQ7sqDvc4QWlq2+8+7AwG2XFHV1OxX259t8XUttsp/o89HoxiCy2iSJh1Z9tC0CTfc6rcUo26bY7rVfd4YU/bW7ieHXV7WIn/PFiiBS/vFNWMcMy8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481642; c=relaxed/simple;
	bh=tL5/BubzDVOb76sV+8vjo94/1Qxodc//cf3CLYrDm5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqTiLnn+66vTkjpEMzW19Wj3ngJ8KbqYGqoOTyLDakrurW81iLvHnFRci3eoA7OywlNONp0b/XcqsdVyrREGqNfC7n6Pi6pktTanuSI2Sb/UFRf19L53YIGYYnyVxfcnqMucDS5GS3k9ySu4Ag52Q3tSGydtICRh+jhGG/MJ10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G144KZ0m; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7399C1800106;
	Tue, 30 Apr 2024 08:53:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 30 Apr 2024 08:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714481639; x=1714568039; bh=UMb/27eflIg4KhNXXlLDv0qw5Lk3
	FPbHkU73m7tOrYs=; b=G144KZ0mZIy5BaS0yCuPlQpNBHfnWHv8VvCTiyr13P5E
	AP2p7lFDDTfFj82cTePPp9ll4zz3Dnyogye6gMQxqylk8WmVp74J/xEE7Y6vYpB7
	8qCR0Vfr6bQgfuPvuqcpuRqTLK7iM91Ypg+FJEDop8T1lCVzMHwcK8e0ZyT95zkC
	A36vQ5iMWh+L8gPA2MA9HWOjevtzgaHMmk5ZyrR385t7G2EJN6N+xCUltsEfRrXF
	rr1ZakrbYJCYResvBvpYtSQmfFksgEivYnvmVWCNBvDAvzuuMIndE34EhjNV+W66
	8WYb/1EWCxXbNu4MlkJq731JUGFh3X+yOMg2sYSULg==
X-ME-Sender: <xms:5ukwZtKWJR7z3HxMVqa_aON8RsJQFCuPyOD7KrxNhf6zQmcb1b5U2g>
    <xme:5ukwZpL_DwnWBboNNroDiFOCpv1DxNpGbCDr5Id2h4b-uNVtjP3jvT-C23-N1I3Tu
    9QTwrDlISvYecM>
X-ME-Received: <xmr:5ukwZltVZWkEJoVaHmJc4fQTQhMUoz93bICBvfITy1dj5ZL9G1XtZvfJV87->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepveekteevgeehheeuffeikeeuuddvueehkedvjeefjeeuveejffejveeivdeu
    tedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghh
    sehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:5ukwZuaFnMm1zwe2vdcycsH2fGxiEu02zBC24HNESa_B2iwcSNE_YA>
    <xmx:5ukwZkZrPZiKkn5UPU3AIkHptU_WeJjZFDG598CrLMJLTXZHl-Mdcg>
    <xmx:5ukwZiAt9hnBnrMzIqFQ-36ju0V1uUtXtOHEclThDZaZ8CPrXdLmrw>
    <xmx:5ukwZiaIeQa49qW0V3s4xKghF4wpMzt3yY7WEYzbIOPZz356nM1j7Q>
    <xmx:5-kwZuDH8TTjQ_guntoqZQ-CyQ4fGDD3yWvRTebU75InyjqEGdLWzQJ7>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 08:53:58 -0400 (EDT)
Date: Tue, 30 Apr 2024 15:53:51 +0300
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
Message-ID: <ZjDp3wneirwcC_ij@shredder>
References: <20240424135109.3524355-1-amorenoz@redhat.com>
 <20240424135109.3524355-5-amorenoz@redhat.com>
 <ZioDvluh7ymBI8qF@shredder>
 <542ed8dd-2d9c-4e4f-81dc-e2a9bdaac3b0@redhat.com>
 <Zip1zKzG5aF1ceom@shredder>
 <96bd71d6-2978-435f-99f8-c31097487cac@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96bd71d6-2978-435f-99f8-c31097487cac@redhat.com>

On Mon, Apr 29, 2024 at 07:33:59AM +0200, Adrian Moreno wrote:
> 
> 
> On 4/25/24 17:25, Ido Schimmel wrote:
> > On Thu, Apr 25, 2024 at 10:06:20AM +0200, Adrian Moreno wrote:
> > > 
> > > 
> > > On 4/25/24 09:18, Ido Schimmel wrote:
> > > > On Wed, Apr 24, 2024 at 03:50:51PM +0200, Adrian Moreno wrote:
> > > > > Currently there are no widely-available tools to dump the metadata and
> > > > > group information when a packet is sampled, making it difficult to
> > > > > troubleshoot related issues.
> > > > > 
> > > > > This makes psample use the event tracing framework to log the sampling
> > > > > of a packet so that it's easier to quickly identify the source
> > > > > (i.e: group) and context (i.e: metadata) of a packet being sampled.
> > > > > 
> > > > > This patch creates some checkpatch splats, but the style of the
> > > > > tracepoint definition mimics that of other modules so it seems
> > > > > acceptable.
> > > > 
> > > > I don't see a good reason to add this tracepoint (which we won't be able
> > > > to remove) when you can easily do that with bpftrace which by now should
> > > > be widely available:
> > > > 
> > > > #!/usr/bin/bpftrace
> > > > 
> > > > kfunc:psample_sample_packet
> > > > {
> > > >           $ts_us = nsecs() / 1000;
> > > >           $secs = $ts_us / 1000000;
> > > >           $us = $ts_us % 1000000;
> > > >           $group = args.group;
> > > >           $skb = args.skb;
> > > >           $md = args.md;
> > > > 
> > > >           printf("%-16s %-6d %6llu.%6llu group_num = %u refcount=%u seq=%u skbaddr=%p len=%u data_len=%u sample_rate=%u in_ifindex=%d out_ifindex=%d user_cookie=%rx\n",
> > > >                  comm, pid, $secs, $us, $group->group_num, $group->refcount, $group->seq,
> > > >                  $skb, $skb->len, $skb->data_len, args.sample_rate,
> > > >                  $md->in_ifindex, $md->out_ifindex,
> > > >                  buf($md->user_cookie, $md->user_cookie_len));
> > > > }
> > > > 
> > > > Example output:
> > > > 
> > > > mausezahn        984      3299.200626 group_num = 1 refcount=1 seq=13775 skbaddr=0xffffa21143fd4000 len=42 data_len=0 sample_rate=10 in_ifindex=0 out_ifindex=20 user_cookie=
> > > > \xde\xad\xbe\xef
> > > > mausezahn        984      3299.281424 group_num = 1 refcount=1 seq=13776 skbaddr=0xffffa21143fd4000 len=42 data_len=0 sample_rate=10 in_ifindex=0 out_ifindex=20 user_cookie=
> > > > \xde\xad\xbe\xef
> > > > 
> > > > Note that it prints the cookie itself unlike the tracepoint which only
> > > > prints the hashed pointer.
> > > > 
> > > 
> > > I agree that bpftrace can do the work relying on kfuncs/kprobes. But I guess
> > > that also true for many other tracepoints out there, right?
> > 
> > Maybe, but this particular tracepoint is not buried deep inside some
> > complex function with manipulated data being passed as arguments.
> > Instead, this tracepoint is placed at the very beginning of the function
> > and takes the function arguments as its own arguments. The tracepoint
> > can be easily replaced with fentry/kprobes like I've shown with the
> > example above.
> > 
> > > For development and labs bpftrace is perfectly fine, but using kfuncs and
> > > requiring recompilation is harder in production systems compared with using
> > > smaller CO-RE tools.
> > 
> > I used bpftrace because it is very easy to write, but I could have done
> > the same with libbpf. I have a bunch of such tools that I wrote over the
> > years that I compiled once on my laptop and which I copy to various
> > machines where I need them.
> > 
> 
> My worry is that if tools are built around a particular kprobe/kfunc they
> will break if the function name or its arguments change, where as a
> tracepoint give them a bit more stability across kernel versions. This
> breakage might not be a huge problem for bpftrace since the user can change
> the script at runtime, but libbpf programs will need recompilation or some
> kind of version-detection mechanism.
> 
> Given the observability-oriented nature of psample I can very much see tools
> like this being built (I myself plan to write one for OVS repo) and my
> concern is having their stability depend on a function name or arguments not
> changing across versions.

There are a lot of tools in BCC that are using kprobes/fentry so
experience shows that it is possible to build observability tools on top
of these interfaces. My preference would be to avoid preemptively adding
a new tracepoint.

> 
> 
> > > If OVS starts using psample heavily and users need to troubleshoot or merely
> > > observe packets as they are sampled in a more efficient way, they are likely
> > > to use ebpf for that. I think making it a bit easier (as in, providing a
> > > sligthly more stable tracepoint) is worth considering.
> > 
> > I'm not saying that it's not worth considering, I'm simply saying that
> > it should be done after gathering operational experience with existing
> > mechanisms. It's possible you will conclude that this tracepoint is not
> > actually needed.
> > 
> > Also, there are some disadvantages in using tracepoints compared to
> > fentry:
> > 
> > https://github.com/Mellanox/mlxsw/commit/e996fd583eff1c43aacb9c79e55f5add12402d7d
> > https://lore.kernel.org/all/CAEf4BzbhvD_f=y3SDAiFqNvuErcnXt4fErMRSfanjYQg5=7GJg@mail.gmail.com/#t
> > 
> > Not saying that's the case here, but worth considering / being aware.
> > 
> > > Can you please expand on your concerns about the tracepoint? It's on the
> > > main internal function of the module so, even though the function name or
> > > its arguments might change, it doesn't seem probable that it'll disappear
> > > altogether. Why else would we want to remove the tracepoint?
> > 
> > It's not really concerns, but dissatisfaction. It's my impression (might
> > be wrong) that this series commits to adding new interfaces without
> > first seriously evaluating existing ones. This is true for this patch
> > and patch #2 that adds a new netlink command instead of using
> > SO_ATTACH_FILTER like existing applications are doing to achieve the
> > same goal.
> > 
> > I guess some will disagree, but wanted to voice my opinion nonetheless.
> > 
> 
> That's a fair point and I appreciate the feedback.
> 
> For patch #2, I can concede that it's just making applications slightly
> simpler without providing any further stability guarantees. I'm OK removing
> it.
> 
> And, I fail to convince you of the usefulness of the tracepoint, I can
> remove it as well.

Great, thank you. To be clear, my goal is not to make your life more
difficult, but simply to avoid merging changes that cannot be undone
when their goal can be achieved using existing interfaces.


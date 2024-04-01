Return-Path: <linux-kernel+bounces-126797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B25893CD2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916A01F22DE1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F844643B;
	Mon,  1 Apr 2024 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="jnHP2wjm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H8ViwOeG"
Received: from flow6-smtp.messagingengine.com (flow6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F233FBBD;
	Mon,  1 Apr 2024 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985057; cv=none; b=BIDk/e1hkGKjkapr9qBccv6lL6Kcr4ub3chqnwi9xq6g7WCJJ4h1JSkL2nIM8GOCEAMIMNIClc4DdxMnTXJOAWHKs7H5f9ONiuAmoFDE4NLbwrrOTtVAO5yH/H2skMHPZ5xRKn+kRHeOvJLZQix0uNX37/ry7vbz5M6N0G4Gqm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985057; c=relaxed/simple;
	bh=Vu9NJbqYq8DKSNj9RbFUIEuMF9BDspzO48JX9Fl5sic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnPkn9fQ0JxA4ZY99G+sVWZpKO7vEgYtA5jUf8PI+u1TrlwL9c0iIDSaCaZsuyycKbAc+rAqBUoz5SpnNRQ7SiwH0B7H/S3LteN+oAm6ia6DPfsnI1d6ZuMsSmn/eIVGoVSVYsVx2gONjvOZ5jzeOVVHqCPk+1MNI3te4RiXwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=jnHP2wjm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H8ViwOeG; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailflow.nyi.internal (Postfix) with ESMTP id 9DD8D2003F2;
	Mon,  1 Apr 2024 11:24:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 01 Apr 2024 11:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1711985054;
	 x=1711992254; bh=RrcJpR6o9gazuIRw+eN1bhtXNZiNsVKHCtdZLgD7j4Q=; b=
	jnHP2wjmGtEGrFtLrX0/ULGt9yGo4k11CaiBLNQqQ5nV7yu3MV0sYpwvlLp2qv67
	weGXSGWx2iArteij+jagEnnly7VEZGJVLrriVR99KN55+fwNa1KpaNvxkJth7CSB
	90uRFsncryY990CQ/2AX/tg8BDJeMgDC8MyailmsZfj1FWbbmT40ve/6KFYnCVKZ
	vkKhmYQFk4zjnEsMVAJJLB/8bK9ne4dh7bgxDynrdeqqiiObunh61/PoURupWQA6
	GvB5Uj/PJX8Oo1yFBwCwQxKp0EwTYsncWSX9q87v6bYxotYlo0pGZqkFDfRkZEEp
	Lf54LU2aEhfJWmalHjGIWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711985054; x=
	1711992254; bh=RrcJpR6o9gazuIRw+eN1bhtXNZiNsVKHCtdZLgD7j4Q=; b=H
	8ViwOeGbbq+0ftgw9lG/q6Sdjq4sstv3j2cC3fs7fOHnewCJDDiRp8KHeb4eqEe4
	6J68gmHTANZIX3mQlpy26hioYdl1oZGz31HdQKvoQgCzXyNX3WOpzO9hMt4Hn0i+
	DTzd6mYgBPTskSGZfzB53y5O4UclDSY0vjv7aKyokvuN/Z/xNL985lSoFNRyuY2W
	+7i4BzVYZGGdC7nRi1IPzUoSvMpt9FDLVWvIJ4LyiwuOI4yrmFpHODtv03T3x0KC
	tlRobgtTo1YtI92uULA3LQFXWZfvY2/98nLk2B3BAkzOFfTelaStGUmzaoovksqz
	q4byBey1VgsA43juLcSTw==
X-ME-Sender: <xms:ntEKZozS0a8pOEmT36gLQdTsXIiId2RrOZbstEIqM38l41gH33HB-A>
    <xme:ntEKZsSJhijCPaoJgOq2SgZpWN2v405Kxb6m0BGEUxDfdIqAGIPd-KKjITKkPDAfs
    Of5PhHg2eKBnQ>
X-ME-Received: <xmr:ntEKZqUYHxEaSurgUJG0KIUyZqyyr6BsoHkl_gmEY-ZObq5iHJu9PZub8-hSv0JGFIDHQLIKy2XNppSw15PilgaRxMnYmcTIBoBgOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeftddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefgke
    ffieefieevkeelteejvdetvddtledugfdvhfetjeejieduledtfefffedvieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:ntEKZmgoYU3GWP4Lanm9HM2Wkw_ui5LnCByHgaAmyZYmR5XMvDluBA>
    <xmx:ntEKZqBoz-h9uJduIzKB4wgdu6evwXCw6iuwdDpy94Tl6w9WeOF7-w>
    <xmx:ntEKZnLotSxXLlOOBQ1X9nU79PKr5AQmlhfERlfl4nkr5BE0PpvqSA>
    <xmx:ntEKZhD2_w8X8IGFH6tyz8YolDWMMLcNVLSDigPgiaFDQG2T5rv6pQ>
    <xmx:ntEKZswiv-wUVhV_XG16Q-u-D2OiXfIOCvt4w1dKcYpA9zB_4j3pH6EBqog>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 11:24:13 -0400 (EDT)
Date: Mon, 1 Apr 2024 17:24:10 +0200
From: Greg KH <greg@kroah.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Viktor Malik <vmalik@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
	Alexei Starovoitov <ast@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Natanael Copa <ncopa@alpinelinux.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Stable <stable@vger.kernel.org>
Subject: Re: Fwd: stable kernels 6.6.23 and 6.1.83 fails to build: error:
 unknown type name 'u32'
Message-ID: <2024040100-skies-outplayed-c162@gregkh>
References: <ZgrAM4NjZQWZ2Jq6@archie.me>
 <2024040143-shrimp-congress-8263@gregkh>
 <ZgrD-XtaG9D8jFnA@archie.me>
 <CAADnVQ+3bGQL9tpAR-up0_bPeF-+zW9xPp=Li1xUYf-2SaRuCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+3bGQL9tpAR-up0_bPeF-+zW9xPp=Li1xUYf-2SaRuCw@mail.gmail.com>

On Mon, Apr 01, 2024 at 08:09:40AM -0700, Alexei Starovoitov wrote:
> On Mon, Apr 1, 2024 at 7:26 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> > On Mon, Apr 01, 2024 at 04:15:25PM +0200, Greg KH wrote:
> > > On Mon, Apr 01, 2024 at 09:09:55PM +0700, Bagas Sanjaya wrote:
> > > > Hi,
> > > >
> > > > On Bugzilla, ncopa@alpinelinux.org reported resolve_btfids FTBFS regression
> > > > on musl system [1]:
> > > >
> > > > > The latest releases fails to build with musl libc (Alpine Linux edge and v3.19):
> > > > >
> > > > > ```
> > > > > rm -f -f /home/ncopa/aports/main/linux-lts/src/build-lts.x86_64/tools/bpf/resolve_btfids/libbpf/libbpf.a; ar rcs /home/ncopa/aports/main/linux-lts/src/build-lts.x86_64/tool
> > > > > s/bpf/resolve_btfids/libbpf/libbpf.a /home/ncopa/aports/main/linux-lts/src/build-lts.x86_64/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o
> > > > > In file included from main.c:73:
> > > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_ids.h:7:9: error: unknown type name 'u32'
> > > > >     7 |         u32 cnt;
> > > > >       |         ^~~
> > > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_ids.h:8:9: error: unknown type name 'u32'
> > > > >     8 |         u32 ids[];
> > > > >       |         ^~~
> > > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_ids.h:12:9: error: unknown type name 'u32'
> > > > >    12 |         u32 cnt;
> > > > >       |         ^~~
> > > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_ids.h:13:9: error: unknown type name 'u32'
> > > > >    13 |         u32 flags;
> > > > >       |         ^~~
> > > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_ids.h:15:17: error: unknown type name 'u32'
> > > > >    15 |                 u32 id;
> > > > >       |                 ^~~
> > > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_ids.h:16:17: error: unknown type name 'u32'
> > > > >    16 |                 u32 flags;
> > > > >       |                 ^~~
> > > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_ids.h:215:8: error: unknown type name 'u32'
> > > > >   215 | extern u32 btf_tracing_ids[];
> > > > >       |        ^~~
> > > > > make[4]: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/build/Makefile.build:98: /home/ncopa/aports/main/linux-lts/src/build-lts.x86_64/tools/bpf/resolve_btfids
> > > > > /main.o] Error 1
> > > > > make[4]: *** Waiting for unfinished jobs....
> 
> > > > > make[3]: *** [Makefile:83: /home/ncopa/aports/main/linux-lts/src/build-lts.x86_64/tools/bpf/resolve_btfids//resolve_btfids-in.o] Error 2
> > > > > make[2]: *** [Makefile:76: bpf/resolve_btfids] Error 2
> > > > > make[1]: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/Makefile:1354: tools/bpf/resolve_btfids] Error 2
> > > > > make: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/Makefile:234: __sub-make] Error 2
> > > > > ```
> > > >
> > > > Bisection led to upstream commit 9707ac4fe2f5ba ("tools/resolve_btfids:
> > > > Refactor set sorting with types from btf_ids.h") as the culprit.
> > > >
> > > > See the report on Bugzilla for the full thread and proposed fix.
> > >
> > > Is the proposed fix a commit to backport?
> >
> > Nope (see below).
> 
> The fix is in bpf tree.
> commit 62248b22d01e ("tools/resolve_btfids: fix build with musl libc")

Thanks, I'll go queue that up now to make people's lives easier.

greg k-h


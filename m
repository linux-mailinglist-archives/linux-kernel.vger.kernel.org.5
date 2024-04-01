Return-Path: <linux-kernel+bounces-126735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56759893C16
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07B91F247AE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114904122C;
	Mon,  1 Apr 2024 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ZVYnjnuJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="neoyCpxP"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202143FE2D;
	Mon,  1 Apr 2024 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980933; cv=none; b=Qf2m/yWeW7Ks3hCN41qgNlxPz+5gThd8oCESU6ndYcNohWz3z461rXdjf9P8inYvR28pmqqsGYL9GyUzkjDROkDQk4Y/MXHS0GzY5lfgwxoQoq+AAU0BCr6GZFRKwpdbMehtC8jEtKZJ+w2wBIw28vEpaVLt87BiRE/tZ+3MxAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980933; c=relaxed/simple;
	bh=u5aRqDMU06217vwzRELvpEqF5sg6IKxMJxYbUA7HFDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSGnJQ4Ue6SFNTZiIgMwD9JoS7iC78pDLB4uTaLL+FQvRnRedYoA/8DbSJKtBkUm9I5wDPnY9ID8QiIJSw1Np1QafA/Hkz1rslyagTae16uLFgM2hVOXGFJGGH7yhJ9bGepAVuP5YrAXoa7hVE3RyGM0WhXdE9pjDFecdheLzZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ZVYnjnuJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=neoyCpxP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2BC7E11400FA;
	Mon,  1 Apr 2024 10:15:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 01 Apr 2024 10:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711980930; x=1712067330; bh=KOzQg2YZPj
	byBpQUDfdRM4dKo4GpMSdsyM5kYCupZgk=; b=ZVYnjnuJNzx0RbTT7BVhm0jeuF
	amAPpU/dkBQUA8nCZqNYclGLHKZwauEJBoSpDiu6vebaST4how4KqAunYSbxX8R7
	buIqjt23Qji/cvLQ6W6AJixmzSzTqXC3kwTZ6rActUponSMymVnMTiaBv0D4LBiH
	SHgwdt8BjzMFL8qPQRtdLXdN1CSX1mDPSbGCsA1k9/Xn2spR2ty15FUzs/hHGQvx
	MKnYlqn2HqeOF/06ihW4XhU1IzeOkpLJKE3bOKJKP0qIKn+ReE991rUvswJkx7Fl
	CCM5LNgYA2Kq0TkY1I/2p5h8GwtZV76L6DQFZKCbVhg14gIDLZ3dwXAn+xkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711980930; x=1712067330; bh=KOzQg2YZPjbyBpQUDfdRM4dKo4Gp
	MSdsyM5kYCupZgk=; b=neoyCpxPEvwnmIXhjPKSiV9Mabxyk970msJnryyP7OED
	DRhkQCEifP64gNsotJ3dQ/XRMrxOp2f6LNVlLIBA3gi36xOPkQKTuqQxWKFj7Twf
	wWCInbSEAvMgOR3pSxSCwUygPVyZLEhlvqR7a8axLhMuId8P/reS5sApXvIaGscx
	fpen4/prDPST4MmWhbTOU2Ue+JamJbgAgEnuZQ1iiB5m5DffL2G69czHUsBAS6Wa
	9oacpyXYkxL9IqC2KDz+Yp/BIgHPynjXHXdsoTflh2LY6NmX8EHZibCzkQh+Kfbp
	8D1YMmzCjELwju4FOe40Xm7DIS5im9RWAnzMmfYtaQ==
X-ME-Sender: <xms:gcEKZmyk4xEraiqIW_XjDv8bWGTBzsqrbTlLEma-UnWU-6kbT_YrgA>
    <xme:gcEKZiQmLKd8bm8tmDKFLCDPkChpOfS4kBFoS1PSKQCas4FCA5sMEnxMjGK2pa3XH
    7Hjn3F3_YgNTg>
X-ME-Received: <xmr:gcEKZoXtoDANHb_FSKwn8bWlHhErh2dJQLNLQSvtHHrX2iHuNPErDaSZF16nnHuYD4Vqhguu2snBAI0qgJamag9D8rN0bo-qSQzNZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeftddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:gcEKZsgLattQce-rCdZZQEPwkVX3Dpr88CxHSzNzF5w1HhhJ7-BG9Q>
    <xmx:gcEKZoB4YDtCE3h0nV2c0V6TcYoqUFpl-sYj3uqQ-UzZfW4RN2FOMw>
    <xmx:gcEKZtLqPItqrnPP8WN8M75goZX12q6FGxLHGkhq21M-L0G-eKd_7A>
    <xmx:gcEKZvA4HgxYm7Xstf44DpnyP2Ri3tP0DfiMvyZxck_QbsCNeHZ8lg>
    <xmx:gsEKZq5gWU7Ue_mfopJLBrQtEXma5RimplUjMetkgCMuwguwIPAoRQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 10:15:29 -0400 (EDT)
Date: Mon, 1 Apr 2024 16:15:25 +0200
From: Greg KH <greg@kroah.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, ncopa@alpinelinux.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Stable <stable@vger.kernel.org>
Subject: Re: Fwd: stable kernels 6.6.23 and 6.1.83 fails to build: error:
 unknown type name 'u32'
Message-ID: <2024040143-shrimp-congress-8263@gregkh>
References: <ZgrAM4NjZQWZ2Jq6@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgrAM4NjZQWZ2Jq6@archie.me>

On Mon, Apr 01, 2024 at 09:09:55PM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> On Bugzilla, ncopa@alpinelinux.org reported resolve_btfids FTBFS regression
> on musl system [1]:
> 
> > The latest releases fails to build with musl libc (Alpine Linux edge and v3.19):
> > 
> > ```
> > rm -f -f /home/ncopa/aports/main/linux-lts/src/build-lts.x86_64/tools/bpf/resolve_btfids/libbpf/libbpf.a; ar rcs /home/ncopa/aports/main/linux-lts/src/build-lts.x86_64/tool
> > s/bpf/resolve_btfids/libbpf/libbpf.a /home/ncopa/aports/main/linux-lts/src/build-lts.x86_64/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o
> > In file included from main.c:73:
> > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_ids.h:7:9: error: unknown type name 'u32'
> >     7 |         u32 cnt;                                                              
> >       |         ^~~                
> > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_ids.h:8:9: error: unknown type name 'u32'
> >     8 |         u32 ids[];         
> >       |         ^~~                    
> > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_ids.h:12:9: error: unknown type name 'u32'
> >    12 |         u32 cnt;   
> >       |         ^~~                        
> > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_ids.h:13:9: error: unknown type name 'u32'
> >    13 |         u32 flags;
> >       |         ^~~
> > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_ids.h:15:17: error: unknown type name 'u32'
> >    15 |                 u32 id;
> >       |                 ^~~
> > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_ids.h:16:17: error: unknown type name 'u32'
> >    16 |                 u32 flags;
> >       |                 ^~~
> > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_ids.h:215:8: error: unknown type name 'u32'
> >   215 | extern u32 btf_tracing_ids[];
> >       |        ^~~
> > make[4]: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/build/Makefile.build:98: /home/ncopa/aports/main/linux-lts/src/build-lts.x86_64/tools/bpf/resolve_btfids
> > /main.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> > make[3]: *** [Makefile:83: /home/ncopa/aports/main/linux-lts/src/build-lts.x86_64/tools/bpf/resolve_btfids//resolve_btfids-in.o] Error 2
> > make[2]: *** [Makefile:76: bpf/resolve_btfids] Error 2
> > make[1]: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/Makefile:1354: tools/bpf/resolve_btfids] Error 2
> > make: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/Makefile:234: __sub-make] Error 2
> > ```
> 
> Bisection led to upstream commit 9707ac4fe2f5ba ("tools/resolve_btfids:
> Refactor set sorting with types from btf_ids.h") as the culprit.
> 
> See the report on Bugzilla for the full thread and proposed fix.

Is the proposed fix a commit to backport?

Digging through entries is not the easiest way to get things resolved...

greg k-h


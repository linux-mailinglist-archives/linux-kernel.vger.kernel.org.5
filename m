Return-Path: <linux-kernel+bounces-21278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45125828CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9112B24625
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD333D0A6;
	Tue,  9 Jan 2024 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="Y2UCq9xn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cbKCxbTO"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DC73D0C1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id DE9C15C0150;
	Tue,  9 Jan 2024 13:57:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 09 Jan 2024 13:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1704826625;
	 x=1704913025; bh=B6zmsf+yayYXeE2DxGFKFSH0g73vDFd/FENCoj8Itrg=; b=
	Y2UCq9xnI5X+l7WZO4SYgT7C56VGWm4fcNCbuaIxS86fv4J1vCiwyzwmuMhvy5p8
	0mtsasWAiCiAl9eSFEk070xqFPOT6UAgocORbnz0X/UlrHWrA8jSrrdnmIPmRQb/
	vJowb96a2A4V+lktqp8o07Fi49T18BIBNZNhtFKl4mqjGZE9x7VEEjB+1UIeP334
	TAkAhEZ4RrIy/izibAHwGymKyZ13NFzMG0fZkqH/ZLTlnggsJVUbKBCUNI+FMiaW
	ClTr3Av1h1tiM3U+9SX4hQNopAe/Kl0z0aUEp3DAj+SBq8H6oDZ2n+gkd3RwQeuJ
	kWJoRS08tOjsII0xLjuf4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704826625; x=1704913025; bh=B6zmsf+yayYXeE2DxGFKFSH0g73v
	DFd/FENCoj8Itrg=; b=cbKCxbTOWu+691qmbiZiikz7NRLJ7yMzAdg45SfUk9ND
	tbGuCyyXLk5Ma7bDZYP0/xvxagGu++DyzBjAPC7fb3jt6ZPQW1WhEezwikfztirR
	WCD0s2w5VUFEI6iwPGwQ3J9ayU3VZWmoHQ0eovAEUP2iVy4LCoRqJ084g7pB2mYQ
	5+8dzpy35cyKt4wrvXq+k7QxbkVH0iqMacB1QM4fYPYf06M05pwEb/WnhU5cqf31
	lJcvIJsDdKQ/n4aTdCfyr4foU+RaDTHfwqQm0zg+A4+HNWPP9DWF0gfMEQ7ZnvuU
	Eif5fx6ERS/NfrsSFJ8SrzLm0IlESABpDkgPDYAGUg==
X-ME-Sender: <xms:AZedZQHlOUjtmV_rSkYIX2LZxu22DwHtUYYLzQas9sZ3Iu9NKo_1MQ>
    <xme:AZedZZWDRwdM9RgLl2cl8XC94l0UNUAlqy7BNilmw4QKvpC-WSkNtdB7tyZ4jDHGD
    lPp2KLuLMkA_scybdo>
X-ME-Received: <xmr:AZedZaI8Z9Snrbkfluw1EFz_jDrfh1nRrAukF2-ctUN4V9gj_2rqqHjS0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflohhs
    hhcuvfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqne
    cuggftrfgrthhtvghrnhepudeigeehieejuedvtedufeevtdejfeegueefgffhkefgleef
    teetledvtdfftefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:AZedZSHJqdY9LyJIqz3086o29d5r6w_bYmurmRYZasklU02zr47z0Q>
    <xmx:AZedZWUNrjVeBQ4raRFwtixdJWCb9Ch3EGNpunPO_eUvlEDvY62XrQ>
    <xmx:AZedZVMOJ6uR29mIY9cVEvnWH9vzbvs1K-eMSju3kJFtoDTvJd6m2Q>
    <xmx:AZedZVTLldb6gSEeyQAvfHpJ-p5yQN69D2qGcXdXOkL4alPc-fmTCw>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jan 2024 13:57:04 -0500 (EST)
Date: Tue, 9 Jan 2024 10:57:03 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
Message-ID: <ZZ2W_xzCSyOgltad@localhost>
References: <202401081028.0E908F9E0A@keescook>
 <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
 <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org>

On Mon, Jan 08, 2024 at 05:48:38PM -0800, Kees Cook wrote:
> If you think this is too much of a hack, I'm happy to drop it. My very
> first reaction was "fix userspace; shells use access() not execve()"
> but it seems enough other runtimes (Python?) use execve PATH searches
> that it would make a measurable real-world difference.

In particular, execvpe and all the p variants of exec functions in both
glibc and musl have this exact behavior, and thus anything that uses
those functions will have the same behavior.

If someone wants to try other variations on this patch that only look up
the path once, and show via benchmarks that they're faster, I'm all for
it. I would *prefer* the approach of only looking up the path once, if
it's actually faster rather than slower. But I do think the spawnbench
benchmark I provided (which has fork-execvpe and vfork-execvpe and
posix_spawnp variants) is representative of real-world patterns for how
programs execute other programs on $PATH. Doing a microbenchmark on just
execvpe chaining from a program to itself is also valid, but I thought
it would be preferable to benchmark real-world patterns and measure the
actual time-to-first-instruction of the executed program as closely as
possible.


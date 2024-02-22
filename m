Return-Path: <linux-kernel+bounces-76769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BD085FC41
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588081F261B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CB014C59B;
	Thu, 22 Feb 2024 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="MjHSoh1g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GG1wN9W1"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91321474AC;
	Thu, 22 Feb 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615449; cv=none; b=eD+5GtYcBzQGq4MJ1IB/4MtcjbuU91WpmLQuZOvaMcC1N1/ZB2Ngqwb+UYrlCYAO2flK1c0vAAmt99N7LXIV7xjJgYiEeaBVqGoPCwzYqejah+ZCcq5pMauKrx6I3ULXuk5mx6GCnEj8Qdja2ZdIP9u/UbpDphOcjjtVJeXYW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615449; c=relaxed/simple;
	bh=q4hZCcz/bl8SZjjfDLe/pnUi5JMqdAmCHiBzeXrZpyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izPYcursNj0jd5dPo3xjN7o94yeHIIvlz3mfqTXN79bqHcLnX2p7qGJmmA+MITby4RA/kPXh5lmhFF864XfokyFKr5V1ZmtkVHfRTeqy0pSK6iBYbMYovruESdf9/c7cGGhtRCAN3G4BthqA2hJWkWZa8/OooBNuV+8hjaZh1cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=MjHSoh1g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GG1wN9W1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B1F4411400BE;
	Thu, 22 Feb 2024 10:24:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 22 Feb 2024 10:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708615445; x=1708701845; bh=ak/xySA9kP
	x5TQpgiD9qkPOWCJZDiY1FRY7rnoAd+nI=; b=MjHSoh1gTLkHrYXp2mwqvo7RnM
	24Et6oTsgnBDvxFOMfEFX4DWynykTjy/aoNkMm/hixoenPCUwQM/YTACnCBPQwJT
	GU+vx5gRW4krEuz5xn1AO+KCNksDeOsKdIiJTSOunwEiD9c4PrLlgmCpMWGBvhN0
	VDexuHspgxH8lVHNnox1o3ijpDUb+CgF0Kl+JPtY2iS7S0d56yixdGtJhDCh+bEa
	e8jYqBknoCd5CrAJKdLjipptN5HOV1i5g6iLTkS0Z8dtpjZMR6EeBZIOypwduAVa
	AqSk7RSy7sPCSh5TE6975v4Y2eY29YzOPkCJCOCkWBsFacj6gQinMet01aRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708615445; x=1708701845; bh=ak/xySA9kPx5TQpgiD9qkPOWCJZD
	iY1FRY7rnoAd+nI=; b=GG1wN9W1KVdtYsG8N1Q/jA8GEpqPy2w65ZDmRnxsMlgs
	ZiigHLzqDxGbkJOwC7YfaoyBbbOs/7aDFF7+Qba1qX0wQ4pO0n+guV7nbdPgf+76
	KCgef/7GUBGs88Zyay2Oz01A11iWz3L1RPmPxtFPyF06dhM4+C8bf1BBicU5xsDA
	d30QeEb9LBvaryH7jCRjPO8fbw9NKawtrDDnzh1b62ijhaJ48xZnpIS5PyNgn9Ym
	DxtnIB0+c65//mogLNG41sgF0fs5ECvfKbdfgYrG5u/7vmxvl2YheLI+yjCDE3Xg
	mnYyofmawWhMPuqfBN6rUfKA/rjfZnp2+/NDa1pcHg==
X-ME-Sender: <xms:FWfXZVFULwUjMu1sJs9F4rIJpIwiP7zbyC1jfndfBIFxkUStnKFMew>
    <xme:FWfXZaXIifusNiy4xocsOlqwNQfUFBVX3RdT8px_D-UlBu4oTr7SMFq2XiSIsX0Ug
    EVKcbtv8xZEm0ijLmI>
X-ME-Received: <xmr:FWfXZXIEa-kIOrMaXum5R5jyLKG1nqGzBIPdzhz-nqNQJ6F43idRlSKSJRY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeggdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeelffekveduvefftdejkefhtefhgeduhffghfejtdehieevjedtkeejveej
    keeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:FWfXZbG8isINsh5AiOJWEy6JD-uvrpiEdOqo3IALjnmPeWo78I6eow>
    <xmx:FWfXZbUhCSilefL2foYJa229cuBgLf1071sqNgVko_c8xTNl3gnd8w>
    <xmx:FWfXZWOU7snIUzi-FB5V6-DMrOt5BvESBmTvD0_Nu_0gM2dEuMVGdw>
    <xmx:FWfXZdJvzu8H4jGekdXMAMIfefmMNPDRkBLIFdzDoYLHqFm5OiRnYw>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 10:24:04 -0500 (EST)
Date: Thu, 22 Feb 2024 08:24:02 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Kees Cook <keescook@chromium.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, Greg KH <gregkh@linuxfoundation.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leaking_addresses: Provide mechanism to scan binary files
Message-ID: <ZddnEtnxhJsafdcF@tycho.pizza>
References: <20240218173809.work.286-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218173809.work.286-kees@kernel.org>

Hi Kees,

On Sun, Feb 18, 2024 at 09:38:12AM -0800, Kees Cook wrote:
> Introduce --kallsyms argument for scanning binary files for known symbol
> addresses. This would have found the exposure in /sys/kernel/notes:
> 
> $ scripts/leaking_addresses.pl --kallsyms=<(sudo cat /proc/kallsyms)
> /sys/kernel/notes: hypercall_page @ 156
> /sys/kernel/notes: xen_hypercall_set_trap_table @ 156
> /sys/kernel/notes: startup_xen @ 132
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Patch itself is

Reviewed-by: Tycho Andersen <tandersen@netflix.com>

And if you can carry it, that would be great (see below :).

This does bring up some interesting questions. From off-list
discussions with Tobin, I believe he is not particularly interested in
maintaining this script any more. I was never set up to do the PRs
myself, I agreed to be a reviewer to help Tobin out. I'm happy to
adopt it if that makes sense, but I'm curious about the future of the
script:

1. is it useful? (seems like yes if you're adding features)
2. does it make sense to live here as a separate thing? should we
   perhaps run it as part of kselftests or similar? I think that e.g.
   681ff0181bbf ("x86/mm/init/32: Stop printing the virtual memory
   layout") was not discovered with this script, but maybe if we put it
   inline with some other stuff people regularly run more of these would
   fall out? Maybe it makes sense to live somewhere else entirely
   (syzkaller)? I can probably set up some x86/arm64 infra to run it
   regularly, but that won't catch other less popular arches.
3. perl. I'm mostly not a perl programmer, but would be happy to
   rewrite it in python pending the outcome of discussion above.

Thoughts?

Tycho


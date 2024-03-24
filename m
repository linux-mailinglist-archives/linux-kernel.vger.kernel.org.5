Return-Path: <linux-kernel+bounces-112617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41B4887C0A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 09:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1792C1F2159E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 08:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0A215E89;
	Sun, 24 Mar 2024 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="VYbU9FNj";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="AiaAJIoT"
Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD9914A98
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711270446; cv=none; b=hOAlIQL+YcT2LX4Vk1HHfVhBr82+Xq8Z7FzarInMcvOjDRVSiHqJziK5HWtvfHp0F81RadkmgqkMfu2qxrJgtPHQhYsJFVAuI1/VP5HGEMffXEKIHDk1pTjqWKcAZxcBHyA2EZGpD9ePjZXvlwb3UeZdeTA+gs5bt2/SJS2PO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711270446; c=relaxed/simple;
	bh=hs4jUUCt48qL2QwMZOjgM2vlRF2cE3r2RtwVXG9sQyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfOV/Ms9DrWTNZPzeI0QKhDjrsNPNYS6pPxkA17+Um5jNvpiiu2y3bfFLGz7X+4UYhuo2ApVpRhAzR2uSXiGHMr/wGPVY6miLGpaXjTEemSY26cxY5zeI8lpezTqp9RECBTRyReOnDuTr3Go+yUjIhgWPs6y0gTRieleyzNa7Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=VYbU9FNj; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=AiaAJIoT; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=ilBS90by6SCxKHHjd4xnZkERRnipn9y3PlIFePRKJHc=;
	b=VYbU9FNj6VSnUa2rpdrDNmnElZTZ+9DJbvbTituVggOzor800hcuK48psEVekaK2y8Q7djF5izlCF
	 ki1VaRD3Zfw9vaRUzfhaPiNqVmQWKnCd+HLtbi3UbdS1TcINjbRJhVtMl86KeSXwOi6VadAIP3Tv7s
	 WPbrRFBmXKo9WBzYFaMMl7rymi4iwtgaoNrsNbnRZFUKz2FNSuyGsn0QLoIFHx3bz3wV/keTT5/9d2
	 MQ2mm+lNxJWTHn7t5gf5jTa+KejQs2l42hl05hpyixeYKB9V1ol3uwF2K3HfLP0ruwZ+G0wOPwVEYC
	 HgTsU6gHSocO8S+c872Nsr55kTyfOtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=ilBS90by6SCxKHHjd4xnZkERRnipn9y3PlIFePRKJHc=;
	b=AiaAJIoTJmv6xZNJHngHZvUJNkec2JzXAnJzlxV6mJvUpkPadMUGw4GC4tjb0dkT9DpSsTWXEqRkg
	 7tBj58IBg==
X-HalOne-ID: 09b88606-e9bc-11ee-a6fe-31e85a7fa845
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay4.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 09b88606-e9bc-11ee-a6fe-31e85a7fa845;
	Sun, 24 Mar 2024 08:53:55 +0000 (UTC)
Date: Sun, 24 Mar 2024 09:53:53 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Koakuma <koachan@protonmail.com>
Cc: "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [sparc] Use of -fcall-used-* flags in Makefile?
Message-ID: <20240324085353.GA1382477@ravnborg.org>
References: <JAYB7uS-EdLABTR4iWZdtFOVa5MvlKosIrD_cKTzgeozCOGRM7lhxeLigFB1g3exX445I_W5VKB-tAzl2_G1zCVJRQjp67ODfsSqiZWOZ9o=@protonmail.com>
 <20240319221615.GA379167@ravnborg.org>
 <FLtGz1AK53Qsar2xlt7KBdmT7JLz3H_NoxJQ0UaC0zqNmBtsQ2eSU6LA_lojbVQh8gArSmZoVikYxEuTC4j75PMP_BcnGPuAM2mv1YK7GHA=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FLtGz1AK53Qsar2xlt7KBdmT7JLz3H_NoxJQ0UaC0zqNmBtsQ2eSU6LA_lojbVQh8gArSmZoVikYxEuTC4j75PMP_BcnGPuAM2mv1YK7GHA=@protonmail.com>

Hi Koakuma.

On Sat, Mar 23, 2024 at 04:37:27PM +0000, Koakuma wrote:
> Hello Sam,
> 
> Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > Hi Koakuma,
> > Looking at https://github.com/gcc-mirror/gcc/blob/master/gcc/config/sparc/sparc.h
> > I read that:
> > 
> > On v9 systems:
> > g1,g5 are free to use as temporaries, and are free to use between calls
> > ...
> > g6-g7 are reserved for the operating system (or application in
> > embedded case).
> > 
> > Based on the above I would assume gcc do not change behaviour with or
> > without -fcall-used-g7.
> > [...]
> > For sparc32 the above file says:
> > 
> > g5 through g7 are reserved for the operating system.
> > 
> > So again - it looks like -fcall-used-g5 -fcall-used-g7 should have no
> > effect here and verification on a real target would be nice.
> > 
> > Sam
> 
> >From my understanding (and looking at the codegen results) those flags
> forces GCC to treat the named register as volatile, despite what the ABI
> says. However, I also believe that removing them wouldn't be harmful?
> 
> To quote my reasoning in the LLVM tracker:
> > omitting the flags shouldn't be harmful either - compilers will now
> > simply refuse to touch them, and any assembly code that happens
> > to touch them would still work like usual (because Linux' conventions
> > already treats them as volatile anyway).
> 
> But I am not entirely sure about it, that is why it'd be great if there's
> some explaination on why those flags were added in the first place.
> 
> > I do not have a sparc64 system at my hands - and for this qemu may not
> > cut it. But it would be super if someone with a working sparc64 target
> > could verify if the kernel could be built and works without
> > -fcall-used-g7.
> 
> I am currently running a build with those flags taken out on a T5120,
> and the kernel seems to be running okay for what I do (LLVM development),
> but I don't know if there are more comprehensive test suite for me
> to try on.

I tried to build a sparc32 kernel with the two -fcall-used-g5 -fcall-used-g7
flags dropped. Everything worked for me in qemu - but then I only booted
to a prompt and browsed around a little.

From your explanation and our limited testing it seems likely the flags
can be dropped, but I cannot say for sure.

Unless others chime in maybe try to send in patches to drop the flags
from sparc32 and sparc64 and see how it goes.

	Sam


Return-Path: <linux-kernel+bounces-119718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF6888CC5E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947911F67683
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C73213C69D;
	Tue, 26 Mar 2024 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQBo8QYF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076B14265;
	Tue, 26 Mar 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479142; cv=none; b=Qxku6QAe93fOKl8o0stv2hTS8o0PmTDv43QwJna4ZXdObRVrx4TK78oCbk6f8wxqAvUMDud9ghEC6pLQAEnGHZEBBAclH4g5UoqjFYeAMsFqd6c19SsZxtndyqsdq5paaXcRAKeIraxUBvFemMfD6UonimHIT7CgSYruPfl821c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479142; c=relaxed/simple;
	bh=EKi3PqIi15RdQXeNOHo7DSkD8CZDxBeq6ht4t/Ii+RY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpkynBu1dtGInaIz7+/UHN+fjszkhSGDKIfSne2lGbiZa95a2S88OrK/iJn50PTmEPmhUAuASjI4hxsA++fPXFYIAUfHjAt1h4oYkhul5fvESEFs3AVifopfFpI+CTRn+CTLDLOG9cJa9DYFMpAjBazZth7R6y/1A9Akmdqskh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQBo8QYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6959AC433C7;
	Tue, 26 Mar 2024 18:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711479142;
	bh=EKi3PqIi15RdQXeNOHo7DSkD8CZDxBeq6ht4t/Ii+RY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DQBo8QYFi4Rt8e6btUJodmB3OMAYYYpr6ZANkf0U+LEpuTwmAnuiC1QC9Klzg7VJG
	 ffBekdWUtGv+v6h5lTc9e9yzKnN25YjeWBREuJsS0bGpMpu8ITSr5QgoI1WdSa6582
	 aF/0QIoW1qJff1+iWEtLeW9n015arPeBqczMFm+/87JwxgtUNC61E+dQEOjUFNAG9f
	 fuPPYjskqnxCKEPEdDWFESNrpBq13+qawP6+6OO0sjIbMb/ie0ncgtSNXaP/B+uya7
	 lUkvxHWGBYYkUPP09BJswMBwsO51y9sP3PECT4ozl3IBqfPwvaH48B2uU5Soj3Zo0s
	 bPbHO5VyeIcUA==
Date: Tue, 26 Mar 2024 18:52:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 ciprian.hegbeli@analog.com, marcelo.schmitt@analog.com,
 dragos.bogdan@analog.com
Subject: Re: iio: GSoC 2024: RFC on AD7294-2 driver proposal
Message-ID: <20240326185207.20f8987e@jic23-huawei>
In-Reply-To: <20240319060528.1238089-1-anshulusr@gmail.com>
References: <20240319060528.1238089-1-anshulusr@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 11:35:27 +0530
Anshul Dalal <anshulusr@gmail.com> wrote:

> Hello everyone,
> 
> I am Anshul Dalal, a pre-final year student at SRMIST (India). I am
> pursuing my Bachelor's in Computer Science and Engineering and wish to
> participate in GSoC 2024 as part of The Linux Foundation under the IIO
> worksgroup.
> 
> Following the suggestion from the IIO GSoC page[1], I would like to work
> on a driver for AD7294-2. I am interested in the device since it offers
> a wide array of functionality that is different from my past IIO
> drivers[2]. I have prepared a draft proposal and would like to get early
> feedback:
> https://docs.google.com/document/d/1zf9yDq2-Ba8Vqh10w1cYI3buHzh0qIYwzf7xBkaEzDM
> 
> I'm aware of interest in the same device from other contributors[3]. If
> required, I'm ready to work on any other part suggested by the company
> or the IIO community.
> 
> Best regards,
> Anshul

Hi Anshul,

As you note, there are threads elsewhere discussing the suitability of this part.

Given the potentially competitive nature of proposals, I'm only going to give
general comments based on a quick look at your proposal.
I'll stick to the sort of thing that might help everyone proposing such a project.

1) Maintainer / reviewer bandwidth is often the biggest unknown in a project
   targeting upstream - so get that underway in plenty of time.
   Treat it as a risk and plan mitigation where you can.

2) Allow time for revisions - this is a fairly complex device, so there may well
   be more complex changes requested such as ABI redesigns and they may take
   a non trivial amount of time. For reference one GSOC intern some years ago
   did 3 major rewrites; the code was excellent (until after the GSOC had
   nearly finished I'd been assuming he was an experienced consultant - not
   an intern!) Our understanding of what was the best path was driven by seeing and
   discussing each revision.  Whilst that was much earlier in the evolution of IIO
   event now a moderate amount of time makes sense.

3) Don't wait until the end to send stuff for review - you will probably be
   crossing kernel development cycles (with a merge window to cause everything
   to grind to a halt) and reviewer / maintainer vacations etc.
   As such, structure a driver development plan to be suitable for partial
   upstreaming mid way.  If you like play guess the kernel release dates
   feel free to put that alongside your plan.  Guessing my holidays is
   a harder target :)
   Trying to upstream a driver alongside further development, parallel's
   up the time for reviewers to respond with developing more advanced features.
   Note that full time kernel developers do this sort of thing all the time
   as a complex feature often takes multiple cycles (and sometimes multiple
   years) to get fully upstream.

So I'd revisit your plan with these points in mind. It is a complex trade
off of keeping the plan simple and easy to understand, and incorporating
an idea of what else is going on in parallel.

Also think about other risks and how they might be rectified or work
might continue whilst they are being (a classic being failure to
establish reliable comms with the chip).

Jonathan

> 
> ---
> 
> [1]: https://wiki.linuxfoundation.org/gsoc/2024-gsoc-iio-driver
> [2]: Microchip MCP4821 DAC:
>      https://lore.kernel.org/lkml/20231220151954.154595-1-anshulusr@gmail.com/
>      LiteOn LTR390 light sensor:
>      https://lore.kernel.org/lkml/20231208102211.413019-1-anshulusr@gmail.com/
>      Aosong AGS02MA air quality sensor:
>      https://lore.kernel.org/lkml/20231215162312.143568-1-anshulusr@gmail.com/
> [3]: https://lore.kernel.org/linux-iio/20240229184636.13368-1-danascape@gmail.com/
>      https://lore.kernel.org/linux-iio/YlXR0d7waKW9xncd@fedora/



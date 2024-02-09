Return-Path: <linux-kernel+bounces-59101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E053B84F132
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D477282049
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156B365BB8;
	Fri,  9 Feb 2024 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iImVKs7u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561BE65BA7;
	Fri,  9 Feb 2024 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465782; cv=none; b=PHoaL6jWF62fkQuTUOBpKdOxRkOzPlFaXoOQFOufhkmzhm8MOwm5g/5wNeyy77w6FRJgDXjjQH8WrsPTRjKIPhD9c59Wdm5ayg5GGxFKtxKVKHhKTVsDCrZbZJ/WrIENz/KOJrBpuMmtvuX3bjparDVo5sP4ev0xA+ayn83flC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465782; c=relaxed/simple;
	bh=2Muc/VDBOnFkSv5EltSjHZ4YlzxsFKvyis0GCBtGEZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SByO9LPOEnMRhJ8m5ZxLYSHNHDDxVm2+g3/jjZx5fr8N5hiCesYBZsCG1HmQT2BGHb5ROdkRiu519Hb5Te4NGEosLMXLv4QaAiUNWe9H6SIKqkcnzQZ8LDOQrQccJfrNdSGUEYHPnHUQLErpF/cZQptfMnEb/ZvHcGbemCNCl8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iImVKs7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F27C433C7;
	Fri,  9 Feb 2024 08:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707465781;
	bh=2Muc/VDBOnFkSv5EltSjHZ4YlzxsFKvyis0GCBtGEZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iImVKs7ueeAUGAvDStMU3SsSM++eyZXLb70Zs5PYcPJbZ8a/LTHN3gYhZIVGwdzCs
	 uH9Hce6KsdPiyjuh3Ny7zALVcKhAfCko9kf8mE7ypN7WpzRl/dIEOszNMrk3vD8lco
	 lX6KDUNxkzO1IyTZg4WOFhQgnDBzjy8+L1UiXt/s83wqjNQ8cZ8qbF3bJXyf+0x+/9
	 hWPiwUVNDHb8HCjxsNmTL0emBXGI7pul/Sb1fyC+EiF4bEVaDa2aF0ZiPJhCVmVc5U
	 ZpCDGZ6AqdnILuY8ohFUROgby+dEB1/N8zdRNBuJSoS33bL5NfLi9gbGaID57+eGAF
	 d1Cw733cVFzgA==
Date: Fri, 9 Feb 2024 08:02:57 +0000
From: Lee Jones <lee@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Florian Eckert <fe@dev.tdt.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the leds-lj tree
Message-ID: <20240209080257.GI689448@google.com>
References: <20240105173352.6ce1a546@canb.auug.org.au>
 <17b4305d9fe1fbed3e39597f0767f7bd@dev.tdt.de>
 <20240109222031.6ce4aecc@canb.auug.org.au>
 <87wmreee6j.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wmreee6j.fsf@meer.lwn.net>

On Thu, 08 Feb 2024, Jonathan Corbet wrote:

> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> 
> > Hi Florian,
> >
> > On Mon, 08 Jan 2024 08:47:07 +0100 Florian Eckert <fe@dev.tdt.de> wrote:
> >>
> >> Hello Stephen,
> >> 
> >> thanks for your hint
> >> 
> >> On 2024-01-05 07:33, Stephen Rothwell wrote:
> >> > Hi all,
> >> > 
> >> > After merging the leds-lj tree, today's linux-next build (htmldocs)
> >> > produced this warning:
> >> > 
> >> > Warning: /sys/class/leds/<led>/rx is defined 2 times:
> >> > Documentation/ABI/testing/sysfs-class-led-trigger-tty:7
> >> > Documentation/ABI/testing/sysfs-class-led-trigger-netdev:49
> >> > Warning: /sys/class/leds/<led>/tx is defined 2 times:
> >> > Documentation/ABI/testing/sysfs-class-led-trigger-tty:15
> >> > Documentation/ABI/testing/sysfs-class-led-trigger-netdev:34  
> >> 
> >> The behavior of the tty trigger can be controlled via the Rx and Tx file.
> >> If a value is set in Rx or Tx, the LED flashes when data is transmitted in
> >> this direction. The same behavior is used for the netdev trigger.
> >> I have therefore used the same pattern for the new tty trigger as well.
> >> 
> >> I didn't know that the names have to be unique!
> >> 
> >> I'm a bit at a loss as to what to do now. Should I put a prefix "tty_"
> >> in front of the names so that we have "tty_rx", "tty_tx"?
> >> 
> >> If we do it this way, however, the general question arises as to whether
> >> we do have to use a prefix everywhere! If new triggers are added, then the
> >> names for a config file are already used up and anyone who then wants to use
> >> the same name for an other trigger with the same config file because it describe
> >> the same function must then work with a prefix!
> >
> > I think this is only a problem with the documentation system, not the
> > actual sysfs file naming.  Maybe just adding a uniquifying bit to the
> > "<led>" part will solve it.  Or maybe we need the tooling to be taught
> > about placeholders in sysfs names (or maybe there is already a way).
> 
> So I finally remembered to look at this when I had a chance to...  yes,
> it wants each ABI entry to be unique, and the ones listed here are not.
> I *think* the easiest answer is to take a line like:
> 
>   What:		/sys/class/leds/<led>/rx
> 
> and turn it into something like:
> 
>   What:		/sys/class/leds/<netdev-led>/rx
> 
> ...that makes the warning go away and, I think, conveys the information
> just as well.  A bit kludgy, perhaps, but I don't really see anything
> else there that could be used to disambiguate the names automatically.

Thanks Jon.

Please see:

  https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git/commit/?h=for-leds-next&id=4694dcab92cf0e78ff65978888ae14a6373f1ceb

-- 
Lee Jones [李琼斯]


Return-Path: <linux-kernel+bounces-125642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006818929FA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9184D1F21FD2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52C9C126;
	Sat, 30 Mar 2024 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="bYitXpzg";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="YyUcNGh8"
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [46.30.211.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC1033D0
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711790236; cv=none; b=dSPDnUZqa9JPXIqw7W8XBrw2EaAgiuwlpA2JmeXi02tUah08gkSb5W/eSgFRzp9qje5ErWx7Xcpl30nPQ2W8P0KaA1Q3lkHJ1l555zB+urMkfAot4qjIugssGBoNG2J2PRTEleN93ArjR8QbF87hbQ99AnLBUUkpVHoBjZJ1CAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711790236; c=relaxed/simple;
	bh=4yCpOsncwsjmF7Gb9PqlOTig4TQC6m97ufbASYA4VrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJeprP9L2jqW+WNkIRbqnSd4ctroEejBfo6V4Sni8gNi9uDjhEMMvOG8juBRxBwiehYDfFq24fWrALC9p0vQ2U8O/AYUtkldVHjYb2ueqbtiIwsaTyTokMjY82t6k0QV5az7ZQ6p3B5HIHWq+0cCAWZLKmqPxOa/uf2wiaowjgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=bYitXpzg; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=YyUcNGh8; arc=none smtp.client-ip=46.30.211.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=/mhpK7cMvkSIkKaWzItraRPcybJp/qChOJB5FME0Oy0=;
	b=bYitXpzgV0X8hkAiH7Oc9oyyp16nkEmYUjgtrQJ8JTwsZ30MjpFYDY4pM7S0TdBOL64Fe3oT78tWn
	 r/UsUybpsmbJpdzoYDMp0MsNf0Jj2UnJ5X6wt4tE8HUsOsYaYl9iFlVisFjVoSnpUvKz5OKeyBRRQw
	 LozuIQsu1ezgMT3RjMhrCzQduUuFvFXao5Gf649JI2zBelVN+BM/+HA+8fy6W7VFbf5LWUqflweOvb
	 RhSlwE2e9WSO/KjDkSK6TSOasnwsZekrpmnIrMmPVnzfCRAVgzi4jW4Yyh5CBa0g/O/4rZITdvzGf1
	 Fu5j8vXpeMfccDo5pvFMHIviOLyYFRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=/mhpK7cMvkSIkKaWzItraRPcybJp/qChOJB5FME0Oy0=;
	b=YyUcNGh8sEeSweAntykWQGuUlOERhyDOoKAbUkzhtUoznwfXfn8WTuE03pdG3G0+ar3RnJCE8kGwQ
	 ihu/RiMBQ==
X-HalOne-ID: 20560aca-ee76-11ee-99ae-657a30c718c6
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 20560aca-ee76-11ee-99ae-657a30c718c6;
	Sat, 30 Mar 2024 09:16:02 +0000 (UTC)
Date: Sat, 30 Mar 2024 10:16:01 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Nick Bowler <nbowler@draconx.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
	Andreas Larsson <andreas@gaisler.com>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: PROBLEM: Only one CPU active on Ultra 60 since ~4.8 (regression)
Message-ID: <20240330091601.GA128565@ravnborg.org>
References: <CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com>
 <CADyTPEyAidGgBT3f1VJLHb3ouO-r1UyvFp1PcwXxy0NRG94sbw@mail.gmail.com>
 <1df92fec-7f57-5080-94ed-b149ed384280@leemhuis.info>
 <14dcd743-144a-9f7b-849c-0843d50e4c04@draconx.ca>
 <4dce7447-678d-4e60-b76e-b01988bd6515@leemhuis.info>
 <CAHk-=wgFuoHpMk_Z_R3qMXVDgq0N1592+bABkyGjwwSL4zBtHA@mail.gmail.com>
 <943c6d11-e214-43c8-8813-8e1aba6be15c@draconx.ca>
 <20240329094456.GA44268@ravnborg.org>
 <a7c155ed-71fc-4ed9-a8c8-f98024b74651@draconx.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7c155ed-71fc-4ed9-a8c8-f98024b74651@draconx.ca>

On Fri, Mar 29, 2024 at 04:11:06PM -0400, Nick Bowler wrote:
> Hi Sam,
> 
> On 2024-03-29 05:44, Sam Ravnborg wrote:
> > I took a look at this and may have a fix. Could you try the following
> > patch. It builds - but I have not tested it.
> 
> With this patch applied on top of 6.9-rc1, both CPUs appear to come up:
> 
>   % cat /proc/cpuinfo 
>   [...]
>   ncpus probed	: 2
>   ncpus active	: 2
>   [...]
>   State:
>   CPU0:		online
>   CPU2:		online

Thanks, I will add a Tested-by: Nick Bowler <nbowler@draconx.ca>
and submit the patch properly along with a few other sparc64 related
fixes.

	Sam


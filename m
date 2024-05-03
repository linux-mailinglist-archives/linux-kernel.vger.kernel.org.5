Return-Path: <linux-kernel+bounces-167434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16188BA991
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27BB1C20DBA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0657E14F127;
	Fri,  3 May 2024 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="nPpgj1xr"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358FA146D4B;
	Fri,  3 May 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727612; cv=none; b=KpQa4WA49fr3oGRvf44Q/FV7cSkzZhkGZd3lPXZ3gx8C/lqucSL8LZkRDYjlxCSoyHI89hh5q1xAUtJV07mZRjmUsJ/uQW5mbnaNYxJL2et9S8LdTj+hpPy2aSrY8LS6V9nOQKJo9oD4HD3x40AFqNfHWfGHl4jxLaGEOVHh0o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727612; c=relaxed/simple;
	bh=ajq61w3XeSrOvYWq/kaLNW4teboeeYU4DGvFgasUAZI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ARJv53ilFdIN3B8l/fvZKt1nJSrmXcw1nUpxgomieua7Biot+Sw7UwhxACNHl1GAJnD/Hhnt5ZRLWKxB7XtZEfkFkRLymlrUu9a3PbbVxeOKlFoaWgiCe2/vi45TkpPvQKeiZddryDPsuexfGRbvuipMdvfbP58BzhTgUwOBaQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=nPpgj1xr; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714727608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ysi4/6mJffFRduXa16ZIuufstygaWK7u/+mOtVPgE4=;
	b=nPpgj1xrY/kTGRTi9T4s4am9azFUjdVzBE5Yfe3NIaSZORrVUqMSU0ZkbITqGXMi8nDvpP
	nuMEZs5wrMz6VuYOUy4gzvMj35B6gi4DE/ajmA5dEPLQOYLMnG08idjv4N00KProdSGoGV
	zZRwefs1HGDyb9EKJV6rgenLBFfWJfkvl3kYqgJaFPYMia67cvUDQ/NwbYruvjgnWyI5HQ
	FBrlWL3QqbZMgBVoBQszC0qX/7eE78atgSAOeCtOyiLPHhv4FDEs81opHXQ3PtgEWO7nt0
	Fw0J3XrV0cjWpWO6UkCRQJg4NEpIIgn2Y9dEvOMiJMp5Lxd09EJ+FE276+caRw==
Date: Fri, 03 May 2024 11:13:28 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC
 dtsi for H6
In-Reply-To: <20240501103059.10a8f7de@donnerap.manchester.arm.com>
References: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
 <49abb93000078c692c48c0a65ff677893909361a.1714304071.git.dsimic@manjaro.org>
 <20240430001002.4797e4e3@minigeek.lan>
 <6fdeb49d57ccccca62e4f43dbe9475e3@manjaro.org>
 <20240430114627.0cfcd14a@donnerap.manchester.arm.com>
 <f4f4163d908c95d2a3f6f48bc3d7de49@manjaro.org>
 <20240501103059.10a8f7de@donnerap.manchester.arm.com>
Message-ID: <5aeb266ce1aa0ad3dd1d7261eac3b3d2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andre,

On 2024-05-01 11:30, Andre Przywara wrote:
> On Tue, 30 Apr 2024 13:10:41 +0200
> Dragan Simic <dsimic@manjaro.org> wrote:
>> On 2024-04-30 12:46, Andre Przywara wrote:
>> > On Tue, 30 Apr 2024 02:01:42 +0200
>> > Dragan Simic <dsimic@manjaro.org> wrote:
>> >> Thank you very much for reviewing my patch in such a detailed way!
>> >> It's good to know that the values in the Allwinner datasheets match
>> >> with the observed reality, so to speak. :)
>> >
>> > YW, and yes, I like to double check things when it comes to Allwinner
>> > documentation ;-) And it was comparably easy for this problem.
>> 
>> Double checking is always good, IMHO. :)
>> 
>> > Out of curiosity: what triggered that patch? Trying to get rid of false
>> > warning/error messages?
>> 
>> Yes, one of the motivators was to get rid of the false kernel warning,
>> and the other was to have the cache information nicely available 
>> through
>> lscpu(1).  I already did the same for a few Rockchip SoCs, [1][2][3] 
>> so
>> a couple of Allwinner SoCs were the next on my mental TODO list. :)
> 
> Thanks for doing this!

I'm glad that you like all these patches. :)

>>> And do you plan to address the H616 as well? It's a bit more tricky 
>>> there,
>>> since there are two die revisions out: one with 256(?)KB of L2, one 
>>> with
>>> 1MB(!). We know how to tell them apart, so I could provide some TF-A 
>>> code
>>> to patch that up in the DT. The kernel DT copy could go with 256KB 
>>> then.
>> 
>> I have no boards based on the Allwinner H616, so it wasn't on my 
>> radar.
>> Though, I'd be happy to prepare and submit a similar kernel patch for
>> the H616, if you'd then take it further and submit a TF-A patch that
>> fixes the DT according to the detected die revision?  Did I understand
>> the plan right?
> 
> Yes, that was the idea. I have a working version of that TF-A patch 
> now,
> just need to figure out some details about the best way to only build 
> this
> for the H616 port.

Nice, the kernel patch for the H616 SoC dtsi is now on the list, [4]
please have a look.  Please let me know when your follow-up TF-A patch
gets submitted upstream, so I can watch it.

> Neither the data sheet nor the user manual mention the cache sizes for 
> the
> H616, but I checked the CSSIDR_EL1 register readouts on both an old 
> H616
> and a new H618, and they confirm that the former has 256 KB L2, and the
> latter 1MB.

Oh wow, 1 MB of L2 cache is quite a lot for such an SoC, which is
actually very nice to see.  Thumbs up for Allwinner not skimping on
the L2 cache in that H616 die revision. :)

> Also I ran tinymembench on two boards to confirm this,
> community benchmarks results are available here:
> https://github.com/ThomasKaiser/sbc-bench/blob/master/Results.md
> The OrangePi Zero2 and OrangePi Zero3 are good examples, respectively.
> Associativity and cache line size are dictated by the Arm Cortex cores,
> and the L1I & L1D sizes are the same as in the other SoCs.

I've included the most important benchmark results in the H616 SoC
dtsi patch, [4] which actually now serves as an additional reference
for the cache sizes.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=67a6a98575974416834c2294853b3814376a7ce7
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8612169a05c5e979af033868b7a9b177e0f9fcdf
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b72633ba5cfa932405832de25d0f0a11716903b4
[4] 
https://lore.kernel.org/linux-sunxi/9d52e6d338a059618d894abb0764015043330c2b.1714727227.git.dsimic@manjaro.org/


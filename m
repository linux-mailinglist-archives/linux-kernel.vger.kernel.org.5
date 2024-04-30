Return-Path: <linux-kernel+bounces-163825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CD18B72A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6CF1F2173B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5899A12C549;
	Tue, 30 Apr 2024 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="O0R+Fag+"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F316112C819;
	Tue, 30 Apr 2024 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475449; cv=none; b=SBpbr2rEsNjsocCsvhxZzJzUXeJ9pvHGXWSoBTCI0QOTE/+ZebJ7gC84qqOP3eIsImlM0+Vomm+wS0VKp/98KYcCIAlO7cCeVV9LsOHdhT+ZZHBTTrE5v7Y9kWakdI5rHNsU/mKyX1olaeJexmNLq4JfaG9rZwCj23mDBiS8bw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475449; c=relaxed/simple;
	bh=5aMGY4TetrWZPSPC+bg6GoYf1PBtEi/MdRkPeSHwBkA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mUCx+7uwZq19XeaSP6jSnF+P4KR86jfxXHQZIUmi+zD4YGFwqKxbmBqdO54pjPLFVef89NywK4eQ5d44w1NIwRDmwAnfsJUZ7wTSmIhu2NH8gsK1vVmJfnB4L0fWrxWhbQll9ac2beM5Fs3CCjYyE+XmYztjl+t0sOpz6iLxenI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=O0R+Fag+; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714475442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXKLEl88NqVHxINvq3HuX4hPm4pXSq+keAJ00os/VHk=;
	b=O0R+Fag+OueqMCr1y90NL/AmfeM6wv77ctNtGipqjYYIKDwMFsAA+Bo+CFUhoucBanply6
	SS+IUhjNc+Q0fQU69owBtO078NT5rWHaD7JOddHiO7on9Lrb7wtLwGxMr0zFafdThiYGoV
	8ubR3tayTpRouA48EuchTCqZzMz9ciehSHajzmA1ZoB11iTOnVgObRTjQOcoWmn+jfrgKY
	lvUbhkg52K+H5O2n/K9tqbPtVpwUEVTAs6b4Ev8G+13A7PQZK+4KMbbTWAtK9vKJMqXY49
	tzJFSvrvFjfVKfTh2q4WQzTnbT50INSp/NRHBfAEsf7TigpL+rwL+1uviMh77g==
Date: Tue, 30 Apr 2024 13:10:41 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC
 dtsi for H6
In-Reply-To: <20240430114627.0cfcd14a@donnerap.manchester.arm.com>
References: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
 <49abb93000078c692c48c0a65ff677893909361a.1714304071.git.dsimic@manjaro.org>
 <20240430001002.4797e4e3@minigeek.lan>
 <6fdeb49d57ccccca62e4f43dbe9475e3@manjaro.org>
 <20240430114627.0cfcd14a@donnerap.manchester.arm.com>
Message-ID: <f4f4163d908c95d2a3f6f48bc3d7de49@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andre,

On 2024-04-30 12:46, Andre Przywara wrote:
> On Tue, 30 Apr 2024 02:01:42 +0200
> Dragan Simic <dsimic@manjaro.org> wrote:
>> On 2024-04-30 01:10, Andre Przywara wrote:
>> > On Sun, 28 Apr 2024 13:40:36 +0200
>> > Dragan Simic <dsimic@manjaro.org> wrote:
>> >
>> >> Add missing cache information to the Allwinner H6 SoC dtsi, to allow
>> >> the userspace, which includes lscpu(1) that uses the virtual files
>> >> provided
>> >> by the kernel under the /sys/devices/system/cpu directory, to display
>> >> the
>> >> proper H6 cache information.
>> >>
>> >> Adding the cache information to the H6 SoC dtsi also makes the
>> >> following
>> >> warning message in the kernel log go away:
>> >>
>> >>   cacheinfo: Unable to detect cache hierarchy for CPU 0
>> >>
>> >> The cache parameters for the H6 dtsi were obtained and partially
>> >> derived
>> >> by hand from the cache size and layout specifications found in the
>> >> following
>> >> datasheets and technical reference manuals:
>> >>
>> >>   - Allwinner H6 V200 datasheet, version 1.1
>> >>   - ARM Cortex-A53 revision r0p3 TRM, version E
>> >>
>> >> For future reference, here's a brief summary of the documentation:
>> >>
>> >>   - All caches employ the 64-byte cache line length
>> >>   - Each Cortex-A53 core has 32 KB of L1 2-way, set-associative
>> >> instruction
>> >>     cache and 32 KB of L1 4-way, set-associative data cache
>> >>   - The entire SoC has 512 KB of unified L2 16-way, set-associative
>> >> cache
>> >>
>> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> >
>> > I can confirm that the data below matches the manuals, but also the
>> > decoding of the architectural cache type registers (CCSIDR_EL1):
>> >   L1D: 32 KB: 128 sets, 4 way associative, 64 bytes/line
>> >   L1I: 32 KB: 256 sets, 2 way associative, 64 bytes/line
>> >   L2: 512 KB: 512 sets, 16 way associative, 64 bytes/line
>> 
>> Thank you very much for reviewing my patch in such a detailed way!
>> It's good to know that the values in the Allwinner datasheets match
>> with the observed reality, so to speak. :)
> 
> YW, and yes, I like to double check things when it comes to Allwinner
> documentation ;-) And it was comparably easy for this problem.

Double checking is always good, IMHO. :)

> Out of curiosity: what triggered that patch? Trying to get rid of false
> warning/error messages?

Yes, one of the motivators was to get rid of the false kernel warning,
and the other was to have the cache information nicely available through
lscpu(1).  I already did the same for a few Rockchip SoCs, [1][2][3] so
a couple of Allwinner SoCs were the next on my mental TODO list. :)

> And do you plan to address the H616 as well? It's a bit more tricky 
> there,
> since there are two die revisions out: one with 256(?)KB of L2, one 
> with
> 1MB(!). We know how to tell them apart, so I could provide some TF-A 
> code
> to patch that up in the DT. The kernel DT copy could go with 256KB 
> then.

I have no boards based on the Allwinner H616, so it wasn't on my radar.
Though, I'd be happy to prepare and submit a similar kernel patch for
the H616, if you'd then take it further and submit a TF-A patch that
fixes the DT according to the detected die revision?  Did I understand
the plan right?

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=67a6a98575974416834c2294853b3814376a7ce7
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8612169a05c5e979af033868b7a9b177e0f9fcdf
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b72633ba5cfa932405832de25d0f0a11716903b4


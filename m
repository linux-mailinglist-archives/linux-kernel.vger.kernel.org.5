Return-Path: <linux-kernel+bounces-163791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB138B7084
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC671285E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A0012CD84;
	Tue, 30 Apr 2024 10:46:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2808C12C53F;
	Tue, 30 Apr 2024 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473993; cv=none; b=X93ktZyvYOUbVU9nkBz4yZJJBBV0EHGH0IRvpcijiSMH7EqGi8WUD39BXoZk3nRTSSC0QfvvL1Kv5E6azkELCa+mTofo0KnTF+RJkGdJ3yKfQrGptMIfpolc/A72p6eSnVNcT4rZi1k/q7i7kw2NdjqpCUQ6GArk85VFrArfW1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473993; c=relaxed/simple;
	bh=mE6yvWjTcmXVXU5c5sghfUVd7O4Ux9KAsDuJ2YuvrWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpXzZo9RvSuA0ao2EIAIWlfRXHDo7v5jimuxR0VjSg7qIsdEooZzHosky6qsnWhMTJcbvWbnyWVcEuHiWieU/3s22NvGkAV0UlBBXaHb+4mqBzEdIlHu360zoudY1sAv5zyh92Nqrdk5X3ZPXkxiKwbGsHjwxq5QMUjQAB+dxos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 152CD2F4;
	Tue, 30 Apr 2024 03:46:58 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FF353F73F;
	Tue, 30 Apr 2024 03:46:30 -0700 (PDT)
Date: Tue, 30 Apr 2024 11:46:27 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-sunxi@lists.linux.dev, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC
 dtsi for H6
Message-ID: <20240430114627.0cfcd14a@donnerap.manchester.arm.com>
In-Reply-To: <6fdeb49d57ccccca62e4f43dbe9475e3@manjaro.org>
References: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
	<49abb93000078c692c48c0a65ff677893909361a.1714304071.git.dsimic@manjaro.org>
	<20240430001002.4797e4e3@minigeek.lan>
	<6fdeb49d57ccccca62e4f43dbe9475e3@manjaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 02:01:42 +0200
Dragan Simic <dsimic@manjaro.org> wrote:

Hi Dragan,

> Hello Andre,
> 
> On 2024-04-30 01:10, Andre Przywara wrote:
> > On Sun, 28 Apr 2024 13:40:36 +0200
> > Dragan Simic <dsimic@manjaro.org> wrote:
> >   
> >> Add missing cache information to the Allwinner H6 SoC dtsi, to allow
> >> the userspace, which includes lscpu(1) that uses the virtual files 
> >> provided
> >> by the kernel under the /sys/devices/system/cpu directory, to display 
> >> the
> >> proper H6 cache information.
> >> 
> >> Adding the cache information to the H6 SoC dtsi also makes the 
> >> following
> >> warning message in the kernel log go away:
> >> 
> >>   cacheinfo: Unable to detect cache hierarchy for CPU 0
> >> 
> >> The cache parameters for the H6 dtsi were obtained and partially 
> >> derived
> >> by hand from the cache size and layout specifications found in the 
> >> following
> >> datasheets and technical reference manuals:
> >> 
> >>   - Allwinner H6 V200 datasheet, version 1.1
> >>   - ARM Cortex-A53 revision r0p3 TRM, version E
> >> 
> >> For future reference, here's a brief summary of the documentation:
> >> 
> >>   - All caches employ the 64-byte cache line length
> >>   - Each Cortex-A53 core has 32 KB of L1 2-way, set-associative 
> >> instruction
> >>     cache and 32 KB of L1 4-way, set-associative data cache
> >>   - The entire SoC has 512 KB of unified L2 16-way, set-associative 
> >> cache
> >> 
> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>  
> > 
> > I can confirm that the data below matches the manuals, but also the
> > decoding of the architectural cache type registers (CCSIDR_EL1):
> >   L1D: 32 KB: 128 sets, 4 way associative, 64 bytes/line
> >   L1I: 32 KB: 256 sets, 2 way associative, 64 bytes/line
> >   L2: 512 KB: 512 sets, 16 way associative, 64 bytes/line  
> 
> Thank you very much for reviewing my patch in such a detailed way!
> It's good to know that the values in the Allwinner datasheets match
> with the observed reality, so to speak. :)

YW, and yes, I like to double check things when it comes to Allwinner
documentation ;-) And it was comparably easy for this problem.

Out of curiosity: what triggered that patch? Trying to get rid of false
warning/error messages?
And do you plan to address the H616 as well? It's a bit more tricky there,
since there are two die revisions out: one with 256(?)KB of L2, one with
1MB(!). We know how to tell them apart, so I could provide some TF-A code
to patch that up in the DT. The kernel DT copy could go with 256KB then.

Cheers,
Andre.


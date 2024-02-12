Return-Path: <linux-kernel+bounces-61030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57307850C73
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 01:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FC11C209FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A767F8;
	Mon, 12 Feb 2024 00:08:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B2D368;
	Mon, 12 Feb 2024 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707696534; cv=none; b=VyZeCK4MzIg1AV/4b0Td7F1Vhkbvh4fqlqJtjppq+xQZ1BmvCTL3p1Q5PlHQ1u5nknP0Y2UtEjJeJPUGSKElGtz2eEqmJU0eu+ml55GPaGw2mnS8KCWlryHRdT99k2+3g2+Ee3YlECGyjP02tjhL7vF6kpHIbSAd4/smfJEY1iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707696534; c=relaxed/simple;
	bh=aZrV4SDAhZ2GYilzh8Xv+nGrKhDFhsjF5dRvA9nvciM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hebJU7Yyg6d6UuE4PxhbkKsNdyxycYPPrzDJ8sxfd/f1JdB9H+pLICWzpW/74YRl553uK0mdiVmQO1UzwkNRRV9A99DVb+CNmhGD8/hOVnRu5/pMqB8DUFePVvMo7ditK9bboqk5tBZqc9M3Lvwaq6pW6hflNkX7fToMa8JLSdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B651DA7;
	Sun, 11 Feb 2024 16:09:29 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DA6B3F5A1;
	Sun, 11 Feb 2024 16:08:45 -0800 (PST)
Date: Mon, 12 Feb 2024 00:07:27 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Arnaud Ferraris
 <arnaud.ferraris@collabora.com>, Alexey Klimov <alexey.klimov@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add thermal trip points for
 GPU
Message-ID: <20240212000727.4690bdb6@minigeek.lan>
In-Reply-To: <ZcjYk8MD4jotKNcq@skv.local>
References: <20240211105326.506049-1-andrej.skvortzov@gmail.com>
	<20240211125209.15d58462@minigeek.lan>
	<ZcjYk8MD4jotKNcq@skv.local>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Feb 2024 17:24:19 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

Hi Andrey,

> Hi Andre,
> 
> On 24-02-11 12:52, Andre Przywara wrote:
> > On Sun, 11 Feb 2024 13:53:26 +0300
> > Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> > 
> > Hi Andrey,
> >   
> > > From: Alexey Klimov <alexey.klimov@linaro.org>
> > > 
> > > Without trip points for GPU, the following errors are printed in the
> > > dmesg log and the sun8i-thermal driver fails to load:  
> > 
> > So how does that post differ from Alexey one's a few weeks back:
> > https://lore.kernel.org/linux-arm-kernel/20240101000008.65747-1-alexey.klimov@linaro.org/
> > It seems like the same patch?  
> 
> Yes, it's the same patch. I've added only information about failed
> dtbs_check errors in already supported boards to commit message.
> I've found this patch from June 2023 without any feedback. [1] Since I've
> worked on dts changes for PinePhone A64, I've decided to resend
> it. Sorry, I wasn't aware that Alexey resent it in the mean time.

No worries, that's fine, thanks for the explanation.

> It's better to continue discussion in original Alexey's patch.

Will Alexey have time to reply and resend? If not, or if you are not
sure (it's been a while), it's fine to take over this series, and send a
v2, by yourself.

If you can just explicitly state that the GPU trip point values are
copied from the CPU ones (because they share a die), I am happy as far
as my comment is concerned. This is arguably somewhat mentioned in the
commit message already, but I missed it on the first read, so would like
to see this more prominently stated.

As mentioned before, and also stated by Jernej, consider this patch
purely device-specific, not related to any Linux behaviour, and give
rationale only based on the binding, which requires trip points.
Something simple as "The DT binding requires trip points, and
dt-validate complains about them missing for any A64 boards." should
suffice.

Thanks,
Andre

> > And Jernej and I had some comments (no mentioning of "Linux" in commit
> > message, add cooling maps, source of trip temperature values), can you
> > please try to address them?
> > 
> >   
> > > thermal_sys: Failed to find 'trips' node
> > > thermal_sys: Failed to find trip points for thermal-sensor id=1
> > > sun8i-thermal: probe of 1c25000.thermal-sensor failed with error -22  
> > 
> > I think it's pretty obvious that the trip points are missing when they
> > shouldn't, so this does not need too much explanation or rationale in
> > the commit message, so you can cut this short.
> >   
> > > When thermal zones are defined, trip points definitions are mandatory.
> > > Trip values for the GPU are assumed to be the same values as the CPU
> > > ones. The available specs do not provide any hints about thermal regimes
> > > for the GPU and it seems GPU is implemented on the same die as the CPU.
> > > 
> > > 'make dtbs_check' complains about problem in dts for 18 A64-based boards
> > > supported by the kernel:
> > > 
> > > sun50i-a64-pine64.dtb: thermal-zones: gpu0-thermal: 'trips' is a required property
> > > 	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
> > > sun50i-a64-pine64.dtb: thermal-zones: gpu1-thermal: 'trips' is a required property
> > > 	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
> > > 
> > > Tested on Pine a64+ and PinePhone 1.2.
> > > 
> > > Cc: Samuel Holland <samuel@sholland.org>
> > > Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > Cc: Chen-Yu Tsai <wens@csie.org>
> > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> > > Tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>  
> > 
> > You would need your Signed-off-by: here, since you send this, even when
> > on Alexey's behalf.
> > 
> > Cheers,
> > Andre
> >  
> 
> 1.  https://lkml.org/lkml/2023/6/4/416
> 



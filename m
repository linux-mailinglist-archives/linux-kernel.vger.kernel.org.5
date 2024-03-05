Return-Path: <linux-kernel+bounces-92487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D633A872117
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643761F2205D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41178614D;
	Tue,  5 Mar 2024 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WJo0BDiG"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939458613A;
	Tue,  5 Mar 2024 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647638; cv=none; b=NFswNjSodoNUWjTEU2Xt0m9JK1ttiWDwnRo4+0PAshOuCDcqh7iiNEnJyEsg4LsRGZ+zl9k0TzEYycLfXaigkhDstyS3GaelDv9Gt87cbeWXhippUAmsmwu9hQdrKFHPCOnWD+pUhURvP1gAqoLkBhad9eU0pipW+LzEk1e/70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647638; c=relaxed/simple;
	bh=SX5to30EhNbAVGigcYLVoaY+solEIJuRba9iTb4VyoI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8udJZAfRQZ7bobgRIn23UyZmMTkmfEam/xB4MVM3+X2Xav4Fd+q4+9eG29UtQsK2sloK+v/s/XNuQmIPkQUyaUC9z7wO1RsBegBluY7dEiOGI9jylTNdQWo/B/xYBFyPwvs6nI3n4SH3BdtVzBmke6NJbibnxwysKHbq5y0zyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WJo0BDiG; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EBD901BF203;
	Tue,  5 Mar 2024 14:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709647632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FaprjU0HK8RgVI5QhbgK15bFxzuhMnZNXwzBpwlbU4=;
	b=WJo0BDiGD/G+sF4Dv+i+C8fBUkMXamCRODSXLuTYB82Zv3J/SP5X3GWGiSa7oLX8IvnCkm
	8MlueCfV2b5TdnrfiTitWiQXld19UIRXw6hoQ4P/ZZT8tduz81JhnfrSL4fsmkUAQ5DGeK
	9SO24WkSVVEwAMEsoYFHlrCTRth+s4gzzxJwbWAY2NDUaJbWsp6Ry6/pnfgJzVjnVIQiCd
	zxNfFHODiMpOZnIIXc4uRVVTwjfmN3D7JZ0vyHnK9yJZp7fvfp1Jt1zCKoCciQOgRfZwCy
	q9eH+LkDRnmQJBjG8DNjss8NqWnwWLfQ8P6hXZVmzyqZ/Th6NYOi9Ow2v+G8lg==
Date: Tue, 5 Mar 2024 15:07:09 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Heiko
 Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/7] ASoC: rockchip: i2s-tdm: Fix inaccurate sampling
 rates
Message-ID: <20240305150709.02cc4a4e@booty>
In-Reply-To: <2509388.gFrL1EYhQU@archbook>
References: <20240221-rk3308-audio-codec-v3-0-dfa34abfcef6@bootlin.com>
	<20240221-rk3308-audio-codec-v3-1-dfa34abfcef6@bootlin.com>
	<2509388.gFrL1EYhQU@archbook>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Nicolas,

On Mon, 04 Mar 2024 19:40:52 +0100
Nicolas Frattaroli <frattaroli.nicolas@gmail.com> wrote:

[...]

> Hello,
> 
> thank you for your patch series fixing this driver. Since I am the person
> currently listed as the maintainer of it and was the person who originally
> upstreamed it, I think I can provide some insight.
> 
> The mclk calculation and reparenting code indeed originates from the
> downstream driver. As for why that driver did these calculations itself,
> I do not know, but I do know why I did not remove them and rely on the
> CCF to do the reparenting and such for me.
> 
> For starters, I did not know that the DAI and CCF code have functionality
> to automatically reparent clocks based on the audio rate. The reason I did
> not know this is because after looking at the official kernel documentation
> at [1], I did not see any mention of this.
> 
> Similarly, the documentation for the CCF at [2] also makes no mention of
> this feature. In general, guidance for how to properly write a DAI driver
> in the kernel documentation is sparse, though I am extremely grateful to
> broonie for his patience in answering some of my questions I had at the
> time. The input of any of the reviewers at the time, including that of
> Rockchip's engineer who wrote the downstream driver, made it a lot better
> than it initially was.
> 
> Had somebody brought up the existence of this functionality during the
> reviews of this driver's original submission, I would of course have
> fixed this. I do not blame the reviewers or maintainers, as they have
> enough on their plate as-is and don't owe me anything. But I am trying
> to explain the circumstances here that lead to mclk being slightly broken
> for this driver.
> 
> Naturally, now that I know that this functionality does exist, I can do
> a web search (since in-tree documentation search was fruitless) for
> "linux common clock framework reparenting", which as its second result
> brings up a PDF of the slides of a talk by one of your co-workers.[3] The
> slides do not contain the string "reparent", though they do tell me that
> I am able to purchase Linux kernel development training from your
> employer.
> 
> What I'm trying to say here is that I still don't know how the DAI
> reparenting mclk through the CCF works, and I'd probably need to dig
> into the implementation to even know that it does this. Furthermore,
> your employer has an economic incentive to keep this information out
> of the in-tree documentation.

I am very surprised by your opinion about our contributions, as we are
trying to do exactly the opposite, being active members of the
community and giving back in various ways. We are trying to contribute
documentation and share knowledge as well: we release all of our
training materials as Creative Commons (source code included), we
contribute to the Buildroot and Yocto documentation and one of our
colleagues is the maintainer of the Yocto Project documentation. We
also wrote and/or maintain "practical working code examples" such as
the simplest-yocto-setup [1] we recently published and the
zynqmp-pmufw-builder [2], and published some video tutorials (I
remember about one on device tree that seems very appreciated).

[1] https://github.com/bootlin/simplest-yocto-setup/
[2] https://github.com/lucaceresoli/zynqmp-pmufw-builder/

We also contributed to the Documentation directory of the Linux kernel
tree, as git can show:

git shortlog --no-merges -s \
  --author=free-electrons.com --author=bootlin.com \
  -- Documentation/ ':!Documentation/devicetree/bindings/'

Sure, we could do better, but I think we are definitely doing something.

About the CCF specifically, it is surely one of the areas of the kernel
that has insufficient documentation. As a matter of fact, while some
areas are very well documented, for others the only real documentation
is the code. I don't like this fact, some contributions certainly help
but documenting a complex subsystem written by others is definitely a
very relevant effort.

However I don't think the sound documentation should describe clock
reparenting: it is really a CCF feature that is available to any
in-kernel clock user, i.e. pretty much every subsystem. It should
definitely be described in the CCF docs, sure.

> I hope that clears up any confusion as to "why such a complex yet
> incorrect logic is present", and what ultimately lead you to having
> to write this patch.

Thanks for taking time to explain. This is very useful as there might
have been reasons I didn't suspect for the code being as it is.

The fact that you based your work on the downstream vendor kernel (as
I did for the codec driver in this series) is probably the reason. Not
only because the code quality of vendor kernels is sometimes
considerably lower than the mainline kernel, but also because that
driver might have been written when the reparenting logic in the CCF
was not yet as complete and effective as it is today, so chances are
the manual reparenting was correct initially.

Also, the incorrect sampling rate is barely noticeable at most sampling
rates up to 96 kHz, so I'm not blaming anybody for having introduced a
bug that is not visible in all use cases. The only way to not introduce
any bugs is not writing any code.

> As for the patch itself, I'll hopefully get around to testing it this
> week on an RK3566 board, as your cover letter does not list the platforms
> this was tested for regressions on, so I assume you're just using RK3308.

Your testing would be very useful!

And yes, I developed and tested my patch on RK3308. Good point, added
now to my commit log so it will appear in v4.

> The RK356x has some linked clock things going on which mainline does not
> yet model properly as far as I know (which is why some video related clocks
> are marked as critical, and why things like [4] are needed for MIPI-DSI
> output to work. So any changes that might fiddle with the parent clocks
> I'd like to validate.

Right, video clocks are tricky to get right and I've often seen them
require manual hard-coding in the device tree, unfortunately.

> If I don't get around to it in a timely manner
> however, I'm fine with this patch as-is.

Cool, thanks.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


Return-Path: <linux-kernel+bounces-136633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4771E89D650
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33281F233E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DE981729;
	Tue,  9 Apr 2024 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ql+F87zy"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C88B7D3E8;
	Tue,  9 Apr 2024 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657281; cv=none; b=Y+/+mPAOlh8jnSxNdgEpWacHqbGEsGPp8V4MM1Ie2iCSDGAmQt5CIyNNePlhcO+V7EZJDJZGyB6QjREmGXjlx2sCZTsNmlK6gxY4H+/GHs4C98Tnny5lpDfGk+UzEpIRqW7Hd9UQC6Dk1/tkxm6qiCnATeIMlORQwpHzxwTFp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657281; c=relaxed/simple;
	bh=OPUmLe7bbPSd+EFdJzb2nUvsqvDTd4pOvVEKqyMUQX0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=jofE4I5cCyX4KjRwfiVwZTrbbyA2F2pWWzm080m8A/w/5yM0aDJVj3TfI/x8SM9JH3R5BD1eJif2W/R/sdOp7ETfxC2fReEMlmPsm0GRhEZxz6ghV2OH1XiIyyxeFl3l5rFczHBARL9zzidX4VB7qt8dfV5WpMb6I6HMBf7AbqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ql+F87zy; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD40B1BF207;
	Tue,  9 Apr 2024 10:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712657277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DhSZHTr8k1rFvJdGhzrRm1qQZ2GU5hWtU1V3WOs0hbE=;
	b=Ql+F87zyNbN9PXXKMbUPnhYMfSwvxTU+xLKzHlxDzam1X2Eqdo0Mz4jG/pKsHZalTfqHM6
	9iwYX4pjqdCTuZx4XkLGRWciDVrsxarQHOGErYcLaMvMoKHDGi9ONlnlZ339uC+Kg6qxFZ
	9k28gMBmaoIXnAYJGmZ1cgEnhncsCqjBVGiW7HfF6jkOQBfyJNt1KtTv7zA4w/kuAs6aRh
	18sVZFKlYmeB60P4CY4f7NGyT7BOkUHZ0l2Mjp7o37r/Xzxwykfq9VyNZZ+rajsXKUIV3J
	8ydsKu0vZOcL2NsvCKRrZ0uJ4VKjTRml5h4tlrQWoQMc0PW0yHbQZ7sNBZ46bg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Apr 2024 12:07:56 +0200
Message-Id: <D0FIC34Z35BV.1RT6NNGWA85SL@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v2 05/11] spi: cadence-qspi: add FIFO depth detection
 quirk
Cc: "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Vaishnav Achath" <vaishnav.a@ti.com>, "Thomas Bogendoerfer"
 <tsbogend@alpha.franken.de>, "Rob Herring" <robh@kernel.org>,
 <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Mark Brown" <broonie@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
 <20240405-cdns-qspi-mbly-v2-5-956679866d6d@bootlin.com>
 <551bea0a-1c9e-4e04-87db-c643fdaee85e@sirena.org.uk>
 <D0ETH1AG1ONG.1M1FPSZM69H0Z@bootlin.com>
 <66bf7d58-a726-49ba-9765-f769f6189310@sirena.org.uk>
In-Reply-To: <66bf7d58-a726-49ba-9765-f769f6189310@sirena.org.uk>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Mon Apr 8, 2024 at 4:51 PM CEST, Mark Brown wrote:
> On Mon, Apr 08, 2024 at 04:38:56PM +0200, Th=C3=A9o Lebrun wrote:
> > On Mon Apr 8, 2024 at 4:10 PM CEST, Mark Brown wrote:
> > > On Fri, Apr 05, 2024 at 05:02:15PM +0200, Th=C3=A9o Lebrun wrote:
>
> > > > +	if (ddata && ddata->quirks & CQSPI_DETECT_FIFO_DEPTH) {
> > > > +		cqspi->fifo_depth =3D fifo_depth;
> > > > +		dev_dbg(dev, "using FIFO depth of %u\n", fifo_depth);
> > > > +	} else if (fifo_depth !=3D cqspi->fifo_depth) {
> > > > +		dev_warn(dev, "detected FIFO depth (%u) different from config (%=
u)\n",
> > > > +			 fifo_depth, cqspi->fifo_depth);
> > > > +	}
>
> > > It's not obvious to me that we should ignore an explicitly specified
> > > property if the quirk is present
>
> > DT value isn't expected for compatibles with CQSPI_DETECT_FIFO_DEPTH
> > quirk, therefore we do not ignore a specified property. Bindings agree:
> > prop is false with EyeQ5 compatible.
>
> Sure, but it's not obvious that that is the most helpful or constructive
> way to handle things.

Agreed, a simpler solution can be found.

> > > - if anything I'd more expect to see
> > > the new warning in that case, possibly with a higher severity if we'r=
e
> > > saying that the quirk means we're more confident that the data report=
ed
> > > by the hardware is reliable.  I think what I'd expect is that we alwa=
ys
> > > use an explicitly specified depth (hopefully the user was specifying =
it
> > > for a reason?).
>
> > The goal was a simpler devicetree on Mobileye platform. This is why we
> > add this behavior flag. You prefer the property to be always present?
> > This is a only a nice-to-have, you tell me what you prefer.
>
> I would prefer that the property is always optional, or only required on
> platforms where we know that the depth isn't probeable.
>
> > I wasn't sure all HW behaved in the same way wrt read-only bits in
> > SRAMPARTITION, and I do not have access to other platforms exploiting
> > this driver. This is why I kept behavior reserved for EyeQ5-integrated
> > IP block.
>
> Well, if there's such little confidence that the depth is reported then
> we shouldn't be logging an error.
>
> > > Pulling all the above together can we just drop the quirk and always =
do
> > > the detection, or leave the quirk as just controlling the severity wi=
th
> > > which we log any difference between detected and explicitly configure=
d
> > > depths?
>
> > If we do not simplify devicetree, then I'd vote for dropping this patch
> > entirely. Adding code for detecting such an edge-case doesn't sound
> > useful. Especially since this kind of error should only occur to people
> > adding new hardware support; those probably do not need a nice
> > user-facing error message. What do you think?
>
> I'm confused why you think dropping the patch is a good idea?

Sorry I was unclear. I'll recap here options I see possible.

 - (1) Require DT property for all compatibles. That would be my
   preferred option *if* you think we should keep the DT property
   mandatory. I do not think requiring property AND detecting at
   runtime is useful.

 - (2) Require DT property for all but EyeQ5 compatible. On this
   platform, runtime detection is done.
    - (2a) On others, warn if value is different from DT property.
    - (2b) On others, do not detect+warn.

 - (3) Make DT property optional for all compatibles.
    - (3a) If provided, warn if runtime detect value is different.
    - (3b) If provided, do not detect+warn.

My preference would go to (3a):
 - we avoid a new quirk,
 - we avoid dt-bindings conditionals based on compatible,
 - we add a warning for a potentially buggy behavior and,
 - we do not modify FIFO depth used for existing devicetrees.

To make a choice, it'd be useful to know other platform behaviors. I
have no reason to think this SRAMPARTITION behavior isn't reproducable
on other platforms but I cannot guarantee anything. I just tested on TI
J7200 EVM with the quad SPI-NOR instance (spi@47040000) and it works as
expected.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



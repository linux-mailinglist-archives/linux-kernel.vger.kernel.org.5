Return-Path: <linux-kernel+bounces-103845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1AE87C553
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E919282502
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40E38C1E;
	Thu, 14 Mar 2024 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="NYFgkKuB"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96E66119;
	Thu, 14 Mar 2024 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710456363; cv=none; b=gUaWi3LOIGKrpOOon2Vag2p4w1gKCGZz+FKxi3R4hHyOZ3ekITy8oUNtoKTzoQDMm2soAOLymrfHdXrCMIf7qXHcMLdkWnMEu5nKu6qhxSZg+3mMNatlrO1KESy0WbKAlf9TKdAK/snIInq1cQz9DPjd9QK5An3vHLHgRYJXdBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710456363; c=relaxed/simple;
	bh=FtGcGGcCml3K6BfZXA29w4dWx4FPAxqXCh+2Kd5cs8E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qURshCbGxgcZcoI/hPa72W1VgXy1NM8ftcOjETD54QuKozwcaw1lqPPpD+8o0VxdtJtYaDESxPpwYADYST1/2GIfXs4MljNAt9yA4OE2X4aoJ985mMk/WhrMs5iFhhJl6M+VYW4mVOgCY/W4l0RAaF+O5MMFSgZHeyEBeceT/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=NYFgkKuB; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 74F2047565;
	Thu, 14 Mar 2024 22:39:55 +0000 (UTC)
Date: Thu, 14 Mar 2024 18:39:52 -0400
From: Aren <aren@peacevolution.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hans de Goede <j.w.r.degoede@gmail.com>, 
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Quentin Schulz <quentin.schulz@bootlin.com>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 5/5] power: supply: axp20x_usb_power: set input
 current limit in probe
Message-ID: <jzmibxh5avq4oxbldzayi754s6ir3e5zcphh4sfwzrl72j4msa@qersxklkpmtx>
References: <20240130203714.3020464-1-aren@peacevolution.org>
 <20240130203714.3020464-6-aren@peacevolution.org>
 <6nf7h3nc4q7fwrnm4spmgv2sdkczowkfpietcv2tyv4mixkq3b@svxgzkdqnzlq>
 <hlnzivsmt66icz4bsayv5wtlgbktq355m4qxj532lg4lgeimju@jammw2y6zpha>
 <uktr265th6h4btay765p33zgihuzgafu25rz7npwfm3ojhq2tm@wvrymmf3xtxy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uktr265th6h4btay765p33zgihuzgafu25rz7npwfm3ojhq2tm@wvrymmf3xtxy>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1710455996;
	h=from:subject:date:message-id:to:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=s5tG6UJiIsvtLfOlvkeSJg725lkDm4PeKTH/iA/Un+E=;
	b=NYFgkKuBDiWweYalediKlaNJBzUswQ4mYAiuRUgGDy4Orxf6jQ88JGzwQ/hljAdddkBeru
	iyY59M+viwlMGKe9wxtyBLK6RhZBYgbEiCotOrZcwMfJ0QcFxHzX2KuVik6UfVRxOGim85
	XJq5Ts4eZzTVLH76Smm03DbIvDrNWgw=

On Sun, Feb 11, 2024 at 12:27:12AM +0100, Ondřej Jirman wrote:
> On Tue, Jan 30, 2024 at 11:20:29PM -0500, Aren wrote:
> > On Tue, Jan 30, 2024 at 10:13:06PM +0100, Ondřej Jirman wrote:
> > > On Tue, Jan 30, 2024 at 03:28:01PM -0500, Aren Moynihan wrote:
> > > > Unfortunately BC 1.2 detection doesn't seem to be performed without a
> > > > battery, at least I wasn't able to trigger it.
> > > >
> > > > This will be worth revising once we have a driver that can provide a
> > > > signal that USB-PD is in progress and/or finished, but until then I'd
> > > > prefer not take on that complexity.
> > > 
> > > This patch adds complexity and will lead to hard to debug issues for some
> > > people. It certainly did cause issues for me, when I had similar patch in
> > > my tree a while ago, forcing me to drop it.
> > > 
> > > There are other situations you're not considering. Like battery being
> > > very discharged and unable to provide power, while still being detected
> > > and BC1.2 running correctly and successfully when the device is powered
> > > up by being plugged into DCP port (only option of powerup in such a 
> > > scenario).
> > 
> > Oh you're right, I overlooked the case where the battery is very low, in
> > which case bc detection should still be performed (I think, I haven't
> > tested it). This issue this patch is trying to fix doesn't apply in that
> > case, so it should be simple enough to check if the pmic has detected a
> > battery and skip setting the current limit if it has.
> >
> > > Battery is detected at 2.2V and certainly it will not provide any power
> > > if OCV of the battery is anywhere below 3V. See "9.4.5 Battery detection"
> > > in AXP803 datasheet. So you have about 1V range of possible battery voltage
> > > where BC1.2 will work, but you'll force lower the correctly detected current
> > > limit and break boot, because 2.5W is too low for the boot time power surge.
> > > 
> > > The phone will just randomly die halfthrough boot for apparently no reason,
> > > despite being connected to DCP.
> > > 
> > > And also forget Pinephone, there may also be batteryless SBCs using this PMIC
> > > with battery as an option (similar to Quartz64-A - Rockchip SBC, but exactly
> > > this setup with battery capable PMIC in the power path on a normal SBC, with
> > > battery being optional), where this patch will break boot on them, too. I'm
> > > quite confident PMIC relaxing the limit without a battery is meant for such use
> > > cases.
> > 
> > Perhaps it would be better to read the limit from the device tree, that
> > way it could be set higher for a specific board if it needs to draw that
> > much current and be able to boot without a battery? It seems sketchy to
> > default to a current limit significantly higher than what the usb power
> > supply is required to support.
> 
> But is there really an issue? The board may not be using USB power supply.
> It may simply have a barrel jack, like Quartz64-A does. And it will still
> create an issue if you make the new behavior "opt-out" via DT. You can make
> it opt-in if you like.

The axp20x_ac_power driver is used for the barrel jack, so this patch
shouldn't change how those devices behave. There are only a few boards
that are expected to boot/operate with only usb power, which should be
the only ones that need special attention.

> Also in Pinephone case, you'll not really have a case where the battery has
> < 2V not loaded. That's not going to happen. PMIC will shut off at 3V battery
> voltage when loaded. It will not discharge further, and after shutoff battery
> voltage will jump to 3.4V or so, and it will not drop below 2V after that, ever.
> So the battery will pretty much always be detected as long as it's present.

The most likely case I can think of is if someone intentionally tries to
boot the device without the battery. I suspect it's also possible for a
battery to degrade to the point where it won't hold a charge.

> What actual problem have you seen that this patch is trying to solve?

The problem, in theory, is that the pmic ignores the USB BC
specification and sets the current limit to 3A instead of 500mA. In
practice (as long as the power supply is implemented properly) if this
is too much power, it should just cause the power supply to shut off.
I'm not sure how likely / what the risks of a power supply cutting
corners are.

I find it surprising that the hardware/driver takes a lot of care to
figure out what the proper current is and stick to that, except when
there isn't a battery.

The point of this patch (after a revision) should be to make it explicit
when and why this driver ignores the USB BC specification. And to reduce
the cases where it does, if possible.

With the goal of making it explicit what cases ignore the spec, I would
prefer to have an opt-out mechanism. I compiled what I believe to be a
full list of devices that use this driver with usb bc enabled (detailed
notes below), and there's only a handful of them. It shouldn't be too
difficult to out-out the boards that need it.

> 
> Thank you and kind regards,
> 	o.

Sorry it took me a while to respond, I haven't had much time to work on
this in the past few weeks.

Regards
 - Aren

p.s. the notes on what devices use this functionality:

These devices include the axp803 or axp81x dtsi:
$ rg -l 'include "axp(803|81x).dtsi"'
 - sun50i-a100-allwinner-perf1.dts
 - sun50i-a64-amarula-relic.dts
 - sun50i-a64-bananapi-m64.dts
 - sun50i-a64-nanopi-a64.dts
 - sun50i-a64-olinuxino.dts
 - sun50i-a64-orangepi-win.dts
 - sun50i-a64-pine64.dts
 - sun50i-a64-pinebook.dts
 - sun50i-a64-pinephone.dtsi
 - sun50i-a64-pinetab.dts
 - sun50i-a64-sopine.dtsi
 - sun50i-a64-teres-i.dts
 - sun8i-a83t-allwinner-h8homlet-v2.dts
 - sun8i-a83t-bananapi-m3.dts
 - sun8i-a83t-cubietruck-plus.dts
 - sun8i-a83t-tbs-a711.dts

Out of those only these enable usb_power_supply:
$ rg -l 'include "axp(803|81x).dtsi"' | xargs rg -l 'usb_power_supply'
 - sun50i-a64-bananapi-m64.dts
 - sun50i-a64-pinetab.dts
 - sun50i-a64-pinephone.dtsi
 - sun8i-a83t-tbs-a711.dts
 - sun8i-a83t-cubietruck-plus.dts
 - sun8i-a83t-bananapi-m3.dts

sun50i-a64-bananapi-m64.dts: The barrel jack is connected to acin, so
will be unaffected. Banannapi docs say it's not possible to power over
usb, but schematic suggests it should work. Probably needs to opt-out of
the lower current limit.

sun50i-a64-pinetab.dts: unclear if charging is supported via usb, vbus
is connected through a component listed as "NC/0R". Regardless device
has barrel jack and battery for power, shouldn't need to run exclusively
from usb.

sun50i-a64-pinephone.dtsi: is typically booted with a battery connected,
shouldn't need to run exclusively from usb.

sun8i-a83t-tbs-a711.dts: has an internal battery, shouldn't need to run
exclusively from usb.

sun8i-a83t-cubietruck-plus.dts and sun8i-a83t-bananapi-m3.dts: Both
appear to support being powered over usb and a barrel jack. These will
need to opt-out to be able to run from usb.


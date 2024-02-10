Return-Path: <linux-kernel+bounces-60577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263AC850747
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AFC28381E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A0E5FEFC;
	Sat, 10 Feb 2024 23:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="sYqJw+DW"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392695FDA4;
	Sat, 10 Feb 2024 23:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707607640; cv=none; b=KjkvOsSiAqK4aRuPL9Cbx+GOc/QL89Ra28Sn2x/jOdp/uoNEMjBXHnuLLHEr6/au+5GWO9w+V68j1/IHU4aiChHRfv1bXggkEHL+dX+McR75i7uMDHQcpKTJ1kcy6KMWigZS/8weyKDpCVoLPh72a9gbakRmswi++QyG7ZO0AoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707607640; c=relaxed/simple;
	bh=/TgjizfIX8xFE594q/OFRPTu9VobMODx7LQ8bttWEUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dL4BUUeFS9SjEoP1itTRD+7tC8fXxN7VQhaHzJtKmZlzKdGSd8fJmn8bJRl3IzUNJ9BfmyKHl+gJvnFIq3UEVdGDHK+q7xsmRurOGRd6vAplvGkQ+uPp3ceUWADrQcELa6iJHZ3XC2gO7h0EYqR+6V2Fy2wcFjmumwxHtusF1xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=sYqJw+DW; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1707607633; bh=/TgjizfIX8xFE594q/OFRPTu9VobMODx7LQ8bttWEUs=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=sYqJw+DW8VLf/uoAHiG1g2gRy+MIUSJoAeinhzXKo4wHZ7syMVB3++rGEk+940qMG
	 ow88iS5WER5awo92aW7qyj5/FiqJaCgqney/v2eg4Q459/yiZmz3D4EXZ+QPQKeNAi
	 0HsN8I+mrWY5GhCDymZLRJLXBYXs6OIvYkyDEjV0=
Date: Sun, 11 Feb 2024 00:27:12 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Aren <aren@peacevolution.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <j.w.r.degoede@gmail.com>, Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>, Quentin Schulz <quentin.schulz@bootlin.com>, 
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 5/5] power: supply: axp20x_usb_power: set input
 current limit in probe
Message-ID: <uktr265th6h4btay765p33zgihuzgafu25rz7npwfm3ojhq2tm@wvrymmf3xtxy>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Aren <aren@peacevolution.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <j.w.r.degoede@gmail.com>, Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>, Quentin Schulz <quentin.schulz@bootlin.com>, 
	Sebastian Reichel <sre@kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240130203714.3020464-1-aren@peacevolution.org>
 <20240130203714.3020464-6-aren@peacevolution.org>
 <6nf7h3nc4q7fwrnm4spmgv2sdkczowkfpietcv2tyv4mixkq3b@svxgzkdqnzlq>
 <hlnzivsmt66icz4bsayv5wtlgbktq355m4qxj532lg4lgeimju@jammw2y6zpha>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hlnzivsmt66icz4bsayv5wtlgbktq355m4qxj532lg4lgeimju@jammw2y6zpha>

On Tue, Jan 30, 2024 at 11:20:29PM -0500, Aren wrote:
> On Tue, Jan 30, 2024 at 10:13:06PM +0100, Ondřej Jirman wrote:
> > On Tue, Jan 30, 2024 at 03:28:01PM -0500, Aren Moynihan wrote:
> > > Unfortunately BC 1.2 detection doesn't seem to be performed without a
> > > battery, at least I wasn't able to trigger it.
> > >
> > > This will be worth revising once we have a driver that can provide a
> > > signal that USB-PD is in progress and/or finished, but until then I'd
> > > prefer not take on that complexity.
> > 
> > This patch adds complexity and will lead to hard to debug issues for some
> > people. It certainly did cause issues for me, when I had similar patch in
> > my tree a while ago, forcing me to drop it.
> > 
> > There are other situations you're not considering. Like battery being
> > very discharged and unable to provide power, while still being detected
> > and BC1.2 running correctly and successfully when the device is powered
> > up by being plugged into DCP port (only option of powerup in such a 
> > scenario).
> 
> Oh you're right, I overlooked the case where the battery is very low, in
> which case bc detection should still be performed (I think, I haven't
> tested it). This issue this patch is trying to fix doesn't apply in that
> case, so it should be simple enough to check if the pmic has detected a
> battery and skip setting the current limit if it has.
>
> > Battery is detected at 2.2V and certainly it will not provide any power
> > if OCV of the battery is anywhere below 3V. See "9.4.5 Battery detection"
> > in AXP803 datasheet. So you have about 1V range of possible battery voltage
> > where BC1.2 will work, but you'll force lower the correctly detected current
> > limit and break boot, because 2.5W is too low for the boot time power surge.
> > 
> > The phone will just randomly die halfthrough boot for apparently no reason,
> > despite being connected to DCP.
> > 
> > And also forget Pinephone, there may also be batteryless SBCs using this PMIC
> > with battery as an option (similar to Quartz64-A - Rockchip SBC, but exactly
> > this setup with battery capable PMIC in the power path on a normal SBC, with
> > battery being optional), where this patch will break boot on them, too. I'm
> > quite confident PMIC relaxing the limit without a battery is meant for such use
> > cases.
> 
> Perhaps it would be better to read the limit from the device tree, that
> way it could be set higher for a specific board if it needs to draw that
> much current and be able to boot without a battery? It seems sketchy to
> default to a current limit significantly higher than what the usb power
> supply is required to support.

But is there really an issue? The board may not be using USB power supply.
It may simply have a barrel jack, like Quartz64-A does. And it will still
create an issue if you make the new behavior "opt-out" via DT. You can make
it opt-in if you like.

Also in Pinephone case, you'll not really have a case where the battery has
< 2V not loaded. That's not going to happen. PMIC will shut off at 3V battery
voltage when loaded. It will not discharge further, and after shutoff battery
voltage will jump to 3.4V or so, and it will not drop below 2V after that, ever.
So the battery will pretty much always be detected as long as it's present.

What actual problem have you seen that this patch is trying to solve?

Thank you and kind regards,
	o.


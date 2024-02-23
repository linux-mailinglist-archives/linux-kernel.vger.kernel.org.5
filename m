Return-Path: <linux-kernel+bounces-79312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA1E8620A6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B632851D7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6042414DFD1;
	Fri, 23 Feb 2024 23:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="Kb9O2ZhI"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC7BDDBB;
	Fri, 23 Feb 2024 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708730922; cv=none; b=DTZWpQpdJY3JvoN5JswJ3mF1gbtYK61DzKNFyqHAiGvUD/5jYrirTyiePpVrIxzv4ATA1NjI+TBLhV6SPMgrKVc06mU0KZKUQEizEzvWwUPM7H8VzkDI7z9vON/XGmCFXEYe7r8n/aDT42YK6aAMTBzjA4dKM/MmAiVql8N4J9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708730922; c=relaxed/simple;
	bh=9NZ5JkXy//hRPPcVyOT31xfjN3H4Ao1higU7/Kkae6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOmg53JVlKOtb6bUFtzJZGrRIXwzwwFDbyHeh9W27IynmvmOVv1DB3vY/38pUSCb7nwkNM9nVoBBnML/XgbcyX3ne3n2eAB3o14Tr+TvDHhP9p3p6vKgtSUHkrwBulsG6tBbtmdg/oxDrKffQB4jixufo3+ajAQ/5rfixf4GX28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=Kb9O2ZhI; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708730916; bh=9NZ5JkXy//hRPPcVyOT31xfjN3H4Ao1higU7/Kkae6o=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=Kb9O2ZhI0rdpldF8sbpwobtvyflXwY+QwtVtWeudheCzyeo3B320kK7II46vdelkk
	 l81V2GoVhJLIjPeSkzyLkSj7AdBJOIE8BYRtt9DdEK99TOyJKUf2SSSlBVxk7iK0nr
	 Nx3PFCaNp36RneJF1RXWah2lJbSonNs8pmULbw3c=
Date: Sat, 24 Feb 2024 00:28:36 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Aren <aren@peacevolution.org>
Cc: linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	linux-arm-kernel@lists.infradead.org, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	linux-leds@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Miles Alan <m@milesalan.com>, 
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 3/4] arm64: dts: sun50i-a64-pinephone: add multicolor
 led node
Message-ID: <xhowm7pne2og7iyhoa7wi26qa5q23fvl2ptaxtwnp4upgunubo@q5unl6mzvluy>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Aren <aren@peacevolution.org>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	linux-arm-kernel@lists.infradead.org, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	linux-leds@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Miles Alan <m@milesalan.com>, 
	Samuel Holland <samuel@sholland.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240206185400.596979-1-aren@peacevolution.org>
 <20240206185400.596979-3-aren@peacevolution.org>
 <sixgkkllo7medcjwjnmbkpqkgfvnmrtlhlwarwuxid5oqwrht5@gl65b6fetq2b>
 <5hqfabcolgqcu22hs3xnaimojwuz26tzi63px3rvbsgxa6kjss@ik42w7k26see>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5hqfabcolgqcu22hs3xnaimojwuz26tzi63px3rvbsgxa6kjss@ik42w7k26see>

Hello Aren,

On Fri, Feb 23, 2024 at 10:22:36AM -0500, Aren wrote:
> On Fri, Feb 23, 2024 at 09:46:25AM +0100, Ondřej Jirman wrote:
> > Hello Aren,
> > 
> > On Tue, Feb 06, 2024 at 01:13:19PM -0500, Aren Moynihan wrote:
> > > The red, green, and blue leds currently in the device tree represent a
> > > single rgb led on the front of the PinePhone.
> > > 
> > > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> > > ---
> > > 
> > > Changes in v2:
> > >  - remove function property from individual led nodes
> > > 
> > >  .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 16 ++++++++++------
> > >  1 file changed, 10 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > > index ad2476ee01e4..e53e0d4579a7 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > > @@ -39,28 +39,32 @@ chosen {
> > >  	leds {
> > >  		compatible = "gpio-leds";
> > >  
> > > -		led-0 {
> > > -			function = LED_FUNCTION_INDICATOR;
> > 
> > This looks like a needless change that will just break people's current scripts
> > and setup. It does mine, and there sure are others that will be surprised, too.
> > 
> > This leads to a change in sysfs path from:
> > 
> >   /sys/class/leds/blue:indicator
> > 
> > to
> > 
> >   /sys/class/leds/blue:
> > 
> > which is 1) a weird name and 2) a backwards compatibility break for seemingly
> > no apparent reason. Any reaons for the change?
> 
> Leds-group-multicolor will make those read-only, so that will break when
> it's enabled either way. Removing the function property makes it less
> likely that programs attempting to discover leds will use the wrong
> path.

Allright. Then this breaks even more usecases then I thought. I quite depend on
being able to apply various kernel based LED triggers to individual LEDs in the
RGB LED. (The LED is not really multi-color in practice - you don't get a mix of
colors. It's only technically a RGB LED, but if you turn on red and green, you
see red and green, individually. I suspect it's a clear capped LED, not
a diffused one and expects an external difuser - which Pinephone doesn't have.
So this works out quite fine from the user perspective, because you see
individual colors and can assign meanings to them individually)

So this change makes it that I'll not be able to map different triggers
to individual colors now.

Eg. I have a power manager driver for Pinephone keyboard that exports LED triggers
to indicate various charging states of the keyboard battery, so that I get
warnings when the KB is discharged, or disconnected from control algorithm
due to its tendency to shut off, and disappear from I2C bus, etc. AXP20x driver
also exports a bunch of useful triggers.

---

As a side note, this new multicolor abstraction seems a bit lacking and
cumbersome, too.

I still have to control individual LEDs via multi_intensity file and have to
parse multi_index to even know which number corresponds to what color. In addition
I have to ensure correct value in brightness file.

If I want to change one of the LEDs, I now have to first read the whole status
of multi-color LED and update it somehow in a non-racy way, which is
impossible with this API without going through some userspace daemon that
centralizes the LED control. 

If this is expected to be usable in device independent way, then there's another
problem:  multi_intensity values don't seem to have any range defined in sysfs,
so I can't know what is the max usable value. How do I know the range is 0-1 vs
0-255 or 0-200000? There's max_brightness but that seems to be related to
possible values in brightness file. Seems like I can write pretty much anything
to multi_intensity, even things like this:

  https://megous.com/dl/tmp/4c6db9376f148951.png

(looks like all LEDs are turned on even for negative intensity)

If multi_intensity is supposed to be some relative measure of brightenss of
individual LEDs in RGB LED, then echo '1 1 1000' > multi_intensity 
should pretty much result in only red LED being on. But all are on at full
brightness. So the kernel doesn't even represent the desired color properly,
based on HW limitations it knows about. There's no aproximation/rounding to the
limits of control of individual LEDs. Even 1 millionth of relative intensity
will result in the LED being turned fully on.

Discoverability of how to control the LEDs is also quite lacking. Individual
directories under /sys/class/leds are still there for individual parts of RGB
LED, and it's not clearly identifiable that you can't control them. brightness
file still has -rw-r--r-- permissions. But writing to it produces EBUSY.
As far as I can see, the only indication that something is amiss is that
there's a device/consumer:platform:multi-led symlink under the individual LEDs.
But that can have any name in practice, and how can one know that just because
some device has a in-kernel consumer, that it's a kind of a consumer that blocks
changes to the device?

If I have to discover that some LED is controlled by some other driver only
by trying to light it up, then that's not a great API, I'd say.

End of side note. :)

---

^^^^ All this from the PoV of a (API) user. I can understand the device-tree
appeal of representing the technically RGB LED as RGB node, but as a user who
messes with sysfs, and likes the simplicity and flexibility of how things work
now, with the upstream Pinephone DT, I really dislike the change, because it
forces unpleasant userspace changes, incl. necessity for some userspace LED
control daemon to get race-free LED control from multiple sources. And I'm not
even sure what I'd do with the keyboard driver, and how to keep the triggers
working.

Anyway, I and others can get around all this by:

  echo multi-led > /sys/class/leds/rgb:status/device/driver/unbind

at system startup and get back control via idndividual LED directories.
But please don't change the names of directories that were there up to now. That
will just break many people's scripts for no reason. So my only request is to
make this fallback to previous way it worked easy.

Kind regards,
	o.

> I left these in v1 of this patch, but was recommended to remove them.
> https://lore.kernel.org/lkml/k26bellccok4tj3kz2nrtp2vth2rnsiea677e2kzm56m767wjx@pnkqiz5hmiyb/
>
> Thanks for taking a look at this
>  - Aren
> 
> > People normally hardcode these paths in eg. /etc/tmpfiles.d to apply LED triggers
> > to particular LEDs.
> > 
> > Kind regards,
> > 	o.
> > 
> > > +		led0: led-0 {
> > >  			color = <LED_COLOR_ID_BLUE>;
> > >  			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
> > >  			retain-state-suspended;
> > >  		};
> > >  
> > > -		led-1 {
> > > -			function = LED_FUNCTION_INDICATOR;
> > > +		led1: led-1 {
> > >  			color = <LED_COLOR_ID_GREEN>;
> > >  			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
> > >  			retain-state-suspended;
> > >  		};
> > >  
> > > -		led-2 {
> > > -			function = LED_FUNCTION_INDICATOR;
> > > +		led2: led-2 {
> > >  			color = <LED_COLOR_ID_RED>;
> > >  			gpios = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
> > >  			retain-state-suspended;
> > >  		};
> > >  	};
> > >  
> > > +	multi-led {
> > > +		compatible = "leds-group-multicolor";
> > > +		color = <LED_COLOR_ID_RGB>;
> > > +		function = LED_FUNCTION_INDICATOR;
> > > +		leds = <&led0>, <&led1>, <&led2>;
> > > +	};
> > > +
> > >  	reg_ps: ps-regulator {
> > >  		compatible = "regulator-fixed";
> > >  		regulator-name = "ps";
> > > -- 
> > > 2.43.0
> > > 


Return-Path: <linux-kernel+bounces-79448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8447A86225F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 03:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC01B222C5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AF5125A7;
	Sat, 24 Feb 2024 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="Lqt/S9iW"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC14E559;
	Sat, 24 Feb 2024 02:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708743133; cv=none; b=PQ8wKdKidLbBntBQWcKrZNvPhFSUTv554ZmP+ZSz7+5EWBNpAe6kMPXdvn+bS5nQty3uSvo0G4Y/bt3f2TfZmmvx62Zrq8aNcZJAt+4g28a3WmlYfDusrUcDPR8auXTQtpyqq+q8ByVeR2nA7Y0bVDSnHa1N3WnxqMHGCiWVV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708743133; c=relaxed/simple;
	bh=K/u1uP2fB1x2ynQuaKNAjHXlhjEAhzFWzVZsJtUO+28=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwQZ1352OGY4AFff5IwLv6c5STIxa53L2Za33BGBwiJbzufQ1D/qshqAnbdiCvMfegTTQTLMR7/Lutk4W1NclBF4GCnHdbc1xjTFMoW3bHRB98vrt4pG1HB6i2XBHXoL1ccRPjrh1S1mTXZSnw9hD+ruTAPM2GoxPIrhDmT3Mk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=Lqt/S9iW; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 783FE3FAAC;
	Sat, 24 Feb 2024 02:52:07 +0000 (UTC)
Date: Fri, 23 Feb 2024 21:52:04 -0500
From: Aren <aren@peacevolution.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	linux-arm-kernel@lists.infradead.org, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	linux-leds@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Miles Alan <m@milesalan.com>, 
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 3/4] arm64: dts: sun50i-a64-pinephone: add multicolor
 led node
Message-ID: <lkhwdfw67nfgsz2pectd7xgr724owf4z2qlyinmxncv5ncf4mw@si7tvaao7ums>
References: <20240206185400.596979-1-aren@peacevolution.org>
 <20240206185400.596979-3-aren@peacevolution.org>
 <sixgkkllo7medcjwjnmbkpqkgfvnmrtlhlwarwuxid5oqwrht5@gl65b6fetq2b>
 <5hqfabcolgqcu22hs3xnaimojwuz26tzi63px3rvbsgxa6kjss@ik42w7k26see>
 <xhowm7pne2og7iyhoa7wi26qa5q23fvl2ptaxtwnp4upgunubo@q5unl6mzvluy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhowm7pne2og7iyhoa7wi26qa5q23fvl2ptaxtwnp4upgunubo@q5unl6mzvluy>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1708743128;
	h=from:subject:date:message-id:to:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=+Vx2hLcbv/rZ3qoHegu6oTxF8sgJvV2PO82Oeho+oKM=;
	b=Lqt/S9iW8cUgRsCJgjJhK//VDEYyi9J5iUOvl6XKuup+ZCXoOA3tHS+y9eiO2lHIIiLinx
	VDbAC2WEm0I62CLjdhkGSiW/hlziHyIUyR8p6G2F4ld6ps8cUjrcP3SGmgsj9hyjJBuiFU
	9aJMQBu8O5QVRoSiMHzYx2Qd8S3/3Kg=

On Sat, Feb 24, 2024 at 12:28:36AM +0100, Ondřej Jirman wrote:
> Hello Aren,
> 
> On Fri, Feb 23, 2024 at 10:22:36AM -0500, Aren wrote:
> > On Fri, Feb 23, 2024 at 09:46:25AM +0100, Ondřej Jirman wrote:
> > > Hello Aren,
> > > 
> > > On Tue, Feb 06, 2024 at 01:13:19PM -0500, Aren Moynihan wrote:
> > > > The red, green, and blue leds currently in the device tree represent a
> > > > single rgb led on the front of the PinePhone.
> > > > 
> > > > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> > > > ---
> > > > 
> > > > Changes in v2:
> > > >  - remove function property from individual led nodes
> > > > 
> > > >  .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 16 ++++++++++------
> > > >  1 file changed, 10 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > > > index ad2476ee01e4..e53e0d4579a7 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > > > @@ -39,28 +39,32 @@ chosen {
> > > >  	leds {
> > > >  		compatible = "gpio-leds";
> > > >  
> > > > -		led-0 {
> > > > -			function = LED_FUNCTION_INDICATOR;
> > > 
> > > This looks like a needless change that will just break people's current scripts
> > > and setup. It does mine, and there sure are others that will be surprised, too.
> > > 
> > > This leads to a change in sysfs path from:
> > > 
> > >   /sys/class/leds/blue:indicator
> > > 
> > > to
> > > 
> > >   /sys/class/leds/blue:
> > > 
> > > which is 1) a weird name and 2) a backwards compatibility break for seemingly
> > > no apparent reason. Any reaons for the change?
> > 
> > Leds-group-multicolor will make those read-only, so that will break when
> > it's enabled either way. Removing the function property makes it less
> > likely that programs attempting to discover leds will use the wrong
> > path.
> 
> Allright. Then this breaks even more usecases then I thought. I quite depend on
> being able to apply various kernel based LED triggers to individual LEDs in the
> RGB LED. (The LED is not really multi-color in practice - you don't get a mix of
> colors. It's only technically a RGB LED, but if you turn on red and green, you
> see red and green, individually. I suspect it's a clear capped LED, not
> a diffused one and expects an external difuser - which Pinephone doesn't have.
> So this works out quite fine from the user perspective, because you see
> individual colors and can assign meanings to them individually)
> 
> So this change makes it that I'll not be able to map different triggers
> to individual colors now.
> 
> Eg. I have a power manager driver for Pinephone keyboard that exports LED triggers
> to indicate various charging states of the keyboard battery, so that I get
> warnings when the KB is discharged, or disconnected from control algorithm
> due to its tendency to shut off, and disappear from I2C bus, etc. AXP20x driver
> also exports a bunch of useful triggers.
> 
> ---
> 
> As a side note, this new multicolor abstraction seems a bit lacking and
> cumbersome, too.
> 
> I still have to control individual LEDs via multi_intensity file and have to
> parse multi_index to even know which number corresponds to what color. In addition
> I have to ensure correct value in brightness file.
> 
> If I want to change one of the LEDs, I now have to first read the whole status
> of multi-color LED and update it somehow in a non-racy way, which is
> impossible with this API without going through some userspace daemon that
> centralizes the LED control. 
> 
> If this is expected to be usable in device independent way, then there's another
> problem:  multi_intensity values don't seem to have any range defined in sysfs,
> so I can't know what is the max usable value. How do I know the range is 0-1 vs
> 0-255 or 0-200000? There's max_brightness but that seems to be related to
> possible values in brightness file. Seems like I can write pretty much anything
> to multi_intensity, even things like this:
> 
>   https://megous.com/dl/tmp/4c6db9376f148951.png
> 
> (looks like all LEDs are turned on even for negative intensity)
> 
> If multi_intensity is supposed to be some relative measure of brightenss of
> individual LEDs in RGB LED, then echo '1 1 1000' > multi_intensity 
> should pretty much result in only red LED being on. But all are on at full
> brightness. So the kernel doesn't even represent the desired color properly,
> based on HW limitations it knows about. There's no aproximation/rounding to the
> limits of control of individual LEDs. Even 1 millionth of relative intensity
> will result in the LED being turned fully on.
> 
> Discoverability of how to control the LEDs is also quite lacking. Individual
> directories under /sys/class/leds are still there for individual parts of RGB
> LED, and it's not clearly identifiable that you can't control them. brightness
> file still has -rw-r--r-- permissions. But writing to it produces EBUSY.
> As far as I can see, the only indication that something is amiss is that
> there's a device/consumer:platform:multi-led symlink under the individual LEDs.
> But that can have any name in practice, and how can one know that just because
> some device has a in-kernel consumer, that it's a kind of a consumer that blocks
> changes to the device?
> 
> If I have to discover that some LED is controlled by some other driver only
> by trying to light it up, then that's not a great API, I'd say.
> 
> End of side note. :)
> 
> ---
> 
> ^^^^ All this from the PoV of a (API) user. I can understand the device-tree
> appeal of representing the technically RGB LED as RGB node, but as a user who
> messes with sysfs, and likes the simplicity and flexibility of how things work
> now, with the upstream Pinephone DT, I really dislike the change, because it
> forces unpleasant userspace changes, incl. necessity for some userspace LED
> control daemon to get race-free LED control from multiple sources. And I'm not
> even sure what I'd do with the keyboard driver, and how to keep the triggers
> working.
> 
> Anyway, I and others can get around all this by:
> 
>   echo multi-led > /sys/class/leds/rgb:status/device/driver/unbind
> 
> at system startup and get back control via idndividual LED directories.
> But please don't change the names of directories that were there up to now. That
> will just break many people's scripts for no reason. So my only request is to
> make this fallback to previous way it worked easy.

Makes sense, I'll send v1 again with a revised commit message when I get
a chance (this was the only change to the device tree part of this
patchset between v1 and v2).

Thanks
 - Aren

> Kind regards,
> 	o.
> 
> > I left these in v1 of this patch, but was recommended to remove them.
> > https://lore.kernel.org/lkml/k26bellccok4tj3kz2nrtp2vth2rnsiea677e2kzm56m767wjx@pnkqiz5hmiyb/
> >
> > Thanks for taking a look at this
> >  - Aren
> > 
> > > People normally hardcode these paths in eg. /etc/tmpfiles.d to apply LED triggers
> > > to particular LEDs.
> > > 
> > > Kind regards,
> > > 	o.
> > > 
> > > > +		led0: led-0 {
> > > >  			color = <LED_COLOR_ID_BLUE>;
> > > >  			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
> > > >  			retain-state-suspended;
> > > >  		};
> > > >  
> > > > -		led-1 {
> > > > -			function = LED_FUNCTION_INDICATOR;
> > > > +		led1: led-1 {
> > > >  			color = <LED_COLOR_ID_GREEN>;
> > > >  			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
> > > >  			retain-state-suspended;
> > > >  		};
> > > >  
> > > > -		led-2 {
> > > > -			function = LED_FUNCTION_INDICATOR;
> > > > +		led2: led-2 {
> > > >  			color = <LED_COLOR_ID_RED>;
> > > >  			gpios = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
> > > >  			retain-state-suspended;
> > > >  		};
> > > >  	};
> > > >  
> > > > +	multi-led {
> > > > +		compatible = "leds-group-multicolor";
> > > > +		color = <LED_COLOR_ID_RGB>;
> > > > +		function = LED_FUNCTION_INDICATOR;
> > > > +		leds = <&led0>, <&led1>, <&led2>;
> > > > +	};
> > > > +
> > > >  	reg_ps: ps-regulator {
> > > >  		compatible = "regulator-fixed";
> > > >  		regulator-name = "ps";
> > > > -- 
> > > > 2.43.0
> > > > 


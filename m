Return-Path: <linux-kernel+bounces-11311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FC181E461
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 02:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A150281DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8522BA40;
	Tue, 26 Dec 2023 01:17:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD98A2A;
	Tue, 26 Dec 2023 01:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7513A1FB;
	Mon, 25 Dec 2023 17:17:45 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B7A03F641;
	Mon, 25 Dec 2023 17:16:58 -0800 (PST)
Date: Tue, 26 Dec 2023 01:16:34 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: fuyao <fuyao@sjterm.com>
Cc: fuyao <fuyao1697@cyg.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Alexandre
 TORGUE <alexandre.torgue@st.com>, Enric Balletbo i Serra
 <eballetbo@gmail.com>, Baruch Siach <baruch@tkos.co.il>, Paul Barker
 <paul.barker@sancloud.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ARM: dts: sun8i: r40: open the regulator aldo1
Message-ID: <20231226011634.32e2342d@minigeek.lan>
In-Reply-To: <ZYlVTFrWkPaci92K@debian.cyg>
References: <ZYKjYypuAx7gNuam@debian.cyg>
	<20231220150400.0f32e2a5@donnerap.manchester.arm.com>
	<ZYOhAQi7XeLUuAC9@debian.cyg>
	<20231221103906.1830ef94@donnerap.manchester.arm.com>
	<ZYlVTFrWkPaci92K@debian.cyg>
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

On Mon, 25 Dec 2023 18:11:24 +0800
fuyao <fuyao@sjterm.com> wrote:

Hi,

thanks for the reply, with insightful information!

> On Thu, Dec 21, 2023 at 10:39:06AM +0000, Andre Przywara wrote:
> > On Thu, 21 Dec 2023 10:20:49 +0800
> > fuyao <fuyao@sjterm.com> wrote:
> > 
> > Hi,
> > 
> > thanks for the reply!
> >   
> > > On Wed, Dec 20, 2023 at 03:04:00PM +0000, Andre Przywara wrote:  
> > > > On Wed, 20 Dec 2023 16:18:43 +0800
> > > > fuyao <fuyao1697@cyg.com> wrote:
> > > > 
> > > > Hi,
> > > >     
> > > > > the aldo1 is connect regulator pin which power the TV.    
> > > > 
> > > > What do you mean with that? That ALDO1 is connected to VCC-TVOUT and/or
> > > > VCC-TVIN on the R40 SoC?    
> > > 
> > > The ALDO1 is connected to VCC-TVOUT on the R40 Soc.  
> > 
> > Ah, thanks for the confirmation.
> >   
> > > > > The USB core use TV ref as reference Voltage.    
> > > > 
> > > > The USB core in the SoC? So pin VCC-USB, which requires 3.3V, the same
> > > > voltage as the TV pins?
> > > > Which means this doesn't really have much to do with TV, it's just that
> > > > USB and also "TV" are supplied by ALDO1?    
> > > 
> > > The internal USB PHY requires a reference voltage. It seems that in
> > > order to save costs, the reference voltage of the TVOUT module is used.  
> > 
> > Do you mean a USB *reference* voltage that is separate from the USB PHY
> > power supply voltage, so pin VCC-USB on the SoC? And that it is internally
> > connected to some TV-OUT related circuits? So that would apply to all
> > devices using the R40 SoC then?  
> yes, The usb need a power from TV module insides.

Ah, alright. I dimly remember hearing reports about unstable USB
operation on some (custom?) R40 boards, that might as well explain it.
On the BananaPis (the only other officially supported R40 boards),
TVOUT and TVOUT are connected to DCDC1, so are effectively always
powered by 3.3V already, which would explain why we didn't observe USB
issues there.

> > Or is it simply that the SoC pins VCC-TVOUT and VCC-USB are connected
> > together, on this SoM?  
> no

Thanks for the confirmation!

> > Do you have access to some schematic? I couldn't find one online easily,
> > so cannot check this myself.
> >   
> It has up to https://file.io/VSUL4FDrapDY

Ah, many thanks, that's really useful! That indeed confirms that both
TVIN and TVOUT are exclusively powered by ALDO1.

So if you resend the patch as v2, with the regulator-name changed, and
possibly with the following commit message, I'd support it:

=============
The USB PHY in the Allwinner R40 SoC seems to rely on voltage on the
VCC-TVIN/OUT supply pins for proper operation, on top of its own supply
voltage on VCC-USB. Without a 3.3V voltage supplied to VCC-TV*, USB
operation becomes unstable and can result in disconnects.

The Forlinx FETA40i-C SoM connects both the VCC-TVOUT and VCC-TVIN pins
to the ALDO1 rail of the PMIC, so we need to enable that rail for USB
operation. Since there is no supply property in the DT bindings for
the USB core, we need to always enable the regulator.

This fixes unstable USB operation on boards using the Forlinx FETA40i-C
module.
================

Cheers,
Andre


> > Thanks,
> > Andre
> >   
> > > > > Signed-off-by: fuyao <fuyao1697@cyg.com>
> > > > > ---
> > > > >  arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi b/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
> > > > > index 9f39b5a2bb35..8906170461df 100644
> > > > > --- a/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
> > > > > +++ b/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
> > > > > @@ -42,6 +42,13 @@ &pio {
> > > > >  	vcc-pg-supply = <&reg_dldo1>;
> > > > >  };
> > > > >  
> > > > > +&reg_aldo1 {
> > > > > +	regulator-always-on;    
> > > > 
> > > > So did USB never work before, with the DT as in mainline?
> > > >     
> > > 
> > > The USB can work, but is unstable. Occasionally disconnected because of
> > > the D+/D- electrical characteristics.
> > >   
> > > > For always-on regulators it would be good to see some rationale why this
> > > > cannot be referenced by its consumer. If it is really supplying the USB
> > > > core, that would be a reason, because we don't have a good way of
> > > > describing this.
> > > >     
> > > > > +	regulator-min-microvolt = <3300000>;
> > > > > +	regulator-max-microvolt = <3300000>;
> > > > > +	regulator-name = "vcc-aldo1";    
> > > > 
> > > > Regulators should be named after their users, so use something like:
> > > > 	regulator-name = "vcc-3v3-tv-usb";
> > > >     
> > > 
> > > thanks.
> > >   
> > > > That then also serves as documentation of why this is always on.
> > > > 
> > > > Cheers,
> > > > Andre
> > > >     
> > > > > +};
> > > > > +
> > > > >  &reg_aldo2 {
> > > > >  	regulator-always-on;
> > > > >  	regulator-min-microvolt = <1800000>;    
> > > >     
> > >   
> 



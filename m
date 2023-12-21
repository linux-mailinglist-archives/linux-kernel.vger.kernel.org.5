Return-Path: <linux-kernel+bounces-7748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB3481AC93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B74287ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3F9258B;
	Thu, 21 Dec 2023 02:20:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out28-38.mail.aliyun.com (out28-38.mail.aliyun.com [115.124.28.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B30B1843;
	Thu, 21 Dec 2023 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjterm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjterm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08253946|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.759945-0.00196268-0.238092;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=fuyao@sjterm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.VpJwiCT_1703125249;
Received: from localhost(mailfrom:fuyao@sjterm.com fp:SMTPD_---.VpJwiCT_1703125249)
          by smtp.aliyun-inc.com;
          Thu, 21 Dec 2023 10:20:50 +0800
Date: Thu, 21 Dec 2023 10:20:49 +0800
From: fuyao <fuyao@sjterm.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: fuyao <fuyao1697@cyg.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Paul Barker <paul.barker@sancloud.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ARM: dts: sun8i: r40: open the regulator aldo1
Message-ID: <ZYOhAQi7XeLUuAC9@debian.cyg>
Mail-Followup-To: Andre Przywara <andre.przywara@arm.com>,
	fuyao <fuyao1697@cyg.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Paul Barker <paul.barker@sancloud.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
References: <ZYKjYypuAx7gNuam@debian.cyg>
 <20231220150400.0f32e2a5@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220150400.0f32e2a5@donnerap.manchester.arm.com>
Organization: work_work_work

On Wed, Dec 20, 2023 at 03:04:00PM +0000, Andre Przywara wrote:
> On Wed, 20 Dec 2023 16:18:43 +0800
> fuyao <fuyao1697@cyg.com> wrote:
> 
> Hi,
> 
> > the aldo1 is connect regulator pin which power the TV.
> 
> What do you mean with that? That ALDO1 is connected to VCC-TVOUT and/or
> VCC-TVIN on the R40 SoC?

The ALDO1 is connected to VCC-TVOUT on the R40 Soc.

> 
> > The USB core use TV ref as reference Voltage.
> 
> The USB core in the SoC? So pin VCC-USB, which requires 3.3V, the same
> voltage as the TV pins?
> Which means this doesn't really have much to do with TV, it's just that
> USB and also "TV" are supplied by ALDO1?

The internal USB PHY requires a reference voltage. It seems that in
order to save costs, the reference voltage of the TVOUT module is used.

> 
> > Signed-off-by: fuyao <fuyao1697@cyg.com>
> > ---
> >  arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi b/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
> > index 9f39b5a2bb35..8906170461df 100644
> > --- a/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
> > +++ b/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
> > @@ -42,6 +42,13 @@ &pio {
> >  	vcc-pg-supply = <&reg_dldo1>;
> >  };
> >  
> > +&reg_aldo1 {
> > +	regulator-always-on;
> 
> So did USB never work before, with the DT as in mainline?
> 

The USB can work, but is unstable. Occasionally disconnected because of
the D+/D- electrical characteristics.

> For always-on regulators it would be good to see some rationale why this
> cannot be referenced by its consumer. If it is really supplying the USB
> core, that would be a reason, because we don't have a good way of
> describing this.
> 
> > +	regulator-min-microvolt = <3300000>;
> > +	regulator-max-microvolt = <3300000>;
> > +	regulator-name = "vcc-aldo1";
> 
> Regulators should be named after their users, so use something like:
> 	regulator-name = "vcc-3v3-tv-usb";
> 

thanks.

> That then also serves as documentation of why this is always on.
> 
> Cheers,
> Andre
> 
> > +};
> > +
> >  &reg_aldo2 {
> >  	regulator-always-on;
> >  	regulator-min-microvolt = <1800000>;
> 



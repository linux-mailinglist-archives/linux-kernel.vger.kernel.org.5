Return-Path: <linux-kernel+bounces-153466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C7E8ACE71
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478B31F21739
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5C314F9E0;
	Mon, 22 Apr 2024 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="riMPnVD9"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776861DFF0;
	Mon, 22 Apr 2024 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793087; cv=none; b=KiFG8VQXe/xvL5Cjd9ekTbeXhcYM2RvzoON3DQ3Y5Y5S7iXqhkq9cwdE7KiAsyY+cDqLzocHZsAlbc1XlrhQPFwDqsuBTMfkX5H+g0FnuLrs7GrJTiwJNJILdphg1soE0vQvFSEo6TceRChue6jkrKbm8LCeqMKkN55XOssr9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793087; c=relaxed/simple;
	bh=/b9wDmN1JJVm3q4XIJa9ojb9o9zQd1sK0dbVkNVYTxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObBKVilw2CZ6aUb/qfVwwAYoc/SDh5pxA4P7Z/dy8xcOD5ZH3cMEtXkiWmUynmleFcJhllyJ9jnuu81j/b1s07+o5/7a9xiXwZMRwrkwiaSIowBHx2xPVbDuO0KQ83oTs6sTUVuNWXlFe6G9iX/eXsBxJ2zfqozKuPOJN1GXh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=riMPnVD9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z81Hn2wA/+Uj7Uzyftbfopp02iSniH0rYdaqzFMODuI=; b=riMPnVD9u/RcXfaiLo4d/CRKmo
	4guu9gHfcHVjEF1erkrkafPTNNnl+ZNKeVNi6LlLK7k6vtx4gjGjOFbTZs7C5+/+0p/czOPYZmoL0
	n3hrrDW4Sdcgtb7h+Pkq91Oe5cNiZDF89FfeImw7+/4DEuaITIdhtG+piwiTg/vKkxt0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rytro-00DcZa-Pq; Mon, 22 Apr 2024 15:37:56 +0200
Date: Mon, 22 Apr 2024 15:37:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Message-ID: <fd466583-3221-4b94-b66b-18840615fb71@lunn.ch>
References: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
 <20240414-cn9130-som-v3-4-350a67d44e0a@solid-run.com>
 <3958052d-fc09-4c4c-a9e3-4923871cff44@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3958052d-fc09-4c4c-a9e3-4923871cff44@solid-run.com>

On Sun, Apr 14, 2024 at 01:18:56PM +0000, Josua Mayer wrote:
> Am 14.04.24 um 14:58 schrieb Josua Mayer:
> > Add description for the SolidRun CN9131 SolidWAN, based on CN9130 SoM
> > with an extra communication  processor on the carrier board.
> >
> > This board differentiates itself from CN9130 Clearfog by providing
> > additional SoC native network interfaces and pci buses:
> > 2x 10Gbps SFP+
> > 4x 1Gbps RJ45
> > 1x miniPCI-E
> > 1x m.2 b-key with sata, usb-2.0 and usb-3.0
> > 1x m.2 m-key with pcie and usb-2.0
> > 1x m.2 b-key with pcie, usb-2.0, usb-3.0 and 2x sim slots
> > 1x mpcie with pcie only
> > 2x type-a usb-2.0/3.0
> >
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > ---
> >  arch/arm64/boot/dts/marvell/Makefile               |   1 +
> >  arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 653 +++++++++++++++++++++
> >  2 files changed, 654 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> > index 019f2251d696..16f9d7156d9f 100644
> > --- a/arch/arm64/boot/dts/marvell/Makefile
> > +++ b/arch/arm64/boot/dts/marvell/Makefile
> > @@ -30,3 +30,4 @@ dtb-$(CONFIG_ARCH_MVEBU) += ac5x-rd-carrier-cn9131.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-base.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-pro.dtb
> > +dtb-$(CONFIG_ARCH_MVEBU) += cn9131-cf-solidwan.dtb
> > diff --git a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
> cut
> > +	leds {
> > +		compatible = "gpio-leds";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&cp0_led_pins &cp1_led_pins>;
> > +
> > +		/* for sfp-1 (J42) */
> > +		led-sfp1-activity {
> > +			label = "sfp1";
> > +			gpios = <&cp0_gpio1 7 GPIO_ACTIVE_HIGH>;
> > +			color = <LED_COLOR_ID_GREEN>;
> > +		};
> > +
> > +		/* for sfp-1 (J42) */
> > +		led-sfp1-link {
> > +			label = "sfp1";
> > +			gpios = <&cp0_gpio1 4 GPIO_ACTIVE_HIGH>;
> > +			color = <LED_COLOR_ID_YELLOW>;
> > +		};
> > +
> > +		/* (J28) */
> > +		led-sfp0-activity {
> > +			label = "sfp0";
> > +			gpios = <&cp1_gpio2 22 GPIO_ACTIVE_HIGH>;
> > +			color = <LED_COLOR_ID_GREEN>;
> > +		};
> > +
> > +		/* (J28) */
> > +		led-sfp0-link {
> > +			label = "sfp0";
> > +			gpios = <&cp1_gpio2 23 GPIO_ACTIVE_HIGH>;
> > +			color = <LED_COLOR_ID_YELLOW>;
> > +		};
> > +	};
> > +
> Here I am uncertain what to put in the label.
> Each SFP has a single dual-color (3 terminals) LED,
> with one gpio controlling each colour.
> 
> Colours are similar to RJ45 connectors (yellow, green),
> and are intended for the same purpose: link, activity.

For the switch LEDs you used label = "LED10"; Does the silk screen
have similar numbers for these LEDs?

     Andrew





Return-Path: <linux-kernel+bounces-167702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440498BADAE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750D61C21900
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2BB153808;
	Fri,  3 May 2024 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAAMtZka"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAB214A0AB;
	Fri,  3 May 2024 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742679; cv=none; b=k091JboE2Vb3n8XBVgmblCSeOngc7ZodygozSmFpe7zqiI4pzbK1Zieg0QYnN9fQCQNErqAGkmbKNeKrGXCtmXTqLp3umeTMIQQbxgi0LT4/cEJdSxD8SQjbo4g0jPe2qaKHK1AluiEoghY3p9aov7yzj6OoIvF9Bcet11OQMtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742679; c=relaxed/simple;
	bh=vBejc4y26BCn3jsVAONmf4WH+VOYO6P0hxMPw087VT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYx2TDEtQY8sUMvqFdEopnalYPdKcn108xnVJAIH5liLUGwJAaygdmrpiBc/IL1kxJuJQscwzFFZ24hBtCSQG6sabKMfcrHPNajCkJE2jF87vEQRBS8WeAJEgPLzy6k7XfBfDyi+/aBiUUQ84DdjXvlVq5iLM2CcdrE7kLFELi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAAMtZka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1172FC116B1;
	Fri,  3 May 2024 13:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714742679;
	bh=vBejc4y26BCn3jsVAONmf4WH+VOYO6P0hxMPw087VT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAAMtZkaKaPmLIMMrzKy1xRAU9cA+SRW0uBiMhQw8xje/Yr3ZK0z7KC0jht54W2JL
	 XZC8RfTVVrk3/1JMgs3RPDVIwmFEo5YTKI0iBMIng6dAPFXO7Icv3gjqDV19ewqjPa
	 PVaF5CcsBVvmhf7pxREDdCvFGAMWTTaGc0/PBXx4EP3k3ksP53vOt0ejW5+ZXBjKIF
	 wxkBbAHveeNqepoBEzwvbHRkX9GSrnZaufLn0d0e18xsNnWhVjKvdXYKAfn50xqbZD
	 FdkPm770QijZ6/pRNvnar5RYKZ1/LEzhsRUlm3xoIfBdWufXjyY+iybWdgwHuVjAeQ
	 Y0Rkk35uiMRiA==
Date: Fri, 3 May 2024 08:24:38 -0500
From: Rob Herring <robh@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Message-ID: <20240503132438.GA460984-robh@kernel.org>
References: <20240502-cn9130-som-v4-0-0a2e2f1c70d8@solid-run.com>
 <20240502-cn9130-som-v4-4-0a2e2f1c70d8@solid-run.com>
 <d72c7637-e59f-4104-93e9-6faab2da0836@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d72c7637-e59f-4104-93e9-6faab2da0836@solid-run.com>

On Thu, May 02, 2024 at 05:35:44PM +0000, Josua Mayer wrote:
> Am 02.05.24 um 14:32 schrieb Josua Mayer:
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
> >  arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 643 +++++++++++++++++++++
> >  2 files changed, 644 insertions(+)
> >
> cut
> > +	/* Type-A port on J53 */
> > +	reg_usb_a_vbus0: regulator-usb-a-vbus0 {
> > +		compatible = "regulator-fixed";
> > +		pinctrl-0 = <&cp0_reg_usb_a_vbus0_pins>;
> > +		pinctrl-names = "default";
> > +		regulator-name = "vbus0";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		regulator-oc-protection-microamp = <1000000>;
> 
> Is it correct to specify over-current protection for a 
> regulator-fixed? It causes kernel messages:
> 
> [ 7.988337] vbus0: IC does not support requested over-current limits 
> [ 7.994756] vbus0: IC does not support requested over voltage limits 
> [ 7.998796] vbus1: IC does not support requested over-current limits
> ...

Seems like you have your answer...

>
> The reason I put the property was that the 1A limit is a property of 
> the regulator component (NCP380-1.0A). Maybe that is the wrong property?
> 
> It also generates an interrupt for which I found no suitable description.

Then you should describe the actual device because it is not just a 
regulator-fixed. I suppose we could consider adding an interrupt to 
regulator-fixed, but then its function can only be for (presumably) 
over-current. Even details on how to handle it could vary as well.

Rob



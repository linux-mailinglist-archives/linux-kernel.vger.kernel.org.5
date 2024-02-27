Return-Path: <linux-kernel+bounces-83713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CEB869D94
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FFA1F21CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A90614A08F;
	Tue, 27 Feb 2024 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XJOxg1si"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DD81487EB;
	Tue, 27 Feb 2024 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054637; cv=none; b=N2m/UOBKMGiswoYqPAmSMNRC60vZX4uTax9um6eGUpLt5O7ndtEtiy9BRW1kaFwJQ0sv/VjrjjxxeeaXz1CmD93k7Fq1NiDxRrV4/578qgZpHWk6RkW/6PRCRMoKv3BHmUdG+NsXRv/XnGDkm/L1h4McSsbiXG8+o0wCygIUF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054637; c=relaxed/simple;
	bh=JKaLeWJMv2PiLodxVF66I8/DgXnvXTCAEkmR/iAlsMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+kR6AS/Wkud+VRHLtaP7eoxvRSPvz6riBQ/AlZxZZig6k9PAulG9tbGrxS0YN6zMOonOl/B6V/p2xrHG1t3TH70yRKRLGeNA/FZC+Al5Xs0bDgtmO3Rj/fC6HtdFWikwO4vRQo8/ITT3BW950GRHd7JRfKtBywpHafL9Tjcrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XJOxg1si; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B123D60003;
	Tue, 27 Feb 2024 17:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709054631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sl3yY0W8c5HJd45w2Vd535hfLRJOaX7Ck1Cj7Bauwxc=;
	b=XJOxg1siDRaJgIfy64860PCWq4wFV5cuCinGiDdOwRKiX6ANk4dFMOr6WfOJNhFT5AGfE9
	VMTvHBOM6oJR+7rYkkhDC6WHj3ZtnfRiN6kJqubVDYic5KDv2689jr8KNswAaPYxbxcRdd
	asKmhwLumJQj2RdBlxr5Qpo9RcIec+VDhW4WKUbLm0Y81D3FYRO9+jtyH6ugJI1hoo71Ag
	5zK2I1mZ7fcsPo2eka09VbAOmflI8GtvuX9hR+5MhmbaNS5NnDd2g+LkJq58p33//0SSrW
	3INvr9x8HcV6KbqqEMfe/JkiZo7d4Jd7FpFiCxvjC09wD5ezQiDNaQzySvVrPw==
Date: Tue, 27 Feb 2024 18:23:46 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Adam Ford <aford173@gmail.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, Marek
 Vasut <marex@denx.de>, Kishon Vijay Abraham I <kishon@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Will Deacon
 <will@kernel.org>, Rob Herring <robh@kernel.org>, imx@lists.linux.dev,
 Sascha Hauer <s.hauer@pengutronix.de>, aford@beaconembedded.com,
 linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 devicetree@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH V6 5/6] arm64: dts: imx8mp: add HDMI display pipeline
Message-ID: <20240227182346.6e67cc88@booty>
In-Reply-To: <CAHCN7xKnEvrfYMZau95e7aknTkdqrQLfgWZTfb6mS3Yt5BT6+Q@mail.gmail.com>
References: <20240226234532.80114-1-aford173@gmail.com>
	<20240226234532.80114-6-aford173@gmail.com>
	<20240227083301.4saxxuv4n6aoqnl6@pengutronix.de>
	<CAHCN7xKnEvrfYMZau95e7aknTkdqrQLfgWZTfb6mS3Yt5BT6+Q@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com

On Tue, 27 Feb 2024 07:51:58 -0600
Adam Ford <aford173@gmail.com> wrote:

> On Tue, Feb 27, 2024 at 2:33=E2=80=AFAM Marco Felsch <m.felsch@pengutroni=
x.de> wrote:
> >
> > Hi Adam,
> >
> > thanks a lot for pushing this topic.
> >
> > On 24-02-26, Adam Ford wrote: =20
> > > From: Lucas Stach <l.stach@pengutronix.de>
> > >
> > > This adds the DT nodes for all the peripherals that make up the
> > > HDMI display pipeline.
> > >
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > Tested-by: Marek Vasut <marex@denx.de>
> > > Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > > ---
> > > V6:  Make LCDIF3 disabled by default
> > >
> > > V5:  No change
> > >
> > > V3:  Re-ordered the HDMI parts to properly come after irqstree_hdmi
> > >      inside AIPS4.  Change size of LCDIF3 and PVI to match TRM sizes
> > >      of 4KB.
> > >
> > > V2:  I took this from Lucas' original submission with the following:
> > >      Removed extra clock from HDMI-TX since it is now part of the
> > >      power domain
> > >      Added interrupt-parent to PVI
> > >      Changed the name of the HDMI tranmitter to fsl,imx8mp-hdmi-tx
> > >      Added ports to HDMI-tx
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 95 +++++++++++++++++++++=
++
> > >  1 file changed, 95 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/b=
oot/dts/freescale/imx8mp.dtsi
> > > index 18bfa7d9aa7f..637b0265b0f1 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > @@ -1940,6 +1940,101 @@ irqsteer_hdmi: interrupt-controller@32fc2000 {
> > >                               clock-names =3D "ipg";
> > >                               power-domains =3D <&hdmi_blk_ctrl IMX8M=
P_HDMIBLK_PD_IRQSTEER>;
> > >                       };
> > > +
> > > +                     hdmi_pvi: display-bridge@32fc4000 {
> > > +                             compatible =3D "fsl,imx8mp-hdmi-pvi";
> > > +                             reg =3D <0x32fc4000 0x1000>;
> > > +                             interrupt-parent =3D <&irqsteer_hdmi>;
> > > +                             interrupts =3D <12>;
> > > +                             power-domains =3D <&hdmi_blk_ctrl IMX8M=
P_HDMIBLK_PD_PVI>; =20
> >
> > this node should be 'status =3D "disabled";' as reported by Luca else t=
his
> > node will EPROBE_DEFER. With that beeing fixed you can add my: =20
>=20
> sorry I missed that one...and I though I was done...sigh.  I hope it's
> not too late to get this into the next release.
> >
> > Tested-by: Marco Felsch <m.felsch@pengutronix.de>
> > =20
>=20
> I'll push a V7 tonight and add your tested-by.  Thanks for testing.

And with that fixed you can add to v7:

 Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


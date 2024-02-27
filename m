Return-Path: <linux-kernel+bounces-83351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECAE869454
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240CC283DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6C913B7BE;
	Tue, 27 Feb 2024 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax/xOD6h"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C3513B2AC;
	Tue, 27 Feb 2024 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041933; cv=none; b=eQQ3ldhGPFiOs+NvJp6jXMBcZwGQvHcr0k3+yG6QziTDzsxlv3Wk7Lpyz8e7IU8uEThMyNIUNW6js1egdm3Ui+F4GtXnTZyXFEP0ZhpBHG2NgfP6g9hOwVeJR/0P/Qjg/7GC9jSGf6WeeEClUmlUGgh6bJYMPgN25m5qjfO/22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041933; c=relaxed/simple;
	bh=8uZ65RdBRrZVQLt3Jfa2DywrGVNgAqJJKx5brrMyuuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjPZTeJPKZ6qV2fMc2YGHbeBCuKiJOAJCSnLuLZyYf3MB/dA5iZK23gHvjFb2N+I01gWaY7xSqioRpvYnaxGL5It7/cjFRMSCsEWpVzB3ja3Lc/G8HjUdmdBj0NUfJtDnr71w+Uq1WLUUUnoxBbL3GXj6HN7AdZoTDaSHYnp6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ax/xOD6h; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d94b222a3aso43638455ad.2;
        Tue, 27 Feb 2024 05:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709041930; x=1709646730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIVyIgwTLXzwUXutxuVhEBa2JRV+KMFUyJvpPIJLlDo=;
        b=Ax/xOD6hfp5BvPZEncM4bAA+C8kLdLLhMi6Ftn8Zy/yqvD/PZzmGejkhX7ujauoYpO
         eE9uKXyL/S0107EAGoI7U12WboTNa620sngup1Nuy2qhS6bzwMsGO9LiF99L3LvfDThO
         rH9LHuiycrFwleltq4b4Up5QmgNbhEWpznnm7Sd9F3WXQ4Q1hUlfXPu24EN7JkUFf8R0
         qOcwVSvVehcb34elndnltWHgBVWtYXM7JmJFBs/7gQqIgqmKg4FW+aLeR9FWIJA6WYYs
         vPkpMOlMiujKdmGGrEItX6XXDX/Re8qhGPWXkT9QhdqMM5gxmLt+l7+YCLPY7UlJpK9d
         dyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709041930; x=1709646730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIVyIgwTLXzwUXutxuVhEBa2JRV+KMFUyJvpPIJLlDo=;
        b=QrFEZ/zPHK78pb18Q+LDueRg4wVrt7IwWHS3T/Tkjcry1mkCLzgeEOgBPopwIjY4Hf
         2FdKzvYoqJOGnjCSbhfebeBsVW0oT8tZ9KvFMGe7By+p9UckBcra8BA+3WpJN9gnMpBg
         S67tYIoFiT2Yyx6ZPUP1OVDVveS98JmNkHZ0FDqOyLVgfAx+8Mn91Mpd/ORDLaVNKiL4
         ZNlW22el4mtnOnwN00XNIZzBXwFS79dI/dUxTaQgcsJxSiiiG2RB+ZjvkPkR7uIluI/C
         tsYx4CNsnkMEQCyFfc1NXV8cQ3QwClQNA5XdeU0X2GbIkovsfpGwfGbQkKg0KaMu9+tt
         cAkg==
X-Forwarded-Encrypted: i=1; AJvYcCWh0vQlLH6i7wGLOyKfjKjZI5i7OzZlPvQK8CwQFGRyTIlk46PghQPT2+Gw2XsuIA55PFuYiyebhECRA37Ns112yZWvtpgAyvV5PF+2r8Mj86aH8h8BhUZJvPigcbKx3yEgxN1AMuPlEA==
X-Gm-Message-State: AOJu0Yy9OyRgIRFIkwkCHJQAa9ZHcryOUmuPu3yHpdEaGxHgFbw4ruc/
	2frV2V2C8xqjMb6xUTOipm6C0k6wD/TtiRw8X5yQRFcEJOa8yXSsPyhxU3SOELVUOBzTUUja6+l
	tBlB6pbdksLpp4g6X6r2I/q4RMQE=
X-Google-Smtp-Source: AGHT+IGDbPuViPnz5x8Or5gGEDuBn9xS6cKSAFV4NoAIctp6lQe6NM7m54HwbtmTcMeIm3lqzbT8HflIHThgZMUE2gs=
X-Received: by 2002:a17:902:db0e:b0:1dc:b77e:1973 with SMTP id
 m14-20020a170902db0e00b001dcb77e1973mr2408566plx.53.1709041930195; Tue, 27
 Feb 2024 05:52:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226234532.80114-1-aford173@gmail.com> <20240226234532.80114-6-aford173@gmail.com>
 <20240227083301.4saxxuv4n6aoqnl6@pengutronix.de>
In-Reply-To: <20240227083301.4saxxuv4n6aoqnl6@pengutronix.de>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 27 Feb 2024 07:51:58 -0600
Message-ID: <CAHCN7xKnEvrfYMZau95e7aknTkdqrQLfgWZTfb6mS3Yt5BT6+Q@mail.gmail.com>
Subject: Re: [PATCH V6 5/6] arm64: dts: imx8mp: add HDMI display pipeline
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
	Marek Vasut <marex@denx.de>, Kishon Vijay Abraham I <kishon@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>, imx@lists.linux.dev, 
	Sascha Hauer <s.hauer@pengutronix.de>, aford@beaconembedded.com, 
	linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Shawn Guo <shawnguo@kernel.org>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, devicetree@vger.kernel.org, 
	Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 2:33=E2=80=AFAM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>
> Hi Adam,
>
> thanks a lot for pushing this topic.
>
> On 24-02-26, Adam Ford wrote:
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > This adds the DT nodes for all the peripherals that make up the
> > HDMI display pipeline.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Tested-by: Marek Vasut <marex@denx.de>
> > Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > ---
> > V6:  Make LCDIF3 disabled by default
> >
> > V5:  No change
> >
> > V3:  Re-ordered the HDMI parts to properly come after irqstree_hdmi
> >      inside AIPS4.  Change size of LCDIF3 and PVI to match TRM sizes
> >      of 4KB.
> >
> > V2:  I took this from Lucas' original submission with the following:
> >      Removed extra clock from HDMI-TX since it is now part of the
> >      power domain
> >      Added interrupt-parent to PVI
> >      Changed the name of the HDMI tranmitter to fsl,imx8mp-hdmi-tx
> >      Added ports to HDMI-tx
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 95 +++++++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mp.dtsi
> > index 18bfa7d9aa7f..637b0265b0f1 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -1940,6 +1940,101 @@ irqsteer_hdmi: interrupt-controller@32fc2000 {
> >                               clock-names =3D "ipg";
> >                               power-domains =3D <&hdmi_blk_ctrl IMX8MP_=
HDMIBLK_PD_IRQSTEER>;
> >                       };
> > +
> > +                     hdmi_pvi: display-bridge@32fc4000 {
> > +                             compatible =3D "fsl,imx8mp-hdmi-pvi";
> > +                             reg =3D <0x32fc4000 0x1000>;
> > +                             interrupt-parent =3D <&irqsteer_hdmi>;
> > +                             interrupts =3D <12>;
> > +                             power-domains =3D <&hdmi_blk_ctrl IMX8MP_=
HDMIBLK_PD_PVI>;
>
> this node should be 'status =3D "disabled";' as reported by Luca else thi=
s
> node will EPROBE_DEFER. With that beeing fixed you can add my:

sorry I missed that one...and I though I was done...sigh.  I hope it's
not too late to get this into the next release.
>
> Tested-by: Marco Felsch <m.felsch@pengutronix.de>
>

I'll push a V7 tonight and add your tested-by.  Thanks for testing.

adam

> Regards,
>   Marco
>
> > +
> > +                             ports {
> > +                                     #address-cells =3D <1>;
> > +                                     #size-cells =3D <0>;
> > +
> > +                                     port@0 {
> > +                                             reg =3D <0>;
> > +                                             pvi_from_lcdif3: endpoint=
 {
> > +                                                     remote-endpoint =
=3D <&lcdif3_to_pvi>;
> > +                                             };
> > +                                     };
> > +
> > +                                     port@1 {
> > +                                             reg =3D <1>;
> > +                                             pvi_to_hdmi_tx: endpoint =
{
> > +                                                     remote-endpoint =
=3D <&hdmi_tx_from_pvi>;
> > +                                             };
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     lcdif3: display-controller@32fc6000 {
> > +                             compatible =3D "fsl,imx8mp-lcdif";
> > +                             reg =3D <0x32fc6000 0x1000>;
> > +                             interrupt-parent =3D <&irqsteer_hdmi>;
> > +                             interrupts =3D <8>;
> > +                             clocks =3D <&hdmi_tx_phy>,
> > +                                      <&clk IMX8MP_CLK_HDMI_APB>,
> > +                                      <&clk IMX8MP_CLK_HDMI_ROOT>;
> > +                             clock-names =3D "pix", "axi", "disp_axi";
> > +                             power-domains =3D <&hdmi_blk_ctrl IMX8MP_=
HDMIBLK_PD_LCDIF>;
> > +                             status =3D "disabled";
> > +
> > +                             port {
> > +                                     lcdif3_to_pvi: endpoint {
> > +                                             remote-endpoint =3D <&pvi=
_from_lcdif3>;
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     hdmi_tx: hdmi@32fd8000 {
> > +                             compatible =3D "fsl,imx8mp-hdmi-tx";
> > +                             reg =3D <0x32fd8000 0x7eff>;
> > +                             interrupt-parent =3D <&irqsteer_hdmi>;
> > +                             interrupts =3D <0>;
> > +                             clocks =3D <&clk IMX8MP_CLK_HDMI_APB>,
> > +                                      <&clk IMX8MP_CLK_HDMI_REF_266M>,
> > +                                      <&clk IMX8MP_CLK_32K>,
> > +                                      <&hdmi_tx_phy>;
> > +                             clock-names =3D "iahb", "isfr", "cec", "p=
ix";
> > +                             assigned-clocks =3D <&clk IMX8MP_CLK_HDMI=
_REF_266M>;
> > +                             assigned-clock-parents =3D <&clk IMX8MP_S=
YS_PLL1_266M>;
> > +                             power-domains =3D <&hdmi_blk_ctrl IMX8MP_=
HDMIBLK_PD_HDMI_TX>;
> > +                             reg-io-width =3D <1>;
> > +                             status =3D "disabled";
> > +
> > +                             ports {
> > +                                     #address-cells =3D <1>;
> > +                                     #size-cells =3D <0>;
> > +
> > +                                     port@0 {
> > +                                             reg =3D <0>;
> > +
> > +                                             hdmi_tx_from_pvi: endpoin=
t {
> > +                                                     remote-endpoint =
=3D <&pvi_to_hdmi_tx>;
> > +                                             };
> > +                                     };
> > +
> > +                                     port@1 {
> > +                                             reg =3D <1>;
> > +                                             /* Point endpoint to the =
HDMI connector */
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     hdmi_tx_phy: phy@32fdff00 {
> > +                             compatible =3D "fsl,imx8mp-hdmi-phy";
> > +                             reg =3D <0x32fdff00 0x100>;
> > +                             clocks =3D <&clk IMX8MP_CLK_HDMI_APB>,
> > +                                      <&clk IMX8MP_CLK_HDMI_24M>;
> > +                             clock-names =3D "apb", "ref";
> > +                             assigned-clocks =3D <&clk IMX8MP_CLK_HDMI=
_24M>;
> > +                             assigned-clock-parents =3D <&clk IMX8MP_C=
LK_24M>;
> > +                             power-domains =3D <&hdmi_blk_ctrl IMX8MP_=
HDMIBLK_PD_HDMI_TX_PHY>;
> > +                             #clock-cells =3D <0>;
> > +                             #phy-cells =3D <0>;
> > +                             status =3D "disabled";
> > +                     };
> >               };
> >
> >               pcie: pcie@33800000 {
> > --
> > 2.43.0
> >
> >
> >


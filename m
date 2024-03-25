Return-Path: <linux-kernel+bounces-117349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA03C88AA4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9F01C37758
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42500136E16;
	Mon, 25 Mar 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+KKMy3/"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB531859;
	Mon, 25 Mar 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379855; cv=none; b=XE4XRTAXuPh0hgzoy3ZxV8AnWj6lsR0BvxQUifVvOHecs0L4iAp3Pq8PoPRoruZ3mKY3J8DgMydCdK0q0ghXDtPZnCbu3BMmLRrkoS3of43x3LcTp3jpmJt12mZB/IXXiZT409NpT67OVwJNrcZh+UK9K59T9yhOq5EAc5Eo5p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379855; c=relaxed/simple;
	bh=Z7DQsxcyH0W/gablP524XEmzxtYZC4lsJ+F1su9YiB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQ4Ca1bWDiAOfppRuzc9fk2vYTMDI5k30u7OhXa4NhGCraQg7ZqDR+iI1r6tnwIlnltKLmPHOBLi91eJQWYWVXonHIIx+eWkd2OOCOJaUj0I40+NCaJsTsfnlURtPPkcPRzM+goZe2XBoOX1aVdsS+tPAfMUpzt9hrjKcoqDdC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+KKMy3/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5e152c757a5so2158952a12.2;
        Mon, 25 Mar 2024 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711379853; x=1711984653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSgt+4nKYBY1Ayj+RwqYwKb2lK1TqC+P0oz8UdkaXh8=;
        b=K+KKMy3/Hf0GcipH7L0SJXrI5GvfsSHJGashslXzVd7wlJkM5saoKs8tX2h6uezdEo
         9tuCYCAgYGKG8yEaBOGjwexKjBnsbhCUMfu4Hp+e5ApI7r4YKmRfPFvJ+buMeOzniyzG
         qk5pArDVzZNWSAaeRv7OgVYko6bPEUyoU3nzZJGuthmYry/sgrcji4Q7JPIVn4DJvhga
         QWh6fkvA9p6J85CQz1V3C2noagvsJEsTaaeF+Vc14D4VHqNhE4SXdU3esmAsegOyooQ4
         oysiLE3F/J2OrIVjyv6r3wg0TO+8acKSlwZ3dC7r22QwB3c1CH38yBH7eQwl22uzcBUJ
         hBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711379853; x=1711984653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSgt+4nKYBY1Ayj+RwqYwKb2lK1TqC+P0oz8UdkaXh8=;
        b=LsdNVubiOE4mpevZot1/H0HFC0ROrMqeqJcVwW2sUPMVmv01+YdBY1by7ejU6XxT1L
         tgAFMM7spqZAbsajbDBdY5/JNwyPdHgOVxbC/XQWFsGaWpMb12qLYGOilfEbbL5xfFg8
         4+KoEkgbOMWfES3oa03uA9t4MLWaj5+WkyBDaerVRCiF+IJSSl4FaSZLhYfowHIINSlQ
         cRmtZo3cfG98rR1cFuoRcZSO/FyjYFhAa3d6MNOuvDnE2uC3Ez4I8iTJP8bsGfdFT+vi
         y/8DkvYXwgKsRGlaBh5Lh9dnWtIy2OQH+60CRvbWD01mS0vV1yZyTXmMBOITzG7NV6RE
         U+qA==
X-Forwarded-Encrypted: i=1; AJvYcCVyJU9IkOfCoLPsinJCjMX5emdvaysgccsSJKBUtn7hB6Mc85CpFPbzsQZbPkxZ0VeKG51VD61kWed7meO11eV1lmczIxOeljIzePSdxJwLSwW3FRb3YEKAfGYK56v9oiAUZB927cxhQ4solrdnzO3vo5GQA5xIreoZoCTLsucoyVHwiM/a
X-Gm-Message-State: AOJu0YzsznmfLcUe4sgAZ7YR3hzwx0Y8nu5kgcC7xCncIJjTOrXhG1Vj
	AyF2UtkfmIfDTwa9DMq8QWsVSLVeEF8U3EdEffpdvvEzIpDWborsPPhtz+eUVysUa7hWLc07c1e
	PaE/aK03/sumpBRl5Dfb+WNX5M7oaSkl3
X-Google-Smtp-Source: AGHT+IFibWjpLcbD3KGE3boiZEm48+fiPpxlk7JSFE3ccrJTt3DxR35bwg0Ilj91QuSxHUKgvkzaRdxDyPpaf3QFpTU=
X-Received: by 2002:a17:90a:ba88:b0:29f:ba42:68a6 with SMTP id
 t8-20020a17090aba8800b0029fba4268a6mr4773369pjr.41.1711379853047; Mon, 25 Mar
 2024 08:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129093113.255161-1-paul.elder@ideasonboard.com>
 <20231129093113.255161-2-paul.elder@ideasonboard.com> <CAHCN7xLOu5qfxNihEYuSXxuxxH=S_+7nDkX1H=ziDW3QvaErQA@mail.gmail.com>
 <20240325151402.GW18799@pendragon.ideasonboard.com>
In-Reply-To: <20240325151402.GW18799@pendragon.ideasonboard.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 25 Mar 2024 10:17:21 -0500
Message-ID: <CAHCN7xKczvZzQYGKeEC4Z7-2wWDa2FijugW1_HcayVOLg7D38A@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp: Add DT nodes for the two ISPs
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Paul Elder <paul.elder@ideasonboard.com>, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, kieran.bingham@ideasonboard.com, 
	tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Marek Vasut <marex@denx.de>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:14=E2=80=AFAM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Adam,
>
> On Wed, Mar 20, 2024 at 07:35:46AM -0500, Adam Ford wrote:
> > On Wed, Nov 29, 2023 at 3:31=E2=80=AFAM Paul Elder wrote:
> > >
> > > The ISP supports both CSI and parallel interfaces, where port 0
> > > corresponds to the former and port 1 corresponds to the latter. Since
> > > the i.MX8MP's ISPs are connected by the parallel interface to the CSI
> > > receiver, set them both to port 1.
> > >
> > > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> >
> > Paul, are you able to resend this now that the driver part has been
> > merged into the main branch?
> >
> > If you can't, I can resend it on your behalf.
>
> I've just sent a v2, you're on CC.

Thanks!

adam
>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 50 +++++++++++++++++++++=
++
> > >  1 file changed, 50 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/b=
oot/dts/freescale/imx8mp.dtsi
> > > index c9a610ba4836..25579d4c58f2 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > @@ -1604,6 +1604,56 @@ isi_in_1: endpoint {
> > >                                 };
> > >                         };
> > >
> > > +                       isp_0: isp@32e10000 {
> > > +                               compatible =3D "fsl,imx8mp-isp";
> > > +                               reg =3D <0x32e10000 0x10000>;
> > > +                               interrupts =3D <GIC_SPI 74 IRQ_TYPE_L=
EVEL_HIGH>;
> > > +                               clocks =3D <&clk IMX8MP_CLK_MEDIA_ISP=
_ROOT>,
> > > +                                        <&clk IMX8MP_CLK_MEDIA_AXI_R=
OOT>,
> > > +                                        <&clk IMX8MP_CLK_MEDIA_APB_R=
OOT>;
> > > +                               clock-names =3D "isp", "aclk", "hclk"=
;
> > > +                               assigned-clocks =3D <&clk IMX8MP_CLK_=
MEDIA_ISP>;
> > > +                               assigned-clock-parents =3D <&clk IMX8=
MP_SYS_PLL2_500M>;
> > > +                               assigned-clock-rates =3D <500000000>;
> > > +                               power-domains =3D <&media_blk_ctrl IM=
X8MP_MEDIABLK_PD_ISP>;
> > > +                               fsl,blk-ctrl =3D <&media_blk_ctrl 0>;
> > > +                               status =3D "disabled";
> > > +
> > > +                               ports {
> > > +                                       #address-cells =3D <1>;
> > > +                                       #size-cells =3D <0>;
> > > +
> > > +                                       port@1 {
> > > +                                               reg =3D <1>;
> > > +                                       };
> > > +                               };
> > > +                       };
> > > +
> > > +                       isp_1: isp@32e20000 {
> > > +                               compatible =3D "fsl,imx8mp-isp";
> > > +                               reg =3D <0x32e20000 0x10000>;
> > > +                               interrupts =3D <GIC_SPI 75 IRQ_TYPE_L=
EVEL_HIGH>;
> > > +                               clocks =3D <&clk IMX8MP_CLK_MEDIA_ISP=
_ROOT>,
> > > +                                        <&clk IMX8MP_CLK_MEDIA_AXI_R=
OOT>,
> > > +                                        <&clk IMX8MP_CLK_MEDIA_APB_R=
OOT>;
> > > +                               clock-names =3D "isp", "aclk", "hclk"=
;
> > > +                               assigned-clocks =3D <&clk IMX8MP_CLK_=
MEDIA_ISP>;
> > > +                               assigned-clock-parents =3D <&clk IMX8=
MP_SYS_PLL2_500M>;
> > > +                               assigned-clock-rates =3D <500000000>;
> > > +                               power-domains =3D <&media_blk_ctrl IM=
X8MP_MEDIABLK_PD_ISP>;
> > > +                               fsl,blk-ctrl =3D <&media_blk_ctrl 1>;
> > > +                               status =3D "disabled";
> > > +
> > > +                               ports {
> > > +                                       #address-cells =3D <1>;
> > > +                                       #size-cells =3D <0>;
> > > +
> > > +                                       port@1 {
> > > +                                               reg =3D <1>;
> > > +                                       };
> > > +                               };
> > > +                       };
> > > +
> > >                         dewarp: dwe@32e30000 {
> > >                                 compatible =3D "nxp,imx8mp-dw100";
> > >                                 reg =3D <0x32e30000 0x10000>;
>
> --
> Regards,
>
> Laurent Pinchart


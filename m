Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3D7E6593
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjKIIuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKIIuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:50:11 -0500
Received: from mx2-at.ubimet.com (mx2-at.ubimet.com [141.98.226.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4E01FFB;
        Thu,  9 Nov 2023 00:50:09 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mx2-at.ubimet.com (Postfix) with ESMTP id 4AD1F81216;
        Thu,  9 Nov 2023 08:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ubimet.com;
        s=20200131mdel; t=1699519807;
        bh=J0/vL/p9yQkjEpM+8f9htE5cT3g34rqFDusxOvHBm9Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QY2yQPPBQkl/JfpaV0Ad2EH0CI4mRW9PM4FORj1FmKDK0X17Jz26IaTVKUKl6tAIA
         Yv6qNOnlJAswXw7km70icDhypqA4PHGg0eRX9HdlvFzcnLxvLw1S2ApBIOuZfdjvhR
         MHRCUrQwoRwCT3NKkOzQsDDy24tumP5DJVWXkYxzt3a+H6vqBFgO2VFqi9iarZX0wJ
         iIyASnaZXiwEvbm09sTutABrUcDHTqfL+MiBb1HL3askPeyHMMA9FSONGLjWbs1ofY
         yvKt7dvk7pc0RStasa+8yZjjb+RRABqJ5KDLCTh+tCe6jr4ptc+TPzz1g/3l4EKJyl
         jzGWdfa0D1cMw==
Received: from mx2-at.ubimet.com ([127.0.0.1])
        by localhost (mx02.dmz.dc.at.ubimet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pFy8DpHO8JVP; Thu,  9 Nov 2023 08:50:07 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com (zimbra-mta01.ext.dc.at.ubimet.com [10.1.18.22])
        by mx2-at.ubimet.com (Postfix) with ESMTPS id 37EC381213;
        Thu,  9 Nov 2023 08:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id 1F25580762;
        Thu,  9 Nov 2023 08:50:07 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 9De7x--wzeqJ; Thu,  9 Nov 2023 08:50:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id 0F393806B0;
        Thu,  9 Nov 2023 08:50:06 +0000 (UTC)
X-Virus-Scanned: amavis at zimbra-mta01.ext.dc.at.ubimet.com
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 7TVYlce6KwT9; Thu,  9 Nov 2023 08:50:05 +0000 (UTC)
Received: from pcn112 (pcn112.it.hub.at.ubimet.com [10.15.66.143])
        by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTPSA id 8DCDB806EE;
        Thu,  9 Nov 2023 08:50:05 +0000 (UTC)
Date:   Thu, 9 Nov 2023 09:49:30 +0100
From:   jrodrigues <jrodrigues@ubimet.com>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ARM: dts: imx: tqma7: add lm75a sensor (rev. 01xxx)
Message-ID: <20231109094930.635cf59a@pcn112>
In-Reply-To: <CAH+2xPBdpYiNRzPP+0Diqrc+GfdJYbiTDheD6n2fb42w65LNFg@mail.gmail.com>
References: <20231102231130.13ca0513@pcn112>
        <CAOMZO5C8wq=72HUqSb9bdQK2ji2zcEKByByovnKzUt6A5H3K8Q@mail.gmail.com>
        <CAH+2xPBdpYiNRzPP+0Diqrc+GfdJYbiTDheD6n2fb42w65LNFg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023 23:51:11 +0100
Bruno Thomsen <bruno.thomsen@gmail.com> wrote:

> Den fre. 3. nov. 2023 kl. 22.07 skrev Fabio Estevam
> <festevam@gmail.com>:
> >
> > [Adding Bruno and Alexander]
> >
> > On Thu, Nov 2, 2023 at 7:12=E2=80=AFPM Jo=C3=A3o Rodrigues
> > <jrodrigues@ubimet.com> wrote: =20
> > >
> > > From: Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>
> > >
> > > TQMa7x (revision 01xxx) uses a LM75A temperature sensor.
> > > The two sensors use different I2C addresses, so we can set both
> > > sensors simultaneously. =20
>=20
> Hi Jo=C3=A3o,
>=20
> Looks correct to me and an elegant way of adding support for rev 01xx
> boards.
>=20
> Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>
>=20
> After this change the imx7d-flex-concentrator.dts needs to be updated
> as it uses TQMa7d rev 02xx boards with something like this:
>=20
> /* TQMa7d 02xx */
> &se97b {
>         status =3D "okay";
> };
>=20
> I can send a follow up patch when this change lands.
>=20
> /Bruno
>=20

Hi Bruno,

Thank you for the review.
Taking the status out was a request from Krzysztof in the initial version of
the patch, since the default for status is "okay". I have also tested (and
confirmed) this works as expected, with the appropriate temperature sensor
being recognised by the kernel.

Kind regards,
Jo=C3=A3o

> > >
> > > Signed-off-by: Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>
> > > ---
> > >  arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
> > > b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi index
> > > fe42b0a4683..3fc3130f9de 100644 ---
> > > a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi +++
> > > b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi @@ -128,11 +128,16 @@
> > > vgen6_reg: vldo4 { };
> > >         };
> > >
> > > -       /* NXP SE97BTP with temperature sensor + eeprom */
> > > +       /* LM75A temperature sensor, TQMa7x 01xx */
> > > +       lm75a: temperature-sensor@48 {
> > > +               compatible =3D "national,lm75a";
> > > +               reg =3D <0x48>;
> > > +       };
> > > +
> > > +       /* NXP SE97BTP with temperature sensor + eeprom, TQMa7x
> > > 02xx */ se97b: temperature-sensor-eeprom@1e {
> > >                 compatible =3D "nxp,se97b", "jedec,jc-42.4-temp";
> > >                 reg =3D <0x1e>;
> > > -               status =3D "okay";
> > >         };
> > >
> > >         /* ST M24C64 */
> > > --
> > > 2.25.1
> > > =20


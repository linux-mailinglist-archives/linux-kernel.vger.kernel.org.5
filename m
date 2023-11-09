Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC9F7E6411
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 07:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjKIG5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 01:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjKIG5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 01:57:38 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CF32D4F;
        Wed,  8 Nov 2023 22:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1699513056; x=1731049056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PAqbVjcJpwJv+qGmjw/YAS9SG5eyJvGIFMhJR66DceA=;
  b=QpvpNKWJVaR8vnr5KVCc6AtTVSzPzhDWxitdwhdk0Zus90twur43yGRk
   DadBv1X/rWOlmieDQj4BB59VO1xu6YTjkGAqpGSytptbJwqv8zIakKMpm
   3iVhn1iESZRy1Ssps3vzI61vst7tfCGAdU9DV+5s3XrpBLm4rRHVWSeBn
   U+gwAZtBUdy5FkMNvNH/45diGyLLhn2O2y6/UGxvrGXLG74//H2mE/+i1
   IGehHTIlszvbVMwl/yuSZ8uJSZXgYLiKY+QDHGiFEGVfBYDVTcvP2UcnU
   V68UmuP+TxVgUYEwRDQwumPoDagQZA4Yw4NjwQ+zc0QL8odLT09SOA36m
   g==;
X-IronPort-AV: E=Sophos;i="6.03,288,1694728800"; 
   d="scan'208";a="33887871"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Nov 2023 07:57:33 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 8966628007F;
        Thu,  9 Nov 2023 07:57:33 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     =?ISO-8859-1?Q?Jo=E3o?= Rodrigues <jrodrigues@ubimet.com>,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ARM: dts: imx: tqma7: add lm75a sensor (rev. 01xxx)
Date:   Thu, 09 Nov 2023 07:57:36 +0100
Message-ID: <1783737.VLH7GnMWUR@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <2253436.iZASKD2KPV@steina-w>
References: <20231102231130.13ca0513@pcn112> <CAOMZO5C8wq=72HUqSb9bdQK2ji2zcEKByByovnKzUt6A5H3K8Q@mail.gmail.com> <2253436.iZASKD2KPV@steina-w>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jo=C3=A3o,

Am Dienstag, 7. November 2023, 07:34:32 CET schrieb Alexander Stein:
> Hi,
>=20
> Am Freitag, 3. November 2023, 22:07:08 CET schrieb Fabio Estevam:
> > [Adding Bruno and Alexander]
> >=20
> > On Thu, Nov 2, 2023 at 7:12=E2=80=AFPM Jo=C3=A3o Rodrigues <jrodrigues@=
ubimet.com>=20
wrote:
> > > From: Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>
> > >=20
> > > TQMa7x (revision 01xxx) uses a LM75A temperature sensor.
> > > The two sensors use different I2C addresses, so we can set both senso=
rs
> > > simultaneously.
>=20
> I've contacted responsible department and I am waiting for more details.

I got response that REV.01xx was just a prototype and not released official=
ly.

> Best regards,
> Alexander
>=20
> > > Signed-off-by: Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>
> > > ---
> > >=20
> > >  arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
> > > b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi index
> > > fe42b0a4683..3fc3130f9de 100644
> > > --- a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
> > > +++ b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
> > > @@ -128,11 +128,16 @@ vgen6_reg: vldo4 {
> > >=20
> > >                 };
> > >        =20
> > >         };
> > >=20
> > > -       /* NXP SE97BTP with temperature sensor + eeprom */
> > > +       /* LM75A temperature sensor, TQMa7x 01xx */
> > > +       lm75a: temperature-sensor@48 {
> > > +               compatible =3D "national,lm75a";
> > > +               reg =3D <0x48>;
> > > +       };

I don't like the idea of adding an i2c device for everybody. This restricts/
affects usage of i2c address 0x48 for all rev.02xx users, no?

Best regards,
Alexander

> > > +
> > > +       /* NXP SE97BTP with temperature sensor + eeprom, TQMa7x 02xx =
*/
> > >=20
> > >         se97b: temperature-sensor-eeprom@1e {
> > >        =20
> > >                 compatible =3D "nxp,se97b", "jedec,jc-42.4-temp";
> > >                 reg =3D <0x1e>;
> > >=20
> > > -               status =3D "okay";
> > >=20
> > >         };
> > >        =20
> > >         /* ST M24C64 */
> > >=20
> > > --
> > > 2.25.1


=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/



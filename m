Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE14F7E353F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjKGGek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKGGei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:34:38 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AB3110;
        Mon,  6 Nov 2023 22:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1699338874; x=1730874874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BZOUKef8XnMxZtGy2xqoSV8Tn9ptlXd8U7y8CTGYCPU=;
  b=lZ5BRp9xImDfKIW+q80GbNEyDbJ9/ursCIdjmnKND8C1IhqzqFM+XfM2
   2IN6Jmu4ti6IrNV4TiMLpz0/MEbiDxuW3ss/yBIG9ulwKKH5zx1qwkIyN
   PW0jERut2a+qzfMIZXbMhczSAXfhhhLPd6Bb6yJI8XV0+6NM2MBJstvX3
   pj1VlTAxI9m3IBHS2C4ej9nxvyW3HfqPWQCTpY8LaLMTRZBtfj+sCs6tV
   ByP6uZ8VCYvBUo8+n7frkIrXIIIRxGEIYDJjvPhLLiP577w7vFSm++abw
   8FhyeFg1kz+GTFKwoZDJU1myc+Z4OEOfCVegv4edPmlNt5H0Ow+aIUPR5
   g==;
X-IronPort-AV: E=Sophos;i="6.03,282,1694728800"; 
   d="scan'208";a="33839681"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Nov 2023 07:34:31 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 4BBA828007F;
        Tue,  7 Nov 2023 07:34:31 +0100 (CET)
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
Date:   Tue, 07 Nov 2023 07:34:32 +0100
Message-ID: <2253436.iZASKD2KPV@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAOMZO5C8wq=72HUqSb9bdQK2ji2zcEKByByovnKzUt6A5H3K8Q@mail.gmail.com>
References: <20231102231130.13ca0513@pcn112> <CAOMZO5C8wq=72HUqSb9bdQK2ji2zcEKByByovnKzUt6A5H3K8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Freitag, 3. November 2023, 22:07:08 CET schrieb Fabio Estevam:
> [Adding Bruno and Alexander]
>=20
> On Thu, Nov 2, 2023 at 7:12=E2=80=AFPM Jo=C3=A3o Rodrigues <jrodrigues@ub=
imet.com> wrote:
> > From: Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>
> >=20
> > TQMa7x (revision 01xxx) uses a LM75A temperature sensor.
> > The two sensors use different I2C addresses, so we can set both sensors
> > simultaneously.

I've contacted responsible department and I am waiting for more details.

Best regards,
Alexander

> > Signed-off-by: Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>
> > ---
> >=20
> >  arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
> > b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi index
> > fe42b0a4683..3fc3130f9de 100644
> > --- a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
> > +++ b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
> > @@ -128,11 +128,16 @@ vgen6_reg: vldo4 {
> >=20
> >                 };
> >        =20
> >         };
> >=20
> > -       /* NXP SE97BTP with temperature sensor + eeprom */
> > +       /* LM75A temperature sensor, TQMa7x 01xx */
> > +       lm75a: temperature-sensor@48 {
> > +               compatible =3D "national,lm75a";
> > +               reg =3D <0x48>;
> > +       };
> > +
> > +       /* NXP SE97BTP with temperature sensor + eeprom, TQMa7x 02xx */
> >=20
> >         se97b: temperature-sensor-eeprom@1e {
> >        =20
> >                 compatible =3D "nxp,se97b", "jedec,jc-42.4-temp";
> >                 reg =3D <0x1e>;
> >=20
> > -               status =3D "okay";
> >=20
> >         };
> >        =20
> >         /* ST M24C64 */
> >=20
> > --
> > 2.25.1


=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/



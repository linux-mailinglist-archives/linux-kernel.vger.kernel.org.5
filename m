Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BF27CC573
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343864AbjJQOCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343880AbjJQOCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:02:14 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15810102;
        Tue, 17 Oct 2023 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697551330; x=1729087330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jANLk1Fnic8hXh7J6ape/eAxnsf8qTgjV0Zfaqe390w=;
  b=OAzxZG3EzLlUe/nZ8WwyY760l7RoAC3ShpkYCxZWeFEnhgFcK1q+AoHI
   je7++6piGLHBTmomZXXw/WtkmXgmslpe5Jf/hqezPakpktSVK803j2sDx
   7y72ds6oW16yYbDbAUy1uXXHH//MQIAMddx/yppba9CBWJNUCNQzXSmAp
   ewh2Lxz7mxBgGghErsL6qpJS66e0CUE//h9WV3HJMasndR80Gqeakjx4R
   hDdfmDy3DZLEEMKQ5jhFSIe9AN2f73BX4GHauSQKckxjy5ZewK1OQ4399
   9rfiNhYWHWQUF2rnjnatE4GomZnB5oLfQjmKa3rOV3/IzojaqApl3OX0k
   A==;
X-IronPort-AV: E=Sophos;i="6.03,232,1694728800"; 
   d="scan'208";a="33509080"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 Oct 2023 16:02:08 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id BC0BB280082;
        Tue, 17 Oct 2023 16:02:07 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Jacky Bai <ping.bai@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Joy Zou <joy.zou@nxp.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] regulator: pca9450: add pca9451a support
Date:   Tue, 17 Oct 2023 16:02:09 +0200
Message-ID: <2213718.72vocr9iq0@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <AM6PR04MB59255766CED30160FB552F94E10AA@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20230531065724.3671795-1-joy.zou@nxp.com> <4630917.iIbC2pHGDl@steina-w> <AM6PR04MB59255766CED30160FB552F94E10AA@AM6PR04MB5925.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Dienstag, 1. August 2023, 12:17:20 CEST schrieb Joy Zou:
> > -----Original Message-----
> > From: Alexander Stein
> > <alexander.stein@ew.tq-group.com<mailto:alexander.stein@ew.tq-group.com=
>>
> >=20
 Sent: 2023=E5=B9=B47=E6=9C=885=E6=97=A5 21:13
> > To: Jacky Bai <ping.bai@nxp.com<mailto:ping.bai@nxp.com>>;
> > lgirdwood@gmail.com<mailto:lgirdwood@gmail.com>;
> > broonie@kernel.org<mailto:broonie@kernel.org>;
> > robh+dt@kernel.org<mailto:robh+dt@kernel.org>;
> > krzysztof.kozlowski+dt@linaro.org<mailto:krzysztof.kozlowski+dt@linaro.=
or
> > g>; conor+dt@kernel.org<mailto:conor+dt@kernel.org>;
> > shawnguo@kernel.org<mailto:shawnguo@kernel.org>;
> > s.hauer@pengutronix.de<mailto:s.hauer@pengutronix.de>;
> > linux-arm-kernel@lists.infradead.org<mailto:linux-arm-kernel@lists.infr=
ad
> > ead.org>; Joy Zou <joy.zou@nxp.com<mailto:joy.zou@nxp.com>> Cc:
> > kernel@pengutronix.de<mailto:kernel@pengutronix.de>;
> > festevam@gmail.com<mailto:festevam@gmail.com>; dl-linux-imx
> > <linux-imx@nxp.com<mailto:linux-imx@nxp.com>>;
> > devicetree@vger.kernel.org<mailto:devicetree@vger.kernel.org>;
> > linux-arm-kernel@lists.infradead.org<mailto:linux-arm-kernel@lists.infr=
ad
> > ead.org>;
> > linux-kernel@vger.kernel.org<mailto:linux-kernel@vger.kernel.org>
> > Subject: [EXT] Re: [PATCH v1 2/3] regulator: pca9450: add pca9451a
> > support>
> >
> >
> > Caution: This is an external email. Please take care when clicking links
> > or
 opening attachments. When in doubt, report the message using the
> > 'Report this email' button
> >
> >
> >
> >
> > Hello,
> >
> >
> >
> > Am Mittwoch, 5. Juli 2023, 08:50:24 CEST schrieb Joy Zou:
> >=20
> > >
> > >
> > > > -----Original Message-----
> > > > From: Alexander Stein
> > > > <alexander.stein@ew.tq-group.com<mailto:alexander.stein@ew.tq-group=
=2Ec
> > > > om>>
 Sent: 2023=E5=B9=B45=E6=9C=8831=E6=97=A5 19:35
> > > > To: Jacky Bai <ping.bai@nxp.com<mailto:ping.bai@nxp.com>>;
> > > > lgirdwood@gmail.com<mailto:lgirdwood@gmail.com>;
> > > > broonie@kernel.org<mailto:broonie@kernel.org>;
> > > > robh+dt@kernel.org<mailto:robh+dt@kernel.org>;
> > > > krzysztof.kozlowski+dt@linaro.org<mailto:krzysztof.kozlowski+dt@lin=
ar
> > > > o.org>; conor+dt@kernel.org<mailto:conor+dt@kernel.org>;
> > > > shawnguo@kernel.org<mailto:shawnguo@kernel.org>;
> > > > s.hauer@pengutronix.de<mailto:s.hauer@pengutronix.de>;
> > > > linux-arm-kernel@lists.infradead.org<mailto:linux-arm-kernel@lists.=
in
> > > > fradead.org> Cc: kernel@pengutronix.de<mailto:kernel@pengutronix.de=
>;
> > > > festevam@gmail.com<mailto:festevam@gmail.com>; dl-linux-imx
> > > > <linux-imx@nxp.com<mailto:linux-imx@nxp.com>>;
> > > > devicetree@vger.kernel.org<mailto:devicetree@vger.kernel.org>;
> > > > linux-arm-kernel@lists.infradead.org<mailto:linux-arm-kernel@lists.=
in
> > > > fradead.org>;
> > > > linux-kernel@vger.kernel.org<mailto:linux-kernel@vger.kernel.org>;
> > > > Joy Zou
> > =20
> >  <joy.zou@nxp.com<mailto:joy.zou@nxp.com>>
> > =20
> > > > Subject: Re: [PATCH v1 2/3] regulator: pca9450: add pca9451a
> > > > support
> > > >
> > > >
> > > >
> > > > Hi,
> > > >=20
> > > > > @@ -104,7 +104,15 @@ static const struct regulator_ops
> > > > > pca9450_ldo_regulator_ops =3D { * 0.60 to 2.1875V (12.5mV step)
> > > > >
> > > > >
> > > > >
> > > > >   */
> > > > >
> > > > >
> > > > >
> > > > >  static const struct linear_range pca9450_dvs_buck_volts[] =3D {
> > > > >
> > > > >
> > > > >
> > > > > -     REGULATOR_LINEAR_RANGE(600000,  0x00, 0x7F, 12500),
> > > > > +     REGULATOR_LINEAR_RANGE(600000, 0x00, 0x7F, 12500), };
> > > > > +
> > > > > +/*
> > > > > + * BUCK1/3
> > > > > + * 0.65 to 2.2375V (12.5mV step)
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > Reading this comment, it seems the same distinction needs to be done
> > > > for
> > > > BUCK3 as well, no?
> > >
> > >
> > >
> > > Sorry for the late reply!
> > > The BUCK1 and BUCK3 are dual phase, so don't need to be done for BUCK=
3.
> > >
> > >
> > >
> > > >
> > > >
> > > >
> > > > > + */
> > > > > +static const struct linear_range pca9450_trim_dvs_buck_volts[] =
=3D {
> > > > > +     REGULATOR_LINEAR_RANGE(650000, 0x00, 0x7F, 12500),
> > > > >
> > > > >
> > > > >
> > > > >  };
>=20
>=20
>=20
> > > > > @@ -708,8 +917,9 @@ static int pca9450_i2c_probe(struct i2c_client
> > > > > *i2c)
> > > > >
> > > > >
> > > > >
> > > > >       const struct pca9450_regulator_desc     *regulator_desc;
> > > > >       struct regulator_config config =3D { };
> > > > >       struct pca9450 *pca9450;
> > > > >
> > > > >
> > > > >
> > > > > -     unsigned int device_id, i;
> > > > > +     unsigned int device_id, i, val;
> > > > >
> > > > >
> > > > >
> > > > >       unsigned int reset_ctrl;
> > > > >
> > > > >
> > > > >
> > > > > +     bool pmic_trim =3D false;
> > > > >
> > > > >
> > > > >
> > > > >       int ret;
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >       if (!i2c->irq) {
> > > > >
> > > > >
> > > > >
> > > > > @@ -721,6 +931,22 @@ static int pca9450_i2c_probe(struct
> > > > > i2c_client
> > > > > *i2c)
> > > > >
> > > > >
> > > > >
> > > > >       if (!pca9450)
> > > > >
> > > > >
> > > > >
> > > > >               return -ENOMEM;
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > +     pca9450->regmap =3D devm_regmap_init_i2c(i2c,
> > > > > +
> > > >
> > > >
> > > >
> > > > &pca9450_regmap_config);
> > > >
> > > >
> > > >
> > > > > +     if (IS_ERR(pca9450->regmap)) {
> > > > > +             dev_err(&i2c->dev, "regmap initialization failed\n"=
);
> > > > > +             return PTR_ERR(pca9450->regmap);
> > > > > +     }
> > > > > +
> > > > > +     ret =3D regmap_read(pca9450->regmap, PCA9450_REG_PWRCTRL,
> > > >
> > > >
> > > >
> > > > &val);
> > > >
> > > >
> > > >
> > > > > +     if (ret) {
> > > > > +             dev_err(&i2c->dev, "Read device id error\n");
> > > > > +             return ret;
> > > > > +     }
> > > > > +
> > > > > +     if (val & PCA9450_REG_PWRCTRL_TOFF_DEB)
> > > > > +             pmic_trim =3D true;
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > PCA9450_REG_PWRCTRL is a read/write register. How is it possible to
> > > > detect a chip revision using a bit which can be changed by software
> > > > e.g.
> > > > bootloader? Despite that this bit sets debounce time for
> > > > PMIC_ON_REQ, how is this related to BUCK1 voltage range?
> > >
> > >
> > >
> > > There are old and new two kind PMIC pca9451a.
> >
> >
> >
> > There is only one part mentioned in the ordering options. How can I
> > distinguish them? Any chip ID, date codes, markings?
>=20
> Yes, there is only one part. We distinguish the new and old part by this
> bit
 Toff_Deb of PCA9450_REG_PWRCTRL reset value. The reset value 0 means
> it's old part, and the reset value 1 means it's new part.

Is the "old" part by coincidence an unofficial prerelease/sample chip?

> >
> >
> > > This bit sets debounce time in
> > > PCA9450_REG_PWRCTRL was set different value by hardware in order to
> > > only distinguish the old and new PMIC. This bit isn't related to the
> > > BUCK1 voltage range. If the pmic_trim is true that means it's new
> > > pca9451a.
>
> >
> >
> > But this bit is writable. How do you know it has not been modified since
> > reset?
> Yes, we don't consider modify the debounce bit case. Modify the Toff_deb
> value
 will influence the old and new part judgement.

This judgement seems broken to me. How can I know offline whether I have ol=
d=20
or new parts? I would like to know if there is a difference on some my boar=
ds.

> For example, this default value of Toff_deb is 1 in the new part, if the
> customers
 change the Toff_deb value from 1 to 0, and then make the board
> warm reset, the Toff_deb value still keep 0, if the Toff_deb value is 0,
> the PMIC driver will think this part is old part. But this part is new pa=
rt
> in fact.

This should show you it's a bad idea to decide the chip revision depending =
on=20
Toff_deb.

> Have discussed this issue with our internal team member, we will add a no=
te
> to PCA9451
 datasheet =E2=80=93 =E2=80=9CPlease contract NXP If you want to change
> Toff_deb.=E2=80=9D But till now, we am not aware any customers case which=
 need to
> adjust Toff_deb.
>=20
> Make it more clear: If customers do need to manually adjust Toff_deb, It
> need PMIC driver
 update to bypass this bit check and directly apply
> corresponding voltage config table old or new. Thank you very much for yo=
ur
> comments and efforts.

In this case I need to know if I use old, new or both revision of these par=
ts.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE8178B3EF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjH1PDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjH1PDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:03:17 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F4D122
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693234988;
        bh=gxOhBSoeaNwDPM5C5Oi3iz89MA7vtl3zERyZ9VYs6nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ipz/jo9UJGKXqAU99yCD4UWjPw+co/Vswxf+oEfDey8Mcm1xNGJ44s+X/2aAPRK59
         9w1onwKd2JVdI2t+LHc9VpRdvbtAXiAUulqbUqyr0x5rQX+z+ly77uKZIPkPGGjnpt
         sgmsFE4CWmAJMOr1LoymQwHY4anKGpkcDX3cbF6k=
Received: from localhost.localdomain ([122.14.229.192])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id C5A32EF; Mon, 28 Aug 2023 23:03:05 +0800
X-QQ-mid: xmsmtpt1693234985t6js198x2
Message-ID: <tencent_D90A6A9DC4DD4D576DDA5600188F47A2C206@qq.com>
X-QQ-XMAILINFO: M1Nbo1LDE6NLyFQ049PofQdex6boaCEeabcIBgRys8GZabcoJiHoX5Pu8J9vba
         KfezdSvmAasMkhrjixbP5RKA3r3McuuRl6LTsb02KqInufGy6prBPZoyFJhO34sWr8cdRWljYF1k
         zrbg/9ySC9lSExPj+QmGfqV0vxVaLC12qp6nWOmo1655LqxLGs3LD9CDX/zgcevHiptHt4yxvwvR
         M28yLZMyXh7uqsGnXNrAHw6zFT5UOgQTulzHLF6CoRzu5HMagpkqPjhnOdv+Vr92Lg3Vd48hjee6
         Qv7RkNDq41CPXw/L4HNxoCbrQtaJ91xMAvxMRgkRSd4vefogOuj11/x5Qpsxi58nHMUmx6cCeRWl
         rWAgVj7r1atJZJKra4ZEpknBrCQ90yo4rXZvhM31kXGvv4FEjmY9cGtnaS4IKhUyRsFoK7TFmXuJ
         gBKgO58WyWmiW2E78exbKB0FSdWS7EpbToX/dHHjfaxqfcWdtLQPBmPC8RFBNXvnwZj43uw5nQol
         7py4oMHCaG8hF/eiAao5cOYTDidoY/W1kQqT0NRjmCQt7Lv47zu1z04P46bYej7oYlS6ki3aRtUs
         MfjHN8x4BGEqxhbmbYd2aRZDh7yPmQlUWw6kW482c2dxmah/uUNGa3DYVSVn8+D7cNMXpV7lgpmB
         R02UscGwKcssLu0T0SQTaGdh0V/r78V3SQH3aSIxmeghbaPLmgkGcj5tQPCYYHPpT0+pZHs+Bum8
         hbCHtZbnSnBEu6f+75CJxmvpQX/0bRh3MBabCRgRwNBVnfdOG/LlxDp9nvOFkZVntSYYTIU2n4ox
         bhIXVcEn19kwyiVFvdJJaIbJ9VanR6S3LmKRuWtTelrm6VwLETFRMknZPJM1qQhSPz8V7gvQjb22
         8QcgWWLJOF0x3luoCTcRvi6z/SAfA1T3I0cw5ANcXnasFLPImw6WINmPoo9RmVq+tdxeQ11ULtmf
         rQhjSXy8zsnNcIUhjnH7rPH6vmcbOD4iNU7bqQRL4/SVkyCw5e7BS2PmR4t4IO
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: imx-weim: fix to avoid potential NULL pointer dereference
Date:   Mon, 28 Aug 2023 23:03:05 +0800
X-OQ-MSGID: <4525541.LvFx2qVVIh@localhost.localdomain>
In-Reply-To: <CAOMZO5BByJsCOCpQ9WZqMWP7qmh7x3N06wD9VhpWMjoi4hg2ag@mail.gmail.com>
References: <tencent_0ED0DF5CD5426F55806D79D028F8A10E490A@qq.com>
 <CAOMZO5BByJsCOCpQ9WZqMWP7qmh7x3N06wD9VhpWMjoi4hg2ag@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023=E5=B9=B47=E6=9C=8816=E6=97=A5=E6=98=9F=E6=9C=9F=E6=97=A5 CST=
 =E4=B8=8A=E5=8D=8812:38:09=EF=BC=8CFabio Estevam =E5=86=99=E9=81=93=EF=BC=
=9A
> Hi Zhang,
>=20
> On Sat, Jul 15, 2023 at 12:21=E2=80=AFPM Zhang Shurong
>=20
> <zhang_shurong@foxmail.com> wrote:
> > of_match_device() may fail and returns a NULL pointer.
> >=20
> > Fix this by checking the return value of of_match_device.
> >=20
> > Fixes: 3f98b6baad63 ("drivers: bus: imx-weim: Add support for
> > i.MX1/21/25/27/31/35/50/51/53") Signed-off-by: Zhang Shurong
> > <zhang_shurong@foxmail.com>
> > ---
> >=20
> >  drivers/bus/imx-weim.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> > index 52a5d0447390..65402bb60c18 100644
> > --- a/drivers/bus/imx-weim.c
> > +++ b/drivers/bus/imx-weim.c
> > @@ -202,15 +202,19 @@ static int weim_timing_setup(struct device *dev,
> > struct device_node *np,>=20
> >  static int weim_parse_dt(struct platform_device *pdev)
> >  {
> >=20
> > -       const struct of_device_id *of_id =3D of_match_device(weim_id_ta=
ble,
> > -                                                          &pdev->dev);
> > -       const struct imx_weim_devtype *devtype =3D of_id->data;
> > +       const struct of_device_id *of_id;
> > +       const struct imx_weim_devtype *devtype;
> >=20
> >         int ret =3D 0, have_child =3D 0;
> >         struct device_node *child;
> >         struct weim_priv *priv;
> >         void __iomem *base;
> >         u32 reg;
> >=20
> > +       of_id =3D of_match_device(weim_id_table, &pdev->dev);
> > +       if (!of_id)
> > +               return -EINVAL;
>=20
> If there is no match the driver will not probe in the first place.
>=20
> I don't think this check is needed.

Hello Fabio,

I think we can make it happen by designing the platform device in a way tha=
t=20
its name aligns with that of the driver. In such a scenario, when the drive=
r=20
is probed, the of_match_device function will return null. You can verify th=
is=20
functionality by reviewing the following function:

static int platform_match(struct device *dev, struct device_driver *drv)

Best regards,
Shurong




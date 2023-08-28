Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A8B78B57E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjH1QmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjH1QmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:42:03 -0400
X-Greylist: delayed 5984 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Aug 2023 09:41:57 PDT
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CE3F9;
        Mon, 28 Aug 2023 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693240916;
        bh=qMLnaoLr7Mxo2WAiGAwS0IA7JoMknwpbu2iKGRbMgtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=vH7ENNrcedrqWanNUcN4EIlugB7fjXU7rPCQ9xEZdsY9ujrhxujVqF+VcdQwN+wfZ
         Rxc96rzaZKYnqB3XiO4RabqCkMj5LEjP7r4ZAU8qpsBlphbjnw5mX1AegiBoaYJl80
         nurWtWvQxp+bY/xq3lLYw+rrjjUwh4MczaXjHCwo=
Received: from localhost.localdomain ([122.14.229.192])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 8E52FE7E; Tue, 29 Aug 2023 00:35:37 +0800
X-QQ-mid: xmsmtpt1693240537td16zclax
Message-ID: <tencent_273D6814AA50AF24126F966A3DB684C0FE09@qq.com>
X-QQ-XMAILINFO: NFvJBhJV2/hXwhjejeYoN5PG4pyPtPw2M/TIYGva9QgadJmM2h091KEZjafGq2
         T5tlxcSeJkTiSOunxxJhcoDjpnMg9AdPYI1uCf4EAv62b8q3f+Q8Apw6OL5sVTduoLMCXCtq1QkI
         20yCg2nbII6R5wB0Vm3z294iEgbhrzrE+NXmL1p6iNg4XhcPGLDvJzxmsYtMTIDSBLXN8dxuABAR
         Ik9CPFOqQGBCNbBTuTVGWQRytfxVGsEd2gPx4WZAaAEbTl/Mjnr9miqOF7RHVpJK/crS/GPbH+x5
         SKhuj274CAmES5zxNFOF+R2rELNG/SkhTvD5y8AeQrwCYNf1rpRx1eATl+hbCYtOY5KqV8Fz//Qb
         ZO20aL+fxSZ5VfFKM7JiN/zp5TLJsDZ2mZdWGJTlO4cILjbO33bL2IpYSLruBHCTXqShjpCVPj9s
         BtoIYDA4VFi59JDrMO9jNBvqaS51xRjt1v/SGpBRYAIXk7Fy5HLMNN7q/s/kj8N9y13KsfPfjlrb
         3CUlE67+wYWZjvGBmCuI/Tbe3gN7ccXx2Iwghm9SuGiF+zNCXRK0jdWjsjwJlrZDrBjN8U6QB5vw
         CoJu2rp6rhzqPSXcJ9l41Pm8fnUmf8algkDZYsXWUzy1ipX2zj2RIkdw25TUGhp0LjqpoCkIFG2g
         eFa3KXiXwxt5NsFb1p6eflRQzRRReaf67f+AEPKOVRuA+M0hQW0ZjhqCOPy0RlfpHsK1OIWv8YHO
         +OVfxZhVh+QH6B/mN8cJ0U/fr0gcT24wi2SAIFgqvbAE1qR9nb9PVNH6ju7Tg6jh2XSaND2zhUWd
         UW7Dsz2Pb4Ztkaa8fT16vJ5ZwVh+XVO5Ie8F4cQRL0WaDUJHyr8QTqi4eQo8LSfA2Ua8Vq87b20l
         9Ejmbu75rpuNjbptuNwm+n1x946soLdFhFPsOg6Z9Wv075+CLLZvNr7soxlVh0eGEeWe7HIHlpze
         R/0NOMcbhAg/X31A+Vsd747DYx5RVPjEweKoM+M2fA6/EWy+JU6M/kQO6GizLy2ewRngFyM14=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, lgirdwood@gmail.com,
        broonie@kernel.org, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] io: adc: stm32-adc: fix potential NULL pointer dereference in
 stm32_adc_probe()
Date:   Tue, 29 Aug 2023 00:35:36 +0800
X-OQ-MSGID: <3266012.aeNJFYEL58@localhost.localdomain>
In-Reply-To: <20230828171605.15c51c28@jic23-huawei>
References: <tencent_994DA85912C937E3B5405BA960B31ED90A08@qq.com>
 <tencent_CF6E986A75B63EC09E3D98143650B5241809@qq.com>
 <20230828171605.15c51c28@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023=E5=B9=B48=E6=9C=8829=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=8C CST=
 =E4=B8=8A=E5=8D=8812:16:05=EF=BC=8CJonathan Cameron =E5=86=99=E9=81=93=EF=
=BC=9A
> On Mon, 28 Aug 2023 23:02:07 +0800
>=20
> Zhang Shurong <zhang_shurong@foxmail.com> wrote:
> > =E5=9C=A8 2023=E5=B9=B47=E6=9C=8817=E6=97=A5=E6=98=9F=E6=9C=9F=E4=B8=80=
 CST =E4=B8=8A=E5=8D=8812:08:21=EF=BC=8CJonathan Cameron =E5=86=99=E9=81=93=
=EF=BC=9A
> >=20
> > > On Sat, 15 Jul 2023 23:55:50 +0800
> > >=20
> > > Zhang Shurong <zhang_shurong@foxmail.com> wrote:
> > > > of_match_device() may fail and returns a NULL pointer.
> > > >=20
> > > > Fix this by checking the return value of of_match_device().
> > > >=20
> > > > Fixes: 64ad7f6438f3 ("iio: adc: stm32: introduce compatible data cf=
g")
> > > > Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> > >=20
> > > Hi Zhang,
> > >=20
> > > I'm not sure we can actually make this bug happen. Do you have
> > > a way of triggering it?  The driver is only probed on devices where
> > > that match will work.
> > >=20
> > > Also, assuming the match table is the same one associated with this
> > > probe
> > > function, then us priv->cfg =3D of_device_get_match_data() and check =
the
> > > output of that which is what we really care about.
> > >=20
> > > Jonathan
> > >=20
> > > > ---
> > > >=20
> > > >  drivers/iio/adc/stm32-adc-core.c | 9 +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/adc/stm32-adc-core.c
> > > > b/drivers/iio/adc/stm32-adc-core.c index 48f02dcc81c1..70011fdbf5f6
> > > > 100644
> > > > --- a/drivers/iio/adc/stm32-adc-core.c
> > > > +++ b/drivers/iio/adc/stm32-adc-core.c
> > > > @@ -706,6 +706,8 @@ static int stm32_adc_probe(struct platform_devi=
ce
> > > > *pdev)>
> > > >=20
> > > >  	struct stm32_adc_priv *priv;
> > > >  	struct device *dev =3D &pdev->dev;
> > > >  	struct device_node *np =3D pdev->dev.of_node;
> > > >=20
> > > > +	const struct of_device_id *of_id;
> > > > +
> > > >=20
> > > >  	struct resource *res;
> > > >  	u32 max_rate;
> > > >  	int ret;
> > > >=20
> > > > @@ -718,8 +720,11 @@ static int stm32_adc_probe(struct platform_dev=
ice
> > > > *pdev)>
> > > >=20
> > > >  		return -ENOMEM;
> > > >  =09
> > > >  	platform_set_drvdata(pdev, &priv->common);
> > > >=20
> > > > -	priv->cfg =3D (const struct stm32_adc_priv_cfg *)
> > > > -		of_match_device(dev->driver->of_match_table, dev)->data;
> > > > +	of_id =3D of_match_device(dev->driver->of_match_table, dev);
> > > > +	if (!of_id)
> > > > +		return -ENODEV;
> > > > +
> > > > +	priv->cfg =3D (const struct stm32_adc_priv_cfg *)of_id->data;
> > > >=20
> > > >  	priv->nb_adc_max =3D priv->cfg->num_adcs;
> > > >  	spin_lock_init(&priv->common.lock);
> >=20
> > Hello Jonathan,
> >=20
> > I think we can make it happen by designing the platform device in a way
> > that its name aligns with that of the driver. In such a scenario, when
> > the driver is probed, the of_match_device function will return null. You
> > can verify this functionality by reviewing the following function:
> >=20
> > static int platform_match(struct device *dev, struct device_driver *drv)
>=20
> I don't think we care about that case.  If there is a real example of
> why someone would do this then that would be a different matter.
>=20
> Jonathan
>=20
> > Best regards,
> > Shurong
I just think it might be more appropriate to return the correct error code =
in=20
this situation. I agree with your assessment that it is an abnormal case.=20
Therefore, it is perfectly fine if you decide not to select this patch.

Thanks for your kind reply.

Shurong




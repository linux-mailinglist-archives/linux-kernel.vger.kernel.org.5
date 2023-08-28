Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F081A78B405
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjH1PJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjH1PIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:08:52 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F921AD;
        Mon, 28 Aug 2023 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693235318;
        bh=jSltvEstbop3NROWcEwdZJbmP1v8gLHUw94pJQsaf3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pNw2iT/qbyWCGBLuhbcCv7cCEMZNdVn8fFoCL+QUImBa6sMTuen1oeRZE01b1IylE
         hH2C8JNQaYPlbVL/tlPbSLvL801cB/JQfacoTVg57o54LPqoiXspDPzLg0jUtvwRMX
         a/zLB8LbBrX1a15qHWUxjhVX72ZogzqE2E2n165Y=
Received: from localhost.localdomain ([122.14.229.192])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id 8738A04; Mon, 28 Aug 2023 23:02:07 +0800
X-QQ-mid: xmsmtpt1693234927t8a1x7jf4
Message-ID: <tencent_CF6E986A75B63EC09E3D98143650B5241809@qq.com>
X-QQ-XMAILINFO: MeK9O+zTyEgNs+LeEp8wuw1W+ZzSO1xt89C05fPo+KhYxR40w2ZLaCnt7UoQYP
         1LsuFXgH5yk7FsRZrDt/fIqNHWDOhKl6e2a/0KP79uUqIyBDmpSauM746pTQOXM0KfZy1ScFdJqr
         fQyr5SmAeTi5MmtXu34Qpz7M4eJ5Kto6Pr5NJtr1EPjoM6bvBtp6U1ClinRqyXslYpYUPLOe9C4Z
         3xfrahIgwaHA2wkKlwsILr4K3raS7jtQ+FGWoQ2ocpAOrhJNt1SG1o6vXXLcW2YT/sr2AKFphzLN
         OXviIH2CZueQR5hK89KyIHIitiQsEFCoJKX5jZZ36Dkvd8dtfoOnvTr/BBBE/D4Y94lnJICStTYf
         8Aw7fkCbWa6O0FthHHmmCof9Wh9ckxPLO1mOHJZLMLNUurTX+GWUuQKJY4MrVLpZREhJ1rDcvPMp
         qjetfGoM7hTH5XXEjcTt3JDE36uDURCN7ktDrOXH/UQeiX1GB8IMnlSKJ2srdKyOz2JLsPGA5T9c
         eu4kT5GD95hEtRwOm9VKP/bu3jCWy7TuDvg99h509XaHKPpDRQwUIcOSvLQCUxdG23Eg089Y/HEZ
         1MqtHrKRjEJgDufwyYJ7M6YyTpvk0zsJ3OfnQxUnDB3xZYVn8+NPsRtbqfv30hcrD+nXTTvo86oa
         wfeel8s2T0+O9T701m0O4tHVTX9UWd5N/1qyize4oHfs2kRfiFV3K14qumHpFwN22EePVBDtJMNP
         Je/fK5yYmUbmOsr5wR5aQ2w437Tetulqbzkpc2g75iOzlgsMs+qthpa150x/3hvYkqdHgXIPY7M+
         gbWptpFW4o+7xprMGGO39en5bcSpFnPav2S0xOCsa4syW+CFzohnSH5yjdXhUKeMiiq7IEoumbeC
         YO6FyTNE/ew2PV/95/EvgleJn8LPvxyBsMsa0FL+nZ3qqjoloNqocUUIkRVmggK/rckR0nzudnx0
         ZmvKRi5lfafiV3ojyvJjbaw10zZ0hASq0pEr0gxc0xFvrAKcGYAdhaqTX6pDFM
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
Date:   Mon, 28 Aug 2023 23:02:07 +0800
X-OQ-MSGID: <5984351.lOV4Wx5bFT@localhost.localdomain>
In-Reply-To: <20230716170821.3305e3fa@jic23-huawei>
References: <tencent_994DA85912C937E3B5405BA960B31ED90A08@qq.com>
 <20230716170821.3305e3fa@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023=E5=B9=B47=E6=9C=8817=E6=97=A5=E6=98=9F=E6=9C=9F=E4=B8=80 CST=
 =E4=B8=8A=E5=8D=8812:08:21=EF=BC=8CJonathan Cameron =E5=86=99=E9=81=93=EF=
=BC=9A
> On Sat, 15 Jul 2023 23:55:50 +0800
>=20
> Zhang Shurong <zhang_shurong@foxmail.com> wrote:
> > of_match_device() may fail and returns a NULL pointer.
> >=20
> > Fix this by checking the return value of of_match_device().
> >=20
> > Fixes: 64ad7f6438f3 ("iio: adc: stm32: introduce compatible data cfg")
> > Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
>=20
> Hi Zhang,
>=20
> I'm not sure we can actually make this bug happen. Do you have
> a way of triggering it?  The driver is only probed on devices where
> that match will work.
>=20
> Also, assuming the match table is the same one associated with this probe
> function, then us priv->cfg =3D of_device_get_match_data() and check the
> output of that which is what we really care about.
>=20
> Jonathan
>=20
> > ---
> >=20
> >  drivers/iio/adc/stm32-adc-core.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/stm32-adc-core.c
> > b/drivers/iio/adc/stm32-adc-core.c index 48f02dcc81c1..70011fdbf5f6
> > 100644
> > --- a/drivers/iio/adc/stm32-adc-core.c
> > +++ b/drivers/iio/adc/stm32-adc-core.c
> > @@ -706,6 +706,8 @@ static int stm32_adc_probe(struct platform_device
> > *pdev)>=20
> >  	struct stm32_adc_priv *priv;
> >  	struct device *dev =3D &pdev->dev;
> >  	struct device_node *np =3D pdev->dev.of_node;
> >=20
> > +	const struct of_device_id *of_id;
> > +
> >=20
> >  	struct resource *res;
> >  	u32 max_rate;
> >  	int ret;
> >=20
> > @@ -718,8 +720,11 @@ static int stm32_adc_probe(struct platform_device
> > *pdev)>=20
> >  		return -ENOMEM;
> >  =09
> >  	platform_set_drvdata(pdev, &priv->common);
> >=20
> > -	priv->cfg =3D (const struct stm32_adc_priv_cfg *)
> > -		of_match_device(dev->driver->of_match_table, dev)->data;
> > +	of_id =3D of_match_device(dev->driver->of_match_table, dev);
> > +	if (!of_id)
> > +		return -ENODEV;
> > +
> > +	priv->cfg =3D (const struct stm32_adc_priv_cfg *)of_id->data;
> >=20
> >  	priv->nb_adc_max =3D priv->cfg->num_adcs;
> >  	spin_lock_init(&priv->common.lock);
Hello Jonathan,

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




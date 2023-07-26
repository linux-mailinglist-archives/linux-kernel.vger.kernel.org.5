Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033CC762EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjGZIB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjGZIBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:01:02 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B491C196;
        Wed, 26 Jul 2023 00:52:53 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 800F6100006;
        Wed, 26 Jul 2023 10:52:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 800F6100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1690357970;
        bh=vTUqR02g7CyzGcKZgu+ckB967aCBxpLWQ1Cp4fR5GdI=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
        b=pcG+Peusb9E7FOmULN3LDYHt7fYVVlcAsgLW8ggdEqWHTiBjoOaw2BO9n+Hf7uWSK
         5gavGbOwHqAv2oNew4cLJA7pTNW3hHANNoHySLymoHWmQfsGmj4xdz+jh6P++jTYXW
         cXxYFgov4JCOVGddTQc8PU4JinFOG0t/HiteN5SjU8pmUb4j+RwJunFnc5Q/GOwwSn
         GWxSXNsvDW/H5sTbQ7dvw9xeM6Xs+2QbnwHU2SJl49x2m1fhS9kTTkqavlfRhhLjUw
         xeDl0/bgLvLcjY+MdKFteQzfMpQ/60Uq7KF2jqnzq7ooq88frKaWQE0puMS7VfWNgD
         rlnRK89r5r17A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 26 Jul 2023 10:52:50 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 10:52:43 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([::1]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::80e5:bab:4999:4480%7]) with mapi id
 15.02.1118.030; Wed, 26 Jul 2023 10:52:43 +0300
From:   Alexey Romanov <AVRomanov@sberdevices.ru>
To:     Martin Kaiser <lists@kaiser.cx>
CC:     "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "olivia@selenic.com" <olivia@selenic.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 1/3] drivers: rng: add check status bit feature
Thread-Topic: [PATCH v1 1/3] drivers: rng: add check status bit feature
Thread-Index: AQHZvwIhgAdKkj3BKkSqydzslBnXI6/KtJqAgADHaIA=
Date:   Wed, 26 Jul 2023 07:52:43 +0000
Message-ID: <20230726075243.f37sjcurmog3eunh@cab-wsm-0029881>
References: <20230725141252.98848-1-avromanov@sberdevices.ru>
 <20230725141252.98848-2-avromanov@sberdevices.ru>
 <20230725195901.n2klvgz7outqaatk@viti.kaiser.cx>
In-Reply-To: <20230725195901.n2klvgz7outqaatk@viti.kaiser.cx>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A8C49A7B982AD4AA50B334FB89BE21D@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178796 [Jul 22 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVRomanov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 525 525 723604743bfbdb7e16728748c3fa45e9eba05f7d, {Track_E25351}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/23 08:49:00 #21663637
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Tue, Jul 25, 2023 at 09:59:01PM +0200, Martin Kaiser wrote:
> Alexey Romanov (avromanov@sberdevices.ru) wrote:
>=20
> > For some Amlogic SOC's, mechanism to obtain random number
> > has been changed. For example, S4 now uses status bit waiting algo.
>=20
> > Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> > ---
> >  drivers/char/hw_random/meson-rng.c | 77 ++++++++++++++++++++++++++++--
> >  1 file changed, 74 insertions(+), 3 deletions(-)
>=20
> > diff --git a/drivers/char/hw_random/meson-rng.c b/drivers/char/hw_rando=
m/meson-rng.c
> > index a4eb8e35f13d..c6d7349630a1 100644
> > --- a/drivers/char/hw_random/meson-rng.c
> > +++ b/drivers/char/hw_random/meson-rng.c
> > @@ -14,19 +14,65 @@
> >  #include <linux/of.h>
> >  #include <linux/clk.h>
>=20
> > -#define RNG_DATA 0x00
> > +struct meson_rng_priv {
> > +	bool check_status_bit;
> > +	unsigned int data_offset;
> > +	unsigned int cfg_offset;
> > +};
>=20
> >  struct meson_rng_data {
> >  	void __iomem *base;
> >  	struct hwrng rng;
> > +	struct device *dev;
> > +	const struct meson_rng_priv *priv;
> >  };
>=20
> > +#define RUN_BIT			0
> > +#define SEED_READY_STS_BIT	31
> > +#define RETRY_CNT		100
> > +
> > +static int meson_rng_wait_status(void __iomem *cfg_addr, int bit)
> > +{
> > +	u32 status;
> > +	u32 cnt =3D 0;
> > +
> > +	do {
> > +		status =3D readl_relaxed(cfg_addr) & BIT(bit);
> > +		cpu_relax();
> > +	} while (status && (cnt++ < RETRY_CNT));
> > +
>=20
> Could you use readl_relaxed_poll_timeout here instead of open coding the
> loop?

At first I also thought about this API. But later I came to the
conclusion that it is inappropriate here:

1. We can't call rng_read from an atomic context.
2. RNG for me looks like a very lightweight primitive to me that=20
should work quiclky.

But, now I looked again at the API and realized that we can use=20
readl_relaxed_poll_timeout_atomic() instead of
readl_relaxed_poll_timeout(). What do you think?

>=20
> > +	if (status)
> > +		return -EBUSY;
> > +
> > +	return 0;
> > +}
> > +
> >  static int meson_rng_read(struct hwrng *rng, void *buf, size_t max, bo=
ol wait)
> >  {
> >  	struct meson_rng_data *data =3D
> >  			container_of(rng, struct meson_rng_data, rng);
> > +	const struct meson_rng_priv *priv =3D data->priv;
> > +
> > +	if (priv->check_status_bit) {
> > +		void __iomem *cfg_addr =3D data->base + priv->cfg_offset;
> > +		int err;
> > +
> > +		writel_relaxed(readl_relaxed(cfg_addr) | BIT(SEED_READY_STS_BIT), cf=
g_addr);
>=20
> > -	*(u32 *)buf =3D readl_relaxed(data->base + RNG_DATA);
> > +		err =3D meson_rng_wait_status(cfg_addr, SEED_READY_STS_BIT);
> > +		if (err) {
> > +			dev_err(data->dev, "Seed isn't ready, try again\n");
> > +			return err;
> > +		}
> > +
> > +		err =3D meson_rng_wait_status(cfg_addr, RUN_BIT);
> > +		if (err) {
> > +			dev_err(data->dev, "Can't get random number, try again\n");
> > +			return err;
> > +		}
> > +	}
> > +
> > +	*(u32 *)buf =3D readl_relaxed(data->base + priv->data_offset);
>=20
> >  	return sizeof(u32);
> >  }
> > @@ -41,6 +87,10 @@ static int meson_rng_probe(struct platform_device *p=
dev)
> >  	if (!data)
> >  		return -ENOMEM;
>=20
> > +	data->priv =3D device_get_match_data(&pdev->dev);
> > +	if (!data->priv)
> > +		return -ENODEV;
> > +
> >  	data->base =3D devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(data->base))
> >  		return PTR_ERR(data->base);
> > @@ -53,11 +103,32 @@ static int meson_rng_probe(struct platform_device =
*pdev)
> >  	data->rng.name =3D pdev->name;
> >  	data->rng.read =3D meson_rng_read;
>=20
> > +	data->dev =3D &pdev->dev;
> > +
> >  	return devm_hwrng_register(dev, &data->rng);
> >  }
>=20
> > +static const struct meson_rng_priv meson_rng_priv =3D {
> > +	.check_status_bit =3D false,
> > +	.data_offset =3D 0x0,
> > +	.cfg_offset =3D 0x0,
> > +};
> > +
> > +static const struct meson_rng_priv meson_rng_priv_s4 =3D {
> > +	.check_status_bit =3D true,
> > +	.data_offset =3D 0x8,
> > +	.cfg_offset =3D 0x0,
> > +};
> > +
> >  static const struct of_device_id meson_rng_of_match[] =3D {
> > -	{ .compatible =3D "amlogic,meson-rng", },
> > +	{
> > +		.compatible =3D "amlogic,meson-rng",
> > +		.data =3D (void *)&meson_rng_priv,
> > +	},
> > +	{
> > +		.compatible =3D "amlogic,meson-rng-s4",
> > +		.data =3D (void *)&meson_rng_priv_s4,
> > +	},
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(of, meson_rng_of_match);
> > --=20
> > 2.38.1
>=20

--=20
Thank you,
Alexey=

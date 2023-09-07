Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9D4797B43
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343591AbjIGSLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343638AbjIGSLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:11:13 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681772117;
        Thu,  7 Sep 2023 11:10:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bce552508fso21795841fa.1;
        Thu, 07 Sep 2023 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694110244; x=1694715044; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ck0eLIxfOYoympEUqr1tahPrvmIkWwNYKiHxaNfIYz4=;
        b=eBk62sCcJ4HqIcj1DjB2jkTYBoxvOxkuM3NN/beQB9uMsbLna73DK7d1sGdXYyP4mg
         w5Ma0TbOS/302skKHayVFZARfKZU1wDwRoDAOWXiipae1Kc5Hz+dpU/kgqlvvMhGJ/7x
         AJ+drArGTXFiCM33dnZ3LtycFdHgzfXwYPSKb+xeushQemQEO0T6NlA5qecaRYxUYC+r
         lbFcB2uFhaZpsVx3iFhju6el0nh4UHQCizAJHd6FMM9aNccy0OVKQ37mNbfWXyJoiJQ1
         /0sDgFQLn6rEMu/gzvow2egBXWEJpvt3HYbzbxqWKSeHyUTmSTdXiim8JOv+W5njggXm
         +TVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694110244; x=1694715044;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ck0eLIxfOYoympEUqr1tahPrvmIkWwNYKiHxaNfIYz4=;
        b=ZqJzSFFi1UF75ImhQ/HFv6R2Yz/32SCQQ+1wovbjQwP+PGYBl/y4b0vG9gr7yBuFCH
         7ULN/nhK4wTru8/HRD1qYt7peYlcQBBFlS5YuScapgVchYA5kctiGlneMXdswDn6TszZ
         mwqUG8pRNQ0lrsWJ4r0wsi9cnx/XPEu9nGZr68BnL0HzLMcMG6G+xJ45Iqcp8auutikp
         kM+sZ9+kCClMprCro+IRRnNR8JC+3NPgiuL6l61SktFSWgB6qMegZ/rHnqHzBS9/p6MP
         wNaB83hr52Ev9iqr4SbZiQosXqHDBt22liNvNgEEzti9BcmLweQBrJCy/p19JN4pImt6
         wxUQ==
X-Gm-Message-State: AOJu0YyXjsUSiAFrIRcOksx7ottTtXVUH5ye1vSGIcl3G77cywTV0BoX
        7uYFcczYt/F7Fy4PTg10yteQisLxR08=
X-Google-Smtp-Source: AGHT+IF7cSjqLYrDfLGPhnioqyqsJTTFtlImwhxIPwRpHoVojsOIRHvx27MZmLl02DjOzot0em2imw==
X-Received: by 2002:a1c:7905:0:b0:401:d69e:8b4d with SMTP id l5-20020a1c7905000000b00401d69e8b4dmr4331815wme.9.1694070550862;
        Thu, 07 Sep 2023 00:09:10 -0700 (PDT)
Received: from thinkpad-work.lan (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id z6-20020a7bc7c6000000b003fa96fe2bd9sm1591689wmk.22.2023.09.07.00.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 00:09:10 -0700 (PDT)
Message-ID: <8c206c8079d363d961f8f1f40c8346e872143f83.camel@gmail.com>
Subject: Re: [PATCH v2 2/3] iio: pressure: bmp280: Use i2c_get_match_data
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Thu, 07 Sep 2023 09:09:09 +0200
In-Reply-To: <20230828123937.2bff2d92@jic23-huawei>
References: <cover.1691952005.git.ang.iglesiasg@gmail.com>
         <55f8dc02de16a353f0449bc1c7cb487bd776dfaf.1691952005.git.ang.iglesiasg@gmail.com>
         <954c859835aed6c41a356fdd999a8be51469eb9e.camel@gmail.com>
         <OS0PR01MB5922EDF7759069CD4993FA468617A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
         <a83bde5079b769950220c0f1f3b8d374db39cfc7.camel@gmail.com>
         <20230828123937.2bff2d92@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-08-28 at 12:39 +0100, Jonathan Cameron wrote:
> On Mon, 14 Aug 2023 18:43:49 +0200
> Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
>=20
> > On Mon, 2023-08-14 at 06:57 +0000, Biju Das wrote:
> > > Hi Angel Iglesias,
> > >=20
> > > =C2=A0=20
> > > > Subject: Re: [PATCH v2 2/3] iio: pressure: bmp280: Use
> > > > i2c_get_match_data
> > > >=20
> > > > On Sun, 2023-08-13 at 21:03 +0200, Angel Iglesias wrote:=C2=A0=20
> > > > > Replaces device_get_match_data() and fallback match_id logic by n=
ew
> > > > > unified helper function i2c_get_match_data().
> > > > >=20
> > > > > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > > > >=20
> > > > > diff --git a/drivers/iio/pressure/bmp280-i2c.c
> > > > > b/drivers/iio/pressure/bmp280- i2c.c index 693eb1975fdc..34e3bc75=
8493
> > > > > 100644
> > > > > --- a/drivers/iio/pressure/bmp280-i2c.c
> > > > > +++ b/drivers/iio/pressure/bmp280-i2c.c
> > > > > @@ -11,9 +11,7 @@ static int bmp280_i2c_probe(struct i2c_client
> > > > > *client)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct bmp2=
80_chip_info *chip_info;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct regmap *re=
gmap;
> > > > >=20
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chip_info =3D device_g=
et_match_data(&client->dev);
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!chip_info)
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0chip_info =3D (const struct bmp280_chip_info *)
> > > > > id->driver_data;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chip_info =3D i2c_get_=
match_data(client);
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap =3D devm_r=
egmap_init_i2c(client,
> > > > > chip_info->regmap_config);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(regmap=
)) {=C2=A0=20
> > > >=20
> > > > Hi,
> > > >=20
> > > > I noticed I submitted this change that was also submitted by Biju D=
as on
> > > > another
> > > > patch:=C2=A0=20
> > > =C2=A0=20
> > > > Should I drop this patch from the series?=C2=A0=20
> > >=20
> > > I think it is ok. Andy is suggesting to use unified table for SPI/I2C
> > >=20
> > > Is it something do able and testable in your environment? see [1],
> > > If yes, please create another patch for using unified table for both =
i2c
> > > and
> > > spi.=C2=A0=20
> >=20
> > I have around a BMP390 with the SPI pins available to test it out. In t=
he
> > case
> > of the bmp280 we could unify the of_match table as they're almost the s=
ame.
> > In
> > the case of the spi_device_id and i2c_device_id tables, as they're diff=
erent
> > structs I'm not sure if they can be unified.
> >=20
> > Regarding Andy's comment, I think he's referring to the duplicated chip
> > infos.
> > In the case of the bmp280, the chip_infos are defined on the common dri=
ver
> > code
> > and used for both SPI and I2C match tables.
> Hi,
>=20
> I'm loosing track of where we are with this driver as multiple people are
> working on it.
>=20
> Angel, as most of the work is yours, please could you manage the flow of
> patches
> for this one so I get series with clear statement of what they are depend=
ent
> on.

Sure. If Biju is okay with it, maybe I should squash toghether this two ser=
ies
of mine:
https://patchwork.kernel.org/project/linux-iio/cover/cover.1691952005.git.a=
ng.iglesiasg@gmail.com/
https://patchwork.kernel.org/project/linux-iio/cover/cover.1692805377.git.a=
ng.iglesiasg@gmail.com/

And pull this patch from Biju:
https://patchwork.kernel.org/project/linux-iio/patch/20230812175808.236405-=
1-biju.das.jz@bp.renesas.com/

Sorry again from the noise introduced in the mail-list,

Kind regards,
Angel

> Thanks,
>=20
> Jonathan
>=20
> >=20
> > >=20
> > > https://lore.kernel.org/linux-renesas-soc/CAHp75VeX+T=3DhAN+PgtHTdv4b=
6UtDVgveUUww1b1kuOngzDinFw@mail.gmail.com/T/#t
> > >=20
> > > Cheers,
> > > Biju=C2=A0=20
> >=20
> > Kind regards,
> > Angel
> >=20
>=20


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6514F77A0D7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjHLPsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjHLPr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:47:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E03E4D;
        Sat, 12 Aug 2023 08:48:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe5c0e587eso28364665e9.0;
        Sat, 12 Aug 2023 08:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691855281; x=1692460081;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=StqerXza6lp4ou7FvOX89rtPb6wd1n7S7DgLDCt2oG4=;
        b=rrCDuw9TR3ZN/G8itBdztmVOwr8TUBzAlgpXulQ7EgZi8Jt0/iQmxzeGT5JDszcWkx
         4T1PRMVFxOA+wKTvJbolm8UVN+5e0GVniUbNpYMhVDi9RDgx3riJXWtr1tXM33L3Zul+
         9xrH/JfUpNHFsEW71TZzacTXV2BS1v9lbIpzZEvRsFp8CzYLNiDy9VPDCOUy4XnuLQje
         9f9RgZ/vDdydyw65kCoOxnSHJfaG+XInTbEloitQjTjHYUIS/YwnBBouMrvk688u6oTh
         CxEPZRFAC4/GYdMyFExtICVr1nq9EZamBsEnmfjsWGHwAUR6C+TOAtSiG4lXQ7S6kyC9
         P1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691855281; x=1692460081;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=StqerXza6lp4ou7FvOX89rtPb6wd1n7S7DgLDCt2oG4=;
        b=bLUjUG74X9KChRZL3E80KHXZehcTJvE8Usb40JzCiOQvkLzZybfC2AYsOQE4rxpZDF
         y9aPvS0yMxwMpJl3reQnxYPp1yfhPU1bOdq2Ed3RKqFtmiMhzL+pzS5iF4yOnag3+Gvw
         7Vzaf4Jjm+RquOOHEqzs0xEC0kA1a4rHUgcPN8DDlq+b6M0hHYkd30u+k+ShsPwjM88u
         INrsh+myvAEEMnSM8+74T2Kagui29j2mNaLP8mgsg+wGmGUo1eBv1J/KchDkMp/JC9kN
         p+/xgHoSBSiJ+z9eo2iVQvksNKXGSsuoOnEjlWm8paD9Tl3zmt1VEeVWA7fWtBjjcmwB
         L36w==
X-Gm-Message-State: AOJu0YyblTSIrHSP3WvdlZx//QeujR7y8GRj5oqIf+penyoWSS3aDGLs
        GOUZWsFcg0x1e0AFjNkYvXGn7UXlXg4=
X-Google-Smtp-Source: AGHT+IEiMg9rV6hd/Go5n3dDsaSpVQv65NQQ6ZldqeAEEjXN2ltTpwEKmVo+E7lExYL4h38cLRTwZA==
X-Received: by 2002:a7b:c7ca:0:b0:3fe:1b67:db7e with SMTP id z10-20020a7bc7ca000000b003fe1b67db7emr4150059wmk.18.1691855280770;
        Sat, 12 Aug 2023 08:48:00 -0700 (PDT)
Received: from DreamMachine2.lan (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id fk3-20020a05600c0cc300b003fc05b89e5bsm8788022wmb.34.2023.08.12.08.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 08:48:00 -0700 (PDT)
Message-ID: <6d923240417c3e679cfec6c79767b80e4ea9605b.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: pressure: bmp280: Use i2c_get_match_data
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 12 Aug 2023 17:47:59 +0200
In-Reply-To: <20230806113001.26neek3slt3w77zt@pengutronix.de>
References: <cover.1691276610.git.ang.iglesiasg@gmail.com>
         <b3483bd87093d4cd0862904b70a167ebbb538644.1691276610.git.ang.iglesiasg@gmail.com>
         <20230806113001.26neek3slt3w77zt@pengutronix.de>
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

On Sun, 2023-08-06 at 13:30 +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Sun, Aug 06, 2023 at 01:15:03AM +0200, Angel Iglesias wrote:
> > Replaces device_get_match_data() and fallback match_id logic by new
> > unified helper function i2c_get_match_data().
> >=20
> > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> >=20
> > diff --git a/drivers/iio/pressure/bmp280-i2c.c
> > b/drivers/iio/pressure/bmp280-i2c.c
> > index 693eb1975fdc..4ebaa4edc4fc 100644
> > --- a/drivers/iio/pressure/bmp280-i2c.c
> > +++ b/drivers/iio/pressure/bmp280-i2c.c
> > @@ -11,9 +11,9 @@ static int bmp280_i2c_probe(struct i2c_client *client=
)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct bmp280_chi=
p_info *chip_info;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct regmap *regmap;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chip_info =3D device_get_mat=
ch_data(&client->dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chip_info =3D i2c_get_match_=
data(client);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!chip_info)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0chip_info =3D (const struct bmp280_chip_info *) id-
> > >driver_data;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
>=20
> the old code assumed that chip_info isn't NULL (implicitly by
> dereferencing that pointer in the line below). I wouldn't change
> semantics in a patch converting to a helper and so just do:
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chip_info =3D device_get_match=
_data(&client->dev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chip_info =3D i2c_get_match_da=
ta(client);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!chip_info)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0chip_info =3D (const struct bmp280_chip_info *) id->drive=
r_data;
>=20
> or alternatively, if you think adding a check is a good idea, add an
> error message in the error path and mention the semantic change in the
> commit log.
>=20

Oh I see. I didn't take into account all this. Thanks for your time

> Best regards
> Uwe
>=20
Kind regards
Angel


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B9C77AACB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 21:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjHMTJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 15:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjHMTJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 15:09:16 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B851713;
        Sun, 13 Aug 2023 12:09:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31977ace1c8so237445f8f.1;
        Sun, 13 Aug 2023 12:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691953755; x=1692558555;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RXBR08df/DXV58NKIeSQwWxVeGpxhoQ0bVGRTRA80lw=;
        b=bxBvQS8ZdMJL0ViNasV+ePxB6Duqvx8Rix49Msa9rsJMX2Pro7soVVCLxdPufAOP+t
         xUS6zGkPj/zVg0u/f9mK5hBa848NfHopPZ52lFhFvBf86gsv5QPMA4cCpmyUilkL82SV
         EANMVoMcaUK/3AYxSdq+jEX54JGqFTixIujqTndRIzNzqL03IkJ0jzzPEAYS+PVBNtO9
         RO6FBZuiB6XHSMhl4RshPt/dsknZxx+Ku48sgNVunza1J+U/KyY9KqlscTzH4tp3g+Y2
         Pir+mL/38xuHBrWbFxnKtS4hzd3yCEeNDyHVYmkQhNKIsnNQXCT+xu0T+Zg4DhRRumVV
         mTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691953755; x=1692558555;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RXBR08df/DXV58NKIeSQwWxVeGpxhoQ0bVGRTRA80lw=;
        b=d2nr6jinkOi+xlbmrQtwxVaVO4WcEDw2OOeAqWxHBkksY0vUurgQczLVOPnWNXSHV+
         /oUeiIjn8UEYEqgOos2fHSqN3QyDGc1/+odRJwsZ6YeBM8J97nV1Xhncn+Ci4QiL/WcM
         xB5zP5JIu8GfwfiTPv8m/WgAL3QGjI5H0ghv/N0u3MNJbw0/6INFHfI5prs3gzSzkUCG
         kuzK+dDuqmf/DOGbnjMfF/cPlPn4ma+zz0KnPr8xHxyTQJDaL6EgH3yC+dOMTaq4HY6v
         66wZlf5j6x5A99gfuFI0XpfATGzul7ZC4WTZVkDqMqAl6GMN3J0hNiganffSdxw/TrLy
         RPdg==
X-Gm-Message-State: AOJu0Yy58nxM7AKSuQ2jMoqtuf2vW/u79A6RI2IFGb5mkBm/DMWa6aOx
        +xlLUyfnMyLI3htxVkndcGw=
X-Google-Smtp-Source: AGHT+IGdLQB+taBB8+9FFscmxy685Ga9PTwhT3M6lSw3fOJ6I+pDWCkva0VpkvOTzIB5CCL82dwsvg==
X-Received: by 2002:adf:f7cd:0:b0:317:eaf5:d556 with SMTP id a13-20020adff7cd000000b00317eaf5d556mr5190093wrq.69.1691953754583;
        Sun, 13 Aug 2023 12:09:14 -0700 (PDT)
Received: from DreamMachine2.lan (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id q10-20020adfcd8a000000b0031753073abcsm12084364wrj.36.2023.08.13.12.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 12:09:14 -0700 (PDT)
Message-ID: <954c859835aed6c41a356fdd999a8be51469eb9e.camel@gmail.com>
Subject: Re: [PATCH v2 2/3] iio: pressure: bmp280: Use i2c_get_match_data
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Sun, 13 Aug 2023 21:09:13 +0200
In-Reply-To: <55f8dc02de16a353f0449bc1c7cb487bd776dfaf.1691952005.git.ang.iglesiasg@gmail.com>
References: <cover.1691952005.git.ang.iglesiasg@gmail.com>
         <55f8dc02de16a353f0449bc1c7cb487bd776dfaf.1691952005.git.ang.iglesiasg@gmail.com>
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

On Sun, 2023-08-13 at 21:03 +0200, Angel Iglesias wrote:
> Replaces device_get_match_data() and fallback match_id logic by new
> unified helper function i2c_get_match_data().
>=20
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
>=20
> diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp=
280-
> i2c.c
> index 693eb1975fdc..34e3bc758493 100644
> --- a/drivers/iio/pressure/bmp280-i2c.c
> +++ b/drivers/iio/pressure/bmp280-i2c.c
> @@ -11,9 +11,7 @@ static int bmp280_i2c_probe(struct i2c_client *client)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct bmp280_chip_=
info *chip_info;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct regmap *regmap;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chip_info =3D device_get_match=
_data(&client->dev);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!chip_info)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0chip_info =3D (const struct bmp280_chip_info *) id->drive=
r_data;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chip_info =3D i2c_get_match_da=
ta(client);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap =3D devm_regmap_in=
it_i2c(client, chip_info->regmap_config);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(regmap)) {

Hi,

I noticed I submitted this change that was also submitted by Biju Das on an=
other
patch:
https://lore.kernel.org/all/20230812175808.236405-1-biju.das.jz@bp.renesas.=
com/

Should I drop this patch from the series?

Kind regards,
Angel

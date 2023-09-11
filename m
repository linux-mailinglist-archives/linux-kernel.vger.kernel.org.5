Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8244379B86E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351509AbjIKVnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbjIKMqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:46:07 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C945CCC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:46:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf57366ccdso37382655ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694436363; x=1695041163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B5XvPZZqdirBPZjjGmlvzSk97lGyej6mdL4djNdnVCI=;
        b=OwyYjWBxXY619PZ1p946e5YEvo9Jx33QPOGy4JI96bG/SMjazDKGfUF/fRbPapZB6R
         soILrONHb4G3UUYBId5oMzWHXG3iaB0sRWSR64FcrQm/fLpRu92FLaCS48a64EQI2nF6
         c9av2dJP9MJIRgtAeMGD3X8MQwCI6chTe0IZxceUTd3B65M4s9qEt8rhR47RQSUxC9Cg
         8DOEYvmD6y4v+mpVd+gsO6RleB0npm0Ro9kArpLc3V0I4wyIWM5lDp16q+PLAIDpKU4W
         zx8hsZQcD4PZjUmLqspadnvxeJ+83lkItvfnoBZKmmv7nZlANi1vrrsqL1EB5krYBwNF
         I2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694436363; x=1695041163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5XvPZZqdirBPZjjGmlvzSk97lGyej6mdL4djNdnVCI=;
        b=WjSxXckthzAt/Xh10gaRK9VddwtLdql9oX9SpmV5pAc5xJXl1dHDYpQVppDVfYkE0M
         vvGJXG2GqoypthZou1DZY9NIj8kjNC0Rop17Kn9P+tO0Q07Xn5y2lY7KAden8GYhA2uv
         dohvr1LXuCf/lej3Ykr84RJWYvx9aAMRt2eZhVEKMoNQuXKZtywHQDkaJxXaheGl1iuS
         ekc0ZuQyaGmD7Ij8fHT+RxveB4gT0qqQNr2+q4qBYWORpCaIAwz2GmOj+2Ty9sduj50k
         qhIy4rKsCr3f/LtshhGop6TjFhcNnCxQ7s8x2sD9IVHFHnguoqOJNBxDuWELuh2M7Twy
         zbnQ==
X-Gm-Message-State: AOJu0YxsK09uyBMc5RbSn5BEETkFrFkgjJ+Z0YrCU3FbGzAefDlTzFwy
        lUY3q7O/1bC5UW/CrUqyNWQ=
X-Google-Smtp-Source: AGHT+IEoeaHrIceDWUgY90v7qFPznKsBTy2K/RKtRP79UVqR7O46yrZDjc+n2e5+BFUy3Q71/RjMjg==
X-Received: by 2002:a17:90a:5794:b0:26b:513a:30b0 with SMTP id g20-20020a17090a579400b0026b513a30b0mr13923816pji.10.1694436362813;
        Mon, 11 Sep 2023 05:46:02 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id d24-20020a17090ac25800b0026b30377c14sm5581863pjx.6.2023.09.11.05.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 05:46:02 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0E96680DD549; Mon, 11 Sep 2023 19:45:58 +0700 (WIB)
Date:   Mon, 11 Sep 2023 19:45:58 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Myunguk Kim <mwkim@gaonchips.com>, alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dwc: fix typo in comment
Message-ID: <ZP8MBll6ZsOlZyaj@debian.me>
References: <20230911064646.168181-1-mwkim@gaonchips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S+WQLwUYDDDtOHMY"
Content-Disposition: inline
In-Reply-To: <20230911064646.168181-1-mwkim@gaonchips.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S+WQLwUYDDDtOHMY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 03:46:46PM +0900, Myunguk Kim wrote:
> This fixes typo in comment

On what? Can you describe the typofix in more detail?

>=20
> Signed-off-by: Myunguk Kim <mwkim@gaonchips.com>
> ---
>  sound/soc/dwc/dwc-i2s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
> index 71ff894035a4..45e55e550924 100644
> --- a/sound/soc/dwc/dwc-i2s.c
> +++ b/sound/soc/dwc/dwc-i2s.c
> @@ -138,7 +138,7 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev=
_id)
>  			irq_valid =3D true;
>  		}
> =20
> -		/* Error Handling: TX */
> +		/* Error Handling: RX */
>  		if (isr[i] & ISR_RXFO)=20
> { 			dev_err_ratelimited(dev->dev, "RX overrun (ch_id=3D%d)\n", i);
>  			irq_valid =3D true;

Oh, you mean the code following the comment checks for RXFO overrun.

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--S+WQLwUYDDDtOHMY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZP8MAgAKCRD2uYlJVVFO
o3MyAQDA9qZKWM+Xqnw1ZKiEx8pkr5GrsaLJ5HV6zN64vPqvOQD9F3v5H5vFLGqO
0v230ZWsjXAWDA2rPXXP68hDNudhXA0=
=aoyc
-----END PGP SIGNATURE-----

--S+WQLwUYDDDtOHMY--

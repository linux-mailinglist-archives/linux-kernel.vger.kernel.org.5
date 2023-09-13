Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B39779E0CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbjIMH1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238575AbjIMH1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:27:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B321986
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:27:13 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so4872675ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694590033; x=1695194833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/U+Y3lXkYu7caCIkdd3um0u2yWGnImH6AF8GWuY2Sng=;
        b=RSQq4MVOzkVTxLGl6tDxLBGRgP0JXHAiegiUOL+C8DV9/roYfYuzsnmWbZi/vImuXK
         jEC2CyyICwCuWE1Y/UDoeWmRw/P63twZIiFs64ZbamV3UpzBJovWTY/kYKEiyP6SJBQW
         0TAWFfu+dN4yDXlSiUneo4x3YLRx9gkl3KH/UHqTjrsV7o1YILCrKI0nGcGp2XuM6htN
         z9t3JRkc7ajUAqZqDgaEeq61Z7+c6EYaxCWCeD2F0uQcw1HbhRTCZWoYh/Q4dSYE2zig
         Z5RSSkc+ozfYvtJGGVIzBtIUW6YX+HRE8gGPrB4sIKyxnXvvf4pveIf5BIgR8p7Rjrj0
         zMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694590033; x=1695194833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/U+Y3lXkYu7caCIkdd3um0u2yWGnImH6AF8GWuY2Sng=;
        b=nXsl+FTGKAUKtjYLWh8r1s46HiLiVjRKVhkEibER8x57tDrWySEG3ifLR4aeUp+hAd
         T4AZFiaRvqkNZr/ZhEXfXzM2UX4j7zitt20rw1jLg/5nA+Ie29BFZs0nzAkJwqSt6W1T
         ArF6HfiB4cB0Aajk11z9vUReKPnQUYvvy/vPWRbprnGslZ6j6OztFrCZ+uGOxCM2oql5
         CuQoQBJ3qhZou9CrkrpJQY2CV3RovMz8S0JaPMcePgvrxykSDJxb6Z8mYn8uQAnZDkeD
         lNCBWYwW9QZnGRYxrdFueIDtAMLFaFeMwMHWyNGt4Ww6mEj0Otv82umj/4u8xSoKlZV/
         GdRw==
X-Gm-Message-State: AOJu0Yz13qN8N05mqlYxPNfiiaKGvlZeO8EEpPKGqZMPJxz6iyu6eTVw
        qLRuwNC8WChVu3uC0Df8s4s=
X-Google-Smtp-Source: AGHT+IGZWdmjxFZdnmgRLOwMQ8jZlp8YoTiqoeKbtipu94an5Ymgd1VKd/ABcnjQwkiXMVWRf1tBRg==
X-Received: by 2002:a17:903:22c3:b0:1c3:a814:a12b with SMTP id y3-20020a17090322c300b001c3a814a12bmr2872742plg.16.1694590033299;
        Wed, 13 Sep 2023 00:27:13 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id iz2-20020a170902ef8200b001bd99fd1114sm9713884plb.288.2023.09.13.00.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:27:12 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 575FF8212DD9; Wed, 13 Sep 2023 14:27:10 +0700 (WIB)
Date:   Wed, 13 Sep 2023 14:27:09 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Myunguk Kim <mwkim@gaonchips.com>, alsa-devel@alsa-project.org
Cc:     broonie@kernel.org, fido_max@inbox.ru,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        u.kleine-koenig@pengutronix.de, xingyu.wu@starfivetech.com
Subject: Re: [PATCH] [v2] ASoC: dwc: fix typo in comment
Message-ID: <ZQFkTYqZ-QWxCjFu@debian.me>
References: <20230913024103.1454354-1-mwkim@gaonchips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ob7r/gzMky4stU9D"
Content-Disposition: inline
In-Reply-To: <20230913024103.1454354-1-mwkim@gaonchips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ob7r/gzMky4stU9D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 11:41:04AM +0900, Myunguk Kim wrote:
> ISR_RXFO means "Status of Data Overrun interrupt for the RX channel"
> according to the datasheet.
>=20
> So, the comment should be RX, not TX

Thanks for better description!

The patch title though, I'd like to write it as "ASoC: dwc: correct ISR_RXFO
check comment".

>=20
> Signed-off-by: Myunguk Kim <mwkim@gaonchips.com>
> ---
>  sound/soc/dwc/dwc-i2s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
> index 22c004179214..c71c17ef961d 100644
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

In any case,

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Ob7r/gzMky4stU9D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQFkSQAKCRD2uYlJVVFO
oyutAQClx0B4pl8pmOqjUxvXFRf0+/lJMGZQaaeply8sj17flgEAuE3xDs4OmWl9
crDoNHVRX2FbfnwnfY48vy4ehCyKQAU=
=uSnr
-----END PGP SIGNATURE-----

--Ob7r/gzMky4stU9D--

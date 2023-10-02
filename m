Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78377B538B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbjJBMy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjJBMy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:54:56 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8E5AD;
        Mon,  2 Oct 2023 05:54:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c15463ddd4so193727991fa.3;
        Mon, 02 Oct 2023 05:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696251291; x=1696856091; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZJR14f5l2U6HTkmIyT91fkWqxzAoTmODmYIX5RU5wM=;
        b=SZtp6GhZCIc2GkzCIUiI3kQ65UDDTeXBfXscS5B86AuRk3j+cWuvsE36arPOKyxB2O
         6NVFCt1I/ZKZf2qQdkA5QP2QUReuxwBd4YmHha1q1eDVLshI+7icsVY/bUZDJlm4Ol99
         lZEUgG4/Im0/tJs5xnQjjUx/0oi4NoBGYN0hrv9xNVAMt61Ftk3EmedRcy9a48FpGuCO
         5v4DulxZ73pJgkeOze5UMPtxIbMjUD5kypscvEnOg6Mp13K1+VMaFpIh4B8RScU/nXVw
         kkl/8Kf+7aCrB3vipSdOSpxGKe4bLGdbq8arh5wel4IgUI3Mb3qxnZw8N5/U1BJGjV5y
         d1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696251291; x=1696856091;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZJR14f5l2U6HTkmIyT91fkWqxzAoTmODmYIX5RU5wM=;
        b=fBYfNRNQm+QK6lv5dgR3hl0qPYYJFRyn5Tl6ZIBizxLxWWZAtWmtH7SU9ZBpjUzKVJ
         2CE3jb4J0a67TbKIqzgQHdN/FXlmbL6OnuKIzpLfzE58YgZaJOJ4MLAVY8ojR8KKn0XD
         FeNASdV0ehRuXSycdUitqIEoRt+ucgw26aUbSOhl+mdvSDcwNK8cUcXecSNVSacFUZsd
         XYGy0nCzJrl2cVzTHLgEHXw773n2wRPk0xsx0xG7TTZ4o9e5wdbKLFjBhjJc0FVv2a8P
         qq4z9arNiBBIyiiukZo6lb2j2uZXKugZk3Q8SGYkMM8SZck4KQWo9hdmd5DKXYQ70XE8
         Yiig==
X-Gm-Message-State: AOJu0YyNEyDQIL1fANB3Xm+HJIl6q3fURhGiAdrMkh0SyDQtTcfzNuiy
        ZmjKT0MggnE80WMwdVtexVfgmmpJLr8=
X-Google-Smtp-Source: AGHT+IHIrrFQD0cCpusHkYjTSE7AWof8c/S3aBqCPM4xJfPxFXYN1ojCirQX5QW45ECBTDl79siiHw==
X-Received: by 2002:a2e:9a89:0:b0:2b6:d13a:8e34 with SMTP id p9-20020a2e9a89000000b002b6d13a8e34mr9770893lji.46.1696251291323;
        Mon, 02 Oct 2023 05:54:51 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id c4-20020a2e9d84000000b002bfb1cc89b7sm5300465ljj.110.2023.10.02.05.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:54:50 -0700 (PDT)
Date:   Mon, 2 Oct 2023 15:54:46 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] tools: iio: iio_generic_buffer ensure alignment
Message-ID: <ZRq9lm/C7g9m9zen@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uWQp3c5/bnyFA+y2"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uWQp3c5/bnyFA+y2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The iio_generic_buffer can return garbage values when the total size of
scan data is not a multiple of the largest element in the scan. This can be
demonstrated by reading a scan, consisting, for example of one 4-byte and
one 2-byte element, where the 4-byte element is first in the buffer.

The IIO generic buffer code does not take into account the last two
padding bytes that are needed to ensure that the 4-byte data for next
scan is correctly aligned.

Add the padding bytes required to align the next sample with the scan size.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: e58537ccce73 ("staging: iio: update example application.")

---
Revision history
v4 =3D> v5:
 - drop unnecessary comment.
 - drop all other patches as those were already applied.
 - add Fixes-tag.
v3 =3D> v4:
 - drop extra print and TODO coment
 - add comment clarifying alignment sizes
---
 tools/iio/iio_generic_buffer.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 44bbf80f0cfd..c1c037ee0071 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -54,9 +54,12 @@ enum autochan {
 static unsigned int size_from_channelarray(struct iio_channel_info *channe=
ls, int num_channels)
 {
 	unsigned int bytes =3D 0;
-	int i =3D 0;
+	int i =3D 0, max =3D 0;
+	unsigned int misalignment;
=20
 	while (i < num_channels) {
+		if (channels[i].bytes > max)
+			max =3D channels[i].bytes;
 		if (bytes % channels[i].bytes =3D=3D 0)
 			channels[i].location =3D bytes;
 		else
@@ -66,6 +69,14 @@ static unsigned int size_from_channelarray(struct iio_ch=
annel_info *channels, in
 		bytes =3D channels[i].location + channels[i].bytes;
 		i++;
 	}
+	/*
+	 * We wan't the data in next sample to also be properly aligned so
+	 * we'll add padding at the end if needed. Adding padding only
+	 * works for channel data which size is 2^n bytes.
+	 */
+	misalignment =3D bytes % max;
+	if (misalignment)
+		bytes +=3D max - misalignment;
=20
 	return bytes;
 }

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
--=20
2.41.0


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--uWQp3c5/bnyFA+y2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUavYUACgkQeFA3/03a
ocW3JQf8Ccbaeg1B45itnTgW6SaOwPrBzhpHVjlNyg9uKkbNiQxr9wwmvT5/KWI0
ck+U28EoP2yVWB6Z4DJH7tCDDyBSTUuuvsAz1sWgwFkAViVeb8FnESeeRQRO5t1V
zhBopbMj51/gs9AtAgXzt+MhxqGtE47GHQcPmpG5SfMdOesp7fpaEzVxj6B0/ve1
sv0GpdEhAQ1F1OINpgJ/ZbUd8hB9Mhtd6dPK/K2NrI8OPZR3LrMThlMtZtHCb+Et
cWg4qPvFUeNB4x8bXs9u0nVC7c+QdXXaLPKYRAT4ZwPktCeT2Hjr6Uu5945vIfKB
Agqdgysla0Rg/0g63MSZ4vstA/D5Hg==
=ahQD
-----END PGP SIGNATURE-----

--uWQp3c5/bnyFA+y2--

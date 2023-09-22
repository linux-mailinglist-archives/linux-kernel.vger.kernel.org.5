Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE877AB060
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjIVLRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjIVLRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:17:11 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D1EAF;
        Fri, 22 Sep 2023 04:17:05 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso34320681fa.1;
        Fri, 22 Sep 2023 04:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695381424; x=1695986224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOmXlRHFjQZVNGJzWqKnGXST1HA75pZmn0pDpkT8XEA=;
        b=Yzr1QRREIqQMan7zQS/B26XmynwrCHWPLSUm/sfxHIuCvHdLYA1FTZC+ecubj10Wyz
         AzQcqYJ56rZ5Lle8kSgaqU1Tvv94J3903y5+SqxhU9JzTCf6tmxDDuhegXtR498YLhS1
         AqqP5VlW3BjSXDI5V4gKOePrHGnG5iWdNqd/JTH0gA1+SA2QpFjCGHY15eLCbUUzjPsM
         suGTEvh4O14NGoucQlJmDglF5zksNxPFGF4fJ4SocTiKVT4P29vusqW4NUP7fYd53IYL
         IYeEQZK5tr9Culqws8sK+9uv9esOF23STqa25ur/uYwEh1rf5XmC0z9OqfDCBvuvO3xw
         lZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695381424; x=1695986224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOmXlRHFjQZVNGJzWqKnGXST1HA75pZmn0pDpkT8XEA=;
        b=Oct3SSLZLalsIvnfYd679iIKqos6WYltmVnBp0qbGaUHCtZqNC+QdkqnvnrOS42UXj
         64Zn5dh5WoU0TJI7AI7Nm1gVP4WM0EC92rnejrzGJOJD5mDoYv5/XIbLEkXN87/SHD/N
         WN7veHTM1j7GxlWauGJ9sDUEW5o8TcOTzDDlVOHCZTEEtFwXJ0qOi17hsaPFzBVIOx5C
         1z3uajh2+cjiLA0+sS+KHrHFVDE/jNDVbNEFQRRj+sfjoSeyLDGa1gPTgZDflc8q7MIx
         93tQJZlr30Np4MLEQg7s1sCDj0XoD796DNZWxD1DHuMfXFlJhVLQL6uqGGDGi9U+DyeE
         xztQ==
X-Gm-Message-State: AOJu0YwsiwJluaRQgE39+Iqyd+CBjYrdAxTPSf6APXe41tgIDV/Pu/kh
        qQQgOdECP0Gddhe8kDnJ6dA=
X-Google-Smtp-Source: AGHT+IFFvkG/+1UGhUahOmMwZV25EbvezT7Z/KylfHcN8ZTuSFXHjIkMR0NU40hvOIgkdAHKc5ky+w==
X-Received: by 2002:a05:651c:1034:b0:2bc:d8cb:5a13 with SMTP id w20-20020a05651c103400b002bcd8cb5a13mr7176763ljm.42.1695381423636;
        Fri, 22 Sep 2023 04:17:03 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id v12-20020a2e960c000000b002b6ad323248sm868292ljh.10.2023.09.22.04.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:17:02 -0700 (PDT)
Date:   Fri, 22 Sep 2023 14:16:57 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Benjamin Bara <bbara93@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] iio: improve doc for available_scan_mask
Message-ID: <74b66a5b9eee2fb7046f254928391e3da61aa3b2.1695380366.git.mazziesaccount@gmail.com>
References: <cover.1695380366.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sYH9gocHgXuXB6Ok"
Content-Disposition: inline
In-Reply-To: <cover.1695380366.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sYH9gocHgXuXB6Ok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The available_scan_mask is an array of bitmaps representing the channels
which can be simultaneously enabled by the driver. In many cases the
hardware can offer more channels than what the user is interested in
obtaining. In such cases it may be preferred that only subset of
channels are enabled, and driver reads only a subset of the channels from
the hardware.

Some devices can't support all channel combinations. For example the
BM1390 pressure sensor must always read the pressure data in order to
acknowledge the watermark IRQ, while reading temperature can be omitted.
So, the available scan mask would be 'pressure and temperature' and
'pressure only'.

When IIO seatchs for the scan mask it asks the driver to use, it will
pick the first suitable one from the 'available_scan_mask' array. Hence,
ordering the masks in the array makes difference. We should 'prefer'
reading just the pressure from the hardware (as it is cheaper operation
than reading both pressure and temperature) over reading both pressure
and temperature. Hence, we should set the 'only pressure' as first scan
mask in available_scan_mask array. If we set the 'pressure and
temperature' as first in array, then the 'only temperature' will never
get used as 'pressure and temperature' can always serve the user's
needs.

Add (minimal) kerneldoc to the 'available_scan_mask' to hint the user
that ordering of masks matters.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 include/linux/iio/iio.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 202e55b0a28b..7bfa1b9bc8a2 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -556,7 +556,9 @@ struct iio_buffer_setup_ops {
  *			and owner
  * @buffer:		[DRIVER] any buffer present
  * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
- * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
+ * @available_scan_masks: [DRIVER] optional array of allowed bitmasks. Sor=
t the
+ *			   array in order of preference, the most preferred
+ *			   masks first.
  * @masklength:		[INTERN] the length of the mask established from
  *			channels
  * @active_scan_mask:	[INTERN] union of all scan masks requested by buffers
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

--sYH9gocHgXuXB6Ok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUNd6kACgkQeFA3/03a
ocXzTAgAruwUVjkJt11Vu6Zr076Hu1E5ugJlJ5Cyt98gsghv1FGk9nv+WLtL/cpx
G/Mbto9I9RM6NDwtZw7I9+qlZhPQz5zWrjEpencZlKNkYs3pJqgi1FoS3zWzYU+Y
bc3jeU6caHPjZtBmXvz37Eyo8CkU5LogjdqJPizsZYwThhysT70qe35GLz3L4Hc0
qa52n0IZagq/PplIYnxn51UolJJNKaG9CNzVAVU8lsolMs3lD694jvD21AOwYS4G
1YZ+DA4WNiXMTGDVR/LlUC5gq0uA0oZaDPBig+NUXdTCUKmMIuy4NUwAWltogTad
aaQoa3ztEZPvfh5Xl800Ys+vDCeilA==
=S0fv
-----END PGP SIGNATURE-----

--sYH9gocHgXuXB6Ok--

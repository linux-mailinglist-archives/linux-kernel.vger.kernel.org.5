Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8737AB067
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjIVLSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjIVLSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:18:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A866AF;
        Fri, 22 Sep 2023 04:17:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50437f39c9dso1036218e87.3;
        Fri, 22 Sep 2023 04:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695381477; x=1695986277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cIAB6MpcjuuKqpe+1Lhuap6hKVsOivGLkNwO83oo9k0=;
        b=DdXYddpVAz5TSDVu2S7BpvGzts8SN4rn2NVYUSpgm1KVA3cPLCCzb83ukZes6s0P9s
         Rje2sFAV7pmqKCg3vzlQ95AjtaGajZQVQYYpVxDzS/qgZ89usx9LBbjMQcUthrsDQEaF
         9/3mup9+mZGXcWL1enfi2ZgksElk4prlBE3gBqMXBMUImcDcYIHjP9mKi9gdHP40OShs
         5u80suFrU+AaZlipgLFB8Nui2cKoiiyIs3JwOBGe5gX6ntrBw9Qx/+4DHPKRudkjU/Jl
         LDAKLSbRhfpzO4DTsfBUA+mL/5lhq62eaDr0mmLqesOyK8nLkAZ3HX3Y/5qp/cXzeFWy
         GqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695381477; x=1695986277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIAB6MpcjuuKqpe+1Lhuap6hKVsOivGLkNwO83oo9k0=;
        b=szRwBVhqiZvOcNR1FUge2ByEvQnkwzVvzJZ03Jj57nBl/XMGm0VOBbChskdRobCn8s
         Ed2CyCkgBu41UEP+OeWHrYRc/qbcz62r4U1WltuK4gQhLWNVe7v1F0Z1tW18mln1FEtT
         lRQ1IcWIsN5A1UcbUgX9zAF/00gBNKnWUKAP/JBmhTUrM2wqvGsBGnOqqo4f1kslXcpG
         Zuj0fwpE1qYpiU9nKLEwQv7mPlSe+f2pmAfk4bjEM6tX7yLss2eqX5uHgy/HjxMxwsQ3
         H/2kOOKy7kEjUr2YNH6cIXy5WsEzC98xlmFpkAY9z0rwQeMEVaYWJOrV7amoLmqaF2yq
         jwBQ==
X-Gm-Message-State: AOJu0Yw/aysW0+YcjzcElcYq8/1Wp5MAEu9X2sli3p32h0UVqBp6OUFj
        uWW/WOnpChJXIGayhsRdCmI=
X-Google-Smtp-Source: AGHT+IHOHpc2JdOxK7d0YeAjtZfPNR/OIge9cN+0kT1HFVT5iiJj7Btc30lBmOLE4ebyIj9/6ABypA==
X-Received: by 2002:a05:6512:2356:b0:504:35a1:31ce with SMTP id p22-20020a056512235600b0050435a131cemr2576998lfu.30.1695381477520;
        Fri, 22 Sep 2023 04:17:57 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id u2-20020a056512040200b005030a35019dsm692099lfk.178.2023.09.22.04.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:17:56 -0700 (PDT)
Date:   Fri, 22 Sep 2023 14:17:49 +0300
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
Subject: [PATCH v3 3/6] iio: try searching for exact scan_mask
Message-ID: <24a577e6e157e1199817ab36631cec51675ef3ca.1695380366.git.mazziesaccount@gmail.com>
References: <cover.1695380366.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7R35CQ0ZLI6pqD5C"
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


--7R35CQ0ZLI6pqD5C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When IIO goes through the available scan masks in order to select the
best suiting one, it will just accept the first listed subset of channels
which meets the user's requirements. This works great for most of the
drivers as they can sort the list of channels in the order where
the 'least costy' channel selections come first.

It may be that in some cases the ordering of the list of available scan
masks is not thoroughly considered. We can't really try outsmarting the
drivers by selecting the smallest supported subset - as this might not
be the 'least costy one' - but we can at least try searching through the
list to see if we have an exactly matching mask. It should be sane
assumption that if the device can support reading only the exact
channels user is interested in, then this should be also the least costy
selection - and if it is not and optimization is important, then the
driver could consider omitting setting the 'available_scan_mask' and
doing demuxing - or just omitting the 'costy exact match' and providing
only the more efficient broader selection of channels.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/industrialio-buffer.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-b=
uffer.c
index 176d31d9f9d8..e97396623373 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -411,19 +411,32 @@ static const unsigned long *iio_scan_mask_match(const=
 unsigned long *av_masks,
 						const unsigned long *mask,
 						bool strict)
 {
+	const unsigned long *first_subset =3D NULL;
+
 	if (bitmap_empty(mask, masklength))
 		return NULL;
-	while (*av_masks) {
-		if (strict) {
+
+	if (strict) {
+		while (*av_masks) {
 			if (bitmap_equal(mask, av_masks, masklength))
 				return av_masks;
-		} else {
-			if (bitmap_subset(mask, av_masks, masklength))
-				return av_masks;
+
+			av_masks +=3D BITS_TO_LONGS(masklength);
 		}
+
+		return NULL;
+	}
+	while (*av_masks) {
+		if (bitmap_equal(mask, av_masks, masklength))
+			return av_masks;
+
+		if (!first_subset && bitmap_subset(mask, av_masks, masklength))
+			first_subset =3D av_masks;
+
 		av_masks +=3D BITS_TO_LONGS(masklength);
 	}
-	return NULL;
+
+	return first_subset;
 }
=20
 static bool iio_validate_scan_mask(struct iio_dev *indio_dev,
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

--7R35CQ0ZLI6pqD5C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUNd90ACgkQeFA3/03a
ocU2WQf6Auw4pqbkWyR7JsNtuC7v1QjKz5jrZegmivTs0dL1j1z10SwoAHvS0A9W
asnYKWnIeu4+JapN1nQsg/oSmhMIB155kvieyIywiOmMRONTkw1TS34ldE4jpYAd
osVM3JnM8tXCqXKjFJRB69OuRSXXr3+S6h3QGGdnKeTvsJLv4FonQmEuPtKZTp7u
8Xo6CZSOzG8gXGrG6D6G/Mafq9Y9/Fl8lhURwk/Ri2CdjG7laXZk2/JjKoq1Mb7t
vHY51PbtMB+W/wnSY8ictXAn5OXV4zuFvL+aa0IRzIgKzRejkZpWIVZhZIJAUM0P
bPF3yRpfUKlaAj/5pAsZkUjeFR0T+A==
=pMvn
-----END PGP SIGNATURE-----

--7R35CQ0ZLI6pqD5C--

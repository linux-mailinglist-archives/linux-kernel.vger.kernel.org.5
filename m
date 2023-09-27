Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECB07AFE50
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjI0I1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjI0I01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:26:27 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A732CE9;
        Wed, 27 Sep 2023 01:26:23 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-503397ee920so16761852e87.1;
        Wed, 27 Sep 2023 01:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695803182; x=1696407982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3M+fhkSU75ZwJTVy/9LEZES58n3Sr/w+Y0+8L0nomxI=;
        b=S6bnlg6iw3CoIgvx97RpA9I+w/dZH1ssIGt+8PXtX2ZW1ICm+Tcuh2HwsUN7rPaAWq
         a9DF0IFLKSw1QzovG0nPPrExbNyyqc4POBE+lZznDUIqb5HzHN6OstWvg7lfOp1EAuAT
         cc2xXpxvVv5E8sOGM9T/y/nepfh0lud54ANJwqe3ZN7KIVFpZXmQdwlKQq5EZrlkQv4c
         Mfe50mhAk58KE14xYi/gH1y8F+EY3H2dIYcZnC+xbgcorO9IDqouYinD9dXTLrXtg6Ce
         r//3j1lnMEXVDyAwisflX3gLMzLM2n4/0r/NC0kuenDmq70MHYbi+ZFHjptMb1G7yNQb
         kyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695803182; x=1696407982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M+fhkSU75ZwJTVy/9LEZES58n3Sr/w+Y0+8L0nomxI=;
        b=MWQ0GEcHmkY+kdQ2UmT65ZkiaTpzPqOn1Z6e9Kec1srAWOgww6G6MiwZLOKinDqvGk
         75uE7PnD6qzNQUH6SGdUcjkZbGxFdYEWoc13w4ZMUoOPf5StBf4Qnq1aAmimt+ATWzqu
         U9KY3xAXrC8ZrSpcqDyC3AwYH6IYAdlV9DPLj70jQ1A0KPC1NkA0ci0hAaKEf5cpv8hS
         kL5xz/sGuWqGKfjTlhHYqZ+WZAPuY/Boqp2UVe4a0rbVMPXzSXfqx5iDQjiB3k2kpzEq
         4BPJy/VlogUdA3ZmNiMiuL4jJeKzuYUX7fBK1HInrUW9RH+7FVxfXCgvr+x006xkix3E
         SIgg==
X-Gm-Message-State: AOJu0Yyevn2YS4lSq5rEj8Kh2G15OPuxzS7cTH5HjbiRB9VAfJjx9GAe
        M4qWfxuUySyLs9UHQuwBii/ngh/dJT4=
X-Google-Smtp-Source: AGHT+IEvTKArd+9rhJz1P3ux20jG6esY8uIeRZvvlL70yqMnj+s8j9q6aFlo4F34eBNu31UMcyyttQ==
X-Received: by 2002:a05:6512:11c6:b0:4fa:5e76:7ad4 with SMTP id h6-20020a05651211c600b004fa5e767ad4mr983405lfr.10.1695803181724;
        Wed, 27 Sep 2023 01:26:21 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id h18-20020a197012000000b0050309ea3a62sm2479646lfc.277.2023.09.27.01.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:26:20 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:26:07 +0300
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
        Benjamin Bara <bbara93@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] tools: iio: iio_generic_buffer ensure alignment
Message-ID: <e986b4562ca663e19ea30b81d15221c15bd87227.1695727471.git.mazziesaccount@gmail.com>
References: <cover.1695727471.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FUsvzO4N/DXR6Pi1"
Content-Disposition: inline
In-Reply-To: <cover.1695727471.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FUsvzO4N/DXR6Pi1
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

---
I think the whole alignment code could be revised here, but I am unsure
what kind of alignment is expected, and if it actually depends on the
architecture. Anyways, I'll quote myself from another mail to explain
how this patch handles things:

> For non power of2 sizes, the alignment code will result strange alignment=
s.
> For example, scan consisting of two 6-byte elements would be packed -
> meaning the second element would probably break the alignment rules by
> starting from address '6'. I think that on most architectures the proper
> access would require 2 padding bytes to be added at the end of the first
> sample. Current code wouldn't do that.

> If we allow only power of 2 sizes - I would expect a scan consisting of a
> 8 byte element followed by a 16 byte element to be tightly packed. I'd
> assume that for the 16 byte data, it'd be enough to ensure 8 byte alignme=
nt.
> Current code would however add 8 bytes of padding at the end of the first
> 8 byte element to make the 16 byte scan element to be aligned at 16 byte
> address. To my uneducated mind this is not needed - but maybe I just don't
> know what I am writing about :)

Revision history
v3 =3D> v4:
 - drop extra print and TODO coment
 - add comment clarifying alignment sizes
---
 tools/iio/iio_generic_buffer.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 44bbf80f0cfd..c07c49397b19 100644
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
@@ -66,6 +69,19 @@ static unsigned int size_from_channelarray(struct iio_ch=
annel_info *channels, in
 		bytes =3D channels[i].location + channels[i].bytes;
 		i++;
 	}
+	/*
+	 * We wan't the data in next sample to also be properly aligned so
+	 * we'll add padding at the end if needed.
+	 *
+	 * Please note, this code does ensure alignment to maximum channel
+	 * size. It works only as long as the channel sizes are 1, 2, 4 or 8
+	 * bytes. Also, on 32 bit platforms it might be enough to align also
+	 * the 8 byte elements to 4 byte boundary - which this code is not
+	 * doing.
+	 */
+	misalignment =3D bytes % max;
+	if (misalignment)
+		bytes +=3D max - misalignment;
=20
 	return bytes;
 }
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

--FUsvzO4N/DXR6Pi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUT5x8ACgkQeFA3/03a
ocXFBAf/agzdoD0BTlSQt9kSg5PKTv+tn0wW7rJuXFzNBCu5rhlqLNP6QOi99QWI
hK2rxH58jseymEaYPW4eIlpcqodLlRbiDmFgo9sPSyxHG05rUXZjdWPR32WQ3F3D
uSwmI2UNclE6waCiEWsHSGHeziVrCd5HVLShM1lpdRYBXx208ETBvCxSxANEi6tN
bhK79Y8dTMexxtYZ3cvFG+8hfFACPeU26dOFk2FX3kscg84MUsfPyynmq6bPybU9
93KkSixmo5GtqbqQUufAY7zeitoxPqwb6CjR16TowaLnyuxsSuokd8YPw8/oizDC
O/XW9NqFLWrJ1KK5bA8NgoaB2fgp4w==
=bVGG
-----END PGP SIGNATURE-----

--FUsvzO4N/DXR6Pi1--

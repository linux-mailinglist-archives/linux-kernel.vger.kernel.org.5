Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1445C7AFE5A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjI0I2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjI0I1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:27:49 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BC31AC;
        Wed, 27 Sep 2023 01:27:48 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bffc55af02so172410331fa.2;
        Wed, 27 Sep 2023 01:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695803266; x=1696408066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj1fAt2POw3G1BVuIsXBKGLxebPu14W+cyBpSJ0ZvcI=;
        b=FV8ocweEHg8MOpz/GP3m88ft4DP+kL++AYzTqo7SVK1cFVuHy0qLy6d40Hm38vrHaj
         ZUcFF3oALF4W2DaBNDtP4H31SxenWPhLFATIZvAj61cMjdexJCL9wT4Xg0/CK8FwaNpA
         fECravsyKdfcShIF6v3YMRSpuGIRrRwGN7yw3J7IgfvYs91698lxFnDm9M5NOxhL1HJg
         cnnDz/AmKjPckbUQizjuklqvwRS51v+e7LMx/9zeuU6Z1UvoAR3AX/wLzL91Otq+ldnB
         F1WW1l4kQwrC3PHSMXluVFBZ+5KH67Mh+1Ah+/tgT4qWfwsPDqbKiRM/Y1s24eWlO02D
         19qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695803266; x=1696408066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj1fAt2POw3G1BVuIsXBKGLxebPu14W+cyBpSJ0ZvcI=;
        b=LQl78bnKQzC+12GXOP7iEflB7Hund3B/09Hk8eiaY6GulXRJ/+qWt8atOYnkvdj2bv
         JIumaMMnZZzFVm49FddezNEm1PFlVzgOdyf6QTxTuanaJOkuNQx//e1mLuumdfNuI5zT
         i4ewB8QJsf+j2UXkd58An3odKIi/pqnp1I58o6Yw3tyHDBYDHvoiXD9ec/nf+d6kPDbc
         tXuyVwrNKnObIGnNoqEJQnKbpdYgena0j6u/SRicoH6RTQUBGTbfN3zbcCvl/g9ChEGO
         xWEsjVRL8d5ScJluM/Zx9HJCRM9K9jrMNMjvcxheo132GKN6w5aZ6IElimG7a3+okLP5
         NGBA==
X-Gm-Message-State: AOJu0YwwRzKg96LBmJFBPjMAYRtXj+/Q75EqUGhKH3+sBqGJk313B98a
        ghbHFHcAZG8OzXLszapYBxk=
X-Google-Smtp-Source: AGHT+IEt/OpJyHtIN1ai4xGP0BH/uIzC9mzeDahbG3aAQiXYDWUoiUCtV76TBdGUS3UiZ7XaV2pwFA==
X-Received: by 2002:a2e:9612:0:b0:2bc:be3c:9080 with SMTP id v18-20020a2e9612000000b002bcbe3c9080mr1314766ljh.27.1695803266085;
        Wed, 27 Sep 2023 01:27:46 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y4-20020a2e95c4000000b002ba586d27a2sm3038128ljh.26.2023.09.27.01.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:27:45 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:27:41 +0300
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
Subject: [PATCH v4 2/5] iio: improve doc for available_scan_mask
Message-ID: <4e43bf0186df5c8a56b470318b4827605f9cad6c.1695727471.git.mazziesaccount@gmail.com>
References: <cover.1695727471.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ysY46l6I9tFYuZdP"
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


--ysY46l6I9tFYuZdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The available_scan_mask is an array of bitmaps representing the channels
which can be simultaneously enabled by the driver. In many cases, the
hardware can offer more channels than what the user is interested in
obtaining. In such cases, it may be preferred that only a subset of
channels are enabled, and the driver reads only a subset of the channels
=66rom the hardware.

Some devices can't support all channel combinations. For example, the
BM1390 pressure sensor must always read the pressure data in order to
acknowledge the watermark IRQ, while reading temperature can be omitted.
So, the available scan masks would be 'pressure and temperature' and
'pressure only'.

When IIO searches for the scan mask it asks the driver to use, it will
pick the first suitable one from the 'available_scan_mask' array. Hence,
ordering the masks in the array makes a difference. We should 'prefer'
reading just the pressure from the hardware (as it is a cheaper operation
than reading both pressure and temperature) over reading both pressure
and temperature. Hence, we should set the 'only pressure' as the first
scan mask in available_scan_mask array. If we set the 'pressure and
temperature' as first in the array, then the 'only temperature' will never
get used as 'pressure and temperature' can always serve the user's
needs.

Add (minimal) kerneldoc to the 'available_scan_mask' to hint the user
that the ordering of masks matters.

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

--ysY46l6I9tFYuZdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUT530ACgkQeFA3/03a
ocVWFggAzH/J6YyXt2/bFTdC4/7cF9pTBmmxoFHEZ9Gdda0iWn6aXAL0VVjfBqxd
0qjKQGd4iPI0Zhwq1BulAAe6+fkpaFS034VD7vLz8uMj2nGLRGFAiSdh1XV5p9xe
nIf2lFYts605GZvmpbMAbUgoXCjhUHuFlId/Az/brI86vlLhMJnGC/1GIO1tZV++
gCBY3AoycklGLNnFviVCLjt8Gkn2qPgT3ZZc5zadtKFR8rQY5q2hmlrfpdg9RpD7
7ko0xsynsMnv7XRAJxtpKD+mW6Xk/nyLwA3ENqzMjRj9K3+OFlsBm6D+bzH92rBR
GSM3U14IBVeVpFmZPAESzT4olJeAYQ==
=/H1j
-----END PGP SIGNATURE-----

--ysY46l6I9tFYuZdP--

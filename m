Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D148E7CA638
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjJPLEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjJPLEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:04:23 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AC583;
        Mon, 16 Oct 2023 04:04:21 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c515527310so21690071fa.2;
        Mon, 16 Oct 2023 04:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697454259; x=1698059059; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nDb8K3NJwk1obZ1SsU2lxQGhz5tCjrcotcdhCQHsm0=;
        b=AUS8P6ThC7Ni6xfq5vKGDZWmAprcI4E9Z2YY7wprmMw1L155luPP4Aw6Vh4SM+Y7Sb
         OrEE3hKjWPlFGxVwqUV++fTmqQhLmkbVOmc4h1Nsfl503tkMPWM9DjLxuX8l7fvGAgJT
         frEynMsxyX7/PTJvO2TWxRBeZDl8+YVL73CpUcHlKCL+K7bSrrpvKFUmqC3rMbEmaJ/M
         cLgKUMzb2zQT1UfQbGPmC11Imk7BZDxiWKZA4KBraa28N6D1imnTKG/u8YOKqnG9oyLP
         gv437OgdUr+3N24Nqgi/KrrD3BdCEHtFiL/XiM4m31WLQVXgEP5IjhEsSaRbAd2WqQhm
         QI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697454259; x=1698059059;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nDb8K3NJwk1obZ1SsU2lxQGhz5tCjrcotcdhCQHsm0=;
        b=j8hRtZbVh8izNSvLGXVhqYvks8KmAElBWX841ocN63Y9FQTSi/S0XkZmhpdRN3PcLP
         OMT5elgENw9PCKgE2ZGnLgobk1Grb+7htmAaNaFCfve5FW8gddsUqAUhcY0jZzLZnMlS
         wJCKuMAtRfkXCT8xtxcejltd6VBqxjdbTQbzVj9og+c/JG7U3Fb/Q/F4M5g5zza2e+Ml
         GUNvVkKRjp3aXpu8o42hklzpdOfnOEf9sAc2OXBlqTDl5S7IhJN5QyKT7ZNX2xIjRAO2
         RrjoLv7NHa4HnuuxMZnHcIw3PC2A8RMGUZpjH6/3dP+TKioBkxrW7LGa424AjMCiFuxp
         sALQ==
X-Gm-Message-State: AOJu0YyNfII6RC7d9tHkVo5tAGtA9lfNZDo3+LmLV2djRUugJ20qXPC7
        aspbZvO0wqeW0N3PoPO9Tg0=
X-Google-Smtp-Source: AGHT+IGIxHL+5o9bgkt0Xh5P7TXY28VMMohbmqGu7TL/OAqQtRFVCNxUeo1t6Rxc1Yb5xhc7Pk4chA==
X-Received: by 2002:a05:651c:1a24:b0:2c5:1bd9:f95c with SMTP id by36-20020a05651c1a2400b002c51bd9f95cmr3540664ljb.53.1697454258987;
        Mon, 16 Oct 2023 04:04:18 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id e20-20020a2e8ed4000000b002bfff335ca1sm1267503ljl.79.2023.10.16.04.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:04:17 -0700 (PDT)
Date:   Mon, 16 Oct 2023 14:04:11 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Sanity-check available_scan_masks array
Message-ID: <cover.1697452986.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rGz3xelvsPCuZD9Q"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rGz3xelvsPCuZD9Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sanity-check available_scan_masks array

The available_scan_masks is an array of bitmasks representing the
channels which can be simultaneously(*) scanned by a driver from the
device. Following special characteristics apply:

- When IIO is scanning through the array it will use the first mask
  which can be used to scan all enabled channels. This means drivers
  should order the array in the order of the preference. This does also
  mean that a mask which is a subset of a mask located earler in array
  will never be used because the earlier one will be picked by the core.
- Masks wider than size of long are supported only to some extent. The
  code scanning through the array will interpret the first mask with
  first long zeroed as end-of-array terminator. Changing this behaviour
  would make mask-arrays for multi-long masks to be terminated by more
  than one zero long. Failure to do so would result kernel to read
  beyond the array generating a potentially hazardous bug.

Add a sanity-check to IIO-device registration emitting a warning if
available_scan_mask array is misordered or if mask width is larger than
a long while available_scan_mask-array is populated. Currently there
should be no in-tree drivers with available_scan_mask populated and mask
wider than a long.

Revision history:
v1 =3D> v2:
	- Add patch 2/2 documenting why iio_scan_mask_match() checks only
	  a long worth of bits while searching for the end of the
	  available_scan_mask-array.
	- Styling of patch 1/2 as per comments from Jonathan
	v1 and related discussion here:
	https://lore.kernel.org/lkml/ZRvjuZaQWdZw1U1I@dc78bmyyyyyyyyyyyyydt-3.rev.=
dnainternet.fi/

Matti Vaittinen (2):
  iio: sanity check available_scan_masks array
  iio: buffer: document known issue

 drivers/iio/industrialio-buffer.c | 16 ++++++++
 drivers/iio/industrialio-core.c   | 63 +++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

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

--rGz3xelvsPCuZD9Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUtGKgACgkQeFA3/03a
ocVQuQf/eqtT0k+Bv3URVOa8Bs5kMI65qWVtogmdsMT7jTanJpZ4T4c9w4ey+dBJ
06OqXrM4PyjCai2JXFdjOTkr76UCyBZCg/wO6oEHkddXTbX1pmFrY9Xyc120S84K
8aP4RrNv0Se9H/dL5PrTdAIoqzEH6lR6Hp+Wt6apDXNRXbOgJjT+pQo8Tpn1y4cY
j/9b9RkACl7wA7aD5fHpH1lDdHwZKXFWOmz7Cx1dmhnWL0cHaBNAHCYfH6wW7pU3
l7+9PX0US+DK9+FJjgHc0Y2b8kE+GwCMTJzEyYLDt0xqiljZhV9Cy5ptshQg0nlc
+fn1hxb1vnunvwzchNl2D+MQ0klWTA==
=zDgl
-----END PGP SIGNATURE-----

--rGz3xelvsPCuZD9Q--

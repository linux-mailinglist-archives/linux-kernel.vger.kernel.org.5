Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69187A1696
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjIOGzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjIOGzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:55:37 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD96270B;
        Thu, 14 Sep 2023 23:55:21 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so28794731fa.3;
        Thu, 14 Sep 2023 23:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694760920; x=1695365720; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wLUQAZI1IJf0z26Sa3mrW7ObnZWoziopCsj/BOvrL+A=;
        b=POy51eqE6RgR+nYQHxVheC3/KEXo4T/wgDx5/292EQ4WLkJKiznBUu8T2zFWg0/0mE
         8ZmujBMWZGLzMvfWuh97DdRrru4ooTwp9EhSubpd+oMVlEphMcnXgqGhztdlQ9HbQW9d
         R+86vIT2UlnTRfq7W0LVRpzJZi1L0hsvBHsPIqmJKBFOdhewGTzzyOu+eF3UI304/syd
         lIJdeKGLm0ysY3j45JzOwidb+4++R1AuNxuK75DZLRsoBekkBXn7zehSr7oy5sME5bNs
         jfRAnXeJ6mgRrCuSieAhBNJgGvAWQZX1W8kduVNUAlixC8IUh3vDhyefhxLB6hr5AaHV
         0Q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694760920; x=1695365720;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLUQAZI1IJf0z26Sa3mrW7ObnZWoziopCsj/BOvrL+A=;
        b=bH4PEVoSCD52G3OEsc0bmLoKSNK2+znpXkJ453ITEKMeC3tQLz34vxAdnuQPkLvEFG
         0OKzVtSp/wRnsj5ETzJ3sMUoi3WPf97WClkdeb7FyVVB5a6Ox2L+ozvl8kMJaiSfu40j
         xM5uIBC9Cb0vRG/63t1IrP5ex5Id2pEkdqMPS3YI9CRt9kuAElUC4CiWM9tJOrN6FTxB
         F57pxCxCHK+Q/37hL5gsySBTRf0PG9z+kVfnsbHR1MFD3wEF4nDdnQrt55aMPA9k6vcv
         +vvZbGDVk0cE6omeqcp3qSsOfGy/wFozvek6U/kzYZwc7yBYzt4Bipnr0dh3VnAOLjWP
         Ssaw==
X-Gm-Message-State: AOJu0YzBfpIFlOqUUYx3nrV8zlum2mrV5abcmM4L3gzNDFUOoB+aCqJC
        5cZ1Diz+xDp13kAGB1rwJUAsxIBRtG4=
X-Google-Smtp-Source: AGHT+IHCa2xUJfJ3TOSTgesCkm61mYyaWL6K/zu5jtpe2osqpGmJx+MhZfRnMY0bQh46HyvH4GtsHQ==
X-Received: by 2002:a2e:8887:0:b0:2bf:7dac:a51 with SMTP id k7-20020a2e8887000000b002bf7dac0a51mr832166lji.51.1694760919713;
        Thu, 14 Sep 2023 23:55:19 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id k2-20020a2ea282000000b002bfc5c77579sm583203lja.120.2023.09.14.23.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 23:55:18 -0700 (PDT)
Date:   Fri, 15 Sep 2023 09:55:07 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Benjamin Bara <bbara93@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Support ROHM BM1390 pressure sensor
Message-ID: <cover.1694760170.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uwiU7FLUKbshnF8E"
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


--uwiU7FLUKbshnF8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM BM1390 Pressure sensor (BM1390GLV-Z) can measure pressures ranging
=66rom 300 hPa to 1300 hPa with configurable measurement averaging and an
internal FIFO. The sensor does also provide temperature measurements
although, according to the data sheet, sensor performs internal
temperature compensation for the MEMS.

Sensor does also contain IIR filter implemented in HW. The data-sheet
says the IIR filter can be configured to be "weak", "middle" or
"strong". Some RMS noise figures are provided in data sheet but no
accurate maths for the filter configurations is provided.

I actually asked if we can define 3db frequencies corresponding to these
IIR filter settings - and I received values 0.452Hz, 0.167Hz, and 0.047Hz
but I am not at all sure we understood each others with the HW
colleagues... Hence, the IIR filter configuration is not supported by this
driver and the filter is just configured to the "middle" setting.
(at least for now)

It would also be possible to not use IIR filter but just do some simple
averaging. I wonder if it would make sense to implement the OVERSAMPLING
value setting so that if this value is written, IIR filter is disabled and
number of samples to be averaged is set to value requested by
OVERSAMPLING. The data-sheet has a mention that if IIR is used, the
number of averaged samples must be set to a fixed value.

The FIFO measurement mode (in sensor hardware) is only measuring the
pressure and not the temperature. The driver measures temperature when
FIFO is flushed and simply uses the same measured temperature value to
all reported temperatures. This should not be a problem when temperature
is not changing very rapidly (several degrees C / second) but allows users
to get the temperature measurements from sensor without any additional
logic.

This driver has received limited amount of testing this far. It's in a
state 'works on my machine, for my use cases' - and all feedback is
appreciated!

Revision history:
Major changes here, please see the head room of individual patches for
more detailed list.
v1 =3D> v2:
	rebased on v6.6-rc1
	dt-bindings:
	  - fix compatible in the example
	sensor driver:
	  - drop unnecessary write_raw callback
	  - plenty of small improvements and fixes
	MAINTAINERS:
	  - No changes


Matti Vaittinen (3):
  dt-bindings: Add ROHM BM1390 pressure sensor
  iio: pressure: Support ROHM BU1390
  MAINTAINERS: Add ROHM BM1390

 .../bindings/iio/pressure/rohm,bm1390.yaml    |  52 +
 MAINTAINERS                                   |   6 +
 drivers/iio/pressure/Kconfig                  |   9 +
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/rohm-bm1390.c            | 899 ++++++++++++++++++
 5 files changed, 967 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/rohm,bm1=
390.yaml
 create mode 100644 drivers/iio/pressure/rohm-bm1390.c


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

--uwiU7FLUKbshnF8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUD/8UACgkQeFA3/03a
ocUi5gf9FQ2cEZ5N8RsOwIIThE48bc5t1JyMYWqyOpX1T0tSWiwbhuPfPl1VuFoh
q+4yM0d4dQOs5GVRPovwQU781weiP88uIMQC0qNcw3L9kGceWS2mCJRAVPx05aPr
WTX6kHpNjAAYH4T8Pq1NRkbdhvK31g/+OoDPViq483znQJsoxrxrP6pK36Jv3zCx
wcd1nMZn64jUdDbRjn51AiD4sLFU3ZH9DMz9/7IF0YFDQflXIyQfBajDFfBswtGj
pEgUMBE1VMq4tDx7NJSFco9SgzoEGF9WyxM/FS2BK7wETI+A0hnmvihc98Jqt85/
OfGDe1PHUGbI5vgb8Ug6cDWo9TQXdg==
=xmOv
-----END PGP SIGNATURE-----

--uwiU7FLUKbshnF8E--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553C57AFE0A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjI0ITA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjI0IS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:18:58 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC5095;
        Wed, 27 Sep 2023 01:18:55 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-503065c4b25so16760266e87.1;
        Wed, 27 Sep 2023 01:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695802734; x=1696407534; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+3x8vUXTH+hRGX3fxYyM/ow7F7EZ9k5o10DeJwSjcq4=;
        b=PSR5ojaGddvT2WStqShEF+rlWJXrxyKdabBR7meq6i0yuBMCkw6pz3V0aKujdV1lb6
         hYd3pf5AciAZQeJMnFQCRKlG+5g1oZyue/ij+ukSOkx8Kgitq8OdQQyfbCVFJXSjT3Oh
         Dk1cwECTKPy1JDtzpWCo3s653UhBwXH/07A+N1lvE73qSbtre3TnsrwPe4OektrFx2Px
         DPt+hnW4yf4wwLWC+U5i+HD4YMH61LcHJq9lqEHJl6rcFoa+phx7XYCSqJZEGzpeDMsz
         DBoHVayIW+lp6zwsHpeNuO8MfbEM8AN/CSftpamwUGxx0bgVsFKO8n+ITF6N87sawlG4
         0/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695802734; x=1696407534;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3x8vUXTH+hRGX3fxYyM/ow7F7EZ9k5o10DeJwSjcq4=;
        b=UBrLbp/tGRBmZfZuIpC6KGIc3dIJFOwtm0QPokqY/Pbb2y4n9Ax7Yyoi/EHnnW2jh1
         6S9NsV4I1yIfbOl6ntafIQCF02pG/fB6R+axKKnQjov8FeTjtIldtM/55JMdmo9ZhDOj
         7IrSGOi7Iqicz1MgpRoMj+QO8waNGvRR3wh+efXUupRcEa0VL6h7XjBs4JsuLD///40v
         r7UxD92RSmVL+9KCMGJG8Ka8WwTxtZ1U/UboAkAbEAwmfC2JL1Gkhp+xzJSBvroo+xnt
         akjsNO84dufIJPlCNdtcrNt5USpVdgpuTdYAy6ACcZ/jQvXqVzsSCFnQkUARVgSG4Oej
         em4Q==
X-Gm-Message-State: AOJu0Yz3ggMhIS3JeTypI4KLrxtJsh6VNJRohlooNfRuOrvUiUwqEH3U
        puyqpGh1nshweILrtA70dxRm+EE/JrM=
X-Google-Smtp-Source: AGHT+IEpHX0mNt6z5BMFuuLqTJ8UidjxgMkPm8uup8OdQ2EUIBGLEmKcUqWlzTaHcQnK9t5kfNyubg==
X-Received: by 2002:a19:5e1c:0:b0:4fe:5860:7abf with SMTP id s28-20020a195e1c000000b004fe58607abfmr1088770lfb.13.1695802733518;
        Wed, 27 Sep 2023 01:18:53 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t17-20020ac243b1000000b00502ae8db086sm2517072lfl.19.2023.09.27.01.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:18:52 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:18:38 +0300
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
Subject: [PATCH v4 0/5] Support ROHM BM1390 pressure sensor
Message-ID: <cover.1695727471.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fSwAP33zslKgzBDb"
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


--fSwAP33zslKgzBDb
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

Revision history:
Major changes here, please see the head room of individual patches for
more detailed list.
v3 =3D> v4:
	rebased back on v6.6-rc1
	dropped patch implementing the exact match search for
	available_scan_mask
	tools: iio_generic_buffer: comment on aligning logic
	bm1390 driver:
	 - cleanups and fixes
         - own info struct for case where IRQ is omitted and FIFO not
           supported
	 - fix support for using other triggers. (not really tested but
	   should work)

v2 =3D> v3:
	rebased on v6.6-rc2
	added three IIO fixup patches so numbering of patches changed
	dt-bindings/MAINTAINERS: No changes
	bm1390 driver:
	 - various cleanups and fixes
	 - do not disable IRQ
	 - fix temperature reading when FIFO is used
	 - separate buffer and trigger initialization

v1 =3D> v2:
	rebased on v6.6-rc1
	dt-bindings:
	  - fix compatible in the example
	sensor driver:
	  - drop unnecessary write_raw callback
	  - plenty of small improvements and fixes
	MAINTAINERS:
	  - No changes

Matti Vaittinen (5):
  tools: iio: iio_generic_buffer ensure alignment
  iio: improve doc for available_scan_mask
  dt-bindings: Add ROHM BM1390 pressure sensor
  iio: pressure: Support ROHM BU1390
  MAINTAINERS: Add ROHM BM1390

 .../bindings/iio/pressure/rohm,bm1390.yaml    |  52 +
 MAINTAINERS                                   |   6 +
 drivers/iio/pressure/Kconfig                  |   9 +
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/rohm-bm1390.c            | 934 ++++++++++++++++++
 include/linux/iio/iio.h                       |   4 +-
 tools/iio/iio_generic_buffer.c                |  18 +-
 7 files changed, 1022 insertions(+), 2 deletions(-)
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

--fSwAP33zslKgzBDb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUT5U8ACgkQeFA3/03a
ocXQTggArZYjJmcqpldv5kUoB8oC4OFUOC5FE/+rvhGYHZeZp958xTZY+53A6wdL
9kedZhSCM8MFObWkCQdG01NcEoD1tdJ1ISLee8BBNzGM9o8I6Y5DG4T0ptNCx7uw
6//SY0oTUee2MEtGOYHWsms8VG57OBh4qW2Uv0vSCDiTQ2YyO+zFVdYJCJQzRCC3
C6x5JMv+OiYx1wtM1zPwAqV+uK8/IO+48b3amVd2tbYpfrGBmOO3lIz3xy6i43NA
AS7kJNrHZSvKRyhyeLCEKxuO3iFIl5HHpjo+fgAppajsd32oIfXfnzDwKe0ONpJi
VEKr2DqZK0K+n1EQ5ttDAI5hgEv+Fg==
=yTSK
-----END PGP SIGNATURE-----

--fSwAP33zslKgzBDb--

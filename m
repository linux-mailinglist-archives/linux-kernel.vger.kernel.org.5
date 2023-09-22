Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8377AB05B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjIVLPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjIVLPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:15:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6D1AF;
        Fri, 22 Sep 2023 04:15:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5043120ffbcso2420894e87.2;
        Fri, 22 Sep 2023 04:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695381304; x=1695986104; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12f5yyT0VcPpXHLkpH7MFmQ/cCt4mwm5CuEcr3HwBqw=;
        b=HCd2tLAm3gJbK09WMZivh7k3m9MrWocOE2xYG9S3LiIWV/xoMHdDTQYk72ioIvso98
         YXHh02qNOI8ALYZgbvwkbiOB4b4dC7qLZCA3Qjn30vZ/HheyjvwtatgUdXto7vf23WTb
         wV9LmgppYzT06cMcpMFuWoRhe8EqYzeCaXaaK2Lezkqe125yh36veH905bQo8i7K1yED
         lhfJe4XiwSJzF6NpUUBw6hzR7JS9OS1tjXwTddlj4r/BfIE2KeGmRnFI7Sh/IXu6lMcz
         jh5xyCt8fpkupC4P0kiR4mFYshUbmCkqLrdYb2JmIPYCc++fqAXwlKlOpaZW1qPkHgf9
         zoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695381304; x=1695986104;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12f5yyT0VcPpXHLkpH7MFmQ/cCt4mwm5CuEcr3HwBqw=;
        b=Xq16ot0VQXtJQaBovYEt1rA1xonZjLD3iQ1bTXoI0HB4FidpXBFSR1zBJ8xpRXpFK5
         2UEb3V3jJj9BNb9m3WIuGKGoaA+CjVluIFQPy21pP1dUoncZCnsHFnM7TgEMrXu1W43q
         FfucecRYi7+l3CNgtsYsqBPmAAUBXs24HDB0/ZdsBs3YoI6YcCNqx08FgnW4W3vAEwDT
         KtDDNvAvMRI5Hx444JdLCgw86pVVWqooJqKFnKt83rv96lfOgNEifYj+dkGzoCnASq0r
         N8/WdnpUTs8auof20JtHTJsjBlzp+IbtUlESa4w2yxhQJcfpgkxA9+4/Rm25CCUNholo
         L3fQ==
X-Gm-Message-State: AOJu0Yxsohpj/JXsHX46CWdPv1nZy3SfjZkztAVrTY4HijRKGYxz/727
        dIFgJFzeHhn1zyBc5uwdDos=
X-Google-Smtp-Source: AGHT+IGTsCyYllBO4l7k+xEQT18giXRjSmXex4cYTRopU2IrAJdzJXSNvDpxxwYoljSAmGj/H0Be7w==
X-Received: by 2002:a19:8c14:0:b0:500:ac10:1641 with SMTP id o20-20020a198c14000000b00500ac101641mr7174543lfd.46.1695381301847;
        Fri, 22 Sep 2023 04:15:01 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id c11-20020a19760b000000b0050338c5c1f3sm690352lff.14.2023.09.22.04.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:15:00 -0700 (PDT)
Date:   Fri, 22 Sep 2023 14:14:52 +0300
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
Subject: [PATCH v3 0/6] Support ROHM BM1390 pressure sensor
Message-ID: <cover.1695380366.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GWs1Q0lOeljR7ll2"
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


--GWs1Q0lOeljR7ll2
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

Matti Vaittinen (6):
  tools: iio: iio_generic_buffer ensure alignment
  iio: improve doc for available_scan_mask
  iio: try searching for exact scan_mask
  dt-bindings: Add ROHM BM1390 pressure sensor
  iio: pressure: Support ROHM BU1390
  MAINTAINERS: Add ROHM BM1390

 .../bindings/iio/pressure/rohm,bm1390.yaml    |  52 +
 MAINTAINERS                                   |   6 +
 drivers/iio/industrialio-buffer.c             |  25 +-
 drivers/iio/pressure/Kconfig                  |   9 +
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/rohm-bm1390.c            | 930 ++++++++++++++++++
 include/linux/iio/iio.h                       |   4 +-
 tools/iio/iio_generic_buffer.c                |  15 +-
 8 files changed, 1034 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/rohm,bm1=
390.yaml
 create mode 100644 drivers/iio/pressure/rohm-bm1390.c


base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
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

--GWs1Q0lOeljR7ll2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUNdygACgkQeFA3/03a
ocUr3AgAr4DSyXT3RXXG1SAtclZKpXISF6C1bGtCrCBsAKCPLTSrvI6q+GQJemz9
+49PimaiU4H0xqgkcveRIP5AYLcPIhh4tnVnbechXWlOLATvpm9wruryNRWoA/2m
jDjyCbhuzDNyCkb/kCqh50EOPG8FFgWQ2UdscMyNYCpgghdupBM8bRWWJ2fy8oX9
WBk3WH5tWunFkHi46Kd0KAN/dEi+7MzmqT8U0BYZYzb4UfHrre9lFlX787vn/vIG
JIsQueodkrSLQnN/aIoMHKqNDjsTPn4KaFeVrrzrZkZ8AfkRIoqVP3ESU2iZ9Qay
AD5mETRtGZ/smsQd1a+iUcGlOOlGfA==
=+Mnu
-----END PGP SIGNATURE-----

--GWs1Q0lOeljR7ll2--

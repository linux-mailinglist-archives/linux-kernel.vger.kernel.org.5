Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EF6793CC4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbjIFMg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjIFMg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:36:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725B4171C;
        Wed,  6 Sep 2023 05:36:54 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bceca8a41aso55668551fa.0;
        Wed, 06 Sep 2023 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694003813; x=1694608613; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYvzf03YqecQCtZTCL0bWpYSy2s7Z4Fa4sz1ABBRHMM=;
        b=SoUYFgn6+EHW/N3IgOoO9bkcPeLFAxAbVRFGAipS1VOCE4AZIRPbZ62GCSjm2icgmz
         55layHRloGMgn4VvW2wL/QG+GmPephYk+Yp5utc1vwg774Jb4FDCPn5ZgVerKkzAo8XY
         1ZiqDw7aX00KhPUvTScQetRIQOzIAT0Z9XPTw7GLyys3ldjSMC+KZGQVJG71faIykVVN
         pblIxyPBLIrNvG9er5exiP7ES+P28XZx/rU6qm2BQcPzCzmzkGWD3YBDxpFVwHYmcH1Z
         8CLlVJ7ZyFVQrFsNC6YouxF9N6rBgUe/doKEGeqUp/ss3iedXtVouA239sCBMz4zF1dS
         Bc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694003813; x=1694608613;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYvzf03YqecQCtZTCL0bWpYSy2s7Z4Fa4sz1ABBRHMM=;
        b=amWuTO5ep0oDikW3ITslaZ3G2UY2YCItemEUKjfzzkWMUeysDftrBbCjpe707v+Rdg
         bGwlEPxshEjv3wSLHbTFciZ0XgwGshJlv/I1xsOXxOXPxg4UEHq29WDC7zVotMxCqUtx
         ogMaG9IWuL5wr2SdiUNf9+zuik6MzIB6c4wTFPVmaCa9rOgNo3/E5q7jVt6LZ6FCagel
         NqEGaWcKsTxpUkkWW34MWrSFaSxjDwIz6kbsKYf7asBzA0FBkn1WBo8YH9eKdiIRf+Az
         sbl+oBxAfEm4hK50/QvE7OtlCq+BWlr8iCJ8dqa7a5PjHspDCZLXbivUYPKhMX0t/Cp9
         w2hw==
X-Gm-Message-State: AOJu0YwD168fnGhHGw8wUsJRwamFWEstIgAB2P/bM0We/zPsz36WBEVo
        NfJIQK5jR+hTq7DAKeKBR8s=
X-Google-Smtp-Source: AGHT+IGdTSaEthamaVjn/54BDzKGHgEN4k3YI3rK2BSG/B8X29U+0rCNZRHJJ+PyIOSr4dL2Z+638A==
X-Received: by 2002:a05:651c:1214:b0:2bc:f39b:d1a8 with SMTP id i20-20020a05651c121400b002bcf39bd1a8mr2272623lja.46.1694003812353;
        Wed, 06 Sep 2023 05:36:52 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id h24-20020a2e9018000000b002bceae8b9fasm3285094ljg.109.2023.09.06.05.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 05:36:51 -0700 (PDT)
Date:   Wed, 6 Sep 2023 15:36:43 +0300
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
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Support ROHM BM1390 pressure sensor
Message-ID: <cover.1694001462.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9EvZjNHDEQk1gQo8"
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


--9EvZjNHDEQk1gQo8
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

Matti Vaittinen (3):
  dt-bindings: Add ROHM BM1390 pressure sensor
  iio: pressure: Support ROHM BU1390
  MAINTAINERS: Add ROHM BM1390

 .../bindings/iio/pressure/rohm,bm1390.yaml    |  52 +
 MAINTAINERS                                   |   6 +
 drivers/iio/pressure/Kconfig                  |   9 +
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/rohm-bm1390.c            | 944 ++++++++++++++++++
 5 files changed, 1012 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/rohm,bm1=
390.yaml
 create mode 100644 drivers/iio/pressure/rohm-bm1390.c


base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
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

--9EvZjNHDEQk1gQo8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmT4clYACgkQeFA3/03a
ocUxhwf+NDchSYAOou6z94pkXu1dCe92/1S1hsKqODo1x9ktS7bBGKlBfzzucKeZ
uWZX+Lpu/5ga5azop2P3bG9NuiNL5rIN0MTW1uHIczT/Ib+u54jStuCgHS8w4DGn
FTfabM46/9JKBeUoaJX6WDXcOX9lJRsR4hx96pzTZLC2ftHWOnvU64bLE3nO/mFD
7dcJ8flFNE/9ayn8LXj/mIn2JNVMTSsdXG01LNnzc7YksDhZ+NW+P4pt98f6/iw+
Vp5Gxfmy4piJngmszKUnYcLLsql/kuZ1Y23FfzFpe+g9eUGrti9TJyMUUzZ5JkQA
PpJEO15krN5yM5FAIiptbR4twK9CNg==
=23Jn
-----END PGP SIGNATURE-----

--9EvZjNHDEQk1gQo8--

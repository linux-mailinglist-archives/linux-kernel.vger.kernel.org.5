Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4597B1643
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjI1IpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjI1IpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:45:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32606191;
        Thu, 28 Sep 2023 01:45:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50337b43ee6so21007016e87.3;
        Thu, 28 Sep 2023 01:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695890711; x=1696495511; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXRzbOod1k29U08n2WanP1cWUIg2W+KT9BSDqPF5dHk=;
        b=WqWNPS35F8oCvT4LsJVKMOl5EMg1JNwYVXQB7K31Q2cP4jTtrVgyO2Q4JBvbcwvmRz
         wlzbngIfzoGW0T2BeZof/4R3jCg4w4FNSCoxsZtUYccHq0EwnZI2HUSE//azIJ815SaQ
         osdDn3K80r13J4q/VZ6N6w7tDKHZ9r6tpx+3AyeuvxZGy4muq8u5JenWjITh8inRtYqC
         SvuCaPLQZkIkj/Oq5JMpXMBvJ2pFAzlAV7CrYc6sNNIbfkftpHjljN+qZd8dK8Z8ALkm
         OI0nooVfaBV/pm+WYvLkEnxfYjYwD2lPJ2HU5Ka24w1h7HaK0KxUoYfyRBcReJuBIepv
         HCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695890711; x=1696495511;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXRzbOod1k29U08n2WanP1cWUIg2W+KT9BSDqPF5dHk=;
        b=glw2PU1R8MQbiYvDcKiHD/TFS43bYjVDgkBfZiWCwyZZBFv3Bzq8vGfjHXS05RHN/V
         kyeNIaPph5Uu1fxz36ThsFdStLnbB+LbT35j5pb4Jf3Aadt6jJ0tzkxo7pqvmJKgxQr/
         wUjVDkBOjlx2psqZN+Pl/qpypTMVfcgjrWh4KMFo1bt0yPwHy5ffY/+hvW5k+hjdQ8hb
         1PMaW+Mw69LomHPAmW9WR76n75SV73lVQfxw4vVXZaVQjZMyyH1rRWYFVOr+dcWbdq7c
         +41ZB5RG9kXpwXRpXH2Zu8aYTsvhhb8RZO3cEtD+w5S3yvZez2m7PzDRNhvuDzQ4A7dW
         ZNwg==
X-Gm-Message-State: AOJu0YzXUQ6hH/faKQbghjsK+qSFIdQqjkkqPKILR9WXFFRLmFWxSV5q
        bLAn9zvCsBAyk4TPJfWQxnSrL6aU6Zk=
X-Google-Smtp-Source: AGHT+IEakEU7gR4hrb3rL3XoYibY+UWcnP5aQelDicRTRsAlzLhyA2QX0J/aEPGteRE3ptj4w7ATDg==
X-Received: by 2002:a05:6512:3e14:b0:503:446:c7b1 with SMTP id i20-20020a0565123e1400b005030446c7b1mr725623lfv.40.1695890711050;
        Thu, 28 Sep 2023 01:45:11 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id br36-20020a056512402400b005048f11892dsm352438lfb.171.2023.09.28.01.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:45:09 -0700 (PDT)
Date:   Thu, 28 Sep 2023 11:45:00 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Support ROHM KX132ACR-LBZ Accelerometer
Message-ID: <cover.1695879676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SZzqwfzT38be3ABV"
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


--SZzqwfzT38be3ABV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM KX132ACR-LBZ is an accelerometer for industrial applications.
It has a subset of KX022A (NOTE: Not KX132-1211) functionalities, dropping
support for tap, free fall and tilt detection engines. Also, the register
interface is an exact subset of what is found on KX022A (except the
WHO_AM_I register value).

This series adds own DT compatible for the KX132ACR-LBZ and also own
chip-info in driver to allow handling the different 'WHO_AM_I' value.
The separation of the Kionix KX022A and ROHM KX132ACR-LBZ does also
allow adding support for the KX022A tilt/free fall/tap engines which are
not present on KX132ACR-LBZ.

Revision history:
v1 =3D> v2:
 - Add KX132ACR-LBZ into list of the supported ICs in Kconfig

Matti Vaittinen (2):
  dt-bindings: iio: Add KX132ACR-LBZ accelerometer
  iio: kx022a: Support ROHM KX132ACR-LBZ

 .../bindings/iio/accel/kionix,kx022a.yaml     | 10 +++---
 drivers/iio/accel/Kconfig                     |  4 +--
 drivers/iio/accel/kionix-kx022a-i2c.c         |  4 ++-
 drivers/iio/accel/kionix-kx022a-spi.c         |  4 ++-
 drivers/iio/accel/kionix-kx022a.c             | 34 ++++++++++++++++++-
 drivers/iio/accel/kionix-kx022a.h             |  2 ++
 6 files changed, 49 insertions(+), 9 deletions(-)


base-commit: 5e99f692d4e32e3250ab18d511894ca797407aec
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

--SZzqwfzT38be3ABV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUVPQkACgkQeFA3/03a
ocXVNAgAlpwCcKqDlv5z9X1v2BLIort/lCMQvDRSsaWodpadCZLF9xzusLG9ugkw
Zy6f3cMNBNAzd7N2Vr+AbacDQJ6LZyyuNrdmqcghPRRahhRn5hRrNWfxIRwJ5OKo
HUtMN2zhhQ45N133rEvEiktSHk9tX1c94PbGFkG3ob1vapqjilqdKbevLzg1a1+q
MjNBvm1ag0Bsr2gQSC4uy9ci1A/a2OueIivdMdFhJnr476N44ZhnGpchvY5FctUt
JldHU4mgPe2FSPHPFWoz6/kQ+hQnRfP70p01mTt7vT0nk8DZgyd/+yXv7rOuEuB2
jXF1vaB0qP+7JJpBBB4j+Pz0ZoN+vg==
=2E5S
-----END PGP SIGNATURE-----

--SZzqwfzT38be3ABV--

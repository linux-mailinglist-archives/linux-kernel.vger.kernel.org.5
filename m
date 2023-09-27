Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC6A7B04BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjI0M4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjI0M4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:56:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34147F3;
        Wed, 27 Sep 2023 05:56:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5046bf37ec1so8419627e87.1;
        Wed, 27 Sep 2023 05:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695819363; x=1696424163; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0x06RSY7/Vq9q7hdrauvpq/UhEcx6nGlRRG9za9o8+M=;
        b=IGDCJPmVLdoyvSZrUqrf5D0Y3w48BRbk9FonVkX9GJHbQ5IfHIO4VP923JVRK4mCNz
         iEXYId7AXeAxWrLc3RbpX2whYir8qXI2lNXYNlmHJ3umgZWlU5Ctr8KsDbEtJ3MACWA0
         U5Y8lMaNt9sUq6yLMJvuErq/d+GKIPJRXvH1sOeK4HO5ZL3jRbjCNytTd4Pi9dMogAUd
         Vg2AMyP8N/wfkWLaSQQXVzX1pKvxB65+ORkB5lWiDh29hCl1jG3ygKfIelK0Gapc4sK+
         gepZzv2HXQN4Qmq0R51O7+0pasxB64GMMy0vsm/yANMq5jfpF/vJF9zK//kV/blxpxCN
         g7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695819363; x=1696424163;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0x06RSY7/Vq9q7hdrauvpq/UhEcx6nGlRRG9za9o8+M=;
        b=RcrhFY3nG9vTisl+rOMZ5XqnfKPTVzrponNoSIbMLD3SzNeKw5pmYopoIQid1q/DMp
         jSAWepVeN1R+8NUi/fQixm/Z49akyL3wIF2d3YYVarTUdi+xpglD9HQoMGnvfhiaarGl
         s3rCo52q0IkThDJh69XI6MbhvLnGiU56s6HENfW5bzlCyenMnvm3NEHoWcVi2vvf5Wf7
         y3QZurTwQYOyOz0JWWRnaPTlrvgAJ+6w6Djitfr2kolbomAi1h8xTe2d2uLSzh1GKt1/
         qRTjVHdQJ/vQa+SNJxdN0wTFYKZZ0EpzgkT5UeOP8lZ+k9ntbPFmGbwh1qeSeUJvou9b
         VHbw==
X-Gm-Message-State: AOJu0YyT9PyXyxjzq9zqUZVqz8Du/v2SlTm2NzECckgHfsnR+QtEqIL4
        ZhhaIdwmBqIyo8Q/vvdFR9E=
X-Google-Smtp-Source: AGHT+IH82iz5fs1Vc/NcXc83wSQz61KS+Jr/dykoPfkqok0zfupCFLdGpDbALC5enYwAj7hhFZ6LdA==
X-Received: by 2002:ac2:5315:0:b0:503:385c:4319 with SMTP id c21-20020ac25315000000b00503385c4319mr1631981lfh.19.1695819362778;
        Wed, 27 Sep 2023 05:56:02 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id v4-20020ac25924000000b004fdde1db756sm48045lfi.26.2023.09.27.05.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 05:56:01 -0700 (PDT)
Date:   Wed, 27 Sep 2023 15:55:45 +0300
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
Subject: [PATCH 0/2] Support ROHM KX132ACR-LBZ Accelerometer
Message-ID: <cover.1695819243.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v9JK0SVvtbCzYQYP"
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


--v9JK0SVvtbCzYQYP
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

Matti Vaittinen (2):
  dt-bindings: iio: Add KX132ACR-LBZ accelerometer
  iio: kx022a: Support ROHM KX132ACR-LBZ

 .../bindings/iio/accel/kionix,kx022a.yaml     | 10 +++---
 drivers/iio/accel/kionix-kx022a-i2c.c         |  4 ++-
 drivers/iio/accel/kionix-kx022a-spi.c         |  4 ++-
 drivers/iio/accel/kionix-kx022a.c             | 34 ++++++++++++++++++-
 drivers/iio/accel/kionix-kx022a.h             |  2 ++
 5 files changed, 47 insertions(+), 7 deletions(-)


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

--v9JK0SVvtbCzYQYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUUJkQACgkQeFA3/03a
ocWAmAgAgW89E5nHGv7lJWkqt+qkY/U/jUxa3TXfUqQtzdBWm2tnI1Sq6+oQ9T4M
AQzmGfx4PPb91eB4KDK2C/ZW5B7B0d+RxlbiUHqA2yTGuocRruedJg7sdCOxA6aR
U+aJcurYJ3Y/p4HWTgNoJ3z9BXPpm5qHoIdrlhP5va0jOTeixcvoWL4Ib8K2Gcio
UiEXffcmlPuu8rq9gTNI7/OVp1MiDZZh3Z/4ynWXzUZLGluGEBLt/SmuxTjphZnh
hB86T6LOfYannQRi1MfJFP7VZj+ZyjONBrr4NiMWDxuscm0D9Ym1WVsxGO2smMW3
TxTShJKVhzz8ok4rBLGUqdnjCG78nA==
=Gs/n
-----END PGP SIGNATURE-----

--v9JK0SVvtbCzYQYP--

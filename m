Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7A17AFE68
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjI0I3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjI0I2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:28:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B30CC2;
        Wed, 27 Sep 2023 01:28:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50481a0eee7so658910e87.0;
        Wed, 27 Sep 2023 01:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695803314; x=1696408114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7zhhw4X8ZguuIp3bguxfu5i5tsDhNfMkVLJ+Koc92Gw=;
        b=e34iXVtNOQkwKzWQQKno3XWihOfawzm2qpckjMzeKhWNLBs4O1MdFdBABV12NgmulR
         /8cvOPK41vK3f+su8L8feFz19BPMCq1UoBmmx0AH5JAZe7n2u7GJcmQ/+g7xAjjuuAXP
         v+TW0n045gN/Ei1wqtQdPZCdSUauK+7l/BTIy9tkazpP+bH7T+P+4Iuc3Lj518QbN2l9
         LtZo7pd4vSt++YsYTkVHZp/UrRZqFqoUU1n/uhhpj+VOfQ0l6lUa0etutqrLtGuBL8rd
         D0LKjZduyQ6jS30Aidd3AQdRy8ZubDgbLq2ZOZMXSVpAhefXQUtfZ8BqrQ2P1pvaNbO8
         Ut8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695803314; x=1696408114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zhhw4X8ZguuIp3bguxfu5i5tsDhNfMkVLJ+Koc92Gw=;
        b=Fln/nS6EvRRTwh0+aaW2K3ATWoIwvnGeEAjlvg0ZenK/V5VjZ03cBHr9ojwDsZEMSW
         E3ZTWmQiPGgXSqDw3Cc1TED8nkcwHOBYhxcUbfADhiELZrIe2btmynn6Oe2Dxo3GUPZ6
         0eUpoww3bFiAYrPxPdW3kYK0iplwJap3f3oDpZL+JDWwjbssjZPe1Tohvhx1nWWS5713
         jqL8TeXCo5tAI+x9aC1M0m5s8MstVM8vCFgwaz7CB87ZT3f/E5NJgfPF5P1TUn2giQUG
         Ne6hAZ0i5YTGQkBAGakZL/4aTlSxI3xq2m6YcYo5y0KldlvzU6omViulSD3WZrwAcI9K
         EprQ==
X-Gm-Message-State: AOJu0YzDXURqwi9zhpqvb/zH5NOKyXiH5jC2Q2HsFHYQTIRBgIaWaz65
        Ues41+wFo9EMA1F7zwiXQyU=
X-Google-Smtp-Source: AGHT+IFQ9Gf9AAMsfGRzuYRi7vpSf8rhVXCql4gfGy/88l+njwxiSFUT4EFW2jeppFk5QCtoBFDmaw==
X-Received: by 2002:a05:6512:31d5:b0:500:7aba:4d07 with SMTP id j21-20020a05651231d500b005007aba4d07mr730914lfe.22.1695803314065;
        Wed, 27 Sep 2023 01:28:34 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id w4-20020ac24424000000b0050332394bcasm2520557lfl.150.2023.09.27.01.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:28:33 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:28:29 +0300
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
Subject: [PATCH v4 5/5] MAINTAINERS: Add ROHM BM1390
Message-ID: <fb19d3027ac19663789e18d4dc972a5dac0fde74.1695727471.git.mazziesaccount@gmail.com>
References: <cover.1695727471.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d2INkxLnJdFZYeaJ"
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


--d2INkxLnJdFZYeaJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add myself as a maintainer for ROHM BM1390 pressure sensor driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..91390f571a05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18563,6 +18563,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/bh1750.yaml
 F:	drivers/iio/light/bh1750.c
=20
+ROHM BM1390 PRESSURE SENSOR DRIVER
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/pressure/rohm-bm1390.c
+
 ROHM BU270xx LIGHT SENSOR DRIVERs
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
 L:	linux-iio@vger.kernel.org
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

--d2INkxLnJdFZYeaJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUT560ACgkQeFA3/03a
ocX/FQf9ENV6YHI5E+I4qxBOq/pDVzx4RBBu3l+4115A0HRFa/w4AwCH9MQ6uyyn
SdwPizq49RJvQs3b6vWIHJXsnJtPrAp5fwXGtwBaNnVbCD/uWKskF9+UimiEUV+s
Y5STqksC3QRlSrAFQ1OSriU/h9qw/oIJIP8vF6zS3pmztwM8ECvtpNsKfjKdbQsB
GYtoxVnGRoc3M7AW0QXtkWOGAn+UwGimBrE/8KdR8MiNhdn9ydChMHJeKttqQyrb
uYR7Dr5d3BFOTyrsob4iicCCtq3kt44q5HPHnAj6LkcpZ9l6uYkGrQh9vqoZUHrZ
Arg/kEA8bb+YRKalaT5VT4lNU+I2VA==
=/njF
-----END PGP SIGNATURE-----

--d2INkxLnJdFZYeaJ--

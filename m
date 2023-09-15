Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BA47A16A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjIOG5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjIOG5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:57:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8612717;
        Thu, 14 Sep 2023 23:56:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50079d148aeso3049415e87.3;
        Thu, 14 Sep 2023 23:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694761007; x=1695365807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MeZKWp0Orf/6vVsLqOgOvydscuIuBOLwH+cYF7rvP0o=;
        b=f8htH2mTb8Hs+66YwKL2Srb+DmYAIyVnk5Wos+UPTEFMyr4AZxCwjLHFozCTEzJTBn
         HunLHYLaZlLHLTnCdR5TnMZicMvuew/Mz2bwts9ChuoQwAaZbaF85O6TszYHJR32QjLX
         zt//SPttZmycKIWsJxN6HdocUHj12rn4+rYz0/DiCiXPoQkfZkzv8MKFYMI99vMQQI/l
         iGd2OXNPYGsXolt/m8cR7CB5S6pEZyII2x/CTscd/X+6JopTQu3xmdvBntJ0n3csjhoA
         LnSe91ozKju6eFp1YOryEh0I7buBhhgODPj9zC0r2ezbyO1KiGjmlQazrdulWq39+2/K
         Jokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694761007; x=1695365807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeZKWp0Orf/6vVsLqOgOvydscuIuBOLwH+cYF7rvP0o=;
        b=G7yJImYOHG2L0DbrtumjsTxWwerE/tFnuG9OHmNRjbaSN3hfRv/GhjDtkZgA6EpTPg
         BXQwk7BNX/VNExcfUxFaPG9xGGIC3GFM/+8/0gtERNeSly5T1Qa/0gadfMVFwRnl9Suk
         JCsxjkKDZQvo9j/n+CGnYMrFurbIyE12HwGweRN4ZQLzw0W81Zu1CIJCAuqLhTcfoeuw
         iAWfj1nuRnSPmDZg1iKnVfoyd7IWjMmSIOlu6Bx70DZepAf/rjDdMcKrlb2VME7sG+8N
         fRKKT6KyYot7dMSJ3GwMNG71Odul6yxRCNc6Lxsq4oXfVAO4R841t0cGUAUzV2rJvtrZ
         5X4g==
X-Gm-Message-State: AOJu0Yy96Afa0uUJ92ncHGmTtfdN846de55w4RW9mXy838XpYX3GTY6E
        2wJ/w+rmH8n90gC5Z3SJ+Jo=
X-Google-Smtp-Source: AGHT+IE9Mjci7c4mVGoy3/H6Rx6GHAPNmnUB2GBHgeEo29EsfvSoDiFiFKhZVVOafIoDI0XKy0l1ZQ==
X-Received: by 2002:ac2:4f16:0:b0:500:9d4a:8a02 with SMTP id k22-20020ac24f16000000b005009d4a8a02mr917943lfr.62.1694761006659;
        Thu, 14 Sep 2023 23:56:46 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id d6-20020ac25446000000b004fb78959218sm535808lfn.200.2023.09.14.23.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 23:56:45 -0700 (PDT)
Date:   Fri, 15 Sep 2023 09:56:40 +0300
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
Subject: [PATCH v2 3/3] MAINTAINERS: Add ROHM BM1390
Message-ID: <64add46e9ac39e9d4a247eb70aeb25de8f399698.1694760170.git.mazziesaccount@gmail.com>
References: <cover.1694760170.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V4RmuZANNdioRVWF"
Content-Disposition: inline
In-Reply-To: <cover.1694760170.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V4RmuZANNdioRVWF
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

--V4RmuZANNdioRVWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUEACgACgkQeFA3/03a
ocWDvAgAtJCKkEcpE5LcrXINzDOhkAB/yrqOvzUoyssQQZUF+4soeZ+Sz9cuWc/e
wVU9ECKMF4b9hr9al0Ejyce99QN8q0gGuKg6kT8DvCxxffuvBUQkVi1UW2R16DYh
i5VavgB4UQny6D32CCdGYO+Hof26Hyr/5S/Bmy0iwQXJpYeXCwzlumZooZ4iHe4e
YSUQ3+yqtnuqR5qrrPwXbnfivz/x+6X7IuSuy4pLQP2CZ1sM4K7rP5l+FqoQSAdu
nDFTaB9VCvzVBxJdvPYC6Sb8HMn5iiEa9EeMEFO9w/PjCxc7fpDlj20i4z5ahgM6
sv/pfkixHvaDZUmHmqf/0O9psmKf9Q==
=yLJN
-----END PGP SIGNATURE-----

--V4RmuZANNdioRVWF--

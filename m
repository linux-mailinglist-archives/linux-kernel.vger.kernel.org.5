Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C02F7AB07D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjIVLUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjIVLUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:20:15 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5977114;
        Fri, 22 Sep 2023 04:20:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5031ccf004cso3295516e87.2;
        Fri, 22 Sep 2023 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695381605; x=1695986405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRymrfE4yB8tdGehYp9F/ITBlEhDiwdFyq3dADysbRU=;
        b=bdvERPBChI5PyrbGo3M9BilF6GFzC4W4afKuRVIJQEoIWe5b2pRu231mASueApXWqV
         KCSPNC7HIObqN2HVpBWwt+P+DH8GA0JM3j/P9HzH4uOA4oNUcrYZC0OTDj5x5w/Xk39F
         ZdQgAGW9+YkYCpjrTSjcsgX9V5l/BYsVthKhZHDFuXSFTP4YkZX56aShZ1ifkIqqasXd
         nWXj2/ExF8M3sik5vvYfc1bH4QEQyRxm/JadncoWV1+/LgLZivlKo/D6cx8z5KRQX0OX
         Z28AgtAs6t2zIQPzxBtn6KLzho7+hBdsAy6ShF7xXqfC/apElP+CzUDnOcgQdkhSQFJd
         HRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695381605; x=1695986405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRymrfE4yB8tdGehYp9F/ITBlEhDiwdFyq3dADysbRU=;
        b=MJ6AgKuWCfLqBba3donk1KvmI92pnruqz6kSA88ozq3M8OFdEUqoDXH1jmjXmT7/lD
         wR14eFCRh1yb+GRUAfu00XC8P0lEz9UidyhcMeF7GBU03tOPMqhA9PTDfNFF0VvQg9+1
         HYTF2ug7Nl2QQeCGZM2N8m2SX3W9cXLEaRK7GDr8XF5VI54nsN2JALWe6zsvUW6i6RtE
         NiqE1tRXMR7dub0VchWBK9N/ESfktu8oTSjgJ27wEKmLbs4WvN/sas7lOZ+uieIDC6gp
         8C06nT105bBvXjOp0QGWcAGniDf7z5DFHhb9F+e7RzRU3zRzA3Y2N42El0uvMxmCA3ZG
         2Nzg==
X-Gm-Message-State: AOJu0YzCXh9z/JDRFDMWH8k09tvpX2bFOLurekd9+fd/bHtETV0Mt/Z1
        ZFBEaB5sfMqEUQj+7xBj3HY=
X-Google-Smtp-Source: AGHT+IEYq8SCIlbr/oE6E/c3XpFOUMOi+izbxyact74TSQWABtdV7BROdT2u5SAtQBEEfgLwki/VMw==
X-Received: by 2002:a05:6512:250c:b0:4ff:9bd9:f69a with SMTP id be12-20020a056512250c00b004ff9bd9f69amr8508375lfb.65.1695381604906;
        Fri, 22 Sep 2023 04:20:04 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id n7-20020a195507000000b004ff8f090057sm690096lfe.59.2023.09.22.04.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:20:03 -0700 (PDT)
Date:   Fri, 22 Sep 2023 14:19:57 +0300
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
Subject: [PATCH v3 6/6] MAINTAINERS: Add ROHM BM1390
Message-ID: <3231287865a48ad158633c0af9b419dd78492e59.1695380366.git.mazziesaccount@gmail.com>
References: <cover.1695380366.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ljt+Oz5WvBZ2HxBR"
Content-Disposition: inline
In-Reply-To: <cover.1695380366.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ljt+Oz5WvBZ2HxBR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add myself as a maintainer for ROHM BM1390 pressure sensor driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf0f54c24f81..2f296320d642 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18562,6 +18562,12 @@ S:	Maintained
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

--ljt+Oz5WvBZ2HxBR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUNeF0ACgkQeFA3/03a
ocWoCQgAyuXqyh2FPi+SYOKkTqETnNqe87udgYaUX8EbBiGnUTZkr8mFTPtX0kR6
n5PI//B22nlcsbxK5buNCmy8f6Ik3S95CHanTxA+o2GyTKnAPqaPyRXW1c+T9Sb/
ko/tvKKB1Ac1TbNc9Qu94pCFtg/TUa+sTNrXqQCZ7WrX4RVfB/w1mc7CpRg0yj8H
DIlt0POr0u/LzpYNUnU/JTs5j9FArAQpY5N/g5kdQX9H+7US9canJioUbXWlH0Ry
lWxfMeIa0CrVAJRfLDlZbQ0Iggic2f9r1LHkPhS9TQZ0l59JN552fKlOyiJxTGc9
0egjJobQFVtbsoL4SSkwyhS8RpkfXw==
=zvIo
-----END PGP SIGNATURE-----

--ljt+Oz5WvBZ2HxBR--

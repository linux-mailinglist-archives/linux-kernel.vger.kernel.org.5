Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E462793CDE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240738AbjIFMkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbjIFMkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:40:36 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B003D171C;
        Wed,  6 Sep 2023 05:40:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-501be2d45e0so2983155e87.3;
        Wed, 06 Sep 2023 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694004030; x=1694608830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vku9jt1/MT2jaACSB57Jc+E96gaHBVPOlSLatq5yZQc=;
        b=PcG0bLlK9NU/61ijUaLgVClyl8i99mQY1xO3PfZz6Wf9qAzy5/7LIVV61YfhGR+9pc
         +n5ahaZqQ3XaFLjiw8hXZ14T+XCP4ahVRS1pJM7+kMNZMvb5S42SnwtwOrK9RdsAsRtc
         Yvyh3DuFbiB4eXWolsx9fw1L8vg4vTTw7EcxjBd3z3KFBR5kT3M6EfrITJ2C/tvkELjl
         FIZ3GZVd3oJhgcHJW0DfOmzraJih5INM76m4w7JhCtbdROC+8+l1kVWRqJLPSrzg5INP
         7WK1VHcjo9H3pkMIPyubMDHILHJBGbTFMlfExqhdIXY+UwnKmLcWLik36C2bpyHYvbE4
         GLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694004030; x=1694608830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vku9jt1/MT2jaACSB57Jc+E96gaHBVPOlSLatq5yZQc=;
        b=AC6vWqzgEh8jQG77ievrc66GfXXFg9I6+0ExaSRLoYc0f7LDb25oGKVfHhPxpHHVUF
         Isa4vBvQzThg5NUZV0JJwV8MX7J9/AxU30vYXKc2ngH8l3mf89Lh1cY1gE1fDGG48dj+
         fnNaFdxiPR43W0XJW0yjghvR5CFp8U6yQbyX6Fmnu6ZGBPsjXzVPR0PQKganA3czCoW2
         2fG++w9FLrJUSCCfOGpybwbbEcm7B0LIg8kjvBT23iAeeFkWewk9exLEl4urw3qWG/Le
         GYWsoTHB4liriMPi0cidOMue1CqM8X/VPA939ctGGDNCemFyS+FMmF/KnzS8G3/jeu+9
         X7UA==
X-Gm-Message-State: AOJu0Yyzfh6D62ZyhpxJl+wyM60U0blBH0TayBiF3MSa/zX5dRE6IrpK
        6C9q7YOVEUtumgc+w2KRVzI=
X-Google-Smtp-Source: AGHT+IE7SbcPR16ee6g5AeRPYZ12DcHdbviRcJSHkOvx2uD7etl58kH5wZnEITsDLXzREIltFTJ3FA==
X-Received: by 2002:a05:6512:2148:b0:500:d8d6:fc5a with SMTP id s8-20020a056512214800b00500d8d6fc5amr2222940lfr.37.1694004029676;
        Wed, 06 Sep 2023 05:40:29 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id p21-20020a19f015000000b00500b19152cbsm2727232lfc.8.2023.09.06.05.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 05:40:28 -0700 (PDT)
Date:   Wed, 6 Sep 2023 15:40:24 +0300
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
Subject: [PATCH 3/3] MAINTAINERS: Add ROHM BM1390
Message-ID: <bca32e53fc58a3584db522ef827618b32ab0fb1a.1694001462.git.mazziesaccount@gmail.com>
References: <cover.1694001462.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7s/7PdHPLMA47FMN"
Content-Disposition: inline
In-Reply-To: <cover.1694001462.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7s/7PdHPLMA47FMN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add myself as a maintainer for ROHM BM1390 pressure sensor driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4cc6bf79fdd8..ad18c76b7b07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18422,6 +18422,12 @@ S:	Maintained
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

--7s/7PdHPLMA47FMN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmT4czgACgkQeFA3/03a
ocWkzwgAy3MzEzO2gAvkQeDQY5GCasJCpNN/1WyFx4XtCFpT7K30NDn3WCLWIMxJ
FuB2L1aiXUz/Xyhk16THrbskFqHpTbjWt5edYsLyi110+uWcY6IieWsP7Vxzeac4
0rR8WkxIz86nPr+6mzAwD5/WYc90IJOBxYDCkSi39Bx2Kr/dsPa+FxfLbGnFmWK6
b2CFkyueqXYqu0Ryy+C1O3Mr7n8wZjE60ovG1HOU02KzJCgP4fdm8pCBG6dEBH/u
PyCLHpjm+o66c4iPkpf4laK5uQ+sjSPismSAhh1i1VpSdpCTDpQgwI7nw8y4HJSB
sOE7nQIiIe5xwD5ZSUJj+DgANabplg==
=rJcJ
-----END PGP SIGNATURE-----

--7s/7PdHPLMA47FMN--

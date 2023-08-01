Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EB676B45F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjHAMFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjHAMFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:05:09 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A8C199F;
        Tue,  1 Aug 2023 05:04:47 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so9019673e87.2;
        Tue, 01 Aug 2023 05:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690891485; x=1691496285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lUSZxUxJVRcnvJ4sobFgXrYil73npapr2l2ITiQG0aI=;
        b=R4JtoyAC+ocWiuXRjDbII6S1UVzNDhm8T75KcU5zkLavGT3YPmIQ1W7juoNacFKZN/
         iiiYgiTgNiFGoHbPBBMg25bqR0hStWyd01S2A9NrlhyQW3KMeV6p0+hJHxJjR12gxBy0
         3YwEMKdKrPZK+3YX3RochuoUuQbTbx/LTP1RtgnIw14RsunfZplVmvCoBHUBNBNyJ6Gp
         k5dQ9HTpa1uVW61pHHA88E/lZfO66wAe41nMRBzDR++yUghbBTzU5VpUNOWD8dgRUsXi
         4gqWOVCkfP4/5elSfpaGenGVHrSGaBfJMb5eSpDJo/aKHSKT5YSryIDci1yuPK2Y8y3I
         5r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690891485; x=1691496285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUSZxUxJVRcnvJ4sobFgXrYil73npapr2l2ITiQG0aI=;
        b=Rou/NosTIsbzvvCpmhyKLaj7Prvb8hCSVudy+949GmF/8nlVUs0O+EEq8B5wWHUCDm
         9x0Up5XzRz8QN8UYNM6BHgXVwM0kpyks7j4SKVu9aKf2/suWVMjbbdEvbs5oJBryK67m
         irRdrPXmo3MAjiCE72FwC7Hc6nEuIB/TER5XxCGTk4dCjqOFjKzzclBB6rOZi7gbkoj9
         FgVv/ocGwpftdLQUzMfEqsGNwc7Xpq5D84BzlaloDznE1D213bjlDSDQqoofesHbSdDP
         7X0OkR0aoSFS2cH4BypnuMnv8soTMnHjgrGOyLPejlhax5LTsYsDyMHL/8vyg6TwmfA4
         jTPg==
X-Gm-Message-State: ABy/qLYDjJexVV4zgft3Joxu00GnKkRTbGldapmxHo7r+tEvafu+ofpy
        hDG/QNd6gVuzsr7H47HnJHY=
X-Google-Smtp-Source: APBJJlF+tW5ztsnU2aYScjsFUo6/gEbVHI011g23lXFi9h/0m5bqKGuO6i1p4n+q3KRRennzetzSgg==
X-Received: by 2002:ac2:43b7:0:b0:4f9:5d2a:e0f5 with SMTP id t23-20020ac243b7000000b004f95d2ae0f5mr1926958lfl.19.1690891485429;
        Tue, 01 Aug 2023 05:04:45 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q19-20020ac25293000000b004fe0ab60530sm2552455lfm.49.2023.08.01.05.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:04:44 -0700 (PDT)
Date:   Tue, 1 Aug 2023 15:04:40 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 8/8] net-next: mvpp2: don't shadow error
Message-ID: <8c5b976a4ef9ba38fc952e9cf61848baa3e9dfe7.1690890774.git.mazziesaccount@gmail.com>
References: <cover.1690890774.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PxwUsYkRvGz4sbiY"
Content-Disposition: inline
In-Reply-To: <cover.1690890774.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PxwUsYkRvGz4sbiY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Do not overwrite error from lower layers but return the actual error to
user if obtaining an IRQ fails.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/=
ethernet/marvell/mvpp2/mvpp2_main.c
index 2632ffe91ca5..2aba34a2ca76 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5830,13 +5830,13 @@ static int mvpp2_multi_queue_vectors_init(struct mv=
pp2_port *port,
 		}
=20
 		if (port_node)
-			v->irq =3D of_irq_get_byname(port_node, irqname);
+			ret =3D of_irq_get_byname(port_node, irqname);
 		else
-			v->irq =3D fwnode_irq_get(port->fwnode, i);
-		if (v->irq < 0) {
-			ret =3D -EINVAL;
+			ret =3D fwnode_irq_get(port->fwnode, i);
+		if (ret < 0)
 			goto err;
-		}
+
+		v->irq =3D ret;
=20
 		netif_napi_add(port->dev, &v->napi, mvpp2_poll);
 	}
--=20
2.40.1


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

--PxwUsYkRvGz4sbiY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmTI9NgACgkQeFA3/03a
ocU57QgArf8JlEqKVayQDw6bJdv8CBJaGdYYU28HD2CPjDvfvJ0f1p2wq5csZObK
yX2//Sl3rq+CMldChgW1irUQJ+B5CnDqzgI8s+/IhVn2d5FAMwi54/W7GWOYzOsV
W6po3q+HHPcYb/543T2OWPtm+025lgSIuASVmz5mmvM9gcwRT9q0n08+/nGoL+TO
oUvnI6kl2NJ5Yk7mOl7ggWIhInZc9erugutrjmtgNJ7nodj5swLsesMOZiKco++m
0Rh/TX8529G62BcWzBigKE9AjWEZKZ3EvvYL60hknd+8nI+AGXCabs3ISmtlto2f
YKltDbyq/4Pdub5V4SJuYKd0vaYG6g==
=xXGU
-----END PGP SIGNATURE-----

--PxwUsYkRvGz4sbiY--

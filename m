Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CDB76B45D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjHAMFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjHAMEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:04:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07701FC6;
        Tue,  1 Aug 2023 05:04:30 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so9019258e87.2;
        Tue, 01 Aug 2023 05:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690891469; x=1691496269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ADYcjyBt6vQx4AlVs0ouKVJ5yckCOkwBqZsdJ6ZjKOQ=;
        b=mNNs3VPnUFmoXBhLcSCDTGAThPOJlCg40STaqxQT3KJQbAsUU5vq7XDhY/5Wn2HooK
         0eLJf+UXlnMF/NN4Ca+PX7/YfOK70km5ZTK7ApccfvC+GMmK6DEuFKUc+ZM4/wKW1pHk
         Z1CQI/ssPl5x2P3S77aPv+d5kBaiDjl2YW6ULtvXhnXtUBJ4HhPzRpkUmK2JZpRoKQEg
         vgUNJ1fEBEAbfDilZTKQ7JAaFj25hWDuLmtv3yH8jZ9j1KfNYDT2dqGS9oziBvm5Bjyw
         ULIQKckJOmZjXWNgq/jMnLg0v7nKja3DsCKqwgDrIdHE38Tm+TZu/PmdHCnbsJe3qKbi
         QvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690891469; x=1691496269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADYcjyBt6vQx4AlVs0ouKVJ5yckCOkwBqZsdJ6ZjKOQ=;
        b=L1D5/MkyB8vhbWujOdYaknUE7NJYolnKuNGXo53vsejdXuVytkUGfB4nT5YfXJyWFN
         KKXhBWNCD3XdyYK+X94bHRj+Hz0BXhJ6g1O39pAdeUjGAPVYI+F/n0RiHWZJ6GkscXHW
         MVcvBUhOpY8b1cIiapNgoFQWNyPQMuxnJZdWWiHmeVKecScjM7sYH39kYYRa657nR4xp
         3nHwUgNfKAeE2adgMs6Rvoj0Lli66GOE2eHZgTbZQrdVnz3J9pknx6czbJglEWZIkkpr
         Z9yoiu0fQE4Q/JGDqEeyKJGdkAPC7nvbzMu/BGKw6GXSEngnc0iKlqLuHsP6NxHB/Mxc
         4D8w==
X-Gm-Message-State: ABy/qLbl6W3FKTZ4L5eJfz7YTK3lVXiHwqJouKhMvjfADgP5HS+R+d2a
        p1FpDtORnueNckxrk4pXD7k=
X-Google-Smtp-Source: APBJJlFOPb4UW9GNOSGxVwQ9anYiY/4gZVwpnu05QHHdDdmQk9tEoOUZfcMeR4k7UdHzogrmXAHqsg==
X-Received: by 2002:ac2:5bd0:0:b0:4fe:3724:fdb1 with SMTP id u16-20020ac25bd0000000b004fe3724fdb1mr2202695lfn.41.1690891468655;
        Tue, 01 Aug 2023 05:04:28 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id m14-20020a056512014e00b004fe3229e584sm1157059lfo.270.2023.08.01.05.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:04:27 -0700 (PDT)
Date:   Tue, 1 Aug 2023 15:04:24 +0300
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
Subject: [PATCH v8 7/8] net-next: mvpp2: relax return value check for IRQ get
Message-ID: <9738e169d83a96f18de417e62b3cf4c20f51f885.1690890774.git.mazziesaccount@gmail.com>
References: <cover.1690890774.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/sCa28yDRnnrSPo8"
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


--/sCa28yDRnnrSPo8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fwnode_irq_get[_byname]() were changed to not return 0 anymore.

Drop check for return value 0.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v5 =3D>:
 - No changes
v4 =3D v5:
Fix the subject, mb1232 =3D> mvpp2

The patch changing the fwnode_irq_get() got merged during 5.4:
https://lore.kernel.org/all/fb7241d3-d1d1-1c37-919b-488d6d007484@gmail.com/
This is a clean-up as agreed.
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/=
ethernet/marvell/mvpp2/mvpp2_main.c
index 1fec84b4c068..2632ffe91ca5 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5833,7 +5833,7 @@ static int mvpp2_multi_queue_vectors_init(struct mvpp=
2_port *port,
 			v->irq =3D of_irq_get_byname(port_node, irqname);
 		else
 			v->irq =3D fwnode_irq_get(port->fwnode, i);
-		if (v->irq <=3D 0) {
+		if (v->irq < 0) {
 			ret =3D -EINVAL;
 			goto err;
 		}
@@ -6764,7 +6764,7 @@ static int mvpp2_port_probe(struct platform_device *p=
dev,
 		err =3D -EPROBE_DEFER;
 		goto err_deinit_qvecs;
 	}
-	if (port->port_irq <=3D 0)
+	if (port->port_irq < 0)
 		/* the link irq is optional */
 		port->port_irq =3D 0;
=20
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

--/sCa28yDRnnrSPo8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmTI9MgACgkQeFA3/03a
ocWg+wgApu+Z6yZLccRuV33Y51DSdby2EPjInb0L/wZRibJl28li/b5BP8RD0YDG
45eLHjm4xKmkgz4QPwZ0GAe6kdtiVFvET6Ew8kTRzXw4nWAYMj9D7EJ1dmQTTdKU
f4x3W1JLJOLmT79aJukCo+xywc+qA/JVFjWHNYHC4ZcugiSSxw4cbMgLutZwhbhS
BzjRg5Ft5+Z4/+lwAFXC4kiNlz1x78Qnt/ylHgqdZg3bfAroBYRlBIV24UpbENxb
nhkaGNxZyuD8sSa9DWgnn7b3KzAtbB88mIfVREmp/MId3vh4iXgabeN0tZvsXTOn
vpnEBBfrLJGS64qowGXLyEaQERXAnQ==
=gbFx
-----END PGP SIGNATURE-----

--/sCa28yDRnnrSPo8--

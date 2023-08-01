Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F8076B44E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjHAMEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbjHAMDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:03:45 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C913D1734;
        Tue,  1 Aug 2023 05:03:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso84202331fa.3;
        Tue, 01 Aug 2023 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690891416; x=1691496216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8zpSRj+GD1K9ivzCsboyfWepvG0nnxsJI4neiOMEOJA=;
        b=J9YXI/qQWmc5foKYmcXr/mlM5rzoT7ewawJlMCCWUj6LqVxodgC86yvhX9LVcLzrId
         ZMkIdl0WnR24MEWt1s91jJUWB2YFfz+xv/6wJ3QScW6rg/hiNPf+6xxw2h8RpPg2W120
         eLvpxuzfmRCQOR4uZj8OJAQyPe6pgJzwUQGN84YvXJiXkPBdPKsEITrwhkeEfuw9jGMO
         Cxy6RyLHU8T6grY7VKpp0XfSrhJxws3xim3yVFVyrpSRjcXTD+zBxKVE2QxoGmyvi68V
         q9Hj0nPh3vM3KnxiFNfgc+Cs1AWHntrw4iN1SvF4Bmb1ZzgEr7Pg1Op51Tf76WTE9XFj
         ItAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690891416; x=1691496216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zpSRj+GD1K9ivzCsboyfWepvG0nnxsJI4neiOMEOJA=;
        b=Td0FvCqi2R8GJFCXfLdGRu31QBJsp0yunf3dXrjT1CU7uROhbNDCwObB1sdnfYN19+
         2ZjpvyZP5jFgEIpQskg5YiyogoIl6GNtrAS1gFT7GUPWdb5kxjfsDGh6b3mDpXHqC2/e
         8bzYun2Stb0Q8IfBVctO1dMJ1DpnFiaTYnzxEqYB4tT1g2Hyy2GABSeNXEaVW+RUhuXM
         MnFoaj18A00GxEYHAeYqJBSLziYNOFkjyd2vn5OWr41DkZ/Aw+0UfQkBIfEcIdEyMT/y
         +c9cv+g3+shcBj9LHcZZ2hE9zWVSf5EL4qRb2dsUfsmcF4ebPR4o6mgDWe2PTmROo7kC
         vOaQ==
X-Gm-Message-State: ABy/qLYfURSRWGI5ZNNGuCRWb2I6SQ2Dmffp2ainxGR44kOzzLSkOJkn
        lD3SS3+yPOY/Gfhhm3vrFFc=
X-Google-Smtp-Source: APBJJlHjM5sGeXJ8scrk4aBLFhYKc236hH6cKgiTcqCKxDSEfv4vNXCF+LRTsngmIqRpheMWNP66IQ==
X-Received: by 2002:a2e:8812:0:b0:2b9:3cb3:2592 with SMTP id x18-20020a2e8812000000b002b93cb32592mr2327537ljh.10.1690891415898;
        Tue, 01 Aug 2023 05:03:35 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y16-20020a2e7d10000000b002b9899d0f0bsm2590417ljc.83.2023.08.01.05.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:03:35 -0700 (PDT)
Date:   Tue, 1 Aug 2023 15:03:31 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/8] pinctrl: ingenic: relax return value check for IRQ get
Message-ID: <92e97e068e0f058d081886f0352715d1f22d43a1.1690890774.git.mazziesaccount@gmail.com>
References: <cover.1690890774.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Fcap+cDW0Rqwoy47"
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


--Fcap+cDW0Rqwoy47
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fwnode_irq_get[_byname]() were changed to not return 0 anymore.

Drop check for return value 0.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Revision history:
 - No changes

Please note, I took Linus' reply to v4 cover-letter as ack && added the
tag. Please let me know if this was not Ok.

The patch changing the fwnode_irq_get() got merged during 5.4:
https://lore.kernel.org/all/fb7241d3-d1d1-1c37-919b-488d6d007484@gmail.com/
This is a clean-up as agreed.
---
 drivers/pinctrl/pinctrl-ingenic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-in=
genic.c
index 2f220a47b749..86e71ad703a5 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -4201,8 +4201,6 @@ static int __init ingenic_gpio_probe(struct ingenic_p=
inctrl *jzpc,
 	err =3D fwnode_irq_get(fwnode, 0);
 	if (err < 0)
 		return err;
-	if (!err)
-		return -EINVAL;
 	jzgc->irq =3D err;
=20
 	girq =3D &jzgc->gc.irq;
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

--Fcap+cDW0Rqwoy47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmTI9JMACgkQeFA3/03a
ocVLWAf+NGRt7nw3/XhPANula40iJJFiuw8jhq/Wh2q7d5+R8FyuXJ4k0MxYnNai
Gz7hXWymh+tE5m6X2AiVaGen80URaPifkWsCCoQQvtN3EOt0b/uACthvyx3CkvoJ
/6suG7+iZvQcxZTbHeJKvxh9IwsyLIKKyD2YVWA3EekFn4GAm9TtCGI3eITfejKN
qJvpQpreePQoxqOEr0oGj8ZxqF4M1OQV5xyAVxG/iP5r4x7syoVt3II0qkkL2JEJ
QYDGxtlgy5WGQyACRlBdvRInq6sb4ELRD/zuRD0bAAB2S03yqY0PJzLWN3kQtrMR
AEowC+zNv1M1/MfC47NKj/vsbSrIgA==
=DHaf
-----END PGP SIGNATURE-----

--Fcap+cDW0Rqwoy47--

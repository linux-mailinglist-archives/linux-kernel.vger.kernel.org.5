Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACCC80C021
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjLKDu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 22:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKDu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 22:50:57 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC940E7;
        Sun, 10 Dec 2023 19:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702266659;
        bh=FGkn7wAFqtTBrFRe5RSB0rgYUlfdkjXPy2LBmnrawZI=;
        h=Date:From:To:Cc:Subject:From;
        b=GXNkDSeppFQTc7iPvGpIjpBqMLxFrzgAPd5vBGBg5iPFOKDMwDYWLz7BMYXD0eKCZ
         o9UXs9k0UwyQuVo2FzGZDl1KGtsY8z68gNblrFQQ9AsTQ8aHjh6oEhC8IKUFlXKnoK
         3dPv0HwN8eTXsxBcattc6SzRcDnF19AHgucxtyrlDqmjpzsIkMZQSmItkFjDj5Y2nj
         2h7P2IZTg/tJSlQkeYmAFrPdGDWmQX9aVuJr/oZnMcDGYwOa3ZApJxKe94vcHO8wjs
         98nPOy1ioQfok4Bqk0l/I8sI9hCGxswY2DRLEU25C4OH8C35WWLdM1KSGAw2lYcj5+
         is1mMtbPZHJCg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpSTG6kcxz4x2V;
        Mon, 11 Dec 2023 14:50:58 +1100 (AEDT)
Date:   Mon, 11 Dec 2023 14:50:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the pinctrl-intel tree with the
 gpio-brgl tree
Message-ID: <20231211145056.23fbfd7d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FU3efTF+ydPNoOnYUznk4ry";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FU3efTF+ydPNoOnYUznk4ry
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pinctrl-intel tree got a conflict in:

  drivers/pinctrl/intel/pinctrl-baytrail.c

between commit:

  c73505c8a001 ("pinctrl: baytrail: use gpiochip_dup_line_label()")

from the gpio-brgl tree and commit:

  6191e49de389 ("pinctrl: baytrail: Simplify code with cleanup helpers")

from the pinctrl-intel tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/pinctrl/intel/pinctrl-baytrail.c
index 3c8c02043481,9b76819e606a..000000000000
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@@ -1173,7 -1136,7 +1136,6 @@@ static void byt_gpio_dbg_show(struct se
  		void __iomem *conf_reg, *val_reg;
  		const char *pull_str =3D NULL;
  		const char *pull =3D NULL;
- 		unsigned long flags;
 -		const char *label;
  		unsigned int pin;
 =20
  		pin =3D vg->soc->pins[i].number;

--Sig_/FU3efTF+ydPNoOnYUznk4ry
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV2hyAACgkQAVBC80lX
0GyPFwgAhFziVLWXn5fOB38Btu/fRLEqzvkL6cquOkgu8Sw+UjEwgkEuuU1qmbQp
iCTNltOzJfjnrqDpfU8woI1GunHeLMs9qgRK1Ctkom+7cc+afghD9nqzuIUhA5T9
c1GsZataPNwYME6ze8Qamqe+mhQEph68yxbkN/Hc+kASEu1WK/FKdS/7wY8D6dSp
fDpvHkKE2Qt9aophW9jKZmRzAja6UwTJhBL1OVOeQ0pvRoPsPoMDCxs9Y7vPdrH9
QCEoOWWfvUwhd36GAbtNEKnpxlIVeOG5/PCtRVJ5INn9vLlnrx7MiqzQJfl8kvS/
e0J6IBkex52+MBpsfpcBt84Yi1v1DA==
=UraX
-----END PGP SIGNATURE-----

--Sig_/FU3efTF+ydPNoOnYUznk4ry--

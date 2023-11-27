Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082687F96E3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 01:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjK0AtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 19:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjK0AtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 19:49:06 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327B2116;
        Sun, 26 Nov 2023 16:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701046148;
        bh=eSSxfkaF6P/9ehL6rQMSgiFTpLmH2PD+sC91+LhZ+yg=;
        h=Date:From:To:Cc:Subject:From;
        b=GcUYbfoqsih8uNPaOHYo4osjcgTl4ckc/GODFIb6X02PjujOpZ3ldue4YYmhvZVC6
         ETFr7HJ/0oZNwhGs6BNkh1APzDQ6+OafLU5d78H/jVpwOYSJHIrvheObyOJEUzgqb4
         jNivkc3d7fjQq/b5tOchDfLyZgkHsw7YIQQeSPrdYnue5kh2Qj1P8mws+mPoZ76sNy
         RprogQmelI7zH3Te2zVmM18e/WnwK8BeL8en92MsxkUUusGsYOpq/8La0eV4xkNcWV
         EmZLh/K43FvrMP+Fnu90KdviPYk+yDUUEd1RD33qbaug1smb3t9UbORrCkCpKCu809
         fm7/e+Xs+C4nw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sdn5t6sG5z4xPL;
        Mon, 27 Nov 2023 11:49:06 +1100 (AEDT)
Date:   Mon, 27 Nov 2023 11:49:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: linux-next: manual merge of the tty tree with the powerpc tree
Message-ID: <20231127114904.77f7efb6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s_bmlMboQn5EzX+dtDeXWmA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s_bmlMboQn5EzX+dtDeXWmA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tty tree got a conflict in:

  drivers/tty/hvc/hvc_console.h

between commit:

  c9e38dc90e1c ("tty: hvc: Make hvc_remove() return no value")

from the powerpc tree and commit:

  7f30c19caf94 ("tty: hvc: Make hvc_remove() return no value")

from the tty tree.

These are slightly different versions of the same patch.

I fixed it up (I used the former version (removed "extern" from a function
declaration)) and can carry the fix as necessary. This is now fixed as
far as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/s_bmlMboQn5EzX+dtDeXWmA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVj54AACgkQAVBC80lX
0GxMywgAk/KriTf1x1WfY+DGKeTl2pHJPX7vqhJVQjUH5B2KlePP04tpJ4LlJOa+
OArcCKA49+0eAMPlSJq+pTavBg9Mz8sp6uHOXq6J5TZMae8DzMDba1FmeLy6+dOx
q4F4nOfGY0d/eCLSbfupoKYPCkoMoyTt9ODGF1GsvQsbina13x7reQVw//bwdJ9Y
jViyH2rfeWMWzsZGyQ9OUObxOBmo63SFxsNyWSYR4bQt+sZ03/TRi+5Bx8nFQcJ1
+xuQp4fK4FKc98wtQAKxOsyF0gjaAZr+Hsbi+fxg6YGAaLkPN0A1j7StjMhYeuDe
YC2/oWHfkcGBAJtpiW/adAxFULACiA==
=1s/D
-----END PGP SIGNATURE-----

--Sig_/s_bmlMboQn5EzX+dtDeXWmA--

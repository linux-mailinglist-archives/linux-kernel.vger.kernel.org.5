Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C607CEE84
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 05:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjJSDyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 23:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJSDyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 23:54:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC09118;
        Wed, 18 Oct 2023 20:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697687647;
        bh=n/35KHu7JyOQYZ1iMGaxwWjDH2lv/OhTG0kl8VPB3bs=;
        h=Date:From:To:Cc:Subject:From;
        b=KsUmdJAhrIjnHN//6aETVIgs5LsvtDJvY2uVnkImKBY91xpA7mocQVz9+U4Zs5N0R
         XFyYxghfkW3sOn39gvg3r+fWZKDp+38CWzzlEDI6K4Rhd5pNmv1eeyBtmZRUwKWzJx
         6szz+D2K7aPA8YSBRDxfzufbMpR/5zcIIZrqi6SUUveVLEb7uDXdzz82RZ7SO++wFl
         dQxT6sxTBH3l+Wq3uOkuvCUrWzqE+CLIL2WsD8aKF8sFLtFQf7Hoq8epAUjpOcTpTb
         5tT3jshWZ/q16ixDk6j0P3pJ9tYqBfZRA+MTIC4xyOFnRY/bhXjlkM5Tl+p2VPv/U/
         n3LJyjA8jOGjw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9v3L2HpTz4xbT;
        Thu, 19 Oct 2023 14:54:06 +1100 (AEDT)
Date:   Thu, 19 Oct 2023 14:54:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the efi-fixes tree
Message-ID: <20231019145404.63bd38ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1jUJS3rYAb9ajyeJ.V=mWCb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1jUJS3rYAb9ajyeJ.V=mWCb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the tip tree got a conflict in:

  drivers/firmware/efi/libstub/x86-stub.c

between commit:

  db7724134c26 ("x86/boot: efistub: Assign global boot_params variable")

from the efi-fixes tree and commit:

  50dcc2e0d62e ("x86/boot: efistub: Assign global boot_params variable")

from the tip tree.

I fixed it up (I just arbitrarily chose the former) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/1jUJS3rYAb9ajyeJ.V=mWCb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUwqFwACgkQAVBC80lX
0GyTLggAoZJwvyXcO6IHuswXwuo5YVsjqvHIeNiBpj359492u2GbMzo3jJrFb+/T
+jhf6KNd/I9dZl1HwL5vCKywvxTMTZqchOLREpnNcGSe5i1WbdGpkqKMODh7+vNz
ba8nb/qdb0a2Xaaz6b+MNNiQ1hRhfL+bYF2HC2Z3452UVGu0IjPDnSSFZe9JgW0k
CqmKmj4FaUJdk5Q1MAowmGnB7yZrHKOHl8s/Wk7pOgzZhMfEo8wa/R4nve3xt59u
++1POb4n0cuQ5Sxd33Ja/ypxOHabylBhnVOXZadanYfYbZCMZN8m1or2NqpFwYmr
6qAAOt9GpdThB0Hpk09vdT1Y14CJfA==
=/CFs
-----END PGP SIGNATURE-----

--Sig_/1jUJS3rYAb9ajyeJ.V=mWCb--

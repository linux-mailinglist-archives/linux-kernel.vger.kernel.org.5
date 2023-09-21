Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB36C7A90B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 03:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjIUBur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 21:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjIUBup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 21:50:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A26AF;
        Wed, 20 Sep 2023 18:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695261037;
        bh=JLRMlSo3vMMNvqxLmYNQNMSGfT0Tg+jBoXG/REv5U0g=;
        h=Date:From:To:Cc:Subject:From;
        b=LL3JOHa996/ClIp6UOSpQNWH3+3ARf7GX4hWYsep/8l6w2cydSW8G/qa3BtTJCY0n
         Zd1YBiyOzKCidIKu5H4Pr/ILZFxbv2mwpK/wtE8DqMVrZvuLEfaL9Lb5VVtLx6ACEM
         qG7FfwCwu3g8FLn6eGWr6ppH5tofg0jnTo+rRQBUxaYVDk4J1bmniqaMR3lI7W756A
         atfXNojZWm7R6PK/cyPUxkynPpjFmCGwhk87HlQ8a9M6WBZYvLXzbWHbUcEFUTb1HS
         inYnZMGxaVWkNXeolQLo980WybK2jiBRyvPrVM3D/PrkRgEDfx52wUuGC7GgMp+4wL
         vIX2m6f/ZlL7A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rrddm3C7jz4wy7;
        Thu, 21 Sep 2023 11:50:36 +1000 (AEST)
Date:   Thu, 21 Sep 2023 11:50:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Joel Granados <j.granados@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the sysctl tree with the asm-generic
 tree
Message-ID: <20230921115034.5461f62f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/abOGJuyUxkoxwYZBACpOO4O";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/abOGJuyUxkoxwYZBACpOO4O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sysctl tree got a conflict in:

  arch/ia64/kernel/crash.c

between commit:

  cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")

from the asm-generic tree and commit:

  d2f2ef357794 ("ia64: Remove now superfluous sentinel element from ctl_tab=
le array")

from the sysctl tree.

I fixed it up (I removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/abOGJuyUxkoxwYZBACpOO4O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmULoWoACgkQAVBC80lX
0Gx7PQf/TzOjUUFn+I6C5fLjeElNvtz83wRWweZuJplE2Skv3+mjLk5APK7sdXBI
e1C69jKE0BbOdmn7j1FznpFCMIbNbqUlQOGmDt/1/xJx7LWtm+2sVLBXe2oFSzYP
JaORSbAjb8MWFN1DGUAPJQu5Cz0F5Knrg5HYVWYAxjVXJIzR+iXkcR1O4tx/15k6
DqJtzuxMOG+f4wsKJOYCr20YWIb4kUWTV3savYhQ5Fu/dds2uX/SDEuPIOPijLmM
6g0ZnAFiT86Dhqq8CmW2VFeJFBAcQsslGXzeJ+8sWxM1fye8jpSiOH/KIVjM5RMd
fp4yzvZK5pn6rXeaydhvfw/DNgyG9w==
=7zyq
-----END PGP SIGNATURE-----

--Sig_/abOGJuyUxkoxwYZBACpOO4O--

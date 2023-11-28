Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040817FB086
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjK1Cdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjK1Cdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:33:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A001718F;
        Mon, 27 Nov 2023 18:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701138830;
        bh=2NEKrV25skME0djfpzvzrt8UkkMVPNSDD71pdqpYz54=;
        h=Date:From:To:Cc:Subject:From;
        b=a1RLbDZ1Jku6Td+kWzKHUhh793r9et/sT14kJH24lNvpjorB2qJ74fGVIilsJY3qj
         m1pv8tLm6dJJQ/4xAY3+eZWZPH9yqiefF9sNnSi0loMrfMjt/QvPZxefJ91bLckPcL
         YbKiZmun5GsSWu4cYKeU/W0IZ6u1bkK2+buryZYJMor4Dx9eeDX4gJI9I/9Fua6Iiv
         nXCwbjaPKteElW8qu5eFGJuzx2arCFxT9H+sIu2faL8NkyYPRhFrAjaPeBlYr+n4/T
         qMA68SXuBhjvvz8EldS1qRfFhns1jv8CIBCR5261h8VooT0zKeSX0ZQiDy/pd/R0bu
         DwWPAwEyf6NSQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SfRNF4XVkz4wcj;
        Tue, 28 Nov 2023 13:33:49 +1100 (AEDT)
Date:   Tue, 28 Nov 2023 13:33:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20231128133346.74e3ef04@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1M=UPsPTMmwHs5piAeunq9t";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1M=UPsPTMmwHs5piAeunq9t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc allyesconfig)
produced this warning:

arch/powerpc/kernel/swsusp_64.c:14:6: warning: no previous prototype for 'd=
o_after_copyback' [-Wmissing-prototypes]
   14 | void do_after_copyback(void)
      |      ^~~~~~~~~~~~~~~~~

Exposed by commit

  c6345dfa6e3e ("Makefile.extrawarn: turn on missing-prototypes globally")

--=20
Cheers,
Stephen Rothwell

--Sig_/1M=UPsPTMmwHs5piAeunq9t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVlUYoACgkQAVBC80lX
0GyJvQf/QdU+xhWFsKVBj6OkKYjKV1OVmp93MborX7w2b7qICWr25SeHnGSXHJo4
ogu6VF9WiXzds+7yBbeYNyQNGj+CVoRP44yDvCQbg5HUBhae0KjMzlNrTCoZ9RaN
ka6pa9NA/n8+cL/L3RAWkGWnYGq+8UVRGi3ZGLBmYrHqBIfnPyx9/avAss2eYd4+
ls+CtCDNbtZWisrn6JQ3FgeVFFncgBQ5oyI8Eu9IBoiucQ5fJrhHgtiNwwXjqGrk
cG+y1w9Oo1YtXzeP11pCsLzeb9gP8pEz993lQHtSisSGxP5HT+ODtsTgdyr2NzAY
ltLLUyV834g3V/JL/Kc0q7oqVesdJg==
=FRcq
-----END PGP SIGNATURE-----

--Sig_/1M=UPsPTMmwHs5piAeunq9t--

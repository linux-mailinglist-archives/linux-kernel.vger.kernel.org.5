Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB4E75E5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 00:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGWWsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 18:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjGWWsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 18:48:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD661B7;
        Sun, 23 Jul 2023 15:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690152499;
        bh=eSV5ine0fyYzovQy3xjXgnfOS8sXP3Qpkmxk2W+RrvE=;
        h=Date:From:To:Cc:Subject:From;
        b=Odl6QqB5XfocMCR40s8FQhS25igrdiiDX8bMz2wsqPYu10Bhc0KRlhjK2iCTOign6
         VwAgbczehseIunvOxgGqmUyAvhuwUlySlB2gkAJ8creIYy0VMOuj4HykQbJfQm3BOz
         ho5XhSZHamlucyvVHEykKXuh6075lg08EulrglGoFAmFxCPWBr95Nvl7WgdNcrJTC0
         saj3YvfxulC51Kx+p2GUqgyCeAji42CzY5Vsas9yEJLlgnjRHxhKB2X3PeHzt1Vkrt
         x+XZs1XIV4At5j7vzTMmeBVNxoGAAGXgLfVNLcYxedDl8eFwbMuOmtuuZpk9jQJnir
         kEbGk05wsVkag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R8JNg0b5nz4wy1;
        Mon, 24 Jul 2023 08:48:18 +1000 (AEST)
Date:   Mon, 24 Jul 2023 08:48:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the riscv-dt tree
Message-ID: <20230724084817.0ed6cbf4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pC85KWewtDDn0uCBU8GNEoZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pC85KWewtDDn0uCBU8GNEoZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8e421af310dc ("riscv: dts: starfive: remove undocumented phy properties")

Fixes tag

  Fixes: b15a73c358d1 ("riscv: dts: starfive: visionfive2: Add configuratio=
n of gmac and phy")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Thus

Fixes: b15a73c358d1 ("riscv: dts: starfive: visionfive 2: Add configuration=
 of gmac and phy")

--=20
Cheers,
Stephen Rothwell

--Sig_/pC85KWewtDDn0uCBU8GNEoZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS9rjEACgkQAVBC80lX
0GywWwf/UVuyzm2UsnjBJl8DdQbWca2umfp60z/qSSsrX+3GvuZnyrWjzGzdpOjR
EAHIdhEJUCi9dnrQJo2BiQYIQnXOLMyatTR+KfLn5wX4wZnnA/wFtmiNUwReheCz
a+EFqcI6qosmqCTLBRAquPG87ChUqsxyCwZG68TuFaLiJkROaPRpC1CJOaic2tXj
AZZC/luuXKAsxKNfQLqy3v+r6zIoGrZDgx3rAaqkd6geC/KCKbWL0PuY+fHmChvg
u3tV0gnSVzd/BV4Al0JdFaZaJAdosulKeilGmhKW1bF2FHG2KMRjB/pKrSfNeeCR
TcWc3US3rlI1VUoE2FthAWIz5QIezQ==
=sQwY
-----END PGP SIGNATURE-----

--Sig_/pC85KWewtDDn0uCBU8GNEoZ--

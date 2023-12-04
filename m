Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DD4802B04
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 05:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjLDEr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 23:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDErZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 23:47:25 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B56C0;
        Sun,  3 Dec 2023 20:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701665250;
        bh=wESg691Lzisb2j2T5ffU0ayjsNyCgrXpHz4d1d82uJY=;
        h=Date:From:To:Cc:Subject:From;
        b=lEuZR+aplzfMlrWrlgZ+Z/MWrhbkvgkas52+qA0sZgbELzXkR5jl9v2oB+fLRkZDT
         35rmjK3fMuw4WtZzo0wFz6tBuMUCirj5owi9efGJCaeU14FE+bz/C9md9xLyHqV3Px
         ufNQtrtBFXyPNEr82KJM4QV9pp3UZ7p4OQ8pP5EKOz0bq8c1PNAR1nFPG8gbOsUt0T
         wJBkazYtU5dO53PCzJZGmWVFiO68yg4e/9Gq4uO61UX0YwmDqa6qB2gr6qcF4FjfdG
         0UsfP9prIzRytLTA7ijUxcZQyhNEzbHjcwqU/emzL5pQ1ccKG83cnyt0RgYPcSgOKX
         EV90HOqKJsApA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SkB3j5MJbz4xdc;
        Mon,  4 Dec 2023 15:47:28 +1100 (AEDT)
Date:   Mon, 4 Dec 2023 15:47:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Coco Li <lixiaoyan@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the net-next tree
Message-ID: <20231204154728.04bf8b77@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JBhmtWTJZVJoL0j2.XZ8oBq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JBhmtWTJZVJoL0j2.XZ8oBq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (htmldocs)
produced these warnings:

Documentation/networking/net_cachelines/index.rst:3: WARNING: Explicit mark=
up ends without a blank line; unexpected unindent.
Documentation/networking/net_cachelines/inet_connection_sock.rst:3: WARNING=
: Explicit markup ends without a blank line; unexpected unindent.
Documentation/networking/net_cachelines/inet_sock.rst:3: WARNING: Explicit =
markup ends without a blank line; unexpected unindent.
Documentation/networking/net_cachelines/net_device.rst:3: WARNING: Explicit=
 markup ends without a blank line; unexpected unindent.
Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst:3: WARNING: E=
xplicit markup ends without a blank line; unexpected unindent.
Documentation/networking/net_cachelines/snmp.rst:3: WARNING: Explicit marku=
p ends without a blank line; unexpected unindent.
Documentation/networking/net_cachelines/tcp_sock.rst:3: WARNING: Explicit m=
arkup ends without a blank line; unexpected unindent.

Introduced by commit

  14006f1d8fa2 ("Documentations: Analyze heavily used Networking related st=
ructs")

--=20
Cheers,
Stephen Rothwell

--Sig_/JBhmtWTJZVJoL0j2.XZ8oBq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVtWeAACgkQAVBC80lX
0GwqIAf8CLPr4aea9OqCjCnqoQHVFgVN//wHeVBnldeFjOmwmB+TUQpIcBG4iZBC
Hhzws2eYBuStnpYiFGl/XZxYn4FlTH1Bl8vJhFVsbDqM0KN16EmbfjdjLD4Rl+4H
6uqiulB/lIri3AuLJezuqgjWJRjf7SJNHNoof3r+RjSguJlOVvOfbgo6pffPWVrY
TFYjBcUsn43wrtzE1bJxTB+KxsxwKDi6YhWIekaZ9AHcXx5j5ToQSBEYxbv7vQby
i0gDnYROx+uyVfCeromDhfVh2FBx65pMjG/kTqW8OpeHu7lfc+2LdiXgDwX8mDth
pdlorFSq5LgK2vLzosMmgG1D8YzxSw==
=2Cxl
-----END PGP SIGNATURE-----

--Sig_/JBhmtWTJZVJoL0j2.XZ8oBq--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F6975E599
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 00:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjGWWhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 18:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWWhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 18:37:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3794F1B0;
        Sun, 23 Jul 2023 15:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690151825;
        bh=LxW6JJ6AtaorYpCXyS2NzoLc0u4P3By4MVniWy6RjsM=;
        h=Date:From:To:Cc:Subject:From;
        b=HCtX4+qEOZJ3f+2EJqfRdiWE3e26kIoZm5IQxoWmLoNYrj2Bz8cPNvTFmEeatzygN
         ibgJUI8QmDahETT2muZAx+ISaza5k8YDFUWlwpXv00F/r3ns27KjVZDQzcr8mOAhb2
         Uv0Yz8OQ+1v9MPsq9xsoNAzM91BT4AJkxObag3XztqYHlG8LLGEv8Z764HynlHrNMn
         eS1nSf2gl5dKQp/IBvi3EUriuSzvBPwgelHoOoH2FXRAgoY7jm1mkouWryXIwpYpPL
         2AGvODwUezU6yr+pmIphd/osLWvdy0O3/7rtFRuiIqsQqbRf9TGw07e2togL6+WBfr
         ceU0u3kV/xwjQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R8J7h6LD3z4wZn;
        Mon, 24 Jul 2023 08:37:04 +1000 (AEST)
Date:   Mon, 24 Jul 2023 08:37:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>
Cc:     Weili Qian <qianweili@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the crypto tree
Message-ID: <20230724083703.5d995fb4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d1vHiiYsJxy71g3tmV1270v";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d1vHiiYsJxy71g3tmV1270v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  5cd4ed98cfb7 ("crypto: hisilicon/qm - flush all work before driver remove=
d")

Fixes tag

  Fixes: ("crypto: hisilicon/qm - enable PF and VFs communication")

has these problem(s):

  - No SHA1 recognised

Maybe you meant

Fixes: e3ac4d20e936 ("crypto: hisilicon/qm - enable PF and VFs communicatio=
n")

--=20
Cheers,
Stephen Rothwell

--Sig_/d1vHiiYsJxy71g3tmV1270v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS9q48ACgkQAVBC80lX
0Gwrtgf9FhOKwL0Q0OrSI5uoroI2Y0FXt8g0dKfYBdItKQ2/KZTDfjng8NR9bX7g
g+HfGUJ9HaeAqoF0pqMbeldVqZ1N2ta64y1LcUnfB6ChxInJg9g1KwI3xs5R97Fy
BRHW8XF2pnYnkiZU1A2IYkQzErtW2wjbNN+8et7ajbMJbDhginZEN6hiOWc6DDb7
Y9X4Ha5eqpGyjfNjQJ12U503A53bpDF7Lo+FeggTKf3Kq0Z23EmqJHqJ33sjvRjR
FPfY1ARsMT4UWLbg3+Pb3BXHl3cP4YK81kcWjGOEOX+m4BSSXtwXjIcsxv7iJMxc
2ujLJfIVrvbOlZulEa32jYn0JAFm5Q==
=ytar
-----END PGP SIGNATURE-----

--Sig_/d1vHiiYsJxy71g3tmV1270v--

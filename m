Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C23E7B5C55
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjJBVDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 17:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjJBVDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 17:03:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9F78E;
        Mon,  2 Oct 2023 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696280625;
        bh=nSoNmVMaoH2FOYYXwIPi5erc8SRt78eIIKi6HUOWjSc=;
        h=Date:From:To:Cc:Subject:From;
        b=TxOo7G12LjfNxAi5auZCZEEmiPi8Nk8pfcbeDNKoB/W0gO80UZxgktMgbTI23n4I1
         DohQhOQRWr70D59BhJ0TTVV0n2V4kAibTejox+X0+J/ta1cJMbpVSug15hfw+qlcfl
         5njkmcW+POLK+763tFBgrPWOZaaO/20rdvIAG7Yb7y1WspkKBNW5gsWQVYDKtdCAe4
         muTPXAvW675nT4GBVMgyFdTvBMiUqpJtXVx/O7QjRPOA2QCIvFzY2xmAZxLS0lquaf
         O8u2md8L47C+7L6EgMifUA37l2CkhsOJHXLXbkWJAzz0YS4iB8k7OwjpIi4Z+FmMcO
         X6daTmUUFCRFw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RztjD6GnGz4whq;
        Tue,  3 Oct 2023 08:03:44 +1100 (AEDT)
Date:   Tue, 3 Oct 2023 08:03:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the crypto tree
Message-ID: <20231003080343.01094378@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MP5qlNvLlFN/LlwhNctLIe_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MP5qlNvLlFN/LlwhNctLIe_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  29b49013176b ("ipsec: Select CRYPTO_AEAD")

Fixes tag

  Fixes: 1383e2ab102c ("ipsec: Stop using crypto_has_alg")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: a1383e2ab102 ("ipsec: Stop using crypto_has_alg")

--=20
Cheers,
Stephen Rothwell

--Sig_/MP5qlNvLlFN/LlwhNctLIe_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUbMC8ACgkQAVBC80lX
0GwCCAf/YWs0fRInI4zoXwevNNFy06I/JiLquh0l2RFeO4MP0Kn71Vth++UHlu/K
srPBs0jgAPncDrcD8oVEmo3SewbkR+eHEefaEmUkJmHGHAM1GwodMfC6RYGWSQTU
UlbPTUTEwe6A/MjRP+aj+uhvaK7+xYQbBqWca/bD6NfY82iLiVWRAQ0Y5EFQEVC1
P4ySNux9auZBPYYPiqnOgdYfrxRTBoJMOR+Xg6VOHiWQWkjX3sqCwm13AwXKDk/o
T5FKF2479CPxpBDVbadE+gi0QSx0iWfx5cBiSyrfH/G/J2VT7333BTHjzeffeve/
tSQLZkOziZGSdQWyLdS9h0LgW/iUqA==
=8Q0M
-----END PGP SIGNATURE-----

--Sig_/MP5qlNvLlFN/LlwhNctLIe_--

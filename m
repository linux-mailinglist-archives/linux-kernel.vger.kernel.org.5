Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B071277C3E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 01:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjHNXUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 19:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjHNXTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 19:19:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC5610F4;
        Mon, 14 Aug 2023 16:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692055173;
        bh=+wq60YYgGWa37mOQaoEIifIbuef6529sNDX/3ujO8Ao=;
        h=Date:From:To:Cc:Subject:From;
        b=LwV8hBXSQZT02KatvEayYUyn6X2+f23VS2oILph4ufQOxa2M1q5GuAfv6wR/aJ0vZ
         q8jESw34w39KqIFxEqyLLAUv02sduCTswQjv5DUxjgTb9itquvc/Z6OPvNeprJNX8x
         2DjXuDoSoxnhbdnB/TUj2hXRXvSf7qR8rB6/YFtGohpgh7sL/jKf8Fy2ynjNGfA1v3
         7AZ0Dtdgz33fn9tkHeGBnGBo2H3X49KHJN1XLf1hsCv5ei/O3mYLYl9sgBONoLm2A/
         UgaS7pQGT2oanbFUd54N/akXKm3hGdlxN5ZpMUWcxbMWH8mg7asiNuCKmj/s56fCUn
         ESEsUiB7h6PKA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPr2X41zKz4wZt;
        Tue, 15 Aug 2023 09:19:32 +1000 (AEST)
Date:   Tue, 15 Aug 2023 09:19:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Yu Kuai <yukuai3@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20230815091931.4dd2b277@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Tb0WqOr1jF6Z+H89ZGzY9_i";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Tb0WqOr1jF6Z+H89ZGzY9_i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  71070e7bd25d ("md/raid10: fix a 'conf->barrier' leakage in raid10_takeove=
r()")

Fixes tag

  Fixes: 4d27e927344a ("md: don't quiesce in mddev_suspend()")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: b39f35ebe86d ("md: don't quiesce in mddev_suspend()")

--=20
Cheers,
Stephen Rothwell

--Sig_/Tb0WqOr1jF6Z+H89ZGzY9_i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTatoMACgkQAVBC80lX
0Gx7aQf/Q9R3FPjlsji2FH1todQkCqWiPz+aLjQE0vZnegtVUtFnKM1ZllfY8BIW
SugXyBYZfqYMS86dlCDOG4gYeVnlapUDwFjoQHKG/r8ZBTgltCluFfUgI3HDOgkT
pni5CNzTxfiZuFBFi/lXzpAmpBV66cZ1UCiYHWxmlXZ55fhtR6Q7bTKA1BCGVEhQ
vJFyzqHGUqcAMC09mmgvzx4jeAWWDJHaVz3235n6Qjbt5fwd/lVgQIk7DTTO7HSr
ixfCLzL/P10Ru6sCOy3YIoPksPk4/KwT+vkJXC+RnQgYm8ThdCmcRYg0QfXtLlvA
4u5BgHKAXYa6voShCwbQtB9AZAbMlw==
=2xNZ
-----END PGP SIGNATURE-----

--Sig_/Tb0WqOr1jF6Z+H89ZGzY9_i--

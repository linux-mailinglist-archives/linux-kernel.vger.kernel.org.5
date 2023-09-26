Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA157AE57F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjIZGIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbjIZGH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:07:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111F3F2;
        Mon, 25 Sep 2023 23:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695708469;
        bh=r0sUST26JQt7+BBQMj+sRAzNzWUgjRuQCHTvv6r9HmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aUKkCn8wHVr+QZcSLfc55z825W6sJ711ZEcLUTeRrQqXsVGKfsR6///tehkMbgzPM
         goAhtBZDVzuKPkQjOT296FCnXcWNa2PVjv04mD2fR50SV5WQB+6iwCzXHhzxr1Q2Af
         jtP4pfoGh/18B0kGAqW8Y/+c56AoDShqxaAZuRN2A2Mpu3VJ57nKSgVpdKVGYHbuYL
         3YNHCYqtkBJIbBJdIuQAUMIH0/GZ6QS5saX2VzFZIeiJuaz+VcCDK9aTdnxMD0rmDk
         cNaeLIYalU5rCzvin48T90Lcx/fR2cjyoShhRtk+YgRChQfd82ymnv9m24FIcJJtJd
         DSyjXtGt+0BQg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rvq6C3NBYz4xNh;
        Tue, 26 Sep 2023 16:07:47 +1000 (AEST)
Date:   Tue, 26 Sep 2023 16:07:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alessio Balsini <balsini@android.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 overlayfs tree
Message-ID: <20230926160745.75df4606@canb.auug.org.au>
In-Reply-To: <CAOQ4uxgs7dCUQ50J6fwW5Dtgb-sBU4WyKogbU2PEG2uooWxSCw@mail.gmail.com>
References: <20230926102444.096ce797@canb.auug.org.au>
        <CAOQ4uxgs7dCUQ50J6fwW5Dtgb-sBU4WyKogbU2PEG2uooWxSCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fEl2H3WQbEJw4xfKZnBY6wH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fEl2H3WQbEJw4xfKZnBY6wH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Amir,

On Tue, 26 Sep 2023 08:09:51 +0300 Amir Goldstein <amir73il@gmail.com> wrot=
e:
>
> At this opportunity, I would like to ask you to add branch ovl-fixes
> from ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
> to linux-next, because I will need to send some ovl fixes for 6.6 in
> the near future.

Added from tomorrow.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--=20
Cheers,
Stephen Rothwell

--Sig_/fEl2H3WQbEJw4xfKZnBY6wH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUSdTEACgkQAVBC80lX
0GxfQQf/dUmQVUsmmy3mnpcqkDOgdDaT7X50Lm6YHs2cghMwqMc5UkMQgS/hVeEW
kc9Hq7DOxVUkLNgUy5ufE2KRILrFVJV0f/HpbetyrdbQQcc5jVY2IhA4HCwZFo6L
7EK+D32FZNL0sq9MCXli1Ezl9xPGfEWzbKELLy2UpNwAJqQmU5kUgssKpXJJ9WTx
ho1GT6D6KiegpAgDdEb4J1nEGlTqE8Q5+QIrihUjCseooLTQ5VTbgT5cTzJOsTUq
+NBdu9DpT9wVqmNAZbcTUUrsxAwhDnNij4pLXuMhfqHFhw0jLBKtf9G4jPPMpArb
3lGzgZMiOyxPtahvbxNRdIVFaLMTiw==
=W4dB
-----END PGP SIGNATURE-----

--Sig_/fEl2H3WQbEJw4xfKZnBY6wH--

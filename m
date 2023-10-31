Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA917DD834
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346607AbjJaWX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346504AbjJaWX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:23:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDA710F;
        Tue, 31 Oct 2023 15:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698791029;
        bh=cJvaviqJcj+/e/u9e1phUK3dawuyU8/xvwf+6L2zplo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uvBNS6NesI3Y1n6p2ENWcgbV0ouCx8sOp2cWLJo3EVjcLtBS9gw+1iD3MHud8CgTI
         sgLKpypE/XBT5iW7VopSCBPEv3RqO0qP8LUWdeokknViE0LekF1Z3JxHD7edzK4nEr
         voi1ZEmczqSutom1nH5Ke3WQobDTVgXZCVrjUqDRyAbDu8k0XnNlILJmWrv//3WNXq
         NzJGbxRzzwD6dVwC0WEhn+eSHY145oZ5913yfmdmlCaAPsiwipRJmzdtZhSRfzxTQo
         ZUrutWN0WtFvw9ckRc3oZ9a3LbUzB74lA8sNxD8wKBEE6Sf+gRwPprqbJps/FVLNt6
         OUHMeQUXjF/6A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SKl6D4bTNz4wd2;
        Wed,  1 Nov 2023 09:23:48 +1100 (AEDT)
Date:   Wed, 1 Nov 2023 09:23:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the block tree with the asm-generic
 tree
Message-ID: <20231101092347.01bc2eec@canb.auug.org.au>
In-Reply-To: <20230925120908.4b15c44d@canb.auug.org.au>
References: <20230925120544.7b1baece@canb.auug.org.au>
        <20230925120908.4b15c44d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2/u+06xgg1lGXSfxRUqMiXh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2/u+06xgg1lGXSfxRUqMiXh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 25 Sep 2023 12:09:08 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> On Mon, 25 Sep 2023 12:05:44 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Today's linux-next merge of the block tree got a conflict in:
> >=20
> >   arch/ia64/kernel/syscalls/syscall.tbl
> >=20
> > between commit:
> >=20
> >   cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> >=20
> > from the asm-generic tree and commits:
> >=20
> >   9f6c532f59b2 ("futex: Add sys_futex_wake()")
> >   cb8c4312afca ("futex: Add sys_futex_wait()")
> >   0f4b5f972216 ("futex: Add sys_futex_requeue()")
> >=20
> > from the block tree. =20
>=20
> These three commits are also in the tip tree.
>=20
> > I fixed it up (I just removed the file) and can carry the fix as
> > necessary.

This is now a conflict between the asm-generic tree and Linus' tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/2/u+06xgg1lGXSfxRUqMiXh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVBfnMACgkQAVBC80lX
0GwLfwgAhD85pgEiS5/zT0OKuXtids3mMWGV6mBnbq/eYPsnLZC8xmqsYyBjIkV0
XMJcZRh5/BjJFNqHL7tg6Nj9FGq0+S40FPHUsXq2Ia8DlOlpkjj2Kiv7aHRfSck5
CyRu0U95g/0QRDrW4x4at59jVefmleFx6Rmi2CDA5dH2BFb6PPFWtEYBq9Zc6Vyn
7fNP7JKSteZVtPMGOcdyQEhT2XpV7MqnB9p3ZaEWa/SbYsQlCi/LSIS9Pm/H8vfS
l1ifxQ/jREvmWGTkWoTwT+xqdx9Wy03IfFo/936Mx2sEHy1qeVNZP6+mJrhbJgfz
6Ed0s5jFb+SAhW4eJiwCv3G9pgGW0A==
=gKyP
-----END PGP SIGNATURE-----

--Sig_/2/u+06xgg1lGXSfxRUqMiXh--

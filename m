Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4F77D7A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjJZBS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjJZBS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:18:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FF9136;
        Wed, 25 Oct 2023 18:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698283099;
        bh=VHRzahGOiiLSmvMd3w8GzTVfBBZEUkBw/tH5XXoVyFg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kSqJXmGhqM+mHEbdztwvaXA7fcvO1uMfTUh3Cvs/YTCHI4Fd630CpTNqWncnsY9yQ
         aHbD29ySok1OHkcmw68R61K1DX8xKueBq/s3vKxIig6BO+kwdMLar2pwLQQbETQ7zk
         CKzZWc6015nU++zKBLy2KQEVqRy/nXNwg1DpiuP6S04cgpEyPJrsd35dUjnaSfE/2F
         3apClVEgS0YAQ9f+L9aIi4DfHHeXU8mYdMCrKhYU7Bzm6ScYnpIVDFaQHWUWkLDjGb
         yz/YvmIFOyouthL+vBupaPTkuxcYPDiiBSnpT+waaBc5kHVpb19wjbpy23XgvcNhH1
         oojuer0fi+/aw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SG7GL5mGZz4wxX;
        Thu, 26 Oct 2023 12:18:17 +1100 (AEDT)
Date:   Thu, 26 Oct 2023 12:18:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ftrace tree
Message-ID: <20231026121816.401d2723@canb.auug.org.au>
In-Reply-To: <20231023133033.5d54f393@canb.auug.org.au>
References: <20231023133033.5d54f393@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vz68pBVvSsS3WsMewe+yFev";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vz68pBVvSsS3WsMewe+yFev
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 23 Oct 2023 13:30:33 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the ftrace tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>=20
> arch/powerpc/kernel/setup-common.c:604:10: error: 'struct seq_buf' has no=
 member named 'readpos'
>   604 |         .readpos =3D 0,
>       |          ^~~~~~~
> arch/powerpc/kernel/setup-common.c:604:20: error: excess elements in stru=
ct initializer [-Werror]
>   604 |         .readpos =3D 0,
>       |                    ^
> arch/powerpc/kernel/setup-common.c:604:20: note: (near initialization for=
 'ppc_hw_desc')
> cc1: all warnings being treated as errors
>=20
> Caused by commit
>=20
>   d0ed46b60396 ("tracing: Move readpos from seq_buf to trace_seq")
>=20
> I have used the ftrace tree from next-20231020 for today.

This is still failing ...

--=20
Cheers,
Stephen Rothwell

--Sig_/Vz68pBVvSsS3WsMewe+yFev
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU5vlgACgkQAVBC80lX
0GwjGAf8C+yu2pqfPXi++yq9MFhiRLu3qvzmMGgNWnxFfz79XvK1a/ZnwlPaxfcB
5arSycnfgKg03RvIDSaKk/OKcks+iP4rMIt3Dnk4jNq3vKYi4rnAMXg0tYYrejJ7
iWXA+OFWtIJHyj43An6E9NthrCgYsXljZHMNVQ1upt93tymqjrGr6I33HKxQ7wKw
9MA7cwjzf+z3+WhUaLTF1d2S/mvz7I9D11s8Iz/YAcyqElITYrWLx/exyuB1+3bA
TRSDLNToobjGlNGRjbQjdJMJC21qkGKVFkFWjKkic1NBMfsJUIv8UiI1GK+ZLvsm
E5IYR3JYpERgjzs/jpSsRe7AAcpH6A==
=s/Z2
-----END PGP SIGNATURE-----

--Sig_/Vz68pBVvSsS3WsMewe+yFev--

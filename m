Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB377DFC08
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377428AbjKBVeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbjKBVeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:34:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5E319A;
        Thu,  2 Nov 2023 14:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698960844;
        bh=kCbqYq6AZTpaUah26JxLW0tsZXqox8dE9OSgv3+Z8jE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UBR1Mik8oL3uIgyKJDs2KlF2Xu93Q8HKojGD/CgBdGlE1pEiWjgbdGMyOS6mtmTRL
         +CxQInRyTiyc7vuF6twYOtxE57Nja2udn1v0pEy0g2QzrC20yeV/WdIhCa+j3GFtu7
         Um22N9jbyVX7wcUWxWWoxe2gah8CdSxPjAjWa+rw15sCAcDuA+AzWJfMb9rQt6z09n
         jHF/VYVnXrEZLH9BXY9PG0CCWyodmFRed+E+QQXoLhv/vulSXPMMB8/8/The6Ma8AP
         HZmOpa7F+XUMdNBWJFHVEcEHPmqgVx8aKuggLUyL8Q+ZG6llkkGHwqattyECBcW/MH
         5iczpnFC+3nsA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SLxvv5z2xz4wx7;
        Fri,  3 Nov 2023 08:34:03 +1100 (AEDT)
Date:   Fri, 3 Nov 2023 08:34:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the asm-generic tree with the mm
 tree
Message-ID: <20231103083402.6d8cc7d2@canb.auug.org.au>
In-Reply-To: <20230918101027.7506b71e@canb.auug.org.au>
References: <20230918101027.7506b71e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cQl1LrOmM=j1cchgpHoaltm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cQl1LrOmM=j1cchgpHoaltm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 18 Sep 2023 10:10:27 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the asm-generic tree got a conflict in:
>=20
>   arch/ia64/kernel/setup.c
>=20
> between commit:
>=20
>   52f40d9a3c11 ("crash_core: change the prototype of function parse_crash=
kernel()")
>=20
> from the mm tree and commit:
>=20
>   cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
>=20
> from the asm-generic tree.
>=20
> I fixed it up (I removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the mm-nonmm-stable tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/cQl1LrOmM=j1cchgpHoaltm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVEFcoACgkQAVBC80lX
0GwW6Qf/fSluccY/3iDJ4vilm2o4OKokc0WdzboftFaHhuEqUITrz4OKBaQbRHKy
PPO2rFcztzRammqLYbASC95CtLN/Tqj5dTwzRBThyKtE90+6z/xvabjL4OH3rTzq
ZjgsPbew43nJEKyrjxyAug2/LM60xLmYEb90YJn26DCppM4ayuXA/FORcvBQ5ij6
Khp+w6w9Hcq0fbd8YN/DE2r6H69AMrXap5YdIiwB/+pGyjj+TKrv71UC2nwBAXPm
90eElpdPz5obK2A9mP0OBMiTcrL7yLyqt7chyH3sMdZv2zCmcnptiVp04oW9Gych
Nlf4HCUaowP65/O1rjmCXE7vnq2ySg==
=9pgm
-----END PGP SIGNATURE-----

--Sig_/cQl1LrOmM=j1cchgpHoaltm--

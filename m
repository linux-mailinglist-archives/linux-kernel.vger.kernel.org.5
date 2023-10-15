Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0AE7C9C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 00:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjJOWPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 18:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOWPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 18:15:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD96AD;
        Sun, 15 Oct 2023 15:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697408130;
        bh=REwvH9ugodppN/e6AKyeQfL7GJYvtPOiULrUJpz+qNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CJN6ly98KBD/UQLWQahooW4mPpc10USetiXtZs4+lDtZCsiRz3YUSfNCA0gz1ohqu
         78moz/B5zMng7jhbbgiiqdwrPZN1oxB49zP9qiK7hbQIDFwAA277NM8GXm+008fY09
         OUht5yT0hzbgGTLfQD5VrKqlDA3vsVO8E7ksDjLHEU0N+pZb1G+sErI0vMdX4kSPIF
         Tu87DG8BMjM0H4sbnNGblv78tLSXakI/faaQVnf7BoyKJt2j+fVKp54sZQPP/VkfJ9
         +ZAGpiKUPevm5gRHVtkbzZBnfPcRBnknACeRx83xHXIZKeItkRawYV8jrXkdwJpYp7
         vaJymP0sjQ83g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S7vgx6hgTz4wcK;
        Mon, 16 Oct 2023 09:15:25 +1100 (AEDT)
Date:   Mon, 16 Oct 2023 09:15:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: Re: linux-next: manual merge of the tip tree with the asm-generic
 tree
Message-ID: <20231016091524.1c1cb83d@canb.auug.org.au>
In-Reply-To: <20231012134442.16f3f9f6@canb.auug.org.au>
References: <20231012134442.16f3f9f6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lkygVc3XrOh=7+t/HOg/eKR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lkygVc3XrOh=7+t/HOg/eKR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 12 Oct 2023 13:44:42 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the tip tree got a conflict in:
>=20
>   arch/ia64/include/asm/cpu.h
>   arch/ia64/kernel/topology.c
>=20
> between commit:
>=20
>   cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
>=20
> from the asm-generic tree and commit:
>=20
>   c4dd854f740c ("cpu-hotplug: Provide prototypes for arch CPU registratio=
n")
>=20
> from the tip tree.
>=20
> I fixed it up (I deleted the files) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between Linus' tree and the asm-generic tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/lkygVc3XrOh=7+t/HOg/eKR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUsZHwACgkQAVBC80lX
0Gz8Jwf+OVt4TOXztb6+gkPNtlgOweAvRVAKi4pq0ETol1kXTRo2VPjbT0ZAM2OP
m2iAG+HLlBU6Z0LOOv2XizamwexfRD2/mOh4VRgw//KQaPBeB5FYmXsT1UDRgbCL
5BXvJGf0lyBoPG6TNrJ5rWmmXP03n9X8G9tzY4RuRjNf3pj/OvYCOKbJ6FarEvVM
rS4oBWqbOrKeBupgBFJ2/Ka0qJMwyJJaIlxc9kyp5UqzWRgDnv1D7vEe828FSe/5
P3bj1XMC3JRD3exaWA8iugVSHTInKA1YRCp+t5gP9KFfxLRCeeAJztKZpSEVr2fq
WCtf0IoT3lOMndMHgnojCW6wSf3btg==
=1sCY
-----END PGP SIGNATURE-----

--Sig_/lkygVc3XrOh=7+t/HOg/eKR--

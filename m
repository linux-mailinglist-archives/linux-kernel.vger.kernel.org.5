Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24847CB7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjJQBaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQBaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:30:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1C8AB;
        Mon, 16 Oct 2023 18:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697506220;
        bh=Q2fe3Ax/XToviOfwG/USlwkvyK64Re+kcHB9byMn4Qc=;
        h=Date:From:To:Cc:Subject:From;
        b=aVfXG4rvQwkg7hEYTCQ//Ce13lpfeouKTHaZYk697NX1g9qjLKQNxCi8lHUqXWg4E
         MtykLoZAArqvmjlQ5IkYYIIIs2pB73kdrXLDnmYL2TRaQx7mR4XdOXsJQWJWIPysR0
         bmlLsLQHEd8SklhFerwDNarRhsEs4WqVkezAKl+Jbkns4CWO9d9imgSHM4ubyONsG7
         mv/9a0IhWJ7I+jH1BZmT6LlyE+O4peqlQgGN//ARXRn/x1icIZrYZ0yOjpzVJkwoyk
         qDRJ0Sn6vRWPrCjLQo8S582GWdT88LoQ22+Gou89QRGduwBFYtigEneZI9EvGlo9vu
         xwxRrRK2vShTg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8byM5Jw6z4wcf;
        Tue, 17 Oct 2023 12:30:19 +1100 (AEDT)
Date:   Tue, 17 Oct 2023 12:30:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20231017123017.3907baac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/50XVF6ViMpX4.y.BB1WplxR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/50XVF6ViMpX4.y.BB1WplxR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/kvm/arm.c

between commit:

  d8569fba1385 ("arm64: kvm: Use cpus_have_final_cap() explicitly")

from the arm64 tree and commit:

  ef150908b6bd ("KVM: arm64: Add generic check for system-supported vCPU fe=
atures")

from the kvm-arm tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/50XVF6ViMpX4.y.BB1WplxR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUt46kACgkQAVBC80lX
0GxkHAgAhlQlvJz1zakFg+zxpviTi/spDGQRUfRn/V99p7H4qFfphq0GaW6/LBrL
ZwBc6KeoECdVKHAIqUAqBn4A3gj4+ccqrTzKQBFx1DYiigvaYfbdiP2TkyPxVIEG
D8Z6NWqDMs7cloluXLgKKoByQVPkmGql4/15q8Q70e0wORLl8HfgR66RI7hPOEsF
sV2dXXBEMdQrGgnVymp1eS6seUKs+Pnj4FH7f/gs4UQYZkWhqNJnwpl5vS5onh3N
SJmG4lSu+t6Cb3FcLWC0Escl1BJMvSWyjmZLqQDl2vPUOynQzeCbrGEFZpMMsKNv
wDdiABlOzF2ikSVoS+33FKbM1TJBPw==
=piPe
-----END PGP SIGNATURE-----

--Sig_/50XVF6ViMpX4.y.BB1WplxR--

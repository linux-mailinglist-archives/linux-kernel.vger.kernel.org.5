Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12827D4575
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjJXC2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjJXC2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:28:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066AECC;
        Mon, 23 Oct 2023 19:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698114518;
        bh=h6UYMiE2f0B2VXOwQI/9psAqqxTmSQz2TxvZRF5UFFA=;
        h=Date:From:To:Cc:Subject:From;
        b=CA60qC8++eikNno2KjdREZQypK/H1ViQQ2NgxBBY9jrgsW87YfyWW9lw8Vr8brONT
         fLMOhf9beLYt1b2FD1Qpkn1XiOt5SIlYjXr97piuk9hmg9b6NCfm7cRFj4xp/XRMFG
         L+Dcrc4gN1Bl/tpUx7crtqdlWulF1AzNVc4opyLN+494RQEzaMGW1dx2I8aWpqBbsE
         8gCbhw37N7gYJ3eYrDsqqfGNM0osXAdfiqXWVr/J4crMs8Hz/bN5sk93GnGApwsb8W
         uRJIY891hOFIp3r6TznF2UlZqo0Pkysfj183IvtG0LRvNGYgyc8JhodOS1Ad5YM1jB
         1Xsmx2B3rhELg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDwwP2B7Tz4wcg;
        Tue, 24 Oct 2023 13:28:36 +1100 (AEDT)
Date:   Tue, 24 Oct 2023 13:28:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Vincent Donnefort <vdonnefort@google.com>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20231024132835.3b885fb8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k0SswMXsNpeYrw=DHqkGzWn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k0SswMXsNpeYrw=DHqkGzWn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/kvm/mmu.c

between commits:

  0e0fb2f69c1b ("arm64: kvm: avoid CONFIG_PGTABLE_LEVELS for runtime levels=
")
  8d35f7bcee55 ("arm64: kvm: Limit HYP VA and host S2 range to 48 bits when=
 LPA2 is in effect")

from the arm64 tree and commit:

  bf92834e6f6e ("KVM: arm64: Use folio for THP adjustment")

from the kvm-arm tree.

I fixed it up (the latter removed the struct updated by the former, so
I just did that) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/k0SswMXsNpeYrw=DHqkGzWn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU3K9MACgkQAVBC80lX
0GwiEgf/WjewjROZQjqQHvWX+KfblkJf99qbyAgFs76UWfg+BJDS+Gu18SMtcS+G
m5llZmDPUbjz5/wXXOOSUTVhXLIjrKJ6WQTfcGAdLUoONWNDJem9BruE4MSnWoOX
dGl1QRDZYI70A5OYc7QTbs0JfuUPdHJI4fpfvQ9mWt3qq0g/6QM6ozR26P2lqtgm
0OyteFwCAWTUId0ZJuYImXKDIHbMoEV9LQwccLQ5ufcxLCbUmPuYadU70quO7E4/
Y1mB2k5zmidla1yQPVkGnGFx0lWeO6fnS+Fe9YHbo0tG4vv8Aor/YSmWY7p52DM9
nUH9NbLFRgGdUCQyAzxrK+WTCPl5xA==
=u22T
-----END PGP SIGNATURE-----

--Sig_/k0SswMXsNpeYrw=DHqkGzWn--

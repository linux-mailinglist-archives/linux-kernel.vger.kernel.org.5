Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0976C7F3A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjKUXPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKUXP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:15:29 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508BD1A3;
        Tue, 21 Nov 2023 15:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700608524;
        bh=nfRskNbuIurQ4Tzlr2gREYCPCNCgX9hSPRaPXiyP3aQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vLkRV6DWMBoR9fYbRHOscgI/IXtp3Ze5dll0yPXJ2ALXsuSLZb0FBnIh2U7w7lxjp
         uW9IH6PG6oapUg704Cib6+lPi9Y22wyhRBqlMtoFaCG4TR5bxfgv6qSsueL0zK9FGF
         a8YwXfOlSNAWAq64EvUyv+zrFej/h7//jpnb2RSGYpdpSMpUyZUSRMg9th6MXa0fgG
         21LzQasVu0OwVFuMj7ldm7masX4L5BZ8vN0Dj2AbOt9pGIFTUyyXHHo+mryqXFAI3+
         4uBTmE+2y4G5lFsHHGh6JIFEmOszfnt7VMnz0WJbM1jxXQgrDy9NC/CJBOZRIo3i6g
         A3NDTlL6T820w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZgG4092Dz4wcX;
        Wed, 22 Nov 2023 10:15:23 +1100 (AEDT)
Date:   Wed, 22 Nov 2023 10:15:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp-gustavo tree
Message-ID: <20231122101522.1c1daa2e@canb.auug.org.au>
In-Reply-To: <26671a7a-c3ed-448e-a220-108516a50deb@embeddedor.com>
References: <20231121131903.68a37932@canb.auug.org.au>
        <26671a7a-c3ed-448e-a220-108516a50deb@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3+ys0CtKulkH9pbOL3Om_cW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3+ys0CtKulkH9pbOL3Om_cW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Tue, 21 Nov 2023 10:31:16 -0600 "Gustavo A. R. Silva" <gustavo@embeddedo=
r.com> wrote:
>
> I wonder if you could help me catch the rest of these issues by disabling
> WERROR (so we can get all the warnings) and letting your builds run with =
the
> following patch on top:

That seems to be working OK.  I moved your tree to merge just after the
fixes for the current release and added a CONFIG_WERROR=3Dn to all the
builds.  I'll keep it like that for a while and then go back to getting
errors.

--=20
Cheers,
Stephen Rothwell

--Sig_/3+ys0CtKulkH9pbOL3Om_cW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVdOgoACgkQAVBC80lX
0Gw8xAf/fVS3WSyypZKj2SnP1wnhaU+ysoO51+LoACBTR1uX1tPEkmO2KTeTjixc
0yPjy5KRAFPHAhb8EZkeJt/xMw9qfdO6XOQqFbBbZ/hbNY6u2+D/gYulsELEcQ6K
ildXMl7NUdUjrqwtLADUoMBScIWDprwTtZFXm62ti5/BbcapsCvCAbpf+YSbXvdW
c9HH+lR8pk2ndU9aFK5fDgGEFKLk77dkorSC6ed7yxWifou7GUoDXFP/RBIx4rXd
VPZeEUZGovoFTtzc+9X4SqBKJrHzO+T9tuCRwJxh0ujczeZET9C/I8PT7ODzCFAw
WQWPUujNkDBBGDkioUZJbQCnxBhoww==
=xp5K
-----END PGP SIGNATURE-----

--Sig_/3+ys0CtKulkH9pbOL3Om_cW--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6397CD1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjJRBqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJRBqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:46:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FDCC6;
        Tue, 17 Oct 2023 18:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697593598;
        bh=sK387LiYhZZbkHvAzGKdwmMCDSjgPgBjg6FV5LLzqpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zt2G0UiaO/1mn+X0nXtIwgkgTNsiZBffL3n0N05NwIK5isp1EjNvo3c76MQ/neNtB
         hc6VP5VVpeoeVkRTyy/UyH/bbfC3vHMeExB349w263/PeTAn3EIpIhz9y2k1XdwGCm
         vJuUykPIY9VV2fMvjvJYC3/1l6uMjNGB/9v1rAJBeYA/6VmHVgMXa5roiATUiek365
         fjWy5Sc6+FIGzDhpaTjzwyne/u7U8nIoA9aEedmF4XvTCNtcXUZ0Ckqu59kmw74HFC
         OIXDrZs/uJ3gKjhUecSC8yIz1/PGyfY/BxdE4SESAmcQI+xGXEqbjHDEDe4qNZIFoQ
         sK2Yzr4q8c4Zw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9DGj1v2pz4xNq;
        Wed, 18 Oct 2023 12:46:36 +1100 (AEDT)
Date:   Wed, 18 Oct 2023 12:46:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>, Dave Airlie <airlied@redhat.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: linux-next: manual merge of the drm-misc tree with the
 asm-generic tree
Message-ID: <20231018124636.4a973762@canb.auug.org.au>
In-Reply-To: <20231013114602.4cea19d1@canb.auug.org.au>
References: <20231013114602.4cea19d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IaZJTkHQNzxrMSOcD/.Bq6C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IaZJTkHQNzxrMSOcD/.Bq6C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 13 Oct 2023 11:46:02 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the drm-misc tree got a conflict in:
>=20
>   arch/ia64/include/asm/fb.h
>=20
> between commit:
>=20
>   cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
>=20
> from the asm-generic tree and commit:
>=20
>   052ddf7b86d2 ("fbdev: Replace fb_pgprotect() with pgprot_framebuffer()")
>=20
> from the drm-misc tree.
>=20
> I fixed it up (I just removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the asm-generic tree and the drm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/IaZJTkHQNzxrMSOcD/.Bq6C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUvOPwACgkQAVBC80lX
0GyvuwgAhp29SLuWA6DctRnsz791475JBOZwVFWtpwyBBs03kxF/2WpuKEKnUwNI
+NzfxlCwLtWwn6JE/Ef68oAO14GEVTZ2HFBtjTsxuUPaDdZmyPlq44569hMUPPmC
UXzXoeA1fFExegOG4xVHptitX7Jcm/+d1I/N1wrlHoFLoLUzll0WI9qKmlETH7sQ
oEwmcfSWCJAz67IQ8HlQoCALtXrpXgPHVcbq3+bocBJUecxqhSPdwRHhPdrSKp2G
0cOAjznwgJWPuP9JEbbpmDrMJhi5n6CNuemBO+6U+QqhPbQ7Vsn5ZM6v2fDdnKVq
9SeNy9GSuaMT2pbLFr2Tn0VqTa/NSw==
=cjeL
-----END PGP SIGNATURE-----

--Sig_/IaZJTkHQNzxrMSOcD/.Bq6C--

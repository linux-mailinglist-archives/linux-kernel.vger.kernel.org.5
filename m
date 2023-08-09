Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5052F775173
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 05:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjHIDhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 23:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHIDhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 23:37:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C35110CF;
        Tue,  8 Aug 2023 20:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691552246;
        bh=5K6DdPXa1vkuwi5HOOHYpyDluwjaZ9iS/L0MVwLWqKM=;
        h=Date:From:To:Cc:Subject:From;
        b=NUDbQ6tEcJuqTmfIdY89Z9T5Mp7g4L6krZEcEHX0s+lJrlmYQi7vCTPjY964GkIff
         AWo/h6mykHTIVCkPQQXIFsnr7R3qVE0STmVO6Iw2dZ6mXsldA2TjS2FQPNKfTW0Wnd
         ++dZxD6hiBMS9ii/PaEekCkW491vxdBPCZVi5cCk0T/4UlQ77sYBWL7zB68B5FvbiN
         DKr/A/LlE6sHCVyYSNsAEnzbnN2Ir1/NZrI1hQ7CnRE6h+dYV8q3eVqb95dl8WB8TU
         NNhegkdY+5tp3zvBP0m7rUr9BtjPIHQiWp2qeB2DzzoPtAit6TxpuZrU6d5jI4pOA8
         bk0ltoF81r8jQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RLG2r6sqtz4wxQ;
        Wed,  9 Aug 2023 13:37:24 +1000 (AEST)
Date:   Wed, 9 Aug 2023 13:37:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tty tree with the net-next tree
Message-ID: <20230809133723.2ebeddd7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Rau6+MCsb+9NMmQO3wcqyl_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Rau6+MCsb+9NMmQO3wcqyl_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tty tree got a conflict in:

  arch/powerpc/sysdev/fsl_soc.c

between commit:

  62e106c802c5 ("net: fs_enet: Remove stale prototypes from fsl_soc.c")

from the net-next tree and commit:

  80a8f487b9ba ("serial: cpm_uart: Remove stale prototype in powerpc/fsl_so=
c.c")

from the tty tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/sysdev/fsl_soc.c
index 528506f6e2b8,99fc4c3b94fa..000000000000
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@@ -22,7 -22,8 +22,6 @@@
  #include <linux/phy.h>
  #include <linux/spi/spi.h>
  #include <linux/fsl_devices.h>
- #include <linux/fs_uart_pd.h>
 -#include <linux/fs_enet_pd.h>
  #include <linux/reboot.h>
 =20
  #include <linux/atomic.h>
@@@ -35,7 -36,8 +34,6 @@@
  #include <asm/cpm2.h>
  #include <asm/fsl_hcalls.h>	/* For the Freescale hypervisor */
 =20
- extern void init_smc_ioports(struct fs_uart_platform_info*);
 -extern void init_fcc_ioports(struct fs_platform_info*);
 -extern void init_fec_ioports(struct fs_platform_info*);
  static phys_addr_t immrbase =3D -1;
 =20
  phys_addr_t get_immrbase(void)

--Sig_/Rau6+MCsb+9NMmQO3wcqyl_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTTCfMACgkQAVBC80lX
0GwCmAf/b3T229KwkdzSkY9YhOkuOmEAh3uIvo0+I10hr7AOkg5P8O7zGGXE6OLP
HxZjUVije4PS3G3VhrXTZs8f6hDXs1LRWuqabv7+SqQexiCFe63lzINkm1XSAaA0
ENdWOW1DXVomEkwB1dhfE0AzDvOX2BMyT86oINsnxx87pWC1lUMMfuuDIVBnVaKz
kKshMsOmYGcyvU8RtnXO9+rJk149hhUdAExNzjSme2kcSTdW1U75mMaOnWFqqgfz
czfCBOArqfRrx+bWN+BNqwqYM/gMxBk1Ne9K17Uy4ywc1s2pEa9VyVUadzRW74v7
sa1GQ8S2K8rLKUGLLME9Z6TV+QR3rQ==
=z0Rb
-----END PGP SIGNATURE-----

--Sig_/Rau6+MCsb+9NMmQO3wcqyl_--

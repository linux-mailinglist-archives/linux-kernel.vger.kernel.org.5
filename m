Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D507E7C7AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 02:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344245AbjJMAqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 20:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjJMAqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 20:46:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F20B7;
        Thu, 12 Oct 2023 17:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697157965;
        bh=Y2baROFxBkorrLhkUHImSq2kYpiq8E1PZRnYdQ6X+yo=;
        h=Date:From:To:Cc:Subject:From;
        b=lmxQcvtq92NM0e4MM/t52kHpPXhBP06zobAL8ZYfHoR4uKWfk0beJXNxUAYdMpt4z
         q+zm+qZLeYxLO8/GE1ey06jOp+xXBOEEx4wQzLcR0OaPnVUTXJPwhtb8x23d7WkA+r
         TOKWIXHf7Uv4vgkBwKPZ+7FyKpJ6NBeFCgp+1jad4IblYRFcl3sOXtX0t33b02imQW
         sYZmZ/Yi05vVdc+tbZW/NB9QW4EuvznCU94Q/JwVVLFfuzI8/UMxisNBfNvK6C7zA8
         nH6mHNZ+T1VPXujwE5HHRCwyHUvzK8GNPQUNR0EPPZmI9BzLXwnw7CZUiZDWxo+and
         upuXgCopENTyg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S67981Smlz4xKl;
        Fri, 13 Oct 2023 11:46:03 +1100 (AEDT)
Date:   Fri, 13 Oct 2023 11:46:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the drm-misc tree with the asm-generic
 tree
Message-ID: <20231013114602.4cea19d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ztYj8dNvgOzPA7znF1RIfx_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ztYj8dNvgOzPA7znF1RIfx_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  arch/ia64/include/asm/fb.h

between commit:

  cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")

from the asm-generic tree and commit:

  052ddf7b86d2 ("fbdev: Replace fb_pgprotect() with pgprot_framebuffer()")

from the drm-misc tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/ztYj8dNvgOzPA7znF1RIfx_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUok0sACgkQAVBC80lX
0GxB/wf/ROm0rGYuxU6UyfrdITGCdalANh65ZWTeadiilkzDmM3XJnoi/prT1yib
vMqGzRtE1FVU+axAP6e7KWCT6zkNkFB5dGcBy8wbq1tI2Tni0CH7gey3SeCdd9/o
4FWMP0WH7Mk9zAjNUU+hl/5aPvkSmLQtqZSoFpiFCrR4O+AzaSC0EmF9UEmmnvar
hh9ptCupqQsH7c/6eGtt/AS6biv6K448Uv6h0RJoY2TixDSeZyOly01sKWAesGmX
nol+1oi1pCrb8vw5HxrC+jPt61LbtCa+FKNXUWFB1q6qeBCsDGp812z95o7dxv4h
zb/s5SJY90S7TiFlQpfl/kFDxbi+Jg==
=huQp
-----END PGP SIGNATURE-----

--Sig_/ztYj8dNvgOzPA7znF1RIfx_--

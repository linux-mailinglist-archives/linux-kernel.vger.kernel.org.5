Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB52C7D292A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjJWDr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJWDr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:47:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C0CE9;
        Sun, 22 Oct 2023 20:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698032843;
        bh=SziYY1ABMf8DuL5z0is9ByCbU2OtLabxluT0AfjFci8=;
        h=Date:From:To:Cc:Subject:From;
        b=Oetn57SUZrJ2AW4oMKUMSKY15V6Sl8gxYfS8PDjS2T1l7+4SzuBtt+LUZHiOBlyN3
         n2dOU5oW8Blse0X+2xT9bJrFFmjhQS6DBsIAXOXqM+0U0BjtRPsVwnaJF6YGwaIXJI
         ppmyctlqDICZkwVGHQHs+ZNHtwKtTv/8Fo8m2YPCwG6Vu3ks8Jt+G77yvcd+mtPf0S
         wzA/2TnB/A5U9/5MxfTtmhMApbvgt2jsTLLODcRI5Y7cpiwAKzDKu3FZy5VLnVkf3A
         F4b27HmlpSOSKe3Ku3S41CufgluvSLQOARp/bOM17A3J1Dylcpx5CxecOvWIPGJMUc
         dVZjt/YTHWLag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDLjk2ZTFz4x23;
        Mon, 23 Oct 2023 14:47:22 +1100 (AEDT)
Date:   Mon, 23 Oct 2023 14:47:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Benjamin Poirier <benjamin.poirier@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: linux-next: manual merge of the staging tree with the net-next tree
Message-ID: <20231023144720.231873f1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1k0w+OwPEDYvUpmeB8AIS_y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1k0w+OwPEDYvUpmeB8AIS_y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/qlge/qlge_devlink.c

between commit:

  3465915e9985 ("staging: qlge: devlink health: use retained error fmsg API=
")

from the net-next tree and commit:

  875be090928d ("staging: qlge: Retire the driver")

from the staging tree.

I fixed it up (I just deleted the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/1k0w+OwPEDYvUpmeB8AIS_y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU17MgACgkQAVBC80lX
0GxEkggAke6CgrGBCpIMbig3gO6i+5vRazhxfigGMdsUJIaAgTtTkmgZy3ziEUO8
zqA/zfUhemkK4MfxzCDnJlSiCB8fM7qkuTf9u8lN3l/Bv+jqIOPySsNFyw+6z01h
PE5ngUL9y1wLl0r2ShhJn9VH6VYeTGcgCMz0g9GlyPvjTDJ5rJkXreS34MF7FbIK
hlPy1KFVwqok/Z1KTFDyuiaJSRTXEtTECsoz4tHOKksRDE5jB0KV1gTl4wB9uFpQ
tbkRYzzXlYuxUSDKhENFsJ1wDky2wRZsJlFQbRjDIoimtwn4xwI3z0SNujpRACI4
n2Qmw+PDVT65lvukobXDl50hX5WGjQ==
=dcuf
-----END PGP SIGNATURE-----

--Sig_/1k0w+OwPEDYvUpmeB8AIS_y--

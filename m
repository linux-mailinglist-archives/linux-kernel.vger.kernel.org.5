Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E1B7BEF41
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378152AbjJIXhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379014AbjJIXhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:37:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D2B9D;
        Mon,  9 Oct 2023 16:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696894665;
        bh=ddNE5NrNAX/1w2VkhTFnyud5eL2I/kfyP4zPb62e1cc=;
        h=Date:From:To:Cc:Subject:From;
        b=q+2gCvS4nPDQietobOycwMGzGEQxQHikrGGnmDGQr+8jCewmLCRPkDHB5XB/2CMNm
         tUw0TKb36TjV6i6LIO8ZKZqAIXIbnr94WBNN01Qxs/556b7CKovk8Uz3KYcurqz+gD
         Fk2+jStvwS+96KwutDpWem4IGcX/WB0WEVSf1IBHUTSkhu/8AZfpoBBCGM6eQJQf5m
         z0Ev9QWQ74E6xkp8Pqh0xtFWmYgmNgWcnkbjsIis1b3mXSXIguJTujVsfSDXlz+HM7
         EghEMtPzoH5eChFk35Zcyt3OusB0/hX6jWmFXphsDWtHYDbZIyifMTJvYu6xNRyO/w
         k0MsdZelqolUw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S4Fnj3LlKz4xPc;
        Tue, 10 Oct 2023 10:37:45 +1100 (AEDT)
Date:   Tue, 10 Oct 2023 10:37:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the ntfs3
 tree
Message-ID: <20231010103744.2e7085a6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5sAmW5pUwKcL7njVm.uDAA0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5sAmW5pUwKcL7njVm.uDAA0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got conflicts in:

  fs/ntfs3/inode.c
  fs/ntfs3/namei.c

between commits:

  3f2f09f18972 ("fs/ntfs3: Use inode_set_ctime_to_ts instead of inode_set_c=
time")
  f684073c09fd ("fs/ntfs3: Refactoring and comments")

from the ntfs3 tree and commit:

  82f8d5fde753 ("ntfs3: convert to new timestamp accessors")

from the vfs-brauner tree.

I fixed it up (I used the latter changes) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/5sAmW5pUwKcL7njVm.uDAA0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUkjsgACgkQAVBC80lX
0Gwxxgf+P+Ww81bHgBFSgoUmiyjvbQCXd/sc/pTkAe/Yfk/wpzCq/RbDnJgId51p
NZasMonRGaLaoWJWDJSgLL9E8HCkGO0OiSZ6mydAv/bqV89//WmPd0HHmkdteNpv
bUEjaABeVLH97VZYl2MsGDa4aU3XfEIErcUKr9e7XRsYderHHvllA+kEHOgx281Y
KfIUNKXlwnof9yJFWyFxlbRcux7LTuOqJPC0vq0OlEASfsR+spMX5l4rQmksz/WW
ZiziK8zOgdb7Ft6ZOlGdNOJ+oODevZlA+WjsSiVn3sAb88v7kyEqh4e9BcQAzCD3
uxcaY7ejMqGg4PO+D9OT1OuprceLNQ==
=1l6h
-----END PGP SIGNATURE-----

--Sig_/5sAmW5pUwKcL7njVm.uDAA0--

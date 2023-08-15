Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072B977CB8B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbjHOLP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbjHOLP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:15:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70FDEE;
        Tue, 15 Aug 2023 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692098127;
        bh=j+wLZtT8TZ9O7RSdGhc+l0TG8AzzrIEOSPYUKcNOiaw=;
        h=Date:From:To:Cc:Subject:From;
        b=a9SUAuNfc3c+Phchmwb6RZWVm2XtUb8lWHE2n8QMF7YFd8y/BsaXPQ8yBsYFiVPVf
         G+/P5WD1SfoyTvvgwp8T0qRxoAAHwKG+rEC9/gS+7Uk9w4mavMnZLDxWiDfYvyp+Jz
         Fjm0D5MYrG7xlnwZ/TC9azkDA3TWy1+ZX2CxldNrB2vqIw6LizckmaI8nns+mgGioA
         0t9BYhuGrENy3J/8mq7fXBL7nXZA18yPKpUUFWZT2iGR0ldXzyXS7gCynS3Euy1Z0G
         p/5ULrUOWRLAN30wCvW13BVDtuyALerM+J7O7t1zaJgkAUDFfVfMIr3nruI4FSrB0W
         EmOde0FY+u5+Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQ7wZ5h50z4wbP;
        Tue, 15 Aug 2023 21:15:26 +1000 (AEST)
Date:   Tue, 15 Aug 2023 21:15:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the vfs-brauner tree
Message-ID: <20230815211525.0b9ad0d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XEiR/6y00HBff87uysQM6iu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XEiR/6y00HBff87uysQM6iu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (htmldocs)
produced this warning:

fs/inode.c:759: warning: Excess function parameter 'kill_dirty' description=
 in 'invalidate_inodes'

Introduced by commit

  fc3b2b8e7199 ("fs: simplify invalidate_inodes")

--=20
Cheers,
Stephen Rothwell

--Sig_/XEiR/6y00HBff87uysQM6iu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTbXk0ACgkQAVBC80lX
0GyOHwf/e676dy/wSDz2Vub1F44Tbn6c7JI4AbcFBTe8JkAZyGUp9FCN564uB/b4
NpCF6v43TJTsjP687e3rGAKom9/e/MRy65ta2wD28aBCNHWq3/yHjJTbEjNl+udQ
O4qBgofr5Mlx0r/w5FMl22Z/69BRSO75xMpDlF5gcsR2ecNEnsTiWjuFXqt7T51k
MugmF/5oAC4W0rwAqTfsy/uKRIaG+p2Mup1FpC3ZXA2Pg832vuAWVCSzbMC9ctgv
nqHJACO9AepzYpfKbeFLmsl3nnl0M67D0KZTbl8Kz+L1af4VhUKcY2i6W0A+j9wW
1pvcg+HLfjl5/4x1ZKtUg5Lqfw15Ow==
=g12I
-----END PGP SIGNATURE-----

--Sig_/XEiR/6y00HBff87uysQM6iu--

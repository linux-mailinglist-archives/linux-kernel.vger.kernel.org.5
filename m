Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA6B758A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 02:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGSA4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 20:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjGSA4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 20:56:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65071FFE;
        Tue, 18 Jul 2023 17:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689728076;
        bh=hTchEKX6cnJkYCHL4oAppGBgjyw3HhGMPHv7Zn0VTik=;
        h=Date:From:To:Cc:Subject:From;
        b=uT9Dl0z22yuk1/ozsIFsUWy4kSAqAINbPwZs5sRGYtwfxW0pm/9XnGLe69d/PEkvh
         Fp6sjzSkvU9rC9GiOIW8aGY305NJKCNTNR8sJ+2Tou45SuPADXPLgv4fIK29ZSCIkU
         QV2jL4UqxsfejEp1mGDisZCdhPttQvXYMJjqlBcONQKYyLN+ZakBC1iKj2LMfxPopF
         f+PNm7Ug6aMzzwUH7HYAnILnWbcJLm7+rtAqjpUnMIj6Fsm80RwWDboS2jSMy7K1cw
         aLjBttfIG5hXu+3XrJXtPAMY+s0lqxJxf6cleiYzFVIwdWn9UdP1S5pRznYVtgHFqe
         JEbFVVA9BuEoQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R5HQh0NWxz4wjG;
        Wed, 19 Jul 2023 10:54:35 +1000 (AEST)
Date:   Wed, 19 Jul 2023 10:28:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the btrfs tree
Message-ID: <20230719102813.12e24eb4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O/W8eXJmUO3GjyG3BVBBNrA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O/W8eXJmUO3GjyG3BVBBNrA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the btrfs-fixes tree as different
commits (but the same patches):

  13c2fe254dea ("btrfs: fix ordered extent split error handling in btrfs_di=
o_submit_io")
  31dabcf9cdca ("btrfs: set_page_extent_mapped after read_folio in btrfs_co=
nt_expand")
  5597efed9886 ("btrfs: fix iput() on error pointer after error during orph=
an cleanup")
  8e5955e7a539 ("btrfs: zoned: fix memory leak after finding block group wi=
th super blocks")
  9a976a7a78a2 ("btrfs: use irq safe locking when running and adding delaye=
d iputs")
  ce23502dff23 ("btrfs: fix warning when putting transaction with qgroups e=
nabled after abort")
  dfcfcaf6d1fa ("btrfs: raid56: always verify the P/Q contents for scrub")
  e6d11b4a5648 ("btrfs: fix double iput() on inode after an error during or=
phan cleanup")

--=20
Cheers,
Stephen Rothwell

--Sig_/O/W8eXJmUO3GjyG3BVBBNrA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS3Lh0ACgkQAVBC80lX
0GyCqwf+L8W+qqq9KGRnnjMlfTnM6GyXaftsB2JTGDu0pD07tPNjfa3ZUjMGd4uT
+lABeByTExXsCF1SjY2wPktFNlnCGnikKklRYwCCZPyROawyO0f+z9q/rT5b1tuk
Ge22Kp7SmZfmGnWLmbB0CNGfW+c4q59JOtUjJZJX8PTL3BCBwHtjMDKXm70bKNcD
9quSlp3bZEJG1/4TBVWaivEv39PZ0PrSdz10qD0E6LN6lJTBO+vNOhEulOx9kutx
XI/taz1T8nApj03AuRUs6DVCDeyh+5DIeJzFJW8/gWCAGrl+4FcWGS8ZklYBO0tq
FSSLK+qvQD8j2KDvJ19c9Hu8EVs2Qw==
=M7DR
-----END PGP SIGNATURE-----

--Sig_/O/W8eXJmUO3GjyG3BVBBNrA--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B8F783961
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 07:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjHVFcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 01:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjHVFca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:32:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3E512C;
        Mon, 21 Aug 2023 22:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692682347;
        bh=oUMRanxDvd3x3hEhi6gNsYYyAgxZ5IkL+PHEmiGdvIo=;
        h=Date:From:To:Cc:Subject:From;
        b=DLgWkKzPAo21FoJ2kMy3DZnlTNSRL84V8ujRhIjMSy0e8qTerIBzgPJ/Q3K+Pd6W3
         8s9XbuEchpLHKO08o8Q7G6EzVXcfuDBp7pqVZ//viH17vhe35anM15Isf131aDpfPd
         +uzyA3s046cFm+GBeLRijq+DBX0iamhFsNmUZDBPREYDTyCAUMc1qHHKS4YoqTYexz
         3LFsG9qUFFhui9oJTH0ni0Jxzce01X2dOGbP6LH+6dmQcKFxoURQXeD3e65vQ7o/5s
         /+zX9BU+A9g/sPLiWE//XZf8SzrzdNTS7/zrND+Hh4Sqfn9xOPHgJPCankL5oDW20v
         VGm2r22jmaShg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVHzZ6JDQz4wb5;
        Tue, 22 Aug 2023 15:32:26 +1000 (AEST)
Date:   Tue, 22 Aug 2023 15:32:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Manish Rangankar <mrangankar@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the scsi-mkp tree
Message-ID: <20230822153223.0a497697@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TiiCvYs2+EXynnuezqpmRAI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TiiCvYs2+EXynnuezqpmRAI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scsi-mkp tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ERROR: modpost: "nvme_fc_rcv_ls_req" [drivers/scsi/qla2xxx/qla2xxx.ko] unde=
fined!

Caused by commit

  875386b98857 ("scsi: qla2xxx: Add Unsolicited LS Request and Response Sup=
port for NVMe")

# CONFIG_NVME_FC is not set

I have used the scsi-mkp tree from next-20230821 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/TiiCvYs2+EXynnuezqpmRAI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTkSGcACgkQAVBC80lX
0GzQPAf+NlHNl5lKb6kuoFdHKqm28b9s1OlPSQYqRJmh7jBu9asPsBN81AzyRh3k
+kWYfDLicdU7VjUnII6bb7qfrGEpAa40f9/6fO3eYvEFd81snSkiJLW3E14+s3WY
wD93zjKoetT3PxE+yFpoykbSF9BPf0bE6aBFivpiHj/y5DdjHVY74GsNIraf5xAn
72WPXWOgFAmA7Yxte1RZ/xDixstd3YpKC7oNAabJULwFbmwgDT2tm7q4fZzzBoCs
UOTbZKFut7lW1PgRENY7lKDdURAWiWw+Lg7gxkrCXtkMGDxI5Way/SdgfhldfjHU
ocBAMOPFRNiQVEB4EhOO0naPnIYtOw==
=wIQ6
-----END PGP SIGNATURE-----

--Sig_/TiiCvYs2+EXynnuezqpmRAI--

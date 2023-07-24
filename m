Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1262075EA55
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 06:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjGXEFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 00:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXEE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 00:04:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25387E3;
        Sun, 23 Jul 2023 21:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690171496;
        bh=vfrMny8FDRkS9ug9L14TgacUSOvb+OnKEnU5CeKziPg=;
        h=Date:From:To:Cc:Subject:From;
        b=FKE1jGc9huXZi+6HETgpI/7VPA2+LVIg06AKXEH5CX5o+4flsH8GNDaNtNPk9kOoE
         BBWAbXaqJF2RIwDIAMTH7GsOcIQ9QGahvjvCss9oSI6Gl7m4Un4Xj6SomQw0/2YJiO
         nGrmZkb5a8sJXIU/JKF5KL4/R9QoTFUA6H5hlFp9wDvWo4n1skngHisk+sbFua8UR6
         kexpeD6uNS+ahSdoa8qlsVHN/VQyDri4Bsb8H+NM2yVfYnR5PNZ4m2tY3T04lQR2EU
         3eNcym4A74c8lcoHAMICDF7ROLoku43uAi1E2QxvuyHKUfNiuULCvxOEo2OIA1Jdb3
         37sF7GdoqgFFQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R8RQ00cS4z4wyY;
        Mon, 24 Jul 2023 14:04:55 +1000 (AEST)
Date:   Mon, 24 Jul 2023 14:04:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Can Guo <quic_cang@quicinc.com>,
        Ziqi Chen <quic_ziqichen@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the scsi-mkp tree
Message-ID: <20230724140454.71047ed4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wCavwK+1o4Pyby64b.myWZ5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wCavwK+1o4Pyby64b.myWZ5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scsi-mkp tree, today's linux-next build (arm64
defconfig) produced this warning:

drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_mcq_esi_handler':
drivers/ufs/host/ufs-qcom.c:1652:31: warning: unused variable 'host' [-Wunu=
sed-variable]
 1652 |         struct ufs_qcom_host *host =3D ufshcd_get_variant(hba);
      |                               ^~~~

Introduced by commit

  8f2b78652d05 ("scsi: ufs: qcom: Get queue ID from MSI index in ESI handle=
r")

--=20
Cheers,
Stephen Rothwell

--Sig_/wCavwK+1o4Pyby64b.myWZ5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS9+GYACgkQAVBC80lX
0GxeCgf8CboXixtCEoxcwzCDxOmS1rmVmVx/tWmybRIxFEKw+w7ZvkLFZOjgTzbs
YOwDufh+EKDrlLEn6w+YzMAZvdEfa959tPHopfxnARi/exmex1SbUoA3gVhovQUN
q33/i7H/A8ppqH4dlzhJX7EnU6Xrng1RfxlLqDveErBMVIY/NEj0xOK1OwLKTM2o
mZ1XZfh+VI0iv6rOoncmyVwsZjLmrjc/wZKlx3/BMg5Ojfkfgkjh6XyyjOUSoCHC
on5/7yFmlCxyKuQunmzsBzGdbrZr0Fj7UduyQfm4fSJ2IziCkYCYwcfoNZgJqBou
TuBRCiNZLLcdZiCuFyaosYL3TncHeQ==
=btDA
-----END PGP SIGNATURE-----

--Sig_/wCavwK+1o4Pyby64b.myWZ5--

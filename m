Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A136E78A4C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 05:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjH1DNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 23:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjH1DNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 23:13:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5414DC7;
        Sun, 27 Aug 2023 20:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693192386;
        bh=xdPMWSNE6VetcUdvX74oZqwxtWMU1dNQ9ebGgJ2LfMs=;
        h=Date:From:To:Cc:Subject:From;
        b=RSxdFGRSSr2UsHez4nEGUlrsXwhLPM1dfqGSa8+VfnX/2KDfc2DozOroxgdOpfHjp
         2ZcZ/Qd0vszxE0uzfIb+jd9DU9gkTfBHU6hwTMTLb6RDrxubulGW6NHLVnkf/lbnpH
         Wl/4hXhdfEld1JRsMOBGsXDE3/dk7f7JzveBMTHjFKEv3VD1Qbj/eUaePCmQC39+8m
         C6/39szSTH5DYEH4fFKlHP3AkxXlMqyi0DHWZzVukjqPu/3x0JUNBm8eFTQsLqMjq/
         Wh4CUX6vJhZhESNYdzMekbqu0It6o/LXVBHyqP4m8CBfFtH/AYJp8R/IL0MYmvKYUd
         jDeJEGUOD9Jlg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RYwc1601jz4wxN;
        Mon, 28 Aug 2023 13:13:05 +1000 (AEST)
Date:   Mon, 28 Aug 2023 13:13:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the scsi-mkp tree
Message-ID: <20230828131304.269a2a40@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tLvpup_R6e7phZvqXMqkbIi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tLvpup_R6e7phZvqXMqkbIi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scsi-mkp tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

drivers/scsi/qla2xxx/qla_nvme.c: In function 'qla2xxx_process_purls_pkt':
drivers/scsi/qla2xxx/qla_nvme.c:1183:20: warning: unused variable 'fcport' =
[-Wunused-variable]
 1183 |         fc_port_t *fcport =3D uctx->fcport;
      |                    ^~~~~~

Introduced by commit

  27177862de96 ("scsi: qla2xxx: Fix nvme_fc_rcv_ls_req() undefined error")

# CONFIG_NVME_FC is not set
--=20
Cheers,
Stephen Rothwell

--Sig_/tLvpup_R6e7phZvqXMqkbIi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTsEMAACgkQAVBC80lX
0GzWigf+NCR/T7pwVC5tHg01hvW0zKPQYJvuV3m1Ej58ExxuiCLxDjyfNBig0RA0
4OT8iMqOoBVGUzrSxx03GLM+a7m7bnQGsnvh50BCEK5WrdTod464+ODF+9M72Whb
1JOzWZSNkLzWYiRGGgUpJYdcbGHJmXYEM+06wyzEsmmdA9W3tn5C9JpqrCEV98/I
7MCm07Gthw0OEP0wepa92dd/fwQtn/Ac3Ka+XvEtEuPsHALXD4IWMZU8JSxg17Ai
TDAun6btNQoPnhgIpIniDTWfAc54fLbte9x6r8QZdFuG2srEEmk5HIeZW6p+6yZ6
FlU66Z9LNhzHLFh+AJ2rETPpWMYuHQ==
=6p5s
-----END PGP SIGNATURE-----

--Sig_/tLvpup_R6e7phZvqXMqkbIi--

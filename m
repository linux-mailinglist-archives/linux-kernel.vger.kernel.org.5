Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AE97863C5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbjHWWzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238791AbjHWWz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:55:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B379E50;
        Wed, 23 Aug 2023 15:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692831326;
        bh=GTP6QrOTPTS425744/rXRFSGR35B6UyhJlhIpbQIKFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BnxWvcTyHIcCJIftp3yD0XGpguV8ZpdCIhPvM07WxNcLz1WagyNwrH76WPAgj2IFT
         C4qiuV5Nqc8t+4bL4hqC1RJOvNXUdCNYROCaCubmB9crf8LuPV3X9gkxC5Kfj/GjuT
         gJ888wsl0HJ25yJD8pDI4j7D8BJHPAFVRFctrT8mUCt71LaGtzkuknhmlR1NcFuq5X
         tYNcv8aqiThZ7SchwkH7RZ2G2wIbrUQ6AG7foh92aNsL/2grOzJnLlpovBH7FqEVHV
         ql2uROFVz5F0Vh+DBXrTP7GEEj7xPllaVfnQ+KZ6+kz5aq77WniCcUdyZHVQK1nMuy
         TT66EorMtuQVA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RWM4Y6FVCz4wb0;
        Thu, 24 Aug 2023 08:55:25 +1000 (AEST)
Date:   Thu, 24 Aug 2023 08:55:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Manish Rangankar <mrangankar@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
Message-ID: <20230824085523.165db2d0@canb.auug.org.au>
In-Reply-To: <20230822153223.0a497697@canb.auug.org.au>
References: <20230822153223.0a497697@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AmqzOcCE+RdfHaM5fbEKGQD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AmqzOcCE+RdfHaM5fbEKGQD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 22 Aug 2023 15:32:23 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the scsi-mkp tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>=20
> ERROR: modpost: "nvme_fc_rcv_ls_req" [drivers/scsi/qla2xxx/qla2xxx.ko] un=
defined!
>=20
> Caused by commit
>=20
>   875386b98857 ("scsi: qla2xxx: Add Unsolicited LS Request and Response S=
upport for NVMe")
>=20
> # CONFIG_NVME_FC is not set
>=20
> I have used the scsi-mkp tree from next-20230821 for today.

Ping?

--=20
Cheers,
Stephen Rothwell

--Sig_/AmqzOcCE+RdfHaM5fbEKGQD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTmjlwACgkQAVBC80lX
0Gzu9gf9HOInnH+15c/edNF/xrAAK8pFGSP98EM2DOQyaXFpTPmlhYmtAzVyk3NU
53dV7cge+Wyb9OtJ4DhTP0n1kKzmdXRLoPig800BFbv2Uqwuf0u8jd5bIpl15ug4
DV4+IWaEbrogRZn/i6SKk0fUIBzdpbAPGp9j5K+I9D3vhNRsnGKsw8jRAxzI4+Ek
PF+81CBah0jUZluXnm3YvzVFaVPLQ257/DvsZflehtruLNjYyOWTAATuNs7GAUQs
Lru6d55gkVEMaElvnnTkKQABzGfdPdwjPzmwJUxEBbQRJKdhFipXux/00gxKxqzs
+VM8ok7kEp7qs3/lIAmHfClUpQZToA==
=gCfY
-----END PGP SIGNATURE-----

--Sig_/AmqzOcCE+RdfHaM5fbEKGQD--

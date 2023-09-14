Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47F87A1194
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjINXTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjINXTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:19:42 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9510D2707;
        Thu, 14 Sep 2023 16:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694733573;
        bh=5rDkQLDZ7KY1y8OYYwwbj5hV/LWNM7lyOf4IRDHyA2E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Anb3k86T8y7NywcfuTVM+pXmC8XIPSYYmnZTkirsqcidhgWbKHTKaI8ev5VGWqABD
         liA4Wl1IOjVNlrWwId1ILpRqsxxmVMplnE/SiLfxqC4T49gLzIRBG+q+JywM91vWl+
         V3h/P5mYyjpR9Ao4bKT4c1GoU78P0eZ6yfSOWMrmxmMxzTx5HlSf2HDnFWyheKmOSE
         vgdcp7e/zmaiekPhza1tFWecGKC0ZMJsKqxcebN3V1h18xvdETAfBRQ4KVV15gd0gD
         e64r+28m4sENjqTukKAQD+2ZIYKpEBlBPY3NFT2s2SEgA9OZQCwNvhsSinAEZPlJoD
         PpIyXJdRphW2g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RmtZF0LYCz4x3C;
        Fri, 15 Sep 2023 09:19:32 +1000 (AEST)
Date:   Fri, 15 Sep 2023 09:19:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jinjie Ruan <ruanjinjie@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>
Subject: Re: linux-next: manual merge of the scsi-mkp tree with the mm tree
Message-ID: <20230915091931.62f860f9@canb.auug.org.au>
In-Reply-To: <20230906103905.0752736e@canb.auug.org.au>
References: <20230906103905.0752736e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9KcqI=VU0O8m6CD9gVtQm0_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9KcqI=VU0O8m6CD9gVtQm0_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 6 Sep 2023 10:39:05 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the scsi-mkp tree got a conflict in:
>=20
>   drivers/scsi/qla2xxx/qla_dfs.c
>=20
> between commit:
>=20
>   d16e04dc79ed ("scsi: qla2xxx: use DEFINE_SHOW_STORE_ATTRIBUTE() helper =
for debugfs")

now
  edcac2e0d679 ("scsi: qla2xxx: use DEFINE_SHOW_STORE_ATTRIBUTE() helper fo=
r debugfs")

> from the mm tree and commit:
>=20
>   d0b0822e32db ("scsi: qla2xxx: Fix NULL vs IS_ERR() bug for debugfs_crea=
te_dir()")
>=20
> from the scsi-mkp tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/scsi/qla2xxx/qla_dfs.c
> index debb14d71e8a,a7a364760b80..000000000000
> --- a/drivers/scsi/qla2xxx/qla_dfs.c
> +++ b/drivers/scsi/qla2xxx/qla_dfs.c
> @@@ -662,8 -707,8 +662,8 @@@ create_nodes
>  =20
>   	if (IS_QLA27XX(ha) || IS_QLA83XX(ha) || IS_QLA28XX(ha)) {
>   		ha->tgt.dfs_naqp =3D debugfs_create_file("naqp",
>  -		    0400, ha->dfs_dir, vha, &dfs_naqp_ops);
>  +		    0400, ha->dfs_dir, vha, &qla_dfs_naqp_fops);
> - 		if (!ha->tgt.dfs_naqp) {
> + 		if (IS_ERR(ha->tgt.dfs_naqp)) {
>   			ql_log(ql_log_warn, vha, 0xd011,
>   			       "Unable to create debugFS naqp node.\n");
>   			goto out;

This is now a conflict between the mm tree and the scsi-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/9KcqI=VU0O8m6CD9gVtQm0_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUDlQMACgkQAVBC80lX
0Gydngf9FVDu2XWBKDn8wZGAqjKggJDLK3s1iuFV/52YWnRf4M/diJjdnIVal3mp
m3q5KP/vRRhzncMN+sz37S8+nMQhHrLxlErQl0m60KrNrAC1tZKJOnXqT/s8pBCh
Pb63hdVMrGDP1Af8mKfsLkEXhHsOWP2MmMoGkrSUOVCzxYgMvkMHIxE4mdSLkGCh
9T18g3+xfuKFiX/6BNozFGQCOUi/4gw6KRbRPeCRCjuQLy4y7SLk5D23id2fdMN/
sndqKrTHwoX4gF6NOs+ezKC4mhf/gG6pcYnYZAiFnOa0WF9X/DuIRGpW7WDk0K5+
HSnsjsOP6dnOURVOwg1cyFSn0u61pw==
=YdFl
-----END PGP SIGNATURE-----

--Sig_/9KcqI=VU0O8m6CD9gVtQm0_--

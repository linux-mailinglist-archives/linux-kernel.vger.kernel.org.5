Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5735F7D29BE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 07:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjJWFr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 01:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWFr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 01:47:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA20D5D;
        Sun, 22 Oct 2023 22:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698040042;
        bh=iJafEpyiFghwHa5AZqZW4zZtxv8CEENlEv9PKlWssUg=;
        h=Date:From:To:Cc:Subject:From;
        b=tfnrr3jsn1axBZ2dZgdsmepmqvXtaUpU/vvCOGnkAzKgzq65hvv7DxoeuvnKxuUsY
         FCpEtEXkZncMYpIMzHoVySvgxx0D3rX3QXPE9uYZHXMa+RBU+AqZ4D56qF++Ha1Tz4
         Em0mzSxrs3Va9u0N/YueSv6NjRjded+EN6bHKVdBVVBVR/bvZgUiueWVhbdSF192PV
         VJxkgQee5LzlCoUz6xjtwpwLnpuHitsLUh+Ien5PfY4JGzxMe6EZQW4iVu+/SBElkc
         DmQwjux/JcDE5WPjRGIsa2TcaflH5HpxTsLf7KVEo1RNiacOyht9vJ6+bJgNqZqpvx
         oOzNqhZ4mwoKA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDPNB2K8hz4wp0;
        Mon, 23 Oct 2023 16:47:22 +1100 (AEDT)
Date:   Mon, 23 Oct 2023 16:47:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Joao Martins <joao.m.martins@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the iommufd tree
Message-ID: <20231023164721.1cb43dd6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ilgvcv_2ajYK1GtbNBvqEFm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ilgvcv_2ajYK1GtbNBvqEFm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the iommufd tree, today's linux-next build (htmldocs)
produced these warnings:

include/uapi/linux/iommufd.h:433: warning: expecting prototype for enum iom=
mufd_hw_info_capabilities. Prototype was for enum iommufd_hw_capabilities i=
nstead
include/uapi/linux/iommufd.h:497: warning: Function parameter or member '__=
reserved' not described in 'iommu_hwpt_set_dirty_tracking'
include/uapi/linux/iommufd.h:512: warning: expecting prototype for enum iom=
mufd_get_dirty_bitmap_flags. Prototype was for enum iommufd_hwpt_get_dirty_=
bitmap_flags instead
include/uapi/linux/iommufd.h:542: warning: Function parameter or member '__=
reserved' not described in 'iommu_hwpt_get_dirty_bitmap'

Introduced by commits

  f87900f25050 ("iommufd: Add a flag to skip clearing of IOPTE dirty")
  d2b3a545cdcc ("iommufd: Add capabilities to IOMMU_GET_HW_INFO")
  1337d793ea25 ("iommufd: Add IOMMU_HWPT_GET_DIRTY_BITMAP")
  ccccda6d18bd ("iommufd: Add IOMMU_HWPT_SET_DIRTY_TRACKING")

--=20
Cheers,
Stephen Rothwell

--Sig_/Ilgvcv_2ajYK1GtbNBvqEFm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU2COkACgkQAVBC80lX
0GzFoggAjTVp+MMD+HeiI6MsD4B1T69/ZkjrIo2bItyqqLi4e++AjYfz/fEPrvJi
JxvuD9owJDkz0FatvUXsqQDgam8phW4jbTDwOyDf1trAK04wlW0Pb3zbEPppbJxi
P4Cw/Mriye6VnbPNZRdO3eGF4BGoBxo4fpfsIiZpYNj0xt5NF014cdN9W6aGYLw+
3tgHT+V4J4QYFSKdo+BYevyQo1P8UlDhURY+QSliKWbihEU5C2V3IN7NhuQVfU92
tM9oEz7e8LY2azpW5JdH4BMQeSydRHtauoQUQJlC7kKOJ9SRW2n6Xjg+HB9hOU27
YhHkz/KrnAPWzgSwtVlPomuNLiTJ6A==
=69PI
-----END PGP SIGNATURE-----

--Sig_/Ilgvcv_2ajYK1GtbNBvqEFm--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D1A7D60E8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 06:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjJYEfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 00:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYEfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 00:35:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2AD9F;
        Tue, 24 Oct 2023 21:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698208497;
        bh=SlmCHvb+gPuTe/iK2j/se12Dk/VBxmoZuPgcWC6Sdgw=;
        h=Date:From:To:Cc:Subject:From;
        b=RnkWABzF5rKYQOuI/mMByI2zQqog3xDsb7nI313lOY6K1o4CdvB7BkgEkSHgaYGr7
         yonpLamzc5ZyJlvI+m+MPJpyF1evY5Jcwhx8MQ7BRd80AJyLIz5TNiN4ZzdMWyeYk9
         /uV1lT+ec9wp/QU0ahHqkOvxLLMy73YZu4u7qb1U2vp9NcYSxWeEq4Rr3G4TTPUgDa
         DOuyZOlphUxEzBmkZ/glDRELHkTXgY5qdv+OqkySp4bWbuZbXIHnx8ROgIWIAZeTP/
         Ld9FCgWV/2z1iXh1YrVScbScfxOrI5zjQ/qv6Y4kdpALUUJFgob08zExjddzDEzFeZ
         RJa6oeUCpFHhQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SFbgh0wRrz4wcg;
        Wed, 25 Oct 2023 15:34:56 +1100 (AEDT)
Date:   Wed, 25 Oct 2023 15:34:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <20231025153455.283c5b12@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MPnDetDqs2Pu0DORcE=2QfW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MPnDetDqs2Pu0DORcE=2QfW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommufd tree got a conflict in:

  drivers/iommu/intel/pasid.c

between commit:

  c61c255e114c ("iommu/vt-d: Remove unused function")

from the iommu tree and commits:

  f35f22cc760e ("iommu/vt-d: Access/Dirty bit support for SS domains")
  cbf8b441ea08 ("iommu/vt-d: Add helper to setup pasid nested translation")

from the iommufd tree.

I fixed it up (the latter added a use of the function removed by
the former, so I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/MPnDetDqs2Pu0DORcE=2QfW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU4mu8ACgkQAVBC80lX
0GxsOQf/cDs5qODl+IFre4BTgsv113Iyu2EiWHVFwbLaTvnzKqWsaG1Csoy12oNY
rlwTk82QwXZI4pxdFph8l82GJQ48IiD4QZOJY0Em/eMglpdbD/jBbxaCayoR3Gm9
xBrA+s2BflRBg689AcDoe+PU6OA1Xo2k1LJmSjGM0sMZVhn1YuJWhHoLSJFnIio1
ysX5Kfc2XWH+AA5J3EJbeEgpdRsi+ZRRF98KNYNE9hCzS7/dApOU5U7JhddLCsHL
g23ruvCb+mMFkyeU1Sb7wXUOk24rsNgCRV1Jm0UkTepF8WULEhQKZ6gErj6jMCLK
/tY+ZPgE41jjLXl7u+PFw30GX0iO9g==
=zu5G
-----END PGP SIGNATURE-----

--Sig_/MPnDetDqs2Pu0DORcE=2QfW--

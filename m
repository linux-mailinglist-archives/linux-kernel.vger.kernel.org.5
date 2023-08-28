Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0099E78A4BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 05:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjH1DDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 23:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjH1DCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 23:02:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDFC92;
        Sun, 27 Aug 2023 20:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693191763;
        bh=mJNe4evVth2/AWKRqtAnNN94HeG55RTJys8PpJZtFiw=;
        h=Date:From:To:Cc:Subject:From;
        b=LQMG7OMYYuLdjhOxAzmcjx9D9EDmgfxnA46DeRpvlBYNp+92y4BnsgnRpikL4uXyZ
         0r2gxHAkQTP+dtKjghaMR0cvCYfD59DvGGG2fjOFrFJr74rbWwSRkqoL77ManTGq1W
         sKGu711BhF4Bgriv5pQUv/+3//T/fWaBvlG2CMr268QxeLDP+L1TVDsKJ7EHqmWIPv
         L5fMLBEgk+KveKO+uGb7uOVUpgKnp57PxGiP5kn7u2EFUOiLPceB2NRZ2WERVHUR32
         YYsJpbD3OArVqhx0wHz3ghOc+YrJJeH5Iny2iUHSq2ua+2lpZhity2iOjrRrPN0Ro7
         FMJvKgyC/6iRg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RYwN256DSz4wxR;
        Mon, 28 Aug 2023 13:02:42 +1000 (AEST)
Date:   Mon, 28 Aug 2023 13:02:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Karan Tilak Kumar <kartilak@cisco.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the scsi-mkp tree with Linus' tree
Message-ID: <20230828130240.4814c106@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tfQOdNv5/EzCIf/_+xus8aO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tfQOdNv5/EzCIf/_+xus8aO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  drivers/scsi/fnic/fnic.h

between commit:

  5a43b07a8783 ("scsi: fnic: Replace return codes in fnic_clean_pending_abo=
rts()")

from Linus' tree and commit:

  15924b050363 ("scsi: fnic: Replace sgreset tag with max_tag_id")

from the scsi-mkp tree.

I fixed it up (it was just the version number, so I used the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/tfQOdNv5/EzCIf/_+xus8aO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTsDlAACgkQAVBC80lX
0Gyv4Qf9FdJk0RQmxDy874to3/kNOeQEcNtX3byUFPCTsJEkdSj9rdISPDRAQdy8
7kW0qOhy/J26yE4+yLjMSsEkRrlJmclqATCNLfR8YE7J5i88JPZLfDmQZdjueTfC
GPg1y7rC84HTRl1p5Ztp69IjcyP+WH4TG1aN6wV3H6EofTSdEpF7QYAMUWktuRI2
LwONigfKuexMK1ma+NAz4rhXEA70AraAxfLc1WSgOyEHp/PoZqaMsBKpqpaWc7Ev
Ra7XhcYCfcnMVBZqE0GaxceWhrgsdcfTSmBsoP85IxSDbSrWo2Z4FvXUeutFfi/7
W3IGf1m8GlcGdCWN8pNfE+gZVcxqmQ==
=4BYA
-----END PGP SIGNATURE-----

--Sig_/tfQOdNv5/EzCIf/_+xus8aO--

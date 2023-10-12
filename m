Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56D77C61DF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 02:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376624AbjJLAhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 20:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjJLAha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 20:37:30 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833F698;
        Wed, 11 Oct 2023 17:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697071043;
        bh=d0eWK5n2+GWr3yid0IrdcGPcamDTbmkULf2jKU9FMh4=;
        h=Date:From:To:Cc:Subject:From;
        b=J7MKxLij/7k8M7iY9b6lnoDEYzdYn6acQA2nURqomPEU62BxrerraaAHhMuhLWHJJ
         QDUnvexRjR/MWFe89JHnFbKsWuaOp030cDQ4DMkUVnvxQMob+z+BHCXyFL2tPOR3JV
         5i2loRNYD1e0u6czG01uM0bnkaEehAr2HqgQ5VmH8rIM3ep2qJ1mcskWX4gh3PHEgy
         07kdcXWhn9acQbMOCpw3i2a5ALnhr0zMxpD4pqIQVrUsRbWREfDgI6XlaoO4wG+gN+
         G7IFnufOWJacFiws7WQ8dJd9/t+77gFsYhoJ7cLXNhVUtQVfInKbcgUsLdmwaNgpfj
         yrMF2WXuKlAHA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S5W1Y66qDz4xWb;
        Thu, 12 Oct 2023 11:37:21 +1100 (AEDT)
Date:   Thu, 12 Oct 2023 11:37:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Networking <netdev@vger.kernel.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the wireless
 tree
Message-ID: <20231012113648.46eea5ec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wof5tWYoXT/+z+takc=pVNJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wof5tWYoXT/+z+takc=pVNJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/mac80211/key.c

between commit:

  02e0e426a2fb ("wifi: mac80211: fix error path key leak")

from the wireless tree and commits:

  2a8b665e6bcc ("wifi: mac80211: remove key_mtx")
  7d6904bf26b9 ("Merge wireless into wireless-next")

from the net-next tree.

I fixed it up (I just used the latter, there may be more needed) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/wof5tWYoXT/+z+takc=pVNJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUnP8EACgkQAVBC80lX
0GzuVgf/XJeoQF5D8JpWF3YB37FVbdZm3PvJJr0N5LKTsYcwwOhaBIms38+UcD5S
TntSRx3UiVlPC4walmHH74a+d5is2W46BMSWSgkne58MLJ2Js/qEs1k6EnTzSwN/
XW/bjrpjD0cTivwGTLssG/Zz+QmAkplL0xpgnkrQ4y1+JCoEAOXqejpJpENXloPP
ZI9qOqb6hB6FEoyq5BS1PmvKqzBGCl9DB/WtYOFjP7iAIYTpHMlM8iUo7kUq2DxX
WUI16HxCIa/d1Xbz+UWD0/VcIPAp/mRTU0oMjzyhx+ascJPtqdd9v0KR5mydh64I
+FLQ2eGwYxXjr191YzYb2VFij29aJg==
=bNpy
-----END PGP SIGNATURE-----

--Sig_/wof5tWYoXT/+z+takc=pVNJ--

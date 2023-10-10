Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CD07BF1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442083AbjJJDyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441993AbjJJDyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:54:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5A69D;
        Mon,  9 Oct 2023 20:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696910053;
        bh=8bV4SCcom7j/uKEvPwyzbYLkGNfVEznGZi6GQ4ZyQEY=;
        h=Date:From:To:Cc:Subject:From;
        b=VFZWYElaGRbOdDBLdDA/45PtdmgVuk8gFBZsQ8vvIe0Xw2NzItD4pSaW7XrbBgMjL
         3Kd1ks7NzoePtb4bGsKjLM+fq200Zm4OJ/UlGNidwva674V5BDXpJsaGpTsHN77Y/i
         Gfm3nwPVmBQfedi7xayk50V/gA8GLIEk9dH9UC4/Lnt56JRSnrVIGx3oUgVVKg0N74
         0CIpyxHNJZu66io7jWq4OAIH3fS4bQNIiTI0zvO1OAHfCFk6w3MZYPWTYPWPmAP+tC
         Z2L9N3Nm5OOnWWeFgse4EOMBNd4nBvgcVtfgaNxEao6wFhmsK7SFlyDssZK+XqxHM3
         ij5pd8ZCf2QxA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S4MTc6PrKz4xM4;
        Tue, 10 Oct 2023 14:54:12 +1100 (AEDT)
Date:   Tue, 10 Oct 2023 14:54:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the dmaengine tree
Message-ID: <20231010145412.4a758f9d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_///poTgS=XLb/fPh_1ybezjW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_///poTgS=XLb/fPh_1ybezjW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the dmaengine tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/dma/mmp_tdma.c: In function 'mmp_tdma_probe':
drivers/dma/mmp_tdma.c:638:36: error: unused variable 'of_id' [-Werror=3Dun=
used-variable]
  638 |         const struct of_device_id *of_id;
      |                                    ^~~~~
cc1: all warnings being treated as errors

Caused by commit

  a67ba97dfb30 ("dmaengine: Use device_get_match_data()")

I have used the dmaengine tree from next-20231009 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_///poTgS=XLb/fPh_1ybezjW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUkyuQACgkQAVBC80lX
0GxJNwgAj/T/zrh3yBei8Kw9tbx4y+FDl9S8wcLyN1lsAaf/dYBcd0xQ80qaYVkh
R8Y8T+PmfX+Bhj5+RIpGRHCo48RclTSZ2WL1WfdoJOrp1OmhHIiEaCoEJyulzMk2
tYQippeES5AnPtQBFUMlJsHUzE9G5AirZcBlpyKTE2bmCj7eKmyI01LR4HceCrzQ
Vh3gCh/K3B9b/a+Zdk8cTKpiaDSV37f7AYD+URRvvEdn0cqwmH0gxUWxLteTjBl0
bUQH3gr+5AIQax1imE/MrSENETep43d+zk53EVCnlHu7fUHjYMUQ4k5/fU6QPSIa
E/FKMNRWQwcDsniKAIIKeqVF2OvABA==
=UF4g
-----END PGP SIGNATURE-----

--Sig_///poTgS=XLb/fPh_1ybezjW--

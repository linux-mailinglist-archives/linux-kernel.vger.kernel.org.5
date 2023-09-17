Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621DE7A3E08
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 23:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjIQVqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 17:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjIQVqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:46:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B06A8;
        Sun, 17 Sep 2023 14:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694987149;
        bh=1gq+91PIFQp0CotcayyYLsT0OW67uH5VYysw0SmeuA4=;
        h=Date:From:To:Cc:Subject:From;
        b=rVhvkr9GckLVSo7ciMprMSh0tSFJROddeHtbkTJVMyDFkC4JN89dtTdS3TjxSK4Jl
         vvAFPKQ0/RGu4ckjQ8061cTKzywP5SMnJa2oWhGp5Dymi/JrHNbpfI2Cd8LkLmbenR
         +8pUkv99pRlZeFlOtFBVFi65fJ5AUmqR/JMqRBhuYpFBr4a6/jojhQht1PbUm0ljYJ
         IKeMuw5llrQKJ3wj5C/7b98d+l6nyo07Qdey/a2+2vEWTTXY3zrRVPoxKhoTZE+HQ7
         8NNfotWjGtRcqycNU/1DgAtprtL2AxZ41m3/6y5SUpMNMBKKOBPeC/nJDXQ/TJg27s
         dC/RNzfR17BMw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RphLj1WmKz4wb1;
        Mon, 18 Sep 2023 07:45:49 +1000 (AEST)
Date:   Mon, 18 Sep 2023 07:45:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the cxl-fixes tree
Message-ID: <20230918074537.51fe95ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OFWWOHHTu_mm37Ughuzm_7K";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OFWWOHHTu_mm37Ughuzm_7K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  18f35dc9314d ("cxl/region: Refactor granularity select in cxl_port_setup_=
targets()")

Fixes tag

  Fixes: ("27b3f8d13830 cxl/region: Program target lists")

has these problem(s):

  - No SHA1 recognised

It should be

Fixes: 27b3f8d13830 ("cxl/region: Program target lists")

--=20
Cheers,
Stephen Rothwell

--Sig_/OFWWOHHTu_mm37Ughuzm_7K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUHc4EACgkQAVBC80lX
0GzMawgApdNMA0K5HVDWtOXztjAKEHUSD91xaPg20vs/7GVj6FBtKKso264fpIzo
AlXOmbCRhlx1N+D9C52MQWR4n8o3OurYjRCetb61WC8US5GM+2/dUCTDRmUYbhk8
FCr73XFn5d/JuYvHdGHLstxL2+CulpBRqaykKIjtDFokYVIpmf/KqxWcgCF+ybg7
BCByYYVlBzzEXDaqIGThFTlaNgX4kOlYBk5XdnWAb7D1lQtSsXQk57FHTjUdyRSr
1f/5eARQ2MWMJvWm0Wbpl6r5cMoCgyth67Otzv1PkUY6bOAFBQSYzImadrV9+6XO
sCgpQ62BhloSqk242lr321TQO96DiQ==
=2DzD
-----END PGP SIGNATURE-----

--Sig_/OFWWOHHTu_mm37Ughuzm_7K--

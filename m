Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4D175579A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 23:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjGPVyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 17:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjGPVyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:54:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944151BEE;
        Sun, 16 Jul 2023 14:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689544410;
        bh=ucCJY6jTF12cvwASAnIcFYuMb2+3sDMJcF5KO2B1OPM=;
        h=Date:From:To:Cc:Subject:From;
        b=S91tBEOS73KF1jCkCqcSR9Ti0owQWY2zE6atGgbxgxqpVvJSH4coF/ifqPIcJPkbH
         eP8v+Qeq1u+1iMWcwwvtxbfiChuy76gxlOKm3nKi6UMziL7EF9/w6sIueQQOK7tofw
         YKUDSTzgDRwILVbKlMaXuvzhOj42QI6HFlFe6TC56942HPjRbGDuy4QDNUwCP32EH5
         P8AShvbUYxevnlXyW0eBoqwW+wZXPdxIzchIyoN9BiNjxEMdZN9mdTJLLBymmcNIvv
         bWV/pD/f9uQEwvL43PRtUxVlqHy4ZvE9/me70ql5RR34qBj6Gqhy9oenrODotn4yUT
         q9iM11IYk60aQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R3zVf1gdcz4wb8;
        Mon, 17 Jul 2023 07:53:30 +1000 (AEST)
Date:   Mon, 17 Jul 2023 07:53:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the v4l-dvb-next tree
Message-ID: <20230717075328.6ccd5cba@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qLSSW3RJ0Kbg3i=o8v.U06X";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qLSSW3RJ0Kbg3i=o8v.U06X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9c2dcfc2cf0f ("media: tc358746: Address compiler warnings")

Fixes tag

  Fixes: 80a21da3605 ("media: tc358746: add Toshiba TC358746 Parallel to CS=
I-2 bridge driver")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

Also, please keep all the commit message tags together at the end of
the commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/qLSSW3RJ0Kbg3i=o8v.U06X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS0ZtgACgkQAVBC80lX
0Gz/pQf/VPi+KgyCfvhQoWMjMqoPSF5rteuh5OZtsWNR/AqfGKmvKi858QI12Guv
0aTE3tAQ1UR1vUHX0iUCTfYkHFNDZBeqoFJesG4n+bKWFLt+16VgDHVlVlNJuSli
iLEjUeRZmn9Y07Roue1tcRKxd65j6WLnnzc+E80CvcOwtJlQ9Ma7+FeZPLvjZZTH
siy81eysfYj8qLRtCDwVm4CGauFk2iJbzghdsnOgjO16alxUzbE/PMX0AL3S+IRl
cWByiUcqMOcpCsKTojCA5YueIXLOQFxD5VhN3A7MER5PZgsAab367XVAgN+rqfn7
HdIrrtLKfU0Mf971/7obESpy6W1AWA==
=ocSZ
-----END PGP SIGNATURE-----

--Sig_/qLSSW3RJ0Kbg3i=o8v.U06X--

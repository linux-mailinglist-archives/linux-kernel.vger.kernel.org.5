Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D546800159
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376652AbjLAB4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjLAB4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:56:47 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEE21716;
        Thu, 30 Nov 2023 17:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701395810;
        bh=eVODzEGXfAJB7NTzo5d2nrI+hsOA04iJWQ+eWYFdKJk=;
        h=Date:From:To:Cc:Subject:From;
        b=meGaVaP6LMy7I12JExNKjmHTnJD14Sr+/zAOMxQNwMUqY2XU8iezDZNqTSEixCFhT
         DmJRAJLTxq7zKdC+XVBC7QxOwznEPE0qh/m/JJddkq56gaplzSrfGUHr5naA3A1Rfq
         6horgcJjr9mOluPrDB0e3ITASo2R7y3N5RD3hKL/KDhoY8KM6Rl3eyXfvIYLweDK6g
         YzOrMsUY51d6dGf+PclmfSthZYw3jABgkZv6gkEjrLM2POJvcfYZcCSPdPofY1IyAL
         1+0dnDUnD+3qwqU1Kv/KEJ5q5sJwHPaH6VAVMX6siISaAtVWLJdl6CHrdk0tK7rtZF
         HPn8KzvQs03jA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ShGQB2Whqz4wb2;
        Fri,  1 Dec 2023 12:56:50 +1100 (AEDT)
Date:   Fri, 1 Dec 2023 12:56:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        David Regan <dregan@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the nand tree
Message-ID: <20231201125648.71d7586d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DXzDsg5QMDalYXPT7LXeEVD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DXzDsg5QMDalYXPT7LXeEVD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nand tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/mtd/rawnand.h:1016: warning: Function parameter or member 'de=
assert_wp' not described in 'nand_operation'

Introduced by commit

  e82a5a014dd5 ("mtd: rawnand: Add destructive operation")

--=20
Cheers,
Stephen Rothwell

--Sig_/DXzDsg5QMDalYXPT7LXeEVD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVpPWAACgkQAVBC80lX
0Gx97wgAnrWTrNcrOSb15OMquaUPAx1711NPe4HrOKNKUVWRJ5ftr7Gj7TATEmXu
qL0tWdBfrYzSVk2CJCYbccbGjS9Tu/Z5Z40jK6m9aiKkfQ5/vfF2xzllHrnVZUkn
fInL8f9HiKpYVpFZXlSz+q7Vwrgk2ipnUTxJOCJc4GulBfL/uCHEv6Q1Jpsr9gVA
fV9izB/hpLGhK0+tz+RA6yYI1U3lIKRYslBpHSEUdKzovzdvIL2NS9WdzQCvpjzZ
84ICHEtK2C4Uqbcm93KLCfVAmz0j3qitcx49YeAbo+CABJwpmJBiKntj7n1AgmWb
uPm+yGpQ9XjZOhfvGYGXY82VbRuD+w==
=NkAx
-----END PGP SIGNATURE-----

--Sig_/DXzDsg5QMDalYXPT7LXeEVD--

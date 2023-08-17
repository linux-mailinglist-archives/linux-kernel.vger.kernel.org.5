Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145A27801EB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 01:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356271AbjHQXtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356300AbjHQXsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:48:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C583A9C;
        Thu, 17 Aug 2023 16:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692316034;
        bh=XvIGu+hM6e+wHFZeAyxG3TM+rOvoi7/QTlbFkavm+B0=;
        h=Date:From:To:Cc:Subject:From;
        b=ExiihHLBWnAWx4ggEEMkSapuD4KmWZEWPmeD/qaneYkLdCLYt+PaJFOmGngOBgQFA
         gw+mAq+ZeGHqUiUQCLL3ljADYOlUmoHBXuzmSRZgDSLPK3n9MCbHuH7CY9BU0q0Ik5
         2c2jXxx1JwmEoBU60ImXRJmnvtqiG+BmRD2RdZyT8HvBleWhq+MLLue5YCsRJ+hTdK
         m8ucPbZKO0f5Pe31qaJFaGn27zAzdLke/ltbSth2+G7+jSKWCi4HgyiBJg6gyGGxT5
         HSnvDAGxWI70rQeHsDQ7q9VXT13VUcZ7G2J2Ja/tWj9VkRZ3bUVgnIAlzZm/lVIFUj
         Yaqq/IJ6JaZqA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRhW65Ystz4wZJ;
        Fri, 18 Aug 2023 09:47:14 +1000 (AEST)
Date:   Fri, 18 Aug 2023 09:47:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the mm tree
Message-ID: <20230818094713.1e4eec55@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4O1RViaYipnuAGdKqw.xsqq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4O1RViaYipnuAGdKqw.xsqq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

It looks like the mm-nonmm-stable branch was rebased, but then the
mm-everything branch was not rebuilt using the new version.

--=20
Cheers,
Stephen Rothwell

--Sig_/4O1RViaYipnuAGdKqw.xsqq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTesYIACgkQAVBC80lX
0GylwAgAkijaPQ/sXWfdyyozdph/owRqrWzEF3QWoSNsesAq5N4hlgdizDEwD1Ne
6Jr6SiAlX+/4Iph9Pfg0/ZPBg+Ona3gPKtLHE3N+1LNCl6bNvxErSOyRcamzfrOt
1EFrcHut9R0DG1K7dyY0BYlqJXbD9vmHLMpV6YGvczSGXGiLpa/HFYmwYbqrTHuR
IGVPpecMpbxaNwB4JIZsy6DYXEDcBp3uIunnSjoAwT9OO93mAwns5kWUByurcwg0
d1bKgaaB6v81Pn4FKxz40ytVLZa4X2aQswNEwIod/1haJMBdWmYYiAkNrNylrgU/
TcElUtOr7poxiL9x3kx3KiIlrWh+tQ==
=mXSm
-----END PGP SIGNATURE-----

--Sig_/4O1RViaYipnuAGdKqw.xsqq--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83217CB9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 06:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjJQEdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 00:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQEdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 00:33:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E4D83;
        Mon, 16 Oct 2023 21:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697517190;
        bh=gVAPCAAHt3zwend5SRuH5Qj3uJCx+/I+PmgnjQtfR74=;
        h=Date:From:To:Cc:Subject:From;
        b=agi+n6SvgzbprpOz/wreNDBoXwiY8CXsDZ9yIm3q39MZn86944M/jrR9DdCP2EfHJ
         V7/MicT8U/UbgtG13fR6GVZrDjdO5hEfHUZSG2CUmjs9Uv58zgwfXFnnLWDRkPSIXc
         PYDLOWFTyVy4TLBMWXuFKnmMIE7Zxj3wkQnJkYP/rtDx+hoX9PHH2886lBpeU/Pd6v
         U4eaNYzxB5HSqE3KPRpVRJ/ixKIdHlH2OdPR6M8O8XH0kJmLTLnou7n/2ZMiMBpB0/
         QoV2XXM7T9ye9qZa0I+80Obm/wQp42lN4IXzENPhj+B5jBapYiORXV+fiWSMVQvwCe
         RoUk/He92cn/w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8h1L4qmnz4xF7;
        Tue, 17 Oct 2023 15:33:10 +1100 (AEDT)
Date:   Tue, 17 Oct 2023 15:33:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zi Yan <ziy@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm tree
Message-ID: <20231017153309.4148d57a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i2Yf5N=wiUf/yoDIc31qpGm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i2Yf5N=wiUf/yoDIc31qpGm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f8b008d22ffe ("mm/migrate: correct nr_failed in migrate_pages_sync()")

Fixes tag

  Fixes: 2ef7dbb26990 ("migrate_pages: try migrate in batch asynchronously =
fi=3D

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes
  - Subject does not match target commit subject
    Just use
        git log -1 --format=3D'Fixes: %h ("%s")'

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/i2Yf5N=wiUf/yoDIc31qpGm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUuDoUACgkQAVBC80lX
0GzgNAf+J0qtCVtAReR7Np28UEJi59F0p7PY5OK1jI1qVPrWmus0QsQrerSlesU7
ortFOIXEjvuAFPsnrgG9fXyXNINoFTYi6S0vuODyrVO7IsR3jVcUcR/S8Ji/Lj0H
Zl1kQ71p9wCse4zlcj+1Cuy/4WZ01A5Mv25XuJJ5je7hvhPifgOZ9kxFZ0Jpmd0F
2BiHMwAEaNDQNzKYKITnldE2YO3/eL4aFnOuLmAScYZbjoLSBoz14Jx+Cr6d/T2I
uogHLc7SFyP8kLZfPWJ169DjiyNUVuNav250S4RZplpR0y2inEPAtaqxkaeFyQ2b
ZLsgWQznrLzt9jzcVd7ju4HhD/eJYQ==
=sRam
-----END PGP SIGNATURE-----

--Sig_/i2Yf5N=wiUf/yoDIc31qpGm--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056CD7C4A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344466AbjJKGWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344210AbjJKGWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:22:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57679B;
        Tue, 10 Oct 2023 23:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697005371;
        bh=do1+OLudqm4G6YFPzIsQsPmx/JqwLQPT8sgazB4mP+A=;
        h=Date:From:To:Cc:Subject:From;
        b=rZCKXt6M5TTLkWlZLVJH38luOMygcwdjHbqq/uqrf/6zjXhnfvzIvdPAG7d11DNek
         /Pu4lB+ZADzhJ3/YEBw9HtAGZB2y37vw313LEcZcmIpwT5QSEOaSeiGMDEE0BtrRAg
         Ci2kgEv3ZAcarzr+O2p1VY2DwM1K8FM2aGASXadHnqX8E9Dai7DOwPobDCns7nPHaq
         7qCSCk511rC92piOR3DSW65hiE9VVnp854pdaizGEwEzazhtHsgJ5B9cOlc+0o0Xsh
         ah0dFaOud7DW0q4ENbRN2pg8l13R3EPsB8+Njqg3AbNU3BlpC01NaLra68Hd0ToCs5
         OiMq+YubtJSBw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S52kf6zvbz4xWK;
        Wed, 11 Oct 2023 17:22:50 +1100 (AEDT)
Date:   Wed, 11 Oct 2023 17:22:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Will Deacon <will@kernel.org>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the arm-perf tree
Message-ID: <20231011172250.5a6498e5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fXs0/8MHi1ntp8/hhL4Nx+c";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fXs0/8MHi1ntp8/hhL4Nx+c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm-perf tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/admin-guide/perf/ampere_cspmu.rst: WARNING: document isn't in=
cluded in any toctree

Introduced by commit

  53a810ad3c5c ("perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC =
PMU")

--=20
Cheers,
Stephen Rothwell

--Sig_/fXs0/8MHi1ntp8/hhL4Nx+c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUmPzoACgkQAVBC80lX
0GxjwQf/Xl8UFKEJcmjZYoJPYv0R1cIMcHVtCby21vSmI+pHOR241w8dFhOHFJm8
cnS8x4IFRQbaHBymIUSmXAeU4nlyMF54ENikGqV2yZFokR35yWIxHap67Q29eQ6O
leaeSLDs2a0abONSFpWr0oazxOF67ZxXHxyZJN1Y2vlKGBeqzBDcPpUemMDEBkW0
Cl+1WgO67K2NFDrS8I+S3IHx0C2yMpDDjD2v3VMBewn7gom6yE/95dvmXYut1GYs
Mi1OkzVe21y0T1CWHO1QjcBiXVOSJC+cL9NsvXspcWoXQmthWIrI5vGf6uFcn8WC
JrOe3KZBlrdHpbRIh1vn4dntiJFtYw==
=eSa1
-----END PGP SIGNATURE-----

--Sig_/fXs0/8MHi1ntp8/hhL4Nx+c--

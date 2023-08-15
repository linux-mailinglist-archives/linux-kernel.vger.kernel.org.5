Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56CE77CB81
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbjHOLIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbjHOLIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:08:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A817210B;
        Tue, 15 Aug 2023 04:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692097668;
        bh=Kg75p6A/D/B9IbewscNAgu9Ye08xXs0a0XA+g2n9EXo=;
        h=Date:From:To:Cc:Subject:From;
        b=rGuOIWK3FiPlA/EpNuA0fzNjUFBdbsxE94LA8i5lVxCTuSw3Gv2u6qM2TiJqMB6Hy
         +nslF2l6xr/gJb/GBCfc5AcM3lACMoMhOzveksaMcslIFOTgANND8tRe4jCFMngkA7
         2MmQPndVJ1eBRLK9Yd5av9c4P9WC14LU4/A6mzDPUttXdKI3ub9EeLwNDjzovylpxP
         zziN80a1UdjZXb1+FyaRBsGGZnxi+q1WOVlkq3/wnFmqDnYqLDb2effHBkkXGPOgGP
         anWwS1AWZxg1zdtsmuGuC14L0y3A1hyEZhui7ZlQIw4fBA9rm8kMcxwJtOV7F+vcmd
         s9ml/lKDpFZqw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQ7lm4pP8z4wxK;
        Tue, 15 Aug 2023 21:07:48 +1000 (AEST)
Date:   Tue, 15 Aug 2023 21:07:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20230815210747.6c409362@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.suldkq4UmkctXk5q+QPYo4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.suldkq4UmkctXk5q+QPYo4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1: warning: 'product_name' not f=
ound
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1: warning: 'product_name' not f=
ound
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1: warning: 'serial_number' not =
found

Introduced by commit

  7957ec80ef97 ("drm/amdgpu: Add FRU sysfs nodes only if needed")

--=20
Cheers,
Stephen Rothwell

--Sig_/.suldkq4UmkctXk5q+QPYo4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTbXIMACgkQAVBC80lX
0Gw4gwgAgJpdlmFZcD+cR6NvwRGWEch9/d2G1V6TYcaFSy4AK5lRb1Dsa4pq9eAJ
GXvDUY6YbAjg6s2bU6dUTeQKogD6oXvOZM6cexxKEOY+NbujY3URjbgmHq3jAm62
QTAoiKjGhxwV7DhdNbHIyP66nIAhPtjTLHhkTsMnwhT+khOU4D6NWzZJhhHpAErt
JAYvbYUrk7OSiIZiqLOpXkAfl9v1zXwcu2vWLo/lXz6JTh5+FOR1z8EgDQa3kkCU
YMTYXflXKVibGeyN52jLmEu9naGVoJf2bzCVTNYpyvuqe4q0iFZG9Alto94yECps
vVb26M32MoxuM3VN1z/UuBni+Du+HQ==
=cI6f
-----END PGP SIGNATURE-----

--Sig_/.suldkq4UmkctXk5q+QPYo4--

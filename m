Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C710080FB08
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377961AbjLLXJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377895AbjLLXJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:09:29 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D938A94;
        Tue, 12 Dec 2023 15:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702422573;
        bh=ReJYNCwEh7uJ5zxLU9iEyda4Z/if8JiHPAdQK0Jn6nA=;
        h=Date:From:To:Cc:Subject:From;
        b=lz82nX2RpePoauBh/lmHoWlp1WjGwXQ4ErOtMes3OFAuDQKPavWjxE+9/b0n5tlv8
         NJqUfLFOTmKdn8n9p1FowxURtXgrVh6zGP3Q4tAj6x8INsvJ1YL1qDGIs9LGDo2o0B
         eZuyIp/Ehl7wJGuAfoObcAi0U/1QrSDwe1A49ViM4GSAr/AlgF6LHa1YHpVCqERsmL
         uhRiJsy06jx/N2YNSa7DMYl0/+HmdB/sh6O64MJ5p4h3sftJUVZjC327z8Y9EzRac0
         mgLxAD1TdwFasA6bwaT18YicJKcbzL8rP+/8VmxNb/UNfY2bNUK+UgKjyQdMTfzTah
         BHPJulD0FeDqQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SqZ7d2rs9z4wc1;
        Wed, 13 Dec 2023 10:09:32 +1100 (AEDT)
Date:   Wed, 13 Dec 2023 10:09:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the arm-perf tree
Message-ID: <20231213100931.12d9d85e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IkgUYuGrLs8sX_KIjnBEk_k";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IkgUYuGrLs8sX_KIjnBEk_k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm-perf tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from drivers/perf/arm_dmc620_pmu.c:26:
include/linux/perf/arm_pmu.h:15:10: fatal error: asm/cputype.h: No such fil=
e or directory
   15 | #include <asm/cputype.h>
      |          ^~~~~~~~~~~~~~~

I can't easily tell what caused this - possibly commit

  a5f4ca68f348 ("perf/arm_dmc620: Remove duplicate format attribute #define=
s")

I have used the arm-perf and arm64 trees from next-20231212 for today
(since the arm64 tree merged the arm-perf tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/IkgUYuGrLs8sX_KIjnBEk_k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV46CsACgkQAVBC80lX
0GyA4gf/YUfqnBKLjOpmG+pY650Q1TdOxh/nRIm+NoKPyujpXyQWu9S9RWaAu07o
+tc08MsS3vg5HISapO4VLs2dpy5gwdwbIuFc4EBzjBNrt5ltYUBobKueIqe9Tbj8
rfBSXD/S8iSh80VwX1tpdn7bZ7b0BnImjy9bX5KRVRmmlwMCkpnuxPbnPm2+gXdQ
rnM00sQJiZE4ZLAdQvdTygJHgyWs1fBvAVV8fIfORBJC3EuFCZIMaUahSiGq++iz
uI7nfuTVtk6Ee4hqB9MgRDMYwW9prXdnQ0XKFxB0rmWBiqaUVs6mGkkAm0HKPpII
V+ccqvtDUXWDGy3hIGnYULDv6kaZjQ==
=9PR1
-----END PGP SIGNATURE-----

--Sig_/IkgUYuGrLs8sX_KIjnBEk_k--

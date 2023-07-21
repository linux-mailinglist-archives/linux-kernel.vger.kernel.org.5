Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEA175BCC0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGUDVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGUDU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:20:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31937272A;
        Thu, 20 Jul 2023 20:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689909649;
        bh=109U+3YK9uYn6Fr2HxZ84niz4wIVKVOjKtlBpE/dImY=;
        h=Date:From:To:Cc:Subject:From;
        b=qt89xGWwNmXe5VBuWaFdQrKIhMWEusJ8LPKEs+Xjg3yPY8e5q2zFkSUh0MMtgD0kZ
         Awk7J67yhzP5eGzgKr06K90FWBqEfgEDoEYg0e9FDVpBYreUuXfiXTX0RRq+o1qy4t
         kng8fgVNRf95fEQubREMf5wgolRj/MOVy1ltSWeYf+hVzv/MAMGHJCCUVnrTHyKYgK
         zxiNRCNtXwcpjasduBWXsrsEeM+ByFxUgAL7mp1uPKwgkzUvPVgjvCVD4lcVdgDra+
         oivDaIz6cvkSgAav14McReSpqGnxwE5ncZmwNC/ExXb6yZ+Zd0k+vkMW+yEB/VOB6y
         fOGrgtRsmCHuA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R6ZZT2hdkz4wZp;
        Fri, 21 Jul 2023 13:20:49 +1000 (AEST)
Date:   Fri, 21 Jul 2023 13:07:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>
Cc:     Mohan Kumar <mkumard@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the tegra tree
Message-ID: <20230721130730.058a385e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fXd8S_l/ynGCK7.vtpD=/Ok";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fXd8S_l/ynGCK7.vtpD=/Ok
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tegra tree, today's linux-next build (arm64 defconfig)
produced this warning:

arch/arm64/boot/dts/nvidia/tegra234-p3701.dtsi:57.27-60.10: Warning (graph_=
endpoint): /bus@0/aconnect@2900000/ahub@2900800/i2s@2901100/ports/port@1/en=
dpoint: graph connection to node '/bus@0/i2c@31e0000/audio-codec@1c/port/en=
dpoint' is not bidirectional
  also defined at arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi:14.30=
-17.10
arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi:56.26-59.8: Warning (gr=
aph_endpoint): /bus@0/i2c@31e0000/audio-codec@1c/port/endpoint: graph conne=
ction to node '/bus@0/aconnect@2900000/ahub@2900800/i2s@2901000/ports/port@=
1/endpoint' is not bidirectional

Introduced by commit

  89b143fbba40 ("arm64: tegra: Add audio support for IGX Orin")

--=20
Cheers,
Stephen Rothwell

--Sig_/fXd8S_l/ynGCK7.vtpD=/Ok
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS59nMACgkQAVBC80lX
0GzbPAf9GW9acpCWhaXHlIwAc9SQ/S2mvNr71VpMdQ4vhjjh7c3p8f6U49MzalBn
qJH2zU04gWA0rv0i53TJQ3TUiVQ7ND85KFB8U7VyeesMrhHiBle5G0e+sbTedywQ
XEe5FOPhdOHUf0GEabJXdo7egstzsANFFbayvyq64CTqg8Xw1WxP1KiybJO/321e
APZcEJspmip7vlfal+W+zudsp4q1VlzmP0xYJHpxmKxbBVt9LZIa0ajX6m9VsY2u
ZfV23APTqVdALyi2whioeClNszCCLBpmfqj2GMQno9h7Hsonr5vfYfXTLpxnpzDA
zQ5kChvvTty8PgXyHZGm2udfoBIQXA==
=vIOX
-----END PGP SIGNATURE-----

--Sig_/fXd8S_l/ynGCK7.vtpD=/Ok--

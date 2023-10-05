Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BB47B9E27
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjJEN5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243891AbjJENze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:55:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2659310F0;
        Wed,  4 Oct 2023 20:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696475739;
        bh=IWIDGeHwZTv8cvx7Pmxk0dBBOn8mpJiMjXDDssxG/ow=;
        h=Date:From:To:Cc:Subject:From;
        b=RJDj9zzUH4AshrVqwOfL9CI7MASDYp59PbK4g3jmoBVL3cY4E5LVW2jbEwBL2ZvIz
         4r42C4O9KTq/N1SmwuVkPhcW7xo93n2WRpLV3DgB/OW9RQQKBOC7kRGXD/SYcFmYoM
         17PyO7zyRT58yxBpI2m9T7Ig0Z4+vn7TaimxOdNUQc0oIkQ8vSKm/1EeAPJgxI+GA2
         pA9KY5cYw9SrqBS2D0P4ByIMFzhMmMLtD2oNgBz1lBwX+3R8NIA8YPfp0No8nHZQi9
         3krToV9S+vIat6myBX6+xqUQcAQ7Rgc1ZrasdKH43UdUNH0+t9aAZlyiLjMwMpJ0Gw
         8VYEjouxc0o+A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S1GsR3xkpz4xQ1;
        Thu,  5 Oct 2023 14:15:39 +1100 (AEDT)
Date:   Thu, 5 Oct 2023 14:15:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the ti tree
Message-ID: <20231005141536.77538147@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HurukrJ=5I1ls3v3XEBFOHe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HurukrJ=5I1ls3v3XEBFOHe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[I may have missed this yesterday, sorry]

After merging the ti tree, today's linux-next build (arm64 defconfig)
produced these warnings:

arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso:65.8-140.3: Warning (avoid_de=
fault_addr_size): /fragment@3/__overlay__: Relying on default #address-cell=
s value
arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso:65.8-140.3: Warning (avoid_de=
fault_addr_size): /fragment@3/__overlay__: Relying on default #size-cells v=
alue

Introduced by commit

  45a0c06571e1 ("arm64: dts: ti: am642-evm: Add overlay for NAND expansion =
card")

--=20
Cheers,
Stephen Rothwell

--Sig_/HurukrJ=5I1ls3v3XEBFOHe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUeKlgACgkQAVBC80lX
0GzDFwf/UoKvoSrJ968rfk6pnjh6+h5MqgTO6Mz4Z5XcjqbDAsKzWZOwsqYVq9HL
Qen3d7yBSDxYWiNLH10S0Ii6FRgWxQgaiAzKDtJRzxUPPDjWTxZL/sskihoHxgDm
IcVYm/hy7cPHEo/Exp9KSjlvS5OLdHeGe1zLtaf5Xdwokn15qoKvMpI+DBVOSF85
71j7q5AzBphDtOQZe1GIBZdHaYYzG7gRMYXt5CcydGIqk3vPO4+/tdy1pezCb+L7
F9Snd9eNbZgbMksZTFXaJ6sjLasWGErTohZrEM1kNCRfEDsVYthtDyyUcQ7INQfS
eLJIaXTqaZ+HDAQpQT0j9J9H4Nb2zg==
=hwMs
-----END PGP SIGNATURE-----

--Sig_/HurukrJ=5I1ls3v3XEBFOHe--

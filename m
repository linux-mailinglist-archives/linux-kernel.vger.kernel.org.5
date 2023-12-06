Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED80980665E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 05:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376625AbjLFEr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 23:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFEr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 23:47:27 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502C1A5;
        Tue,  5 Dec 2023 20:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701838052;
        bh=vVeXte/GmqKo3BeYMWbX83grmqhoPxHp5v7YTOjDpsA=;
        h=Date:From:To:Cc:Subject:From;
        b=KWF9cQqnSfX/77k/wycjtzFfW+925aby3FKWeEgtj3OkxaFyjT1ax1afFkn2puYTa
         qe1mT00hYcRq8h/L0xEGine+G/P0Wh2hnztomnNKdW/eVn3yf9NccGpjQ0bnXz7gBc
         2TA7b39oQAoL42fMY8QmFVF/P98crAa1XdDTcx0zk2vq5FBUsyVdCeeYvUwFfIEPcH
         oAZH0dctryy0XG/BrasUyHRCV+3r9ynqz8Gg+tTkjMf6sVcRXyjz8sAB+EjXzgyLWk
         npqSvzhO6h/WJco7mXCypLFo36BlAzv6mXQYsEjNgyEftV70MC8kNP0b4Em7z9s8QI
         jrceWPhZ8YAAA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SlPyq1wJyz4wd1;
        Wed,  6 Dec 2023 15:47:31 +1100 (AEDT)
Date:   Wed, 6 Dec 2023 15:47:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the imx-mxs tree
Message-ID: <20231206154730.00346f93@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j7l+mD.zyoT/RVwR2qkuFR2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j7l+mD.zyoT/RVwR2qkuFR2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  50f8906b310e ("arm64: dts: freescale: imx8-ss-lsio: Fix #pwm-cells")

Fixes tag

  Fixes: a05c329644d81 ("arm64: dts: freescale: imx8-ss-lsio: add support f=
or lsio_pwm0-3")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 23fa99b205ea ("arm64: dts: freescale: imx8-ss-lsio: add support for =
lsio_pwm0-3")

--=20
Cheers,
Stephen Rothwell

--Sig_/j7l+mD.zyoT/RVwR2qkuFR2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVv/OIACgkQAVBC80lX
0GytjAf+Ib7Z+SOfFCz37uYYBm5vZqoIRqr+XT1PUGMd3uWqu13NAkhkaVmTd6iL
+SElKoN6PvMnOOK08KT9UXZfDDu7ZltS16lYTZhwCw65FkbYpj4WODS/XLtrFnnk
fQwzbDZR4NUmSg91gT2i4zphLIMranV4/ZRSgdcbFZ5bf427pJ0JMjzZb3mUeloJ
ZsezDQ20GHsBXmN9fE87aDEaDYXIUg/FAanXUeoZOTetbuObN848tt+Adlj8ssOL
/PXC++BZlSxO46Qflclh0PBCPYfApNlJ/DIxGqJffnjZ6zLeFi8NQWsgPozgXAJm
dX0yZ9xV5bmH04dfIglv0Lemm0V3aQ==
=Yfsc
-----END PGP SIGNATURE-----

--Sig_/j7l+mD.zyoT/RVwR2qkuFR2--

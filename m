Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661C5760263
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjGXWdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjGXWdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:33:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E559F1FDE;
        Mon, 24 Jul 2023 15:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690237933;
        bh=/uQWPdsrbd4Z+j1MCnssxq28ZvspIDVceEVZS8EdwwM=;
        h=Date:From:To:Cc:Subject:From;
        b=BRhO56K0nT5M1W/hJN0IUNumEQw0NyvrcISfOelCN0n3D1Xs+oAZbbppAJobHVbBb
         3poRzbi4XNnHRhrN/FR6nkE42ZD4U7D4pXqtYKEC66RLpg2WUqlBtT0Z06sGCjJp7O
         dBWwHKfg6NWBWLx8/qDXBZot4gT3g8UQMBJ8Uzo3rCN63y6Ri3K1MwLiJc3q1ERc1F
         L03Cr7cesTqfDBAbS+k9YI1HecWaJ7pDf/V7eug12CTBsuQEzdGwE1RF6KOZDk4S9H
         R6+lUjFtc4lykgkG6J3JawDxBay+qEuRJmmUQFgRpYP8LhpdsgNLTMO9m0DngOSaID
         tKIjWHWXM5ZEQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R8vzd5r8zz4wy6;
        Tue, 25 Jul 2023 08:32:13 +1000 (AEST)
Date:   Tue, 25 Jul 2023 08:32:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the devicetree tree
Message-ID: <20230725083212.0f59e6ac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/59TN87Tlncky3yWLHtFlQ.c";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/59TN87Tlncky3yWLHtFlQ.c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  120e4bb6ca34 ("of: fix htmldocs build warnings")

Fixes tag

  Fixes: 39459ce717b8 ("of: dynamic: add lifecycle docbook info to node cre=
ation functions")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: d9194e009efe ("of: dynamic: add lifecycle docbook info to node creat=
ion functions")

I assume somthing has been rebased along the way :-(

Also, please keep all the commit message tags together at the end of
the commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/59TN87Tlncky3yWLHtFlQ.c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS+++wACgkQAVBC80lX
0GwyBAf+IYVJJx49xnlvtzLiHi2NGlnNnau95itc9ekyTjrtXC37jotajTmVX72+
lYoAXwbYxQKtokCd/l282RpnFFh7Rb1y8p7HpsRpfDfcAWaL7FMGiLL8/HJgwdku
R/ePHYTAaKL13YZJ78InSlZw5GeAE3DDqOy0SPt6XIspcVufkSwg7tQfVptBLMjW
sGoz5XW9u2sFDcG5NPD7SozMnR07mjmfqJTYmWps6fiUmDk2I8kPehn6U0lnEQTe
ghJhfLGfmq/vST43MeyPi7iOvuxMrSZhwTugVVo2H256W6VYL3T9ArJ4nMGPb3qr
kbRqmO6HH5eFlwRmjCD0bbqlC64woA==
=Xb9R
-----END PGP SIGNATURE-----

--Sig_/59TN87Tlncky3yWLHtFlQ.c--

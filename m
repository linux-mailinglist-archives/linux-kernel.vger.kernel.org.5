Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B937A774E1C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjHHWPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjHHWPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:15:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C0E10F7;
        Tue,  8 Aug 2023 15:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691532936;
        bh=thKNqYKxYm0ppZesSrFSwrwcnW1fyw5bW2bBB/OwfLM=;
        h=Date:From:To:Cc:Subject:From;
        b=OsdnV5Xzeq0rORcbEzoaQaNpgXAZXKdgZF15pF6qWVCrdxo4UmQHnCv6JllER749M
         lZRbnHn+NvUXlkDvm/62cDwOexNQqTOqHhdBiE85gUo3Ki9zdT1Mb4otliOmqEGipQ
         J09hCVZ+0oPLbnwut4gD64G5yNzrBzyq2Z5tZsJysj8LiyN67IF/aH/JP9n0GbWC7J
         jLxogJDD4qUyOuK7Yr1cMVY5/nu+GARr/PIvxcM99BVuljobFPjMJKvYLRO/0BMk0m
         XRehPfIEXmH0yl1e20jRZfNfhU4RmTigvZuDmoW1eMqHGEIo7/PsYhNOaE1daxGT9K
         //7cRyJWEh/hw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RL6vX3mYTz4wbv;
        Wed,  9 Aug 2023 08:15:36 +1000 (AEST)
Date:   Wed, 9 Aug 2023 08:15:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: unexpected file in the mfd tree
Message-ID: <20230809081524.006da553@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KQGZ8vpq90rHKR+mPTI5fc9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KQGZ8vpq90rHKR+mPTI5fc9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  bb60922c31d0 ("mfd: Explicitly include correct DT includes")

added this unexpected file:

  drivers/mfd/rz-mtu3.c.rej

--=20
Cheers,
Stephen Rothwell

--Sig_/KQGZ8vpq90rHKR+mPTI5fc9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTSvnwACgkQAVBC80lX
0GxcSwf9HppF+pL9dvbFonlaTMmi67LPLFZYqu2xNoLymk2b+pbnlEZjBAi2EQgG
GMQGUvGQdS0k6wi44GYpAFUo6AR18UA5eDHa4sH7GO3o8qyraddWnmlmVS/twxCC
kQyZVums0tKxIqh+6I4yO9GLJImcwqCxZfouVYBoLnUwsSTojjBMwODihpObm2u5
8DJSy3SIBNHArFs+npqpdhW1A3o4fyvCSCxoK2Bf4eUnhtmv6fMbPkyEwPEzinCP
9HvLiOenmy7NAsMFT07d1qLp+loHOudm12lKkqjne0JHs25dyLiNaVTnW0oDpwVh
j3T2ZbpJHhZCzKG6QanN3hmVVOTkoQ==
=Q12J
-----END PGP SIGNATURE-----

--Sig_/KQGZ8vpq90rHKR+mPTI5fc9--

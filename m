Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7053A79F872
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjINCtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjINCtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:49:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2DB10CC;
        Wed, 13 Sep 2023 19:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694659770;
        bh=ZsakcTBIIQU6Boyh25Zj7mQRAko+w4lMYinWimPWE6M=;
        h=Date:From:To:Cc:Subject:From;
        b=BvuzvZGXCUeANFaR7QCYMkuwtt6bRMg7tbW2HWN2lItMxGjYmY3MiWX3RRtSgvvrP
         +8ckhPQZf5vU78CqkatQK/YMbc9+UYl1zVXPKbE58OdSOhajhB8BFJA60qS/kp0XEL
         TeFTHBmk3yuKpoz+HCfGMNQe/o7/D+z+s1qES7tsObH/Vjw5Oq/CrDya3XZPStlbEJ
         FTaUhJ9HwGBvOhrRVG31Ml/pHyOSZDF+M4DV0m2qlJ6bQp5tsjjBZYkdg9OkccuKaZ
         UOSfLYtTYnlummp0NkEgIKLNyQ2ZstbZlkikZV7Sd3UXS23YbwQtoU33J3mfKByb2Q
         7uk+Y9Ot78d1g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RmMGx3rMCz4wy0;
        Thu, 14 Sep 2023 12:49:29 +1000 (AEST)
Date:   Thu, 14 Sep 2023 12:49:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the wireless-next tree
Message-ID: <20230914124928.346388e9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4lcElBc=W6XaG2maIA=_/eh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4lcElBc=W6XaG2maIA=_/eh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the wireless-next tree, today's linux-next build (htmldocs)
produced this warning:

include/net/cfg80211.h:5963: warning: Excess function parameter 'work' desc=
ription in 'wiphy_delayed_work_flush'

Introduced by commit

  56cfb8ce1f7f ("wifi: cfg80211: add flush functions for wiphy work")

--=20
Cheers,
Stephen Rothwell

--Sig_/4lcElBc=W6XaG2maIA=_/eh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUCdLgACgkQAVBC80lX
0GwswAgAk+KveRO9g6npWpdSuu+TZ6e31Zry9dxcRc+Oq7j8DwxNkJcK7F6OKF0U
dbf/yhjd79lFqrvCjz35hRbEj8RXONjX8sosJ+eJfvZOVV7X6Qr4+o/Oi170EyL4
OFcV5ZOFNaDSnkcw3VWyeG4wex6lwYf7RzEN2iUO78Oyxa0Fson/hsvL3uGsygNg
W8vfQlGcPhFun/Mg2uiOZZ6C713lw5qqdOp4KQJkAEJh9hxtXUq7+rfUFrBeuziI
PLSS/rXjBaebJF1XwtwteAZ53TQKKRh8fFi732es5A2h4SLoYHUHHxJSyEX4mAYQ
wSZwRKwP3csCuYL0VdOn+XSoCk51Zg==
=zKnb
-----END PGP SIGNATURE-----

--Sig_/4lcElBc=W6XaG2maIA=_/eh--

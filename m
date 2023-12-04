Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9A4802B1E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 05:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjLDEyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 23:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDEyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 23:54:37 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AADF2;
        Sun,  3 Dec 2023 20:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701665683;
        bh=h7RanW8Xf4UE1bGWVVdVo0+JKirxifkyhe2hVaNGAJo=;
        h=Date:From:To:Cc:Subject:From;
        b=NDxKd6sF4toruZKCNjtJVxKoL57MJFBg4PLrHfCzcrPbfEgJJVbLHDZ64LMKkZ43m
         9Tbl19A/7vpzHV1x1LoEB5lKhUsDBvNvla5yf1+0/uIgyq9iTxqO0PWOJOX8oPL9SX
         n0GDpVIfLxrxuq84VaV8o9m+Fo8cHoTX7/lvMGNU5iB+wO56kw3eMoQsPloSuvlXlr
         QkdONIKEyKax8F3RVN67qax8VLpRxooY4QTMN+xqyxu/05cR1Edcqj6oDHMzuHQkst
         NaigUPrae9KdPYkpsdfVUobh7+UP9pnxT37h4APKKwRU1Fhy4QYNBjm8QwAAY+sztt
         m4cSNVkwxoEiw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SkBD26vDTz4xhK;
        Mon,  4 Dec 2023 15:54:42 +1100 (AEDT)
Date:   Mon, 4 Dec 2023 15:54:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20231204155442.1243c74e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Nc.dLxrnU8Cwlgl+=U3coi3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Nc.dLxrnU8Cwlgl+=U3coi3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/damon.h:201: warning: Function parameter or member 'get_score=
_arg' not described in 'damos_quota'

Introduced by commit

  99b36eab9c05 ("mm/damon/core: implement goal-oriented feedback-driven quo=
ta auto-tuning")

--=20
Cheers,
Stephen Rothwell

--Sig_/Nc.dLxrnU8Cwlgl+=U3coi3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVtW5IACgkQAVBC80lX
0GypDgf/axBcbZIlX5LWjaLZh2v5Qi0C4G3uw0KfxloRtitE7Jahc6btl9qO2JlP
lICB4znVcqJ8XXZm3F19f7Jr/obc1bQDdDh6SxNS+3FhKcra8QOkc5aLYxo2axnb
EImaWc1ilHtBoUiZNnnupmPNGMGsQ/74i2ahRfL7ohZ6LHexpjfepLwXi7kuR2aq
Az/W9zJTCXFhJJ7bKCML/QoHK83YlVMSERZUJLMlEwOrABGcfp8NPv9oFpI8txb4
5/lou84aHVawa5iV24HYlM485MV+fReV28Gmt0mZdvGmUPS/NvjQfc7jF4rd8igA
EhFvGg+FhH4BXEvLQDnPcjA30/kTtA==
=lMAz
-----END PGP SIGNATURE-----

--Sig_/Nc.dLxrnU8Cwlgl+=U3coi3--

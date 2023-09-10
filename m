Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5470779A095
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 01:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjIJXBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 19:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjIJXA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 19:00:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48543184;
        Sun, 10 Sep 2023 16:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694386848;
        bh=Hyq7T+RWt9crTM67/bCxWQy98/F2/9vTSK5CGJw8K94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EaeMW6MM505CcovRzqkVOGch4slYF+jSZTw3Zn3SdRvZstS4Gl8W67SjeislxR77c
         P2/CJVOD9XcttqX9SRGXfVKyoDcsZ4FX1NI2zeu28urxDA96GegrAaIninZktJXeVA
         xRR7qsB4ZMRhejWs0SpmoOfDhky57uSS7VSpy2wh+UjnNGJNL7V1j2QO0KQnIbEL+E
         55+mqZWgXYYzjEaRe7kBlMf+R7ROU/V41nkV0fS6x8k9E1MPHJy/cSI8nKnITYKH3j
         N3Z3inUn3iT0gYKeellyou+iLsEaDXQWeWYjATITNjOKtw4VIpB/ulUTuyvofaFgiO
         2YBh2q+qS4Diw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RkQLS2vZ7z4x4T;
        Mon, 11 Sep 2023 09:00:48 +1000 (AEST)
Date:   Mon, 11 Sep 2023 09:00:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the mediatek tree
Message-ID: <20230911085725.6778bf3c@canb.auug.org.au>
In-Reply-To: <20230630084457.3a483c12@canb.auug.org.au>
References: <20230630084457.3a483c12@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YPR6DEZwpZH=d3kZw9Taj.2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YPR6DEZwpZH=d3kZw9Taj.2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 30 Jun 2023 08:44:57 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
>=20
>   1139eb7bf5ef ("arm64: dts: mediatek: mt8186: Wire up CPU frequency/volt=
age scaling")
>   113b5cc06f44 ("arm64: dts: mediatek: mt8173-elm: remove panel model num=
ber in DT")
>   2cb0317922e2 ("arm64: dts: mt7986: add pwm-fan and cooling-maps to BPI-=
R3 dts")
>   320f2af8c387 ("arm64: dts: mt7986: add thermal and efuse")
>   4a7fcb3cdf6c ("arm64: dts: mt7986: use size of reserved partition for b=
l2")
>   58d2424d9f83 ("arm64: dts: mediatek: mt8192: Add missing dma-ranges to =
soc node")
>   5e042912c86b ("arm64: dts: mediatek: mt8183: kukui: Add scp firmware-na=
me")
>   7c8cf2a19228 ("arm64: dts: mediatek: mt8192: Fix CPUs capacity-dmips-mh=
z")
>   861af546db4f ("arm64: dts: mt7986: add thermal-zones")
>   8b018984aad7 ("arm64: dts: mt8173: Power on panel regulator on boot")
>   c45c921fb524 ("arm64: dts: mt7986: increase bl2 partition on NAND of Ba=
nanapi R3")
>   ccc2a6d8446c ("arm64: dts: mt8195: Add video decoder node")
>   d0b4508ad0b5 ("arm64: dts: mediatek: Add cpufreq nodes for MT8192")
>   e5b12f3b851f ("arm64: dts: mediatek: mt8186: Add CCI node and CCI OPP t=
able")
>   eb5aab271611 ("arm64: dts: mediatek: mt8186: Add GPU speed bin NVMEM ce=
lls")
>   f38ff7d3b0f1 ("arm64: dts: mediatek: mt8186: Wire up GPU voltage/freque=
ncy scaling")
>   fd6d9a1c9819 ("arm64: dts: mt8192: Add video-codec nodes")

Those duplicates still exist in the mediatek tree
(git://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git#for-n=
ext).

--=20
Cheers,
Stephen Rothwell

--Sig_/YPR6DEZwpZH=d3kZw9Taj.2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT+Sp4ACgkQAVBC80lX
0GwbAggAncp1X5At7HM5kpEiMF4EUy0/ykBn0+SjluEzaBJJc2uduZLdPhGFEk99
tq3ueHtAsJdoOa2aX/q3wUT15mwwdO4IktM4i+WNGqhWPLYWK2joeDM9tKe6UhHG
5VUgcorVA17Oi8FBIv/28KJ3FDMNPpgDLUbeqvYnZva1Ks50s3HfilnZu1bGQJ2w
P41cugAGcHZSeqUOoYK+9lv/AEuUia6EUNFzLTJ/mFJhfwxTo4n0Hb2NitYvfuap
f5ftNItTEZHu3je+51Li/O6fmVwUCMtv1nm9AQZ7N8aliMJzbl2Bnl6AMRrFldVt
T/GlgFerJG6LIdoC6dL32op3jZmObA==
=QYY9
-----END PGP SIGNATURE-----

--Sig_/YPR6DEZwpZH=d3kZw9Taj.2--

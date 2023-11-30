Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076F97FFE53
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377129AbjK3WKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377116AbjK3WKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:10:08 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F7810DF;
        Thu, 30 Nov 2023 14:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701382214;
        bh=tGoqKjA42cE3Tk+7GVPpkEkj6chR/SK3IvRvQjTYq20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CCLHKo+lmMSqjSn6RNiOydApuVZmqoxwI5pBdM/GP5gDkdPEDQx6JbN9loi5f7Swj
         BCx1IGnRYibn5vbTrm2/c29xUJe8lO8VBrATZXa2Kjh1RyHXVeOmrasGAJ/8EbVKGw
         Dn8ju+H90kkvTq+/fpWWAwMdbHQvgAh57Myo3ASaDDIIdyN97yZSlAVIQdUhU6qxPV
         EfD2YvVmjQkTfwtmoZwcjlxOXaSIUMhr6TnWgN+0AgTtBwEvDrVOC0Ka80V/mTgenB
         7DremU+J5JuXHrU5e8s8XgibONFDJ5DuLHddBnZZHDN0jX+kILixB7s7o/O3jpHW0W
         XuycNQ57uipVg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sh9Nj6Gyfz4xWX;
        Fri,  1 Dec 2023 09:10:13 +1100 (AEDT)
Date:   Fri, 1 Dec 2023 09:10:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Aithal, Srikanth" <sraithal@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the kspp-gustavo tree
Message-ID: <20231201091013.6554b27f@canb.auug.org.au>
In-Reply-To: <402fc89f-96ff-4f64-ad6d-aaa7ecc284e7@embeddedor.com>
References: <20231122144814.649823ac@canb.auug.org.au>
        <813f3aa2-3449-7264-fa54-eaafd9981add@amd.com>
        <20231128091351.2bfb38dd@canb.auug.org.au>
        <001021e0-2262-49c8-89d0-c0d0720ca313@embeddedor.com>
        <402fc89f-96ff-4f64-ad6d-aaa7ecc284e7@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kdNimbeNk/GRNQqhx_kqMm9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kdNimbeNk/GRNQqhx_kqMm9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Thu, 30 Nov 2023 15:54:57 -0600 "Gustavo A. R. Silva" <gustavo@embeddedo=
r.com> wrote:
>

> >> Given that gcc 11 is a provided compiler on RHEL 9, can you not add
> >> -Wstringop-overflow for that compiler, please. =20
>=20
> Done:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/comm=
it/?h=3Dfor-next/kspp&id=3D617ab3c357d2ebdfff0e1a090c46f2f3f29b45e2

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/kdNimbeNk/GRNQqhx_kqMm9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVpCEUACgkQAVBC80lX
0Gx1mgf/fm6PH5keY60h4sgJAJFzE8XQYxlYDe4RL36z5HYxVJSDcOKWi+DLktgl
KrU0fhtQds1VwFuy0a4LdurHrDnr9mD48iPnNdnpgUGC3kOXoNOOv6jwD4yjhA3L
HlOQsTNsMW4dMjeOSqAAH+Li58yJgE6vMpa6BGJq8OGnRTjLIq1gXlMUdw5axHo2
FGAk6L8Z/waPnyXH/7J+IhUjuD4r+ThkPUspxpbMOguPqIEvyaElPIdxkJhvM84L
huPlumslbZ1pBbe+7GZkIc1nfK0K4OE89FswMF9oMnEu8847AYjnWUJplRY32i/b
dEbwxRc6L/TCzzqROKUhAm/o7NKd2g==
=4QiC
-----END PGP SIGNATURE-----

--Sig_/kdNimbeNk/GRNQqhx_kqMm9--

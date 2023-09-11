Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5289D79BE17
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344900AbjIKVPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbjIKJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:41:24 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAF6102;
        Mon, 11 Sep 2023 02:41:20 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D312D1C0006; Mon, 11 Sep 2023 11:41:18 +0200 (CEST)
Date:   Mon, 11 Sep 2023 11:41:18 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 02/14] crypto: lrw,xts - Replace strlcpy
 with strscpy
Message-ID: <ZP7gvmd+D2fg9DD0@duo.ucw.cz>
References: <20230908182003.3460721-1-sashal@kernel.org>
 <20230908182003.3460721-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AB4e/J+jgIzUs3dd"
Content-Disposition: inline
In-Reply-To: <20230908182003.3460721-2-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AB4e/J+jgIzUs3dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2023-09-08 14:19:49, Sasha Levin wrote:
> From: Azeem Shaikh <azeemshaikh38@gmail.com>
>=20
> [ Upstream commit babb80b3ecc6f40c962e13c654ebcd27f25ee327 ]
>=20
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
>=20
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).

We don't need this in stable, do we?

BR,
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--AB4e/J+jgIzUs3dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZP7gvgAKCRAw5/Bqldv6
8pcUAKCNTxr8jb/rTjHj23ytYJ1W5ly3hgCgrYvOHi1db9NDZa4cQDNIuHRJrrY=
=QOYc
-----END PGP SIGNATURE-----

--AB4e/J+jgIzUs3dd--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237997BF7E9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjJJJvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjJJJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:51:49 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942079F;
        Tue, 10 Oct 2023 02:51:45 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 712191C006C; Tue, 10 Oct 2023 11:51:43 +0200 (CEST)
Date:   Tue, 10 Oct 2023 11:51:42 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sweettea-kernel@dorminy.me, dsterba@suse.com
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: unneeded btrfs changes -- Re: [PATCH 6.1 000/162] 6.1.57-rc1 review
Message-ID: <ZSUerjykMViykoYZ@duo.ucw.cz>
References: <20231009130122.946357448@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jcCQIXOWVvh3I8NE"
Content-Disposition: inline
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jcCQIXOWVvh3I8NE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
On Mon 2023-10-09 14:59:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.57 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.57-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.1.y
> and the diffstat can be found below.
>=20

> Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
>     btrfs: use struct fscrypt_str instead of struct qstr
>=20
> Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
>     btrfs: setup qstr from dentrys using fscrypt helper
>=20
> Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
>     btrfs: use struct qstr instead of name and namelen pairs

These are rather intrusive, and marked with

Stable-dep-of: 9af86694fd5d ("btrfs: file_remove_privs needs an exclusive l=
ock in direct io write")

but we don't have that one in 6.1, so we should not have these,
either.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jcCQIXOWVvh3I8NE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZSUergAKCRAw5/Bqldv6
8uBJAKCxRrWPy/ocbfjE1sPtYFQgGE0xhACglmZMI8vJkSWDAXn1kXa+NsLhvnU=
=z/vL
-----END PGP SIGNATURE-----

--jcCQIXOWVvh3I8NE--

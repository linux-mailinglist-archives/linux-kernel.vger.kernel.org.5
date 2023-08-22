Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314D8783E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjHVKrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjHVKq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:46:59 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BC4E53;
        Tue, 22 Aug 2023 03:46:23 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E932E1C0013; Tue, 22 Aug 2023 12:46:21 +0200 (CEST)
Date:   Tue, 22 Aug 2023 12:46:21 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Winston Wen <wentao@uniontech.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Paulo Alcantara <pc@manguebit.com>,
        Christian Brauner <brauner@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH AUTOSEL 4.14 7/9] fs/nls: make load_nls() take a const
 parameter
Message-ID: <ZOSR/YOFU66otZmO@duo.ucw.cz>
References: <20230813161427.1089101-1-sashal@kernel.org>
 <20230813161427.1089101-7-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GWCY4bT1ife+cbF1"
Content-Disposition: inline
In-Reply-To: <20230813161427.1089101-7-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GWCY4bT1ife+cbF1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2023-08-13 12:14:25, Sasha Levin wrote:
> From: Winston Wen <wentao@uniontech.com>
>=20
> [ Upstream commit c1ed39ec116272935528ca9b348b8ee79b0791da ]
>=20
> load_nls() take a char * parameter, use it to find nls module in list or
> construct the module name to load it.
>=20
> This change make load_nls() take a const parameter, so we don't need do
> some cast like this:
>=20
>         ses->local_nls =3D load_nls((char *)ctx->local_nls->charset);

Nice cleanup, but should not be in stable.

Best regards,
								Pavel
						=09
> Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Winston Wen <wentao@uniontech.com>
> Reviewed-by: Paulo Alcantara <pc@manguebit.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/nls/nls_base.c   | 4 ++--
>  include/linux/nls.h | 2 +-

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--GWCY4bT1ife+cbF1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZOSR/QAKCRAw5/Bqldv6
8m9VAJ9P4ZQyBauDhqOmIY3yV+VR9+KCYQCdEibt47CzAfH4lIAZ1XJurGJNkfU=
=4FCP
-----END PGP SIGNATURE-----

--GWCY4bT1ife+cbF1--

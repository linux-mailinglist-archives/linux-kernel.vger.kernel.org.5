Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0C375F2FA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjGXKX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjGXKXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:23:12 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB1C49E5;
        Mon, 24 Jul 2023 03:17:01 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E72C61C0A92; Mon, 24 Jul 2023 12:16:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1690193818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S2+McpDfsYpwZYH+MJBkwRRarEXjcvPMu7pbH7YtmA8=;
        b=E9S+BZL3KPxBs6CDkplLSGg/QQJ/0h1//H2ReveJgvfYdNehkAIndTpzIrjGpYHr/xNK0r
        H5eHBqkeiIKqOy5sBmo6vjUMBonlGkJVUnJ3ms7xzlHPjbci2iJC20sSIV3L+ksq5lckHB
        AfJ9mW8yQLfyYxgEZRF9jQ5+c9RMVL0=
Date:   Mon, 24 Jul 2023 12:16:58 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        hackyzh002 <hackyzh002@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>, airlied@linux.ie,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 4.14 1/9] drm/radeon: Fix integer overflow in
 radeon_cs_parser_init
Message-ID: <ZL5PmleXslwGqwr1@duo.ucw.cz>
References: <20230724012450.2320077-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+r/USItxKtE2w0t+"
Content-Disposition: inline
In-Reply-To: <20230724012450.2320077-1-sashal@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+r/USItxKtE2w0t+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: hackyzh002 <hackyzh002@gmail.com>
>=20
> [ Upstream commit f828b681d0cd566f86351c0b913e6cb6ed8c7b9c ]
>=20
> The type of size is unsigned, if size is 0x40000000, there will be an
> integer overflow, size will be zero after size *=3D sizeof(uint32_t),
> will cause uninitialized memory to be referenced later

I only got the first patch of the series via lkml, rest seems to have
been lost somewhere :-(.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--+r/USItxKtE2w0t+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZL5PmgAKCRAw5/Bqldv6
8oUOAJ4njNirimaFu4/gfUrc8WlC9GYNkQCfetCwTrc84IdGOfyYeVmrgQY1xI8=
=Pe6p
-----END PGP SIGNATURE-----

--+r/USItxKtE2w0t+--

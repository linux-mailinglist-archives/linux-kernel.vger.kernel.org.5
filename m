Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5487D77002B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjHDMZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHDMZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:25:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69FFAC;
        Fri,  4 Aug 2023 05:25:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6812B61FC6;
        Fri,  4 Aug 2023 12:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5DCC433C8;
        Fri,  4 Aug 2023 12:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691151935;
        bh=Fynirg1lkcY2V0A7ToXBhk0B7jD5r4n97Rn2k9O6NaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bZXKqIJNg1uVNO/LL5OrEnsKH2VWwIHftGS7VhbLhwTyOe8kbzrDZLo7kJoO98Er/
         TKIx8++hKx76d7NOcuAc7+BtGWUHP06NoACy+XunJ6b+fre8DxbQdUxY9P31JkFPFS
         v5EVy0xUlb4/6ixQQPzvEwOlaOS8Nw/wt6yhhb08ZBWFbkoXqChzAUkblicodZWBFv
         agOt5zLa01ayaT28mxVmacjnFI5Tkb5R0OOpSMFT3aWVYLLQV94hfUegqyzqn3rD0+
         Wyl5KPVN3LA6NvmJyN3izLJcF9QYnKtjzXwIKk/eCkULOXNX3dCR5A+ew70o9fxAP4
         kw+tgo+SLRM0w==
Date:   Fri, 4 Aug 2023 13:25:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     like@awinic.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com, wangweidong.a@awinic.com
Subject: Re: [PATCH v2 1/2] regulator: aw37503: Remove unneeded fields and
 switch to using dev_err_probe()
Message-ID: <f2f299b3-0747-4d0b-9c00-b598f6e54ee6@sirena.org.uk>
References: <20230804102703.931418-1-like@awinic.com>
 <20230804102703.931418-2-like@awinic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3s2G+2MBBJdQ6k7b"
Content-Disposition: inline
In-Reply-To: <20230804102703.931418-2-like@awinic.com>
X-Cookie: I'm hungry, time to eat lunch.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3s2G+2MBBJdQ6k7b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2023 at 10:27:02AM +0000, like@awinic.com wrote:
> From: Alec Li <like@awinic.com>
>=20
> These fields are not really need, remove them.
> Switching to use the dev_err_probe() will be easier.
> Keep the Kconfig and Makefile sorted.

This isn't a description of your patch, it is an inter-version
changelog.  As covered in submitting-patches.rst this should be after
the ---.

--3s2G+2MBBJdQ6k7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTM7jkACgkQJNaLcl1U
h9AQNQf8C+38PdmKLbx8lKWCyXlwOwWKhU0l2uZjHbHsAnRV42SzBs7lFkKJk5Ie
+bgLMhjkSlgCSGMyus3uKSYOh8LVjp94WUxPhaDiHagdgeUOynDCsNsyuS73KwdG
7xRsV8QQ6yXj4GGs3UHZcUZd4dE/ZfVYv2Pws1DV4CgXBOw8zD2yxQGWmwjQLRrZ
PAww4e71kLaeQciklf/IHiHIrt9k/IvGwjaBwSYw5pql7+ZaxwMvEuTciwrNhjKQ
9ne2PLHNXChWH0aJYr4ulxZjiqGqLjtNeTePkv/Yr0rm5aGSC0Y/Ax+BIMRHSUar
UwcZ93LP0aFhYXiowJc792qRM+sSKA==
=/z5y
-----END PGP SIGNATURE-----

--3s2G+2MBBJdQ6k7b--

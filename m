Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A88377E731
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345053AbjHPRDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345096AbjHPRD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:03:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F39E26BB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:03:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDA6E61924
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 17:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF655C433C7;
        Wed, 16 Aug 2023 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692205404;
        bh=ev4FifmbigM1CLVALqUmJT03ZpWYzZyqPMwN2b+ho/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xfm+zHxmWpxJ6jJyINNaLWSzf2iAhhy7k/5RYYX7c6BHVzx/HskKquQQudNDMdwPv
         xYc7hJiSDHbxkm3l6Zi1WRwbO8pxDKhWFzLwvMyTejg09Viby16jN5D4kGYvSca44s
         2PsI8jAPkRlZrbepnbs8C5Jf44ESBVV1k07djmsSbcm4bPBz/7aZkbYDCLlqOByby8
         PlPVf7+tEzeI0DS7LUfG6xYIs8JIIZe4+L5Tx0EMgEdnWjemqUaygzxis9IU0SDs2b
         hEdzn5+rvEWRavLnwLniIvbX7FwexXGtOapIljZUx7sIxn9M1nW1iIqvPO1UnnB39q
         Y+cKOlQemDWUw==
Date:   Wed, 16 Aug 2023 18:03:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: cs35l56: Read firmware uuid from a device
 property instead of _SUB
Message-ID: <c3e42efc-9ddc-4788-85f7-cfa350d75d43@sirena.org.uk>
References: <20230816164906.42-1-rf@opensource.cirrus.com>
 <20230816164906.42-3-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mCxFNzxxpmJFmSsL"
Content-Disposition: inline
In-Reply-To: <20230816164906.42-3-rf@opensource.cirrus.com>
X-Cookie: Old soldiers never die.  Young ones do.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mCxFNzxxpmJFmSsL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 05:49:06PM +0100, Richard Fitzgerald wrote:
> From: Maciej Strozek <mstrozek@opensource.cirrus.com>
>=20
> Use a device property "cirrus,firmware-uid" to get the unique firmware
> identifier instead of using ACPI _SUB.
>=20
> There will not usually be a _SUB in Soundwire nodes. The ACPI can use a
> _DSD section for custom properties.
>=20
> There is also a need to support instantiating this driver using software
> nodes. This is for systems where the CS35L56 is a back-end device and the
> ACPI refers only to the front-end audio device - there will not be any AC=
PI
> references to CS35L56.

Are there any existing systems (or might there be given that the driver
is in released kernels already) which rely on _SUB?

--mCxFNzxxpmJFmSsL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTdAVcACgkQJNaLcl1U
h9Bpvwf/SfY9iHnNfei4bgVEObHBYW1vvDBYoFnc8Wf7UZyhn9vOUw/B832UE0OW
nBPxsrzdR+D0pAaOhHtO+RdZYksgVb5V0Q+2ryETwUovxq+Dt3/df+3KDXzLucXf
WOzYM9ShXr+ZkOpHz0vOa+NtI7UIlf+xxr58aa3n6756SrOA1T4008bBagARKO9e
KT2dapmWvC1Om5kEMHCmx7OlWEiu1BcD2j7yrqrs0qNyIO2I6hrwiVdwxNxhmnYo
vl3ShIyd9VjulEFs+1uGccp/gGhRcj1p/3eN1h3XwIqt+90g3NbZC4xtiJztmYvu
PjHBVkrBviRXjpA/DERYZCAGJ/mHiA==
=rCmL
-----END PGP SIGNATURE-----

--mCxFNzxxpmJFmSsL--

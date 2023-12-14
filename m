Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C43812DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443790AbjLNK66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443752AbjLNK64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:58:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866B999
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:58:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B8BC433C7;
        Thu, 14 Dec 2023 10:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702551539;
        bh=h2n9sJgI7iecPTEQJF6qBmcxxJPpJSZTHnxzEJ3wKwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dIA3oV97KFWRFsEPwjeyn3J35QSEO6UN5RWwt/J0MR8rIRq9TXVhwNs7XiK/XlTOM
         SAxhoDPSc/4clfeAXwme6dgXy0SYjx0Xjw/QArY5oEy4kspN9xcctNVqYQ3hmyKui8
         PzrsChKQfy6/WuX/Q66xTO0RNQ46fSdny9B1uumqtrMcqKhA4tFYyTs4TQrgG7NExL
         UlFyJMT4E4IEQJsyS4m/S9KREaarZKUwiaScxpUwTd8IdMW7z+3ZOA1FidIlHy2YEg
         z4q1cNV3Ypdi7eL1hMvxtm90sUpvmTdn6BKbHGLaTPlV/a9+UGGVnZ2Z8wSixpU9AR
         mSDui60YU0AMA==
Date:   Thu, 14 Dec 2023 10:58:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH] spi: stm32: use runtime PM to enable/disable controller
Message-ID: <58897511-3187-4583-bf29-11871dd4d136@sirena.org.uk>
References: <20231204202055.2895125-1-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DT9MugTfRVMgx60Z"
Content-Disposition: inline
In-Reply-To: <20231204202055.2895125-1-ben.wolsieffer@hefring.com>
X-Cookie: The Moral Majority is neither.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DT9MugTfRVMgx60Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 04, 2023 at 03:20:55PM -0500, Ben Wolsieffer wrote:
> Instead of disabling the SPI controller between each message, do it
> as part of runtime PM.

This doesn't apply against current code, please check and resend.

--DT9MugTfRVMgx60Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV63+0ACgkQJNaLcl1U
h9AFDgf/ccmdPjsD5WeSY9MvAPkSdAwIv0/d3yGNyZY8qdHL+ljsOPGKyoF26FeU
DE5beBpTNPTh7y+JLF+Zb4UrC4a2hvEHpVJ99B7AZIde+tgNkPA3JIapbwh7ehoR
a100WtJV5+KG4bFtuw9CJRepYBqaaaLjrv7euCJHgmwsJNb1OiPV+RPe5qiWN3vJ
PPJwY9HUiY7svi9F0sgYPdISw2DJw3syj1KIC92TpFeBz6L9tWhdeD5tGxkC3mDt
4EOJ61cfkbwEm7xasmlAgQHz4/+VV0Lps/kS+hyeKvpOVnCaKQeotrm5QJFJ04ne
GsI1cdjsw1qc2v8sjwCr688sRVeJCw==
=HXyo
-----END PGP SIGNATURE-----

--DT9MugTfRVMgx60Z--

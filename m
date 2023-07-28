Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6E5766BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjG1Lnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjG1Lnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:43:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FCC30FC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:43:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D089C62112
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7317C433C7;
        Fri, 28 Jul 2023 11:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690544626;
        bh=INcecSQlgL6zrFUR6E8VLZohIBeE2x7zqL6Ll+UaSqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gasNyuImC40fLQBj2ralwuJVnvB4it0n55+ai9XL/4ce32YW2bTAzOT4Uv2kUvfz7
         mtLpajZc6Fp9MYIePtPfSmiUyeyyFi8FYqk5B8cd83c8e15ty9sRT7oV+bfuzLiTpI
         unTB0IQOimI+AHma9GwG/7a82TmkRBFKDF/kWtR+wNOwMtTF9QL5IW2dy+LsSvS40I
         ajjuPh1XXg4CK8Lp1ewY7U6kEs48X5E6KqMeIpcvCFLlNtmPuEot/e5KU8oLYsrCtX
         O3juuNffyDiPZsR2Jri+AtlcLuOgkaDwiLp3HgFNeaeK0SomJHupdyaidfLTSz/+d+
         xmuszbPA1MzUQ==
Date:   Fri, 28 Jul 2023 12:43:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
Message-ID: <46853c47-b698-4d96-ba32-5b2802f2220a@sirena.org.uk>
References: <20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org>
 <CAMj1kXH_4OEY58Nb9yGHTDvjfouJHKNVhReo0mMdD_aGWW_WGQ@mail.gmail.com>
 <6766e852-dfb9-4057-b578-33e7d6b9e08e@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b+222yRq1TKxUJvp"
Content-Disposition: inline
In-Reply-To: <6766e852-dfb9-4057-b578-33e7d6b9e08e@lunn.ch>
X-Cookie: Ontogeny recapitulates phylogeny.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b+222yRq1TKxUJvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 28, 2023 at 10:41:40AM +0200, Andrew Lunn wrote:
> > Wouldn't this break SynQuacers booting with firmware that lacks a
> > network driver? (I.e., u-boot?)

> > I am not sure why, but quite some effort has gone into porting u-boot
> > to this SoC as well.

> Agreed, Rather than PHY_INTERFACE_MODE_NA, please use the correct
> value.

Does anyone know off hand what the correct value is?  I only have access
to one of these in a remote test lab which makes everything more
painful.

--b+222yRq1TKxUJvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTDqewACgkQJNaLcl1U
h9BEOAf/Vpzmc1pDsskQugJJmHrpR0lU1gCdG1oThAL1S/9ZpZdRbhCNmS9vsNjb
jmqlo7VfKcKQ7uJI/xu4RWMhHujyc+GRx8G6OMta8n5u2YTjjsK30CAgDdj6PMg8
ce3Fd3PPs0/psTESxyiL/K6Ib8S3/DcKiVe4JbkUgUvzMhkhRXMge+LV5fX16v7U
s0p5xq/fMsgB5xdcL3U3VDTlG/K9+KFly6neCTckhcqNqb9m55hLvuYNtbm3myaT
yLwWM9V3P/pX4bxfDtZGm09/URKlBOIuHpu+7M+5PVnMU0MLZjIzVamW0Cj15tAk
1irBAWD8QgtybtVR7W12IMuFYpATdw==
=SFwZ
-----END PGP SIGNATURE-----

--b+222yRq1TKxUJvp--

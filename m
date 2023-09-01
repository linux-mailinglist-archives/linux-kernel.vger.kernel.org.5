Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6E678FD08
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349103AbjIAMTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjIAMTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:19:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E44AE7B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:19:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 82C13CE2383
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 12:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60AEC433C9;
        Fri,  1 Sep 2023 12:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693570737;
        bh=sGea4k4XfE+4bD0lLMmk8xiAP+v3ZAOJ0EqU9A/+y8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rf+CI3AhZs2A2mFjJxsIg38HxWVp2mXnHtBncRlyo8unzr+5ouSHnMhu6M+J0LsQB
         YY1U6W4chQ4VxRBMfQMpAx82MvkeXHdFeGgpz+D1P0lebBBwIkQ1W34W6CMHINWsXu
         f6QXHxr8gy2wwDgVKo0QAb4roahTPl1g7w2Oob322+Gm8cPkS8v7VEuxWTXYAobcX3
         R4HgcoOdE6OeP1fDqJIekE9g5hXKW0rT5tcAhCBnLj1wgrooACdcsUZrnBbg57FMej
         Df50SGA3lXxeG4ExACOlV0p595FkNMgob3eWnSJ/miw5bABNzH4Iaa+iGrVDEOJmBs
         /GxDxw2Uz+CYw==
Date:   Fri, 1 Sep 2023 13:18:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] regulator: userspace-consumer: Add regulator event
 support
Message-ID: <93a0f6cb-1aea-4b8d-a1a4-0f5876eb333b@sirena.org.uk>
References: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
 <20230831121412.2359239-2-Naresh.Solanki@9elements.com>
 <5000a233-e992-455a-bca3-79aaa8713ff4@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zK0u6SO2H1t1rVxo"
Content-Disposition: inline
In-Reply-To: <5000a233-e992-455a-bca3-79aaa8713ff4@hatter.bewilderbeest.net>
X-Cookie: Dealer prices may vary.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zK0u6SO2H1t1rVxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 01, 2023 at 02:27:28AM -0700, Zev Weiss wrote:

> I for one frequently examine things in sysfs using shell commands like 'cat'
> and 'grep' and such, and I suspect I'm (very, very) far from alone in that.
> With this design a user doing that could cause a monitoring daemon to miss
> events that it was expecting to receive via this file.

> I don't think we should be creating sysfs files that are secretly land mines
> that allow a curious user innocently peeking around in sysfs doing (they
> think) read-only operations to break things for other programs using those
> files.

It could be switched to clear on read.  Like I said on the prior version
the userspace consumer is a bit of a sharp edge at the best of times.

--zK0u6SO2H1t1rVxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTx1qwACgkQJNaLcl1U
h9DG8Qf+ImJaOhO+lsZDd6kuE89XXMoVAZobVGL5Sjo+0Sm5LXYzzmLfPm1Nj/S4
rCZhSCGJleCq6+7OkkBJ55lFVJZf1JumogMWwqmgxyyunjEmiPOard9jg2FZqSr0
HG1fXHTEPk667X3/B1eKGBHANlltGx2psKDPmhvmmS0L5OIv6a7lM+OXDXyQOGdC
SSyCbyQBupffsq+NNQNUyEX4qFERdEQjXpNT9352F89PIZIXpJKlTkceZRV1OBWQ
EzCmM0CQvGCF+njLWBy6QpeT4/vmaC/+O+igNCsh2OMos8RzfPrD/+n5hF87Ibyu
tJcUJsbpPheqNtuS8QSt0WtucHHm4A==
=zF45
-----END PGP SIGNATURE-----

--zK0u6SO2H1t1rVxo--

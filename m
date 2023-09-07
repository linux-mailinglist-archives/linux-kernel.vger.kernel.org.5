Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5359D79778B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjIGQ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbjIGQ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:26:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9716A7D;
        Thu,  7 Sep 2023 09:22:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2430EC3277F;
        Thu,  7 Sep 2023 11:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694087504;
        bh=zjCLSVlz5LdCpC8IOpacCvdlUauv1FO+yJco6i36Oic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SqUytxf6zXbzBIIkpjtKMhcFfrmJPqHiIboWOlhpunBvqIjcLazGaEq1guZ+y0hRI
         Bu0087gvzOUJwwaOADCNRZLmNLQIVmFe/BX/T/SFl+5+Xg9HD+L/e0JJFX2l6i/koq
         WnvGt5s1VGrabaFiyZ2/CdJRL4+7a8WixhRxQULr7OzK3B+E3k1Gw3pOz1CKu+2GZq
         Sd1AlnviH2HtKpNHVOrpwl1YcMdI7rdW+LctE8YH6Q8Vpd0XBFFLqXXb4754DnoLAo
         zh61V47/eh7v3+V61IOdpGE180+ykPp2csE0qn8tlopWLb4A7wVOKOxR6VW9xMwyzz
         nBBCZDDex/VoQ==
Date:   Thu, 7 Sep 2023 12:51:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates
Message-ID: <2c3371b7-3dae-48d7-8cc8-1acfd5bd267c@sirena.org.uk>
References: <1694069533-7832-1-git-send-email-spujar@nvidia.com>
 <1694069533-7832-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HG1UHo7ZQGFGM8s+"
Content-Disposition: inline
In-Reply-To: <1694069533-7832-3-git-send-email-spujar@nvidia.com>
X-Cookie: In the next world, you're on your own.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HG1UHo7ZQGFGM8s+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 07, 2023 at 12:22:13PM +0530, Sameer Pujar wrote:

> Fixes: 202e2f774543 ("ASoC: tegra: Add audio graph based card driver")
> Cc: stable@vger.kernel.org

This is just a performance improvement rather than a correctness fix as
far as I can tell?

--HG1UHo7ZQGFGM8s+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT5uUoACgkQJNaLcl1U
h9CANgf/U94AHJ9kaYX/llz+gCrnDPZiKF6ybEtAU8/FafiAXB1qqhJXgW7rYlOv
w1oreyoLvt7fSSDilpCBjkB95pwSzAsqtuoGj1jvwfszhZtNuKBAILsU3TEQYuyh
ZJ9sSzvEiWM3QAYyIqSfQuPGbkQ0vZ0uHk3jE/M3t2MB6XvTzijC5HAU5lSqKf5q
KB+sHqqvMZDdQHADUKo7kgd6CqMEDriZAkoL4OSpYpBQN45gU5qDGzpZi9E9qIz8
9M5cGuEnzj4Z6Bh8KrFf4xEQOp/rKx47iz3KfkXpVJaBWASm+vqeFfSCR7DGxaKq
n/GTqlWdCZjilEbg9YapCRGiljEkVA==
=D621
-----END PGP SIGNATURE-----

--HG1UHo7ZQGFGM8s+--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFA5797739
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242132AbjIGQWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242278AbjIGQWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:22:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBC1901C;
        Thu,  7 Sep 2023 09:19:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23E2C32792;
        Thu,  7 Sep 2023 14:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694097344;
        bh=GY6/oA7SpWwIF/ML9jHKi31Aw6dDj+gK/Pfk0CzMgqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=meYesdsY2uNTDb5EWe4281EIPUqP+ejVqDZt9LCkSfXPg4Irrz3V+aN6tNCzOlgc2
         ahh8dLGQQAnbuiFUv6CfwEQdgMoQh2Us23Bv55rnXFCgCOLrOmRgckQmB49BCwBfNT
         F3vJeT816sWqUt+PmdBvRs2D4bFdqQfjc1DO7pMD099Ku5mwQT/QLbNiAWJ/KW2x1x
         2ft6mNiLln57pjQduAluykFZGPrhx+sfNSVVZRVaXjbIdi+4wugfRr70TqxfCMPe1l
         Gbt/aytSPZ6Z7sQtswCgUTVlJunB/G6M+lsApHXzAaRfDmEyiemOTyTCnbq+vrNOO9
         r6MAC/pLNbtjg==
Date:   Thu, 7 Sep 2023 15:35:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates
Message-ID: <262708f6-d25c-4734-834e-6a3959ad6c07@sirena.org.uk>
References: <1694069533-7832-1-git-send-email-spujar@nvidia.com>
 <1694069533-7832-3-git-send-email-spujar@nvidia.com>
 <2c3371b7-3dae-48d7-8cc8-1acfd5bd267c@sirena.org.uk>
 <61ca531e-6138-7abe-74d1-357369134748@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1d4+VEBxjo3mBMnm"
Content-Disposition: inline
In-Reply-To: <61ca531e-6138-7abe-74d1-357369134748@nvidia.com>
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


--1d4+VEBxjo3mBMnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 07, 2023 at 07:51:13PM +0530, Sameer Pujar wrote:
> On 07-09-2023 17:21, Mark Brown wrote:
> > On Thu, Sep 07, 2023 at 12:22:13PM +0530, Sameer Pujar wrote:

> > > Fixes: 202e2f774543 ("ASoC: tegra: Add audio graph based card driver")
> > > Cc: stable@vger.kernel.org

> > This is just a performance improvement rather than a correctness fix as
> > far as I can tell?

> This was supposed to be a performance improvement. However this is found to
> be resolving a DMIC clock discrepancy and suspect is it happens because of
> back to back quick PLLA updates. Thought it would be safer to have this fix
> in stable releases. May be I should mention these points to justify the
> 'Fixes' and 'stable' tag?

Yes, please - that does make sense as a fix.

--1d4+VEBxjo3mBMnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT537kACgkQJNaLcl1U
h9Aybwf+PTHcefnbcaqpdAilafzxlBkq71oJqgpR14bRtbQXU4jEgToFVRwoEe2r
eh7710aUYzNQatW+EVTp6OlxujcL/CmTLyjzdmVZDRViDZvVTtq1BwnEMBPVoDnm
VQd2uTPqMq05uopzbCnq2s3Mv5gEcw1PPMnqAYvGBOJ+e1XvlBC4h7t3svkcHHku
Y8QCOwyGF+Akq3Dl7WFvenZ0rGJ7z2/NXP//rD2TXeKorRSID19tupKL+i4KJPFV
9RLhqpX/8CpXvo2EwlOSuWvtvN1Waqego6zmQ511uj90I1K24+dY9sgXk8JEE/6L
gsWaQE4XT7wbfut/xeALndmOVrDk0g==
=Ei6H
-----END PGP SIGNATURE-----

--1d4+VEBxjo3mBMnm--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A12E7B46BF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjJAK0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjJAK0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:26:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE0BC2
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 03:26:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3025BC433C8;
        Sun,  1 Oct 2023 10:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696155962;
        bh=s9/p99kT0VYsx4yrVdBNhfgZ/TYCwb1BgJDgHsY9SKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPsd1NtMIOV36cBYv5g/jT6AEaaeRDZyk7BW+L4HreTrkgYqWZ6x/TSUsZ+7ziNuZ
         9Rn8LeX9PMe2KSTLnINi2MSMiiO26q3sflB+2mIAkWnqpQvaO9UWVLS50Rfqw9iVQN
         lWv7Xl2FYH2bElZYg9JgmonlH8t4RRvIpkyo86m8g/WR/KnzH4ZeMVh2iBoPPr7gSR
         LFfA1QJb0J8ASgI3RaRIPYTIxifizJH6DCzM7yATRtvJGiOju8/6so3rmZdVbLnGCN
         WVykFaHCUXCKuNfmtqjVXArcnKLffNwv9QsfHlQ0YsR3Au7i7d3bbyDTgMYeMf2T3J
         sCGAx0vyocx/A==
Date:   Sun, 1 Oct 2023 11:25:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: SOF: ipc4-topology: Use size_add() in call
 to struct_size()
Message-ID: <ZRlJN9qVOv7CIu1N@finisterre.sirena.org.uk>
References: <ZQSr15AYJpDpipg6@work>
 <169601489953.3012131.13922425518082792309.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ueidA5gUlRHLLhJj"
Content-Disposition: inline
In-Reply-To: <169601489953.3012131.13922425518082792309.b4-ty@chromium.org>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ueidA5gUlRHLLhJj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 29, 2023 at 12:14:59PM -0700, Kees Cook wrote:
> On Fri, 15 Sep 2023 13:09:11 -0600, Gustavo A. R. Silva wrote:

> > If, for any reason, the open-coded arithmetic causes a wraparound,
> > the protection that `struct_size()` adds against potential integer
> > overflows is defeated. Fix this by hardening call to `struct_size()`
> > with `size_add()`.

> [1/1] ASoC: SOF: ipc4-topology: Use size_add() in call to struct_size()
>       https://git.kernel.org/kees/c/93d2858dd630

Why is this bypassing the ASoC tree?

--ueidA5gUlRHLLhJj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUZSTYACgkQJNaLcl1U
h9BtXAf+JtOZ1WQU2/T+zUaB9MU7XCgIHdDZoo2/uFRURhrBqZb+sQe0NWOJRR7J
6hWBccpjhIJU34f2MqHtmZdYLxWIPUsK4QrSF6sBA0/2L4cUaTpqsn3fFczMkAkc
W2zwOj1mPDz+VAdHrlSSi0JY3DMjVJX4needmY9LG2vajHvi7eLmVk0W0pdBBlt5
YdTLfdPyDCBzTFEnwu9Oj0B5PGDaEWZoZ8E2DSRnr6rOEJ/t0QBGPtY/kJeWes20
AGI592EbRVJT22z5eWOXQuyVz/S1n7kUSqngUTSkJC2LN6ijELH8O4frF4BM3p6M
afdsDhRrIbChhtiVd3YcWOWNsAXm/A==
=OPOT
-----END PGP SIGNATURE-----

--ueidA5gUlRHLLhJj--

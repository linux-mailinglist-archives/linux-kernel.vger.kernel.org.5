Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE986757F20
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjGRONW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjGRONU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:13:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F85170C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:13:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FEAC615CE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09652C433C7;
        Tue, 18 Jul 2023 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689689598;
        bh=1GVZIwSM9BIamWibq6pepHnCBx3CgDKaQIbUpZGGjj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mq8yJZ5hVIWqZ1ekBoX75Yn9/y5jD5cHrpVzYyA4dLXVoM1/jj6uH11HE4ynmPSgS
         OVdoNuDcukH89+Ja3vsVjlTbqF1XcCsdGJa1S78TmoJsQxoucKvM6Jg8Kpu4EEah2C
         wzI0sS01Eh+DelVhNyh5fcYDmRKVqehm97eWGRlXhUIr2A5RO4qUzUftcL4yjfojIV
         nFTmlwrGCKH/5lSPOi+wm7GHaSJvGBD6BuxzSNYrIjrQzathjI2WbEADw65Xe9sUew
         54CGtCA83iu6RPRSXS1yxHZs8zBXY4HT4b2SK5d0Ys3zWxA8DvN7bObvGUuQ9OIzxo
         vvUkgfoaUwBfQ==
Date:   Tue, 18 Jul 2023 15:13:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Matthew Auld <matthew.auld@intel.com>
Subject: Re: [PATCH 6/7] ASoC: SOF: Intel: Remove deferred probe for SOF
Message-ID: <5a54647b-15fd-47dc-92ef-3e349bcc5d0b@sirena.org.uk>
References: <20230718084522.116952-1-maarten.lankhorst@linux.intel.com>
 <20230718084522.116952-7-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AMK9cj8txzvO4hFQ"
Content-Disposition: inline
In-Reply-To: <20230718084522.116952-7-maarten.lankhorst@linux.intel.com>
X-Cookie: Nothing happens.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AMK9cj8txzvO4hFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2023 at 10:45:21AM +0200, Maarten Lankhorst wrote:
> This was only used to allow modprobing i915, by converting to the
> -EPROBE_DEFER mechanism, it can be completely removed, and is in
> fact counterproductive since -EPROBE_DEFER otherwise won't be
> handled correctly.

Acked-by: Mark Brown <broonie@kernel.org>

--AMK9cj8txzvO4hFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS2nfcACgkQJNaLcl1U
h9AF4Qf+K0+3rMDv85bxPfllcFehtwXonKlWt+F8HVh2UAi14oFjYoJj+ks/JRi1
MJrFfldIHimsPOtCs0OFQXuudLtXQUvWH1v3v4fbX0KazOJAmi8UHdXk8ZKigc0V
5aSf66WnV6nJCGYEldw+MHOv2oCOZQCzmFgsQfOQlbuWHdOP04lwG5CNCP3wlY03
4anEdlNnBcCRtOh45C0CGldwB57mxdZ47zoddgfpKGzHfC46knQZQ/+QiWtu+03G
w0VlVaJHbeBbDK5s0BClydgBj4fm8VyiikusXuH/yD2All8i0k9T3DLIuZp6mTRP
+KF6doVSqVZ6Zhhp5KKu4q+IzQysiw==
=ZsDS
-----END PGP SIGNATURE-----

--AMK9cj8txzvO4hFQ--

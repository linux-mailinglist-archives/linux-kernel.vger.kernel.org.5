Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61101765291
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjG0LgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjG0LgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:36:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E76A10FC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CF3C61D24
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D22C433C7;
        Thu, 27 Jul 2023 11:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690457780;
        bh=ivBrfnksuev81Xr0vG/orlS3M87dt7cmsHbn47jqyjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMMqvdh9u+wKoVfc+WgyxCN9r/p/0N5jVJqEex7ccZUBXlRWeIZMI94RRlbF+WOef
         nGJY8EwrJDZL7VikRRPcFdBDbvaFcBw3KRhC/7uYrf2WjhWzxJm4Lid3dptY4Bpeva
         JKgwm3ze7geXOnO/v0wILzdpxrfwulH7OLKwzJno4gbNW4XBq9IdAbvO92XYGqIS5Z
         kY3xc0LxdpgQu4tcAd/0eM8vns0auZdMVjWdk35Vc8kv65jIcKXHOylrdxdXYZ05/5
         bkr5Bkz9X04Aqr4khQDsiDhm9PCa4KJU7wX/eR2Q1D8C1aKqvAipU/Z1AfTqNmI0lU
         TCbCkNK15NDpg==
Date:   Thu, 27 Jul 2023 12:36:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Liao, Bard" <yung-chuan.liao@linux.intel.com>,
        "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        "Bhat, Uday M" <uday.m.bhat@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: maxim-common: get codec number from ACPI
Message-ID: <1b5c0524-bdd5-41e2-8799-b699525b7a56@sirena.org.uk>
References: <20230720092628.758834-1-brent.lu@intel.com>
 <20230720092628.758834-2-brent.lu@intel.com>
 <ff55e63f-1c17-12ef-57e6-144a5bea4480@linux.intel.com>
 <CY5PR11MB6257FF6D92D524D389B734C19701A@CY5PR11MB6257.namprd11.prod.outlook.com>
 <c1aadbcf-78ab-0566-84e5-8eaa7b418d50@linux.intel.com>
 <bbf9baf1-d55b-b846-740f-1ed8976b82b4@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0nZ4EJfE/aVtFY7z"
Content-Disposition: inline
In-Reply-To: <bbf9baf1-d55b-b846-740f-1ed8976b82b4@linux.intel.com>
X-Cookie: Go 'way!  You're bothering me!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0nZ4EJfE/aVtFY7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 07:41:53AM +0200, Pierre-Louis Bossart wrote:
> On 7/27/23 5:21 AM, Liao, Bard wrote:

> > The point is that if you remove them and they are still used somewhere,
> >=20
> > you will break the build. i.e. Kernel will not compile if we apply the
> >=20
> > first patch only.

> IOW git bisect is broken and that's a big no-no.

Yes, I build test every patch so I'll notice.

--0nZ4EJfE/aVtFY7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTCVqEACgkQJNaLcl1U
h9C/hQf+LxkQQHutKl7/U3u1expUOoh4rffkGKzdDOF3cFMYvuZXpC1LQ31kZKCM
wpRU3R7I+4jSwfpl1ukj5FbIFpFUygT9+pBnSsLM5zulec3Jn5cHWd6Pj0oMrl5x
74qfSFzDLOqNIBvt53SugOqY/yP22ivlVQaKG+IkUKxTKibfwEUcbLEu5by99XgY
5FEtU3hKA2ujGY+pGo4W3LPcDHEl8/tliRx4+wKmNa4nsoZcUJWpFx2i1CJzXgkQ
AyCLagEE5q41Lk59zOqSlLUYDWTNsX6bzDi4P/pijZFFOuT4q7vpdoOMDjJk7Q2M
cFT5uzzwQWiq6yeCz3WR+3J01CQb6g==
=8BNm
-----END PGP SIGNATURE-----

--0nZ4EJfE/aVtFY7z--

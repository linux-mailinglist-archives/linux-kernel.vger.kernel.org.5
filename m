Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DB3785751
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjHWMBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbjHWMBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:01:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B33E5E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:01:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77A5760F23
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 12:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3C6C433C8;
        Wed, 23 Aug 2023 12:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692792090;
        bh=+qxx9c835FfuA1kXHiCO2FXriByw1VW6r27tvA4DIV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0cYXEFtOZmvS9f1ZyhHu3qOlgMR9lM2JeQN5pI2RfuEJ55I4iGR3vWbgbWFLoeWr
         ektm3RnysWW679tOWdUIJafJoIV6kKT7oJY6MHxkWBgpuFqqr6yC6URM8qrwJeiYxM
         y1kPg8/C6VBHhySyketzc99Of0Im7p0RKu+zo1RN5BECEsbc9usuSIObPQnaxLd+gH
         Jkldhnanup1GMNFmqKNSfBtz7563I4KPISVEGBmlm7g7UqtbSk4L/Zqxg/4yjn8/PI
         RU0xjQ8LWRGbiwxSMQ1n1dxxc4PpGX0Xqe3ZfFLbed1HbN9PGkdp1vaFYyEl+e2jq2
         IAMx1Ld3zj8/A==
Date:   Wed, 23 Aug 2023 13:01:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Yong Zhi <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, Brent Lu <brent.lu@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Terry Cheong <htcheong@chromium.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, apoorv <apoorv@intel.com>,
        alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1] Revert "ASoC: Intel: Add rpl_nau8318_8825 driver"
Message-ID: <dd6d51b0-cc60-4fb7-932d-1117143d1715@sirena.org.uk>
References: <20230823040755.2217942-1-ajye_huang@compal.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MBcFXgJDzxWkGZnR"
Content-Disposition: inline
In-Reply-To: <20230823040755.2217942-1-ajye_huang@compal.corp-partner.google.com>
X-Cookie: Some optional equipment shown.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MBcFXgJDzxWkGZnR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 12:07:55PM +0800, Ajye Huang wrote:
> This reverts commit 6b8b6892e43419f5339c47d307b1baac0eea036d.
>=20
> Report from kernel test robot <lkp@intel.com>, that
> in broonie/ci.git file0yZ50U, it's redundant
> commit 6b8b6892e434 ("ASoC: Intel: Add rpl_nau8318_8825 driver")
> because commit 273bc8bf2227 ("ASoC: Intel: Add rpl_nau8318_8825 driver")
> was committed at 2023-08-14.

6b8b6892e434 is not applied?

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--MBcFXgJDzxWkGZnR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTl9RIACgkQJNaLcl1U
h9Dg8gf/fG431V157LLa4NzxUiQbuVBUo6pIu6PK37YsZkh6Q9RRnnaEdS2lg2MG
C/EWEXWhvyV2n4zIrP+XVyIA+v3/zpSp5ES0jaIMHzSrF9A8ntqPdsh+3TXQ0lqi
F/JZ6RFemqK9GUmF3xCdxWF+/seCmKzVwM0PUpX7lCSxs2duf0IETtl1HnLFp9aY
fZLKeYLLzBEvmPEdEekkEXWqFjesgFgAUqJF6HgDUs3qYb9VLWvwuMiHwLakTc7R
X7QJsdRR+nN1mnJu/AOYGCcGddKPJBwn4uTeFa30X4+vfM1AIkF/wHWUVMae5cgv
TlP6NTJFpnSq1lFZMBFe9mIOOtlK9w==
=kYaH
-----END PGP SIGNATURE-----

--MBcFXgJDzxWkGZnR--

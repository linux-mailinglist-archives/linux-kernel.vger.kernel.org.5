Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401EE785C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbjHWPvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjHWPvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:51:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9BA10C7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 797A76210D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5236C433C8;
        Wed, 23 Aug 2023 15:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692805870;
        bh=ADd7oP1/d6c3aMgL14nq5nf0xJcSv5Z92YrLo2vXc+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0Nn8KkX888lKSilqWK8lqv0YMZVwtNhyxd5E4r9zzLidxs9n0j9WZruAB3jWJYk/
         sy+wnYP2VA6UnkdZabC3WwRhIrBTTzPFjz2eTNSolzH4a/XbWhNOZw6reQsUBmpMqH
         aeOb2Nm4hLDHybFqD1sdMoB55lAbl/t51fgyc3cE2PyB7iDadIw7AajUVJyyLlKCdJ
         HLo+305rjRj94qQbddu33zj/xlfB6X1LvVbfBAt/OEkAxvoj04f+7w98UFTQofBmt7
         FOXIs6pTXQSJvEEyPr3v247l69Cay3XDuqCSo1ufbicFYsYUQKM9j5w8e13flHrGiH
         gMMiRiUlw3kng==
Date:   Wed, 23 Aug 2023 16:51:01 +0100
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
Message-ID: <2ebbcb7a-bc0d-4f62-9f4b-706f0270b71a@sirena.org.uk>
References: <20230823040755.2217942-1-ajye_huang@compal.corp-partner.google.com>
 <dd6d51b0-cc60-4fb7-932d-1117143d1715@sirena.org.uk>
 <CALprXBYxrwBW6HLP5MwYhFh1_Skei+pLbXd7yNAEuhLTQJLVPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gs3xv5excqw7RFrX"
Content-Disposition: inline
In-Reply-To: <CALprXBYxrwBW6HLP5MwYhFh1_Skei+pLbXd7yNAEuhLTQJLVPg@mail.gmail.com>
X-Cookie: Some optional equipment shown.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gs3xv5excqw7RFrX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 11:45:09PM +0800, Ajye Huang wrote:

> Please allow me to explain in more detail.
> The 6b8b6892e434 should not be applied into file0yZ50U branch of broonie/ci.git.

That's my CI tree, things in there aren't going anywhere unless they
pass testing.

--gs3xv5excqw7RFrX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTmKuUACgkQJNaLcl1U
h9Aj7Qf+OO9n7pFmDLqmTaZ+TUXsgXxHBU7c2buA+pHaL6GdSYX9Z4BSey6nKNpY
Byr0X9nXoDSeVReO9AhK3aPz1FwlkR8oyI8OQgg1tvSm5eF8rvs7KXtBnwA1xvaA
spaEizonya+TtLhmESmTyQPpxDXqdfscAwEDOgJh4I/lf6rQpcUPknPFrWXYaVJC
9DScI9v70bDXBdEiM01pOe/59gtnfxoWtLu6svNGRNaRIJtLsrf5YZP4I1pquUIN
U0dn9g2I9S0qL/g92/k+DgPszGBpKTzlRWUICmejKyqtjRJuxhdJorU3NArd0L4+
DAXGQbW0vkxQyRszEJ2O4mjYJBnpLw==
=Kv8M
-----END PGP SIGNATURE-----

--gs3xv5excqw7RFrX--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B843F805C55
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442503AbjLEQAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjLEQAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:00:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3945E122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:00:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F83C433C7;
        Tue,  5 Dec 2023 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701792011;
        bh=kI1bEHAXdFXKf87FBcJ74Jf1vavpx37Cc9XIkiHEP9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ulVhU/9MchpQORyRiVvbLnQDmvxyfH56LbUL36dYvVxn5mIABX1YCg8mB17vDqs/l
         oa5K7sqGfVwZjazeVMsvPudvDoRl3zzDLHk4dDClUfYHf7Nb3lQt2bDFogW5Iz00AA
         uC7ph3H5opZzMzrYs/a+j4F10efqCCEA5A3EmpVlhLx13ilsu7+BaIsWmd93hkkF9K
         2mM72WIW0HMkaCz1qUzR0oaGwGuaW9z8/+Z9efK85co2l1cvDu3Xs9s7ExECfN9Mbd
         R8A1ra2ld7sZkHeMaxllBza+wIgR5kXp6RYiHJSkx6p9GAmR64ntnRUu0d4HRVrg69
         YuE+E1uqZkmGQ==
Date:   Tue, 5 Dec 2023 16:00:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
Message-ID: <9d3bdd33-cc23-4c80-a120-68898ba0c572@sirena.org.uk>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
 <20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
 <ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
 <20231205105246.a0864cd10ff0252dec9ffabc@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JI9VIstDJQZBToA8"
Content-Disposition: inline
In-Reply-To: <20231205105246.a0864cd10ff0252dec9ffabc@hugovil.com>
X-Cookie: I've Been Moved!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JI9VIstDJQZBToA8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2023 at 10:52:46AM -0500, Hugo Villeneuve wrote:

> after our discussion about regmap range, it seems that the
> efr_lock will need to stay.

OK.

> In fact, all of this helped me to uncover another case where an
> additional lock would be needed.

Some progress at least!

--JI9VIstDJQZBToA8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVvSQYACgkQJNaLcl1U
h9DHvAgAhZlTxMcszRkCry0LDAA0dP9cZcvYJOumjy7Ptr6AQgWDy8IWNTFUffCC
tiFwXlTcRu25amPCa2j2UKZrAXtrvrp9DLSNVaA5TiTlko9ANHJ3QGRqFmDREw7z
4wKGIx3HCSgrwl5+7DckDHmc1ol61cJ3QfThvFT96F8C0pEVew4DWdMwjBS/mes9
xuzly2qP048donet3BQ9fiO4rV45daoOERayGX2NPuimLFWNyhZ9pCWdlIZNpzK/
cDFZkm9OmCNxr/f0c9fXuU//t7F7jmOxXjv2cL4HfgM0QQJ2S1IBjlZg4ZYP/CKJ
5mQ091vJy0ak6GYvUZjagtEbU9knxQ==
=tuud
-----END PGP SIGNATURE-----

--JI9VIstDJQZBToA8--

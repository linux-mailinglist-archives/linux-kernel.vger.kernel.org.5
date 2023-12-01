Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72118012E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379334AbjLASei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLASeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:34:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CC912A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:34:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7A9C433C8;
        Fri,  1 Dec 2023 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701455683;
        bh=lYdOkcbomoCo/nDtxoX8etSmCoMmoEHguT3Ti1W4duA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UOhhNVOSw3fCPve8hlbeOyjnlL/v6IMxAd+k0rooLnXPrHQgk7tlahDTnB97llX5G
         62nda7t9cMp0s4sGUckPKPGjYw/QadaFD2kItLLWZ4MsNLIcvVZ+5chTMsdZE5Q8Ej
         YPBZ0r84e/W5xc+Ln3K8K0cPaDBkQJKtabtrqvNkAijylqEsATBznw3BCJ+OAOIeze
         bjKxqioabN/eGCf3/8QgZMHq0PCxnEsbJjv3YGJUmwCzY4bCGBqPsrR2T69ZgzqXTR
         zgu4SV++amgJvCp7oiTViI3d7rZsFVAVogEv6k8wu7YTF0AtPHQYn+2TRxbMWFLzev
         3xI3tdib1faMw==
Date:   Fri, 1 Dec 2023 18:34:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
Message-ID: <ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
 <20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gAP8eIWqXiRQDLma"
Content-Disposition: inline
In-Reply-To: <20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
X-Cookie: The early worm gets the late bird.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gAP8eIWqXiRQDLma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2023 at 01:27:36PM -0500, Hugo Villeneuve wrote:

> it is funny, as I am preparing to send a patch for the sc16is7xx driver
> to convert FIFO R/W to use the _noinc_ versions of regmap functions,
> inspired by your patch 3f42b142ea11 ("serial: max310x: fix IO data
> corruption in batched operations").

If you're working on that driver it'd also be good to update the current
use of cache bypass for the enhanced features/interrupt identification
register (and anything else in there, that did seem to be the only one)
to use regmap ranges instead - that'd remove the need for the efr_lock
and be a much more sensible/idiomatic use of the regmap APIs.

--gAP8eIWqXiRQDLma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVqJz4ACgkQJNaLcl1U
h9ChbAf9GpZIS6eBd6Ine2BXBOp73JNB258Km8SfUElURLlKyXyp+U7Zx0fVC9kr
/QTWjWU6knqGimoKpz6qSMpHEgzLvsTtDHd0ZqSdqnJasG7b0nGnnU9RYuPlknP/
W2/+GFsWXp7MIDrDLw64stkvW+XAUj/DPtVSbC2cptRQg58u+0OdFBdh1jREUpBk
AQlUWPzRK/sNyQ+z7I7+28yRd9hsrNAr4B8wcyZY371boAdyJLGnuCop0KiyhXjc
8w6K90XP0sfYWjebkRMTy0pMWpwUecVYGNJUyEgsSTN4l9C/y+kyWEPpwmij5Fin
tE+vh22LAogp64YZbvuwKX5vo2b60Q==
=I0gd
-----END PGP SIGNATURE-----

--gAP8eIWqXiRQDLma--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE6A7DE4FC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344229AbjKARFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKARFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:05:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC1CFD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:05:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D599BC433C8;
        Wed,  1 Nov 2023 17:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698858344;
        bh=5xV6hyTIsbcZvneau3h2oVWhmP+sQM96ndcUicW+Oz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ihH1zX1/QLyCnoaOp1327n8FR6g7H3Uwfv7AywKjzqb6J/K3ydpUjjcVrLi10MEy5
         bs7qeuxwL+3u1Wb58+/E8FBO8NAnsvshg7m3Nz0gS+fRd8FXECMB9O0tQdbQLmhXdC
         Mt/BRApPU62BXvc5RIADwIvqmTrZql61MASM+7qFcDkticnFPCmrQlOj115mnoKoL9
         NoZvRT2lZUraV0WeQ7fadDPIXrT6gXQKEwhgc3n3IODboVHpf3E2a4vQA/dTpFE+px
         iJ/ppIXzMfiPJo959eOzLGMPhrxabFokwe+KQHPI+dWX7DWvFW/6bK2PkBnY6w1kT6
         93JXBVreIcEng==
Date:   Wed, 1 Nov 2023 17:05:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ben Whitten <ben.whitten@gmail.com>
Subject: Re: [PATCH] regmap: prevent noinc writes from clobbering cache
Message-ID: <b0e8c9f5-7aff-4adc-b5bc-d61c6107c07f@sirena.org.uk>
References: <20231101142926.2722603-2-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pw5rt8tNwUJb6Zfg"
Content-Disposition: inline
In-Reply-To: <20231101142926.2722603-2-ben.wolsieffer@hefring.com>
X-Cookie: P-K4
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pw5rt8tNwUJb6Zfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 01, 2023 at 10:29:27AM -0400, Ben Wolsieffer wrote:
> Currently, noinc writes are cached as if they were standard incrementing
> writes, overwriting unrelated register values in the cache. Instead, we
> want to cache the last value written to the register, as is done in the
> accelerated noinc handler (regmap_noinc_readwrite).

Could you please add a kunit test for this?

--pw5rt8tNwUJb6Zfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVChWMACgkQJNaLcl1U
h9Ca0wf/ZPDbcne+0fDI2ts571Uo57MW0irb1eXl6vypwEChkShmFPljDGlI4PP1
+DD0/Uw2RHR9L1b0HnQ6kYwu9HOlSnM5cIkvpEBTQ1bLicEB7pWWSCwSPmiiwHBr
6j2/G4lSqOWbHhTTgMc+Zw8ZSdSLdja2cYfQQwgNlWfAo7RQ9lclljWtBzxKnrXw
Z0P6yQ0TmiKn7L7PcEXMh3+tn6/4CH+lRqL4JxYfKvOyKHmmfqcJJuj1/BULRNQG
C5dpFretGVwsOm8fxNbyhyaO99kjUCYqxMB9HtfbcUYevmByuGbfiLSK4EAlsOGM
rU4ckTMHBgUHjvkTr6XnGMuksIdkRw==
=X9eS
-----END PGP SIGNATURE-----

--pw5rt8tNwUJb6Zfg--

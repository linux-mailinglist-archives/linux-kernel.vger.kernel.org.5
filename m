Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9C5789642
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 13:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjHZLYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 07:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjHZLYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 07:24:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A92A19A0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 04:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1844B62719
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 11:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22145C433C8;
        Sat, 26 Aug 2023 11:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693049069;
        bh=QdP+KA+OdSz2el0jN6VlJTmMNAtuZc+l4F1UYz654CQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J0ijANXefTHurOLYmJpqDvU8r5HHVuFdLEWraAEV3UZ+9FWt9LtL7TZvy+z55xe9R
         JvLJ/rRb6wLKsPE4ZRjxngR0P0LYYCNhdnaqVeABk1txbkMuyC2gL8wbkCmwxSvd4H
         qe6J0yuGF2GPGXCoCQ7KWynKmivydUNzgGtRN7tizJwXX9F/1/J4RDcSz8Fl5yfoIw
         W33nOfKm2K3rTaCHndAfLQwxLvB5qioy+GdJfykwhieW6qDCl3bpOTfzWM6FCKqyQC
         gFLoLTbMDmOui3IR13b3Dy2V7y9iZY+dH1mRnohWKdUEpiJ4zjn3kZaRPPOtEI4Qg0
         r/DicrG0kpLXQ==
Date:   Sat, 26 Aug 2023 12:24:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ASoC: es8316: Enable support for S32 LE format
Message-ID: <ZOng6WCjECi/Ula2@finisterre.sirena.org.uk>
References: <20230824210135.19303-1-posteuca@mutex.one>
 <20230824210135.19303-2-posteuca@mutex.one>
 <ZOfMo4Cb2zd1Km3H@finisterre.sirena.org.uk>
 <87y1hypz1y.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IUEZvB6woga6BL6m"
Content-Disposition: inline
In-Reply-To: <87y1hypz1y.fsf@mutex.one>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IUEZvB6woga6BL6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 26, 2023 at 12:55:21AM +0300, Marian Postevca wrote:

> I removed S32_LE from the CODEC to test if it works and it
> seems it does work with acp-is2-sp. Format S16_LE is chosen by
> both components and sound can be heard. I guess this patch is
> not really needed.

If the device supports it it's a good change, it was just the bit about
it being a fix that I was querying.

--IUEZvB6woga6BL6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTp4OYACgkQJNaLcl1U
h9Ah3Af8CtxEAOV0PQfZ8TfnRojuQe8q+J5avd9VjbolE481OMphKYrHdYzIN2aj
cko3Q0fCBxxdBoy85SDCbyMvj3w6SBEm5pIZUBi3kc820kaQAlqCZjmygGwg0TSv
guCbcmiCMxvnh53p30VwdbEVTjOlhrbvzsT9v++lXSze4kAbmNdwI+Tj1/avteCT
xoXfoCuHFD/bQP2mJ2gPeRM8Iysr6Hl5ROjAqrCtxoHB8uHcPEmWwR7lKD9NqStH
lVsbiQwaKrE4RJvPgYyiwz5bk/Y+pDIfM4fhrDXZzFqUNIfGszwQBU3HVykNYTnz
ywdSsljt7KzCG4VswVWUl7jDnFUgrg==
=x02n
-----END PGP SIGNATURE-----

--IUEZvB6woga6BL6m--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F7D78C232
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjH2KSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjH2KS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:18:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C6491
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7C9A6449B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733C5C433C9;
        Tue, 29 Aug 2023 10:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693304304;
        bh=3U//VkyeA7gvf9F/4eNSaraGKYNwzJlaVqPQO9Pzkws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NqDFvlrDqaKOxENjrz7fM8vJkS1gd3nNowAZcS03ANSA3zQo0u2NhY6xdlVG5Vpux
         K8WdDEcZuaCjCVflNU9kkVDR+4IbFBIMNQC4pVCRoou/vm/KH16WNQkUroxfpIIevN
         Z+5tW+Pqu7UjSXYA+LVRAtlFhgCPpREq1sisXFrOhowDR3+/HkXVIVoG1+IKDU32B5
         mIQjgI3f0v/k4UxjrkwPSxusivRMZ0dQ+X5IkvXlnOGGAluXxL5O2b0NpTaSxrUfoJ
         ElCu4+76l17/rQYeBPcY2fPfmze/wx/NIJdbuyt0TcxRSJiaa0pvP2hrZV09z/f2Y2
         uolhqq5tsda3g==
Date:   Tue, 29 Aug 2023 11:18:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: es8316: Enable support for MCLK div by 2
Message-ID: <ZO3F60iHQzxfjyTT@finisterre.sirena.org.uk>
References: <20230824210135.19303-1-posteuca@mutex.one>
 <20230824210135.19303-3-posteuca@mutex.one>
 <ZOfRXjuSTxSV89SC@finisterre.sirena.org.uk>
 <87msyc9mtm.fsf@mutex.one>
 <ZOzi9BuTo2oXcKta@finisterre.sirena.org.uk>
 <87zg2ax6h4.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dW7tNzymBfs/to0u"
Content-Disposition: inline
In-Reply-To: <87zg2ax6h4.fsf@mutex.one>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dW7tNzymBfs/to0u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 28, 2023 at 11:22:15PM +0300, Marian Postevca wrote:
> Mark Brown <broonie@kernel.org> writes:

> > In general a MCLK that allows you to configure the dividers in the CODEC
> > appropriately for use.  So long as it works your change looks fine I
> > think modulo.

> Sorry, maybe this question is dumb, but I am not familiar with this
> expression. What do you mean by "your change looks fine I think modulo"?

"modulo" means "apart from".

> > Use ARRAY_SIZE()

> Do you mean instead of all instances of NR_SUPPORTED_MCLK_LRCK_RATIOS?
> If so, it's already defined as:
> #define NR_SUPPORTED_MCLK_LRCK_RATIOS ARRAY_SIZE(supported_mclk_lrck_ratios)

Yes, that's what I meant - it might be as well to just drop the define
then since it's prompting this question at use sites?  One of the goals
of ARRAY_SIZE() is to avoid having such defines and keep them in sync.

--dW7tNzymBfs/to0u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTtxeoACgkQJNaLcl1U
h9DBywf/Ztb7aqk240fVfAbyhar0LXYY9S3yQivzajAIk2FdRW3pNGnEByYYE7Wk
ZDWeG9DFBxyW1OJDnwii9gHWJzarqhBMtRodJXHy9urDQ7lmGza+QWehfD2WULZG
CiM/qfKf042oSFW0b6lr59xCkeT9juIhNKoc7kchyOyaXCC0veBbiVGooeKVmCQK
/JSI5iuZvCyMi5TumBydKnqKRcD2nhH1+RqaFJU+//EGnzDWllEGHEBg44jNyVuw
HFGXaYIt13z7tlp6wseAIKE1Nig4Hj77BpaGyF7mBPqMDd9RHAZxHMWCxu+X42vS
c2jqS5LU7ermkk7bJD3UvxBzBHOufw==
=lADU
-----END PGP SIGNATURE-----

--dW7tNzymBfs/to0u--

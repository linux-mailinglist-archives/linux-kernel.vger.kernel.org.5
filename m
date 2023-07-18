Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2385757EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjGRN5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjGRN5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:57:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDB9E8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE01A61588
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284DBC433C8;
        Tue, 18 Jul 2023 13:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689688611;
        bh=uRHw17lISI/6O8PQLrRIjO5Ns0f9TFT46g0OIHNJn5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QXu6w19BXMzXrPbTHzzzZQWQ1I64YgFfFBKIYgGRHIs/22Ig0EHDPNyGhMjHVj1Nl
         jW3yogs727B501ou3r1RDL7vlsJBWnIjhekmxvDmuC9Z3Xy4XJQvFwL5iTS/C5zZS/
         3g7nc8VcEe+UIv4P0W4Qqi5Y9W7TBdnCgAb+khOHMfLCWUNAcYytgVOj+nTL5N4NGQ
         W9TwfJLGX4m6oXzOhiRI/gltlWuTirmNI2YrowM37OQb/ORA32xszyco/PnbhvLeH0
         ZxZcyqEQy7momdspSHxp5AA56BeqU14dcVjNktdQNHea4c1c/UvS46oNfdSElFSD4V
         o1uyEQvGPOPDw==
Date:   Tue, 18 Jul 2023 14:56:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] regmap: Add interface for checking if a register is
 cached
Message-ID: <f6f53056-8526-4a6f-bbb9-add5a77379e6@sirena.org.uk>
References: <20230717-regmap-cache-check-v1-0-73ef688afae3@kernel.org>
 <871qh5py9p.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/sGpDUSgYUUieymK"
Content-Disposition: inline
In-Reply-To: <871qh5py9p.wl-tiwai@suse.de>
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


--/sGpDUSgYUUieymK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2023 at 07:46:42AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Mark Brown (3):
> >       regmap: Let users check if a register is cached
> >       regmap: Provide test for regcache_reg_present()
> >       ALSA: hda: Use regcache_reg_cached() rather than open coding

> Reviewed-by: Takashi Iwai <tiwai@suse.de>

> I suppose you'll take those from regmap.git?

Sure, it's probably easiest (and there's some annoying overlap with some
other work in there that'd make for conflicts otherwise).

--/sGpDUSgYUUieymK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS2mh4ACgkQJNaLcl1U
h9DtDgf+LEObVoThsA+VoBUvewEIj0VwHQii7Md+S9p1tzhEnOPMyNsQeP7fJKId
9yegXZh9Ky49/XcLaXdJDExPVXq2+JwemK4be7NBJ/XLfWpIhZrm5pg7J00jGptG
bDNm4Li8QzWmkEhX9LrvQB2W6RlXZ4V3af1bk/MEdzyaTEmHEEQZtCFQAjHKNeVN
wDCFSJvuCbB3zSlHVJbDjZsKfLU1dGRTPuA/o1u1bnZKK3tdMdP8TaV4kGSZQnyS
AiVGSMDoANyX79ed9QRPYPLCvW7AbSB+xuoi0qf++aNC0+FzDDnksEp1yHAdeWZq
ekWW+P2GoCtWdnLjcCeWB/NoZED12A==
=QtRN
-----END PGP SIGNATURE-----

--/sGpDUSgYUUieymK--

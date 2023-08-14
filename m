Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023E377B99C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjHNNTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjHNNS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:18:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D19E77
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F2EB6252D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17D8C433C8;
        Mon, 14 Aug 2023 13:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692019127;
        bh=lBqbTPCIMvZDXHrHAaZXck9FK5r0lL0nXE1rupaTgIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKnQYGWGGEUtyYQ2lP6MwQHbZCPqpe+fFSJExmHITCo++2h3V7IuFQjS40xFTOg+u
         DIL/Pkm4Q0qPWWhrHUIA7nbd8Q7YCibqko63S/EV6VK/K996A90FLCwEt9UAAYFljo
         wPkDkGTyZ9sCtNuXRyzprQdQvEaIhCezN8AGw3TPPuw/7wviOB5Lm6ZlBo0TsIgf1T
         sk2vKyjXLMjgIBHAwp/MMSo1GHDtyXj8bVouAEoT28ti9jykrg7kt1sbjitkOEWKae
         FXtJZqbzBm6tEebxx9V0Mq+fYS+FOy+lEc8jHauSNTMFmWkXEooRwyvDkCguauwUxL
         iMLg5/4Sjbgew==
Date:   Mon, 14 Aug 2023 14:18:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 21/25] ASoC: dmaengine: Convert to generic PCM copy ops
Message-ID: <56372322-460e-4331-af61-5951ce3f5013@sirena.org.uk>
References: <20230814115523.15279-1-tiwai@suse.de>
 <20230814115523.15279-22-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c7cW3ix30VSoX30X"
Content-Disposition: inline
In-Reply-To: <20230814115523.15279-22-tiwai@suse.de>
X-Cookie: FACILITY REJECTED 100044200000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c7cW3ix30VSoX30X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 01:55:19PM +0200, Takashi Iwai wrote:
> This patch converts the ASoC dmaenging driver code to use the new
> unified PCM copy callback.  It's a straightforward conversion from
> *_user() to *_iter() variants.
>=20
> The process callback is still using the direct pointer as of now, but
> it'll be converted in the next patch.

Reviewed-by: Mark Brown <broonie@kernel.org>

--c7cW3ix30VSoX30X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTaKbIACgkQJNaLcl1U
h9Cwbgf/Wcw9gGth/K9AprMY6o1jF8W9iYzkvvOfeN3GRvbP7cah8wLBAIa92Tkt
zBMV+EoKUs6GgZpwxwbOylX3rgxWMZtxepkFhJ3Tv/oVlXDmuNn7xHz0H/e8upPf
52X/s+rK/Nd5DplzpjnGIsKOUTfxgCKkFbQNHT7SkY7JDkABo453fMTofBPYhmPU
czs42jcgilGlDG37CK0bBlpN2gzU5Ad2BVDk4OXJxSevgVtd9VqkqcZ76oOSDcAf
aNXregRjk/kPIgfY0vYmBQYerWo8zuyYi63c+sfkQ+R5ZjVRMsfFUlH+28JZaS5z
tsWSGSfuOCQn81kRhHoSEdhsGc/mcA==
=DXqV
-----END PGP SIGNATURE-----

--c7cW3ix30VSoX30X--

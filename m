Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F80D76CC4D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjHBMJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjHBMJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F69D1BF9;
        Wed,  2 Aug 2023 05:09:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA24761940;
        Wed,  2 Aug 2023 12:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BCDC433C8;
        Wed,  2 Aug 2023 12:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690978163;
        bh=M5e9aIt4zB+xazIlQzHD++KNXR0lBSq5lPpPZBlFnnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0nVo96YwWrmpCF4FJWiUwGfROiwCepHz2+sCu2OSN3CVI7R58tLGqYicwk4YYKOg
         +NyLJzHU9dFDb2Ho6UPuP2IEP/c/D0cJo7dHvPkGv/B50Ta5mZBFLUrrx0aC9/XNWi
         +t/sdjYvpddoKhGi/JXjdc+frbE7nFrY66eu014qVGygZQPEEgKavljf8ltRC6P5Nq
         Xl3zKTbG64yhtVO+lK7S6RXM3ey01oWUYp+6GBs47b5d74fGfCwBb2ahJbqV9qozKI
         DnSeTdBh7Y9dCBVGiTCZq9YuojTjQKdr2+orJcAcMbvj7a7mpqrt05719eGZTT2qOk
         sgy/jEHSfCbYA==
Date:   Wed, 2 Aug 2023 13:09:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Hans Verkuil <hverkuil@xs4all.nl>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 0/7] Add audio support in v4l2 framework
Message-ID: <b7120871-325c-4db0-a785-854b51ab680f@sirena.org.uk>
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
 <47d66c28-1eb2-07f5-d6f9-779d675aefe8@xs4all.nl>
 <87il9xu1ro.wl-tiwai@suse.de>
 <CAA+D8ANmBKMp_L2GS=Lp-saMQKja6L4E6No3yP-e=a5YQBD_jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s7JwRvdQJYqkq6dD"
Content-Disposition: inline
In-Reply-To: <CAA+D8ANmBKMp_L2GS=Lp-saMQKja6L4E6No3yP-e=a5YQBD_jQ@mail.gmail.com>
X-Cookie: Humpty Dumpty was pushed.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s7JwRvdQJYqkq6dD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 08:02:29PM +0800, Shengjiu Wang wrote:
> On Wed, Aug 2, 2023 at 7:22=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:

> > Well, I personally don't mind to have some audio capability in v4l2
> > layer.  But, the only uncertain thing for now is whether this is a
> > must-have or not.

> Thanks,  I am also not sure about this.  I am also confused that why
> there is no m2m implementation for audio in the kernel.  Audio also
> has similar decoder encoder post-processing as video.

This is the thing where we've been trying to persuade people to work on
replacing DPCM with full componentisation for about a decade now but
nobody's had time other than Morimoto-san who's been chipping away at
making everything component based for a good chunk of that time.  One
trick is that we don't just want this to work for things that are memory
to memory, we also want things where there's a direct interconnect that
bypasses memory for off-SoC case.

> The reason why I select to extend v4l2 for such audio usage is that v4l2
> looks best for this audio m2m implementation.  v4l2 is designed for m2m
> usage.  if we need implement another 'route',  I don't think it can do be=
tter
> that v4l2.

> I appreciate that someone can share his ideas or doable solutions.
> And please don't ignore my request, ignore my patch.

There's a bunch of presentations Lars-Peter did at ELC some considerable
time ago about this.

--s7JwRvdQJYqkq6dD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTKR2sACgkQJNaLcl1U
h9DDTwf/Xps9jJnts1SAD46EJPtve2N9sezS1xZvZgz0pluqjz+vDEyh+ediLcCy
uoiOc/xZz8Odde64unpb8nKuJzfH8hwdn4JFEMc9capaRijhM9iYxSNlDK6p0wil
AX82WXjRdrxyPbNJQgqYehJTbcydxIbewfCqG0ryrG+NeiAPZwR/p1IrCVzBrCZ5
E5+J4oQCAB7li51EuyZuihiImeoDS8LMbPJ5ciHXbhnXyIZaw8AvxTEz9d9llUl8
36hbfxrM24rlJDE16kRco/zHvMkK38W6fubovlGudON8xDoUBFZIPP3SWa5TRy7n
j3xcxiC0N3R2xWsDWKC3p7rK6OoiYQ==
=0Tfg
-----END PGP SIGNATURE-----

--s7JwRvdQJYqkq6dD--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DC9787938
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243451AbjHXUWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243441AbjHXUV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:21:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA652E4B;
        Thu, 24 Aug 2023 13:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48C1261A22;
        Thu, 24 Aug 2023 20:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EE0C433C7;
        Thu, 24 Aug 2023 20:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692908516;
        bh=YJDiLf7SIAYAcv6KOZ8S5EOtjL/tycxNqrjzvwUkBLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r9SeRORWWmfQ8HUQWIKLMSUkafMFWPdWPLpV/BxcoAeeW0LFBycl387Cq9em66P2k
         TZU7kMjyjqVcAu3aoIOD9Yoe0paC8A/0CAwfo73QGHqMnIBkyJPoDlHaKpYEFSYfJy
         XtEDtgB3aGkZz7OmxpiMjqKvJkx72Zjtju3bKdpU6TjgAE9UFGbbFH6FRWTwqBv1zF
         tLXLDS9FhNwgibPpvEVEOt0z4Yod+rbsZLZogBmCiY1JHlEHLK3k49dm9C5ks+Gx0d
         CXG5bAPrxm7SHbaEiO0vo1bHAEEndZ+TgOzeOUC/j3+/AhsnSisgFxz9UPoasphB+p
         WZYubhTz4sL4g==
Date:   Thu, 24 Aug 2023 21:21:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 0/7] Add audio support in v4l2 framework
Message-ID: <ZOe74PO4S6bj/QlV@finisterre.sirena.org.uk>
References: <47d66c28-1eb2-07f5-d6f9-779d675aefe8@xs4all.nl>
 <87il9xu1ro.wl-tiwai@suse.de>
 <CAA+D8ANmBKMp_L2GS=Lp-saMQKja6L4E6No3yP-e=a5YQBD_jQ@mail.gmail.com>
 <87il9xoddo.wl-tiwai@suse.de>
 <CAA+D8AOVEpGxO0YNeS1p+Ym86k6VP-CNQB3JmbeT7mPKg0R99A@mail.gmail.com>
 <844ef9b6-d5e2-46a9-b7a5-7ee86a2e449c@sirena.org.uk>
 <CAA+D8AOnsx+7t3MrWm42waxtetL07nbKURLsh1hBx39LUDm+Zg@mail.gmail.com>
 <CAA+D8AMriHO60SD2OqQSDMmi7wm=0MkoW6faR5nyve-j2Q5AEQ@mail.gmail.com>
 <CAA+D8AN34-NVrgksRAG014PuHGUssTm0p-KR-HYGe+Pt8Yejxg@mail.gmail.com>
 <87wmxk8jaq.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/BnEt2eUNzpLYbS0"
Content-Disposition: inline
In-Reply-To: <87wmxk8jaq.wl-tiwai@suse.de>
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


--/BnEt2eUNzpLYbS0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 24, 2023 at 07:03:09PM +0200, Takashi Iwai wrote:
> Shengjiu Wang wrote:

> > But there are several issues:
> > 1. Need to create sound cards.  ASRC module support multi instances, then
> > need to create multi sound cards for each instance.

> Hm, why can't it be multiple PCM instances instead?

I'm having a hard time following this one too.

> > 2. The ASRC is an entirety but with DPCM we need to separate input port and
> > output port to playback substream and capture stream. Synchronous between
> > playback substream and capture substream is a problem.
> > How to start them and stop them at the same time.

> This could be done by enforcing the full duplex and linking the both
> PCM streams, I suppose.

> > So shall we make the decision that we can go to the V4L2 solution?

> Honestly speaking, I don't mind much whether it's implemented in V2L4
> or not -- at least for the kernel part, we can reorganize / refactor
> things internally.  But, the biggest remaining question to me is
> whether this user-space interface is the most suitable one.  Is it
> well defined, usable and maintained for the audio applications?  Or
> is it meant to be a stop-gap for a specific use case?

I'm having a really hard time summoning much enthusiasm for using v4l
here, it feels like this is heading down the same bodge route as DPCM
but directly as ABI so even harder to fix properly.  That said all the
ALSA APIs are really intended to be used in real time and this sounds
like a non real time application?  I don't fully understand what the
actual use case is here.

--/BnEt2eUNzpLYbS0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTnu98ACgkQJNaLcl1U
h9AiVAf/b+KGLAwaZTE1ChwGc7v9hZvC/6XoaboPi8G5bV7pkxq1t7uSRP1zcuKO
lu8Y4qhUvA7y6fzr1QIeLn52ZLDft1tbtdCYmor553INNaI70qWg3gi7s2USDJQk
26UA7CZIWwNCR3PtX++ca/+2CCViYvNQYwGst/Pn79r2X+4oHFhtc32oRW9YKb/d
0AJynBHdPSLhz85BOJYAhz7DfuwOauNoA0QF47YJeDG1DjQ0iK2QXobHwRry64Wu
O7zyZEBtGuMl7sBgXquUxy7n5Ph/OWsNFO9TKkaqCIg+ucx15Hxu5bL6CJwwQ2ng
i0UC+1Pk7lgN8DzYJoeQ3VlpTdjEaA==
=VcrU
-----END PGP SIGNATURE-----

--/BnEt2eUNzpLYbS0--

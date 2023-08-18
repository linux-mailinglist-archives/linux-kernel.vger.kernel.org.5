Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BA7780C27
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376982AbjHRMwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376979AbjHRMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:52:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC2C1988
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:52:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1C8263315
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8CCC433C8;
        Fri, 18 Aug 2023 12:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692363155;
        bh=7YqFcWNg2Fv2nlDyEHSlWqWCIq2Qdgqd6/JGbDJA9Vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXMcnrYzP2vHwKmZfTTGN057SXLQsJMx7wODXLJ0rveDFZN/vQFOL8N27p16BjzIe
         NDQyO/MiZ043Umd71q3NTHS5Iy/p1xvel5R/+zRToohjhPE6mplNSw4zICCCzRO5Tx
         eymUvIzwDz1/U7r/qXUXTq7ywNhfABmzUPQMjTC+JBBTzpefC34wrLoYeSSWzQYPKE
         OHv/b7R/M2xaj5MgqFZcW/T44aOHUjNKDoYV/AvyoUIbJ3FQq8ZuJA+HL2KgJjA0wH
         45m7g9rsYyUHYRB6NziZga9ENrghnZdMnBuNarTrElxxcvLtDFLRNrmD3j96OlIykP
         er7I8XeJaAPpw==
Date:   Fri, 18 Aug 2023 13:52:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     =?utf-8?B?5rKI5LiA6LaF?= <zhuning0077@gmail.com>,
        yangxiaohua <yangxiaohua@everest-semi.com>,
        Zhu Ning <zhuning@everest-semi.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables
 sound for systems with a ES8336 codec
Message-ID: <8cddbe1c-20d7-4b8f-ba02-f86bbb5a54c5@sirena.org.uk>
References: <141a3320-ff65-459f-9d00-c8bed691dcfc@sirena.org.uk>
 <87lejpwxzf.fsf@mutex.one>
 <ZBr9rJn50ovG1w9W@sirena.org.uk>
 <87ttycjyw3.fsf@mutex.one>
 <ZBty1CdPaWm0IcRi@sirena.org.uk>
 <87r0t9uc08.fsf@mutex.one>
 <ZCRCqJ7oG6oefo9g@sirena.org.uk>
 <87zg2pxtog.fsf@mutex.one>
 <d2be9183-87fd-4cc4-a239-9401b5b88364@sirena.org.uk>
 <87o7j5b9bd.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z+806srFnaL0BPyl"
Content-Disposition: inline
In-Reply-To: <87o7j5b9bd.fsf@mutex.one>
X-Cookie: Your aim is high and to the right.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z+806srFnaL0BPyl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 18, 2023 at 01:20:06AM +0300, Marian Postevca wrote:
> Mark Brown <broonie@kernel.org> writes:

> > This is saying that the machine driver should disable jack detection
> > over suspend and restart it during resume.  The machine driver should
> > suspend before the rest of the card which should mean that the CODEC
> > gets powered off then.  The core can't tell if jack detection is
> > supposed to work over suspend, it is a standard wake event on systems
> > like phones, but it sounds like on this system the power gets removed
> > from the device so that can't work.

> Sorry, I don't understand what you are trying to say here. My intention
> is to find a way to have sound working when suspending/resuming
> with jack inserted by not fudging the jack in the machine driver but
> fixing it in the CODEC.

You'd need to pull the relevant supplies out of DAPM and handle them in
the CODEC suspend/resume callback.

> > I don't understand why that would be expected to help?  The main effect
> > of keeping the bias on all the time would be to consume more power.

> I don't fully understand the whole bias thing (I did try hard to
> understand it from the code), but in this specific instance it helps for
> suspending the CODEC. If idle_bias_on is true then idle_bias_off will be

Very old devices required keeping a reference voltage maintained at half
the analog supply voltage, this supply is called the bias.  It couldn't
be powered on/off quickly so needed to be kept on all the time.  I can't
tell which driver you're using here so I can't tell if it's maintaining
any system level power like that.

--Z+806srFnaL0BPyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTfaYwACgkQJNaLcl1U
h9B/DQf/WTaBHBmfKP02yjMkT4VeN9hLq+f9r25ur3Z5EvIKGj0IYpOL5QASU6pw
tmCkN81RBknpWyYWUyDe3TGcKitz5hREeGdfu/NrNwDwS7Z++zCpGZko6De+t49S
sEqvf51OT2Uh8sU0lp/MPkF1cQFnNY9gF1ofRwKRlqXlBih+kmCRZl6rOxXFQ6FK
nwal2kpnkyoX9uoyMF7LqwJZVNXf6DH1fZZBkTHBbYPcbqRUqtjf2tKjlF56wybU
/LmzqyKobRoQ/c6xL3E0iEh98FPnXKsmbxQ8IKOzsvgsq0kGm3GIFQchCMwUEErl
+Q3r8dVJ1KIQkvl1dQbeo62LbcwRbw==
=atF3
-----END PGP SIGNATURE-----

--Z+806srFnaL0BPyl--

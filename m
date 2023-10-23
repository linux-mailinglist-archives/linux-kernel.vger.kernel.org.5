Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11DB7D37A9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjJWNUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjJWNUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:20:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F74AF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:20:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45953C433C8;
        Mon, 23 Oct 2023 13:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698067218;
        bh=h+Jyfyknx4YJBVNzv+TnNizm+sIT9p+Md9k3LAUuzY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPuok6o583VpS6tG5KDC0yJx8vj9gJ6gSlA3QqnTYYk+/GMdmuI3fW3dMwKr3hkYj
         Ymlna77W8ac4A+gIt6W60moB2l91ABkHr00MYLUvyvObUY1TdfDj23XhDSdkxI28UW
         A90TlKGwdEn5OguW60M5u2F/GgsSEytJhDJJSx/mrHGSd6B7w86uvlB6L6tjlAJ/OZ
         aTKsNTE7tT2/rplgklmJTXethWP4VJdJoCRNlh51NWPn3J4MqWvpd4w29w7HkSVqCO
         ZrYOaxB6asux5BtI/E9LzlXDDYwmvRu6dnxUpBfV/HeTVs8xHfqWf+F89Li1ZSEoot
         6ZC5WhXoWPjCQ==
Date:   Mon, 23 Oct 2023 14:20:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: Add Linux specific waitpid() flags
Message-ID: <fc236f5a-8763-417f-8e9b-57da15d5dea3@sirena.org.uk>
References: <20231020-nolibc-waitpid-flags-v1-1-8137072dae14@kernel.org>
 <633402b0-7167-465f-99c6-d959b5f48073@t-8ch.de>
 <ZTOWQnFwrQufHUyw@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8/zfyLwjdpXmZrxg"
Content-Disposition: inline
In-Reply-To: <ZTOWQnFwrQufHUyw@1wt.eu>
X-Cookie: Never reveal your best argument.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8/zfyLwjdpXmZrxg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 21, 2023 at 11:13:38AM +0200, Willy Tarreau wrote:
> On Sat, Oct 21, 2023 at 11:00:20AM +0200, Thomas Wei=DFschuh  wrote:
> > Oct 20, 2023 23:57:01 Mark Brown <broonie@kernel.org>:

> > > Linux defines a few custom flags for waitpid(), make them available to
> > > nolibc based programs.

> > Wouldn't it be easier to include linux/wait.h instead?

> That's indeed the trend we should follow whenever possible. We've got
> caught a few times in the past with build errors depending on the
> includes ordering due to such redefinitions. I don't know if that's the
> case for these ones (nor if including linux/wait.h would cause other
> breakage) but it's worth considering at least.

> The difficulty here is that originally nolibc did not *explicitly* depend
> on UAPI headers, and was supposed to be self-sufficient (that was the
> main point). Adapting to multiple archs caused the addition of ifdefs
> all around, then trying to standardize the include file names instead
> of just "nolibc.h" caused conflicts with programs already including
> linux/anything.h. Anyway now we depend on linux/lots-of-stuff so I
> think it's worth continuing in that direction so that we don't replicate
> the UAPI maintenance effort.

OK, I'll do that - I'd not noticed that nolibc had started pulling in
linux/ headers so was trying to maintain the deliberate duplication.

--8/zfyLwjdpXmZrxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU2cw0ACgkQJNaLcl1U
h9DgEgf+Mj/4MWqwmRLWrbshIma/gJxD2aDCgbB6u/Z3r4WtORWBGpCLHu2HwuUw
1l9FvVIosz/dvUMEYsyCdsRieKYD+G4y7d7mrMOsDy89btenS2ZCISpdeI/UNXun
m1xZyscHvpryRBMg6T89Eu+woMqPly3flZ1N0yPc/fD2xmdnN27WDjveN8VPgY9W
p/ZVQdpnmUvHKIZ7buns17GsXXk27j4rcLbFExCQyz4sOJn1uyT3Wtvq/kiu+EPe
SKkk5NaEn+o6QLUtKyw9t162v5BEjNj47vtXFRcEsVFp6cqEE5guBbsqcE1jbuJB
9qgUjQC6m/o4KdMvtJJz0Qwh4QykPQ==
=W+4M
-----END PGP SIGNATURE-----

--8/zfyLwjdpXmZrxg--

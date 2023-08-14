Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFA977BFC8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjHNS1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHNS1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:27:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56B1B0;
        Mon, 14 Aug 2023 11:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 582D761638;
        Mon, 14 Aug 2023 18:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD77C433C8;
        Mon, 14 Aug 2023 18:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692037631;
        bh=Jt+rPoxzrJg9otv2KBpZZWoKH+f7W2Q1+lOzA6Mb1aA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlJXVyAl0W/HMNVYbzEFCdoL6HgJHwvT+o2L9MjPoUr16NPDivrDz7W2AnPX7ou6k
         wVWno9oPsIZFysGiyUT+bsdck7XTwqS/6GZvULxmyusnX2Ja0punbcMs23H7NYeTO+
         Q3oo5E8RG53i1d754Y3CLnI02XJ4cgbtgX34QSRfSCuaP/RWcrPl6hT5WaVXUVkQMB
         JgEPFp1CDsvkMbKOhb9Ou890I6WlNwCoqwVGG36BCDluMwrWtx5gJ/QYqFijRzhXA1
         wO6xmZK+PKheKs1Zj/xFtBaNRrDG/xDm9HU80DATPK7RefXq3KkurwODDknWHjONg5
         GSE1LPCYHg09g==
Date:   Mon, 14 Aug 2023 19:27:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Watts <contact@jookia.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ASoC: dt-bindings: wlf,wm8782: Add max-rate property
Message-ID: <a7db4653-cb12-4f90-891c-5cf7270598bd@sirena.org.uk>
References: <20230810224930.3216717-1-contact@jookia.org>
 <20230810224930.3216717-4-contact@jookia.org>
 <ZNY+x/R8/T5ysPhy@finisterre.sirena.org.uk>
 <ZNZFB2-kBrpnMSn1@titan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/aJxk8MMdf/9RpDh"
Content-Disposition: inline
In-Reply-To: <ZNZFB2-kBrpnMSn1@titan>
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


--/aJxk8MMdf/9RpDh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 12, 2023 at 12:26:15AM +1000, John Watts wrote:
> On Fri, Aug 11, 2023 at 02:59:35PM +0100, Mark Brown wrote:
> > On Fri, Aug 11, 2023 at 08:49:30AM +1000, John Watts wrote:

> > > + - max-rate    : max supported audio rate configured by FSAMPEN pin, defaults to 48000

> > This seems like a cumbersome and error prone way to configure this - why
> > not just have the binding specify the state of the pin?  That's just a
> > boolean high/low whereas this requires getting the rate right and then
> > having the driver validate it.

> Hi there, the pin is tristate, Z, 0 and 1. How would that be represented?

You'd have to define an enum for that but it does still feel like it
might be easier to work with since it's more direct.

--/aJxk8MMdf/9RpDh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTacfcACgkQJNaLcl1U
h9BXKwgAgSwKyeLPqTWs0T7jIJ1qzjNVtHtx9g/zqFqy1CMWB3obyrIoAkqQ1sZ2
U4O+KbXHmiwtcMnIiw/pgob0Of909XoX+sod5z8Vo/gDwF9rpKcxf30q07vr38Zg
4X0Y+BMPgQ8t6pXYw/7f6jzqdWr9NS/RiiTeBnhTg0rCJ69/0SOKhetiEBbYuOH/
VHx/VGQPuwkgczW6p72rzZp/92OUqbWufopBLgRZjCzvEl96EsoYImaeYqfKc+9r
Ww34k3led/5NINa7WcDiWjG2DJLsUZA8Jc9Wu3fL/hZGZrhvFx5OZmfCT3/V6DQd
Grc4VfsPpVjKok9G6ZXUHvaW7lFuhg==
=Us4P
-----END PGP SIGNATURE-----

--/aJxk8MMdf/9RpDh--

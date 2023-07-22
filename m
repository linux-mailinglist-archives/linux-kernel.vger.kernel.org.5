Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA0E75DD7D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjGVQqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 12:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGVQqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 12:46:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419C5E73;
        Sat, 22 Jul 2023 09:46:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA3C660B9F;
        Sat, 22 Jul 2023 16:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81091C433C7;
        Sat, 22 Jul 2023 16:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690044409;
        bh=FUcJ5kyCBceu8cNLWIvq9oyoWX1mBM/NTa8B3HLsfeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hq9BFN+Qb8kL3PirNWumZYTFEez3EDB0Dy4bM/dvbTvUhL7MSsTBV0Zq1OHrHqzZi
         fsUAhXykmE171UPRY0tmDtOhJ3ESTAZNYnEzdA7R4uhJxBCA8B8gihyx2uxgNH1XBd
         FXVedcdFt9PjZVqbggvh0wgscpS0K3c2345OF7CXXZ5dpK8AsXMWSMo6XR929DmNto
         OeDFDNbRrXw4giBuI24t7VQBOeOlCwqjbZKxKlsZljcnHkVm4lynj7aNLq16ZCoJM4
         ohYxvMbVHnyjcwcHa6imFWUEQNPWj4KTKFB4J/U91V3fqLf+nrZU064jO07z+b5Xcb
         KLhR80it9bWpg==
Date:   Sat, 22 Jul 2023 17:46:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hugh Dickins <hughd@google.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/sun8i: Don't fail probe due to zone
 registration failure
Message-ID: <ZLwH9RFnJymdy7YD@finisterre.sirena.org.uk>
References: <20230718-thermal-sun8i-registration-v1-1-c95b1b070340@kernel.org>
 <5a9ccb708f004e70e2102417eb48b766b03777cd.camel@icenowy.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pJ7zt3hWz8YVEKZz"
Content-Disposition: inline
In-Reply-To: <5a9ccb708f004e70e2102417eb48b766b03777cd.camel@icenowy.me>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pJ7zt3hWz8YVEKZz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 22, 2023 at 08:11:43PM +0800, Icenowy Zheng wrote:
> =E5=9C=A8 2023-07-18=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 16:04 +0100=EF=
=BC=8CMark Brown=E5=86=99=E9=81=93=EF=BC=9A

> > Since we currently do not define any trip points for the GPU thermal
> > zones on at least A64 or H5 this means that we have no thermal
> > support
> > on these platforms:

> > [=C2=A0=C2=A0=C2=A0 1.698703] thermal_sys: Failed to find 'trips' node
> > [=C2=A0=C2=A0=C2=A0 1.698707] thermal_sys: Failed to find trip points f=
or thermal-
> > sensor id=3D1

> I think this is an issue in the core thermal subsystem, and sent a
> patch; Unfortunately the patch seems to be rejected by linux-arm-kernel
> (and some other mailing lists)...

It did seem to be a bit of an excessively strict requirement, I was
going to poke at that myself.  It does seem worthwhile doing the change
in the sun8i driver anyway, there might be some other issue that causes
registration to fail which would have the same issue.

> I will then resend it again and put Mark into CC list.

Thanks.

--pJ7zt3hWz8YVEKZz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS8B/UACgkQJNaLcl1U
h9DbHQf/R/NTGVJ5ZHb5w5mBluOwQ43U4PSsTff9jY6HVWrnJNEXSSVFbmfADsWJ
4nPr/Sv5UEHRMt9fvjV2mm96TwXIk6PcRyoOZ2UYSbth6gmaotVUKfZquoKmvaHJ
Yi9UmOdbIz1i6Eil0s7UL/ZwuRShzzhxfQRdfyvTix9vryxtd6xkYDqMStdHqwc5
5SCuPjyK9SvgWG0Rv50qCvS8DOfmOt0wJ22senQ9EWpoQVQzfOz7a/iReEUKBiLe
15QFff1NN5i2mMzTN6jE0qa4+yxb/SP8LlJ1x/bar6pEZP6YLH3rN/TGEkczo4ej
ZXV/HHHOmErXSt+FGKjXTJVb93AmGw==
=W9D9
-----END PGP SIGNATURE-----

--pJ7zt3hWz8YVEKZz--

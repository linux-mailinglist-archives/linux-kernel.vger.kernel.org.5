Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BEF76DB40
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjHBXHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHBXHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:07:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D94B123;
        Wed,  2 Aug 2023 16:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B77EE61B38;
        Wed,  2 Aug 2023 23:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A36C433C8;
        Wed,  2 Aug 2023 23:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691017632;
        bh=sHIKg/nDNw3R4xGSVyhZMISd3sEKpe+1jfL2edNNHgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6pNyZVV7c9ABVfYRda6Jya1y6gTBcFtI4Gs4CndLhCx3ZUj/fmC0MgVcSsruNZUA
         92JnAeXnuHV1eFMr9AD1f2bpBWvCXnU0Zm0Vp4aAcRWkzHp0pddHt6R6vtJ0Uz7nOH
         pUIUDFslkrzFI5PeAKrhU4Vt/xwa89RonPkeVOENLhtPz1ZDe+bX/m8IzPG+PX4ch5
         OTFaKX7NndxImTa7zobq3VEMRZONo/sORnMA6Hzv1oXLOjkGh+lXwie38AjeeKqEdM
         j2/7FXtkr6LWJMweWcArFyizc8l5DsV0b3XejajRAvdJS8LODSmywydaj3Og1dfMLx
         MAzwAL2/w3ONw==
Date:   Thu, 3 Aug 2023 00:07:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "Sahin, Okan" <okan.sahin@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "zzzzTilki, zzzzIbrahim" <Ibrahim.Tilki@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>, linux@leemhuis.info
Subject: Re: [PATCH v3 2/2] regulator: max77857: Add ADI MAX77857/59/MAX77831
 Regulator Support
Message-ID: <ae431bb5-d132-4737-b4bb-58a323f877a6@sirena.org.uk>
References: <20230717050736.10075-1-okan.sahin@analog.com>
 <20230717050736.10075-3-okan.sahin@analog.com>
 <20230718155502.GA3542993@dev-arch.thelio-3990X>
 <20230726161033.GA1102409@dev-arch.thelio-3990X>
 <PH7PR03MB739122A373964651D995EA5AE701A@PH7PR03MB7391.namprd03.prod.outlook.com>
 <20230727145143.GB2013261@dev-arch.thelio-3990X>
 <CAKwvOdnPQEdbTGBO0hBn7CC4d0xtRV2zmfrYDfAhH0stfDYeJA@mail.gmail.com>
 <32af6891-8246-46de-ba1d-ae1999f6eb10@sirena.org.uk>
 <20230802230426.GA3027248@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2LX9drZDxEXVlZBe"
Content-Disposition: inline
In-Reply-To: <20230802230426.GA3027248@dev-arch.thelio-3990X>
X-Cookie: Humpty Dumpty was pushed.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2LX9drZDxEXVlZBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 04:04:26PM -0700, Nathan Chancellor wrote:
> On Thu, Aug 03, 2023 at 12:02:38AM +0100, Mark Brown wrote:
> > On Wed, Aug 02, 2023 at 03:52:52PM -0700, Nick Desaulniers wrote:
> > > Hi Okan,
> > > Have you sent a follow up fix? The build should not remain broken for
> > > so long.  Otherwise I think Broonie should drop your patch.
> >=20
> > Someone sent what's probably a fix but I was waiting for some
> > confirmation that the change actually works on hardware, it's not super
> > obvious.
>=20
> Got a pointer? I don't see anything on lore:
>=20
> https://lore.kernel.org/all/?q=3Ddfn:drivers/regulator/max77857-regulator=
=2Ec

Oh, they didn't actuallly send it to the list :(

--2LX9drZDxEXVlZBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTK4ZkACgkQJNaLcl1U
h9ASwAf9EgOXf2eaprSEmmkAg6E0PBhk53WjSA3+uyZ9WVMDppxj9A5mAbXM7yQU
5BWMxzZeCiawZDUEKj4j1vfy7m9MenZ/HLTSrkCWMl8MNvhpqCwow0cjSk5gLadU
aywjTAYv0MX0yhkBEgHG1zjOchsIRYGt7uqS9KpQWGkPu11SiA7sfEuC8bOd0jDF
laXWu6xKF6xFrYPMuqfjojnE+fOfjdAXxhCMeWHsdlO22CvrL4XZqK+rb+i8Kg1z
3uiXzG0XOR23ObrAaphBnTR1j2aWJxDWxmjR9upNxvtGP5dyZLyFERqN4DfY8Ozt
Xj8LHN5SuNGcbAv6pOaFb5JlXevv6Q==
=gRU5
-----END PGP SIGNATURE-----

--2LX9drZDxEXVlZBe--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08E0773C7D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjHHQGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjHHQFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:05:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49FE30C7;
        Tue,  8 Aug 2023 08:45:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E0F86259F;
        Tue,  8 Aug 2023 14:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D866C433C7;
        Tue,  8 Aug 2023 14:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691504894;
        bh=qMriDtXrpLpfOWzb5+F5aOCYEZhH3+5fP0nhoxADdxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tV/68gEXuyvM/3aR/Qp/99bWWBgEJWNV2ioFTuNK7maHxoA1B+jr4legADPGIpFmC
         TdlpfRfEciPYC863Fr1g9haSn9B6FuQ3YFQQcWcYtAr3XM1PDaDLeJYHG3t47A4Chw
         UePvtRvh7fol4x07yLv8vsqeQn8LoyKEuJWEzMceYnNDdk/UBRmeCnS3r3upT33N7F
         wef4uKoHfk0fO2u7TR874aKZ8TochZneW8BekRHnLwTLS+D9DmohjHcNFHmugnARaT
         Cmqda5nh8N4n+7M0qOsDiPlx8rWolfpIt/xBVePqjkzPi25YffJO9H1VE4N+DFwxnH
         oZQs+tSbh3JXA==
Date:   Tue, 8 Aug 2023 15:28:10 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Add Infineon TDA38640
Message-ID: <20230808-esquire-epidemic-f9bd74ffde25@spud>
References: <20230802193155.2170935-1-Naresh.Solanki@9elements.com>
 <20230808-stand-cheddar-b76b0b7509a0@spud>
 <eced746a-1181-bd8f-6828-4a4eeb79727c@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XfJu5TZS5xk5xqji"
Content-Disposition: inline
In-Reply-To: <eced746a-1181-bd8f-6828-4a4eeb79727c@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XfJu5TZS5xk5xqji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 07:10:08AM -0700, Guenter Roeck wrote:
> On 8/8/23 04:46, Conor Dooley wrote:
> > On Wed, Aug 02, 2023 at 09:31:51PM +0200, Naresh Solanki wrote:
> > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > >=20
> > > The TDA38640 chip has different output control mechanisms depending on
> > > its mode of operation. When the chip is in SVID mode, only
> > > hardware-based output control is supported via ENABLE pin. However, w=
hen
> > > it operates in PMBus mode, software control works perfectly.
> > >=20
> > > To enable software control as a workaround in SVID mode, add the DT
> > > property 'infineon,en-svid-control'. This property will enable the
> > > workaround, which utilizes ENABLE pin polarity flipping for output wh=
en
> > > the chip is in SVID mode.
> >=20
> > Why do you need a custom property for this? How come it is not possible
> > to determine what bus you are on?
> >=20
>=20
> That is not the point. Yes, it can be detected if the control method is
> PMBus or SVID. However, in SVID mode, SVID is supposed to control the
> output, not PMBUs. This is bypassed by controlling the polarity of the
> (physical) output enable signal. We do _not_ want this enabled automatica=
lly
> in SVID mode. Its side effects on random boards using this chip are unkno=
wn.
> Thus, this needs a property which specifically enables this functionality
> for users who _really_ need to use it and (hopefully) know what they are
> doing.

Hmm, reading this it makes a lot more sense why this is a property - I
guess I just struggled to understand the commit message here,
particularly what the benefit of using the workaround is. I'm still
having difficulty parsing the commit & property text though - its
unclear to me when you would need to use it - so I will stay out
of the way & let Rob or Krzysztof handle things.

--XfJu5TZS5xk5xqji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNJQ+gAKCRB4tDGHoIJi
0rsaAP4p4HX4bMrdis5l4TikUX588o40cMUso+iMzqcRc+4sBQEAiZOIdiIzqofV
HE+wZrIM/ImGNTwKIwWUHO0dKzccKg8=
=+V64
-----END PGP SIGNATURE-----

--XfJu5TZS5xk5xqji--

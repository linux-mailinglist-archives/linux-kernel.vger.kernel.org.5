Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475FB7AB0FD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjIVLfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjIVLf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:35:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA1BCFA;
        Fri, 22 Sep 2023 04:35:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F494C433C7;
        Fri, 22 Sep 2023 11:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695382511;
        bh=aNpDnFYDj2j2Hkh8J6UIChSAo3HYbob/MUwFfBA0fyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lh3bOW0FZO7LnVKBGV83pftFw64EJVKA01kN5ZM3Mtr+Vcp3TV8YJcevHLXNkgp37
         49+G7ptnrP0NW5ZEAB6Mb/xcaaiWWN7oJGHyiVzxO5CvaW6yVmPIZKsx24LraXooVq
         +VTxbSmaHKyOdqJZsP4QuSTOoXe/LtMGlGXpfCoME7abBiLGPBAM+B8pUO9m9760qE
         3lOpDD4pt6iNq+Hw2nREAF78Kd7ASYsVEKekCSNNB2QwK4OlCp3fB97l3+Zq7XeoN5
         +ml9q+LhOS8JT7K8fcZiXyKqT+9cm+oZpIOzEpfJwZYi4JNwFosnn6DqbmMlJG3eTI
         etz69+co19rUQ==
Date:   Fri, 22 Sep 2023 12:35:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hvilleneuve@dimonoff.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: sc16is7xx: convert to YAML
Message-ID: <20230922-awning-repayment-e9f4ec55787d@spud>
References: <20230920152015.1376838-1-hugo@hugovil.com>
 <20230920152015.1376838-5-hugo@hugovil.com>
 <20230921-decorated-patronize-45285045adbf@spud>
 <20230921113040.2dafb3d50cfdd8727de42356@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FaLvclHYZD+k9FzY"
Content-Disposition: inline
In-Reply-To: <20230921113040.2dafb3d50cfdd8727de42356@hugovil.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FaLvclHYZD+k9FzY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 11:30:40AM -0400, Hugo Villeneuve wrote:
> On Thu, 21 Sep 2023 14:45:06 +0100
> Conor Dooley <conor@kernel.org> wrote:
> > On Wed, Sep 20, 2023 at 11:20:15AM -0400, Hugo Villeneuve wrote:

> > > +  clocks:
> > > +    maxItems: 1
> > > +    description: Reference to the IC source clock.
> >=20
> > You could probably drop this, if it only has one clock it's a bit
> > redundant.
>=20
> I don't understand, because there is already a 'clocks' property in
> the examples (and also in my real board DTS file) and if I remove it
> here it will cause a warning:
>=20
> serial@51: Unevaluated properties are not allowed ('clocks' was
> unexpected)

Sorry, I was talking about the description.

--FaLvclHYZD+k9FzY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ176gAKCRB4tDGHoIJi
0twcAP9vBpC+1tj/zupf5iw1FA60BwrOpAZP14ulMEaI7vlVhQEAtnM5KniPS4Uh
bn1iiPZW8oKjgRIGM/LkbpHqmkPs9Qc=
=YeHj
-----END PGP SIGNATURE-----

--FaLvclHYZD+k9FzY--

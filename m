Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDB8767F06
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 14:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjG2MKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 08:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjG2MKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 08:10:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410AE3585;
        Sat, 29 Jul 2023 05:10:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC64560BF0;
        Sat, 29 Jul 2023 12:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A3EC433C7;
        Sat, 29 Jul 2023 12:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690632640;
        bh=lwCF7KElYFty5NxALTV6MT8JALJV2OcvBXjgBuXDWXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ulvqug0/BBOJUb7ZfcuUWidItNRj4tqzrNFDD52jDngpw3/sPA/FXXg05VSnMiU1U
         6PNX18KdCNsgx/Sjk6V4ZMQcysndfjR0lGZsu/wJ8M1kpoccoDgJOjnm8O4mJTJjzH
         2i9apV0Na9YdeCXKAftMjFwraed8xN9zbiYEMEMiIyCrXw7gPGOLLykqapHXZHOcPb
         rampwx0Hpf/iNYn1hYNQANjXc5nPQRAz3XV8docY8v8OCbQH6W9ewHb+YHRCB1kyQ4
         bffntfw5gx+B8/wp3bUivXxzCjoxHCOb7zLdimC2QMTSzuVpOO7+Yf5HRytOTqJAAN
         ksHLma1qSXCTQ==
Date:   Sat, 29 Jul 2023 13:10:35 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: power: supply: Add pm8916 VM-BMS
Message-ID: <20230729-splatter-garland-495a414c323e@spud>
References: <20230728-pm8916-bms-lbc-v1-0-56da32467487@trvn.ru>
 <20230728-pm8916-bms-lbc-v1-1-56da32467487@trvn.ru>
 <20230729-facecloth-trembling-3311ca245505@spud>
 <25e933dc3f28fd73a9b76f172dacfdb2@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="F0OGrZuE9c+ZO4wx"
Content-Disposition: inline
In-Reply-To: <25e933dc3f28fd73a9b76f172dacfdb2@trvn.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F0OGrZuE9c+ZO4wx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 29, 2023 at 05:06:14PM +0500, Nikita Travkin wrote:
> Conor Dooley =D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0) 29.07.2023 15:03:
> > On Fri, Jul 28, 2023 at 10:19:30PM +0500, Nikita Travkin wrote:

> >> +  interrupt-names:
> >> +    items:
> >> +      - const: fifo
> >=20
> > Same here, but do you really need a name, when you have only one
> > interrupt?
> >=20
>=20
> Hm, thinking of this more, the hardware actually has more than one
> interrupt, even though this one seems to be the only really useful
> one. Would a better way forward be to list all of them=20

Yes.

> (and fix
> the driver to get the value by it's name)

It's not a fix to do that, the order of the interrupts is not variable,
so there's nothing wrong with using the indices. You can do it if you
like.

> or it would be
> acceptable to leave the names here and extend the list at a later
> date when (if ever) other interrupts are needed?

If you know what they are, please describe them now, even if the driver
does not use them (yet).

Thanks,
Conor.

--F0OGrZuE9c+ZO4wx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMUBuAAKCRB4tDGHoIJi
0os+APwLvrU71X4nG+/xT8BzpQHHNI3fvHxAitbMTQgugugs0wEAk9oqJ7B5HS3M
dtbCtksiAvT6u8n06DFH8N1e3b5sFgo=
=9Wfg
-----END PGP SIGNATURE-----

--F0OGrZuE9c+ZO4wx--

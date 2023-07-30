Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC5F7684BC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 12:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjG3KFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 06:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjG3KFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 06:05:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0477B1987;
        Sun, 30 Jul 2023 03:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85713606A0;
        Sun, 30 Jul 2023 10:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A7DC433C8;
        Sun, 30 Jul 2023 10:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690711516;
        bh=uOCk5v0cyP6RW8hFIA0Q6PFQ6s4G0QrkYFOB5/6POr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LT4eAcY5XhRvLvdH93Bkd5xsfSPDiJfQnzf9cooDdJS2UZrjbmdXzh8IM/nwLTwVf
         Pth60zkM5VDPFPix/oU8BWI5VwSl/vygiOJQ8ErThM8XbW68EPCkIaPRaiA7HM2+cm
         34MXibtCvfsIX8QkZ8MyR3G1v5TiDmIFFEMvTjLDx3rZdNC3QFyKeMfLR5SHR75rjQ
         QU51C+uZNpZOfphoWMfTrsyzfjSmmW0XtgypvYQFqnURcG7u3UA5xHiOdGp45+EmfR
         W0drXq5jQ1u773SJC1orh9Qcy10urhzPN4tMNe1RyrBOBlzoHJUrr5I4WKEtok/1Gz
         wzwsQgU8m/aMA==
Date:   Sun, 30 Jul 2023 11:05:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: power: supply: Add pm8916 VM-BMS
Message-ID: <20230730-clustered-untidy-e943b4a65d71@spud>
References: <20230728-pm8916-bms-lbc-v1-0-56da32467487@trvn.ru>
 <20230728-pm8916-bms-lbc-v1-1-56da32467487@trvn.ru>
 <20230729-facecloth-trembling-3311ca245505@spud>
 <25e933dc3f28fd73a9b76f172dacfdb2@trvn.ru>
 <20230729-splatter-garland-495a414c323e@spud>
 <0b41a93ee82674e65a3801f5a37edd5a@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jEPzFvG+l0KcHHNb"
Content-Disposition: inline
In-Reply-To: <0b41a93ee82674e65a3801f5a37edd5a@trvn.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jEPzFvG+l0KcHHNb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 29, 2023 at 05:15:06PM +0500, Nikita Travkin wrote:
> Conor Dooley =D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0) 29.07.2023 17:10:
> > On Sat, Jul 29, 2023 at 05:06:14PM +0500, Nikita Travkin wrote:
> >> Conor Dooley =D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0) 29.07.2023 15:03:
> >> > On Fri, Jul 28, 2023 at 10:19:30PM +0500, Nikita Travkin wrote:
> >=20
> >> >> +  interrupt-names:
> >> >> +    items:
> >> >> +      - const: fifo
> >> >
> >> > Same here, but do you really need a name, when you have only one
> >> > interrupt?
> >> >
> >>
> >> Hm, thinking of this more, the hardware actually has more than one
> >> interrupt, even though this one seems to be the only really useful
> >> one. Would a better way forward be to list all of them
> >=20
> > Yes.
> >=20
> >> (and fix
> >> the driver to get the value by it's name)
> >=20
> > It's not a fix to do that, the order of the interrupts is not variable,
> > so there's nothing wrong with using the indices. You can do it if you
> > like.
> >=20
> >> or it would be
> >> acceptable to leave the names here and extend the list at a later
> >> date when (if ever) other interrupts are needed?
> >=20
> > If you know what they are, please describe them now, even if the driver
> > does not use them (yet).
> >=20
>=20
> Thanks for the clarification! Will make sure both drivers have all
> interrupts described in v2

Note that bindings describe hardware, not the driver. The driver need
not touch the other interrupts if it does not use them, but make the
hardware description (IOW the dt-binding) accurate & as complete as you
can.

Thanks,
Conor.

--jEPzFvG+l0KcHHNb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMY10wAKCRB4tDGHoIJi
0hbHAP0XUtnKtw/UNbikUvhnQxyenApvfmv5T5vsTNrJ2nJQBAD+N70WAQYlMFim
l0UKWHTL0bMfQZOTyejhQCMs7tlq1AA=
=T3/R
-----END PGP SIGNATURE-----

--jEPzFvG+l0KcHHNb--

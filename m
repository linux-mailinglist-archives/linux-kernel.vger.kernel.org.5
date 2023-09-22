Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222DF7AADBA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjIVJWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVJWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:22:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38C7CE;
        Fri, 22 Sep 2023 02:22:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BA6C433C7;
        Fri, 22 Sep 2023 09:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695374544;
        bh=8S14wwxTEg2QgvNUOFowD4EjDPHWFixEfBczznYYXPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XW6TFhEPXiHmvFQqo3vS7pKtw74KDLpUQb9ktR8RiTIqAAARktOzI8g6Gv9jRjvBh
         WVWdlPoHs0YehBrNpNCVyqOPhU2XPBCDH6mGPmftbCgDaD+UfDnRuUYGbWFqmuWQlH
         5g22/7EaNjy74I9eJx2h4dxH6e97k1Syfcc0rhC+RWsg1Bh6ljN+SJsAsqXvffvx94
         Cs74g0kZBo2sr9GMyx0hVIRsMMfmGjApL7EG6bzg8dCbPc31rqoiqHlUhGH/ugYArH
         iGzbjaXbIhKvYVn46qilNpmpm0qhvGyL4Jz/fu9TsFXBxWlCuuztlZaZ9aYBEu6j9Q
         l/VEAq7XPtC3w==
Date:   Fri, 22 Sep 2023 10:22:19 +0100
From:   Conor Dooley <conor@kernel.org>
To:     yang tylor <tylor_yang@himax.corp-partner.google.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        poyuan_chang@himax.corp-partner.google.com, hbarnor@chromium.org,
        "jingyliang@chromium.org" <jingyliang@chromium.org>
Subject: Re: [PATCH V2 1/2] dt-bindings: input: Introduce Himax HID-over-SPI
 device
Message-ID: <20230922-unclothed-bottom-5531329f9724@spud>
References: <20230919024943.3088916-1-tylor_yang@himax.corp-partner.google.com>
 <20230919024943.3088916-2-tylor_yang@himax.corp-partner.google.com>
 <20230919-70b2f1e368a8face73468dfa@fedora>
 <CAGD2q_anfBP78jck6AbMNtgAggjOgaB3P6dkmq9tONHP45adFA@mail.gmail.com>
 <20230919-cc4646dbfb953bd34e05658c@fedora>
 <CAGD2q_bkTpvXiomWb_yerNjQfMVKOctYgBqF_RBSo_jYqyyyxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v+aqA+5QpEvFBWgw"
Content-Disposition: inline
In-Reply-To: <CAGD2q_bkTpvXiomWb_yerNjQfMVKOctYgBqF_RBSo_jYqyyyxw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v+aqA+5QpEvFBWgw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 03:56:25PM +0800, yang tylor wrote:
> On Tue, Sep 19, 2023 at 7:09=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> > On Tue, Sep 19, 2023 at 05:31:29PM +0800, yang tylor wrote:

> > > The behavior of "himax,boot_time_fw_upgrade" seems not stable and
> > > should be removed. "himax,fw_in_flash", I use the kernel config for
> > > user to select.
> >
> > That seems like a bad idea, we want to be able to build one kernel that
> > works for all hardware at the same time.
> >
> I see, so I should take that back?
> I'll explain more about it.

Are there particular ICs where the firmware would always be in flash and
others where it would never be? Or is this a choice made by the board or
system designer?

Thanks,
Conor.

--v+aqA+5QpEvFBWgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ1cxwAKCRB4tDGHoIJi
0gULAP9LWqFNeG5rHo+qgr/z06EqS5lS7F8Od2gCHSaTlCa5DAEAyyHbiPkKJrXq
oII3i1N9zR8cMUB/j1LYhi1slzzKqg4=
=tovU
-----END PGP SIGNATURE-----

--v+aqA+5QpEvFBWgw--

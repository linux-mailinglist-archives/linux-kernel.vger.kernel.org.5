Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85AB80229B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjLCLDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCLDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:03:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15D19C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:03:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4313C433C7;
        Sun,  3 Dec 2023 11:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701601437;
        bh=RL9hj4/npBVWsIIkeQ9nIijIaQvVjE1SR3pmSj6oEg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kRgOQtlY1EdSeAzCqTTGDvINRhqHIMsl8+LQeFZaNzcd/5G3CZAlbg+SOtS9kuIMv
         68YQgJfICsQHDs9pFWFtFwyUmm3Nae8OnqyIx+HkdZXP8KxoEmQdLJj4BK+wSvgzm5
         uSLa3Dyo+XY6EPvYNR7WSB0ZOWGtBK0d6ZodlAVj9fd1WLXUHVo3BgJs0Qq5Lyq+hY
         csPMxzR7YNBQiYIUf7jDrYeh2m1eGixPIPQDZCI67+UI49nEbxz7CHGj3x8K7dW9Q7
         id7NTjtXqaCvnU005DSuJPlRgnM4plT34q3XmH2A/94r74ekRCYG+X3/C5OZPhA59J
         Do5H20Z90k9ng==
Date:   Sun, 3 Dec 2023 11:03:52 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Walker Chen <walker.chen@starfivetech.com>,
        JeeHeng Sia <jeeheng.sia@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v1] riscv: dts: starfive: move timebase-frequency to .dtsi
Message-ID: <20231203-mountable-snowsuit-24e4252c9eb5@spud>
References: <20231130-bobbing-valid-b97f26fe8edc@spud>
 <CAJM55Z9=smqcZ=su1oNdk1YZL_XdYAKrwtrZS7ScS=cAVmxZOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gsgU8ZMzlqhOxgDu"
Content-Disposition: inline
In-Reply-To: <CAJM55Z9=smqcZ=su1oNdk1YZL_XdYAKrwtrZS7ScS=cAVmxZOA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gsgU8ZMzlqhOxgDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 02:44:58PM +0100, Emil Renner Berthing wrote:
> Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > Properties fixed by the SoC should be defined in the $soc.dtsi, and the
> > timebase-frequency is not sourced directly from an off-chip oscillator.
>=20
> Yes, according to the JH7100 docs[1] the mtime register is sourced from t=
he
> osc_sys external oscillator through u74rtc_toggle. However I haven't yet =
found
> a place in the docs that describe where that clock is divided by 4 to get
> 6.25MHz from the 25MHz.
>=20
> I expect the JH7110 mtime is set up in a similar way, but haven't yet dug=
 into
> the available documentation.

Your other reply suggests that this is a fixed division for the jh7110,
in which case it makes sense to leave it as-is. mpfs is different in
that it is fixed to 1 MHz regardless of which of the permitted external
oscillator frequencies you use.

--gsgU8ZMzlqhOxgDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWxgmAAKCRB4tDGHoIJi
0sJtAP4pMEN4NONQarXTexQ+6rwQOXlXvIdECO8PYelODQxL6gD9EEx+82qjL5N0
b/REnWOnOFlHnGcBijTAen08Qqc6uAA=
=tfLH
-----END PGP SIGNATURE-----

--gsgU8ZMzlqhOxgDu--

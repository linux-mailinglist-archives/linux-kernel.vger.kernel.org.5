Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5327747B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjHHTR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbjHHTRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:17:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFFD1558A;
        Tue,  8 Aug 2023 09:40:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E73CD623FC;
        Tue,  8 Aug 2023 10:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294EEC433C7;
        Tue,  8 Aug 2023 10:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691491476;
        bh=V/umhZTGl3evHtInzC211fdgJQGdc7LiET+/8luRldw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DfFlpldYwSRpM2j1rpKqckV466YsUzwY+XAIqjL4gid3Zgl2JNmmxgeNVToD9nTBt
         dugoK7A2LEEwRPz0mJtNzvhYSKhigNLrAy9sOIJPi9iY/KOo9Axdw0sUX9j3Y/MJuk
         8b0ZBH5Nw6LtWQOgJRUvWMOPY8mL+TnkDxRMemgR8zjnDtfZv76rqxyO46XLx3q1FU
         0Ke9D+42xkd6yBtTMa4subvtzbIKu4m4lJhBHBCend65RpLsbzAFqQ1YiMNsOZ8AL9
         3aj76VJkpzWOIyK+GyPZEraKxwYRXAL2lKqqj/3M/DhZyJpEbfCwFJ995r/LAqG+o8
         Dkur1MG63RPKA==
Date:   Tue, 8 Aug 2023 11:44:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     JiaJie Ho <jiajie.ho@starfivetech.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] riscv: dts: starfive - Add crypto and trng node
Message-ID: <20230808-fiber-stifle-430ab25390be@spud>
References: <20230808061150.81491-1-jiajie.ho@starfivetech.com>
 <20230808-despair-calm-40ca60de2afb@spud>
 <6c26992dca244c6eab05b64a16be0d0c@EXMBX068.cuchost.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RgPVqGKbYiebNqo8"
Content-Disposition: inline
In-Reply-To: <6c26992dca244c6eab05b64a16be0d0c@EXMBX068.cuchost.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RgPVqGKbYiebNqo8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 10:17:22AM +0000, JiaJie Ho wrote:
> > On Tue, Aug 08, 2023 at 02:11:48PM +0800, Jia Jie Ho wrote:
> > > The following patches add hardware cryptographic and trng module nodes
> > > to JH7110 dts. Patches have been tested on VisionFive2 board.
> > >
> > > Best regards,
> > > Jia Jie
> > >
> > > Jia Jie Ho (2):
> > >   riscv: dts: starfive - Add crypto and DMA node for JH7110
> >=20
> > >   riscv: dts: starfive - Add hwrng node for JH7110 SoC
> >=20
> > I only got one patch, where is the other?
>=20
> Hi Conor,
> My mailing server failed to send out the 2nd patch.
> Do I resend the patch or send it out together with other fixes in v2?

A fixed up v2 please.

--RgPVqGKbYiebNqo8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNIcjwAKCRB4tDGHoIJi
0qjkAQC1Ijbj5bIIJ9R2E2WPDNjZr3nVjnA6RDcKtkWkXI0ATQEAoi1Wsv4j9Qiq
rV/3HbsbpW1FWrJT7qhMXFwBYWIqjAI=
=sG6w
-----END PGP SIGNATURE-----

--RgPVqGKbYiebNqo8--

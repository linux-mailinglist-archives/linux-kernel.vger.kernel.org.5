Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BD4750F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjGLRB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjGLRBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:01:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149DF10C7;
        Wed, 12 Jul 2023 10:01:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A5C761874;
        Wed, 12 Jul 2023 17:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB08CC433C7;
        Wed, 12 Jul 2023 17:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689181302;
        bh=W61o7LlkQs9LBIYjzHUJMBy72qDnWFS0/a8qJkXf2Fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4J4H42OR/vtD+rw+wG1NQ6vEDrz8rXSySfrrPLrIUeoN4Ct2aPEuAjOwvaWRv3cW
         aJpJmYYaiUoBOBEWGod9Vj5UcUS9Jpnhrh1jnK7lJ1dZIBIZLevH1E0muun1AfMPp0
         NZvnUEEWhWG5FZNi/qjgIZUziApMhuQYsmtor+dQ1OXuNc68zMZng55dohedv2dWQJ
         tRqa+mluwl9C5ERDwSrejHNbTQ+QBu+WlSJW+4t+5NuP9ZZSumjXCBfMYndqKB+FDm
         NMEnBHPbyEg7iqHtKbHvCZ+yEYper6sgCEWs3nQthxV46vv2CSNymBgVVrX/r3IiWh
         7tzLiibgRBjjg==
Date:   Wed, 12 Jul 2023 18:01:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     xingyu.wu@starfivetech.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de, kernel@esmil.dk,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, hal.feng@starfivetech.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 0/9] Add STG/ISP/VOUT clock and reset drivers for
 StarFive JH7110
Message-ID: <20230712-unsold-impound-02608d701dfb@spud>
References: <20230712092007.31013-1-xingyu.wu@starfivetech.com>
 <mhng-d3795910-5414-4555-bf3d-75ebe769ed2b@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YXK2FfLMDg7K1UTe"
Content-Disposition: inline
In-Reply-To: <mhng-d3795910-5414-4555-bf3d-75ebe769ed2b@palmer-ri-x1c9a>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YXK2FfLMDg7K1UTe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 09:50:37AM -0700, Palmer Dabbelt wrote:
> On Wed, 12 Jul 2023 02:19:58 PDT (-0700), xingyu.wu@starfivetech.com wrot=
e:
> > This patch serises are base on the basic JH7110 SYSCRG/AONCRG
> > drivers and add new partial clock drivers and reset supports
> > about System-Top-Group(STG), Image-Signal-Process(ISP)
> > and Video-Output(VOUT) for the StarFive JH7110 RISC-V SoC. These
> > clocks and resets could be used by DMA, VIN and Display modules.

> Happy to take it through the RISC-V tree if folks want, but IMO it's
> probably better aimed at the clock/reset folks.  Either way I'd want to g=
ive
> them a chance to ack/review it, so I'm going to drop it from my list.
>=20
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

I had a look through it & I am generally happy with it - everything has
either an R-b from DT folk or Hal on the drivers.
I was going to propose the same thing as the PLL patchset - if Emil is
happy with it, then I intend sending Stephen a PR for the drivers &
bindings.

Thanks,
Conor.

--YXK2FfLMDg7K1UTe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK7ccAAKCRB4tDGHoIJi
0j6sAP42I2NRHZdpOyf2izUoUuaLCqoRMvx4DDBgBCweGvshWAEA7O4i3W5C2V/L
ndm2wUnu6OPIY1snKnd2INzwEwr2XwA=
=kp3i
-----END PGP SIGNATURE-----

--YXK2FfLMDg7K1UTe--

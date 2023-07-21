Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D029775C318
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjGUJcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGUJcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:32:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E54C2726;
        Fri, 21 Jul 2023 02:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32A08618F6;
        Fri, 21 Jul 2023 09:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B70C433C8;
        Fri, 21 Jul 2023 09:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689931966;
        bh=YnSBdEfhfwyPTob8o+YeKHNKwCLCsg52ACNTrnl53hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0ylFNrTrB4uesmyrEKXEGkYMSZ2f8t8VdDglN/EMmvrD/imb5jEYlbzLKDabH5+k
         sLUEs8LJMtB+j46r8tEMB8Dfjd6mrSWcoqSc3f79PGXKZPDRUH75FK4d1BZYK1KJ2C
         vBO3bMEfuXUXaX6V4jmpgPv2maqFOAUQtpRbjBHNEU/Gz4m0c6S4czZd/XeowoVLWq
         eoC3LGOjDKMXYyU74PYhZvIGjUavrYSVMdTjIt+zHIIRJBIe8yVnf1VaoN4oIJPjxM
         ULEbUdd/8oX5q+2LaEZwAkuZcxzWL/i6KX/pzAgBekvwUVWvD9fpiML3QrIZIUhzjM
         lCLdDM34zBPCg==
Date:   Fri, 21 Jul 2023 10:32:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v8 0/9] Add STG/ISP/VOUT clock and reset drivers for
 StarFive JH7110
Message-ID: <20230721-copier-mystify-311b6367f5f8@spud>
References: <20230713113902.56519-1-xingyu.wu@starfivetech.com>
 <20230720-enjoyment-gestation-adb8baa9aaf1@spud>
 <8794c997-f371-70f8-2462-a6c677e7308c@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Da+Ai98mJJBdPIk8"
Content-Disposition: inline
In-Reply-To: <8794c997-f371-70f8-2462-a6c677e7308c@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Da+Ai98mJJBdPIk8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 02:41:56PM +0800, Xingyu Wu wrote:
> On 2023/7/21 0:32, Conor Dooley wrote:
> > On Thu, Jul 13, 2023 at 07:38:53PM +0800, Xingyu Wu wrote:
> >> This patch serises are base on the basic JH7110 SYSCRG/AONCRG
> >> drivers and add new partial clock drivers and reset supports
> >> about System-Top-Group(STG), Image-Signal-Process(ISP)
> >> and Video-Output(VOUT) for the StarFive JH7110 RISC-V SoC. These
> >> clocks and resets could be used by DMA, VIN and Display modules.
> >>=20
> >> Patches 1 and 2 are about the System-Top-Group clock and reset
> >> generator(STGCRG) part. The first patch adds docunmentation to
> >> describe STG bindings, and the second patch adds clock driver to
> >> support STG clocks and resets as auxiliary device for JH7110.
> >>=20
> >> Patches 3 and 4 are about the Image-Signal-Process clock and reset
> >> gennerator(ISPCRG) part. The first patch adds docunmentation to
> >> describe ISP bindings, and the second patch adds clock driver to
> >> support ISP clocks and resets as auxiliary device for JH7110.
> >> And ISP clocks should power on and enable the SYSCRG clocks first
> >> before registering.
> >>=20
> >> Patches 5 and 6 are about the Video-Output clock and reset
> >> generator(VOUTCRG) part. The first patch adds docunmentation to
> >> describe VOUT bindings, and the second patch adds clock driver to
> >> support VOUT clocks and resets as auxiliary device for JH7110.
> >> And VOUT clocks also should power on and enable the SYSCRG clocks
> >> first before registering.
> >>=20
> >> Patch 7 adds struct members to support STG/ISP/VOUT resets.
>=20
> BTW, I found this patch is not in the linux-next or clk-next.
> These STG/ISP/VOUT CRG drivers are 'incomplete' without this resets patch.
> I don't know what your plans about this patch and I'm just curious on it.

Oh. I mistakenly thought that this was a standalone reset controller
patch that Philipp could take, but now I see it depends on the=20
dt-binding headers added by this series.
Maybe you could resend it by itself, and Stephen could pick it into
clk-next?

Sorry about that,
Conor.

--Da+Ai98mJJBdPIk8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLpQuQAKCRB4tDGHoIJi
0pbJAQCJbQjvdBO4XPzRbydiA7oYCEaxC4D8InDZePLnMiemSAD+N05Kkic2KDd1
lVLWaU/WspQV+L72HjM//dmvcHQd/g0=
=Orl3
-----END PGP SIGNATURE-----

--Da+Ai98mJJBdPIk8--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C61575B448
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjGTQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjGTQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:32:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9CA1701;
        Thu, 20 Jul 2023 09:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5B6C61B7A;
        Thu, 20 Jul 2023 16:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349B0C433CB;
        Thu, 20 Jul 2023 16:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689870762;
        bh=BWdCrFmpxyBYlw8r5cwZXw29k1AMvOqH50MyuBtkGAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VkeBV3L4Opf0ORaPITshAX9YPA5Y7i4VAz8fPFmhzDe0SjeZI6LGQTFmCq5jlh9IU
         i9+zTzlykI0YptDOTTDiiWHsi/dOnLs2qoAa18LSxzVaCYIQUdmKft1/GNL8c5wWDd
         JBmO33/dn0bZGPY7lA55iDO9lUgONUxdP3A6NKC6YDv13nhx2FP9Xmyf/tzaaJi2Ae
         ft1NkB8cUexYsdwBWf1Lnap23eqt8hhq7NMcK/wtK/qlfCveoyTNc8T2FBxazmN9Lv
         q/pJuhJjfyeKwafoBlQeHgXVmjv21/1i4fX/sGiCqqBEabvXQoY5FOOCEwOSKRW403
         SiQN5oQF865Ww==
Date:   Thu, 20 Jul 2023 17:32:36 +0100
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
Message-ID: <20230720-enjoyment-gestation-adb8baa9aaf1@spud>
References: <20230713113902.56519-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vhTePwvhqc04hvmz"
Content-Disposition: inline
In-Reply-To: <20230713113902.56519-1-xingyu.wu@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vhTePwvhqc04hvmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 07:38:53PM +0800, Xingyu Wu wrote:
> This patch serises are base on the basic JH7110 SYSCRG/AONCRG
> drivers and add new partial clock drivers and reset supports
> about System-Top-Group(STG), Image-Signal-Process(ISP)
> and Video-Output(VOUT) for the StarFive JH7110 RISC-V SoC. These
> clocks and resets could be used by DMA, VIN and Display modules.
>=20
> Patches 1 and 2 are about the System-Top-Group clock and reset
> generator(STGCRG) part. The first patch adds docunmentation to
> describe STG bindings, and the second patch adds clock driver to
> support STG clocks and resets as auxiliary device for JH7110.
>=20
> Patches 3 and 4 are about the Image-Signal-Process clock and reset
> gennerator(ISPCRG) part. The first patch adds docunmentation to
> describe ISP bindings, and the second patch adds clock driver to
> support ISP clocks and resets as auxiliary device for JH7110.
> And ISP clocks should power on and enable the SYSCRG clocks first
> before registering.
>=20
> Patches 5 and 6 are about the Video-Output clock and reset
> generator(VOUTCRG) part. The first patch adds docunmentation to
> describe VOUT bindings, and the second patch adds clock driver to
> support VOUT clocks and resets as auxiliary device for JH7110.
> And VOUT clocks also should power on and enable the SYSCRG clocks
> first before registering.
>=20
> Patch 7 adds struct members to support STG/ISP/VOUT resets.

> Patch 8 adds external clocks which ISP and VOUT clock driver need.
> Patch 9 adds device node about STGCRG, ISPCRG and VOUTCRG to JH7110 dts.

b4 did not detect this correctly, but I picked these 2 up too.
They should be in next tomorrow.

Please let your co-workers know that they should resend anything that I
didn't sent a thanks email for today, as it failed to apply (eg DMA,
eMMC).

Thanks,
Conor.


--vhTePwvhqc04hvmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLlhpAAKCRB4tDGHoIJi
0pKSAQDFCDfQMvi4yv9+Tf0xlqT4YwJIY33dn1oTYWiDjF5HUgD/XBWnMLctc9VN
l2Gvi7R1GuFnkUjc2SjU2w7UPnb0HQw=
=8f8y
-----END PGP SIGNATURE-----

--vhTePwvhqc04hvmz--

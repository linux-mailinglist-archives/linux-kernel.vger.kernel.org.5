Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA7D77966F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbjHKRrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbjHKRq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:46:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973D210D;
        Fri, 11 Aug 2023 10:46:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FEB36780A;
        Fri, 11 Aug 2023 17:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC28C433C7;
        Fri, 11 Aug 2023 17:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691776018;
        bh=4LhsxggR4DWdzIJ8SEP6TtdTORcSpYx2QpOWDA0Evg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iyXlfEGj7M8tG1HTeNYnovhsUXgxF5XyfBzHZJLx8DdZKrh13DXZmdli5TwiQbxBM
         U/tJAalvLY5dcMbdyUrWowMQ3dbqR/WDpI+LqXO2wUD7QpJZnPKvKiaywN+KKmX1nj
         qjNKyKDNzXXkKAFZWppZ9M7HNqnYDTicluGT3YNupuwPOA3F9ly7ICWjpm+6BDfZfa
         m+7L5YgOuXLSaqGoI3oIP0n+ZOtiJitQK3Vm/iNaU/V0h/p27nj6mW7tMz5JF7kO3o
         CB7v3erNuQh6KKoEx3Nj0fm0KvIYijXP2wklnVGcuBXeI3cZNOx6yQaNR2geOtO2/v
         UX6+wQBkcvTTA==
Date:   Fri, 11 Aug 2023 18:46:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Message-ID: <20230811-bucket-fog-7d04c1ac227c@spud>
References: <20230617161529.2092-1-jszhang@kernel.org>
 <ZNZyNjjekd2SW/mn@x1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CxXu613LXMe5kC+W"
Content-Disposition: inline
In-Reply-To: <ZNZyNjjekd2SW/mn@x1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CxXu613LXMe5kC+W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 10:39:02AM -0700, Drew Fustini wrote:
> On Sun, Jun 18, 2023 at 12:15:21AM +0800, Jisheng Zhang wrote:
> > Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> > module which is powered by T-HEAD's TH1520 SoC. Add minimal device
> > tree files for the core module and the development board.
> >=20
> > Support basic uart/gpio/dmac drivers, so supports booting to a basic
> > shell.
> >=20
> > NOTE: the thead cpu reset dt-binding and DT node are removed in v3. This
> > makes secondary CPUs unable to be online. However, minimal th1520
> > support is better than nothing. And the community has been working on
> > and will work on the cpu reset dt-binding, for example, Conor, Guo and
> > Jessica are discussing about it, I have seen valuable comments and
> > inputs from them. I believe we can add back cpu reset in next
> > development window.
>=20
> I'm interested in starting the secondary cpus on mainline. It seems that
> that "thead,reset-sample" is already implemented in upstream OpenSBI in
> lib/utils/reset/fdt_reset_thead.c and the issue is getting the
> dt-binding accepted. Is that correct?

There was nothing in the original series (AFAIR) that actually uses the
properties. Including it in the Linux DTS just makes life easier, since
the dts could also be used in OpenSBI?

> It looks like you've tried to restart the discussion on the DT list [1]
> so I hope that the DT maintainers will give their perspective.

I'm not sure what there is to say. I already gave feedback about it
which has been ignored.

--CxXu613LXMe5kC+W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNZ0DQAKCRB4tDGHoIJi
0ulpAQD+MhyrwIMZu/OHV7kmlJ8+cHk6ntWVt/wF02p8DWTHXwD/ZIRNDQPRWB+A
bqkAwKwfa3oPmtvhr01lQVk/iLOhTwQ=
=cDLk
-----END PGP SIGNATURE-----

--CxXu613LXMe5kC+W--

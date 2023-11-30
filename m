Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7263A7FEA41
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344826AbjK3IMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjK3IMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:12:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F00FA3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:12:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BBEC433C7;
        Thu, 30 Nov 2023 08:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701331961;
        bh=4TV1m4EuLOh648gIpJtq8IGZ08wvqJekfJH88iGr6Ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3RxQ9UQczk91u/zi7K1KU9msV/n8hdbHHsRonDyGX71dymI6SBvMBf5TQUP0Yp6w
         CjrghI0NJ86OoUv74pQV/ER3FPXhlDURbjUK0y0kW6xzI+kJ9IdhagQ/zGlanb7vk/
         HHeFpj3mfbx2245AqDkOFYRqgZ5YGeHrftl8+ye24EHnTGhyxe7EhXHpiAfb3+8whI
         YjEA4CEr6cRuoHzktMtVlzFb8vPLua46NdgY5z0NrYtTzZpjJeiKrsFRcVyPPTwmSI
         h0Me+8qveOYTB/4JgRsbnxHrv/PtbyW7jx4jm0AkywFvGDiNtmVAD+CnyNVZJrNuJ4
         4JqKWnbvZqRYQ==
Date:   Thu, 30 Nov 2023 08:12:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicorn_wang@outlook.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, richardcochran@gmail.com,
        robh+dt@kernel.org, sboyd@kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com,
        xiaoguang.xing@sophgo.com, guoren@kernel.org, jszhang@kernel.org,
        inochiama@outlook.com, samuel.holland@sifive.com
Subject: Re: [PATCH v2 3/4] clk: sophgo: Add SG2042 clock generator driver
Message-ID: <20231130-enlarging-decode-31dc66f4490b@spud>
References: <cover.1701044106.git.unicorn_wang@outlook.com>
 <c06130afb4bdc1890b4e8d29388fa6feef1f1826.1701044106.git.unicorn_wang@outlook.com>
 <81d421c8-bfd6-42b5-9da1-f067792f8f48@linaro.org>
 <MA0P287MB03329CFBA3BB6A4E4F322F99FEBDA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <2a268c8c-ce55-4321-b390-092b8df61407@linaro.org>
 <MA0P287MB03320824AB953465E00394FEFE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5QzKJcKXThA97D7v"
Content-Disposition: inline
In-Reply-To: <MA0P287MB03320824AB953465E00394FEFE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5QzKJcKXThA97D7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 02:37:53PM +0800, Chen Wang wrote:
>=20
> On 2023/11/27 17:16, Krzysztof Kozlowski wrote:
> > On 27/11/2023 09:07, Chen Wang wrote:
> > > On 2023/11/27 15:12, Krzysztof Kozlowski wrote:
> > > > On 27/11/2023 02:15, Chen Wang wrote:
> > > > > From: Chen Wang <unicorn_wang@outlook.com>
> > > > >=20
> > > > > Add a driver for the SOPHGO SG2042 clock generator.
> > > > >=20
> > > > > Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> > > > ...
> > > >=20
> > > > +}
> > > > +
> > > > +CLK_OF_DECLARE(sg2042_clk, "sophgo,sg2042-clkgen", sg2042_clk_init=
);
> > > > No, this should be platform device. It's a child of another device,=
 so
> > > > you cannot use other way of init ordering.
> > > hi, Krzysztof,
> > >=20
> > > Thanks for your review.
> > >=20
> > > I don't quite understand your opinion. Do you mean CLK_OF_DECLARE is
> > > only used for platform device so it can not be use here? But I think
> > No, I meant you mix init ordering: you depend now on syscon earlier
> > initcall than CLK_OF_DECLARE. Do you remember which one is first? If
> > anything changes here, your driver is broken. There is no dependency, no
> > probe deferral.
>=20
> hi, Krzysztof,
>=20
> I found that the initcall method cannot be used for the clock controller =
of
> sg2042. We need to initialize the clock earlier because there are two
> dw-apb-timers in sg2042 (Sorry, I have not added them in the current DTS =
of
> sg2042, will be submitted later). The initialization of these timers
> (timer_probe()) depends on the initialization of the clock controller. If=
 we
> use the initcall mechanism, it will be too late for the timer. So it seems
> better to use CLK_OF_DECLARE provided by CCF.
>=20
> I have a question here that I would like to discuss. The design of sg2042=
 is
> like this, according to the design of memorymap in its TRM:
>=20
> 070:3001:0000 ~ 070:3001:0FFF SYS_CTRL 4K
> 070:3001:1000 ~ 070:3001:1FFF PINMUX 4K
> 070:3001:2000 ~ 070:3001:2FFF CLOCK 4K
> 070:3001:3000 ~ 070:3001:3FFF RESET 4K
>=20
> But also as per hw design (I don't know why and I don't like it also :( ),
> some of the PLL/GATE CLOCK control registers are defined in the scope of
> SYS_CTRL, and others are defined in the scope of CLOCK. That's why in the
> current code, I define the syscon node corresponding to SYS_CTRL. The
> purpose is just to get the regmap of syscon for the clock controller thro=
ugh
> the device tree (through device_node_to_regmap()), so that the syscon
> defined in SYS_CTRL can be accessed through the regmap from clock. The cl=
ock
> controller driver itself does not rely on other operations of syscon.
>=20
> So based on the above analysis, is it still necessary for us to define the
> clock controller as a child node of syscon? In the version v1 of this pat=
ch,
> I actually did not define the clock controller as a child node of syscon,
> but only accessed syscon through the phandle method. [1]

In that version of the code, clkgen, your DTS, looked like:
+	clkgen: clock-controller {
+		compatible =3D "sophgo,sg2042-clkgen";
+		#clock-cells =3D <1>;
+		system-ctrl =3D <&sys_ctrl>;
+		clocks =3D <&cgi>;
+		assigned-clocks =3D \

+		assigned-clock-rates =3D \

+	};

It had no register regions of its own, just what it got from the sys
ctrl block, which is why I said that. The syscon block looked like:

+		sys_ctrl: syscon@7030010000 {
+			compatible =3D "sophgo,sg2042-syscon", "syscon";
+			reg =3D <0x70 0x30010000 0x0 0x8000>;
+		};

which given the register map does not seem like an accurate reflection
of the size of this region. The "0x8000" should be "0x1000".
>=20
> After more read of the TRM, I believe this situation only exists for cloc=
k.
> That is to say, there will be only one child node of clook under syscon.
> From a hardware design perspective, CLOCK and SYS_CTRL are two different
> blocks. So I think it is better to restore the original method, that is,
> restore clock and syscon to nodes of the same level, and let clock use
> phandle to access syscon.

This sounds two me like there are two different devices. One the "CLOCK"
region at 070:3001:2000 that should be documented as being
"sophgo,sg2042-clkgen" or similar and the second being the "SYS_CTRL" at
070:3001:0000 that is called something like "sophgo,sg2042-sysctrl".
Having more than one clock controller is not a problem and sounds like a
more accurate description of the hardware.

>=20
> What do you think or do you have any good suggestions?
>=20
> Link: https://lore.kernel.org/linux-riscv/20231114-timid-habitat-a06e52e5=
9c9c@squawk/#t
> [1]
>=20
> Thanks
>=20
> Chen
>=20
> >=20
> > > this driver is still for platform device though I move the clock
> > > controller node as a child of the system contoller node. System
> > > controller node is just a block of registers which are used to control
> > > some other platform devices ,such as clock controller, reset controll=
er
> > > and pin controller for this SoC.
> > >=20
> > > And I also see other similar code in kernel, for example:
> > > drivers/clk/clk-k210.c.
> > >=20
> > > And I'm confused by your input "so you cannot use other way of init
> > > ordering." Do you mean "so you CAN use other way of init ordering"?
> > No, I meant you cannot. If you want to use syscon, then your driver
> > should be a proper driver. Therefore add a driver.
> >=20
> > > What's the other way of init ordering do you mean?
> > The one coming not from initcalls but driver model.
> >=20
> > Best regards,
> > Krzysztof
> >=20

--5QzKJcKXThA97D7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWhD8gAKCRB4tDGHoIJi
0qD3APwKST0oQkyhMEP3YAoVteewNlDifbk9w0pWbLzVPSiZfwD/YwK56a15vfNL
ZWr3VDx87CBcnDI47LgIMV4g2g/uSQs=
=otoo
-----END PGP SIGNATURE-----

--5QzKJcKXThA97D7v--

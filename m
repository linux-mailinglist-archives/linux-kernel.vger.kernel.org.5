Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DEC769ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjGaPct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGaPcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:32:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649DCBF;
        Mon, 31 Jul 2023 08:32:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0257B611A0;
        Mon, 31 Jul 2023 15:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35A5C433C8;
        Mon, 31 Jul 2023 15:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690817565;
        bh=W0IpSFwS67t8wZMVaiBzUL8aZ4W06IfVmvreY4qbGLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2K5ueSBGnVMsidOJRqwrd4MjEmjg+Hw3FDDf740xrfNrJZEP43f/YESO5YpUSVrp
         ACOsDnY958gSrkfOzCOgVClGrmL3A4f/hHSKx09Ys/ySrp9DJfhgOC4Tw/+7EruT91
         lEXwNmjptQx0YV8SvmJFwKjFDmWy2P/+rzBxS75CVoJVb3niIIfWe+m2wMrVzSwkVE
         3bJyGkXW1wj/t0lbCZ4sHlIXg4wS+DXHLhXCLZX/0apuvdbe05xZcMbLvRju9w2ADt
         23PNQZ3UgyXI/tcWHZs/pyc3eRqRAohZaqYBkl4E23N49vcUJDPHsu6uxQyirqekTt
         4OcN/oZWxia/w==
Date:   Mon, 31 Jul 2023 16:32:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: add rk3588 compatible to
 rockchip,dwc3
Message-ID: <20230731-decipher-smuggler-2f83caa8c616@spud>
References: <20230720173643.69553-1-sebastian.reichel@collabora.com>
 <20230720173643.69553-2-sebastian.reichel@collabora.com>
 <20230722-coleslaw-breeder-40827e23f717@spud>
 <20230731151224.2vlk7bnabrqhz3pr@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZiAI6f3sKG+VEhr4"
Content-Disposition: inline
In-Reply-To: <20230731151224.2vlk7bnabrqhz3pr@mercury.elektranox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZiAI6f3sKG+VEhr4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 05:12:24PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Sat, Jul 22, 2023 at 12:42:09PM +0100, Conor Dooley wrote:
> > On Thu, Jul 20, 2023 at 07:36:41PM +0200, Sebastian Reichel wrote:
> > > RK3588 has three DWC3 controllers. Two of them are fully functional in
> > > host, device and OTG mode including USB2 support. They are connected =
to
> > > dedicated PHYs, that also support USB-C's DisplayPort alternate mode.
> > >=20
> > > The third controller is connected to one of the combphy's shared
> > > with PCIe and SATA. It can only be used in host mode and does not
> > > support USB2. Compared to the other controllers this one needs
> > > some extra clocks.
> > >=20
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >=20
> > I feel like I say it a bunch for some of these Rockchip bindings
> > patches, but if you're adding more clocks for some SoCs, should some
> > per-SoC constraints not also be added?
>=20
> The extra clocks are not actually needed by all the USB3 controllers
> in the SoC. Only one of three USB3 controllers needs them. In v1 I
> used different compatible values to narrow the clock binding down
> and Krzysztof asked to remove that. So please tell me what it should
> look like.

Maybe Krzysztof and I were talking about different things. I was talking
about constraining !3588 SoCs so that nobody tries to use a utmi and
pipe clock on those, and only allowing them on a 3588. AFAICT, what
Krzysztof objected to was having more than one compatible for
controllers on the 3588. Maybe he weigh in.

Thanks,
Conor.

> > > ---
> > >  .../devicetree/bindings/usb/rockchip,dwc3.yaml        | 11 +++++++++=
--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml=
 b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> > > index 291844c8f3e1..cbc3e55e05e1 100644
> > > --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> > > @@ -30,6 +30,7 @@ select:
> > >          enum:
> > >            - rockchip,rk3328-dwc3
> > >            - rockchip,rk3568-dwc3
> > > +          - rockchip,rk3588-dwc3
> > >    required:
> > >      - compatible
> > > =20
> > > @@ -39,6 +40,7 @@ properties:
> > >        - enum:
> > >            - rockchip,rk3328-dwc3
> > >            - rockchip,rk3568-dwc3
> > > +          - rockchip,rk3588-dwc3
> > >        - const: snps,dwc3
> > > =20
> > >    reg:
> > > @@ -58,7 +60,9 @@ properties:
> > >            Master/Core clock, must to be >=3D 62.5 MHz for SS
> > >            operation and >=3D 30MHz for HS operation
> > >        - description:
> > > -          Controller grf clock
> > > +          Controller grf clock OR UTMI clock
> > > +      - description:
> > > +          PIPE clock
> > > =20
> > >    clock-names:
> > >      minItems: 3
> > > @@ -66,7 +70,10 @@ properties:
> > >        - const: ref_clk
> > >        - const: suspend_clk
> > >        - const: bus_clk
> > > -      - const: grf_clk
> > > +      - enum:
> > > +          - grf_clk
> > > +          - utmi
> > > +      - const: pipe
> > > =20
> > >    power-domains:
> > >      maxItems: 1
> > > --=20
> > > 2.40.1
> > >=20
>=20
>=20



--ZiAI6f3sKG+VEhr4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMfUGAAKCRB4tDGHoIJi
0gYdAQCtVymT2J92udmYoQAUhL5iDXjhAv7jPmdRlPyKGj/qHgEA/fz2olBaKF0u
BkCLMkL5P1piybZ1GpYuKH/Qjf9ugg8=
=3JZ5
-----END PGP SIGNATURE-----

--ZiAI6f3sKG+VEhr4--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B84769A83
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjGaPMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGaPM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:12:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C27810F7;
        Mon, 31 Jul 2023 08:12:28 -0700 (PDT)
Received: from mercury (dyndsl-091-248-210-008.ewe-ip-backbone.de [91.248.210.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 94B60660709D;
        Mon, 31 Jul 2023 16:12:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690816346;
        bh=3XhcVaBAyFWjCc129KgVjm+Ns/bjapharaVEYpGJmdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nbPN5Co+R/you8H8WeD81T/ZpCF6pqoj74zF26G53CDHpiuvRN16kiJmypPRDhx3B
         x3qJIj716Kzl90j8yKx+cznY10CjmgC8nKlMWmCPbPtbWpG9gMmgcO3Tf4y4WTQ73n
         oS7WItLgDUz1IjJxwoRBTaUsQX5I94rQURdA2dA1KeWKoNnHso7YLTyXWurBMze5a2
         iIbRloHVjOziiNxVDxcN7bjYAeek8H4/YML6gxN1C9yhQdF1QppcdGb61mgL4+Xw0h
         9JRLMp/Y5R7KRbM1cRwxxNmwvdPxPZhqhVGEdHN1sAPnvX5em6HLjl5WqB6XGYsJF9
         1jpH799snTe2Q==
Received: by mercury (Postfix, from userid 1000)
        id 3ABB71061FAC; Mon, 31 Jul 2023 17:12:24 +0200 (CEST)
Date:   Mon, 31 Jul 2023 17:12:24 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Conor Dooley <conor@kernel.org>
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
Message-ID: <20230731151224.2vlk7bnabrqhz3pr@mercury.elektranox.org>
References: <20230720173643.69553-1-sebastian.reichel@collabora.com>
 <20230720173643.69553-2-sebastian.reichel@collabora.com>
 <20230722-coleslaw-breeder-40827e23f717@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m6dzip35wy4zbmme"
Content-Disposition: inline
In-Reply-To: <20230722-coleslaw-breeder-40827e23f717@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m6dzip35wy4zbmme
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 22, 2023 at 12:42:09PM +0100, Conor Dooley wrote:
> On Thu, Jul 20, 2023 at 07:36:41PM +0200, Sebastian Reichel wrote:
> > RK3588 has three DWC3 controllers. Two of them are fully functional in
> > host, device and OTG mode including USB2 support. They are connected to
> > dedicated PHYs, that also support USB-C's DisplayPort alternate mode.
> >=20
> > The third controller is connected to one of the combphy's shared
> > with PCIe and SATA. It can only be used in host mode and does not
> > support USB2. Compared to the other controllers this one needs
> > some extra clocks.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> I feel like I say it a bunch for some of these Rockchip bindings
> patches, but if you're adding more clocks for some SoCs, should some
> per-SoC constraints not also be added?

The extra clocks are not actually needed by all the USB3 controllers
in the SoC. Only one of three USB3 controllers needs them. In v1 I
used different compatible values to narrow the clock binding down
and Krzysztof asked to remove that. So please tell me what it should
look like.

Greetings,

-- Sebastian

> > ---
> >  .../devicetree/bindings/usb/rockchip,dwc3.yaml        | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b=
/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> > index 291844c8f3e1..cbc3e55e05e1 100644
> > --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> > +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> > @@ -30,6 +30,7 @@ select:
> >          enum:
> >            - rockchip,rk3328-dwc3
> >            - rockchip,rk3568-dwc3
> > +          - rockchip,rk3588-dwc3
> >    required:
> >      - compatible
> > =20
> > @@ -39,6 +40,7 @@ properties:
> >        - enum:
> >            - rockchip,rk3328-dwc3
> >            - rockchip,rk3568-dwc3
> > +          - rockchip,rk3588-dwc3
> >        - const: snps,dwc3
> > =20
> >    reg:
> > @@ -58,7 +60,9 @@ properties:
> >            Master/Core clock, must to be >=3D 62.5 MHz for SS
> >            operation and >=3D 30MHz for HS operation
> >        - description:
> > -          Controller grf clock
> > +          Controller grf clock OR UTMI clock
> > +      - description:
> > +          PIPE clock
> > =20
> >    clock-names:
> >      minItems: 3
> > @@ -66,7 +70,10 @@ properties:
> >        - const: ref_clk
> >        - const: suspend_clk
> >        - const: bus_clk
> > -      - const: grf_clk
> > +      - enum:
> > +          - grf_clk
> > +          - utmi
> > +      - const: pipe
> > =20
> >    power-domains:
> >      maxItems: 1
> > --=20
> > 2.40.1
> >=20



--m6dzip35wy4zbmme
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmTHz0AACgkQ2O7X88g7
+pqKjg/+OYBPYuk3hSKFWkamZHuGn2rDB7jeHnXzTF7PG/ehiqqifOqn2ro376hZ
Ays6PKMQR+4a+te/CSgLYvH5jc0AB+4v6tA5olENnyRF8XfMaUB6LGPv/HDBWU1v
yhmleCXSeBGcJwpoxsB8UMhhUdzaXlLJ3tRfrtsJJnSOL2Hu8FHif/5RQ8BIoZg/
Q89X9a2zYUlevNHiK63HIjih60/FagN7FvfuPRxz0OpZYewsFIJVfX6SltPuUUNa
p6HuuEcbVzWklTshBax2IKSfT/DHEZAtdcuRaUhZ/7Xiy0BPvOHQQIunh8oKzLde
MquuX8YesnPH/VQzWIElIUOej2RsOMNYE/o/Fw8jRL/j2jQtvUWYHr/dbQy940BW
Pvci2+YO5TQtscLPIAngEqD65VGco9pzbZo9C2cMNXik/LmE+AGomcAFt/Ea4o3l
Cq3UL87xcO/nIuj/wsaNfH0o9CZSbl6tOx4QTgt4EouXDk4kh3prLslOEnhhBGT+
zB4Zbk7ZwH6Q8gWZdo5ED7JiXRsVx6W2NHdFAAkZMq2B/NCKykV/MI2hDDoO6AXC
wd6cGFMCQKrmNO1bWtPBL3jBwwQadZf3M4wtBagB3AsE5UUhc+5JwjZEKWIKfnd3
pRKq0qyv6KC/QaySyXYf1d3094JZL3Ks4rvKAlOHlKuHYesdzWU=
=qk2b
-----END PGP SIGNATURE-----

--m6dzip35wy4zbmme--

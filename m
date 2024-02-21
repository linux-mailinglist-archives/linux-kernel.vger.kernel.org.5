Return-Path: <linux-kernel+bounces-75482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E2485E94D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9510B1C22629
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9924786AF8;
	Wed, 21 Feb 2024 20:55:52 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533343BB4C;
	Wed, 21 Feb 2024 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708548952; cv=none; b=iEMOaD8mHJiaJyENX3vTguO62dlUMR2Q0BCXtANcItGjwe98vDFLoB1gd113rtj6vM6uJLpLp2UGlyWJX6CF8GZynJQO4OUT+uJkJhtM3g0wHuGofjWjVREqdHnDpAp6MfauTh2mwZo2aM9mEbwlx3LVpVmzMZYE7HpuWzQPoJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708548952; c=relaxed/simple;
	bh=rHfeQb45HtkUG7g1SRcqejqfXqfz6MTlodE8sg4okTI=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=OtNjebns7/mI+bcgej4f7jrI04p2HTE6MXqDdm7heDi5cRfxkQ4OInUsodVclIyCWUvT4zUR1wn6uR1gtEgn/PWM1gNXR6VDqBS2zNHnw8C9V3TuzpB7eYiCEq+L5KmFsn8WEEJRFppBuRBA/Qheh6s57MWIPKf7aSg16cS+Jl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id BB61937820D2;
	Wed, 21 Feb 2024 20:55:46 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <fd3b7ab7-3702-412f-947a-95396dbe1f4c@linaro.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240216094922.257674-1-shreeya.patel@collabora.com>
 <20240216094922.257674-3-shreeya.patel@collabora.com> <fd3b7ab7-3702-412f-947a-95396dbe1f4c@linaro.org>
Date: Wed, 21 Feb 2024 20:55:46 +0000
Cc: heiko@sntech.de, mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, jose.abreu@synopsys.com, nelson.costa@synopsys.com, dmitry.osipenko@collabora.com, sebastian.reichel@collabora.com, shawn.wen@rock-chips.com, kernel@collabora.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org, linux-dt@vger.kernel.org, linux-arm@lists.infradead.org
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1048c3-65d66380-b-49a25c80@188726434>
Subject: =?utf-8?q?Re=3A?= [PATCH 2/4] =?utf-8?q?dt-bindings=3A?=
 =?utf-8?q?_media=3A?= Document bindings for HDMI RX Controller
User-Agent: SOGoMail 5.9.1
Content-Transfer-Encoding: quoted-printable

On Friday, February 16, 2024 15:31 IST, Krzysztof Kozlowski <krzysztof.=
kozlowski@linaro.org> wrote:

> On 16/02/2024 10:49, Shreeya Patel wrote:
> > Document bindings for the Synopsys DesignWare HDMI RX Controller.
> >=20
> > Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>=20
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/device=
tree/bindings/submitting-patches.rst#L18
>=20
> > ---
> >  .../bindings/media/snps,dw-hdmi-rx.yaml       | 128 ++++++++++++++=
++++
> >  1 file changed, 128 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/snps,dw=
-hdmi-rx.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/media/snps,dw-hdmi-r=
x.yaml b/Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml
> > new file mode 100644
> > index 000000000000..a70d96b548ee
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml
> > @@ -0,0 +1,128 @@
> > +# SPDX-License-Identifier: (GPL-3.0 OR BSD-2-Clause)
>=20
> Use license checkpatch tells you.
>=20
> > +# Device Tree bindings for Synopsys DesignWare HDMI RX Controller
> > +
> > +---
> > +$id: http://devicetree.org/schemas/media/snps,dw-hdmi-rx.yaml#
>=20
> Why this is a media, not display? Does RX means input? Lack of hardwa=
re
> description does not help?
>=20

Yes, RX means input and this binding doc is for the HDMI INPUT controll=
er.
I'll add some description in v2

>=20
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Synopsys DesignWare HDMI RX Controller
> > +
> > +maintainers:
> > +  - Shreeya Patel <shreeya.patel@collabora.com>
> > +
>=20
> description:
>=20
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: rockchip,rk3588-hdmirx-ctrler
> > +      - const: snps,dw-hdmi-rx
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 3
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: cec
> > +      - const: hdmi
> > +      - const: dma
> > +
> > +  clocks:
> > +    maxItems: 7
> > +
> > +  clock-names:
> > +    items:
> > +      - const: aclk
> > +      - const: audio
> > +      - const: cr=5Fpara
> > +      - const: pclk
> > +      - const: ref
> > +      - const: hclk=5Fs=5Fhdmirx
> > +      - const: hclk=5Fvo1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 4
> > +
> > +  reset-names:
> > +    items:
> > +      - const: rst=5Fa
> > +      - const: rst=5Fp
> > +      - const: rst=5Fref
> > +      - const: rst=5Fbiu
>=20
> Drop rest=5F prefix
>=20
> > +
> > +  pinctrl-names:
> > +    const: default
>=20
> Drop
>=20
> > +
> > +  memory-region:
> > +    maxItems: 1
> > +
> > +  hdmirx-5v-detection-gpios:
> > +    description: GPIO specifier for 5V detection.
>=20
> Detection of what? Isn't this HPD?
>=20
> > +    maxItems: 1
> > +
> > +  rockchip,grf:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      The phandle of the syscon node for the GRF register.
>=20
> Instead describe what for. Basically 80% of your description is
> redundant and only "GRF register" brings some information.
>=20
>=20
> > +
> > +  rockchip,vo1=5Fgrf:
>=20
> No underscores.
>=20
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      The phandle of the syscon node for the VO1 GRF register.
>=20
> Same problem.
>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +  - resets
> > +  - pinctrl-0
> > +  - pinctrl-names
>=20
> Why? Drop.
>=20
> > +  - hdmirx-5v-detection-gpios
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/power/rk3588-power.h>
> > +    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> > +    hdmirx=5Fctrler: hdmirx-controller@fdee0000 {
>=20
> What is hdmirx-controller? Isn't this just hdmi@?
>=20

Writing just hdmi would imply hdmi output I think so that name
will not be appropriate here.

> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-de=
vicetree-basics.html#generic-names-recommendation
>=20

This documentation doesn't have any generic name for HDMI INPUT
but maybe we can use the name hdmi-receiver like some other existing
binding has it here :-
Documentation/devicetree/bindings/media/i2c/tda1997x.txt

Thanks,
Shreeya Patel
>=20
> > +      compatible =3D "rockchip,rk3588-hdmirx-ctrler", "snps,dw-hdm=
i-rx";
> > +      reg =3D <0x0 0xfdee0000 0x0 0x6000>;
> > +      interrupts =3D <GIC=5FSPI 177 IRQ=5FTYPE=5FLEVEL=5FHIGH 0>,
> > +                   <GIC=5FSPI 436 IRQ=5FTYPE=5FLEVEL=5FHIGH 0>,
> > +                   <GIC=5FSPI 179 IRQ=5FTYPE=5FLEVEL=5FHIGH 0>;
>=20
>=20
>=20
> Best regards,
> Krzysztof
>=20
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com
> This list is managed by https://mailman.collabora.com



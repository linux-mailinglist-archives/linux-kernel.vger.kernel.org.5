Return-Path: <linux-kernel+bounces-14239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0878219A6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E811F221EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6338D2E5;
	Tue,  2 Jan 2024 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HgE6W/hn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F012D27F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ccba761783so72816541fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 02:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704191158; x=1704795958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cKlcr9TDXVMFehMkzlKiGxOSc5Va79SEC/vL9WVI28=;
        b=HgE6W/hnge5njJheiWy3LC29QftcC0boKVfgebR4QIQZs4vMQCo++IzqDPru+5VtDI
         NqXVizqBM7qMTTJGLr14IKu4tc4UttzITYLoqKz5KpaGx3cRCwLb0xBlmjJNCPAXmRuj
         eCxAT1gUrhSftSkIlY6J2b/Hr3taFv4lcYhXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704191158; x=1704795958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cKlcr9TDXVMFehMkzlKiGxOSc5Va79SEC/vL9WVI28=;
        b=WfpQybPFZ4jGmSOOknZoebQBngTZCzEQ/N68ggv0QGfbLRQzttcDEFWVfI31cBZ1AT
         y5jOxz/lrmaLykxGS4YbjSNKNXZ0uZtnxGVAggJ56qVDVLhKYdkqA38O7MJwPLfMR9jS
         64EH01IjXNLJRf6pZsaUOWxN0l1QZktX/9GDYm6R1+mBQ+HlbUQMCSxULc+sAiKbYbU7
         mEwld724uobpK/BPgZfSkHE8eYHxSmmNvtRHOiK8VNLfe5mRAZrbts1W4Kf1+gqCKagm
         6VrRsprM/RZSPpvcoZ0r2V+5pBQzG5YGTngAqWKGpfBbIWLEAaluAp0oEZYDOkvxcT5N
         9/Gw==
X-Gm-Message-State: AOJu0YwBOAhsjawPFVA88OJcGzZeTH7YN1wSduqXMQzQ4R0qd3OXQVsE
	J7zZ56k/XUj5Vnvw3Q4ygXFJee/TC2N41BKVxmaPPtp7uRGltI+QSVrbFQ4=
X-Google-Smtp-Source: AGHT+IEGSX35g6EPnerKa8KwPEvruyC+Q2TuN1yb8rNK9FEIB+XeyMq/8mUvO/5tVQzkmn1erUK1+fV7WllsmOUyyCA=
X-Received: by 2002:a2e:9d9a:0:b0:2cb:30f4:a342 with SMTP id
 c26-20020a2e9d9a000000b002cb30f4a342mr6642927ljj.23.1704191158118; Tue, 02
 Jan 2024 02:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213150435.4134390-1-wenst@chromium.org> <20231213150435.4134390-7-wenst@chromium.org>
 <19c98266-0a8e-4e99-8766-cdf31a3a97b6@collabora.com>
In-Reply-To: <19c98266-0a8e-4e99-8766-cdf31a3a97b6@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 2 Jan 2024 18:25:46 +0800
Message-ID: <CAGXv+5E7yzwgEnSUaS3YerK_kcO853AJsq=gBbkWruh86mXbgQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform
 based Tentacruel / Tentacool
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 1, 2024 at 10:09=E2=80=AFPM Eugen Hristev
<eugen.hristev@collabora.com> wrote:
>
> Hello Chen-Yu,
>
> There is still some nonconformity with the bindings, please see below:
>
> On 12/13/23 17:04, Chen-Yu Tsai wrote:
> > Tentacruel and Tentacool are MT8186 based Chromebooks based on the
> > Krabby design.
> >
> > Tentacruel, also known as the ASUS Chromebook CM14 Flip CM1402F, is a
> > convertible device with touchscreen and stylus.
> >
> > Tentacool, also known as the ASUS Chromebook CM14 CM1402C, is a laptop
> > device. It does not have a touchscreen or stylus.
> >
> > The two devices both have two variants. The difference is a second
> > source touchpad controller that shares the same address as the original=
,
> > but is incompatible.
> >
> > The extra SKU IDs for the Tentacruel devices map to different sensor
> > components attached to the Embedded Controller. These are not visible
> > to the main processor.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > Changes since v3:
> > - Reorder some properties to conform better to the newly proposed DT
> >   style guidelines
> > - Drop unused labels
> > - Rename bt-sco node name to bt-sco-codec
> > - Drop i2s*-share properties from afe node
> > - Drop aud_gpio_tdm_{on,off} pinctrl nodes
> > - Replace interrupts with interrupts-extended in tpm node
> > - Enable adsp device
> >
> > Changes since v2:
> > - Picked up Conor's ack
> > - Rename touchpad to trackpad
> > - Drop pinctrl properties from trackpad in tentacruel/tentacool second
> >   source trackpad
> >
> > Changes since v1:
> > - Reorder SKU numbers in descending order.
> > - Fixed pinconfig node names
> > - Moved pinctrl-* properties after interrupts-*
> > - Switched to interrupts-extended for external components
> > - Marked ADSP as explicitly disabled, with a comment explaining that it
> >   stalls the system
> > - Renamed "touchpad" to "trackpad"
> > - Dropped bogus "no-laneswap" property from it6505 node
> > - Moved "realtek,jd-src" property to after all the regulator supplies
> > - Switched to macros for MT6366 regulator "regulator-allowed-modes"
> > - Renamed "vgpu" regulator name to allow coupling, with a comment
> >   containing the name used in the design
> > - Renamed "cr50" node name to "tpm"
> > - Moved trackpad_pins reference up to i2c2; workaround for second sourc=
e
> >   component resource sharing.
> > - Fix copyright year
> > - Fixed touchscreen supply name
> > ---
>
> [snip]
>
> > +
> > +&i2c3 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&i2c3_pins>;
> > +     clock-frequency =3D <100000>;
> > +     status =3D "okay";
> > +
> > +     it6505dptx: dp-bridge@5c {
> > +             compatible =3D "ite,it6505";
>
> dp-bridge@5c: '#address-cells', '#size-cells', '#sound-dai-cells' do not =
match any
> of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/display/bridge/ite=
,it6505.yaml#

Will add a patch to update the bindings.

> > +             reg =3D <0x5c>;
> > +             interrupts-extended =3D <&pio 8 IRQ_TYPE_LEVEL_LOW>;
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&it6505_pins>;
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
>
> /soc/i2c@1100f000/dp-bridge@5c: unnecessary #address-cells/#size-cells wi=
thout
> "ranges" or child "reg" property

Dropped.

> > +             #sound-dai-cells =3D <0>;
> > +             ovdd-supply =3D <&mt6366_vsim2_reg>;
> > +             pwr18-supply =3D <&pp1800_dpbrdg_dx>;
> > +             reset-gpios =3D <&pio 177 GPIO_ACTIVE_HIGH>;
> > +
> > +             ports {
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     port@0 {
> > +                             reg =3D <0>;
> > +
> > +                             it6505_in: endpoint {
> > +                                     link-frequencies =3D /bits/ 64 <1=
50000000>;
> > +                                     remote-endpoint =3D <&dpi_out>;
> > +                             };
> > +                     };
> > +
> > +                     port@1 {
> > +                             reg =3D <1>;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
>
> [snip]
>
> > +&spi1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&spi1_pins>;
> > +     mediatek,pad-select =3D <0>;
> > +     status =3D "okay";
> > +
> > +     cros_ec: ec@0 {
> > +             compatible =3D "google,cros-ec-spi";
> > +             reg =3D <0>;
> > +             interrupts-extended =3D <&pio 13 IRQ_TYPE_LEVEL_LOW>;
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&ec_ap_int>;
> > +             spi-max-frequency =3D <1000000>;
> > +
> > +             i2c_tunnel: i2c-tunnel {
> > +                     compatible =3D "google,cros-ec-i2c-tunnel";
> > +                     google,remote-bus =3D <1>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +
> > +             typec {
> > +                     compatible =3D "google,cros-ec-typec";
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     usb_c0: connector@0 {
> > +                             compatible =3D "usb-c-connector";
> > +                             reg =3D <0>;
> > +                             label =3D "left";
> > +                             power-role =3D "dual";
> > +                             data-role =3D "host";
> > +                             try-power-role =3D "source";
> > +
> > +                             ports {
> > +                                     #address-cells =3D <1>;
> > +                                     #size-cells =3D <0>;
> > +
> typec:connector@0:ports: 'port@0' is a required property
> > +                                     port@1 {
> > +                                             reg =3D <1>;
> > +
> > +                                             typec_port0: endpoint { }=
;
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     usb_c1: connector@1 {
> > +                             compatible =3D "usb-c-connector";
> > +                             reg =3D <1>;
> > +                             label =3D "right";
> > +                             power-role =3D "dual";
> > +                             data-role =3D "host";
> > +                             try-power-role =3D "source";
> > +
> > +                             ports {
> connector@1: Unevaluated properties are not allowed ('ports' was unexpect=
ed)
>         from schema $id: http://devicetree.org/schemas/connector/usb-conn=
ector.yaml#

Not sure why this is happening. Maybe because the sub-schema validation
failed?

In any case, I will drop the whole ports section. This can be re-added once
all the type-C mux stuff has been sorted out.

> > +                                     #address-cells =3D <1>;
> > +                                     #size-cells =3D <0>;
> > +
> > +                                     port@1 {
> connector@0: ports: 'port@0' is a required property
> > +                                             reg =3D <1>;
> > +
> > +                                             typec_port1: endpoint { }=
;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +};
> > +
>
> [snip]
>
> > +
> > +&usb_host1 {
> > +     #address-cells =3D <2>;
> > +     #size-cells =3D <2>;
>
>  usb@11281000: usb@11280000:#address-cells:0:0: 1 was expected
>         from schema $id: http://devicetree.org/schemas/usb/mediatek,mtu3.=
yaml#
> usb@11281000: usb@11280000:#size-cells:0:0: 0 was expected

Dropped.

> > +     vbus-supply =3D <&usb_p1_vbus>;
> > +     status =3D "okay";
> > +};
> > +
> > +&watchdog {
> > +     mediatek,reset-by-toprgu;
> > +};
> > +
> > +#include <arm/cros-ec-keyboard.dtsi>
> > +#include <arm/cros-ec-sbs.dtsi>
>
>
> Eugen

Thanks for the review. Since the merge window is just around the corner,
I will send a new version later this month.

ChenYu


Return-Path: <linux-kernel+bounces-149300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77588A8F19
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA8B2828B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FB886158;
	Wed, 17 Apr 2024 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUvqalSF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923048563C;
	Wed, 17 Apr 2024 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395056; cv=none; b=CIEk5DIi5cNIISgQOhlWR9zQbL33RPV79Q1VvYzNvc+Dw4azw2ETqAc8977YBQzEkHqxhXtin2JIS7fmQWkJbBhNs15kZNpohkIr9QpDKJ/5cm/3ggDPxEDx24Ovu3ou7UbNOMF+2dhFRG26GDp8ld9cRg+/SO3FSuL48FBEhP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395056; c=relaxed/simple;
	bh=DleZPmzIjopdcwuK5ScXde4KztmrAG+BSDTdahj4F34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWReTn63Aby50qvM/MrrZG/30m9jSOlGJcZyCymy/YGJVPw2Gg9+flcTZyp4E39LNl6D6JnWaJY2ZNVSb842PLmb9bCLl9IFaEAz/SvQnXfeeZE/WwRKw+md1dfJGJdu7Tr9+wMQyIbncGyrSXIxN4X1dlUJlLU2ltNMLDFumVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUvqalSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C76C32786;
	Wed, 17 Apr 2024 23:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713395056;
	bh=DleZPmzIjopdcwuK5ScXde4KztmrAG+BSDTdahj4F34=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KUvqalSFcV7qWl7RPj4p2dAkP/ZOE6htLrjxrb2m0xtesPjAe9AGjsdAf/e8gdlh9
	 2n+mYf8ezjDn8uv/EPeEQBJv07PBMJdceCeuoRZSpYO9oRHNdk9YD+jF5WMgdKkaVK
	 M1ckHynpWJhOrhmQ2gZL22DrtoGLRrt3e5sDPXG/8trJnobsdOl8ybkWTfdeiC6iMI
	 U0u1isSfwpqkWSpy/4+KGRsQv2SA4nYmIKChisqswmIqB00MPbzA/8Jl/vlXmOw8qp
	 qa6z+ljwKUoQf7Y0efhRhv0mP1YBFpxmW/8BmeiIIPhafgKyF9NiiyJV1pdoq4Cw4/
	 l1KZ78OyuGztA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d8764656so47041e87.1;
        Wed, 17 Apr 2024 16:04:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYYLY8L62q81DIGuL+i/gKUl07G61vBS1DvGn/O2faXG5pLdYeQJdiJfjg4gnQXKcPw0LuAKhNXrPZ8Vby/RABHc0cvZuKtZn2EnnbMszvE8eePvIDIfTkPfm9DcbhqOgDPwxg7c8R3Vnuh6ST1Fl/1/a5GOpDxU22fG8yDlAiQO0ZN8gXksM9345o7Bmku9nsXT2KO2nohKlmcs98/T0xjQ==
X-Gm-Message-State: AOJu0Ywar3TTneXVE8e4BaLrPVBXv3cuRwgR+i4CnsJhunMPABFLdjYE
	P7jndSvl6aNvwv1bRAHKGN3QX2NVsolg8MZax5idm7W8vb15w2NtsU/ELcCJJEGCnVU5Zej4vsK
	n/593K9i13mMnvm7r6sPo0nwOUHM=
X-Google-Smtp-Source: AGHT+IFynaJ23hI7LhBWah3AipQ/kHcj/2JC6nvWkyzyNtZt6uqnI9CxfUUV/FX4nKwOeNmYWCU+4a78uhTwgWEFRTk=
X-Received: by 2002:ac2:51bc:0:b0:519:592d:adcd with SMTP id
 f28-20020ac251bc000000b00519592dadcdmr335876lfk.3.1713395054395; Wed, 17 Apr
 2024 16:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412073046.1192744-1-wenst@chromium.org> <20240412073046.1192744-2-wenst@chromium.org>
In-Reply-To: <20240412073046.1192744-2-wenst@chromium.org>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 17 Apr 2024 16:04:02 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzp=MKNYc70ZeGCAEgWfFVPOAOZQQ86BXukk+EQQM_C+OA@mail.gmail.com>
Message-ID: <CAGp9Lzp=MKNYc70ZeGCAEgWfFVPOAOZQQ86BXukk+EQQM_C+OA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chen-Yu,

On Fri, Apr 12, 2024 at 12:31=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> The MediaTek MT7921S is a WiFi/Bluetooth combo chip that works over
> SDIO. WiFi and Bluetooth are separate SDIO functions within the chip.
> While the Bluetooth SDIO function is fully discoverable, the chip has
> a pin that can reset just the Bluetooth core, as opposed to the full
> chip. This should be described in the device tree.
>
> Add a device tree binding for the Bluetooth SDIO function of the MT7921S
> specifically to document the reset line. This binding is based on the MMC
> controller binding, which specifies one device node per SDIO function.
>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v2:
> - Expand description and commit message to clearly state that WiFi and
>   Bluetooth are separate SDIO functions, and that each function should
>   be a separate device node, as specified by the MMC binding.
> - Change 'additionalProperties' to 'unevaluatedProperties'
> - Add missing separating new line
> - s/ot/to/
>
> Angelo's reviewed-by was not picked up due to the above changes.
>
> Changes since v1:
> - Reworded descriptions
> - Moved binding maintainer section before description
> - Added missing reference to bluetooth-controller.yaml
> - Added missing GPIO header to example
> ---
>  .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 55 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/media=
tek,mt7921s-bluetooth.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7=
921s-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/media=
tek,mt7921s-bluetooth.yaml
> new file mode 100644
> index 000000000000..67ff7caad599
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bl=
uetooth.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7921s-blueto=
oth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT7921S Bluetooth
> +
> +maintainers:
> +  - Sean Wang <sean.wang@mediatek.com>
> +
> +description:
> +  MT7921S is an SDIO-attached dual-radio WiFi+Bluetooth Combo chip; each
> +  function is its own SDIO function on a shared SDIO interface. The chip
> +  has two dedicated reset lines, one for each function core.
> +  This binding only covers the Bluetooth SDIO function, with one device
> +  node describing only this SDIO function.
> +
> +allOf:
> +  - $ref: bluetooth-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt7921s-bluetooth
> +
> +  reg:
> +    const: 2
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      An active-low reset line for the Bluetooth core; on typical M.2
> +      key E modules this is the W_DISABLE2# pin.
> +

Thanks for adding the new setup for the MT7921S devices. They look good to =
me.
Sometimes, the MT7921S might be set up to wake up the host when it's
asleep using a sideband signal.
This might need an extra pin called "wakeup" to make it happen. Can
you help add this pin to the settings in the same update, or should I
do it later?

> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    mmc {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        bluetooth@2 {
> +            compatible =3D "mediatek,mt7921s-bluetooth";
> +            reg =3D <2>;
> +            reset-gpios =3D <&pio 8 GPIO_ACTIVE_LOW>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 88981d9f3958..218bc2a21207 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13818,6 +13818,7 @@ M:      Sean Wang <sean.wang@mediatek.com>
>  L:     linux-bluetooth@vger.kernel.org
>  L:     linux-mediatek@lists.infradead.org (moderated for non-subscribers=
)
>  S:     Maintained
> +F:     Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-=
bluetooth.yaml
>  F:     Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
>  F:     drivers/bluetooth/btmtkuart.c
>
> --
> 2.44.0.683.g7961c838ac-goog
>
>


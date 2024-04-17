Return-Path: <linux-kernel+bounces-149323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A558A8F90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472741C20DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A65F129A7F;
	Wed, 17 Apr 2024 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebHDLHww"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3A81748;
	Wed, 17 Apr 2024 23:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713397313; cv=none; b=EwTnulc5nhmTOOk6yQscSbTvP5bfZT3aHIPX8z13V6J+SWxpAty8eUcoYuj6++UcjgQgNvmPePb1K38CHE5LPf7GQAVpF31ZDRTEKKj5fWfBrxIoyh0bS7n+dOl02k7m4tlGPW6R1g51SYbOsU/N5ONXEbhij7kInXpPcB0EXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713397313; c=relaxed/simple;
	bh=Nfp4Bt/UB3lYOjUFF0rfs/aN8U0aosIdPb074abhs2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5rj/chMcuQPYBb9GbQ9DqkKbzusvcADg9T4XPIcrJDVQc/PW/ISMbToB9mJeHu9hPJxVX6Cv4JZctO2ozD59ZATIux5SuVrwvBnPx6RpqbNa8P0UjhNYgLQghi7fnTIZOSJsWhVhnYCKh0/SrEo071tY6vv/2b2u+34fONNft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebHDLHww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD35C3277B;
	Wed, 17 Apr 2024 23:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713397312;
	bh=Nfp4Bt/UB3lYOjUFF0rfs/aN8U0aosIdPb074abhs2o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ebHDLHww1sRu0/F4b2uaU6+v4ZNFQlqOEV5l5dHioS9xgrLfSAh/eVxz8a6AmGTcS
	 8sQ069W4VNHVEItjcYazb+m6p2mLxHyjRSuU/fsX5GCr5tMcUnVWhpmb7RAddtbmJr
	 q/KkvTy52wBOq7mNs24PM2PCBd1y8DxKIJXmXhOj2/W1f32qgWnxORCTEj3XFChIDU
	 kvnTh3MQpCj6zD4uCZIkhEgXJeyZCzIuLQo6Pl/HGxTr2A0vGMNHJoIkkIIzCwfkoR
	 ChI/5SoIXiflj+wCDHcjfl/nY0HTRfFlNkJyYylq5531zV4sO8MT1eNgs8I0bobfpX
	 C+NkyTW909qEg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e6583942dso63594a12.1;
        Wed, 17 Apr 2024 16:41:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUs0Hmu6MJQcIPxYBarU3aFPr41rC0n8+g8yWZ15eBIUW1wGBYo+cVZOwhhvSMdpjOGZ5+oZFapChDO/s1+72EnTUaRdB2JSp05evTLtdi5xwUGlpX0EZUwhHOCkYRYD7+t2VWVP+rdbUgnm4vaeuLdeWR2du8IYBo42bxO0K9yw8VeRsOAAG2vQLbLvqCq1nMQ2XhO+5j0QHSNWyh00JHTA==
X-Gm-Message-State: AOJu0YyZpp5LS67JHctIYJFm2cik424UzgaqKgrkQj5C2CIYY0lpyWXa
	RDjTM6i24mTUjyawM2Qzg/87DUsHMuJgvuZ1Ah9goVa19YGD2qU1pU5thSUiYEiTWmw07R2zmwq
	kXVcqTLprhNKwAZATcJ55w4sM48c=
X-Google-Smtp-Source: AGHT+IF4viARxx3GZxQCpGS5aZWzP8rCaswrtzXJWmo/s4eeUGc8cWg9XndNIL6tihZSuLbHwQq+1pEMz/4p7hGte/k=
X-Received: by 2002:a17:906:cd0f:b0:a55:144a:adc2 with SMTP id
 oz15-20020a170906cd0f00b00a55144aadc2mr473106ejb.6.1713397311258; Wed, 17 Apr
 2024 16:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412073046.1192744-1-wenst@chromium.org> <20240412073046.1192744-2-wenst@chromium.org>
 <CAGp9Lzp=MKNYc70ZeGCAEgWfFVPOAOZQQ86BXukk+EQQM_C+OA@mail.gmail.com> <CAGXv+5FeRwYm7x+fYS9KPXW-0tQ-zSuk5nU6AZ-=yU07wXnJ9w@mail.gmail.com>
In-Reply-To: <CAGXv+5FeRwYm7x+fYS9KPXW-0tQ-zSuk5nU6AZ-=yU07wXnJ9w@mail.gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 17 Apr 2024 16:41:39 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzrm6GDdm61FZR60aqmnSVg7k1+NJ=UfNwr6x8Y5RUwOKA@mail.gmail.com>
Message-ID: <CAGp9Lzrm6GDdm61FZR60aqmnSVg7k1+NJ=UfNwr6x8Y5RUwOKA@mail.gmail.com>
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

okay, we will add it once we have implemented it in the driver. thanks
for adding the dt-binding.

     Sean

On Wed, Apr 17, 2024 at 4:32=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Wed, Apr 17, 2024 at 4:04=E2=80=AFPM Sean Wang <sean.wang@kernel.org> =
wrote:
> >
> > Hi Chen-Yu,
> >
> > On Fri, Apr 12, 2024 at 12:31=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.o=
rg> wrote:
> > >
> > > The MediaTek MT7921S is a WiFi/Bluetooth combo chip that works over
> > > SDIO. WiFi and Bluetooth are separate SDIO functions within the chip.
> > > While the Bluetooth SDIO function is fully discoverable, the chip has
> > > a pin that can reset just the Bluetooth core, as opposed to the full
> > > chip. This should be described in the device tree.
> > >
> > > Add a device tree binding for the Bluetooth SDIO function of the MT79=
21S
> > > specifically to document the reset line. This binding is based on the=
 MMC
> > > controller binding, which specifies one device node per SDIO function=
.
> > >
> > > Cc: Sean Wang <sean.wang@mediatek.com>
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > ---
> > > Changes since v2:
> > > - Expand description and commit message to clearly state that WiFi an=
d
> > >   Bluetooth are separate SDIO functions, and that each function shoul=
d
> > >   be a separate device node, as specified by the MMC binding.
> > > - Change 'additionalProperties' to 'unevaluatedProperties'
> > > - Add missing separating new line
> > > - s/ot/to/
> > >
> > > Angelo's reviewed-by was not picked up due to the above changes.
> > >
> > > Changes since v1:
> > > - Reworded descriptions
> > > - Moved binding maintainer section before description
> > > - Added missing reference to bluetooth-controller.yaml
> > > - Added missing GPIO header to example
> > > ---
> > >  .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 55 +++++++++++++++++=
++
> > >  MAINTAINERS                                   |  1 +
> > >  2 files changed, 56 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/m=
ediatek,mt7921s-bluetooth.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek=
,mt7921s-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/m=
ediatek,mt7921s-bluetooth.yaml
> > > new file mode 100644
> > > index 000000000000..67ff7caad599
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921=
s-bluetooth.yaml
> > > @@ -0,0 +1,55 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7921s-bl=
uetooth.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: MediaTek MT7921S Bluetooth
> > > +
> > > +maintainers:
> > > +  - Sean Wang <sean.wang@mediatek.com>
> > > +
> > > +description:
> > > +  MT7921S is an SDIO-attached dual-radio WiFi+Bluetooth Combo chip; =
each
> > > +  function is its own SDIO function on a shared SDIO interface. The =
chip
> > > +  has two dedicated reset lines, one for each function core.
> > > +  This binding only covers the Bluetooth SDIO function, with one dev=
ice
> > > +  node describing only this SDIO function.
> > > +
> > > +allOf:
> > > +  - $ref: bluetooth-controller.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - mediatek,mt7921s-bluetooth
> > > +
> > > +  reg:
> > > +    const: 2
> > > +
> > > +  reset-gpios:
> > > +    maxItems: 1
> > > +    description:
> > > +      An active-low reset line for the Bluetooth core; on typical M.=
2
> > > +      key E modules this is the W_DISABLE2# pin.
> > > +
> >
> > Thanks for adding the new setup for the MT7921S devices. They look good=
 to me.
> > Sometimes, the MT7921S might be set up to wake up the host when it's
> > asleep using a sideband signal.
> > This might need an extra pin called "wakeup" to make it happen. Can
> > you help add this pin to the settings in the same update, or should I
> > do it later?
>
> I suggest you send a patch on top of this one? I'm not sure if you
> would model it as a GPIO or interrupt. And there doesn't seem to be
> any code in the driver expecting it.
>
>
> ChenYu
>
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +
> > > +    mmc {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        bluetooth@2 {
> > > +            compatible =3D "mediatek,mt7921s-bluetooth";
> > > +            reg =3D <2>;
> > > +            reset-gpios =3D <&pio 8 GPIO_ACTIVE_LOW>;
> > > +        };
> > > +    };
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 88981d9f3958..218bc2a21207 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -13818,6 +13818,7 @@ M:      Sean Wang <sean.wang@mediatek.com>
> > >  L:     linux-bluetooth@vger.kernel.org
> > >  L:     linux-mediatek@lists.infradead.org (moderated for non-subscri=
bers)
> > >  S:     Maintained
> > > +F:     Documentation/devicetree/bindings/net/bluetooth/mediatek,mt79=
21s-bluetooth.yaml
> > >  F:     Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> > >  F:     drivers/bluetooth/btmtkuart.c
> > >
> > > --
> > > 2.44.0.683.g7961c838ac-goog
> > >
> > >


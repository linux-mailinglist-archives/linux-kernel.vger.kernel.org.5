Return-Path: <linux-kernel+bounces-157970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109AA8B1986
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9DD282BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CF32557F;
	Thu, 25 Apr 2024 03:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwdIshM2"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C42231C;
	Thu, 25 Apr 2024 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015696; cv=none; b=VBMjZX16X5P/Ze7K4cOGRBr5HwzlK7y7kwzyxds7Lgq3QEPA5EIebwVV/QQe+/43d0pbL4me6BbPunK6U6M6msBQTTB3+NEhAI7aGDvs5bh26ftpdQWe4EI/KHTBvxHCzG+lDlvtwJxb5R4JSJAtUVH7E4qKdiv2MMUCcnndNto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015696; c=relaxed/simple;
	bh=1qg/u+CmvKrQQ3bC0nSSHWL+jArAdi4OYzQyrcTeLfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYMWW9FlKQ4hCxFQH9z8ROadazIdb1ecJAtfnSHS2rGgSPdoIb0K3jq2tbytKV426qkANEuU/3/3XUYW90t1DKkeqW4MpIGdz5N3BbifeVSfo2LlacHlrYAmd3QD06nGkgmnSF2Zy54Oo2xiS2LsVVpueVJ/fUR8LndPtJmxDVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwdIshM2; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36c1a6362a4so2754555ab.2;
        Wed, 24 Apr 2024 20:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714015694; x=1714620494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpkcl7FDpB9iuJiZqGM4IkCYObnHqgbxV1tkOCE2UEE=;
        b=BwdIshM2nfgLcIbOlo0rKbhHBoTlYH8DXXCojtlvDUuRbNR+EwLRFy9HbgajVudH2R
         OUDhMfdRlVnuWA32imvCENa0GfpE+H8/sHKI6I85gUqTRLr9BcK1Ney076DTpz4yLUYQ
         UjXqOcoBzjg+51DagsyaIIv2ZoDrAmPXVm/D+goPzOHtrJamBRalWUXU4O5BrORJfkDa
         kR5O7Kr8VaB2205VkuhEBxLViDlS4roSKmsahtvyh3zpjegwbjuCdmNKFoLJZeZeW00U
         DJruiwZ7njnJf1xWzpqpeTbcuR2aJImw9Q2LBKx7gZCQOBiNrE78+nysmbdPp0k3TiYf
         evvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714015694; x=1714620494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpkcl7FDpB9iuJiZqGM4IkCYObnHqgbxV1tkOCE2UEE=;
        b=Gjl0Mlbk38Oilaf4gh8uYuRRH5G1YnTDDohAvGTP1czX0uAdR1Y1h4Gk5/FP6t7cwW
         3Dm+66dK7SRTVkx3S16hk4hiGQCJYtfMHEfuJGPr1cITGhQ3DTrqAjW4jHIZlNYV4GMz
         1bxQWTleJ6VElZou81UTMNE2PT7cguTDDxuVBZ6u2Z4ZGxprn6kUEBfjIG+5nH7ldcx+
         OJOQGqaScxzzyCbRDcuMfGBZ44oYEZRW6q5+b9HW2BwQqVTJD92K/fx8EW8uSAVQI1bZ
         +ehlSO4ZMWmAMyH0IRdraeCatZmgBfbJcPVvuTlZDWfjeXHJSC00ftdWWMwTr7REI/N7
         fSvw==
X-Forwarded-Encrypted: i=1; AJvYcCUTVqBcxTZl394f93n8OKJvCG7PTo1rFgXka7d+yXRPUKmnZ/kBHntC95Ojlw/qTvH3TCIJQCaj04c1DwVwO0OpeYwc9t0WWoYHu/rYa5YoPkbdODE1bgo1wzSjgnyUs+FLEsxm4VLECh6wBRNCHLcEb3SyeezWMOPE7RX5MycdKIp+nAYC
X-Gm-Message-State: AOJu0YwwgTLgmy8jLSx35QdXjFy/VkQVSiOvn6S83q6FHqgwa66GaVhW
	jC7gvx1y5jUg/YOSaqY3EKrLKiXd22kGooT/NpbQs7NQsKzHMsu8Cip7SWlZbWqs6wUBv+iRUTV
	zKrjavwa+9vNYbsJ2LE74jaj43yE=
X-Google-Smtp-Source: AGHT+IGlXygE9UzrbNpMVVKGHhw27MOQN3YoueGJc1JA+8GN311b98f3Wj0i7+UWE5MFVAOe75CZFHF44dqLB+eqPjs=
X-Received: by 2002:a05:6e02:160e:b0:36a:36ee:339f with SMTP id
 t14-20020a056e02160e00b0036a36ee339fmr5856729ilu.23.1714015693867; Wed, 24
 Apr 2024 20:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713764894-11870-1-git-send-email-shengjiu.wang@nxp.com> <20240423142412.GA138232-robh@kernel.org>
In-Reply-To: <20240423142412.GA138232-robh@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 25 Apr 2024 11:28:02 +0800
Message-ID: <CAA+D8ANnBwL+gp5n=a+oZjqS0tvTwsFtWY8zREGkzE-E9-ndSA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: fsl,ssi: Convert to YAML
To: Rob Herring <robh@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com, broonie@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 10:24=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Mon, Apr 22, 2024 at 01:48:14PM +0800, Shengjiu Wang wrote:
> > Convert the fsl,ssi binding to YAML.
> >
> > Add below compatible strings which were not listed
> > in document:
> >
> > fsl,imx50-ssi
> > fsl,imx53-ssi
> > fsl,imx25-ssi
> > fsl,imx27-ssi
> > fsl,imx6q-ssi
> > fsl,imx6sl-ssi
> > fsl,imx6sx-ssi
> >
> > Add below fsl,mode strings which were not listed.
> >
> > i2s-slave
> > i2s-master
> > lj-slave
> > lj-master
> > rj-slave
> > rj-master
> >
> > Add 'ac97-gpios' property which were not listed.
> > Then dtbs_check can pass.
> >
> > And remove the 'codec' description which should be
> > in the 'codec' binding doc.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> > changes in v2:
> > - change fallback string to const.
> > - add dai-common.yaml
> > - add ac97-gpios property
> >
> >  .../devicetree/bindings/sound/fsl,ssi.txt     |  87 --------
> >  .../devicetree/bindings/sound/fsl,ssi.yaml    | 192 ++++++++++++++++++
> >  2 files changed, 192 insertions(+), 87 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/sound/fsl,ssi.txt
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,ssi.yam=
l
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Docu=
mentation/devicetree/bindings/sound/fsl,ssi.txt
> > deleted file mode 100644
> > index 7e15a85cecd2..000000000000
> > --- a/Documentation/devicetree/bindings/sound/fsl,ssi.txt
> > +++ /dev/null
> > @@ -1,87 +0,0 @@
> > -Freescale Synchronous Serial Interface
> > -
> > -The SSI is a serial device that communicates with audio codecs.  It ca=
n
> > -be programmed in AC97, I2S, left-justified, or right-justified modes.
> > -
> > -Required properties:
> > -- compatible:       Compatible list, should contain one of the followi=
ng
> > -                    compatibles:
> > -                      fsl,mpc8610-ssi
> > -                      fsl,imx51-ssi
> > -                      fsl,imx35-ssi
> > -                      fsl,imx21-ssi
> > -- cell-index:       The SSI, <0> =3D SSI1, <1> =3D SSI2, and so on.
> > -- reg:              Offset and length of the register set for the devi=
ce.
> > -- interrupts:       <a b> where a is the interrupt number and b is a
> > -                    field that represents an encoding of the sense and
> > -                    level information for the interrupt.  This should =
be
> > -                    encoded based on the information in section 2)
> > -                    depending on the type of interrupt controller you
> > -                    have.
> > -- fsl,fifo-depth:   The number of elements in the transmit and receive=
 FIFOs.
> > -                    This number is the maximum allowed value for SFCSR=
[TFWM0].
> > - - clocks:          "ipg" - Required clock for the SSI unit
> > -                    "baud" - Required clock for SSI master mode. Other=
wise this
> > -                   clock is not used
> > -
> > -Required are also ac97 link bindings if ac97 is used. See
> > -Documentation/devicetree/bindings/sound/soc-ac97link.txt for the neces=
sary
> > -bindings.
> > -
> > -Optional properties:
> > -- codec-handle:     Phandle to a 'codec' node that defines an audio
> > -                    codec connected to this SSI.  This node is typical=
ly
> > -                    a child of an I2C or other control node.
> > -- fsl,fiq-stream-filter: Bool property. Disabled DMA and use FIQ inste=
ad to
> > -                 filter the codec stream. This is necessary for some b=
oards
> > -                 where an incompatible codec is connected to this SSI,=
 e.g.
> > -                 on pca100 and pcm043.
> > -- dmas:                  Generic dma devicetree binding as described i=
n
> > -                 Documentation/devicetree/bindings/dma/dma.txt.
> > -- dma-names:     Two dmas have to be defined, "tx" and "rx", if fsl,im=
x-fiq
> > -                 is not defined.
> > -- fsl,mode:         The operating mode for the AC97 interface only.
> > -                    "ac97-slave" - AC97 mode, SSI is clock slave
> > -                    "ac97-master" - AC97 mode, SSI is clock master
> > -- fsl,ssi-asynchronous:
> > -                    If specified, the SSI is to be programmed in async=
hronous
> > -                    mode.  In this mode, pins SRCK, STCK, SRFS, and ST=
FS must
> > -                    all be connected to valid signals.  In synchronous=
 mode,
> > -                    SRCK and SRFS are ignored.  Asynchronous mode allo=
ws
> > -                    playback and capture to use different sample sizes=
 and
> > -                    sample rates.  Some drivers may require that SRCK =
and STCK
> > -                    be connected together, and SRFS and STFS be connec=
ted
> > -                    together.  This would still allow different sample=
 sizes,
> > -                    but not different sample rates.
> > -- fsl,playback-dma: Phandle to a node for the DMA channel to use for
> > -                    playback of audio.  This is typically dictated by =
SOC
> > -                    design.  See the notes below.
> > -                    Only used on Power Architecture.
> > -- fsl,capture-dma:  Phandle to a node for the DMA channel to use for
> > -                    capture (recording) of audio.  This is typically d=
ictated
> > -                    by SOC design.  See the notes below.
> > -                    Only used on Power Architecture.
> > -
> > -Child 'codec' node required properties:
> > -- compatible:       Compatible list, contains the name of the codec
> > -
> > -Child 'codec' node optional properties:
> > -- clock-frequency:  The frequency of the input clock, which typically =
comes
> > -                    from an on-board dedicated oscillator.
> > -
> > -Notes on fsl,playback-dma and fsl,capture-dma:
> > -
> > -On SOCs that have an SSI, specific DMA channels are hard-wired for pla=
yback
> > -and capture.  On the MPC8610, for example, SSI1 must use DMA channel 0=
 for
> > -playback and DMA channel 1 for capture.  SSI2 must use DMA channel 2 f=
or
> > -playback and DMA channel 3 for capture.  The developer can choose whic=
h
> > -DMA controller to use, but the channels themselves are hard-wired.  Th=
e
> > -purpose of these two properties is to represent this hardware design.
> > -
> > -The device tree nodes for the DMA channels that are referenced by
> > -"fsl,playback-dma" and "fsl,capture-dma" must be marked as compatible =
with
> > -"fsl,ssi-dma-channel".  The SOC-specific compatible string (e.g.
> > -"fsl,mpc8610-dma-channel") can remain.  If these nodes are left as
> > -"fsl,elo-dma-channel" or "fsl,eloplus-dma-channel", then the generic E=
lo DMA
> > -drivers (fsldma) will attempt to use them, and it will conflict with t=
he
> > -sound drivers.
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.yaml b/Doc=
umentation/devicetree/bindings/sound/fsl,ssi.yaml
> > new file mode 100644
> > index 000000000000..d22911b0e9ef
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl,ssi.yaml
> > @@ -0,0 +1,192 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/fsl,ssi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale Synchronous Serial Interface
> > +
> > +maintainers:
> > +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> > +
> > +description:
> > +  Notes on fsl,playback-dma and fsl,capture-dma
> > +  On SOCs that have an SSI, specific DMA channels are hard-wired for p=
layback
> > +  and capture.  On the MPC8610, for example, SSI1 must use DMA channel=
 0 for
> > +  playback and DMA channel 1 for capture.  SSI2 must use DMA channel 2=
 for
> > +  playback and DMA channel 3 for capture.  The developer can choose wh=
ich
> > +  DMA controller to use, but the channels themselves are hard-wired.  =
The
> > +  purpose of these two properties is to represent this hardware design=
.
> > +
> > +  The device tree nodes for the DMA channels that are referenced by
> > +  "fsl,playback-dma" and "fsl,capture-dma" must be marked as compatibl=
e with
> > +  "fsl,ssi-dma-channel".  The SOC-specific compatible string (e.g.
> > +  "fsl,mpc8610-dma-channel") can remain.  If these nodes are left as
> > +  "fsl,elo-dma-channel" or "fsl,eloplus-dma-channel", then the generic=
 Elo DMA
> > +  drivers (fsldma) will attempt to use them, and it will conflict with=
 the
> > +  sound drivers.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - fsl,imx50-ssi
> > +              - fsl,imx53-ssi
> > +          - enum:
> > +              - fsl,imx51-ssi
>
> const
>
> > +          - const: fsl,imx21-ssi
> > +      - items:
> > +          - enum:
> > +              - fsl,imx25-ssi
> > +              - fsl,imx27-ssi
> > +              - fsl,imx35-ssi
> > +              - fsl,imx51-ssi
> > +              - fsl,imx6q-ssi
> > +              - fsl,imx6sl-ssi
> > +              - fsl,imx6sx-ssi
> > +          - enum:
> > +              - fsl,imx21-ssi
> > +              - fsl,imx51-ssi
>
> Fallbacks cannot be enum's. You need to split this into 2. Also, there's
> no valid entry for "fsl,imx21-ssi".
>
> It also doesn't make sense that sometimes mx21 is a fallback of mx51,
> but then sometimes the last fallback is mx51.
>
> > +      - items:
> > +          - const: fsl,mpc8610-ssi
> > +
> > +  cell-index:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2]
> > +    description: The SSI index
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  fsl,fifo-depth:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      The number of elements in the transmit and receive FIFOs.
> > +      This number is the maximum allowed value for SFCSR[TFWM0].
>
> Ordering is standard properties first (like 'clocks') and then vendor
> specific properties last.
>
> You need some constraints on the fsl,fifo-depth values.
>
> > +
> > +  clocks:
> > +    items:
> > +      - description: The ipg clock for register access
> > +      - description: clock for SSI master mode
> > +    minItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: ipg
> > +      - const: baud
> > +    minItems: 1
> > +
> > +  dmas:
> > +    oneOf:
> > +      - items:
> > +          - description: DMA controller phandle and request line for R=
X
> > +          - description: DMA controller phandle and request line for T=
X
> > +      - items:
> > +          - description: DMA controller phandle and request line for R=
X0
> > +          - description: DMA controller phandle and request line for T=
X0
> > +          - description: DMA controller phandle and request line for R=
X1
> > +          - description: DMA controller phandle and request line for T=
X1
> > +
> > +  dma-names:
> > +    oneOf:
> > +      - items:
> > +          - const: rx
> > +          - const: tx
> > +      - items:
> > +          - const: rx0
> > +          - const: tx0
> > +          - const: rx1
> > +          - const: tx1
> > +
> > +  codec-handle:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to a 'codec' node that defines an audio
> > +      codec connected to this SSI.  This node is typically
> > +      a child of an I2C or other control node.
> > +
> > +  fsl,fiq-stream-filter:
> > +    type: boolean
> > +    description:
> > +      Disabled DMA and use FIQ instead to filter the codec stream.
> > +      This is necessary for some boards where an incompatible codec
> > +      is connected to this SSI, e.g. on pca100 and pcm043.
> > +
> > +  fsl,mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [ ac97-slave, ac97-master, i2s-slave, i2s-master,
> > +            lj-slave, lj-master, rj-slave, rj-master ]
> > +    description: |
> > +      "ac97-slave" - AC97 mode, SSI is clock slave
> > +      "ac97-master" - AC97 mode, SSI is clock master
> > +      "i2s-slave" - I2S mode, SSI is clock slave
> > +      "i2s-master" - I2S mode, SSI is clock master
> > +      "lj-slave" - Left justified mode, SSI is clock slave
> > +      "lj-master" - Left justified mode, SSI is clock master
> > +      "rj-slave" - Right justified mode, SSI is clock slave
> > +      "rj-master" - Right justified mode, SSI is clock master
> > +
> > +  fsl,ssi-asynchronous:
> > +    type: boolean
> > +    description: If specified, the SSI is to be programmed in asynchro=
nous
> > +      mode.  In this mode, pins SRCK, STCK, SRFS, and STFS must
> > +      all be connected to valid signals.  In synchronous mode,
> > +      SRCK and SRFS are ignored.  Asynchronous mode allows
> > +      playback and capture to use different sample sizes and
> > +      sample rates.  Some drivers may require that SRCK and STCK
> > +      be connected together, and SRFS and STFS be connected
> > +      together.  This would still allow different sample sizes,
> > +      but not different sample rates.
> > +
> > +  fsl,playback-dma:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Phandle to a node for the DMA channel to use for
> > +      playback of audio.  This is typically dictated by SOC
> > +      design. Only used on Power Architecture.
> > +
> > +  fsl,capture-dma:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Phandle to a node for the DMA channel to use for
> > +      capture (recording) of audio.  This is typically dictated
> > +      by SOC design. Only used on Power Architecture.
> > +
> > +  ac97-gpios:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: Please refer to soc-ac97link.txt
> > +
> > +  "#sound-dai-cells":
> > +    const: 0
> > +    description: optional, some dts node didn't add it.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - fsl,fifo-depth
> > +
> > +allOf:
> > +  - $ref: dai-common.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/imx6qdl-clock.h>
> > +    ssi1: ssi@2028000 {
>
> Drop unused labels.
> > +        compatible =3D "fsl,imx6q-ssi",
> > +                     "fsl,imx51-ssi";
>
> This fits on 1 line.

Thanks for the comments,  I will update them accordingly.

Best regards
Shengjiu Wang

>
> > +        reg =3D <0x02028000 0x4000>;
> > +        interrupts =3D <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&clks IMX6QDL_CLK_SSI1_IPG>,
> > +                 <&clks IMX6QDL_CLK_SSI1>;
> > +        clock-names =3D "ipg", "baud";
> > +        dmas =3D <&sdma 37 1 0>, <&sdma 38 1 0>;
> > +        dma-names =3D "rx", "tx";
> > +        #sound-dai-cells =3D <0>;
> > +        fsl,fifo-depth =3D <15>;
> > +    };
> > --
> > 2.34.1
> >


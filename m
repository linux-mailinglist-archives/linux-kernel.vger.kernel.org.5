Return-Path: <linux-kernel+bounces-95685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 717D1875142
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117381F25BD4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF47512FB21;
	Thu,  7 Mar 2024 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILYfLqv6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACE12FB00;
	Thu,  7 Mar 2024 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820222; cv=none; b=DVdMgUETPJ6UuUG8L4uTLhaQZcNp39k+Lc2wWUtF/wI2tuYmW5zikrAWe/UP/FvUZ2hIPFum8F89gK1szeeLM0rKU66dSjTTB8Hx7WDu9nvVsxQo2Z04rNQ/LiCSkZOIeA373jIZS+fzOOOFJgt5t8FQeOj3v1lGWYJ2xmGvOtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820222; c=relaxed/simple;
	bh=BT6wZ8BkYsfqnC5k7BF68W2twgRaf3YZsPmPjxc0vlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/WCJxMfVHQd2O2D+YEh4bx0Bb57C+78mzMqrpiPwQ9z4+eb+b59MqiyOEcCQYyHGtWBmKfrcM3XUy4cGSh/iZqNSGCSLFtqXCrR/foUr7hTjlyvBdTvusCTEntD1YRmQpI/kFNAqSyojKHvIeVxCUveZPhZXfIeQe8YLLSKxgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILYfLqv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DF3C433F1;
	Thu,  7 Mar 2024 14:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709820222;
	bh=BT6wZ8BkYsfqnC5k7BF68W2twgRaf3YZsPmPjxc0vlo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ILYfLqv6AdPmF8HKRsSyjdF8gEF+6ZbG9ncnMQ9J9FOqXbT3wrHjj8dBiJbShKWya
	 YMtlJMOChfzz+ZW2bZYBbKzfo0aF3tlK4nMr2hHltakqhddL/ci7yH175k4DFaYfOd
	 zJ1CfuuzJlEQfuJy1iOWsErkhdJbm3eEP2KZ9DGtoXWULXpjGu2+aIQybusyNZvwcC
	 gtDLmQ1hB5/0faXfl/eg2uiFZUvYywt/JtCQBR73nG4iAmMkZ1z7V4ncUiOtKKCYZu
	 N3bwr/oC7GVd7z4VqW6VazSZYvpP0lQzx6On7bPAwcoak+SPNwHIcJlOh/5hDEggm6
	 GH7I5icGHgGiA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d311081954so9855671fa.2;
        Thu, 07 Mar 2024 06:03:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDCEPZz/aggmYdmQl2ULu4cU8PcASfjYtkqYG254+anOKnOnRW+ry4YBBz3aV9Tu23FVeKR6wu0N/E2OLth5uNDuEsB6LmI+yF2aeNxdZjI5dpogj/EYeK4oM4dbKv+tHpSPPtRHzZuPp30XDeCHuFo16vATZFv1xaxg8SL/SaYU31joD3
X-Gm-Message-State: AOJu0Yz/csrow9xvWjMccxI4t0Nf6g4aTYIzFSf0jc3jM7+56SFYEMA8
	KEzgpSpra7mzXoR17F3YkiXYxzL10OfdxdF5I+ijql2cyKpTGWmqI2ZLPx5VjkkSxtuv6Sv3gSP
	5oU2WvNZNOvX0jqCc9Uz/n5JPuw==
X-Google-Smtp-Source: AGHT+IF5Dc5jk0XZHS0IhbnbHN0DQ1ZhYnHDMr7Hbwtb+vashJF0QYaWL7v2IywW1l6pNzIj3tTpk4NskZfQ4ky22lQ=
X-Received: by 2002:a05:6512:1094:b0:513:30fb:d64 with SMTP id
 j20-20020a056512109400b0051330fb0d64mr1862716lfg.44.1709820199915; Thu, 07
 Mar 2024 06:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227120939.290143-1-angelogioacchino.delregno@collabora.com>
 <20240227120939.290143-20-angelogioacchino.delregno@collabora.com>
 <20240304142341.GA156846-robh@kernel.org> <0aa3dc07-67c8-40a4-9e83-f702979765c5@collabora.com>
In-Reply-To: <0aa3dc07-67c8-40a4-9e83-f702979765c5@collabora.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 7 Mar 2024 08:03:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLNsS_Rx5z5F1vrYbr2g+5-wGYOq6mhtfUd7Db11F0W+Q@mail.gmail.com>
Message-ID: <CAL_JsqLNsS_Rx5z5F1vrYbr2g+5-wGYOq6mhtfUd7Db11F0W+Q@mail.gmail.com>
Subject: Re: [PATCH 19/22] ASoC: dt-bindings: mt8192: Document audio-routing
 and dai-link subnode
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: broonie@kernel.org, wenst@chromium.org, lgirdwood@gmail.com, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com, 
	trevor.wu@mediatek.com, maso.huang@mediatek.com, 
	xiazhengqiao@huaqin.corp-partner.google.com, arnd@arndb.de, 
	kuninori.morimoto.gx@renesas.com, shraash@google.com, amergnat@baylibre.com, 
	nicolas.ferre@microchip.com, u.kleine-koenig@pengutronix.de, 
	dianders@chromium.org, frank.li@vivo.com, allen-kh.cheng@mediatek.com, 
	eugen.hristev@collabora.com, claudiu.beznea@tuxon.dev, 
	jarkko.nikula@bitmer.com, jiaxin.yu@mediatek.com, alpernebiyasak@gmail.com, 
	ckeepax@opensource.cirrus.com, zhourui@huaqin.corp-partner.google.com, 
	nfraprado@collabora.com, alsa-devel@alsa-project.org, 
	shane.chien@mediatek.com, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 5:20=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 04/03/24 15:23, Rob Herring ha scritto:
> > On Tue, Feb 27, 2024 at 01:09:36PM +0100, AngeloGioacchino Del Regno wr=
ote:
> >> Document the dai-link subnodes and the audio-routing property, allowin=
g
> >> to describe machine specific audio hardware and links in device tree.
> >>
> >> While at it, also deprecate the old properties which were previously
> >> used with the driver's partially hardcoded configuration.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@c=
ollabora.com>
> >> ---
> >>   .../sound/mt8192-mt6359-rt1015-rt5682.yaml    | 129 ++++++++++++++++=
--
> >>   1 file changed, 121 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1=
015-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1=
015-rt5682.yaml
> >> index 7e50f5d65c8f..78e221003750 100644
> >> --- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5=
682.yaml
> >> +++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5=
682.yaml
> >> @@ -20,6 +20,15 @@ properties:
> >>         - mediatek,mt8192_mt6359_rt1015p_rt5682
> >>         - mediatek,mt8192_mt6359_rt1015p_rt5682s
> >>
> >> +  audio-routing:
> >> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> >
> > Already defined in sound-card-common.yaml. Add a $ref.
> >
>
> Right. Done for v2.
>
> >> +    description:
> >> +      A list of the connections between audio components. Each entry =
is a
> >> +      pair of strings, the first being the connection's sink, the sec=
ond
> >> +      being the connection's source.
> >> +      Valid names could be the input or output widgets of audio compo=
nents,
> >> +      power supplies, MicBias of codec and the software switch.
> >
> > Generally the names are defined here.
> >
>
> ...but those drivers want to support multiple codecs and multiple boards,=
 so
> for each board we would maybe have to add (software defined) names in her=
e
> which don't always correspond to a HW pin name (but that's not really a p=
roblem).
>
> Sure a subset of the names can't change but, on the other hand, some othe=
rs
> can (as in, may be added).
>
> Hence the question:
>
> Is it mandatory to define the names in an enum here, or can that be avoid=
ed?
> If it is, I can add them no problem.

Does the OS depend on what the names are? As-in if a name was "bar"
and it changed to "baz" in either the DT or the kernel, would that
break things? If yes, then yes, you need them defined here.

>
> >> +
> >>     mediatek,platform:
> >>       $ref: /schemas/types.yaml#/definitions/phandle
> >>       description: The phandle of MT8192 ASoC platform.
> >> @@ -27,10 +36,12 @@ properties:
> >>     mediatek,hdmi-codec:
> >>       $ref: /schemas/types.yaml#/definitions/phandle
> >>       description: The phandle of HDMI codec.
> >> +    deprecated: true
> >>
> >>     headset-codec:
> >>       type: object
> >>       additionalProperties: false
> >> +    deprecated: true
> >>
> >>       properties:
> >>         sound-dai:
> >> @@ -41,6 +52,7 @@ properties:
> >>     speaker-codecs:
> >>       type: object
> >>       additionalProperties: false
> >> +    deprecated: true
> >>
> >>       properties:
> >>         sound-dai:
> >> @@ -51,13 +63,83 @@ properties:
> >>       required:
> >>         - sound-dai
> >>
> >> +patternProperties:
> >> +  ".*-dai-link$":
> >> +    type: object
> >> +    description:
> >> +      Container for dai-link level properties and CODEC sub-nodes.
> >> +
> >> +    properties:
> >> +      link-name:
> >> +        description: Indicates dai-link name and PCM stream name
> >> +        items:
> >> +          enum:
> >> +            - I2S0
> >> +            - I2S1
> >> +            - I2S2
> >> +            - I2S3
> >> +            - I2S4
> >> +            - I2S5
> >> +            - I2S6
> >> +            - I2S7
> >> +            - I2S8
> >> +            - I2S9
> >> +            - TDM
> >> +
> >> +      codec:
> >> +        description: Holds subnode which indicates codec dai.
> >> +        type: object
> >> +        additionalProperties: false
> >> +        properties:
> >> +          sound-dai:
> >> +            minItems: 1
> >> +            maxItems: 2
> >> +        required:
> >> +          - sound-dai
> >> +
> >> +      dai-format:
> >> +        description: audio format
> >> +        items:
> >> +          enum:
> >> +            - i2s
> >> +            - right_j
> >> +            - left_j
> >> +            - dsp_a
> >> +            - dsp_b
> >> +
> >> +      mediatek,clk-provider:
> >> +        $ref: /schemas/types.yaml#/definitions/string
> >> +        description: Indicates dai-link clock master.
> >> +        items:
> >> +          enum:
> >> +            - cpu
> >> +            - codec
> >> +
> >> +    additionalProperties: false
> >
> > Move this before properties.
> >
>
> Done for v2.
>
> >> +
> >> +    required:
> >> +      - link-name
> >> +
> >>   additionalProperties: false
> >>
> >>   required:
> >>     - compatible
> >>     - mediatek,platform
> >> -  - headset-codec
> >> -  - speaker-codecs
> >> +
> >> +allOf:
> >> +  # Disallow dai-link-xxx nodes if the legacy properties are specifie=
d
> >
> > xxx-dai-link?
> >
>
> Oh! Yes, thanks for catching this.
>
> That's what I initially wanted to do, but then I opted for xxx-dai-link a=
nd
> forgot to update this comment.
>
> Fixed for v2.
>
> >> +  - if:
> >> +      patternProperties:
> >> +        ".*-dai-link$": false
> >> +    then:
> >> +      required:
> >> +        - headset-codec
> >> +        - speaker-codecs
> >> +    else:
> >> +      properties:
> >> +        headset-codec: false
> >> +        speaker-codecs: false
> >> +        mediatek,hdmi-codec: false
> >
> > Allowing both would preserve compatibility. That's not needed? If so,
> > say why in the commit msg.
> >
>
> I'm thinking of writing:
>
> "Since describing machine specific audio hardware and links replaces the
> now deprecated old logic doing the same in a driver hardcoded fashion,
> it is not allowed to have both the old and new properties together."

What happened to that. Instead you just sent a new version with
nothing about this.

> ...but in short - both the old and the new can do exactly the same, but
> imo it doesn't make any sense to actually rely on both as:
>   1. It's redundant (and one set of them makes the other useless);
>   2. I want to avoid confusion (as the other set won't be parsed);
>   3. I'm trying to *enforce* consistency as MTK cards have different
>      bindings for .. really, no good reason;
>   4. I want to see custom stuff disappear completely (and/or as much as
>      possible anyway) and use something that is (at least somewhat) commo=
n
>      between all MTK and non-MTK or anyway as a start at least consistent
>      between MTK cards.
>
> In theory, though, speaking of the driver side, there's nothing preventin=
g
> you from specifying both audio-routing xxx-dai-link and mediatek,hdmi-cod=
ec,
> as the drivers' action will be, in short
>     if (new_bindings)
>       forget_about_old_bindings_use_the_new_ones();
>     else
>       use_old_hardcoded_stuff(); /* and be sad */

That works for newer kernels with this change, but existing kernels
will only have:

use_old_hardcoded_stuff(); /* and not know it's sad */

If you want to support a new DT and old kernel, you need to populate
both properties.

> For that, I really don't want to allow both sets of properties - please, =
please,
> tell me that I don't *have to* remove this block :-)

Ultimately it is your decision as Mediatek maintainer, not mine. My
only requirement is the commit message explain why the above
combination is not important for these platforms.

You could leave it, but keep both in the dts files for some time
period. That will cause warnings, but what's a few more. The ABI
doesn't have to be a forever thing. Things evolve and there will be
other reasons to upgrade.

Rob


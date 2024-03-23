Return-Path: <linux-kernel+bounces-112209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F40D8876ED
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B066A1F22847
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710554696;
	Sat, 23 Mar 2024 03:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmAuRuNY"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508D137E;
	Sat, 23 Mar 2024 03:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711165337; cv=none; b=VLh6zjXwivhUHBuOJRduGbrCQTPJuj3H/IgHuj2+Ep2pY/qZGWsTMKsj8tUSzhH/HvcxhjelMTJAnRZ8VmO8XtQsvRSc4FrUAqZbOCKyL+h5nAS2xc0ZSkEzKgiuaOrAHx2kEPNiPVj+LlxuuF9pjz3kNWWRDNrRxZQCX5N6CiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711165337; c=relaxed/simple;
	bh=W2onV23bFeIsjJmE5cH1B/pXfjquwmKl4gj1EcBV3UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7vz7utnUdWrbIWbLUANDEpMxXCe0gpzuPDo9tbCKX2Ga5kjhyk5jwPIYyJhfyl39diaYFkh+Cj5RA+YoLHq3ObGfC55/I8bxlU8DPjVJQlCEiHKUL9dg807I+y5BOzUw1QyiUc/mHKp8xJeoNLWBv2DMU2VT0hkXSqdg7hkUgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmAuRuNY; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-366a4bcb2a8so12667875ab.3;
        Fri, 22 Mar 2024 20:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711165334; x=1711770134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7oGGDfGZl4k7YaoaPgaFIGDNWLjOcUwcUjURXF82RQ=;
        b=hmAuRuNYPabowGvbCPm57oVXyekSJcAiEWjGWYs+GMPQ8ZlYbxz8kgs2nWoIF2YGAQ
         F9hbFchEGJpomctk7jaqEHXe/hMuHWMgvDPK7XNy18nSZv4uKD4Z2/z6p4/ffIFCXdJm
         TXfXUBpj6ZxY3YhIVcmi7y/LEhZ//7Y7lxTQeRC6wvisik22PqaXItpWRdoiMGU5I611
         h927R21pJUAYt72/V1PTTA3wsyNReZM1tnlkIRVXYxAcIEYT64xCIeVNiRbwXVlLfJWe
         Qz6ovPJp7JmLr08xq0xoBuuILjcCCDj1NMHXspsLSzhtCFl6a+wDO73l1KsfdFczRlRB
         ZBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711165334; x=1711770134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7oGGDfGZl4k7YaoaPgaFIGDNWLjOcUwcUjURXF82RQ=;
        b=ctVoKLuhx+cLi4tC2BIH+nXZW6K5CVlrBOIJshS26Ar+I7hjL5kWd4bX9X+dXs9Tec
         09JWyH/TzPm7l6kzXXFU236P90mnA967gJfOGhDltekDUobkrFX1Fp1SM4+C/wff8NHE
         djNFUKH0WoA34TwIl0H5eesUygKVeSzHHptN7t9muzkYgwaQQ04WjNJvxqvQAMBUOwtN
         4P7KPQxe2whKnhOoVDmw1nYeHLjw3QQZxSqlVZSW8iqLOj7jZQRoegBcYdskjrBDQtgi
         Jb0luaQBv17V4JYs+SVahm24lMWHY4Cbo9cbv7WqEOb0F3vXdmLnARQnafeYQ4dQdgq1
         P2pA==
X-Forwarded-Encrypted: i=1; AJvYcCW5h8dqxqp0Uf7Zd6YMyEbmZJszGSe2BW1TSbYvRXcFwZ03n3ezNzvDjTSEaK//xYpLPGJKNMXBtLbYaoxaDxt+BewPkOulrNbhZ47XAW9ZpK/V4uI0wDpQiSEHjp55snF0h3fSge2SexxdhfqA2ABqKFN7tbD/txKxSOmMFpXUvzMWUd77
X-Gm-Message-State: AOJu0Yx/6VDaOLBim9rm6ENrbHo3pylWr+Pv0LFS6TjSy8jPbLpY7P4A
	IXID85/Uc7A3Blf2mb4vJb06eaSShV1QrNekt5g/VP0uFSYG9glHkjlIJo/6R1sSnVLP3BRvg76
	fEoIRhjog2IE9zY7vcn7QLxA/CZU=
X-Google-Smtp-Source: AGHT+IFPTsqAezg9b2hZJLZPqOiIo94F8YICrIiqJ+1QPCJeyoVFkozj6N3t+PVNp2bRjIvmGRqf9x0c5uF+sXMZy2w=
X-Received: by 2002:a92:cad0:0:b0:366:931c:2230 with SMTP id
 m16-20020a92cad0000000b00366931c2230mr1340893ilq.10.1711165334306; Fri, 22
 Mar 2024 20:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711102406-8399-1-git-send-email-shengjiu.wang@nxp.com>
 <1711102406-8399-2-git-send-email-shengjiu.wang@nxp.com> <20240322135800.GA811908-robh@kernel.org>
In-Reply-To: <20240322135800.GA811908-robh@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Sat, 23 Mar 2024 11:42:03 +0800
Message-ID: <CAA+D8AOJ5QsrpKLutHHBhdFX6ry=rX-D=r-ftJt6z0JUwMgE6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl-asoc-card: convert to YAML
To: Rob Herring <robh@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com, broonie@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 9:58=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Mar 22, 2024 at 06:13:25PM +0800, Shengjiu Wang wrote:
> > Convert the fsl-asoc-card binding to YAML.
> >
> > In order to pass the checking, add some used compatible
> > string from devicetree.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../bindings/sound/fsl-asoc-card.txt          | 117 -----------
> >  .../bindings/sound/fsl-asoc-card.yaml         | 196 ++++++++++++++++++
> >  2 files changed, 196 insertions(+), 117 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-ca=
rd.txt
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-ca=
rd.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt =
b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> > deleted file mode 100644
> > index 4e8dbc5abfd1..000000000000
> > --- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> > +++ /dev/null
> > @@ -1,117 +0,0 @@
> > -Freescale Generic ASoC Sound Card with ASRC support
> > -
> > -The Freescale Generic ASoC Sound Card can be used, ideally, for all Fr=
eescale
> > -SoCs connecting with external CODECs.
> > -
> > -The idea of this generic sound card is a bit like ASoC Simple Card. Ho=
wever,
> > -for Freescale SoCs (especially those released in recent years), most o=
f them
> > -have ASRC (Documentation/devicetree/bindings/sound/fsl,asrc.txt) insid=
e. And
> > -this is a specific feature that might be painstakingly controlled and =
merged
> > -into the Simple Card.
> > -
> > -So having this generic sound card allows all Freescale SoC users to be=
nefit
> > -from the simplification of a new card support and the capability of th=
e wide
> > -sample rates support through ASRC.
> > -
> > -Note: The card is initially designed for those sound cards who use AC'=
97, I2S
> > -      and PCM DAI formats. However, it'll be also possible to support =
those non
> > -      AC'97/I2S/PCM type sound cards, such as S/PDIF audio and HDMI au=
dio, as
> > -      long as the driver has been properly upgraded.
> > -
> > -
> > -The compatible list for this generic sound card currently:
> > - "fsl,imx-audio-ac97"
> > -
> > - "fsl,imx-audio-cs42888"
> > -
> > - "fsl,imx-audio-cs427x"
> > - (compatible with CS4271 and CS4272)
> > -
> > - "fsl,imx-audio-wm8962"
> > -
> > - "fsl,imx-audio-sgtl5000"
> > - (compatible with Documentation/devicetree/bindings/sound/imx-audio-sg=
tl5000.txt)
> > -
> > - "fsl,imx-audio-wm8960"
> > -
> > - "fsl,imx-audio-mqs"
> > -
> > - "fsl,imx-audio-wm8524"
> > -
> > - "fsl,imx-audio-tlv320aic32x4"
> > -
> > - "fsl,imx-audio-tlv320aic31xx"
> > -
> > - "fsl,imx-audio-si476x"
> > -
> > - "fsl,imx-audio-wm8958"
> > -
> > - "fsl,imx-audio-nau8822"
> > -
> > -Required properties:
> > -
> > -  - compatible               : Contains one of entries in the compatib=
le list.
> > -
> > -  - model            : The user-visible name of this sound complex
> > -
> > -  - audio-cpu                : The phandle of an CPU DAI controller
> > -
> > -  - audio-codec              : The phandle of an audio codec
> > -
> > -Optional properties:
> > -
> > -  - audio-asrc               : The phandle of ASRC. It can be absent i=
f there's no
> > -                       need to add ASRC support via DPCM.
> > -
> > -  - audio-routing    : A list of the connections between audio compone=
nts.
> > -                       Each entry is a pair of strings, the first bein=
g the
> > -                       connection's sink, the second being the connect=
ion's
> > -                       source. There're a few pre-designed board conne=
ctors:
> > -                        * Line Out Jack
> > -                        * Line In Jack
> > -                        * Headphone Jack
> > -                        * Mic Jack
> > -                        * Ext Spk
> > -                        * AMIC (stands for Analog Microphone Jack)
> > -                        * DMIC (stands for Digital Microphone Jack)
> > -
> > -                       Note: The "Mic Jack" and "AMIC" are redundant w=
hile
> > -                             coexisting in order to support the old bi=
ndings
> > -                             of wm8962 and sgtl5000.
> > -
> > -  - hp-det-gpio              : The GPIO that detect headphones are plu=
gged in
> > -  - mic-det-gpio     : The GPIO that detect microphones are plugged in
> > -  - bitclock-master  : Indicates dai-link bit clock master; for detail=
s see simple-card.yaml.
> > -  - frame-master     : Indicates dai-link frame master; for details se=
e simple-card.yaml.
> > -  - dai-format               : audio format, for details see simple-ca=
rd.yaml.
> > -  - frame-inversion  : dai-link uses frame clock inversion, for detail=
s see simple-card.yaml.
> > -  - bitclock-inversion       : dai-link uses bit clock inversion, for =
details see simple-card.yaml.
> > -  - mclk-id          : main clock id, specific for each card configura=
tion.
> > -
> > -Optional unless SSI is selected as a CPU DAI:
> > -
> > -  - mux-int-port     : The internal port of the i.MX audio muxer (AUDM=
UX)
> > -
> > -  - mux-ext-port     : The external port of the i.MX audio muxer
> > -
> > -Example:
> > -sound-cs42888 {
> > -     compatible =3D "fsl,imx-audio-cs42888";
> > -     model =3D "cs42888-audio";
> > -     audio-cpu =3D <&esai>;
> > -     audio-asrc =3D <&asrc>;
> > -     audio-codec =3D <&cs42888>;
> > -     audio-routing =3D
> > -             "Line Out Jack", "AOUT1L",
> > -             "Line Out Jack", "AOUT1R",
> > -             "Line Out Jack", "AOUT2L",
> > -             "Line Out Jack", "AOUT2R",
> > -             "Line Out Jack", "AOUT3L",
> > -             "Line Out Jack", "AOUT3R",
> > -             "Line Out Jack", "AOUT4L",
> > -             "Line Out Jack", "AOUT4R",
> > -             "AIN1L", "Line In Jack",
> > -             "AIN1R", "Line In Jack",
> > -             "AIN2L", "Line In Jack",
> > -             "AIN2R", "Line In Jack";
> > -};
> > diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml=
 b/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
> > new file mode 100644
> > index 000000000000..48051655230d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
> > @@ -0,0 +1,196 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/fsl-asoc-card.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale Generic ASoC Sound Card with ASRC support
> > +
> > +description:
> > +  The Freescale Generic ASoC Sound Card can be used, ideally,
> > +  for all Freescale SoCs connecting with external CODECs.
> > +
> > +  The idea of this generic sound card is a bit like ASoC Simple Card.
> > +  However, for Freescale SoCs (especially those released in recent yea=
rs),
> > +  most of them have ASRC
> > +  (Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml) inside. =
And
> > +  this is a specific feature that might be painstakingly controlled an=
d
> > +  merged into the Simple Card.
> > +
> > +  So having this generic sound card allows all Freescale SoC users to
> > +  benefit from the simplification of a new card support and the capabi=
lity
> > +  of the wide sample rates support through ASRC.
> > +
> > +  Note, The card is initially designed for those sound cards who use A=
C'97, I2S
> > +  and PCM DAI formats. However, it'll be also possible to support thos=
e non
> > +  AC'97/I2S/PCM type sound cards, such as S/PDIF audio and HDMI audio,=
 as
> > +  long as the driver has been properly upgraded.
> > +
> > +maintainers:
> > +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - fsl,imx-sgtl5000
> > +              - fsl,imx53-cpuvo-sgtl5000
> > +              - fsl,imx51-babbage-sgtl5000
> > +              - fsl,imx53-m53evk-sgtl5000
> > +              - fsl,imx53-qsb-sgtl5000
> > +              - fsl,imx53-voipac-sgtl5000
> > +              - fsl,imx6-armadeus-sgtl5000
> > +              - fsl,imx6-rex-sgtl5000
> > +              - fsl,imx6-sabreauto-cs42888
> > +              - fsl,imx6-wandboard-sgtl5000
> > +              - fsl,imx6dl-nit6xlite-sgtl5000
> > +              - fsl,imx6q-ba16-sgtl5000
> > +              - fsl,imx6q-nitrogen6_max-sgtl5000
> > +              - fsl,imx6q-nitrogen6_som2-sgtl5000
> > +              - fsl,imx6q-nitrogen6x-sgtl5000
> > +              - fsl,imx6q-sabrelite-sgtl5000
> > +              - fsl,imx6q-sabresd-wm8962
> > +              - fsl,imx6q-udoo-ac97
> > +              - fsl,imx6q-ventana-sgtl5000
> > +              - fsl,imx6sl-evk-wm8962
> > +              - fsl,imx6sx-sdb-mqs
> > +              - fsl,imx6sx-sdb-wm8962
> > +              - fsl,imx7d-evk-wm8960
> > +              - karo,tx53-audio-sgtl5000
> > +              - tq,imx53-mba53-sgtl5000
>
> None of these were documented before. It's fine to add all these in this
> patch, but please state in the commit message what missing or incorrect
> things you added in the schema.

ok, will add info in the commit message.

>
> > +          - enum:
> > +              - fsl,imx-audio-ac97
> > +              - fsl,imx-audio-cs42888
> > +              - fsl,imx-audio-mqs
> > +              - fsl,imx-audio-sgtl5000
> > +              - fsl,imx-audio-wm8960
> > +              - fsl,imx-audio-wm8962
> > +      - items:
> > +          - enum:
> > +              - fsl,imx-audio-ac97
> > +              - fsl,imx-audio-cs42888
> > +              - fsl,imx-audio-cs427x
> > +              - fsl,imx-audio-mqs
> > +              - fsl,imx-audio-nau8822
> > +              - fsl,imx-audio-sgtl5000
> > +              - fsl,imx-audio-si476x
> > +              - fsl,imx-audio-tlv320aic31xx
> > +              - fsl,imx-audio-tlv320aic32x4
> > +              - fsl,imx-audio-wm8524
> > +              - fsl,imx-audio-wm8960
> > +              - fsl,imx-audio-wm8962
> > +              - fsl,imx-audio-wm8958
> > +
> > +  model:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: The user-visible name of this sound complex
> > +
> > +  audio-asrc:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      The phandle of ASRC. It can be absent if there's no
> > +      need to add ASRC support via DPCM.
> > +
> > +  audio-codec:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of an audio codec
> > +
> > +  audio-cpu:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of an CPU DAI controller
> > +
> > +  audio-routing:
> > +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> > +    description:
> > +      A list of the connections between audio components. Each entry i=
s a
> > +      pair of strings, the first being the connection's sink, the seco=
nd
> > +      being the connection's source. There're a few pre-designed board
> > +      connectors.
> > +        * Line Out Jack
> > +        * Line In Jack
> > +        * Headphone Jack
> > +        * Mic Jack
> > +        * Ext Spk
> > +        * AMIC (stands for Analog Microphone Jack)
> > +        * DMIC (stands for Digital Microphone Jack)
> > +      Note, The "Mic Jack" and "AMIC" are redundant while coexisting i=
n
> > +      order to support the old bindings of wm8962 and sgtl5000.
>
> Please list the strings out as schema:
>
> minItems: 2
> items:
>   enum:
>     - "Line Out Jack"
>     ...

Can I not list them? Because this fsl-asoc-card is generic
it supports several codecs, if list them, there will be a long list.

>
> > +
> > +  hp-det-gpio:
> > +    maxItems: 1
> > +    description: The GPIO that detect headphones are plugged in
>
>        deprecated: true

ok, will add it.

>
> > +
> > +  hp-det-gpios:
> > +    maxItems: 1
> > +    description: The GPIO that detect headphones are plugged in
> > +
> > +  mic-det-gpio:
> > +    maxItems: 1
> > +    description: The GPIO that detect microphones are plugged in
>
>        deprecated: true
>
> > +
> > +  mic-det-gpios:
> > +    maxItems: 1
> > +    description: The GPIO that detect microphones are plugged in
> > +
> > +  bitclock-master:
> > +    description: Indicates dai-link bit clock master; for details see =
simple-card.yaml.
>
> Drop the prose reference and add:
>
>        $ref: simple-card.yaml#/definitions/bitclock-master
>
> Otherwise, bitclock-master could be anything.
>
> And similar for the rest.

ok, will change them.

Best regards
Shengjiu Wang
>
> > +
> > +  frame-master:
> > +    description: Indicates dai-link frame master; for details see simp=
le-card.yaml.
> > +
> > +  dai-format:
> > +    description: audio format, for details see simple-card.yaml.
> > +
> > +  frame-inversion:
> > +    description: dai-link uses frame clock inversion, for details see =
simple-card.yaml.
> > +
> > +  bitclock-inversion:
> > +    description: dai-link uses bit clock inversion, for details see si=
mple-card.yaml.
> > +
> > +  mclk-id:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: main clock id, specific for each card configuration.
> > +
> > +  mux-int-port:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [1, 2, 7]
> > +    description: The internal port of the i.MX audio muxer (AUDMUX)
> > +
> > +  mux-ext-port:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [3, 4, 5, 6]
> > +    description: The external port of the i.MX audio muxer
> > +
> > +  ssi-controller:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of an CPU DAI controller
> > +
> > +required:
> > +  - compatible
> > +  - model
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    sound-cs42888 {
> > +        compatible =3D "fsl,imx-audio-cs42888";
> > +        model =3D "cs42888-audio";
> > +        audio-cpu =3D <&esai>;
> > +        audio-asrc =3D <&asrc>;
> > +        audio-codec =3D <&cs42888>;
> > +        audio-routing =3D
> > +             "Line Out Jack", "AOUT1L",
> > +             "Line Out Jack", "AOUT1R",
> > +             "Line Out Jack", "AOUT2L",
> > +             "Line Out Jack", "AOUT2R",
> > +             "Line Out Jack", "AOUT3L",
> > +             "Line Out Jack", "AOUT3R",
> > +             "Line Out Jack", "AOUT4L",
> > +             "Line Out Jack", "AOUT4R",
> > +             "AIN1L", "Line In Jack",
> > +             "AIN1R", "Line In Jack",
> > +             "AIN2L", "Line In Jack",
> > +             "AIN2R", "Line In Jack";
> > +    };
> > --
> > 2.34.1
> >


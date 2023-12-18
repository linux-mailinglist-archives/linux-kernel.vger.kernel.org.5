Return-Path: <linux-kernel+bounces-2910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2186681641C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C97DB217B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8F7210F;
	Mon, 18 Dec 2023 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rMVjQtpt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF11713ADE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so25328731fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702862991; x=1703467791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goOkV/j+8n7xf5oq2/AgXGIm/vSbN9pRUXbhB8YUgtM=;
        b=rMVjQtptFSENvgbHqJxpWRjR1SvYREh2KPLChCMuSfk5B/z1GODPl7ajkAdj4lwctl
         FdQZZu7DDjnPG5gPm9pGZqvtIUDxdLPqTElFc2shmsZMVb1/YpGj/nih4gIOuTABLJ6G
         gJ560k0wOCgjK8w7SuFWZC+LB5nrKky+XVyi9DouM6ySTCgRJKfgCIgKYCBInqjkOiDh
         d3td3Q0//lpnj8N4dMh21KxhbFYGab5cEhC7w//TPtumk/TKxVPjEYx8RjTPLDm2Kte2
         eDJ1lDOKnFp2pOl/CMDYVXpLasKBFUqBoVuDnJip+42UEU2KOMYor2Cvtalxa1AROycx
         EX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702862991; x=1703467791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goOkV/j+8n7xf5oq2/AgXGIm/vSbN9pRUXbhB8YUgtM=;
        b=sI8GsJwTkstSF0eLY9kc6JKWKKUjgyu7s5KKFw2e3ZEC2aRokYjpwnvQ7Be8Rh8mwn
         TWhAOc5iUYgnnCZW7V8fPuJ4mLakr1cqS/b8pDatxHMKzYoGRW8jHWaQnsqVG/wxsUO8
         mSHa63B6j2nMJdQIdLJPfofCnn5r0stmKnD4W8j6BcW7RAoh2k0Q4CXaA2oJuLJb+ZK3
         NwDw8bcIMa6BwzkQC4Crf6i0fbN6DL6p8WHxFoLLMaZXOmSWECs1X/bjesRlO02b4ohx
         OWQGtZm7qVWajPZItBGvy7t4SP5CsWOstx/pfO0ghPrSBRv/fzUVAdpbP9hHR2wp2JUI
         c22A==
X-Gm-Message-State: AOJu0Yy1cDGu1kgc+q9c19CBnFxiPuJvqw6ekk3PLVgUFW5fzSnvOrnj
	7+ZQehpf3wNXmw4NOr9XAwU0TSZkl3KLzqRr+kDX9g==
X-Google-Smtp-Source: AGHT+IFsnUmP4WLJVbSaMw1tBicScccBZbSsI3uJUUJztiqfMXzdxrYXqW2/6AbAT1zDEmkwzr/JB3S9NYJXdyvc3bg=
X-Received: by 2002:a2e:9dd5:0:b0:2cc:6066:3c19 with SMTP id
 x21-20020a2e9dd5000000b002cc60663c19mr587687ljj.64.1702862990901; Sun, 17 Dec
 2023 17:29:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217180836.584828-1-anshulusr@gmail.com> <CAMknhBGR7WS46J+MeqY51RhMb78AoUO6URaFxw2M83P29fqzdQ@mail.gmail.com>
In-Reply-To: <CAMknhBGR7WS46J+MeqY51RhMb78AoUO6URaFxw2M83P29fqzdQ@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 Dec 2023 19:29:40 -0600
Message-ID: <CAMknhBHoK-ZB1MpJmM3jbbBpyCbRYcRWPG02fxJ5OY6PLB7ZEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: add MCP4821
To: Anshul Dalal <anshulusr@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	linux-kernel-mentees@lists.linuxfoundation.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 7:25=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On Sun, Dec 17, 2023 at 12:11=E2=80=AFPM Anshul Dalal <anshulusr@gmail.co=
m> wrote:
> >
> > Adds support for MCP48xx series of DACs.
> >
> > Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf =
#MCP48x1
> > Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.p=
df #MCP48x2
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> >
> > ---
> >
> > Changes for v2:
> > - Changed order in device table to numerical
> > - Made vdd_supply required
> > - Added 'Reviewed-by: Conor Dooley'
> >
> > Previous versions:
> > v1: https://lore.kernel.org/lkml/20231117073040.685860-1-anshulusr@gmai=
l.com/
> > ---
> >  .../bindings/iio/dac/microchip,mcp4821.yaml   | 64 +++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip=
,mcp4821.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp482=
1.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
> > new file mode 100644
> > index 000000000000..97da9f9ef450
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4821.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Microchip MCP4821 and similar DACs
> > +
> > +description: |
> > +  Supports MCP48x1 (single channel) and MCP48x2 (dual channel) series =
of DACs.
> > +  Device supports simplex communication over SPI in Mode 0,1 and Mode =
1,1.
>
> It seems like SPI modes usually only have one number in them, i.e.
> mode 1 and mode 3 in this case, I'm guessing.

Oh, and doesn't this mean that we need to include spi-cpha and
spi-cpol properties since they aren't implicit in the bindings anymore
since [1]?

[1]: https://lore.kernel.org/all/20220722191539.90641-2-krzysztof.kozlowski=
@linaro.org/

>
> > +
> > +  +---------+--------------+-------------+
> > +  | Device  |  Resolution  |   Channels  |
> > +  |---------|--------------|-------------|
> > +  | MCP4801 |     8-bit    |      1      |
> > +  | MCP4802 |     8-bit    |      2      |
> > +  | MCP4811 |    10-bit    |      1      |
> > +  | MCP4812 |    10-bit    |      2      |
> > +  | MCP4821 |    12-bit    |      1      |
> > +  | MCP4822 |    12-bit    |      2      |
> > +  +---------+--------------+-------------+
> > +
> > +  Datasheet:
> > +    MCP48x1: https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.p=
df
> > +    MCP48x2: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249=
B.pdf
> > +
> > +maintainers:
> > +  - Anshul Dalal <anshulusr@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - microchip,mcp4801
> > +      - microchip,mcp4802
> > +      - microchip,mcp4811
> > +      - microchip,mcp4812
> > +      - microchip,mcp4821
> > +      - microchip,mcp4822
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
>
> What about the SHDN and LDAC pins? It seems like all should have an
> ldac-gpios property and MCP48x1 should have a shdn-gpios property for
> these.
>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        dac@0 {
> > +            compatible =3D "microchip,mcp4821";
> > +            reg =3D <0>;
> > +            vdd-supply =3D <&vdd_regulator>;
> > +        };
> > +    };
> > --
> > 2.43.0
> >
> >


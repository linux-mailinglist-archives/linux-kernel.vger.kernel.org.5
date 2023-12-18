Return-Path: <linux-kernel+bounces-2903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D46D8816405
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F652824C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9141C1FD9;
	Mon, 18 Dec 2023 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oeq+JOhm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB275396
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cc5e48779aso13088511fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702862738; x=1703467538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHRHA7JfQFuNpMI/anLcoQ4nrN4AoQWbZ++49Uu8LtQ=;
        b=oeq+JOhmu3gPsxl/Xeit5ZrkreAtqgh9bX47lpTi8djKfcz5xnX0KtwxCIEUO/1UeX
         DKJ2WW8lHwpeTdTouAuciWyMtrhB5zvqLHqmUjazIdOzsM9HgSUCbyOVUvS9ftR1PAyJ
         S7vPYNcmZ1nlvWbRfCTemm4EJtYpZnO9M1zNB4U+drPp9fsnNIQn2n0qzdK3wgkgCpz5
         +PWVITo66C/B2LCQNcnQL2xsCNgbmZULNPY0+nZKzZ8zkxa58soDPrB2WyUASnhEVy45
         kJaZtEMe80UJc1V345eKsdKUmqb2JyHxjw96i0G9rZyOjBUwT09L62ZDzAPGKkM59zuu
         U/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702862738; x=1703467538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHRHA7JfQFuNpMI/anLcoQ4nrN4AoQWbZ++49Uu8LtQ=;
        b=g23eQEbfniBNEakwArurGfXsLOdnFeOjnKZPM3bSNSTWSQ+S7KeIzqaxF4hmcoL0Gy
         bGY3IyGtTQb1OXS+XXgfgUJBApUB8k74J5erSrMVXMXNJ0VeAs3sZxacCNUWFep5ub+l
         LoU0c5zHbnD0a0vv/n6cIUwi1W4VD0Sp975kpfZKWQlAbew3EFTseQxHHPaodN65P4w3
         9Rw1XTE4qHzji7Se/cq0zrHH9X3CV6bGv/bUXb/MedgKHWSfm6EZEDJYr6PC5XpLq2Ue
         g/WJbYJqNWvotUiVzD7KNUQgvwHKLy3D10VXI9JzUfKv5uWGi0gjEnj2DtIynqmpGBOT
         2e4Q==
X-Gm-Message-State: AOJu0YxS+2fZJeMnEsgft/2yw6FxAMmStFuu5P4hLTiPIPUSSI6An4d2
	YPXq9T0Tg2GoITWcwHqfGzQlq5GAks8j62DJRc6gQg==
X-Google-Smtp-Source: AGHT+IE7ho2vHKKOouJkmWr4ZLXLTRt7CfGHDDz8T7Mr0FEgXFaZmrWeULevy23Gif3+ThL3Ds0NIPJtK8GMZfbg8Tc=
X-Received: by 2002:a05:651c:12c8:b0:2cc:1f97:b573 with SMTP id
 8-20020a05651c12c800b002cc1f97b573mr5112517lje.106.1702862737939; Sun, 17 Dec
 2023 17:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217180836.584828-1-anshulusr@gmail.com>
In-Reply-To: <20231217180836.584828-1-anshulusr@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 Dec 2023 19:25:26 -0600
Message-ID: <CAMknhBGR7WS46J+MeqY51RhMb78AoUO6URaFxw2M83P29fqzdQ@mail.gmail.com>
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

On Sun, Dec 17, 2023 at 12:11=E2=80=AFPM Anshul Dalal <anshulusr@gmail.com>=
 wrote:
>
> Adds support for MCP48xx series of DACs.
>
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf #M=
CP48x1
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf=
 #MCP48x2
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
>
> ---
>
> Changes for v2:
> - Changed order in device table to numerical
> - Made vdd_supply required
> - Added 'Reviewed-by: Conor Dooley'
>
> Previous versions:
> v1: https://lore.kernel.org/lkml/20231117073040.685860-1-anshulusr@gmail.=
com/
> ---
>  .../bindings/iio/dac/microchip,mcp4821.yaml   | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,m=
cp4821.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.=
yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
> new file mode 100644
> index 000000000000..97da9f9ef450
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4821.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP4821 and similar DACs
> +
> +description: |
> +  Supports MCP48x1 (single channel) and MCP48x2 (dual channel) series of=
 DACs.
> +  Device supports simplex communication over SPI in Mode 0,1 and Mode 1,=
1.

It seems like SPI modes usually only have one number in them, i.e.
mode 1 and mode 3 in this case, I'm guessing.

> +
> +  +---------+--------------+-------------+
> +  | Device  |  Resolution  |   Channels  |
> +  |---------|--------------|-------------|
> +  | MCP4801 |     8-bit    |      1      |
> +  | MCP4802 |     8-bit    |      2      |
> +  | MCP4811 |    10-bit    |      1      |
> +  | MCP4812 |    10-bit    |      2      |
> +  | MCP4821 |    12-bit    |      1      |
> +  | MCP4822 |    12-bit    |      2      |
> +  +---------+--------------+-------------+
> +
> +  Datasheet:
> +    MCP48x1: https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf
> +    MCP48x2: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.=
pdf
> +
> +maintainers:
> +  - Anshul Dalal <anshulusr@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp4801
> +      - microchip,mcp4802
> +      - microchip,mcp4811
> +      - microchip,mcp4812
> +      - microchip,mcp4821
> +      - microchip,mcp4822
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true

What about the SHDN and LDAC pins? It seems like all should have an
ldac-gpios property and MCP48x1 should have a shdn-gpios property for
these.

> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        dac@0 {
> +            compatible =3D "microchip,mcp4821";
> +            reg =3D <0>;
> +            vdd-supply =3D <&vdd_regulator>;
> +        };
> +    };
> --
> 2.43.0
>
>


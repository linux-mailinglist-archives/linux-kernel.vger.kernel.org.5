Return-Path: <linux-kernel+bounces-7389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A6F81A739
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8EA2873B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B984878B;
	Wed, 20 Dec 2023 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hsJP9FXo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFBF482DF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbd532e6e8aso6707276.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703100062; x=1703704862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ps3P/pvG74IGGnT8GqUmphrkn8oo7nKEcsYAKREB89c=;
        b=hsJP9FXowB9Go9/CUlXoDwre8bu3Ej24ZqEXSduvqsC47KX5v3WTHf50QCkcc7SQfb
         ajJiPHl/tNndtgdXZBVbzN7PDDBQrV0b3gXwoF7lypm0YWCZjiBjTmar/YpgL1Nga5gm
         vjEGReyWvXEXkIk+r+egyjLaZ8vmW/VRkln5MC5A71NKYTYQpnOnvuU1c0HqpF/C1396
         GFYJAV9GPf1+/UPMxx+BmLVP9SXPEOAUGM7G6j9x9KtZNMdbYAxDyxtWcvyr/Lqh3Icv
         t90E88kJ5A+zJNZ5/bJksfXbyYizKUEDGXG35IkxVGHBUU/TLiLVyYMOPFIikPJRwEN5
         I25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703100062; x=1703704862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ps3P/pvG74IGGnT8GqUmphrkn8oo7nKEcsYAKREB89c=;
        b=VchgW5W3fkQLw1fJhIqQmoghNsQ6W22b2ADhKnZfuxDKJmRDl/gdG9IeC4jTTakQYK
         Kt7CQTC8hnWBZYDmCoL62oAxhwjnYMeFLMNsRib34mS3RClFUGhiB7W807w2/3zxVXMU
         i1VVq/OR27iyQPx/FmJmHQxoITlL+QZKq6zVd6hVr2JKoqKR21I5LOnVm0XWiKaGp/1D
         q36rKDQfkrLEfs+JK+9BrcVteL7K2IYV660D7YT7UVIoAtbtRiam97LFeYgCjICsU9fj
         1CuuVqmGUdz4tQTpm5hGa2QNYBFVdEpWe4LUtLgZMm6XLcY3iL8qpme7QlS/tE+4th4h
         oFFA==
X-Gm-Message-State: AOJu0Yz2aCdGKARcPvwcEXSiHsfpKCZ0OwmYSxWIaYoKtV4sy/K52Kwe
	NLWQHf/JbXr8p1+D8xj5A+HL7U1Tfi53KUWBwCioiQ==
X-Google-Smtp-Source: AGHT+IE0/lC2Cx520RUvUKQoxpsf0wmqJ8BQXaOwxQm86Cv5E07vosKnSijGbt5II7X94Q8Sms9uxQ9pRCNxE/GNr9k=
X-Received: by 2002:a25:1c1:0:b0:dbd:b165:43d with SMTP id 184-20020a2501c1000000b00dbdb165043dmr247285ybb.18.1703100062573;
 Wed, 20 Dec 2023 11:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215143906.3651122-1-emil.renner.berthing@canonical.com> <20231215143906.3651122-2-emil.renner.berthing@canonical.com>
In-Reply-To: <20231215143906.3651122-2-emil.renner.berthing@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 20:20:51 +0100
Message-ID: <CACRpkdZf09uKr+ka0_rsw5kHMjjQbaGypn2fx2-QobLFBKYrtQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] dt-bindings: pinctrl: Add thead,th1520-pinctrl bindings
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Hoan Tran <hoan@os.amperecomputing.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emil,

thanks for your patch!

On Fri, Dec 15, 2023 at 3:39=E2=80=AFPM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:

> +  The TH1520 has 3 groups of pads each controlled from different memory =
ranges.
> +  Confusingly the memory ranges are named
> +    PADCTRL_AOSYS  -> PAD Group 1
> +    PADCTRL1_APSYS -> PAD Group 2
> +    PADCTRL0_APSYS -> PAD Group 3

Really, even in the documentation? If you look at the layout on the actual
chip, does a pattern emerge?

I think some use the north/south/east/west as group names with the BGA
chip facing up with the package text correctly readable then it is a bit
like a map.

> +          function:
> +            $ref: /schemas/types.yaml#/definitions/string
> +            enum: [ "0", "1", "2", "3", "4", "5" ]
> +            description: The mux function to select for the given pins.

So why is the opaque names "0", "1" etc used, and they will be the same for
all pins I bet. Most drivers use a string identifying the actual function h=
ere.
Such as "i2c", "gpio", etc.

Names that are just figures are *impossible* to understand without access
to a datasheet.

The point of device trees sources are to be human readable, strings of
magic numbers are not human readable at all.

> +          bias-disable: true
> +
> +          bias-pull-up:
> +            type: boolean
> +
> +          bias-pull-down:
> +            type: boolean
> +
> +          drive-strength:
> +            enum: [ 1, 2, 3, 5, 7, 8, 10, 12, 13, 15, 16, 18, 20, 21, 23=
, 25 ]

milliamperes? Then use drive-strength-microamp.

If not, explain what each setting means, i.e. the number of max microamps.

At which point using drive-strength-microamp and a translation table in the
driver may be a better idea.

The only reason to use opaque numbers is if 1, 2 (etc) mean something like
"number of driver stages" with a current output that varies with technology=
.

> +          thead,strong-pull-up:
> +            oneOf:
> +              - type: boolean
> +              - $ref: /schemas/types.yaml#/definitions/uint32
> +                enum: [ 0, 2100 ]
> +            description: Enable or disable strong 2.1kOhm pull-up.

Just use bias-pull-up with an argument.

bias-pull-up =3D <2100000>;

No argument would be the default setting.

No need for custom bindings.

> +        uart0_pins: uart0-0 {
> +            tx-pins {
> +                pins =3D "UART0_TXD";

Pins have reasonable names, but...

> +                function =3D "0";

What about function =3D "uart_0" hmmm?

Yours,
Linus Walleij


Return-Path: <linux-kernel+bounces-91899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2748787181B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922EF1F223FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620107FBC8;
	Tue,  5 Mar 2024 08:20:00 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9737F7EF;
	Tue,  5 Mar 2024 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626799; cv=none; b=sX20eKsrS72cHSP9/yOX9kQRWvfiegZFjMo8GylrFU35NESmW56JWjxEl6oeOamhzoHvny22rlwSUTQC6PA94+dhVdLjKMMjykkW6C9G2HFadLJm947ponLC2u9LKLZKpAm3qlcpBi2EzH1lSdAhh/f9Ju9lvbia8nWE7ncYEHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626799; c=relaxed/simple;
	bh=t6XchAICiSHWdKVGv/WGYM7YeyQcxFEXLVVRKxNtMGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3MFDI3KnwW/b0n5dDZJCBptrt1mSmvN+UoxFwzJFjKAUm16GL+isD0rMzthAfSJlsBf3bc20dgONXQK2tKX6AuLj8+fAhbHfZNrLnd5lsTzfFS3RhBtWBstQ7b2DH9gZJu8FyFCc7GlwLc0uNYzRQDQheGfcueOXGMmAaLARgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60925d20af0so54905777b3.2;
        Tue, 05 Mar 2024 00:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709626795; x=1710231595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZEUhB5dRg0BtcsxeiTUemjtMJD5muiFM6LlHEKnvOw=;
        b=Ug6HHy3AzDcu3uoEUATjx3axDXiy0Twx9oU/d41U6PtO10gJka7DqWhNMNbhJhu0FW
         z14M2lm+kE2YHvqGT2XlaYTI/0zbe5QzWExZwyRaSzgPSiXQR2/f3D2WUmgIBA5HNNlp
         b1QGlg+fTOQIH01x7/z2jj2uEka+TD2iLOzJqFhFFGbP+L8acl/SeQ3y318cMOvNJlsv
         Cpxq0ztrvKawWUtx1BeFy5mcIvylb/spcfopE7atV7y0qh9xCIjf6MvIStrjDDUSpenm
         ClILUJ7ep2z5ePUv/ba831wdJB/07DANzAJW6r4KBv5HDJ8GyD0mAxP5VG6mxpGjV1VT
         Kimg==
X-Forwarded-Encrypted: i=1; AJvYcCW4eeY8+8YTTtO29eXQwkczf6CJXKTSxNBsCLtk8SFL//q7FUFonYEyxGJq5zwDnbGJJbf+p07ibEH7zSiSCs3rQBJkxAnd7OuxZ7N1f4C6aBXwqxl1L94STxJdrM6uC7y+OKKFwJXz5xyD7rb2qqFHp4tG42Za7gi2ck2pLMNVDd/mtTE=
X-Gm-Message-State: AOJu0Yyy47JBHdHl6rGrSl6O3QhGSVJeyeKJYuHfdjK/jc0QezW2HbQ1
	hF/ODDCCzp51YzZYBXe33AQ0zLcMcDwaUYoSp0hoLCyd9/P1a6rHg7ddLuupVk0=
X-Google-Smtp-Source: AGHT+IGtumgYEaXukERvwQ2+EowBtnDS3CxHvLyAdJblTOhF0H9x8BNhLdpe3XpSjQZzYRUtvyp1pQ==
X-Received: by 2002:a0d:c303:0:b0:609:b412:41f7 with SMTP id f3-20020a0dc303000000b00609b41241f7mr4565961ywd.45.1709626795619;
        Tue, 05 Mar 2024 00:19:55 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id w81-20020a814954000000b006079b97c437sm3048957ywa.98.2024.03.05.00.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:19:54 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60943ad307fso49429057b3.1;
        Tue, 05 Mar 2024 00:19:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpJzl8UJr51SUGjJMVd8owK0Ao4ZGXgDV7j6ADCv7bGQ0ExvzZtcPhUR4QvwpcgIyOPfJtXk3Vu8GoJIiojRacG39YwBPFjyXnCqs2xXM6rJzeGQYlSqJskLPphPnOSsYj3ewKY9K47NMPSexHbUyzn5EluImj+S8AgqLvs+OQb6aKmKY=
X-Received: by 2002:a81:4e45:0:b0:609:c5ca:8b0d with SMTP id
 c66-20020a814e45000000b00609c5ca8b0dmr1984380ywb.12.1709626794525; Tue, 05
 Mar 2024 00:19:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305035853.916430-1-chris.packham@alliedtelesis.co.nz> <20240305035853.916430-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240305035853.916430-3-chris.packham@alliedtelesis.co.nz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Mar 2024 09:19:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVjx6rMbqKiG-9pt+y4c4nVZ-MQk8Miv3HB7jgTd=Pdcg@mail.gmail.com>
Message-ID: <CAMuHMdVjx6rMbqKiG-9pt+y4c4nVZ-MQk8Miv3HB7jgTd=Pdcg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: auxdisplay: Add bindings for generic
 7-segment LED
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andy@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, lee@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Tue, Mar 5, 2024 at 4:59=E2=80=AFAM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> Add bindings for a generic 7-segment LED display using GPIOs.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     Changes in v4:
>     - Add ASCII art diagram showing arrangement of segments

Thanks for the update!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/auxdisplay/gpio-7-segment.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/auxdisplay/gpio-7-segment.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO based LED segment display
> +
> +maintainers:
> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
> +
> +properties:
> +  compatible:
> +    const: gpio-7-segment
> +
> +  segment-gpios:
> +    description:

Please add "|", as you want to preserve the formatting of the diagram.

> +      An array of GPIOs one per segment. The first GPIO corresponds to t=
he A
> +      segment the last GPIO corresponds to the G segment. Some LED block=
s also

.. segment, the ...


> +      have a decimal point (currently ignored).
> +
> +               -a-
> +              |   |
> +              f   b
> +              |   |
> +               -g-
> +              |   |
> +              e   c
> +              |   |
> +               -d-  dp
> +
> +    minItems: 7
> +    maxItems: 7

I guess it doesn't hurt to have "maxItems: 8", so people don't have
to update their DTS later when support for the DP is added?
That would need an update to the description above, as the last segment
would then be either G or DP.

> +
> +required:
> +  - segment-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    led-7seg {
> +        compatible =3D "gpio-7-segment";
> +        segment-gpios =3D <&gpio 0 GPIO_ACTIVE_LOW
> +                         &gpio 1 GPIO_ACTIVE_LOW
> +                         &gpio 2 GPIO_ACTIVE_LOW
> +                         &gpio 3 GPIO_ACTIVE_LOW
> +                         &gpio 4 GPIO_ACTIVE_LOW
> +                         &gpio 5 GPIO_ACTIVE_LOW
> +                         &gpio 6 GPIO_ACTIVE_LOW>;

Please group GPIO specifiers using angular brackets:

    segment-gpios =3D <&gpio 0 GPIO_ACTIVE_LOW>,
                     <&gpio 1 GPIO_ACTIVE_LOW>,
                     ...

> +    };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


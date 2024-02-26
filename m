Return-Path: <linux-kernel+bounces-81846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CE4867AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D624D1C24527
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C47B12C7F6;
	Mon, 26 Feb 2024 15:52:51 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5C212C547;
	Mon, 26 Feb 2024 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962770; cv=none; b=Z3uD8mLR5DJOMLhLLin5HV/p51Aipg6oakX91zcIQSxQl27vVxVQnLXUS5jV9P53s/yp5P5F/KIBsGJPud0p1LNYFra2ZquokDwLayN5A1MCAF9IFfwyoO6p8THxdsGdoy9E8baTxlqSXoAfPubk0zpoP9anYh3ih6LOz+agGt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962770; c=relaxed/simple;
	bh=pa99d6Kn0RfwDfANyW2C2EfQymCn/sNS9dARIOHxPyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOM2A0A6CEpQKF4xwqpg5aDaY05KmBWC5uOfjewWw41CdzYlI/rZIlK7ZHWD+fvosK2J8e0Yn14OOzVhhvpEWuhbIuddMx4IU7lqkhYoKciH5vowBFz1VfhE2toDCHQL49j9mHTMqXdIO1YFmVZtnYhevyqLPp93NMG/br0B5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-607c5679842so32180877b3.2;
        Mon, 26 Feb 2024 07:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962767; x=1709567567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QF9GG836vrtAhuBq8aNNcfaDPPzczaK2HeQ5Uo5m9CY=;
        b=RHmBKvoEK6cfBH1i7MAfYai+4O/6V+4oyhZRIgBYgaa/21aDf6gn+qdjhsObzuHihh
         Tl/KdrcBB4SsjUjFqEnjscENjznsT7xredfOVF2wu6mt1kMCBPNqbPi7g6XyJuCzxAcs
         J/XC5jW5wuIqYJledg3rKpCR0xmMjhGpxGPh2iPBltWblQLT/sDPnMudC2eDlsDD3nu3
         DClqGsnhv2dA8WelCF4E8x5Sx6pTNwv2P1IhsbU351Y7xQ4iYyMLARHIjLq9Gbp3t6ds
         Ux258DHc2xqvsb5n6+wXhV3p+WQoupScFuHeduYGXAtiHpcsZtJu4YWDOkz3IkmH71p/
         Vx5g==
X-Forwarded-Encrypted: i=1; AJvYcCUb6W27HNkKxif1dpkgaclfWshdW7hrN4meIeQLMlOySjDC4dFtUumaZTB3c6YDLay+YxHp3iEReBQmQcO5TPG35BJDlhznqGiDwZD4qA0lDIVNzu8HeeqoRuTMpNvMOAhPxqWbuB4QyA==
X-Gm-Message-State: AOJu0YyZoGHN9Mq1YmIFJgkgoy8/LqUa7+gx8Y2BlHllRy0ryuyrkiba
	0HSMS9G/GbSX3O4AXBj6NzsCfFcJRmZI6sggKxJWUbs3qhp5j+BIVG8N8ZQ6BIE=
X-Google-Smtp-Source: AGHT+IFOm5hvQZJh4fbqssroS96CAdD8O12cxnZzQZ868+EAKuaMOxib7oBm/bRqRXu/yfXgBiLh4A==
X-Received: by 2002:a81:9107:0:b0:608:acc0:d2f2 with SMTP id i7-20020a819107000000b00608acc0d2f2mr7208332ywg.28.1708962766554;
        Mon, 26 Feb 2024 07:52:46 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id p127-20020a815b85000000b00607af248292sm1245583ywb.49.2024.02.26.07.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 07:52:46 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso3149491276.1;
        Mon, 26 Feb 2024 07:52:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwTsuHTLfboTuEqTIYapRCeGkC1UMB5VsEfsMZp588tsrenW2BMwNLMYyTcakJdRczTvmcpZQQhFLGtmlJCW4+RSYe4H26aiodmNwH3OqbcdnzSkouGfOzfaotjJVizZM5I1IiM2tYUA==
X-Received: by 2002:a25:ec03:0:b0:dcc:54d0:85ef with SMTP id
 j3-20020a25ec03000000b00dcc54d085efmr5609539ybh.5.1708962766201; Mon, 26 Feb
 2024 07:52:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com> <20240219170337.2161754-9-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240219170337.2161754-9-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 16:52:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVjh3jofcf2SdjRO5bAfokEzjoxv_z89JJyyfwwt5DZsw@mail.gmail.com>
Message-ID: <CAMuHMdVjh3jofcf2SdjRO5bAfokEzjoxv_z89JJyyfwwt5DZsw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Feb 19, 2024 at 6:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Add initial device tree documentation for Maxim MAX6958/6959.
> As per reviewer's request mention the fact of absence reset and
> power enable pins, since the hardware is quite simple.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/auxdisplay/maxim,max6959.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MAX6958/6959 7-segment LED display controller
> +
> +maintainers:
> +  - Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> +
> +description:
> +  The Maxim MAX6958/6959 7-segment LED display controller provides
> +  an I2C interface to up to four 7-segment LED digits. The MAX6959,
> +  in comparison to MAX6958, adds input support. Type of the chip can
> +  be autodetected via specific register read, and hence the features
> +  may be enabled in the driver at run-time, in case they are requested
> +  via Device Tree. A given hardware is simple and does not provide
> +  any additional pins, such as reset or enable.
> +
> +properties:
> +  compatible:
> +    const: maxim,max6959
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

To handle cases where less than 4 characters are wired
(based on hit,hd44780.yaml):

    display-width-chars:
      description: Width of the display, in character cells.
      minimum: 1
      maximum: 4
      default: 4

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


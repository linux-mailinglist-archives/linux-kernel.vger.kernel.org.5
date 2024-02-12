Return-Path: <linux-kernel+bounces-61214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4993F850F02
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5031C21048
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9885AF9D8;
	Mon, 12 Feb 2024 08:42:06 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703777464;
	Mon, 12 Feb 2024 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707727326; cv=none; b=IKFX7sPknLHKFzQeJS/l8ihj37ex7tqoQniwU659L2hKc8qZKU3MI37z/GjGihLbDaeKRTSsZmL8obIGnd7iJ4UoWAdg2N5G13tfkXtCU5Udd9VGBvPmZHVcyxxKizIbERxPNuGDwjSkZfSNFTVQnHHbW40Ci6R38esmk1IJQs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707727326; c=relaxed/simple;
	bh=3s7+euHTIOhSaH5VjIi6VQcGKcAIeqQ/AxNAUR7MPoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqLsWu9GG5lpa+gG+jkQRLvwle+f/jPbhZ0r9YVftvH7nUzYCjlUsru+92NoUEfuzVSOYovlItZxffSkw4WjyewcwpInbvZjyD3CAXRvfPY4oV0d5JtQPg/lMjtRNgye3DUWpIy8mZdQTpNGsV1c+mbf3MbcNmTUUYHrXhCJTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-604aaf2d047so29738727b3.0;
        Mon, 12 Feb 2024 00:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707727323; x=1708332123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sDJfR8Jo81p7fQ0i3luHWg1ByshF+eCyOvnmxC+Z6Y=;
        b=Sr1BSsAYBs5tHn91SLPPopmiAr8AiGZMg1ejynZ5GB5tuPIIi+b+4QtRtvuID6ztCp
         hD/jZfzgiwdZ1bBRrpiQC1cEDap5FBjFNhMle5LI4W3G4FaW56UtpSIGK9zc6VZ1HYdp
         T4KGaI72MNNqwUp8ZEz2+X79n4NIK3MRUbkb+aLbhXLu11HT/Ratxl2Ap2JazNr3Sfrs
         bMM3y+Y4cU9AK3pwEz/fjWaFsbRgd2r1jS6Zea5t1XIW7IDTEkdDC9mvl3N+RmzDu0UZ
         LMnniCuifK2Ijy3NuWwaNh7Zopqj1vFPpclWTxEGfgWtVnzuXhAYnVQWfcKeqxCOZGuG
         Zerg==
X-Gm-Message-State: AOJu0YxxmepiqJ3SxREoSF5o3JL5vkglR1B/AKE7+vJuYOAmhZezJAYR
	AYKsEpkoRQeucCnpi825bPPGcSyNdhcFQbvKsqcw7tWTj6FjR7zTw/nV+pfC26M=
X-Google-Smtp-Source: AGHT+IEA9vzHwX/8frJqfQfqUM8/dN96NAedlWxLgP/nvTSIEv3NVJaViSiCNPnlbq75FUrIzVhqIA==
X-Received: by 2002:a0d:e851:0:b0:5ff:6552:8f57 with SMTP id r78-20020a0de851000000b005ff65528f57mr4965108ywe.39.1707727322750;
        Mon, 12 Feb 2024 00:42:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJH/weaQZvaXU/0WWOhp20x4tSOjQfPNtGwcqIjMFw+ohFLN9Lgcws43boZXWXhpVRLduZaNTTtjPQfP4UfJwcIT2rz8dEtvMIqUvEaT6QdKKpFhXAi4YFK+L2eXOBH96OoDN8VfQgTA==
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id y77-20020a81a150000000b005ff9d3ca38fsm1101664ywg.1.2024.02.12.00.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 00:42:02 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbed0710c74so2345374276.1;
        Mon, 12 Feb 2024 00:42:02 -0800 (PST)
X-Received: by 2002:a25:9205:0:b0:dc2:3b5f:b80 with SMTP id
 b5-20020a259205000000b00dc23b5f0b80mr4967597ybo.44.1707727322147; Mon, 12 Feb
 2024 00:42:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 09:41:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU-c5_Z2AMNtNH4Cc4JUrn+oKU-1CumEOAP6=5Zomcj_A@mail.gmail.com>
Message-ID: <CAMuHMdU-c5_Z2AMNtNH4Cc4JUrn+oKU-1CumEOAP6=5Zomcj_A@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: auxdisplay: hit,hd44780: drop redundant
 GPIO node
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ralf Schlatterbeck <rsc@runtux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

CC Ralf

On Mon, Feb 12, 2024 at 9:34=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Examples of other nodes, like GPIO controller, are redundant and not
> really needed in device bindings.
>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
> +++ b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
> @@ -99,17 +99,7 @@ examples:
>      };
>    - |
>      #include <dt-bindings/gpio/gpio.h>
> -    i2c {
> -            #address-cells =3D <1>;
> -            #size-cells =3D <0>;
>
> -            pcf8574: pcf8574@27 {
> -                    compatible =3D "nxp,pcf8574";
> -                    reg =3D <0x27>;
> -                    gpio-controller;
> -                    #gpio-cells =3D <2>;
> -            };
> -    };

This part was added delberately in commit c784e46c8445635a ("auxdisplay:
Add I2C gpio expander example"), to aid makers who are not DT experts.
Note that there are no other examples of this popular wiring scheme
in upstream DTS.

>      hd44780 {
>              compatible =3D "hit,hd44780";
>              display-height-chars =3D <2>;

If you do want to insist on removing the i2c GPIO expander part,
I think this node should be removed too, as it is almost identical
to the first example.

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


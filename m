Return-Path: <linux-kernel+bounces-49446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA48846A6A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D28A5B2A06B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0096E18032;
	Fri,  2 Feb 2024 08:11:17 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B0047F55;
	Fri,  2 Feb 2024 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861476; cv=none; b=ucUAyLFjpddUrqWXTpH9hPDzz4+Jtgu+8/jQcjzD85fkR6UE2DqIorZRvVu7VzJfV0Nay8J7SGZ/d4Zb7e84oB380o5XKz5gAZw89ObuqeeYqujqPEnmaAl6CR7HYcw9WwE+ssNDyQHLwJgHFpSAa2225+rmbn2BrnrTvYfcjrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861476; c=relaxed/simple;
	bh=o3wPyRXEPoSF+U7A/RsmBapsWEQBn3I78JpEMkHDxPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6PjeuzoNwWr76aKwWzOObKoIgzzD38qeWj2m+J5OdSu6kal2HOpEMeonr2sSRYwQd6aVSUR1h0kNaZ1a4LX2ea3RWXJGIIIDNKNKiYsrDufnRQXRUi8bpSMss1xiU4xLlB9oh6t/6E0ZsqFSeeFV3vyeu+cZuGf5w8mN0pnBVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6040e7ebf33so4126617b3.0;
        Fri, 02 Feb 2024 00:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706861472; x=1707466272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7OoK/n68hP5aJbuOodgIidDfY/+GTLZ17QcyZGeA8I=;
        b=WNjoF3ItnQ/pK7SQ+3P28mLJvATSXret2Yr1J4RotqzUlkEOO4ELsiO1wHseaWCHPi
         uQ4JOClapmdySrK/tT0rK3bUeh6vkbwnlPRheUzSoFRvZxwbGKYiABNLiZSmvMHqb6M3
         n1MN2ir/gjoE2SS6Vm50Xk2CZlnmQba2do1PhqdT7Z59vghlPnhkS78uPWuCt7WYgIWY
         FBVuOQHjORoTdpPWwzB+864lVBK8te/aKJhVRHrwk88RDfPiq+t7nD23ZWlhN7bMsibg
         Kax1O/PhcF3f7XrxcNn4If94xhiTfp+N3hX4EJMwho/4tUQSEj0xeDhBfYVW1bQlV7Tf
         5P0g==
X-Gm-Message-State: AOJu0YzTalJ+qThFV9y9H9lIVYKVbDUInAE9gpfmCyRqSQ3HLmZ9kcLi
	zd9pdutbhwcxh0u+urB/2y05HNV98pkjyUIW28e+fCFcyreTsHtfhkB6lWXNRy4=
X-Google-Smtp-Source: AGHT+IGa+FAvaaF/PkZN0J/RKo4mtyCQu74u3vuXy4ZmvjsePaqRE7Jl/L2qf7Jmss5gQDr67tXy1Q==
X-Received: by 2002:a81:4f82:0:b0:5ff:a961:d91c with SMTP id d124-20020a814f82000000b005ffa961d91cmr1185104ywb.1.1706861472604;
        Fri, 02 Feb 2024 00:11:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUiHaMF4Jaj27UNM58du4HOo+4B68M/GvAuRaak/j5L7UP5/ugzK5FwpXguA7HGfLHE4JI+EWyHoOIwhyYwNTSUqE048BX59Kopf2E9/MQH1r54odQwsd5k7JhwCdXtX8xgmZ0AApbA3ZL3SUjNFD0Z7JpJSto/5JzQ7cEU4hJQWMM4nIc=
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id cd18-20020a05690c089200b005ff98d9a7b8sm302728ywb.19.2024.02.02.00.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 00:11:12 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so393784276.1;
        Fri, 02 Feb 2024 00:11:12 -0800 (PST)
X-Received: by 2002:a05:6902:2489:b0:dc2:23b1:eaef with SMTP id
 ds9-20020a056902248900b00dc223b1eaefmr1451206ybb.18.1706861472161; Fri, 02
 Feb 2024 00:11:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706802756.git.geert+renesas@glider.be> <b20aab137058c02ab5af9aaa1280729a02c6ea49.1706802756.git.geert+renesas@glider.be>
 <20240201221151.GA1562458-robh@kernel.org>
In-Reply-To: <20240201221151.GA1562458-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 2 Feb 2024 09:11:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWmVs2m3bX=21Ocw8y=8WDJfFy2dami3aC9Kj-4PokDEQ@mail.gmail.com>
Message-ID: <CAMuHMdWmVs2m3bX=21Ocw8y=8WDJfFy2dami3aC9Kj-4PokDEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: dt-bindings: gpio-regulator: Fix
 {gpios-,}states limits
To: Rob Herring <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Thu, Feb 1, 2024 at 11:11=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> On Thu, Feb 01, 2024 at 04:58:41PM +0100, Geert Uytterhoeven wrote:
> > make dtbs_check:
> >
> >     arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb: regulator-vcc=
q-sdhi0: Unevaluated properties are not allowed ('gpios-states', 'states' w=
ere unexpected)
> >           from schema $id: http://devicetree.org/schemas/regulator/gpio=
-regulator.yaml#
>
> Unevaluated properties warning here is not interesting. If a property
> fails validation, then it is considered unevaluated. It's that warning
> which is interesting:
>
> arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb: regulator-vccq-sdhi=
0: gpios-states:0: [1] is too short
>         from schema $id: http://devicetree.org/schemas/regulator/gpio-reg=
ulator.yaml#

Oops (again, I'm afraid my mind is already living at FOSDEM ;-),
I copy-'n-pasted the wrong message...

> > The number of items in "gpios-states" must match the number of items in
> > "gpios", so their limits should be identical.
> >
> > The number of items in "states" must lie within the range from zero up
> > to 2^{number of gpios}.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > The second issue did not cause any dtbs_check errors?
>
> I'm not seeing 'states' fail, but it looks like you did? Is that the
> issue you mean? Looks like in the matrix case, we're now setting
> minItems if unspecified.

No, I did not see states fail, only gpios-states.
Hence "the second issue did not cause errors".

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


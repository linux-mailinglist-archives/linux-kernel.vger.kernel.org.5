Return-Path: <linux-kernel+bounces-48802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C560C8461C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3731B2235C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B9E85638;
	Thu,  1 Feb 2024 20:06:07 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F874176B;
	Thu,  1 Feb 2024 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706817967; cv=none; b=Ra4tfbIn2BMLse8xrthG6hQhmsvSNug6g8OuPEQx/ICbQst42fB1fNB2JEviy4F41hQi7FAuJvj7FCdnFz1K2E5QoiybqVNZ+Yd1dG8chxZIWosKNLZ5WyPFso0cMOQtDygoDSQe/PThYNue+6CoMUwMHxn4HVTLHyMt0OZHy9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706817967; c=relaxed/simple;
	bh=gkH8/pxKYHSTaCK13vrWJcmjWEK0Tt9tmbvF+BfSfLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMS9BOOjkUq0OtikXeBiMolfkOYpUDGAK6WMe8LcOHKsNsphDOOXqLFgycnyLxta+/56BnvfGZP/amQ20XE/R4sAni+otE8BUnW5N2CExJVH89wf7U/BT66zCQYNwYJL8TU1lM08l0AON1FtlngjYXB+DCVpYGNUHPYdRmJoypE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bbc649c275so794329b6e.0;
        Thu, 01 Feb 2024 12:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706817963; x=1707422763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rW2ZDwtdk3kDeJBYbJGjBGq8DnNTgVshHb5YupyHpEo=;
        b=iOwDAh4IP8nsFtl5RywPoX3dtUPjXL+u93ssiqcGmMI73gdM8dVXyIhSuk19xQaoeI
         F67n316Jvx7sfC4FsvlzN7c5xc5leMKB+D5B0uq3t6F78fnNwoPJCyI4mgJ2x0Qqoooq
         TLMnq1+raz+aYCcIPYL2TkKkfw1yj2RFCL5KgguiL5HdBFgivBxZauUUg4Fs/SRFqtOJ
         aFa3UWHzrsqIYS/dehGmLU9oAdA66JlB9ubD1fi/9jSkYUJWmQgN/DV2zNU69XAaK+CA
         fcvqBrpYGJyWcQxQE3MRWgq8BjSoPjEQ+GJerUzrUbkBvn9C5SBqLLw8aX7b9sSuBdHA
         0x9Q==
X-Gm-Message-State: AOJu0YyeHr8BcE/OOMh2dhZxOqA0YqO9ZU83weZZGh3dVzkaseNOa5Lf
	gHYxGo+RpPVeizRyxSY2BDj1By+PhaU5nNwFjR/DYbFJmQAEsKyKIRw5l/ycoIU=
X-Google-Smtp-Source: AGHT+IGPYWyOZXU6pjRuWu7Y8OLEFwEQsafle/0m1Yib5u4+HtJQxv1ndATrEmcdxgZIzjieSp3Kug==
X-Received: by 2002:a05:6808:3990:b0:3bf:bbda:9db9 with SMTP id gq16-20020a056808399000b003bfbbda9db9mr332790oib.15.1706817963118;
        Thu, 01 Feb 2024 12:06:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXTgb8PWYor/xrkzQ82rqj1tAoKuG9KZ4ujo+eeiAA2SiYo3zOnGYjz5QbctNS9rdUqFMPbducf3tCO7x5WwVfAcer4JUvTJZ5t2Ez4Nz330lpiBbJJ42WyJlmqKhHBC0sclCaQO+1Ev5l2aeDhrN5vlZyd9HiZ8A0/PpedZa0rLRGmjyc=
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id n23-20020a25d617000000b00dc6e30b77b3sm59093ybg.55.2024.02.01.12.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 12:06:02 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso1050906276.1;
        Thu, 01 Feb 2024 12:06:02 -0800 (PST)
X-Received: by 2002:a25:9346:0:b0:dc2:2979:fcd5 with SMTP id
 g6-20020a259346000000b00dc22979fcd5mr118750ybo.28.1706817962160; Thu, 01 Feb
 2024 12:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706802756.git.geert+renesas@glider.be> <b20aab137058c02ab5af9aaa1280729a02c6ea49.1706802756.git.geert+renesas@glider.be>
 <170680870030.996964.6959185693674664805.robh@kernel.org>
In-Reply-To: <170680870030.996964.6959185693674664805.robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Feb 2024 21:05:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWfovGkvrk4coitFgDTuHS_fQcvFb8kJj-1AWtUgkAYgg@mail.gmail.com>
Message-ID: <CAMuHMdWfovGkvrk4coitFgDTuHS_fQcvFb8kJj-1AWtUgkAYgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: dt-bindings: gpio-regulator: Fix
 {gpios-,}states limits
To: Rob Herring <robh@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob The Robot ;-)

On Thu, Feb 1, 2024 at 6:31=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
> On Thu, 01 Feb 2024 16:58:41 +0100, Geert Uytterhoeven wrote:
> > make dtbs_check:
> >
> >     arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb: regulator-vcc=
q-sdhi0: Unevaluated properties are not allowed ('gpios-states', 'states' w=
ere unexpected)
> >           from schema $id: http://devicetree.org/schemas/regulator/gpio=
-regulator.yaml#
> >
> > The number of items in "gpios-states" must match the number of items in
> > "gpios", so their limits should be identical.
> >
> > The number of items in "states" must lie within the range from zero up
> > to 2^{number of gpios}.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > The second issue did not cause any dtbs_check errors?
> > ---
> >  .../devicetree/bindings/regulator/gpio-regulator.yaml         | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/r=
egulator/gpio-regulator.yaml: properties:states:minItems: 0 is less than th=
e minimum of 1
>         hint: An array property has at least 1 item or is not present
>         from schema $id: http://devicetree.org/meta-schemas/keywords.yaml=
#

Oops, I changed this from 1 to 0 _after_ running dt_binding_check, so
I'm totally to blame for this.

The description says:

    If there are no states in the "states" array, use a fixed regulator ins=
tead.

which I misinterpreted as "states can be empty", especially as the
driver does seem to support that?

I guess 1 is the proper minimum?

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


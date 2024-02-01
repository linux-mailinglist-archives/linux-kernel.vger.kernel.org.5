Return-Path: <linux-kernel+bounces-47857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F448453C7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AB01C26CBC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1823F15D5AD;
	Thu,  1 Feb 2024 09:22:16 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C93915CD59;
	Thu,  1 Feb 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779335; cv=none; b=Bvq6Hd5w18fi1pnwUOekrmdlrm2J5WyAP53o5FG9g3caJ8mpiIKyO6XCVz6XqMqsVgYYlswBsqDvxXy9hO1xb/WsNjBeMn+UeXQMgkV4uRUJClcQLSCchMHA6QpFIDNvm+XeFqVcR+fUG6xM1NPAsGiNYfsNUOwdY/9nEteYmJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779335; c=relaxed/simple;
	bh=al1OXT3b4ZNm+oAqseaUr5rbOswfuhlYywbfkVT/QTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkcUVLRffCgagG15QZ1UNUU6dC4pxYpqJJz67F6h/w31xHBjCWgK3wbbxwJ3nc75Ohe02SqY/lrxc9ckj0ez42gt2maEGdgFX+TF8CuQELh9zYeRjxmQsyglJUBxlRvRWc7Mf9Fcou02siICH08UfF6kxYV34KoQ52etvz6NH8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ffdf06e009so6959237b3.3;
        Thu, 01 Feb 2024 01:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706779331; x=1707384131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeOVkvGjHG8vKffIVzdxVjnEBY9Jb+dC/AhaTOMUW0U=;
        b=YIA5GFYJ9Bp5Lo54rMijHTM4cGQWRni4UTCAeRnz17rF7DMBQy0jxbbQ08UZxa2g5C
         fcSUbgeFYtUtfVigbS9Ye4pNyyGTv4t1cJKrlo4wuf5YHEAPvPMw3U0qHAwcgFSJjpUV
         /3q+ML0JV7NwoBUrq77HHuzyJYQ6zzRzQ7tJ14M6vumHx7g4LslGg3gZ8TOYSfySowA+
         k0mAqJ38057GEcXLlcLgzm1r9u/FbFUH6X8vD10LDzi7vOfo1hYj8vYVvEJXWksSdUnd
         /qsEUIG1XFUE4nOmlepacqjRYaystdnBWlnjWGJdQXP8zbG98kJeJR1oHpIGHYMd7rHi
         d4yQ==
X-Gm-Message-State: AOJu0Yzd3yXS7BAbl2gGl91KexcHZyzzcMEgKTgGCQr1d/x5wdnUVtm4
	H3ztp3vPelVggH7J68LRqtDHjXgNLRaFiFgnc6xTwgntMqjd/BalmtHVuoLAIYw=
X-Google-Smtp-Source: AGHT+IHA+fzM83bO8SBIWNrSWhdUuIe7MjEEIAB4WiKM5Tdbu3sMZ6IvCy/XiYWKSg4EYvjf/oud6g==
X-Received: by 2002:a0d:e2d7:0:b0:5ff:fdd5:d368 with SMTP id l206-20020a0de2d7000000b005fffdd5d368mr1923515ywe.44.1706779331611;
        Thu, 01 Feb 2024 01:22:11 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id gt16-20020a05690c451000b005ff8bcbe01dsm4248271ywb.16.2024.02.01.01.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 01:22:11 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6041c6333cdso4651007b3.2;
        Thu, 01 Feb 2024 01:22:11 -0800 (PST)
X-Received: by 2002:a81:b65b:0:b0:5ee:65b3:f289 with SMTP id
 h27-20020a81b65b000000b005ee65b3f289mr1815979ywk.3.1706779330966; Thu, 01 Feb
 2024 01:22:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130095222.11177-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240130095222.11177-1-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Feb 2024 10:21:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUB_9TNzo+GFbDZO-gjBUGfk7O7aEyJYG5pCw-Z1nK-pw@mail.gmail.com>
Message-ID: <CAMuHMdUB_9TNzo+GFbDZO-gjBUGfk7O7aEyJYG5pCw-Z1nK-pw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: ulcb-kf: document a problemw with
 old firmware
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Tue, Jan 30, 2024 at 10:52=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Old firmware set the GPIO to output, so no interrupts could be read.
> Newer firmware does this correctly. The exact version could not be
> determined, sadly.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> +++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> @@ -324,6 +324,7 @@ gpio_exp_77: gpio@77 {
>                 reg =3D <0x77>;
>                 gpio-controller;
>                 #gpio-cells =3D <2>;
> +               /* If these interrupts don't work, please update your fir=
mware */
>                 interrupt-controller;
>                 interrupt-parent =3D <&gpio5>;
>                 interrupts =3D <9 IRQ_TYPE_EDGE_FALLING>;

I'd rather not add such comments (especially +6y after the fact), as
this is the standard operating procedure in case something doesn't work.

Do you think we should sprinkle the following, too??

/* If secondary CPUs don't work, please update your firmware */
/* If cpuidle crashes, please update your firmware */
/* If watchdog restart doesn't work, please update your firmware */
/* If PSCI reboot doesn't work, please update your firmware */

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


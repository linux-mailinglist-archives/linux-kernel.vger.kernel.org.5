Return-Path: <linux-kernel+bounces-54585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D82684B132
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB7D28643B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17BD12D15A;
	Tue,  6 Feb 2024 09:26:22 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320AD1EEE7;
	Tue,  6 Feb 2024 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211582; cv=none; b=NDiguV5Eq70Cibeo4M0BXFj7iJWds2ZLPxKnYz7xSQHtTRVp/trf0FIuS0v83uPeQdGMotI1EehXBaM8suT90eSXa4iDwZm+C5qIM5LKwaBaLYeaTM5plQgXgULsexK3XsF5PySlhUSU7eHzhUX05ZrMxEuFiIG/rChL3aV9H1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211582; c=relaxed/simple;
	bh=q+ipK9Pdt16bN9JLtiBX6eY547sX3sZjEKdN1uB5Yvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfT5FreVgtFrHWpmm6HIUyr74q8A1jL0U2kg3b5dTsQZa6ho8cbKlYhSFTwg6z5MPZHQwC4zyGrDFVLVu88N43BGqHNh4AwxdL3+2xxhyoYu1xvV8pr/R3fwJOVNwJ50d6OicDbBb+jBnvUtdNMqTEeLiVNYL3csruUGLetgfao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6047cfd1f5cso3215167b3.2;
        Tue, 06 Feb 2024 01:26:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707211577; x=1707816377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2vNm5vci5F+R+oBGRNTgxDB8K1oVhEs6yL2hE7dnho=;
        b=uAgEH3PpUNrfU/M/WzHZIB78ozjss/hQbLyEYO19NHwyHhQ3x1MNh6vKC6wXL0tUNp
         DeNUClA9+nilQohf/ycu+VctiQVEfgcMVBiCIeGaZ91GQjUNVrfbn6ex5waqIK9yyrvT
         3awLplnKoRKvslCDldOo6ehi4vdhw2Gpyw0AFWXewQDrDWqVeDEVHIycVWFbqygErhjT
         8qQOZW5xktXA0Lu6RmMVY5jp4SOrZhX+ibGAP6nF1vwTvjG0ChyxF5vgHJ4OUi4yPe8/
         57arMEpMxKoZrZaAoWjkZqQ3ixq9rSgTEvQMVAZ6vsdw8D6a4t/HuBItOTzIoc1EHjMf
         4vnw==
X-Gm-Message-State: AOJu0YwXhpgjGE7ERplug93N4P6ymobhvkhosB9GSUya3jrHXo6rLnsX
	XBxebcVNTZBLuVl92aAG44HhRsq4TXV2xL3EM0/dteyDruy76Dsk3l4eNGt+Yvg=
X-Google-Smtp-Source: AGHT+IGNZFJB1YIfcX+PvAZF+1ylnMVGIltLm1w77cEIE4TSPUWmFzXfCMtrUphbvccgsOc9gWv2eg==
X-Received: by 2002:a81:e80b:0:b0:5e9:dca:1b14 with SMTP id a11-20020a81e80b000000b005e90dca1b14mr1155848ywm.7.1707211577512;
        Tue, 06 Feb 2024 01:26:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWqI8UZILc36CTWWWfDsom+7/v6tMP3pn7xtVfp37v6eqGVI3zW+o0EWT8bb3pNgzgQWhC96QIHrEpg5yVsKgdCQwGKbDCpqMkYS/MHInxWD33L6bsqDHjaB+cWG5GocFvqQfxWPu4k+1G24AeU2RXQL5PZIj17EXEUXCi0FdciF4/innApR70=
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id dt10-20020a05690c250a00b0060409872f1asm392805ywb.100.2024.02.06.01.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 01:26:17 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-604713c4ee5so10966117b3.0;
        Tue, 06 Feb 2024 01:26:16 -0800 (PST)
X-Received: by 2002:a0d:d8c6:0:b0:602:98af:b469 with SMTP id
 a189-20020a0dd8c6000000b0060298afb469mr1143306ywe.9.1707211576249; Tue, 06
 Feb 2024 01:26:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da6af483-5ee9-45cd-922e-d9d5364674dc@web.de> <CAMuHMdUxn4Ne7kmEfONz8Uk3Why3m9r83GdM5RzTxm_4Gj_a6g@mail.gmail.com>
 <6e397bf2-1d45-434f-8619-58a737a138e3@web.de>
In-Reply-To: <6e397bf2-1d45-434f-8619-58a737a138e3@web.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Feb 2024 10:26:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVWbG6vG4PkbBZ2V+GYbFdnxOgogHUrdBNj4bFYaDafKA@mail.gmail.com>
Message-ID: <CAMuHMdVWbG6vG4PkbBZ2V+GYbFdnxOgogHUrdBNj4bFYaDafKA@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: mediatek: Use devm_platform_ioremap_resource()
 in init_scp()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 10:21=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 6 Feb 2024 10:05:34 +0100
> Subject: [PATCH v2] pmdomain: mediatek: Use devm_platform_ioremap_resourc=
e() in init_scp()
>
> A wrapper function is available since the commit 7945f929f1a77a1c8887a97c=
a07f87626858ff42
> ("drivers: provide devm_platform_ioremap_resource()").
>
> * Thus reuse existing functionality instead of keeping duplicate source c=
ode.
>
> * Delete a local variable which became unnecessary with this refactoring.
>
>
> This issue was transformed by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>
> v2:
> The transformation pattern was adjusted based on advices by known contrib=
utors.
>
> Examples:
> * Doug Anderson
> * Geert Uytterhoeven
> * Robin Murphy

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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


Return-Path: <linux-kernel+bounces-148758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 840F58A870A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8DB1F230DE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653D4146A95;
	Wed, 17 Apr 2024 15:07:48 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139E0146D71;
	Wed, 17 Apr 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366467; cv=none; b=K+g7uHQtlS70apqqlrrlxTJkAlt3uMyH3plJQYRHfajnnNtj3DncP6IfiKRL98NHA93ch/hebXl7qafyVzKCqGI0S1iANB5+ZwKDyt6Z6KPcJ00/rvE/IwT+XV1gLybKTqniOXaRbqwNcZqa1TRlL1oS+cV+FMu5c1SlMeyCfEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366467; c=relaxed/simple;
	bh=cGUDXpqRyTtoJVCTkzWt1ExYguS6miyazDkf3wMlAY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXNa17erHSTOjR2bAOniHnXOQLC6fKuEEbvKPs7bEg6jTIlFxBddn5TmjYLMtEiDyJel/5+B3etbYgNGRYn6GzeueGqgvrn0q3cofxkGZ8lvKuGYIWgCp8uyVewPEdlPmFcrVwE+/O3I0hhjyI5pI8WXsXWmeuHp+wZlCl3AAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de45e596a05so61590276.1;
        Wed, 17 Apr 2024 08:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713366462; x=1713971262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcm0f6cgY9tqOKkBlWhGvnzcvnieDLUDH/xJHhGRlvs=;
        b=Yy0mld4E/WlYouZT6+ok5eUAoIUMJF/zuMbRfc8yRxXmwx6la7uFE5hjJvL4J1YuCY
         Xeez48cRkc1q4TTLYnI4B3JZijoyrmWfu7zj5d0UOhMo/JKUSaQERKNJeGKpEY+zMO0Y
         APHQvrEWhMQOhGpyn6omoHNTJunKtnScmKR3D0iI39mfKONlbH6fS+oWSl8RadYqm3UH
         0hnOd+feQ8Wa0OO+ZryO5zfIKodm2cp84AaX4z9aNSd7wfZFLMnwaavghHlrwgFjbv+X
         MtAGy8t/BH+/aD6wszKJDZIpPW/cIpOoYrcLyUKqzWIq0TeQBlx6lV3xIxPq8OBv/aYv
         PaCA==
X-Forwarded-Encrypted: i=1; AJvYcCV1f9KSALGvVPPXGZzcIAt0R0Y9TI5NEtwQOken46hn7+O4HPF0EmLLdzSjKXxMG2uy++ohyYVAysbjnzLwHD4EmuVPySrpIgTy3MAtaq5lq3mkVYJC4yTU4sJPzvkg418Zb8dVk11YZUqupPBe14klnG2J7BIKg9WwDa+hS+pIoKRsdW7FnW1joGVy
X-Gm-Message-State: AOJu0YzS2Q0z+z1PnsW8ITg2SomeXmkLkFmBMp9/KC9sfL5GRydR4PqY
	gd7lt1eAFY3m/fnJrijIkesBbnzZZo8+JjX74h3hgKYP/ipdQ40pLTLP8p8asF0=
X-Google-Smtp-Source: AGHT+IGfFr8duULCgklTts62aOhQumuuAyumbWGz69P7MrBZtdoDeB6xxu+IyUoWJzzukCcUi7rLvw==
X-Received: by 2002:a81:8d02:0:b0:615:2ed7:59e with SMTP id d2-20020a818d02000000b006152ed7059emr15070616ywg.14.1713366461807;
        Wed, 17 Apr 2024 08:07:41 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id y15-20020a81ca4f000000b0061ada21ac4dsm1129380ywk.25.2024.04.17.08.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 08:07:40 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61500da846fso41913257b3.1;
        Wed, 17 Apr 2024 08:07:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUI0acZkYHLGDtmnCsyqBwZpgw558Izil7Ud1sEWegrRdT7u4gRGASYBh7wzFjUaWmjuNPZTOspAfiXlbAu7VjyXInXvbL1dxxoHvaT8eujBt/cTsH2bg/n16rzca9a2LYRLWojv4VA4oziRYz3ggWp8DQN3c8iv07SiHwp5ueXncTFpfj5Diw1JMum
X-Received: by 2002:a81:b54b:0:b0:61a:e3fc:512e with SMTP id
 c11-20020a81b54b000000b0061ae3fc512emr7181123ywk.25.1713366460625; Wed, 17
 Apr 2024 08:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322151219.885832-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240322151219.885832-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240322151219.885832-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Apr 2024 17:07:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWCttb=ze27vfHs7LtjADU7v-nXimH8mm2zj5D6Uyvstg@mail.gmail.com>
Message-ID: <CAMuHMdWCttb=ze27vfHs7LtjADU7v-nXimH8mm2zj5D6Uyvstg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clocksource/drivers/renesas-ostm: Allow OSTM
 driver to reprobe for RZ/V2H(P) SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Brandt <chris.brandt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 4:13=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ/V2H(P) (R9A09G057) SoC is equipped with the Generic Timer Module,
> also known as OSTM. Similar to the RZ/G2L SoC, the OSTM on the RZ/V2H(P)
> SoC requires the reset line to be deasserted before accessing any
> registers.
>
> Early call to ostm_init() happens through TIMER_OF_DECLARE() which always
> fails with -EPROBE_DEFER, as resets are not available that early in the
> boot process.  To address this issue on the RZ/V2H(P) SoC, enable the OST=
M
> driver to be reprobed through the platform driver probe mechanism.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> - Updated commit description
> - Dropped usage of IS_ENABLED() and used defined() instead

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


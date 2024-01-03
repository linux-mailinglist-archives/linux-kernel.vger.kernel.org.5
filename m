Return-Path: <linux-kernel+bounces-15342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A39BF822A68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4273C1F23DCE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DFC1862A;
	Wed,  3 Jan 2024 09:46:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8818625;
	Wed,  3 Jan 2024 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5edfcba97e3so56103087b3.2;
        Wed, 03 Jan 2024 01:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704275209; x=1704880009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihhhQFZaZR4+J27tLwPbBpD9wwAmji8BYJHqOMirIeI=;
        b=EmJcfOGM+457bmt2vTw01wmY2hP7VeI+xzp6zHz2ntlho2l4ozsxsDY8zyyWBxxe+g
         2A3WFTot8PzMx5ZloJ1l8rJP5Dp/6/Hleh5xLXI8EgepCBvtej/3l8tEKWc+rGRfcSNS
         +dfLHkWnKYKgnkBFjwaAYjon5nF6DuLm6QRL3RcGGTmnI0R6YTh0BMO70EftoqZ7tPvq
         hR4bh982ju9+QVxI2nb+/PdxcfW+zRmC9lkCDwik7KUcaTSGVuPQsAkKqEKOdYZBQA9y
         rHIoJSaFrqJ+CHZgYpFGH40lfXwyxofHUmo9Mdw+jZP0Qu0b6KuNCwvikGkGb05NnN8T
         IrWg==
X-Gm-Message-State: AOJu0YyIRNTKJwfFZfAs0DwifgtO8BrIzBck9V6NC/zrN933dUnUUyM5
	pwJbh2Iqg3RlS/vOeaYXrHsqdsANJuUjXw==
X-Google-Smtp-Source: AGHT+IG5DoeCebu1mnPf6/+snrmyaMw4m2cgTIOf3MnEPMcsooUQPv+W+XJYZiEPdbWHmdx5xWXBiw==
X-Received: by 2002:a81:9156:0:b0:5e8:7687:77c9 with SMTP id i83-20020a819156000000b005e8768777c9mr11218265ywg.1.1704275208963;
        Wed, 03 Jan 2024 01:46:48 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id r38-20020a814426000000b005f134299392sm3749487ywa.52.2024.01.03.01.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 01:46:47 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5edfcba97e3so56102857b3.2;
        Wed, 03 Jan 2024 01:46:47 -0800 (PST)
X-Received: by 2002:a81:80c1:0:b0:5e8:6aba:9d18 with SMTP id
 q184-20020a8180c1000000b005e86aba9d18mr14346275ywf.35.1704275207623; Wed, 03
 Jan 2024 01:46:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103015240.1065284-1-pvorel@suse.cz>
In-Reply-To: <20240103015240.1065284-1-pvorel@suse.cz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 3 Jan 2024 10:46:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
Message-ID: <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
Subject: Re: [PATCH 00/36] Remove UCLINUX from LTP
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>, 
	Andrea Cervesato <andrea.cervesato@suse.com>, Greg Ungerer <gerg@linux-m68k.org>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Christophe Lyon <christophe.lyon@linaro.org>, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

CC other uClinux arch lists

On Wed, Jan 3, 2024 at 2:52=E2=80=AFAM Petr Vorel <pvorel@suse.cz> wrote:
> UCLINUX is broken in LTP and nobody really cares. Actually I dare to
> say UCLINUX is dead. Therefore I prepared patchset to remove UCLINUX
> from LTP. We have been actively removing UCLINUX from LTP during rewrite
> tests to new LTP API. This removes the rest from the old tests (which
> will be sooner or later rewritten to new API).
>
> Because the patchset is quite big, I did not want to send it to mailing
> lists (but I can do it if you want).
>
> Can you please have look at my fork on gitlab, branch: remove-UCLINUX
> https://gitlab.com/pevik/ltp/-/commits/remove-UCLINUX?ref_type=3Dheads
>
> Build test:
> https://github.com/pevik/ltp/actions/runs/7392470215

Thanks for your series!

I see you only CCed linux-m68k, but AFAIK, uClinux is not restricted
to m68k/coldfire, but also available on arm32, riscv, sh, and xtensa.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


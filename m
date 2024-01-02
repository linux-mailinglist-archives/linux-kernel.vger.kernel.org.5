Return-Path: <linux-kernel+bounces-14241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F578219AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DEEC1F22258
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65AAD2E2;
	Tue,  2 Jan 2024 10:28:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D2DD285;
	Tue,  2 Jan 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5edf3780534so40861667b3.0;
        Tue, 02 Jan 2024 02:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704191300; x=1704796100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGUYue1hsQCNLrCF4HXCzjQx8nMIh5sStGYQ5m2PA10=;
        b=IhF8XbFOtM2sbFIMTsvtFcYVn+ZhlUEbik3Am4co+9XxYgYZzesV+ymi3wrCx9/duu
         nZRUzM/rHrRFKnetQZelKIczbYooxe2AWVbKPXNd6OMUddNChMF8EJ7+R15Geh8BzidH
         xeaeQcuWjQ/aNSUZ/1YgVdf2sh7020PMsC/xcxHvlFyxd4gxVdYuCXzOmrKbkAgADQr5
         YL2VZk9NQkU+9UTVwqAuRiGnUuAEAhZ48xKbQlgVgeDH3I4KPjFIUamLpYooWC0zb5LY
         aOzJT//5uHPzUZpaaQSqaNEQBzlb0PETS+33zamkIkH3Ve+eeOEGMrt3GdlawiPfuIhl
         1HXg==
X-Gm-Message-State: AOJu0YwMwZSQ/i6EwHUH0Vu9X/dhihrDpwgUdAObBNsm5AOX65WSr8YY
	7q1a1x9Dq36alrz9DPdMbugE95Wa3AVijA==
X-Google-Smtp-Source: AGHT+IHjusxO/DvFDYCLHPOpP3POSSCoqWg5OhYM53rjTxnQmUEmkECOOX8mHPrS0QKALyCEfEBZ/Q==
X-Received: by 2002:a05:690c:309:b0:5ef:91bd:f6f9 with SMTP id bg9-20020a05690c030900b005ef91bdf6f9mr4071978ywb.35.1704191299787;
        Tue, 02 Jan 2024 02:28:19 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id q2-20020a818002000000b005d3ba95d418sm11865738ywf.108.2024.01.02.02.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 02:28:19 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e7f0bf46a2so74147597b3.1;
        Tue, 02 Jan 2024 02:28:19 -0800 (PST)
X-Received: by 2002:a81:b661:0:b0:5f3:6024:53c with SMTP id
 h33-20020a81b661000000b005f36024053cmr393594ywk.32.1704191299465; Tue, 02 Jan
 2024 02:28:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
 <20231217071250.892867-1-mailhol.vincent@wanadoo.fr> <20231217071250.892867-2-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20231217071250.892867-2-mailhol.vincent@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Jan 2024 11:28:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUvqY4VLDS0mW2VbSzTmef9xt+F3FCpRj5-Mv+KeOqyXg@mail.gmail.com>
Message-ID: <CAMuHMdUvqY4VLDS0mW2VbSzTmef9xt+F3FCpRj5-Mv+KeOqyXg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] m68k/bitops: force inlining of all bitops functions
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Yury Norov <yury.norov@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Kees Cook <keescook@chromium.org>, 
	Petr Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Marco Elver <elver@google.com>, Brian Cain <bcain@quicinc.com>, 
	Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney" <paulmck@kernel.org>, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

Thanks for your patch!

On Sun, Dec 17, 2023 at 8:13=E2=80=AFAM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> The inline keyword actually does not guarantee that the compiler will
> inline a functions. Whenever the goal is to actually inline a
> function, __always_inline should always be preferred instead.
>
> On an allyesconfig, with GCC 13.2.1, it saves roughly 5 KB.
>
>   $ size --format=3DGNU vmlinux.before vmlinux.after
>         text       data        bss      total filename
>     60449738   70975612    2288988  133714338 vmlinux.before
>     60446534   70972412    2289596  133708542 vmlinux.after

With gcc 9.5.0-1ubuntu1~22.04, the figures are completely different
(i.e. a size increase):

allyesconfig:

      text       data        bss      total filename
  58878600   72415994    2283652  133578246 vmlinux.before
  58882250   72419706    2284004  133585960 vmlinux.after

atari_defconfig:

      text       data        bss      total filename
   4112060    1579862     151680    5843602 vmlinux-v6.7-rc8
   4117008    1579350     151680    5848038
vmlinux-v6.7-rc8-1-m68k-bitops-force-inlining

The next patch offsets that for allyesconfig, but not for atari_defconfig.

> Reference: commit 8dd5032d9c54 ("x86/asm/bitops: Force inlining of
> test_and_set_bit and friends")

Please don't split lines containing tags.

> Link: https://git.kernel.org/torvalds/c/8dd5032d9c54
>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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


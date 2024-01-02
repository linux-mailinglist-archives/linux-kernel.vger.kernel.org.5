Return-Path: <linux-kernel+bounces-14266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7796821A66
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594EB1F225F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22291E572;
	Tue,  2 Jan 2024 10:49:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAD0E545;
	Tue,  2 Jan 2024 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbdb2433800so6217736276.3;
        Tue, 02 Jan 2024 02:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704192556; x=1704797356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0kwXnD1UP7IPHyIP7CHVuBK/DoK+f+8Bv02dDQmekQ=;
        b=v7HU/KQSSztPX0lOTGinLhOF5hPSeGkTugbm9+ty+p2pkR8G5ZPGE7QOC4wWAh9Yiy
         5/Lf6Q0EFH5nvK40/sIjkbmA9bAFQGUxxO+8hM4zDxCvfV2t09ETGqHr4ROp0UulnR10
         eNFhL4dxiTtptCwzbrvdytN2JHHenq0FBNz9xv9Zbg5p+TH8lwyH+oPWC9ij8LxjHuX9
         EZMYYpWi5n7V/ol8ZyVE0WQJD1EO4qdc7C/hFrjncY5KSV5Vn+B5LxCOw0D/ZAOnMmO6
         dr6r9tQGqJ9S72YumtjsFl7OMkdoYBA69/Mu9wSQhJl0BZOKfSq4ac+1drwIJdBtXxsl
         8Lbw==
X-Gm-Message-State: AOJu0YyePsIYAqaaVHxYsTuEy6hhbrqnLcOXYWd4hy1zkK8tIx39IJ+b
	qlxxAK/O50GjsdKTGuhI4n7I34f3MJnEww==
X-Google-Smtp-Source: AGHT+IGGJ8zEAgXrPxZkflLvziParzRZ4satEEPv3pLGniGuQdp5sL/uFu8nspWnzoPMHX/s6K76Ig==
X-Received: by 2002:a25:1609:0:b0:dbd:750a:e3af with SMTP id 9-20020a251609000000b00dbd750ae3afmr7044382ybw.26.1704192555941;
        Tue, 02 Jan 2024 02:49:15 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id e69-20020a256948000000b00dbd9ad556ccsm10128500ybc.52.2024.01.02.02.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 02:49:15 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5f0629e67f4so22890637b3.3;
        Tue, 02 Jan 2024 02:49:15 -0800 (PST)
X-Received: by 2002:a81:af49:0:b0:5e9:fa4a:fd32 with SMTP id
 x9-20020a81af49000000b005e9fa4afd32mr10248043ywj.44.1704192555251; Tue, 02
 Jan 2024 02:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
 <20231217071250.892867-1-mailhol.vincent@wanadoo.fr> <20231217071250.892867-3-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20231217071250.892867-3-mailhol.vincent@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Jan 2024 11:49:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdULzic+NC+PA7fOZzaXbJnmW+MfCv05j3xJdj1qxPeyQQ@mail.gmail.com>
Message-ID: <CAMuHMdULzic+NC+PA7fOZzaXbJnmW+MfCv05j3xJdj1qxPeyQQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] m68k/bitops: use __builtin_{clz,ctzl,ffs} to
 evaluate constant expressions
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

On Sun, Dec 17, 2023 at 8:13=E2=80=AFAM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> The compiler is not able to do constant folding on "asm volatile" code.
>
> Evaluate whether or not the function argument is a constant expression
> and if this is the case, return an equivalent builtin expression.
>
> On an allyesconfig, with GCC 13.2.1, it saves roughly 8 KB.
>
>   $ size --format=3DGNU vmlinux.before vmlinux.after
>         text       data        bss      total filename
>     60446534   70972412    2289596  133708542 vmlinux.before
>     60429746   70978876    2291676  133700298 vmlinux.after

Still a win with gcc 9.5.0-1ubuntu1~22.04:

allyesconfig:

      text       data        bss      total filename
  58882250   72419706    2284004  133585960
vmlinux-v6.7-rc8-1-m68k-bitops-force-inlining
  58863570   72419546    2285860  133568976
vmlinux-v6.7-rc8-2-m68k-bitops-use-__builtin_clz,ctzl,ffs

So an even bigger win...

atari_defconfig:

      text       data        bss      total filename
   4117008    1579350     151680    5848038
vmlinux-v6.7-rc8-1-m68k-bitops-force-inlining
   4116940    1579534     151712    5848186
vmlinux-v6.7-rc8-2-m68k-bitops-use-__builtin_clz,ctzl,ffs

... but a small size increase here.


>
> Reference: commit fdb6649ab7c1 ("x86/asm/bitops: Use __builtin_ctzl()
> to evaluate constant expressions")

Please don't split lines containing tags.

> Link: https://git.kernel.org/torvalds/c/fdb6649ab7c1
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


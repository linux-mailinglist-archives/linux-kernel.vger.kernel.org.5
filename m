Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2324D79B4EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350471AbjIKVir convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Sep 2023 17:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbjIKNvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:51:19 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E812CD7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:51:15 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5924093a9b2so43711027b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694440274; x=1695045074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDloSeE/RMJ8xb0vN0WHP8xkcaLq8Ztl0V6yiAC98sM=;
        b=r9sFX8hWbTPT52bROUSe/+eE2tafdA0lf0mPl6GFHlvWIX0sr0C31N/I5M2dG4iYsZ
         NJAPZ/KEX3Gzsq9e0Tjq5TFKys8qKOm2QEqOIaNNipB6XVqnt4cW2I9Yx7+HTe/vv8Sp
         azPKrWWfB4u1qiNmcaAY7jouuLSZe9OKG2dm7difW/Z4RBl3OHyiqUpeprSRdNOq6pMJ
         z90ffM25nv4XDruTjaom9kwezaVFfjA02L1QDyqR0maRO+DwiaFimmcZcoWWnPnLO6g0
         5wQdedSSyvOoNTqIbcaqWeiQO6xjLhyg7y/q71FRg9dhJu5thx6//yESN+LEbCWu+yyO
         CnAg==
X-Gm-Message-State: AOJu0YycwF2lAVjd+nL6o01KKh+BMRWrjAVs5Q1Pm7Fau9YaPlwOxZOK
        3ABwcCEOrSh96teIJvBfSsBgiZL6B/i7jA==
X-Google-Smtp-Source: AGHT+IHBo+6fD75/x2bRXOeZsmXKeXcOGXXSbSPYdbCqEPNwBziQjhJ/ZnEdxSD119ZrnljtHI00ug==
X-Received: by 2002:a81:dd12:0:b0:586:a003:b0b9 with SMTP id e18-20020a81dd12000000b00586a003b0b9mr10887884ywn.49.1694440274244;
        Mon, 11 Sep 2023 06:51:14 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id b65-20020a0df244000000b005869fd2b5bcsm1972241ywf.127.2023.09.11.06.51.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:51:13 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d80211e8df8so2815198276.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:51:13 -0700 (PDT)
X-Received: by 2002:a5b:191:0:b0:d08:5a25:e6b4 with SMTP id
 r17-20020a5b0191000000b00d085a25e6b4mr9656076ybl.28.1694440273428; Mon, 11
 Sep 2023 06:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694093327.git.geert@linux-m68k.org> <6894409da1a0d8667bf74b9100067485ce3c37ac.1694093327.git.geert@linux-m68k.org>
 <0424526e-e9fd-7a3f-71ed-c43855ab1290@linux-m68k.org>
In-Reply-To: <0424526e-e9fd-7a3f-71ed-c43855ab1290@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Sep 2023 15:51:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+KNa6VEydk0uA5E2qn96Jb+ejdd8NHjqFRaC3uuCxKg@mail.gmail.com>
Message-ID: <CAMuHMdU+KNa6VEydk0uA5E2qn96Jb+ejdd8NHjqFRaC3uuCxKg@mail.gmail.com>
Subject: Re: [PATCH 06/52] m68k: kernel: Add and use "process.h"
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Sep 11, 2023 at 3:42 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
> Nice cleanups. My plan is to clean up the ColdFire/68000 warnings as well.

Thanks in advance!

> On 7/9/23 23:41, Geert Uytterhoeven wrote:
> > --- a/arch/m68k/kernel/process.c
> > +++ b/arch/m68k/kernel/process.c
> > @@ -38,6 +38,7 @@
> >   #include <asm/machdep.h>
> >   #include <asm/setup.h>
> >
> > +#include <process.h>
>
> I applied all 52 patches to linux-6.6-rc1 and see this:
>
>      $ ARCH=m68k CROSS_COMPILE=m68k-linux- make amiga_defconfig
>      $ ARCH=m68k CROSS_COMPILE=m68k-linux- make W=1
>      ...
>        CC      arch/m68k/kernel/process.o
>      arch/m68k/kernel/process.c:41:10: fatal error: process.h: No such file or directory
>       #include <process.h>
>                ^~~~~~~~~~~
>
> Of course trivially fixed by doing this:
>
> diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
> index d2d6a5735650..2584e94e2134 100644
> --- a/arch/m68k/kernel/process.c
> +++ b/arch/m68k/kernel/process.c
> @@ -38,7 +38,7 @@
>   #include <asm/machdep.h>
>   #include <asm/setup.h>
>
> -#include <process.h>
> +#include "process.h"

Thanks, will fix (and any other similar typos, if any).

I usually build in separate output directories, which causes

    -I${srcdir}/include
    -I${srcdir}/arch/m68k/kernel
    -I./arch/m68k/kernel

to be added to the include path, causing <...> to work as well :-(

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

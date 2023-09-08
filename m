Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D56A79831A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbjIHHNh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 03:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjIHHNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:13:33 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA54419A8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 00:13:27 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4ff09632194so2939880e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 00:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694157204; x=1694762004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0v9HZl10d+1aEuTYsn3si5rKiEVCmNu7rrWd/6QlBLo=;
        b=hXKtP43t23pq6PAaDWBwrIoGVOfxRKAdn7ET6UWJ9XTfIL/u1xWgjlItANrYbWyDSn
         hMspT2AO4T45ZxMr1iZBjaW8wmTKxlNo/X4TJiajmT2GD5elBHMjahG0uF8rNSkkZcYY
         1cWCAeGafOkmu4G6b2CP9mnwEiJMCFNlCDXVWoljHlr9INxnWjMPVbde3iRsgOvf+1cg
         +MXRDcX9uCp02q1crynHU7/q0+LwKmUqsMZ+MytxDtCE2ur5hSj1ipclwz/kU0Cb8XxF
         +daclUbUrRDXV+XK3lShppPpe/E9ZQGWvgXtgAFGAJvUPyGE8JyW14LDiZfqJh4zDqeG
         1hWg==
X-Gm-Message-State: AOJu0YyqTNWoaPVr1RaTDDcDum5qXj+w2Rf3XyUZglkZ37h3CPPDo3Wg
        yA2BY/8E1019Mb/6+lZEd6AA2suN81+kuzyx
X-Google-Smtp-Source: AGHT+IHzxR79IpVmsCeb26PbBXYTH6gAxwr2Z0SJ4nhW+B2rLrlu92oMV0c7KeM9OjD9IysxGLcp3g==
X-Received: by 2002:a19:435d:0:b0:500:cb2b:8678 with SMTP id m29-20020a19435d000000b00500cb2b8678mr1085535lfj.40.1694157204049;
        Fri, 08 Sep 2023 00:13:24 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id b6-20020ac247e6000000b0050294074233sm189460lfp.225.2023.09.08.00.13.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 00:13:23 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso29408981fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 00:13:23 -0700 (PDT)
X-Received: by 2002:a05:651c:1029:b0:2bc:b45e:bb3f with SMTP id
 w9-20020a05651c102900b002bcb45ebb3fmr1188477ljm.13.1694157203559; Fri, 08 Sep
 2023 00:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694093327.git.geert@linux-m68k.org> <0778d9dd186928666d760d5523c7d2311f781621.1694093327.git.geert@linux-m68k.org>
 <142e4eb5-b47e-e27c-1be3-bc6c5df889c0@linux-m68k.org> <6ff868a4-d433-6e92-8bf2-573fee19ce2c@gmail.com>
 <291d4cb0-e3b8-1e7d-8b34-79aee23865fa@linux-m68k.org>
In-Reply-To: <291d4cb0-e3b8-1e7d-8b34-79aee23865fa@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Sep 2023 09:13:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXAEWUvfO8-ASrb=PJwftYEu+BXLzY7kf+aJGY4DuUTbA@mail.gmail.com>
Message-ID: <CAMuHMdXAEWUvfO8-ASrb=PJwftYEu+BXLzY7kf+aJGY4DuUTbA@mail.gmail.com>
Subject: Re: [PATCH 22/52] m68k: atari: Add and use "atari.h"
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
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

Hi Finn,

On Fri, Sep 8, 2023 at 3:05 AM Finn Thain <fthain@linux-m68k.org> wrote:
> On Fri, 8 Sep 2023, Michael Schmitz wrote:
> > atariints.h already has some prototypes, so yes on that account.
> >
> > atarihw.h only has inlines, but sound and time related prototypes could
> > be added there, too.
> >
> > Geert's intentions might have been avoiding inclusion of all the
> > hardware specific data in those two files, but the only source file to
> > benefit from this is config.c (the other three already include
> > atariints.h and atarihw.h).
> >
> > OTOH, considering this patch series adds a lot of other headers that
> > only contain prototypes, it might be better to keep to that pattern
> > everywhere.
>
> I think Geert's intention may have been to avoid adding definitions to the
> asm/foo.h headers shipped with "make headers_install". If that's the
> intention, there would seem to be a mess to be cleaned up, for which I'm
> partly to blame...

arch/m68k/include/asm/ is not shipped, (arch/m68k/include/uapi/asm/ is).
However, arch/m68k/include/asm/ is shared with the whole tree, while
only the core code under arch/m68k/ needs these definitions.

There is (are) definitely (an) opportunit{y,ies} for moving more stuff
around (from <asm/...> to "...", more extern declarations in C files, ...).
Not to mention the more substantial rework...
But Linux/m68k^WRome wasn't built in a decade neither... ;-)

And TBH, I also went for the "minimum amount of work" ;-)
(which didn't work out that well, yet another rabbit hole, as usual...).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

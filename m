Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27383790188
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350439AbjIARib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239123AbjIARia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:38:30 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B5CE54
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 10:38:27 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-48d0bfd352eso796646e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693589907; x=1694194707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPwuUv4hjkSZBlt8vSweDnDj2mK+hBCM9BXJpfiTr7o=;
        b=pl1SOlatIj6l8giaV9E8bxMSV+K597uiggIFK5F7rbSBYoC2Ii0Jl4XMDXiGksuuUJ
         dg8UF7g3t4Lj0nTWUF3vGn54kIVSiCOAIpVpFWdayXtXcq4HYMXXtwd7GlpwFPFmgVQ6
         rtP0m76f8uLR9BmWStQmOTbhITlSFYGaevc4kq3sWmBfXYTZnO54bewbWAbYbou2oBdR
         OZcWYfu6g7TTRgutLtzsBMu2RITK8nO7eCbnHuNHlJl4JZgZOeD4/wgYMKzhAji7JXcJ
         8owWP2/XA2jx5N5QgumYtK2Zs26cbp0xOL+fUE7nle/t/PTJrotb+3FH1zXzkqq2gS53
         PnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693589907; x=1694194707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPwuUv4hjkSZBlt8vSweDnDj2mK+hBCM9BXJpfiTr7o=;
        b=WHTRnrpVwJY4yJmWAbX8PuB/SEkUkeQ2WNBqYAsn6sNwstT2PM+z6WwM5IxyzrjQ23
         Sj8tzgXkzZ/bGA10cQx/DYGh91xVYKcuquwyjAuXfbScaN1YAKzQPgxRzeThPQ10/7DH
         k0h3/MfrTIBNcXm5j1DB8wnqFk/oY9JceexuvN07747Pl49N2C7BE3UemqENT8BXEIqv
         bu8y4XRpLRSTmamhBI0wd0D8FxTSpcH8svtdCMAOWljU1BUCoqGNiuyJ85F6U6WI9a+4
         OpfnUGQWlDig9jesp3BPV0MDUrhGr5uX7AIEvtYvnPB8tEPnBglzJ+9GuuNAG20zpZw9
         b4Rw==
X-Gm-Message-State: AOJu0YwG9fNZk6YRfQuuF7r5Plgqx566Jq5kGz4B4ueIbbOK+mqp2im/
        FqAHlR/R7+RicCyoxVeie0wWMRBgHZXw5+jcaHSaKXqT
X-Google-Smtp-Source: AGHT+IExDFJ5mNkyVvpjvm1i0VuF2b2//E2DLnEe4iDB2XsxCc8jBTCvVucok9b0484GwHSQ+LMyy3WG/7GV2O4fPXc=
X-Received: by 2002:a1f:cd85:0:b0:48d:149e:1a41 with SMTP id
 d127-20020a1fcd85000000b0048d149e1a41mr3475450vkg.8.1693589906968; Fri, 01
 Sep 2023 10:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+jjjYQWeqDY3EFQWmVzV2pXyhfRaHm6s-XWYSXfe1CxvkeuEQ@mail.gmail.com>
 <dbce949f-d8b5-fb88-af63-21a82e431aa3@gnuweeb.org>
In-Reply-To: <dbce949f-d8b5-fb88-af63-21a82e431aa3@gnuweeb.org>
From:   Joshua Hudson <joshudson@gmail.com>
Date:   Fri, 1 Sep 2023 10:38:15 -0700
Message-ID: <CA+jjjYSMq-hKx5XsMDf=+n4wfAr6Btt7x8gpG5kdRRrzr6YK2Q@mail.gmail.com>
Subject: Re: System Call trashing registers
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86-ml <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 1, 2023 at 9:24=E2=80=AFAM Ammar Faizi <ammarfaizi2@gnuweeb.org=
> wrote:
>
> On 8/24/23 11:15 PM, Joshua Hudson wrote:
> > 1) A lot of my old 32-bit programs don't work on x64 linux anymore
> > because int 80h now trashes ecx and edx. This hasn't been a serious
> > problem for me.
>
> Do you have a reproducer? It doesn't trash ecx and edx on my machine.
>
> Linux 6.5.0-rc5-af-home-2023-08-08-gf01d31303231
> ```
> #include <stdio.h>
>
> static void do_int80(void)
> {
>         int ecx =3D 0x11111;
>         int edx =3D 0x22222;
>         int eax =3D 158; // sched_yield
>
>         __asm__ volatile (
>                 "int $0x80"
>                 : "+a"(eax), "+c"(ecx), "+d"(edx)
>                 :
>                 : "memory"
>         );
>         printf("ecx =3D %#x\n", ecx);
>         printf("edx =3D %#x\n", edx);
> }
>
> int main(void)
> {
>         int i;
>
>         for (i =3D 0; i < 3; i++)
>                 do_int80();
>
>         return 0;
> }
> ```
>
> ammarfaizi2@integral2:/tmp$ gcc -Wall -Wextra -Os z.c -o z
> ammarfaizi2@integral2:/tmp$ ./z
> ecx =3D 0x11111
> edx =3D 0x22222
> ecx =3D 0x11111
> edx =3D 0x22222
> ecx =3D 0x11111
> edx =3D 0x22222
>
>
> > 2) syscall is documented to trash rcx and r11.
> >
> > What I don't understand is why this hasn't ever led to a security
> > issue due to leaking values from kernel space (in the trashed
> > registers) back to userspace.
>
> That behavior is architectural. It's the 'syscall' instruction that
> clobbers %rcx and %r11. Not the kernel.
>
> --
> Ammar Faizi

Correction: it's been fixed again. Sorry about that.

I know the asmutils tools have been broken for a decade, but they're
working now.

What would happen is system calls that take arguments in ecx and edx would =
find
ecx and edx trashed, but only a few calls actually did this, the
primary offender
being open(). The best regression test seems to be hexdump from
asmutils because the
corruption would reliably crash the binary. sched_yeild was never an
affected syscall.

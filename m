Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551AA7A1DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjIOMCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbjIOMCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:02:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC4D2113
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:02:13 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50079d148aeso3491742e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694779331; x=1695384131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3fPlDRzMIONDqj3mMmHL+GbxcO1+3NgTlxYMiH+als=;
        b=V48oHatGNATmYJV7anLx2nNNbUKzb9qtTGDDl0iTKSppwzPTKuCnXCIw8D2ZbjLASz
         NQG2RzyGEpp0NsKg6BCJea2b2Nq7gyoo0WlpOvJ0jUAtEepowES9WH/NbRTyYtCusG0p
         s77Y9M4GAnG5l5FJIDFwDwHU1iWUzv13Gr+gjFMvju+edhzhJNgDjQhLRULSQOG322aT
         WRFRbzjNBm63J3ysJSG8HzDoWNHvZg3Um7K3kSbKqwyIN8uMzpCj14khpZs50Uyxwx3P
         wgoNIqLwpRf0w9G8Xww4ja79BYobsq6tUtybcQpq7N4+IQZTpRXnx5veZYx6trHY0XY1
         WIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694779331; x=1695384131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3fPlDRzMIONDqj3mMmHL+GbxcO1+3NgTlxYMiH+als=;
        b=uDryWizAr6NgrxnxwMxHqKJQ8KulWXybE+zZd1YoChfJiwdK0rV6IKx9I5rIY8oic2
         8JldDprp4actowgNUpJKkQHBXQbF/dg3e27t9fhvCMw44N0Jn6TWwkCKELdUUmMOnA4P
         CaLNXdF9eySh8Jl2fqzZUZRQKutekR/eCRzBLA3bBmsYhMRgpMaaJb0i+fDGipFLyupL
         EAAzNL1Grs3X2PicDM86MsRWvfY8p6+fbSu1AJv/p3gY2NWGohvGjsZd1cEtiQoFTMKU
         WkoEzsGNW6pbOq+x/e15+vaRsYye9q5KqLT3RCp7g+BPUmLxZOfpWi9O5m+gSX4VvhKv
         78CQ==
X-Gm-Message-State: AOJu0YxCun4uz1No0opW3odClQIxepz9Q8+SMJyYONjjEtRNAEf4ybwP
        8QqEWPAGMcoj8c2OuGrIe5G2va7q6SQxDfgWMR0=
X-Google-Smtp-Source: AGHT+IGPCuxDbeI+O3ehnCT30Xgv7V3IYGDZrGQAxhf1fhZegDWTxUsNZl9qa3wyQPQaaJMNmInOdx6xGeDr752UsHc=
X-Received: by 2002:a19:7113:0:b0:500:9a45:62f with SMTP id
 m19-20020a197113000000b005009a45062fmr1169402lfc.8.1694779331034; Fri, 15 Sep
 2023 05:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230830151623.3900-1-ubizjak@gmail.com> <20230830151623.3900-2-ubizjak@gmail.com>
 <ZQQoHWkJ5or/K7UH@gmail.com>
In-Reply-To: <ZQQoHWkJ5or/K7UH@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 15 Sep 2023 14:01:59 +0200
Message-ID: <CAFULd4ZJDE5Hp9DFNpk+pFbCAC2=asEm1eLmQxy2uOWRbLkRwQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/percpu: Use raw_cpu_try_cmpxchg in preempt_count_set
To:     Ingo Molnar <mingo@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 11:47=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > Use raw_cpu_try_cmpxchg instead of raw_cpu_cmpxchg (*ptr, old, new) =3D=
=3D old.
> > x86 CMPXCHG instruction returns success in ZF flag, so this change save=
s a
> > compare after cmpxchg (and related move instruction in front of cmpxchg=
).
> >
> > Also, raw_cpu_try_cmpxchg implicitly assigns old *ptr value to "old" wh=
en
> > cmpxchg fails. There is no need to re-read the value in the loop.
> >
> > No functional change intended.
> >
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > ---
> >  arch/x86/include/asm/preempt.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/pree=
mpt.h
> > index 2d13f25b1bd8..4527e1430c6d 100644
> > --- a/arch/x86/include/asm/preempt.h
> > +++ b/arch/x86/include/asm/preempt.h
> > @@ -31,11 +31,11 @@ static __always_inline void preempt_count_set(int p=
c)
> >  {
> >       int old, new;
> >
> > +     old =3D raw_cpu_read_4(pcpu_hot.preempt_count);
> >       do {
> > -             old =3D raw_cpu_read_4(pcpu_hot.preempt_count);
> >               new =3D (old & PREEMPT_NEED_RESCHED) |
> >                       (pc & ~PREEMPT_NEED_RESCHED);
> > -     } while (raw_cpu_cmpxchg_4(pcpu_hot.preempt_count, old, new) !=3D=
 old);
> > +     } while (!raw_cpu_try_cmpxchg_4(pcpu_hot.preempt_count, &old, new=
));
>
> It would be really nice to have a before/after comparison of generated
> assembly code in the changelog, to demonstrate the effectiveness of this
> optimization.

The  assembly code improvements are in line with other try_cmpxchg
conversions, but for reference, finish_task_switch() from
kernel/sched/core.c that inlines preempt_count_set() improves from:

    5bad:    65 8b 0d 00 00 00 00     mov    %gs:0x0(%rip),%ecx
    5bb4:    89 ca                    mov    %ecx,%edx
    5bb6:    89 c8                    mov    %ecx,%eax
    5bb8:    81 e2 00 00 00 80        and    $0x80000000,%edx
    5bbe:    83 ca 02                 or     $0x2,%edx
    5bc1:    65 0f b1 15 00 00 00     cmpxchg %edx,%gs:0x0(%rip)
    5bc8:    00
    5bc9:    39 c1                    cmp    %eax,%ecx
    5bcb:    75 e0                    jne    5bad <...>
    5bcd:    e9 5a fe ff ff           jmpq   5a2c <...>
    5bd2:

to:

    5bad:    65 8b 05 00 00 00 00     mov    %gs:0x0(%rip),%eax
    5bb4:    89 c2                    mov    %eax,%edx
    5bb6:    81 e2 00 00 00 80        and    $0x80000000,%edx
    5bbc:    83 ca 02                 or     $0x2,%edx
    5bbf:    65 0f b1 15 00 00 00     cmpxchg %edx,%gs:0x0(%rip)
    5bc6:    00
    5bc7:    0f 84 5f fe ff ff        je     5a2c <...>
    5bcd:    eb e5                    jmp    5bb4 <...>
    5bcf:

Please note missing cmp (and mov), loop without extra memory load from
%gs:0x0(%rip) and better predicted jump in the later case. The
improvements with {raw,this}_cpu_try_cmpxchg_128 in the third patch
are even more noticeable, because __int128 value lives in a register
pair, so the comparison needs three separate machine instructions, in
addition to a move of the register pair.

Thanks,
Uros.

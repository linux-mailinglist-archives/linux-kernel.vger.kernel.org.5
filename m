Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E84E7BD855
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346123AbjJIKQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346124AbjJIKQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:16:45 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10455E4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:16:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4053f24c900so75935e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696846600; x=1697451400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNSWC1NcEQWATBxO3PFnKpkKdXA2Vi1W1PLFHkk8mKY=;
        b=jusifRT53YVyAn44ZRntLn3cR6GADFESo2+bTOTdjIKlLt13+eQuy1acu8jUGaZ9dO
         N+/pmPM0pq5RsXUxZ0YHnvuBmujxLdGm82A5SrWhSH4z8qUVZZQhoqazkrKiPnpsJcWE
         Jhpgy82y3OQJJVkTWca27aH7lo2UuDbkQYTZVq0/BCY6L6y17gir3K10ihQalbzrbqFc
         ZeY7CNQr32YtSXXtnUTGn1bp7g2FnaPbBZfx6f66kqrk3mDa4hs6i5oYIFp3SBO6TRzD
         gVnsy5bBkt6VImuKmwQMFPXL7y+B5yWGVsb2QYL9BxxS9amg6JEt9JkGKp/idRGHFfCi
         wx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696846600; x=1697451400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNSWC1NcEQWATBxO3PFnKpkKdXA2Vi1W1PLFHkk8mKY=;
        b=XD7pPkpRh/aHd/hNKmMRhy6giEtDd7ymiS3ugkJUVclJfqTKWMkeV085YJEquWhZvA
         o8qFLPSAl7O1EjmsMlb2QDHbyP/mxqb/kHeynFiLBlIrqOYGcmhEjNl4Mj+hAMKCgKiu
         9bC3RYUJujPFuUOHooRnAayZE72UoyFePfMVI0ykrSzWgxN+1+GW49mhVH2l/vMgQy8c
         9uncixlWj751Hvl9sePXPYr6KMlV0er9VoLXN5Eq7vhhWNkgZ0uxrhD72KJgj/xR3xQ9
         qV6JjAOQLstkXdAhklV58ddkStJmaJKDwMgtRWRme6LYeV783rYPcKqrrFyp9uPIVc9Y
         pT8w==
X-Gm-Message-State: AOJu0YyweS2rlgQLDK4iIT+BW/DRY2WIqlavNWsIK+em+v0bXI/y3lCX
        Q7tT0B/Gkj+dlGzd0++MLskft+Af57hULjXnCa2rfA==
X-Google-Smtp-Source: AGHT+IHu8cp7BHI0j2KjaoQYwoQVJwgOi+YC/g3+z5dc7ANthPGOUQ19ZO5iRT4b5xLRPaPsqTwcVoJW9QtBAl4LAuU=
X-Received: by 2002:a05:600c:2301:b0:405:38d1:e146 with SMTP id
 1-20020a05600c230100b0040538d1e146mr320547wmo.4.1696846600202; Mon, 09 Oct
 2023 03:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231007050621.1706331-1-yajun.deng@linux.dev>
 <CANn89iL-zUw1FqjYRSC7BGB0hfQ5uKpJzUba3YFd--c=GdOoGg@mail.gmail.com>
 <917708b5-cb86-f233-e878-9233c4e6c707@linux.dev> <CANn89i+navyRe8-AV=ehM3qFce2hmnOEKBqvK5Xnev7KTaS5Lg@mail.gmail.com>
 <a53a3ff6-8c66-07c4-0163-e582d88843dd@linux.dev> <CANn89i+u5dXdYm_0_LwhXg5Nw+gHXx+nPUmbYhvT=k9P4+9JRQ@mail.gmail.com>
 <9f4fb613-d63f-9b86-fe92-11bf4dfb7275@linux.dev> <CANn89iK7bvQtGD=p+fHaWiiaNn=u8vWrt0YQ26pGQY=kZTdfJw@mail.gmail.com>
 <4a747fda-2bb9-4231-66d6-31306184eec2@linux.dev> <814b5598-5284-9558-8f56-12a6f7a67187@linux.dev>
 <CANn89iJCTgWTu0mzwj-8_-HiWm4uErY=VASDHoYaod9Nq-ayPA@mail.gmail.com>
 <508b33f7-3dc0-4536-21f6-4a5e7ade2b5c@linux.dev> <CANn89i+r-pQGpen1mUhybmj+6ybhxSsuoaB07NFzOWyHUMFDNw@mail.gmail.com>
 <296ca17d-cff0-2d19-f620-eedab004ddde@linux.dev> <CANn89iL=W3fyuH_KawfhKvLyw2Cw=qhHbEZtbKgQEYhHJChy3Q@mail.gmail.com>
 <68eb65c5-1870-0776-0878-694a8b002a6d@linux.dev>
In-Reply-To: <68eb65c5-1870-0776-0878-694a8b002a6d@linux.dev>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 9 Oct 2023 12:16:25 +0200
Message-ID: <CANn89iJHtYJjp6zPc2PVLAWuN88BQc5OntjrAf7f6QOcqP+B=g@mail.gmail.com>
Subject: Re: [PATCH net-next v7] net/core: Introduce netdev_core_stats_inc()
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, mark.rutland@arm.com,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 11:43=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev> w=
rote:
>
>
> On 2023/10/9 17:30, Eric Dumazet wrote:
> > On Mon, Oct 9, 2023 at 10:36=E2=80=AFAM Yajun Deng <yajun.deng@linux.de=
v> wrote:
> >>
> >> On 2023/10/9 16:20, Eric Dumazet wrote:
> >>> On Mon, Oct 9, 2023 at 10:14=E2=80=AFAM Yajun Deng <yajun.deng@linux.=
dev> wrote:
> >>>> On 2023/10/9 15:53, Eric Dumazet wrote:
> >>>>> On Mon, Oct 9, 2023 at 5:07=E2=80=AFAM Yajun Deng <yajun.deng@linux=
.dev> wrote:
> >>>>>
> >>>>>> 'this_cpu_read + this_cpu_write' and 'pr_info + this_cpu_inc' will=
 make
> >>>>>> the trace work well.
> >>>>>>
> >>>>>> They all have 'pop' instructions in them. This may be the key to m=
aking
> >>>>>> the trace work well.
> >>>>>>
> >>>>>> Hi all,
> >>>>>>
> >>>>>> I need your help on percpu and ftrace.
> >>>>>>
> >>>>> I do not think you made sure netdev_core_stats_inc() was never inli=
ned.
> >>>>>
> >>>>> Adding more code in it is simply changing how the compiler decides =
to
> >>>>> inline or not.
> >>>> Yes, you are right. It needs to add the 'noinline' prefix. The
> >>>> disassembly code will have 'pop'
> >>>>
> >>>> instruction.
> >>>>
> >>> The function was fine, you do not need anything like push or pop.
> >>>
> >>> The only needed stuff was the call __fentry__.
> >>>
> >>> The fact that the function was inlined for some invocations was the
> >>> issue, because the trace point
> >>> is only planted in the out of line function.
> >>
> >> But somehow the following code isn't inline? They didn't need to add t=
he
> >> 'noinline' prefix.
> >>
> >> +               field =3D (unsigned long *)((void *)this_cpu_ptr(p) + =
offset);
> >> +               WRITE_ONCE(*field, READ_ONCE(*field) + 1);
> >>
> >> Or
> >> +               (*(unsigned long *)((void *)this_cpu_ptr(p) + offset))=
++;
> >>
> > I think you are very confused.
> >
> > You only want to trace netdev_core_stats_inc() entry point, not
> > arbitrary pieces of it.
>
>
> Yes, I will trace netdev_core_stats_inc() entry point. I mean to replace
>
> +                                       field =3D (__force unsigned long
> __percpu *)((__force void *)p + offset);
> +                                       this_cpu_inc(*field);
>
> with
>
> +               field =3D (unsigned long *)((void *)this_cpu_ptr(p) + off=
set);
> +               WRITE_ONCE(*field, READ_ONCE(*field) + 1);
>
> Or
> +               (*(unsigned long *)((void *)this_cpu_ptr(p) + offset))++;
>
> The netdev_core_stats_inc() entry point will work fine even if it doesn't
> have 'noinline' prefix.
>
> I don't know why this code needs to add 'noinline' prefix.
> +               field =3D (__force unsigned long __percpu *)((__force voi=
d *)p + offset);
> +               this_cpu_inc(*field);
>

C compiler decides to inline or not, depending on various factors.

The most efficient (and small) code is generated by this_cpu_inc()
version, allowing the compiler to inline it.

If you copy/paste this_cpu_inc()  twenty times, then the compiler
would  not inline the function anymore.

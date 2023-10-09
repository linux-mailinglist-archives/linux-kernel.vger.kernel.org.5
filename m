Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258AB7BDC7A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376539AbjJIMma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376517AbjJIMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:42:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0158999
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:42:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53639fb0ba4so7685850a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696855341; x=1697460141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oMdn3ojprlnWzGvkXii7VeAtu+QKAL8PWgBY1TcGDw=;
        b=QOu2kMSDhOfSAAoRS5SdHEUzr1Fv8JC/ALNRpa8Ymo661nSMbPplPcpMjniVL0m/hK
         KrNCOf94F9DYF5a4JC8EbU6+EiYeb3QqvlWhpJjAN4irhpHJRXVpDsqUZcXy1fKTF8z8
         +pbYVPmlujQNrBHzWg5pcDIxUclTnGuH7235/QPW6yY+VEw4YAcEVvdWaF6shvXW+mqv
         9A5dcG7q9YE9qhilod0UOpTBUJrkRDk78ODmvDgd25YYZWU66K5z+zhzKrHaD9YNTU2m
         TzsyMIT1BKgMgUt7pSG1CDzLFzzqw5NhSyRA7x7mFb5nbTSor8gXjBQgvJfRv3NRnjmm
         TvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696855341; x=1697460141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oMdn3ojprlnWzGvkXii7VeAtu+QKAL8PWgBY1TcGDw=;
        b=NBN6D8RPVGH01R54LCvKO2A2wEFbEsCIIn3Bci6yKVqG4u6uKK83G91vU6OjEdUKR+
         dJ7u9Uz593BZIPil6MuNrprg7tDDThxiZjOdYy4WIq+UvzdzgYfvgdrRT/CIae078TmZ
         vaYWOBsZt4HiG7wyKdx0FnprRcsLkzUVSm+KYxFlJKdF3ccOI4fbSRtDgkQAGd5mxZGU
         FPrloP7WsURxuzcwp/fprbcuf/3EYzwb41JhLM4kM9DmmAkRsyU7gv26rH6nwRmgf9ll
         EoUhafP2x1SmdLRUpKnKVjqkehhyaJ5BzlIrJVfcsWC7LXnY6cdSiGF4oWDMnT1eka2G
         52DA==
X-Gm-Message-State: AOJu0YwWshApAusL91RQKEaWjUF4XpzqRoQmeCkc+1U1735JYekJ5rYf
        Sx2EeHz7jArv9RsAFsKpy5OPFbp8kseY3YA/XD8=
X-Google-Smtp-Source: AGHT+IHIjc6/M3nodmfLXUJLdz1wi1pFV3USmS3bRdPOlkbDdTIuYWxdr04cP5TsZlHqyxILkXa5iuuH+O6oRNIuXoI=
X-Received: by 2002:aa7:c246:0:b0:533:4f9b:67c8 with SMTP id
 y6-20020aa7c246000000b005334f9b67c8mr14223516edo.16.1696855341393; Mon, 09
 Oct 2023 05:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231004145137.86537-1-ubizjak@gmail.com> <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
 <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
 <CAHk-=whq=+LNHmsde8LaF4pdvKxqKt5GxW+Tq+U35_aDcV0ADg@mail.gmail.com>
 <CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com>
 <CAFULd4Z3C771u8Y==8h6hi=mhGmy=7RJRAEBGfNZ0SmynxF41g@mail.gmail.com>
 <ZSPm6Z/lTK1ZlO8m@gmail.com> <ZSPpW3zLTn7IohOJ@gmail.com> <CAFULd4bjnro3CFQLY=qR0S5M0WY3NkrVUW-JUk4nB4mV7xhWNg@mail.gmail.com>
 <EEA95C45-87E6-4033-AEB2-0EC109220074@vmware.com>
In-Reply-To: <EEA95C45-87E6-4033-AEB2-0EC109220074@vmware.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 9 Oct 2023 14:42:10 +0200
Message-ID: <CAFULd4aOSz0ZCtDdh=eST6DCr+ds2B9O2Rk0cyUeS+qQmWdOMA@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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

On Mon, Oct 9, 2023 at 2:21=E2=80=AFPM Nadav Amit <namit@vmware.com> wrote:
>
>
>
> > On Oct 9, 2023, at 3:00 PM, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > !! External Email
> >
> > On Mon, Oct 9, 2023 at 1:51=E2=80=AFPM Ingo Molnar <mingo@kernel.org> w=
rote:
> >>
> >> BTW., while this OK for testing, this is too heavy handed for release
> >> purposes, so please only disable the KASAN instrumentation for the aff=
ected
> >> percpu accessors.
> >>
> >> See the various __no_sanitize* attributes available.
> >
> > These attributes are for function declarations. The percpu casts can
> > not be implemented with separate static inline functions. Also,
> > __no_sanitize_address is mutually exclusive with __always_inline.
>
> Right, but for GCC you may be able to do something like:
>
>     #pragma GCC diagnostic push
>     #pragma GCC diagnostic ignored "-fsanitize=3Daddress"
>
>     // Your code here...
>     #pragma GCC diagnostic pop
>
> Not sure if there is something equivalent in CLANG, and it should be done=
 with
> the kernel=E2=80=99s _Pragma.

Unfortunately, this is only for diagnostics and expects "-W..." to
suppress warnings. Here we want to disable kernel sanitizer just for
the enclosing access and I'm sure it won't work with diagnostics
pragmas. I don't think that "-fsanitize=3D..." is included in target or
optimization options allowed in Pragma.

Uros.

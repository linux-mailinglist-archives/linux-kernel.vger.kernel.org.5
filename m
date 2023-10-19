Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2337CF3F7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344997AbjJSJYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbjJSJX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:23:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9CC98
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:23:56 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so13514241a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697707435; x=1698312235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYBmZb8L0tkdmg0cquRQf2b689ZCsR+eJJtSll1Zofc=;
        b=E5jkXEwbYEfrQ+XtM1mDMnYNyRa2A938tavW3Ru91hvJ4b/aq8fdFjyqSpxec+d22+
         FHqLJrRwlNAALR5wqGuvUcRbxgccBjQjUWEJACWES/ZpBXQb5jj02hH5zUki6BQFqf/t
         xyKMMC6hy7um43f2iX+6PBXFhzoObqrndSsmwiXr1eiAg/6k3kTQV46kC6+mmIRewwss
         Ibp24wA7d+uGHm1kzufOZyWARSGOL9GgnQJJDW0lKDKlx7JI81fNhg0T6FP3DhiJGvH2
         BXeTwgPcN2aUhyf/Bnid7TJZtTKNxyzUf/26zC1S2kg4VGu8pfTpQxQotcxVka0FEfb2
         EVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697707435; x=1698312235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYBmZb8L0tkdmg0cquRQf2b689ZCsR+eJJtSll1Zofc=;
        b=dB6+eya7KDb/8hXL5XuImV0taNhe7p2kSJs/Y6WKC9dcpOK/l33uVvlNbAWy6VqEvo
         k+tJaRK+dDf/zS6GdRoO7/ZQ9JjEe8D0AUU/oeF5lSuubpJMgeHVIu2Ap5WpGgA4XdYQ
         HDCmkux35yN1AzHaORDxLoyEYHLObv7vrbHSH40RjHv4WoxIXxx746LBQqCaP/2+6ew8
         OKDZiH5sLpQW8SUkM9B6iXmvA4W12Trbp/XOEnXCCzgodl6QleNfUYpVMIf/UTyWn22R
         SCrUsvr3uV5N6v3GpVlwcCqD0YjK5tZg5Q8PVnJ2KZy2bjAT34OzTZcuXF4LSgQ5LN0T
         IAUQ==
X-Gm-Message-State: AOJu0YzN/SwS2C9U+QoIkARzZYYvcIBHQOniCiRXpkTBXW3scNK99fT1
        VMFwNVTYIc3Kd/Dzz0NAHD6E6/g3MB6ffe2gQSw=
X-Google-Smtp-Source: AGHT+IFsmWJ9LImdnwphCwJhukkUHate/IWwfl2GqdYlqS02Q+shsGF17iqCuP6m7T6HZHytR5IVlgNVEG0xjoMQZwU=
X-Received: by 2002:a05:6402:42d1:b0:53e:46b0:32be with SMTP id
 i17-20020a05640242d100b0053e46b032bemr1235054edc.34.1697707435100; Thu, 19
 Oct 2023 02:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
 <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
 <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
 <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
 <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com>
 <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
 <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com>
 <CAFULd4Zj5hTvATZUVYhUGrxH3fiAUWjO9C27UV_USf2H164thQ@mail.gmail.com>
 <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com> <20231019090733.GR33217@noisy.programming.kicks-ass.net>
In-Reply-To: <20231019090733.GR33217@noisy.programming.kicks-ass.net>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 19 Oct 2023 11:23:43 +0200
Message-ID: <CAFULd4aVc_GXy2BmnJLb3p7OdAtsLrqOE9vhZrOx7oaWU4Tg-w@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Thu, Oct 19, 2023 at 11:09=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Wed, Oct 18, 2023 at 03:40:05PM -0700, Linus Torvalds wrote:
> > On Wed, 18 Oct 2023 at 14:40, Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > The ones in "raw" form are not IRQ safe and these are implemented
> > > without volatile qualifier.
> >
> > You are misreading it.
> >
> > Both *are* irq safe - on x86.
>
> Stronger, x86 arch code very much relies on them being NMI-safe. Which
> makes the generic implementation insufficient.
>
> They *must* be single RmW instructions on x86.

Maybe I should rephrase my quoted claim above:

"raw" versions are not needed to be IRQ safe [*].

[*] Memory arguments need to be stable, so IRQ and NMI handlers can
not change them outside of the critical section where the "raw"
version operates. When memory arguments are stable, the compiler can
omit reads (cache) the arguments, or re-reads them (rematerialize)
from memory. The atomicity of the operation is irrelevant in the "raw"
context, so the implementation of raw_percpu_xchg_op using
raw_cpu_read/write is OK in this context.

Uros.

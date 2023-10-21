Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FD47D1DD2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjJUPMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUPMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:12:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ACBE3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:12:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so396541a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697901130; x=1698505930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhPHBAAJZa6dFGyjheIVR9hGkiLpAwB9CbD4gzvkOzE=;
        b=Zbja3W1gqA1/gTEA+CpnitTkhuJXVrQva2JpcnDApgYGacw4bigmeaBjk9kMLtzcBo
         h3Del5soIYZVfENIeJIoysnL+4Dtbdt90TH98exOzfDeUyp/0U6JyaNjzrJBrdWlWfRx
         eFc5HFXQLeERRoF8MxWwxDgCdXoF4QlmEZHd3NSxiUPlGWhIULs6zTNMyoneS+3AtO3Y
         EQc3gHlfaWJGBz5lDlHwMzKRPX+4/WZSaXmn63AQTL0v82tbLw6UVrG5nzQAiT7FqhIE
         bgQBCXqBZn8ImhJ/HEUWZwW8K4gGYwQCVVrPfcdhXTS+FQtHxt79UHG+rLFC2IbG5AqL
         N0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697901130; x=1698505930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhPHBAAJZa6dFGyjheIVR9hGkiLpAwB9CbD4gzvkOzE=;
        b=Mjfsiq9C6hGuztRlQLRq7I6HUUrIER9D7G9RZGSKmWYXWCPwCVWKjDwmreXmkkTLm9
         o9Q1VLjdwQL1UnhfmRXA0+h+zteTP4Dch8ksaI4wY2zWXzHN3fNJ+E1/EgWUrq0a10S9
         dba9cAmuFTZuL9dmwIFCNmZmJr7Sru7eyEhH+1Qky/QIXtB12wtxnYr/2pNE0l/Q1cvr
         bJAoGTVfLzFuedTi3fegrhuG+BrZjaAFV3kPeYOSddFsSGVFkIUvwoYpkf4eYoahKD4q
         J0q4JOkyO5Ssv6z59lxV+2tQZa6HuGu84GLZyRvozEHsLly/iodA31/7Mw/p5ViLIxW4
         4pYw==
X-Gm-Message-State: AOJu0YwtPqezrzMyzIV8frlw5omQlHrlwr2LXDXNthk8JDAD+zXqwllZ
        AZplOJ98ln/zm9XiylwrVUGXAHEH97/5Mu+JKaY=
X-Google-Smtp-Source: AGHT+IFbTCDinLjXkvnZKcK6256x6SGENY70aS4ujXItG/7/OQy1MaR8Q5YhWQ+DymfRr+gV7rrpdS7uCivJNZ8Jiyo=
X-Received: by 2002:a05:6402:254e:b0:53f:5467:cc5e with SMTP id
 l14-20020a056402254e00b0053f5467cc5emr3801466edb.19.1697901130084; Sat, 21
 Oct 2023 08:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231021143739.843941-1-ubizjak@gmail.com> <ZTPniJs9/ep11F2I@gmail.com>
In-Reply-To: <ZTPniJs9/ep11F2I@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sat, 21 Oct 2023 17:11:58 +0200
Message-ID: <CAFULd4Zyv7KVo=pO5wEXbuh6bFmAkx=Hgx+LqDuLxAD+nTYS6Q@mail.gmail.com>
Subject: Re: [PATCH -tip v2] x86/percpu: Introduce const-qualified const_pcpu_hot
To:     Ingo Molnar <mingo@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nadav Amit <namit@vmware.com>
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

On Sat, Oct 21, 2023 at 5:00=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> >  arch/x86/include/asm/current.h   | 7 +++++++
> >  arch/x86/include/asm/percpu.h    | 6 +++---
> >  arch/x86/include/asm/processor.h | 3 +++
> >  arch/x86/kernel/cpu/common.c     | 1 +
> >  arch/x86/kernel/vmlinux.lds.S    | 1 +
> >  include/linux/compiler.h         | 2 +-
> >  6 files changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/curr=
ent.h
> > index a1168e7b69e5..0538d2436673 100644
> > --- a/arch/x86/include/asm/current.h
> > +++ b/arch/x86/include/asm/current.h
> > @@ -36,8 +36,15 @@ static_assert(sizeof(struct pcpu_hot) =3D=3D 64);
> >
> >  DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
> >
> > +/* const-qualified alias to pcpu_hot, aliased by linker. */
> > +DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
> > +                     const_pcpu_hot);
>
> The aliasing makes me a bit nervous. Could we at least prefix it a bit mo=
re
> prominently, like const__pcpu_hot? That way it's immediately obvious at a=
ll
> usage sites that it's "special".

Sure, it can be renamed. The symbol - although aliased - may be used
in a general way. It is const-qualified and placed in __seg_gs address
space, so all the rules for const and __seg_gs qualifications apply.
However, the values are not that constant, and can be changed behind
the scenes via the pcpu_hot R/W alias.

Uros.

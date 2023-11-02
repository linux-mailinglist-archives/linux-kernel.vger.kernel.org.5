Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D0C7DF1A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344396AbjKBLuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbjKBLuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:50:18 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72616184
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:50:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso1731771a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 04:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698925812; x=1699530612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0E5CkA/bScNV8ea/XFFHBzbUdI49Ytd/EO22HzHgSc=;
        b=LZ6pOntEFCCP4XbIqO7pyXlQa9biwpa2X8Sh6C5uOLZCCQZ/7U9RO2qeTa7TuZMewp
         6F8ehZ7s8v+bL9qd+k75ip+ysmFhh5xCLrPbyIpR0WWkj29kG8kmTKoth7QQFddF/02B
         QKa3ZxfJ1hZ9VyViEusSYwvxisgJxutcuxhLv2GRK0RrkGQ0OBMRnZfQOhpdAfHSoVYD
         z257Ili+RYvBMtO1bRaLatv1VsesoRFq8E6Oezaa3ph4Kq5auVjPU99M7MleWO8hpvnB
         mgZ0JEGIgqpX/zh2O3CM2cynzIuhcvpT/njFll1dmIpq7LWlfe3AqCHrs51uSaV9jmRK
         Ig5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698925812; x=1699530612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0E5CkA/bScNV8ea/XFFHBzbUdI49Ytd/EO22HzHgSc=;
        b=wnyLfuKGFb3YzA77ArUO6NQ04ztLq1UIbSziadCR78aCWCeN5TnvXoDt50pAlSRUfP
         9rSUASYMYyzXEx3m5eRoDDPW1qwr3DxCVoX9Cn/AlIPkNp2yKdzY/GTXvDi62MApQly4
         pIJrIKbfKhFD/u4RraEdTCf1GRG3jITzxNsi/KjDiQ9NbZsUc4c9xbpyQnyJ99KrmnjF
         hBNdYfUnPb5HlTqxlKlpQSyAgpHXPzNZtZX4IRt8qgZR05x65qmgr0RV2lGO4UIHJpRv
         yZlv0PztiiAoyNVXNWwVSAUy/2hnMlqWnBrV/3Huby/lFE9IrlBp/ZcHV/1I8oVt9EGN
         ck1Q==
X-Gm-Message-State: AOJu0YzITQ3/b9RGyLv0JQKkAw172kTcnuL4C0Ntjq7kIYSiL85zZV9i
        hWS6ijCq50VwFoqI5ZgbSRjKte/diHRS1u9lAro=
X-Google-Smtp-Source: AGHT+IEU3opf6/OPB8Jk8oNaIYsgE/6LtMH4clncg368fhyQMqV4rRMhcij5aofDQnJeJHek3I5HW4ZSYKqQ/pQMou8=
X-Received: by 2002:a50:9e05:0:b0:543:92cc:620a with SMTP id
 z5-20020a509e05000000b0054392cc620amr4896918ede.0.1698925812446; Thu, 02 Nov
 2023 04:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231102112850.3448745-1-ubizjak@gmail.com> <20231102112850.3448745-3-ubizjak@gmail.com>
 <20231102114422.GB3818@noisy.programming.kicks-ass.net>
In-Reply-To: <20231102114422.GB3818@noisy.programming.kicks-ass.net>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 2 Nov 2023 12:50:01 +0100
Message-ID: <CAFULd4Yj=0XrufmZZiv=cZ3A+ncUd-8CF8bfr2h1w2N3PFf=DQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/callthunks: Handle %rip-relative relocations in
 call thunk template
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 12:44=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Nov 02, 2023 at 12:25:47PM +0100, Uros Bizjak wrote:
>
> > @@ -166,13 +168,51 @@ static const u8 nops[] =3D {
> >       0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90,
> >  };
> >
> > +#define apply_reloc_n(n_, p_, d_)                            \
> > +     do {                                                    \
> > +             s32 v =3D *(s##n_ *)(p_);                         \
> > +             v +=3D (d_);                                      \
> > +             BUG_ON((v >> 31) !=3D (v >> (n_-1)));             \
> > +             *(s##n_ *)(p_) =3D (s##n_)v;                      \
> > +     } while (0)
> > +
> > +static __always_inline
> > +void apply_reloc(int n, void *ptr, uintptr_t diff)
> > +{
> > +     switch (n) {
> > +     case 4: apply_reloc_n(32, ptr, diff); break;
> > +     default: BUG();
> > +     }
> > +}
> > +
> > +static void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src)
> > +{
> > +     for (int next, i =3D 0; i < len; i =3D next) {
> > +             struct insn insn;
> > +
> > +             if (WARN_ON_ONCE(insn_decode_kernel(&insn, &buf[i])))
> > +                     return;
> > +
> > +             next =3D i + insn.length;
> > +
> > +             if (insn_rip_relative(&insn))
> > +                     apply_reloc(insn.displacement.nbytes,
> > +                                 buf + i + insn_offset_displacement(&i=
nsn),
> > +                                 src - dest);
> > +     }
> > +}
>
> Isn't it simpler to use apply_relocation() from alternative.c?

Yes, I was looking at that function, but somehow thought that it is a
bit overkill here, since we just need a %rip-relative reloc.

> Remove static, add decl, stuff like that?

On second thought, you are right. Should I move the above function
somewhere (reloc.c?) , or can I just use it from alternative.c and add
decl (where?) ?

Thanks,
Uros.

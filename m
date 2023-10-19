Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7C37D01E4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346384AbjJSShz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346455AbjJSSht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:37:49 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD9B126
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:37:47 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a29c7eefso7987063e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697740666; x=1698345466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWF+wHWkChXhN6iIX2xagS57zOPfIX+NhafNJTMlCrE=;
        b=j3nPTXuOJuHJf2aI4J7CRGFLIoIIt9mjMIkGr+MfldBn6Dc2HGeM816ycw2+erjFzB
         bktUOYpc+gsYHMLjTlqWKQ4XOxTgVdmgFqJTOzzwnOWshDfPbcqPaGW2vTXW9IcvIn7B
         flIklRkcVUZXJO8eCiArfcu/G/fIfWCLQ+nTkui+ks1Gr2AqIrBJkpYMDIMQmmRSHAke
         R3h/Op5VQk4vuX7zt2wWV6f76npMFF53pMkIa24ttTPyBN0BRlSjqnp/mjsFWd8lWSWZ
         +5/2saC/83dn/Lj5jYDkD95nfOgR5GPoWqHmHuVo1OpQggYU4WOlufJ64Pnq4rEKSGxa
         smIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697740666; x=1698345466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWF+wHWkChXhN6iIX2xagS57zOPfIX+NhafNJTMlCrE=;
        b=nyUyvrN3pcbSucIHg9fFh/Rxr9m4wYe4GuQsUudlJl+A+MQnkx4xF95KxV1EZOxiQF
         h1FIjaKaxtNSaxF6dC8htIct5/FUXVcvM9wcMuY70BG1St0zIcyvhmB2bu0g3NNw5qcw
         iPqeo74fIFfEWN2u1zrUpjMkunpqPm1GpLUaiEmm6WsGDj9BYbSL9R45KwmgBxr+W3iw
         6OF62jVt7yYRttB8X7C9CoZRZW5fkbkFNdHtzchjNaM/oFR37b5w9Xwm+xqBMGmPZkHS
         Vlt7UnObaG6r3EjkTTHQ52uQsqxYbCmAIJvKhXdnvcdBuExKxkHbPNl6c3jRjSx020gP
         Z9gQ==
X-Gm-Message-State: AOJu0YybwKOW0xtffbRlEtyZt8+tifOKMeuHPZbw89ZiY+SQ3o2sf4S8
        +R4zD+33IT3QkRIJSGLMLgcNs+MMK1Vz+F9Cvq8=
X-Google-Smtp-Source: AGHT+IFZg97dlSyX9H3Scq96KrJj9pV+XiBbLtmMcxSuXHgS1gTiYpxM+MUTpwyo4JUO353Ns2llgv3QeFOQxIMuutM=
X-Received: by 2002:a05:6512:3d05:b0:500:be57:ce53 with SMTP id
 d5-20020a0565123d0500b00500be57ce53mr2585608lfv.42.1697740665278; Thu, 19 Oct
 2023 11:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
 <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
 <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com>
 <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
 <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com>
 <CAFULd4Zj5hTvATZUVYhUGrxH3fiAUWjO9C27UV_USf2H164thQ@mail.gmail.com>
 <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com>
 <20231019085432.GQ33217@noisy.programming.kicks-ass.net> <CAHk-=wg98L2qaw1U-7NDFQi6dOK=CRO6H-1q1LXuEh348Dk=2Q@mail.gmail.com>
 <20231019181359.GA35308@noisy.programming.kicks-ass.net> <CAHk-=wgHE-6z1CYGrZx0XSrPif+s7MuA+JZKCWWL5CvbdqWK+A@mail.gmail.com>
In-Reply-To: <CAHk-=wgHE-6z1CYGrZx0XSrPif+s7MuA+JZKCWWL5CvbdqWK+A@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 19 Oct 2023 20:37:33 +0200
Message-ID: <CAFULd4aEAfZWk8c2aX+rA9MX0Qso3nsu4Vp0c3oUnWgmvgjJjg@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 8:22=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 19 Oct 2023 at 11:14, Peter Zijlstra <peterz@infradead.org> wrote=
:
> >
> > But are you really saying this_cpu_read() should not imply READ_ONCE()?
>
> Well, Uros is saying that we may be *forced* to have that implication,
> much as I really hate it (and wonder at the competence of a compiler
> that forces the code-pessimizing 'volatile').

Please note that my patch mitigates exactly this. The propagation of
volatile(!) arguments allows huge instruction and code savings. By
using non-volatile asm, a very limited BB CSE can perhaps remove a few
asms. However, if there is no READ_ONCE requirement, then we can
simply remove "volatile" qualification for this_cpu_read from the
memory-ops patch. It will be like a field trip for the compiler,
because *then* it will be able to optimize everything without
limitations.

Uros.

> And the "it's not volatile" is actually our historical behavior. The
> volatile really is new, and didn't exist before your commit
> b59167ac7baf ("x86/percpu: Fix this_cpu_read()").
>
> So the whole "implies READ_ONCE()" really seems to be due to that
> *one* mistake in our percpu sequence locking code.
>
> Yes, it's been that way for 5 years now, but it was the other way
> around for the preceding decade....
>
>                     Linus

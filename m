Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA157CE661
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjJRS1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjJRS1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:27:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B98B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:27:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53f6ccea1eeso1344881a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697653627; x=1698258427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TU3G9xnPBOUL/P4ZcdOX0XkXjpSFEhyC5wq5582SnM=;
        b=TMYEoMLsISO0IFkzlgqc/lbx5XEjuV6aPXku6nAJkyrMAoFflgSWOqs1XwwfsSR6l1
         BJbwe9/uVOai8pwlPZaXdtMM+jmko74YYMhn8+QjhZNn4psT1k2sjMl7dvP614Z4b6Yy
         C0y5OZYqclixmND8EFnajf7q05P0HBBf4O+CamqL7SoSN5xH/oXOlZHI1mwzAU5syVli
         5lkPszhgjiMISeN+f8g0iugzwK9A4oKEBogJ0JUy/FcJtgZmACenfvXMzoLdEQ6OvORc
         9Ad0UxJtfR9v+Gq+zo9+XVdLztGGX5JAXWYuwk/qEKSh+Equ3t7B/4jw2MKerR2gygCx
         u3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653627; x=1698258427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TU3G9xnPBOUL/P4ZcdOX0XkXjpSFEhyC5wq5582SnM=;
        b=MNGjjvnkoF+sf+B9Vgx73L0nzS8CNp7yXcZPK+wYSq3XjuPgmiHvE0rS5DPSi1hnF2
         i0vxz/SX18OvXk25jCAFRdLbk77v81UC14hDxNi0Z1QcD1ebhoWPs+EBds111k8b+ikV
         mp1ckrnBtvCGxerXLAwE3RL2TaZzAtRCPOQNrD6PczfFKtjAJCn3qtIPLl4CUZZDIYap
         Mp+8AmLUwBoTcf7wRGdSrxht9DozwxF5iWHFE3/g/o9bCssZviSSK0FFoUTQi1avyUem
         wMuo59SBqfmVXc9X0zTTALyLxrMmN7o//803h8dCG+Du318WAZSh97ixrlqupkNntaoA
         Jh4A==
X-Gm-Message-State: AOJu0YzAi+wBgF2T1sD/sruCOipnHSP/FhR8uEZVEyOp3MqxQi/hnrIU
        ogYSAZsrtCBr2nVlLSBwtL0gUoesPmrcJ27lREI=
X-Google-Smtp-Source: AGHT+IFNP+QoxuXvgtYoSxeneqZrVArFubCjaBD+uccVuMQo6gceoQZN6OdhGvjGXFWgNWRVejhrDKUEZMnq5q/5bkE=
X-Received: by 2002:a50:9e48:0:b0:52d:212d:78e8 with SMTP id
 z66-20020a509e48000000b0052d212d78e8mr4064598ede.34.1697653627368; Wed, 18
 Oct 2023 11:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com> <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com> <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
 <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
 <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
 <CAFULd4bLEU-tBC8dO1wf66UAxQ2d1HxQ=D6wvtHZfdQCKhnpkw@mail.gmail.com>
 <CAFULd4YAFTFqon3ojv7N6h=G_1pAjSH3T6YvX0G=g7Fwh7j1jQ@mail.gmail.com>
 <A2E458DE-8B84-4FB2-BF6D-3EAB2B355078@vmware.com> <CAFULd4b_PdKb=8U5+Zz-XNoYdULtcQJnmf-yCrpCv7RRogSXyQ@mail.gmail.com>
 <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com>
 <3F9D776E-AD7E-4814-9E3C-508550AD9287@vmware.com> <CAFULd4Zruoq4b5imt3NfN4D+0RY2-i==KGAwUHR8JD0T8=HJBw@mail.gmail.com>
 <28B9471C-4FB0-4AB0-81DD-4885C3645E95@vmware.com> <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
 <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com> <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
In-Reply-To: <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 18 Oct 2023 20:26:55 +0200
Message-ID: <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Wed, Oct 18, 2023 at 8:16=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 18 Oct 2023 at 11:08, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > But loads from non-const memory work like the above.
>
> Yes, I'm certainly ok with the move to use plain loads from __seg_gs
> for the percpu accesses. If they didn't honor the memory clobber, we
> could never use it at all.
>
> I was just saying that the 'const' alias trick isn't useful for
> anything else than 'current', because everything else needs to at
> least honor our existing barriers.

FYI, smp_processor_id() is implemented as:

#define __smp_processor_id() __this_cpu_read(pcpu_hot.cpu_number)

where __this_* forces volatile access which disables CSE.

*If* the variable is really stable, then it should use __raw_cpu_read.
Both, __raw_* and __this_* were recently (tip/percpu branch)
implemented for SEG_SUPPORT as:

#define __raw_cpu_read(qual, pcp)                    \
({                                    \
    *(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));        \
})

where "qual" can be volatile. To enable smp_processor_id()
optimization, it just needs to be moved from __this to __raw accessor.

> (And yes, there's the other user of this_cpu_read_stable() -
> 'top_of_stack', but as mentioned that doesn't really matter).

Uros.

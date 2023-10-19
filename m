Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A11D7CFFA9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjJSQcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjJSQcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:32:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFCC11D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:32:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso2163038a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697733155; x=1698337955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVTjD06nPjN4qlm/QAgywdMGwl3XPRjema1T2xfU6+4=;
        b=DOXoNpJEJx1Nb5cq3Z6dADVHqYFZnoo7Y0jGhQkM7mGHnNem4DN1ZTYFeOKU/W8zLd
         ZiSfsHE2I3bU78k9RP7uOBywd93rVdpskwQkDPGEqu9NOl3Gs5xc2cXU3YQcSNfQMODz
         CgtKmHtzRhxv3kVtZUuHnv6WIyrBUIhW6OSGlLZsay2Fobvyr3MnpJo3gwSZzGX3FvW/
         QpbKUNCIIxxGh+DwQUvwyRQGWgwn/Qz+wBPabG3VhNf9E3CPJay099IV2WJY5gdEkliH
         aT/1yv3fDHihfvRsYeTD9FpJKUVFGGj5zCOxmeQup7JflKnFdXXnxChFIOwrv+AwCiaW
         Ql8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697733155; x=1698337955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVTjD06nPjN4qlm/QAgywdMGwl3XPRjema1T2xfU6+4=;
        b=Y4IW4VQo0ktIPaofTS8fuzgOUs2h2/U0V0UMcTn0ZPL2a+L6nvpYEHhUHzI4nEXBQl
         Py4AV19KvlYzMNGAi4zlpHZeFkzLV7fkN4Vdw7UTYTg1iLYD8Zc5QYsbKlSoPtup6sih
         48bGHZS6d9bGAswEY+rfCKoW1tD5W5fMwyz5D9ULp0sKb7mKnsCjHcK1lDrIQf21MqZp
         jRfyaXlYyA+dyXaPTompmw+r1WsA3wNcT+Yxcj7ZQnP4U2R1yH+Q15LMhvVyOZU2HAvA
         VskFxJpkHeCQMpoUUmTOKkIVklwHbmCFu6hyz2Udk+9Nm0LrLjWZ/lah4AW5DWQbneq6
         /Qvg==
X-Gm-Message-State: AOJu0YzNKI9KBmYJVNnNvda6RoxoalzlsLSO1N0dNu58+SegqA6epYdv
        DHzrLAkARkQpsbRUHstyav5cFbcTwkuuOfxXcsxh4zJnKks5ORMt
X-Google-Smtp-Source: AGHT+IFu0vEmjuRSIBd/WWEel+QAvl6Bznh2uokvugwZLhL8ato7e4lVSroU95LRxej7HRxKJl/p7+3YgU98I9fUnfo=
X-Received: by 2002:a50:cc03:0:b0:533:4a89:5b2e with SMTP id
 m3-20020a50cc03000000b005334a895b2emr2237858edi.1.1697733155449; Thu, 19 Oct
 2023 09:32:35 -0700 (PDT)
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
 <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
 <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
 <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com> <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 19 Oct 2023 18:32:21 +0200
Message-ID: <CAFULd4ZXh2oDrTUWNginc3SjKzcEsJq=aTThvJ47msmCYbRsnw@mail.gmail.com>
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

On Wed, Oct 18, 2023 at 10:22=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 18 Oct 2023 at 12:33, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > This pach works for me:
>
> Looks fine.
>
> But you actually bring up another issue:
>
> > BTW: I also don't understand the comment from include/linux/smp.h:
> >
> > /*
> >  * Allow the architecture to differentiate between a stable and unstabl=
e read.
> >  * For example, x86 uses an IRQ-safe asm-volatile read for the unstable=
 but a
> >  * regular asm read for the stable.
>
> I think the comment is badly worded, but I think the issue may actually b=
e real.
>
> One word: rematerialization.
>
> The thing is, turning inline asm accesses to regular compiler loads
> has a *very* bad semantic problem: the compiler may now feel like it
> can not only combine the loads (ok), but also possibly rematerialize
> values by re-doing the loads (NOT OK!).
>
> IOW, the kernel often has very strict requirements of "at most once"
> behavior, because doing two loads might give different results.
>
> The cpu number is a good example of this.
>
> And yes, sometimes we use actual volatile accesses for them
> (READ_ONCE() and WRITE_ONCE()) but those are *horrendous* in general,
> and are much too strict. Not only does gcc generally lose its mind
> when it sees volatile (ie it stops doing various sane combinations
> that would actually be perfectly valid), but it obviously also stops
> doing CSE on the loads (as it has to).
>
> So the "non-volatile asm" has been a great way to get the "at most
> one" behavior: it's safe wrt interrupts changing the value, because
> you will see *one* value, not two. As far as we know, gcc never
> rematerializes the output of an inline asm. So when you use an inline
> asm, you may have the result CSE'd, but you'll never see it generate
> more than *one* copy of the inline asm.
>
> (Of course, as with so much about inline asm, that "knowledge" is not
> necessarily explicitly spelled out anywhere, and it's just "that's how
> it has always worked").

Perhaps you will be interested in chapter 6.47.2.1, "Volatile" of GCC
manual that says:

" Under certain circumstances, GCC may duplicate (or remove duplicates
of) your assembly code when optimizing."

The compiler may re-materialize non-volatile asm in the same way it
may re-materialize arguments from non-volatile memory. To avoid this,
volatile asm is necessary when unstable memory arguments are accessed
using this_* variants.

Uros.

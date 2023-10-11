Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4617C5DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346981AbjJKUA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjJKUA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:00:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1619E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 13:00:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5334d78c5f6so442025a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697054454; x=1697659254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N++n3Jote5Wa5vsNaDvtu8z3YCnpc3qg46kanlFv2qc=;
        b=Yk1JTyjlcxx0etuy1WNro15lNg/gM9+6Zbx9EVavcHhqqVsYNdti7ni4lMkLwBK2Mf
         SjeaOr3GepfeObxpBbcys/N/9AkH65mV/jMyT5qsx5wA2rNnRP245TH20OV/xjQQxaoi
         TRtLslKlmnFztwZZ9KldMz7CeV/1H5kbHruvGyU4JdjCSyM/Yv53oR8CVwaeTT1Qmv4y
         winLmFWGw2Pf2xfT0H1Cx1xzV4Jr0deTzGWa5KlE+S4pgU1Fei4YNfD7wN5du5/2iMGo
         fFApNNtIU3HicpAEfkkEaBg7KBIfF2zgXVY/k1EsKvZg6Jh4RAjn2oUF3WR/i2OmiNQm
         QdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697054454; x=1697659254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N++n3Jote5Wa5vsNaDvtu8z3YCnpc3qg46kanlFv2qc=;
        b=QLBsY17Dj7WMjmugFYDS6Cj1P6LcVMK1caNqh8q5Oo7ImMrFpVxH/24S0gRUNSHN4R
         hRry+XvdTQo4+8OopL4KioxIPtvwXOJooD68FCVSITtVerTJCSnDJBHcTa5FNnb7qoMS
         U3wekgdMlGU6OpX0AYSOL0Rm6wMSqmPEAD5XrQBz3R2U/RctvzwuXpCfdXNg3jdXGLab
         o1lDiOZlDnTy5MRZKu/FSF1x+VXuwWwNLWHG7aI7pHHs/YkKtd0SgAwtBsQhp/8nR6G5
         +kfcdh7BPpJRg04MqCNuXQoQZOMJmi9d1v57N0mZbeIP0GOajQPejVylSd0kdXCWY239
         OvZg==
X-Gm-Message-State: AOJu0YxZgCXUILteI9xM/8cmmvFs6PNFAv/DLp6FaZSNQp2imEXcSM4L
        0WyRW7e/0vVT8UpomXqKOGzrC0zqHZWPMhh5aT4=
X-Google-Smtp-Source: AGHT+IGOM6S3sHy4OWeoOs0OHj4EGK+fJW8JyS+uTYZSJOQukKbaSzSlEZd3pio9hJnDrdpiRxCRlHWaJnfv3eYzIQY=
X-Received: by 2002:a05:6402:944:b0:53d:e875:d229 with SMTP id
 h4-20020a056402094400b0053de875d229mr1837676edz.29.1697054453531; Wed, 11 Oct
 2023 13:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com>
 <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
 <CAFULd4afyYK0-wAOo3oJDapX0iyu86m5+vVn9c35gk8fd6iwRQ@mail.gmail.com> <CAHk-=wiLyA0g3BvQ_nsF2PWi-FDtcNS5+4-ai1FX-xFzTBeTzg@mail.gmail.com>
In-Reply-To: <CAHk-=wiLyA0g3BvQ_nsF2PWi-FDtcNS5+4-ai1FX-xFzTBeTzg@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 11 Oct 2023 22:00:42 +0200
Message-ID: <CAFULd4ZSorEEkUZOobAyDzkyG+DujEoUOGiMPuiqd9V3C-a39w@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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

On Wed, Oct 11, 2023 at 9:52=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 11 Oct 2023 at 11:42, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > The attached patch was tested on a target with fsgsbase CPUID and
> > without it. It works!
>
> .. I should clearly read all my emails before answering some of them.
>
> Yes, that patch looks good to me, and I'm happy to hear that you
> actually tested it unlike my "maybe something like this".
>
> > The patch improves amd_pmu_enable_virt() in the same way as reported
> > in the original patch submission and also reduces the number of percpu
> > offset reads (either from this_cpu_off or with rdgsbase) from 1663 to
> > 1571.
>
> Dio y ou have any actka performance numbers? The patch looks good to
> me, and I *think* rdgsbase ends up being faster in practice due to
> avoiding a memory access, but that's very much a gut feel.

Unfortunately, I don't have any perf numbers, only those from Agner's
instruction tables. The memory access performance has so many
parameters, that gut feeling is the only thing besides real
case-by-case measurements. The rule of thumb in the compiler world is
also that memory access should be avoided.

Uros.

>
> > The only drawback is a larger binary size:
> >
> >   text    data     bss     dec     hex filename
> > 25546594        4387686  808452 30742732        1d518cc vmlinux-new.o
> > 25515256        4387814  808452 30711522        1d49ee2 vmlinux-old.o
> >
> > that increases by 31k (0.123%), probably due to 1578 rdgsbase alternati=
ves.
>
> I'm actually surprised that it increases the text size. The 'rdgsbase'
> instruction should be smaller than a 'mov %gs', so I would have
> expected the *data* size to increase due to the alternatives tables,
> but not the text size.
>
> [ Looks around ]
>
> Oh. It's because we put the altinstructions into the text section.
> That's kind of silly, but whatever.
>
> So I think that increase in text-size is not "real" - yes, it
> increases our binary size because we obviously have two instructions,
> but the actual *executable* part likely stays the same, and it's just
> that we grow the altinstruction metadata.
>
>                   Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CAF760A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjGYGeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjGYGeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:34:01 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3805F1A3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:33:58 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-48642554ef1so20520e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690266837; x=1690871637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJiABalTnNOwXnyvNkpYhcHXJylF/mDcXUtdtHNtQlo=;
        b=JjF/ChxWctx9l8TcaLzR4eZEiVmL72rdmCOFZibFWPV4KCsyp6+cGWGodIneYy2KFs
         xoZZyVZO9GABg5KJSdBoYeF1jUZwb9A6R7L0CQEVsRa8qqI3DCiuJiOn2fqjJEHOw2/x
         Gk9VPr3jzNGr/1qNA/jY0xJ12cieeEqtAqeMjPGzOdvJ+3r4AFZLFOQ8FpKeANyMuvBQ
         8OkD32Gy3U7Cyt9r18Q1Gq44W2yt3ELo2ALPQpq5p1iUNZ9O0Gh6cgmyYSTRGrZYuuG2
         RSo/4vREQerONmfi48BU6SMu4kF5lv3JoHX01L1mGtPsA5RnSrgjiuubhFClGG/SZeGj
         R4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690266837; x=1690871637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJiABalTnNOwXnyvNkpYhcHXJylF/mDcXUtdtHNtQlo=;
        b=dlpDTLrkmthK9dGxmdncb9fd4/IxmUKGoBqACoVomdXF/XkVA4FHuMT/NribBvDg0/
         /R6QLoD+EC6OrXIRuOKCkYBS3vidcnTYAsO/5fA7Y6jtd0vk0KBcztbQYTHpmoxLH8KH
         kZ2+ijoJLc0TYP3k+2Y1MdxUq/DyGe8uwIotfehfmgHC0yOD4bfaME2GuKsZ9hzBJui1
         a5OSUpDxMqeY4JRLqa4pHhflAB1AiTWn0h7ImrmbTfqJb2SmRN0MOrsrKI219dTQbFsZ
         z8HAUVrhLqyqOa97mA/Z4N6zNv0SBE1JSlsxDqUEdstjF/qdCUWl7ZnePmNSEkpGqOKK
         0RCw==
X-Gm-Message-State: ABy/qLaXvdqJh3q77eag8NKsq272wUqxZAJ05cCb2Ge97YOoRD/1WYRo
        oXnm5cmgjkcMxKb/KWep97yQJdad0IQ+CYt2B3Li8Q==
X-Google-Smtp-Source: APBJJlHqSKuH1SYFf6eixLBXB80dstDot3RlrsqXOAEQuvJWyuFv15EeCvek9py5YvflvvEmbZzEDsw99utxeCV7bk4=
X-Received: by 2002:a1f:4388:0:b0:486:3e4a:8adb with SMTP id
 q130-20020a1f4388000000b004863e4a8adbmr141413vka.6.1690266837163; Mon, 24 Jul
 2023 23:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuifLivwhCh33kedtpU=6zUpTQ_uSkESyzdRKYp8WbTFQ@mail.gmail.com>
 <ZJLzsWsIPD57pDgc@FVFF77S0Q05N> <ZJQXdFxoBNUdutYx@FVFF77S0Q05N>
 <CA+G9fYtAutjL3KpZsQyJuk4WqS=Ydi2iyVb5jdecZ-SOuzKCmA@mail.gmail.com>
 <CANk7y0h+oXNhUzTFQ_Wy-iySRdBi0ezu1Y_hOBtAxmK5AG4dgA@mail.gmail.com> <CANk7y0gi4o+4U6c9QmnDCJDRXNM_98or_4tO-dHOEwZ4fj3gkw@mail.gmail.com>
In-Reply-To: <CANk7y0gi4o+4U6c9QmnDCJDRXNM_98or_4tO-dHOEwZ4fj3gkw@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Jul 2023 12:03:45 +0530
Message-ID: <CA+G9fYvjJgLyEHymByjE8y4OhWfTWbUmQOn0oT2FZoL3T4orVw@mail.gmail.com>
Subject: Re: next: Rpi4: Unexpected kernel BRK exception at EL1
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Puranjay,

On Mon, 3 Jul 2023 at 15:07, Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Hi Naresh,
>
> On Mon, Jun 26, 2023 at 11:04=E2=80=AFAM Puranjay Mohan <puranjay12@gmail=
.com> wrote:
> >
> > Hi Naresh,
> >
> > On Thu, Jun 22, 2023 at 2:35=E2=80=AFPM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > > Hi Mark,
> > >
> > > On Thu, 22 Jun 2023 at 15:12, Mark Rutland <mark.rutland@arm.com> wro=
te:
> > > >
> > > > On Wed, Jun 21, 2023 at 01:57:21PM +0100, Mark Rutland wrote:
> > > > > On Wed, Jun 21, 2023 at 06:06:51PM +0530, Naresh Kamboju wrote:
> > > > > > Following boot warnings and crashes noticed on arm64 Rpi4 devic=
e running
> > > > > > Linux next-20230621 kernel.
> > > > > >
> > > > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > > >
> > > > > > boot log:
> > > > > >
> > > > > > [   22.331748] Kernel text patching generated an invalid instru=
ction
> > > > > > at 0xffff8000835d6580!
> > > > > > [   22.340579] Unexpected kernel BRK exception at EL1
> > > > > > [   22.346141] Internal error: BRK handler: 00000000f2000100 [#=
1] PREEMPT SMP
> > > > >
> > > > > This indicates execution of AARCH64_BREAK_FAULT.
> > > > >
> > > > > That could be from dodgy arguments to aarch64_insn_gen_*(), or el=
sewhere, and
> > > > > given this is in the networking code I suspect this'll be related=
 to BPF.
> > > > >
> > > > > Looking at next-20230621 I see commit:
> > > > >
> > > > >   49703aa2adfaff28 ("bpf, arm64: use bpf_jit_binary_pack_alloc")
> > > > >
> > > > > ... which changed the way BPF allocates memory, and has code that=
 pads memory
> > > > > with a bunch of AARCH64_BREAK_FAULT, so it looks like that *might=
* be related.
> > > >
> > > > For the benefit of those just looknig at this thread, there has bee=
n some
> > > > discussion in the original thread for this commit. Summary and link=
s below.
> > > >
> > > > We identified a potential issue with missing cache maintenance:
> > > >
> > > >   https://lore.kernel.org/linux-arm-kernel/ZJMXqTffB22LSOkd@FVFF77S=
0Q05N/
> > > >
> > > > Puranjay verified that was causing the problem seen here:
> > > >
> > > >   https://lore.kernel.org/linux-arm-kernel/CANk7y0h5ucxmMz4K8sGx7qo=
gFyx6PRxYxmFtwTRO7=3D0Y=3DB4ugw@mail.gmail.com/
> > > >
> > > > Alexei has dropped this commit for now:
> > > >
> > > >   https://lore.kernel.org/linux-arm-kernel/CAADnVQJqDOMABEx8JuU6r_D=
ehyf=3DSkDfRNChx1oNfqPoo7pSrw@mail.gmail.com/
> > >
> > > Thanks for the detailed information.
> > > I am happy to test any proposed fix patches.
> >
> > I have sent the v4 of the patch series:
> > https://lore.kernel.org/bpf/20230626085811.3192402-1-puranjay12@gmail.c=
om/T/#t
> > This works on my raspberry pi 4 setup. If possible can you test this
> > on the similar setup where it was failing earlier?
>
> I think my previous email was missed.
> Can you test the V4 series in the same setup?

I have tested V4 series and reported issues got fixed.

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Thank you !

> This is still not applied to the bpf-next tree.
>
> Thanks,
> Puranjay.

- Naresh

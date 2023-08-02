Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4153C76C1DD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjHBBFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjHBBFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:05:45 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C827726AA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:05:35 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-267f8f36a3cso3840128a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 18:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690938335; x=1691543135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOfoEhakv6Y5bu64uKylY9xP9VvxltVfyqfhwcx3DFg=;
        b=nh9GHiP82vnYxjw8IeEC5XpM9aY0Jr0IkMQBMbEnN2Mvsd2lqz8B+xI79BT7nRy2Qx
         xvwGw8z9BqaiKV+E2W291BUrta5viEfdYotxD4L/V7oRY0ctpwpNk8Su0RlOqRH4Zs1o
         qH545yj+jMsy1LYP897m+mNY+dngAJtvluo9m5S8xwo0/nyQziKX0qNFoboRbO/MPohG
         9julpi1FGhsEa/w/a58XzYhhYKfd3+O5ufHQvVDddDxZtAyhTHQfC/UG0e2uTzpO4fvf
         DKw5/b37n6P/3Q2aVes7yMla+z8JScKjivQgCflBwJKJToVk1L6+mabGS6cW/VWM4XBG
         bnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690938335; x=1691543135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOfoEhakv6Y5bu64uKylY9xP9VvxltVfyqfhwcx3DFg=;
        b=B4sSi+g8+MqkBzxRK8NEM7u1JwFdLwVGrf9wooyI/hUk9urynRlNlrSiDOv1jvKFti
         UpWUUeomPRGE974Lo4IaiIlw5f0BHeSDcRjGc37KP7H5xjpHpMZ6jhr5bOhhR9eIFgOh
         7TzwIZ99wteEQHmNgqvHheJnirH4t8aqqqCXwerquxcD/tRgOBk7EPQyOBrGb3TdxyUy
         /4h76XdBHZ23T/Kar66XQIXNZw5jKmspJeFG/2uVUJ/Or8ykbF5xFO/A7gpGI6kjT22R
         Tj6z7UsSMaz6xhyw/joGhJfUcWO2+frCELnCcfL6CpIv9+XRsZpihfgZfO4F8TUUnbrJ
         luWQ==
X-Gm-Message-State: ABy/qLYAfWcgsnaPkLjJT53BEnHvWxODvRvChXQJ6eeYkLoIHYfKza/A
        E0/8dF6cJaYowKOiq33y0brng8SMPiFNoW6yHnU=
X-Google-Smtp-Source: APBJJlHGV9wmFO84BvXYJ4645A87rM42LBCYV5BMbJpZtIBwMzhra96BSsEsKx62x8u1seqzZpPc4U1LtcDjPet3q18=
X-Received: by 2002:a17:90a:4815:b0:262:ded7:63d with SMTP id
 a21-20020a17090a481500b00262ded7063dmr13287058pjh.17.1690938335162; Tue, 01
 Aug 2023 18:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230801111014.1432679-1-suagrfillet@gmail.com>
 <CAHVXubgv1xmH7ZF9WsBQ=hYYk1PpKH5PUmYnSH1QTU-Jg1=xOA@mail.gmail.com> <CAJF2gTR-OTfbYVZD2uWm4GFOxbva_OpR70tbhYf197bX+yngRQ@mail.gmail.com>
In-Reply-To: <CAJF2gTR-OTfbYVZD2uWm4GFOxbva_OpR70tbhYf197bX+yngRQ@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Wed, 2 Aug 2023 01:05:23 +0000
Message-ID: <CAAYs2=g2sm=mdoET5tMwBTPwpc-Um-2Xabt9QCaWmAi_VfWTYg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Correct the MODULES_VADDR
To:     Guo Ren <guoren@kernel.org>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        akpm@linux-foundation.org, sergey.matyukevich@syntacore.com,
        david@redhat.com, wangkefeng.wang@huawei.com,
        panqinglin2020@iscas.ac.cn, woodrow.shen@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

Guo Ren <guoren@kernel.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=881=E6=97=A5=E5=
=91=A8=E4=BA=8C 23:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Aug 1, 2023 at 8:05=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
> >
> > Hi Song,
> >
> > On Tue, Aug 1, 2023 at 1:10=E2=80=AFPM Song Shuai <suagrfillet@gmail.co=
m> wrote:
> > >
> > > As Documentation/riscv/vm-layout.rst describes, the 2G-sized "modules=
, BPF"
> > > area should lie right before the "kernel" area. But the current defin=
ition
> > > of MODULES_VADDR isn't consistent with that, so correct it.
> > >
> > > Before this patch, the size of "modules" from print_vm_layout() is no=
t 2G.
> > >
> > > [    0.000000]      modules : 0xffffffff2ff2f000 - 0xffffffffae600000=
 (2022 MB)
> > > [    0.000000]       lowmem : 0xff60000000000000 - 0xff60000040000000=
 (1024 MB)
> > > [    0.000000]       kernel : 0xffffffffae600000 - 0xffffffffffffffff=
 (1305 MB)
> > >
> > > After this patch, the size is 2G.
> > >
> > > [    0.000000]      modules : 0xffffffff3a000000 - 0xffffffffba000000=
 (2048 MB)
> > > [    0.000000]       lowmem : 0xff60000000000000 - 0xff60000040000000=
 (1024 MB)
> > > [    0.000000]       kernel : 0xffffffffba000000 - 0xffffffffffffffff=
 (1119 MB)
> > >
> > > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > > ---
> > >  arch/riscv/include/asm/pgtable.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/as=
m/pgtable.h
> > > index 75970ee2bda2..7c57e17fc758 100644
> > > --- a/arch/riscv/include/asm/pgtable.h
> > > +++ b/arch/riscv/include/asm/pgtable.h
> > > @@ -53,8 +53,8 @@
> > >  #ifdef CONFIG_64BIT
> > >  /* This is used to define the end of the KASAN shadow region */
> > >  #define MODULES_LOWEST_VADDR   (KERNEL_LINK_ADDR - SZ_2G)
> > > -#define MODULES_VADDR          (PFN_ALIGN((unsigned long)&_end) - SZ=
_2G)
> > >  #define MODULES_END            (PFN_ALIGN((unsigned long)&_start))
> > > +#define MODULES_VADDR          (MODULES_END - SZ_2G)
> > >  #endif
> > >
> > >  /*
> > > --
> > > 2.20.1
> > >
> >
> > The documentation is approximative, the modules must stay within a 2GB
> > window to *all* the kernel symbols, hence the __end - 2G, not __start.
> Thus, the ftrace detour trampoline could cover all kernel symbols.
>
That's another view to help me understand the definition of
MODULES_VADDR,Thanks.
> --
> Best Regards
>  Guo Ren



--=20
Thanks,
Song

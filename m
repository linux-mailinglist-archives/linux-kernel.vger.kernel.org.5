Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E881578A66C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjH1H0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjH1H0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:26:15 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE081115
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:26:12 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-573921661a6so268590eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1693207572; x=1693812372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vleBfG73dh7bJwkNGyPr2b1/w7KVwTHRq/QGiLU/Y8k=;
        b=BrS/MIx6hYHBxl3MR0MS1/1C9jNXuyp+akURuy08kzv7rNnKxhNker1ZHQPsuSkdjM
         RbmOZUkjDvB96rbJyiQ9tud5WUP7AOxzdzt1oZYuxeyfRADhIKuxRyhZibu/nCRkI5Lx
         HV3qFOn/b94kBdbcHSfM+IDbn4O+0Fp1NVvRrMqzSh9jFNsdBH4GOHH/K8F85DHNXBhM
         cr/8i9mx/2RR7Jh8bqRb9de4J9brOrpdh/Tycs6tFmwPyqh8bWU5p1Rat+Ax8jbwbCEk
         Y6k4z7nzhJtNUKcrmT4sMe0tCsdx6tyDgIKuXtyRpdf3d+aTnRXGKPTbfpE76K6xv/e8
         2/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693207572; x=1693812372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vleBfG73dh7bJwkNGyPr2b1/w7KVwTHRq/QGiLU/Y8k=;
        b=Nppum7II8CPP8s599/iMIImbsyxe1PffrZ6GOYMrKtaBh8Zt0DTEnVMmIWPApUN6va
         O2ZFcRJmN52qdqyPgr+oEfk+Ps79lJV95ySwRPvS4sN8Rke1rOEuwMGHPZeYuG6fdcA0
         HPq7Ufkuq+AfPtQzS07Kf9pkZ6gsCgdxOaFuLfFLmkt8yzcE+88jysz5BTdQHw2Je9lD
         hWEAPcSpygjYm9DTH1cZ8JZe6tzNEw/29w3NGxhXwVqAzH63QumuvlmDdme6FhUtjqRg
         xTON4SSmSu5Eile1UhKB1O2RpKloHfLsNXauKVuk5n3Q29TOISycgVPalch+JsWTXbnT
         8KDA==
X-Gm-Message-State: AOJu0YwQcqn7heXp/h92LBl9oW1NDsm5ktAdKNHw7NabB98pKvDzOAPK
        UPJtuRgM8OVVOY3pjxUwZXnUgF1Ml6oF6q2LsRuAAg==
X-Google-Smtp-Source: AGHT+IGYCw0s4XqRr6eH3dESRTk9/xreZOsRixT90RR4vh26isG1q3NHV4KAVoSKfpKkBfOhgL4w51UACc7StJ2QpMA=
X-Received: by 2002:a4a:6211:0:b0:56e:4921:deb0 with SMTP id
 x17-20020a4a6211000000b0056e4921deb0mr9998569ooc.8.1693207572126; Mon, 28 Aug
 2023 00:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230129064956.143664-1-tjytimi@163.com> <CAMWQL2gBj84qhBopi=YKmHaUose2ggALKtOWqb6adDiuvS5xcg@mail.gmail.com>
 <6dcfcf22-08a4-ba1f-17c2-75f93efb6329@ghiti.fr>
In-Reply-To: <6dcfcf22-08a4-ba1f-17c2-75f93efb6329@ghiti.fr>
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date:   Mon, 28 Aug 2023 15:26:01 +0800
Message-ID: <CAMWQL2h3OTeiV=P+LOp2FwJsc8SKTUH1gi3gYTGDdhP+KNQpdw@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: support arch_has_hw_pte_young()
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Jinyu Tang <tjytimi@163.com>, palmer@rivosinc.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com, yuzhao@google.com,
        conor.dooley@microchip.com, ajones@ventanamicro.com,
        guoren@kernel.org, tongtiangen@huawei.com, anup@brainfault.org,
        akpm@linux-foundation.org, falcon@tinylab.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Sat, Aug 26, 2023 at 3:39=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Yong-Xuan,
>
>
> On 25/08/2023 07:42, Yong-Xuan Wang wrote:
> > Hi Jinyu,
> >
> > It seems like it has been a while since the last release of this patch.=
 Do
> > you have any plans for the patch recently? Or, do you mind sharing any
> > internal progress on the patch?
> >
> > We are starting to work on the Svadu extension of pte A/D bit feature o=
n
> > Linux.
>
>
> This task was assigned to me on the RISE kernel spreadsheet, if you
> indeed take over, I'll change it to your name: any objection?
>
>

Yes, that's fine with me. Thank you!

Regards,
Yong-Xuan

> Thanks,
>
>
> Alex
>
>
> > Do you find any places where we may potentially work together to
> > get things moving? Also, I am willing to base on top of your work and
> > continue sending the series (by keeping all the credits from the origin=
al
> > work)
> >
> > Please let me know if you have any thoughts, thanks :)
> >
> > Regards,
> > Yong-Xuan
> >
> > On Sun, Jan 29, 2023 at 2:53=E2=80=AFPM Jinyu Tang <tjytimi@163.com> wr=
ote:
> >> The arch_has_hw_pte_young() is false for riscv by default. If it's
> >> false, page table walk is almost skipped for MGLRU reclaim. And it
> >> will also cause useless step in __wp_page_copy_user().
> >>
> >> RISC-V Privileged Book says that riscv have two schemes to manage A
> >> and D bit.
> >>
> >> So add a config for selecting, the default is true. For simple
> >> implementation riscv CPU which just generate page fault, unselect it.
> >>
> >> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> >> ---
> >>   arch/riscv/Kconfig               | 10 ++++++++++
> >>   arch/riscv/include/asm/pgtable.h |  7 +++++++
> >>   2 files changed, 17 insertions(+)
> >>
> >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> index e2b656043abf..17c82885549c 100644
> >> --- a/arch/riscv/Kconfig
> >> +++ b/arch/riscv/Kconfig
> >> @@ -180,6 +180,16 @@ config PAGE_OFFSET
> >>          default 0x80000000 if 64BIT && !MMU
> >>          default 0xff60000000000000 if 64BIT
> >>
> >> +config ARCH_HAS_HARDWARE_PTE_YOUNG
> >> +       bool "Hardware Set PTE Access Bit"
> >> +       default y
> >> +       help
> >> +         Select if hardware set A bit when PTE is accessed. The defau=
lt is
> >> +         'Y', because most RISC-V CPU hardware can manage A and D bit=
.
> >> +         But RISC-V may have simple implementation that do not suppor=
t
> >> +         hardware set A bit but only generate page fault, for that ca=
se just
> >> +         unselect it.
> >> +
> >>   config KASAN_SHADOW_OFFSET
> >>          hex
> >>          depends on KASAN_GENERIC
> >> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm=
/pgtable.h
> >> index 4eba9a98d0e3..1db54ab4e1ba 100644
> >> --- a/arch/riscv/include/asm/pgtable.h
> >> +++ b/arch/riscv/include/asm/pgtable.h
> >> @@ -532,6 +532,13 @@ static inline int ptep_clear_flush_young(struct v=
m_area_struct *vma,
> >>           */
> >>          return ptep_test_and_clear_young(vma, address, ptep);
> >>   }
> >> +#ifdef CONFIG_ARCH_HAS_HARDWARE_PTE_YOUNG
> >> +#define arch_has_hw_pte_young arch_has_hw_pte_young
> >> +static inline bool arch_has_hw_pte_young(void)
> >> +{
> >> +       return true;
> >> +}
> >> +#endif
> >>
> >>   #define pgprot_noncached pgprot_noncached
> >>   static inline pgprot_t pgprot_noncached(pgprot_t _prot)
> >> --
> >> 2.30.2
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

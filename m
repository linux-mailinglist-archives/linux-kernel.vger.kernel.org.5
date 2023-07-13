Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3582E752B77
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjGMUND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjGMUM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:12:58 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE1E270B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:12:31 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-c4dd264359cso990148276.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689279150; x=1691871150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJH06eQc+B3mlka9ca3yWe/BFaVZyKNH/FYbTdupon0=;
        b=sq8DoIAkiJTqj/hA0HbPY+Du/lUKvsOypg9bWyJovvwhPvhZLs9OnAATt6DyWj3fhk
         rMqRmV+ckvKtX3mqEovL47UsfIWG+DISWqHsS1jzloQgfd80YPjUGEY2gPScLUzXv3aj
         bEKoTztrMYpGlhl7OU1cNI+EkY48vwK5Af5vcxbKGaAcx3oeCKF43vTk9dp0Os+ehnOh
         4Vot+I5Pq1W7h0Qif76nH99c7qDXBLn72YuUgO10h1+BnKw70/5dvPpRQiXxmJnABb9F
         k/FYmn1X8GMw43PAkTPuZbREEdx6SXIktOvGYFRyjOtq0ls4Ne1B0u4C5shdFL81lA90
         k6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689279150; x=1691871150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJH06eQc+B3mlka9ca3yWe/BFaVZyKNH/FYbTdupon0=;
        b=dr0nJY0eC4L1q9eHDFPUaPpUC5Bsk5p//Opll72t3zmLGFV9WD6+0WtCR740t/4tm8
         KUp404UAOUSF2M0/Z6I2PwjO+CBTzFDeOwNLXA5CESL5IZHLcqs8x1n20ipyBYYyzk2s
         gUUpmXmiFIRfmDVpVOJUXppdE8sO37riluGz3V2c92q7M3KDI7xKiz+HL/XopaG04oPZ
         d24QbcAruwNQ7pxItrgTNrSCRZRj11s/6rXiFehBJ9BTlGYftLDYWg8+Yq9t/iDSinjV
         aWnZp2hbDP3xvmbCvNJAfoWIo8rYjthPa5bK6bPMEwdDEzK9Ug6oihndgnMUf2g6a5MD
         9g9Q==
X-Gm-Message-State: ABy/qLb2pMM8SV5LPmRZ7ANvYYTIoTBHXRNqM9Onf/Qmn/i1I5JhZ7YP
        r882zSVwRUfr3s3atQDBNIkBPwAMZuxukrtMjnxIog==
X-Google-Smtp-Source: APBJJlHsBJjb/bCQUIDnbMcslY/+BRvpuOtfSJIDEY65ZXVL8Q9oqboC4ArbmfQevCrjLrPcX1Bsga2B7wxkVG3h+b4=
X-Received: by 2002:a25:317:0:b0:c67:d3cd:6989 with SMTP id
 23-20020a250317000000b00c67d3cd6989mr2431008ybd.21.1689279150076; Thu, 13 Jul
 2023 13:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230713095339.189715-1-wangkefeng.wang@huawei.com>
 <20230713095339.189715-2-wangkefeng.wang@huawei.com> <ZLAjFQGgcjt4ykS7@casper.infradead.org>
In-Reply-To: <ZLAjFQGgcjt4ykS7@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 13 Jul 2023 13:12:15 -0700
Message-ID: <CAJuCfpGBaAJof=5-Xh1saoN9dhOauMiHBZzb0crVNn9OyOeZHw@mail.gmail.com>
Subject: Re: [PATCH rfc -next 01/10] mm: add a generic VMA lock-based page
 fault handler
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 9:15=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> > +int try_vma_locked_page_fault(struct vm_locked_fault *vmlf, vm_fault_t=
 *ret)
> > +{
> > +     struct vm_area_struct *vma;
> > +     vm_fault_t fault;
>
>
> On Thu, Jul 13, 2023 at 05:53:29PM +0800, Kefeng Wang wrote:
> > +#define VM_LOCKED_FAULT_INIT(_name, _mm, _address, _fault_flags, _vm_f=
lags, _regs, _fault_code) \
> > +     _name.mm                =3D _mm;                  \
> > +     _name.address           =3D _address;             \
> > +     _name.fault_flags       =3D _fault_flags;         \
> > +     _name.vm_flags          =3D _vm_flags;            \
> > +     _name.regs              =3D _regs;                \
> > +     _name.fault_code        =3D _fault_code
>
> More consolidated code is a good idea; no question.  But I don't think
> this is the right way to do it.
>
> > +int __weak arch_vma_check_access(struct vm_area_struct *vma,
> > +                              struct vm_locked_fault *vmlf);
>
> This should be:
>
> #ifndef vma_check_access
> bool vma_check_access(struct vm_area_struct *vma, )
> {
>         return (vma->vm_flags & vm_flags) =3D=3D 0;
> }
> #endif
>
> and then arches which want to do something different can just define
> vma_check_access.
>
> > +int try_vma_locked_page_fault(struct vm_locked_fault *vmlf, vm_fault_t=
 *ret)
> > +{
> > +     struct vm_area_struct *vma;
> > +     vm_fault_t fault;
>
> Declaring the vmf in this function and then copying it back is just wrong=
.
> We need to declare vm_fault_t earlier (in the arch fault handler) and
> pass it in.

Did you mean to say "we need to declare vmf (struct vm_fault) earlier
(in the arch fault handler) and pass it in." ?

>  I don't think that creating struct vm_locked_fault is the
> right idea either.
>
> > +     if (!(vmlf->fault_flags & FAULT_FLAG_USER))
> > +             return -EINVAL;
> > +
> > +     vma =3D lock_vma_under_rcu(vmlf->mm, vmlf->address);
> > +     if (!vma)
> > +             return -EINVAL;
> > +
> > +     if (arch_vma_check_access(vma, vmlf)) {
> > +             vma_end_read(vma);
> > +             return -EINVAL;
> > +     }
> > +
> > +     fault =3D handle_mm_fault(vma, vmlf->address,
> > +                             vmlf->fault_flags | FAULT_FLAG_VMA_LOCK,
> > +                             vmlf->regs);
> > +     *ret =3D fault;
> > +
> > +     if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> > +             vma_end_read(vma);
> > +
> > +     if ((fault & VM_FAULT_RETRY))
> > +             count_vm_vma_lock_event(VMA_LOCK_RETRY);
> > +     else
> > +             count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> > +
> > +     return 0;
> > +}
> > +
> >  #endif /* CONFIG_PER_VMA_LOCK */
> >
> >  #ifndef __PAGETABLE_P4D_FOLDED
> > --
> > 2.27.0
> >
> >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831BD769F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjGaRVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjGaRV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:21:27 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EE01BD9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:21:20 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-348c7075afcso4695ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690824079; x=1691428879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1yc8T49I2SK2WZwiTxo7poffYgxmNdrGJbub/r4Zew=;
        b=3sVZ6Pvu0MXolTiQ3qzM8kGAaMnBBEr6wdfZ02tKrrgnWJIvo3F3TkblR8+mCeqLz7
         1qXflSuEUvBPQ5UPzgIjQfEu4vFikLzhtIHvIPBXHMzl0AM/kqpA5ISl2NMmQYhDROP+
         9e8klrqjKR1eutqvlrh4m6oRlLgNeD45MZr0hKazL8rfmsz5VFIrEaoD9EbMPVM48OeE
         qCplx75r36D9baB9hAs1IgOBsL9TNbtYYnYvs0rvOqAoqW6tw1XlEV1PEwetGi2gpp4a
         kbIlhN/ej8BKcLn9QF4bsJVwJkRXrgYR7F2khR014azoZLG2kmXOWrtv2RUvhNa4ZpL3
         3Pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690824079; x=1691428879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1yc8T49I2SK2WZwiTxo7poffYgxmNdrGJbub/r4Zew=;
        b=S8395c6L5bFtQJY6ySwahYMT7AaAWutgxxaHVOQHVCXpHoWm7tkydat9E3m/T915Oi
         GioCEpOUnzqhftjuJsNS4R+5h6URI5LtlRErCmqRannhKIg+vNj+2VX3ZvxLi6flDF5S
         YgoP4vlM7VaVVqG/SzJYSqu8mlsWJSMBGf5E2/xkLbcesJb1aaZvE02v2YYR+zjJY4Ac
         FtJ9vNMHgWUONFADKzg5dbt//rHgLUsbbAD51Qm3bYhOfoBwFAjwsaaHFj7imhHQshoB
         WT8B5Rnvbnyx0xDZoCI8yPH5bIPrkXqMfJiB8yRkLgEAWBItjTBnRkTfUpgfpcAX+7eq
         BU9g==
X-Gm-Message-State: ABy/qLadP7hGUZk0IbaTmnaAU/EXgyBcfWgxVF9j7ZWf9YIHLrdbvwYN
        MzPlkTFSmS8h4CnsG4u0JIFwywEyqteICW06giG9Sw==
X-Google-Smtp-Source: APBJJlF2POzs0JiDlLB6/5fj5bT2PEm625iQ8R7ZMp4vjPEFJvEfQgAYflOknaXzwi3RrOdMIJI9UZP+pXJQibDjrAE=
X-Received: by 2002:a05:6e02:144d:b0:346:48bd:da43 with SMTP id
 p13-20020a056e02144d00b0034648bdda43mr600950ilo.4.1690824079368; Mon, 31 Jul
 2023 10:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230722022251.3446223-1-rananta@google.com> <20230722022251.3446223-2-rananta@google.com>
 <87v8e5r6s6.wl-maz@kernel.org>
In-Reply-To: <87v8e5r6s6.wl-maz@kernel.org>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Mon, 31 Jul 2023 10:21:08 -0700
Message-ID: <CAJHc60wtc2Usei3hKj1ykVRvBZFFCBOHMi9HCxnNvGK2dPFApA@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] KVM: Rename kvm_arch_flush_remote_tlb() to kvm_arch_flush_remote_tlbs()
To:     Marc Zyngier <maz@kernel.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Gavin Shan <gshan@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        Shaoqin Huang <shahuang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 3:24=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Sat, 22 Jul 2023 03:22:40 +0100,
> Raghavendra Rao Ananta <rananta@google.com> wrote:
> >
> > From: David Matlack <dmatlack@google.com>
> >
> > Rename kvm_arch_flush_remote_tlb() and the associated macro
> > __KVM_HAVE_ARCH_FLUSH_REMOTE_TLB to kvm_arch_flush_remote_tlbs() and
> > __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS respectively.
> >
> > Making the name plural matches kvm_flush_remote_tlbs() and makes it mor=
e
> > clear that this function can affect more than one remote TLB.
> >
> > No functional change intended.
> >
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> > ---
> >  arch/mips/include/asm/kvm_host.h | 4 ++--
> >  arch/mips/kvm/mips.c             | 2 +-
> >  arch/x86/include/asm/kvm_host.h  | 4 ++--
> >  include/linux/kvm_host.h         | 4 ++--
> >  virt/kvm/kvm_main.c              | 2 +-
> >  5 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/k=
vm_host.h
> > index 04cedf9f8811..9b0ad8f3bf32 100644
> > --- a/arch/mips/include/asm/kvm_host.h
> > +++ b/arch/mips/include/asm/kvm_host.h
> > @@ -896,7 +896,7 @@ static inline void kvm_arch_sched_in(struct kvm_vcp=
u *vcpu, int cpu) {}
> >  static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
> >  static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
> >
> > -#define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLB
> > -int kvm_arch_flush_remote_tlb(struct kvm *kvm);
> > +#define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS
> > +int kvm_arch_flush_remote_tlbs(struct kvm *kvm);
>
> How about making this prototype global? I don't see a point in having
> it per-architecture, specially as you are adding arm64 to that mix in
> the following patch.
>
We can make it global, but I'm not sure what was the intention of the
original author. My guess is that he was following the same style that
we have for some of the other kvm_arch_*() functions
(kvm_arch_free_vm() for example)?

- Raghavendra
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

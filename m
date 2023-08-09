Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32681776539
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHIQjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHIQjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:39:03 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B3B1986
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:39:02 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-407db3e9669so311651cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691599141; x=1692203941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAabttuUSlISLQ9kur95AJErnuBmKPlF1t5IPI4xLW8=;
        b=QK/Md6pLtQcnNYaG7FaNR8YGO5V1BDDGTN1QNcb5t4M8hyK/g2UzsOCkQFbfYrRiBB
         G0kclZmDhOUC4jPYSDgzil3jq7z68Wq4Y/XsBYF1MGe9Iir+sC7RphbJoMfImBbhq2T/
         pEhwFheHJqKkE6YRXMAxkXUnF8lSNA2TqIGy9iPTw7Y7ze+v2ZO6wVbfvsq9lZ13AZGe
         qcvfeTRsEBx541O+obhMMtIFxCFLknFX2bE3VoAPa0QB2Ao3Loe9vbjMaWTez52X0ZNb
         c1pWu8dZp76+bEISHoUz6Gcb1Dks1IYF1WyX0qZyE1sqGI1eUsOyDxlWzYy0GZ7RrbKU
         pVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691599141; x=1692203941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAabttuUSlISLQ9kur95AJErnuBmKPlF1t5IPI4xLW8=;
        b=SIJFTAqWe7qwD4slkn+ovO0OI6cWoAhwcjikBZWNb4RuQQMNpMum+ScoWv3D7IfNtc
         x3oh3Jsm9w/Sk66+IKrE4RxtrMVnN73WFmj+S07X3LvSn5Er0Ef2GqZm0mX8XE2MqJ+L
         0ssrN61SXp8KJfGJc/UhRdRM5vmdeKeR0zV0y22fZQv9zWtSvuFt0QPCZ46axXQWuSw3
         YIlazHjye4qoR1tDWtnnaHQF/0UZc33jx7SJBhloxwpj4piKSBjAY3kw+oXqi1O2cCnx
         usiMZzePlexZ2HawMhCv6jxTf82YjKsW2TZdg6rcF3wziAp9z4F2XBI7Cryg77a6tZP3
         5mEg==
X-Gm-Message-State: AOJu0YylE6x9Zi46KYMCfm1i6drBs3Gj2Ohl9xW2oe0IRwW87T7PIxNw
        Rmq+hvmr1BxIypx6csFpEKzsCe0Cf3qAa4j72Ocm8Q==
X-Google-Smtp-Source: AGHT+IFIKXrr2ilFq3pewZHyAMJbe1zJNw2R6kC9Ag8lwIUUWtSfseAhG7bbTMLUN+5Rf6sXibPKOvlrXvIKI8OeOqU=
X-Received: by 2002:a05:622a:206:b0:3ef:302c:319e with SMTP id
 b6-20020a05622a020600b003ef302c319emr161886qtx.8.1691599141628; Wed, 09 Aug
 2023 09:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230808231330.3855936-1-rananta@google.com> <20230808231330.3855936-3-rananta@google.com>
 <c33b0518-6e64-7acf-efa8-f404fce1ccac@redhat.com>
In-Reply-To: <c33b0518-6e64-7acf-efa8-f404fce1ccac@redhat.com>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Wed, 9 Aug 2023 09:38:49 -0700
Message-ID: <CAJHc60yCJANBQOizaoSPhEJH9e8a9C6n68x4qdVkOhVZiiWqkw@mail.gmail.com>
Subject: Re: [PATCH v8 02/14] KVM: Declare kvm_arch_flush_remote_tlbs() globally
To:     Gavin Shan <gshan@redhat.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
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
        Fuad Tabba <tabba@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On Tue, Aug 8, 2023 at 9:00=E2=80=AFPM Gavin Shan <gshan@redhat.com> wrote:
>
>
> On 8/9/23 09:13, Raghavendra Rao Ananta wrote:
> > There's no reason for the architectures to declare
> > kvm_arch_flush_remote_tlbs() in their own headers. Hence to
> > avoid this duplication, make the declaration global, leaving
> > the architectures to define only __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS
> > as needed.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >   arch/mips/include/asm/kvm_host.h | 1 -
> >   include/linux/kvm_host.h         | 2 ++
> >   2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/k=
vm_host.h
> > index 9b0ad8f3bf327..54a85f1d4f2c8 100644
> > --- a/arch/mips/include/asm/kvm_host.h
> > +++ b/arch/mips/include/asm/kvm_host.h
> > @@ -897,6 +897,5 @@ static inline void kvm_arch_vcpu_blocking(struct kv=
m_vcpu *vcpu) {}
> >   static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
> >
> >   #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS
> > -int kvm_arch_flush_remote_tlbs(struct kvm *kvm);
> >
> >   #endif /* __MIPS_KVM_HOST_H__ */
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index e3f968b38ae97..ade5d4500c2ce 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -1484,6 +1484,8 @@ static inline int kvm_arch_flush_remote_tlbs(stru=
ct kvm *kvm)
> >   {
> >       return -ENOTSUPP;
> >   }
> > +#else
> > +int kvm_arch_flush_remote_tlbs(struct kvm *kvm);
> >   #endif
> >
> >   #ifdef __KVM_HAVE_ARCH_NONCOHERENT_DMA
>
> Is the declaration inconsistent to that in arch/x86/include/asm/kvm_host.=
h?
> In order to keep them consistent, I guess we need move kvm_arch_flush_rem=
ote_tlbs()
> from x86's header file to arch/x86/kvm/mmu/mmu.c and 'inline' needs to be=
 dropped.
>
Unsure of the original intentions, I didn't want to disturb any
existing arrangements. If more people agree to this refactoring, I'm
happy to move.

Thank you.
Raghavendra
> Thanks,
> Gavin
>

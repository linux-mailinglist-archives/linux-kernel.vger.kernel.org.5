Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE916812182
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbjLMWby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbjLMWbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:31:52 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283AC106
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:31:56 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso1590a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702506714; x=1703111514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PgJaJWhApgF9FmIhLYdcKhchOF9hVT1X2VoAnpn0Ao=;
        b=3WyYytAHSD/eQrWR1CM3X7lfeJA3uh4lj3ZLT8vdGgj5uZo05UIwZZ3Ct2IJMvfQLI
         1LowL9UkjNCYdjtqWS1gvMlyTFKQ5UWxsNNhmmN0TRkJrAUJkv812PUk1+e/N3YyT0S6
         85Sk+y/MAdZPAqB4PnxBeKUjr3gLmbkuJgTsAdfncY9zbmOTXd7lSS2vHYEbXYXLGTqz
         EgnYnUUn6WMBsIZHojSEFjp7nFlmPxTur50Xl4Ll9huTCcRUZCdGrB6rG3072odabJDV
         qdCpKSkcrCAHH7kF29tctVkeoxvekpOx9RirkLNtj+PWeHAjmnHBE+ZmupWfEdNJnces
         cWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702506714; x=1703111514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PgJaJWhApgF9FmIhLYdcKhchOF9hVT1X2VoAnpn0Ao=;
        b=K8q6Ntw/ZG2Mg4x56Kr+az6mq/gLziCI0sIo9BGtfJaiMF9iCMgaqaPHGFf6VpZ5bh
         Bqa+5v+gIgsamHydKRB06qa1L+kZ0MfPir9dEi21JDVG4d4R+hDTDhxdAR15dGQ7lF4g
         /SUvFrTohQhMTOEsISY9l4PZHlZ0OX9mmvFcZLwuD++TzYa3UFep3/j22aVKD/15VvKk
         cSuEhncmIZzclzNT1Pdn0UlfVpdn2Kqa/8ZtALY4T96gRZ4FPb6VXpDjGonrBtJDzpxa
         E78c+kO/XamhKv2nL15BfchTpqcweM4EZhHDHKLUn+M0XWAVjuJ28qpE7xNgaX4leKCu
         6mxw==
X-Gm-Message-State: AOJu0YwhHZGRRL3fSHp1rQ9WwHEuPCWFzKGV9Ui24UCbT9SgQ3Qo8Yh6
        uPXFFoewlCQ2N85jKqvbpSqsqklTUq5J43ATZwP8nw==
X-Google-Smtp-Source: AGHT+IETGng/qZp64XWpPY6SM575xAjiFlUFwCCdv1u6UWr+/vXroByM0/GH9N8F8x7DGSWZmaydB5N9a7FN1v/1FZ8=
X-Received: by 2002:a05:6402:35c5:b0:551:9870:472 with SMTP id
 z5-20020a05640235c500b0055198700472mr314909edc.1.1702506714443; Wed, 13 Dec
 2023 14:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20220921003201.1441511-11-seanjc@google.com> <20231207010302.2240506-1-jmattson@google.com>
 <ZXHw7tykubfG04Um@google.com> <CALMp9eTT97oDmQT7pxeOMLQbt-371aMtC2Kev+-kWXVRDVrjeg@mail.gmail.com>
 <ZXh8Nq_y_szj1WN0@google.com> <5ca5592b21131f515e296afae006e5bb28b1fb87.camel@redhat.com>
In-Reply-To: <5ca5592b21131f515e296afae006e5bb28b1fb87.camel@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 13 Dec 2023 14:31:40 -0800
Message-ID: <CALMp9eQ69dGSix-9pJdEtEw9T1Mqz9E1eaf1-yGP9k4_nMZogw@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] KVM: x86: never write to memory from kvm_vcpu_check_block()
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>, alexandru.elisei@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        borntraeger@linux.ibm.com, chenhuacai@kernel.org, david@redhat.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, james.morse@arm.com,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, maz@kernel.org,
        oliver.upton@linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, pbonzini@redhat.com,
        suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 2:25=E2=80=AFPM Maxim Levitsky <mlevitsk@redhat.com=
> wrote:
>
> On Tue, 2023-12-12 at 07:28 -0800, Sean Christopherson wrote:
> > On Sun, Dec 10, 2023, Jim Mattson wrote:
> > > On Thu, Dec 7, 2023 at 8:21=E2=80=AFAM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > > > Doh.  We got the less obvious cases and missed the obvious one.
> > > >
> > > > Ugh, and we also missed a related mess in kvm_guest_apic_has_interr=
upt().  That
> > > > thing should really be folded into vmx_has_nested_events().
> > > >
> > > > Good gravy.  And vmx_interrupt_blocked() does the wrong thing becau=
se that
> > > > specifically checks if L1 interrupts are blocked.
> > > >
> > > > Compile tested only, and definitely needs to be chunked into multip=
le patches,
> > > > but I think something like this mess?
> > >
> > > The proposed patch does not fix the problem. In fact, it messes thing=
s
> > > up so much that I don't get any test results back.
> >
> > Drat.
> >
> > > Google has an internal K-U-T test that demonstrates the problem. I
> > > will post it soon.
> >
> > Received, I'll dig in soonish, though "soonish" might unfortunately mig=
ht mean
> > 2024.
> >
>
> Hi,
>
> So this is what I think:
>
>
> KVM does have kvm_guest_apic_has_interrupt() for this exact purpose,
> to check if nested APICv has a pending interrupt before halting.
>
>
> However the problem is bigger - with APICv we have in essence 2 pending i=
nterrupt
> bitmaps - the PIR and the IRR, and to know if the guest has a pending int=
errupt
> one has in theory to copy PIR to IRR, then see if the max is larger then =
the current PPR.
>
> Since we don't want to write to guest memory, and the IRR here resides in=
 the guest memory,
> I guess we have to do a 'dry-run' version of 'vmx_complete_nested_posted_=
interrupt' and call
> it from  kvm_guest_apic_has_interrupt().
>
> What do you think? I can prepare a patch for this.
>
> Can you share a reproducer or write a new one that can be shared?

See https://lore.kernel.org/kvm/20231211185552.3856862-1-jmattson@google.co=
m/.

> Best regards,
>         Maxim Levitsky
>

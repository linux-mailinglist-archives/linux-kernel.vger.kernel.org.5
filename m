Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3EE812235
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjLMW7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjLMW7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:59:13 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50039CF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:59:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbc68661060so5191428276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702508358; x=1703113158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+J5uhAeT04KXTELzQDOfFmLaVLnZ2vRpEsBsoOgLL4=;
        b=KfqFARilZk67aIMqxNzCzRfq/DqZxGxtsMpp6prFL06MxhzS4rmbbTrr45NGtdGuXx
         KGDWdDc5pUuYn4KLtlljQWjoyefiJ+ddfqQuBYsPI8iJsD84nclDLmF2M7jNwCDXWZx9
         oBgnaPFFWpVJ5b6NyJHDx6StNjYYfzDlP/WjURuo/sjTiO5kc68j/f+3k/UBpiDMhxAi
         r2yE5mkELOpmdYkZGb0OZ0RL7MbMuN0alb7bGZs52REVX6RUQZKuJ+yePas9LILeCKQM
         qV48pvLgllVHnX7o8YniHt4JydRf0XU7yJq97zg22VyJ/0tYr5ajGy0mRBUcvtURKr/B
         h7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702508358; x=1703113158;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P+J5uhAeT04KXTELzQDOfFmLaVLnZ2vRpEsBsoOgLL4=;
        b=JCxVZeAwdJEP9tVOJ5YJA9Ed9sEylhfE0EWY9vi6Aw1MbqT3xAZAvHJixZknpLjJmX
         RPA+7d+oLPgoG9IcDlKzoP7xK60yUolJ2iLgUQML2SCj3bnuOil1/HIKPLX4ht0OHYE3
         a4VZ54s2N9D8wJbJtEf287nbwhmn6natQN2mvVxfngv2DCZluyjS3att5F5uUMO68D2A
         ygIrn49zIzbKvANlMdCFtecGEX0L6ncm3kV5zzJRv7+jli7T+FfL0VGmzsEOVP0U5ygW
         xcDhVRoul5UtxThxbIukOaT3kkRje4rhO7BXwpOXHQXD5xN7ZOks6v+OJrQMmUyKBpZt
         HQFA==
X-Gm-Message-State: AOJu0Yyzk3hurjmRbGmzYTAr8jdTvsN73e0tOPR2BZNRvDVPRgI0fmnq
        vygZglYzBelJioeB/2oHcxCpVz+8u8Y=
X-Google-Smtp-Source: AGHT+IF/2tOKGAnp02CUAmcGGknds7jEyZkdjWAgG3ZJhjWlZQOPu75oZHl38j1efeikxZ9gYUCkkMb1/cI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:a28c:0:b0:dbc:d4c4:15d3 with SMTP id
 c12-20020a25a28c000000b00dbcd4c415d3mr27833ybi.5.1702508358541; Wed, 13 Dec
 2023 14:59:18 -0800 (PST)
Date:   Wed, 13 Dec 2023 14:59:16 -0800
In-Reply-To: <5ca5592b21131f515e296afae006e5bb28b1fb87.camel@redhat.com>
Mime-Version: 1.0
References: <20220921003201.1441511-11-seanjc@google.com> <20231207010302.2240506-1-jmattson@google.com>
 <ZXHw7tykubfG04Um@google.com> <CALMp9eTT97oDmQT7pxeOMLQbt-371aMtC2Kev+-kWXVRDVrjeg@mail.gmail.com>
 <ZXh8Nq_y_szj1WN0@google.com> <5ca5592b21131f515e296afae006e5bb28b1fb87.camel@redhat.com>
Message-ID: <ZXo3REB8g-ZecT2U@google.com>
Subject: Re: [PATCH v4 10/12] KVM: x86: never write to memory from kvm_vcpu_check_block()
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>, alexandru.elisei@arm.com,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023, Maxim Levitsky wrote:
> On Tue, 2023-12-12 at 07:28 -0800, Sean Christopherson wrote:
> > On Sun, Dec 10, 2023, Jim Mattson wrote:
> > > On Thu, Dec 7, 2023 at 8:21=E2=80=AFAM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > > > Doh.  We got the less obvious cases and missed the obvious one.
> > > >=20
> > > > Ugh, and we also missed a related mess in kvm_guest_apic_has_interr=
upt().  That
> > > > thing should really be folded into vmx_has_nested_events().
> > > >=20
> > > > Good gravy.  And vmx_interrupt_blocked() does the wrong thing becau=
se that
> > > > specifically checks if L1 interrupts are blocked.
> > > >=20
> > > > Compile tested only, and definitely needs to be chunked into multip=
le patches,
> > > > but I think something like this mess?
> > >=20
> > > The proposed patch does not fix the problem. In fact, it messes thing=
s
> > > up so much that I don't get any test results back.
> >=20
> > Drat.
> >=20
> > > Google has an internal K-U-T test that demonstrates the problem. I
> > > will post it soon.
> >=20
> > Received, I'll dig in soonish, though "soonish" might unfortunately mig=
ht mean
> > 2024.
> >=20
>=20
> Hi,
>=20
> So this is what I think:
>=20
> KVM does have kvm_guest_apic_has_interrupt() for this exact purpose,
> to check if nested APICv has a pending interrupt before halting.

For all intents and purposes, so was nested_ops->has_events().  I don't see
any reason to have two APIs that do the same thing, and the call to
kvm_guest_apic_has_interrupt() is wrong in that it doesn't verify that IRQs=
 are
enabled for _L2_.  That's why my preference is to fold the two together.

> However the problem is bigger - with APICv we have in essence 2 pending
> interrupt bitmaps - the PIR and the IRR, and to know if the guest has a
> pending interrupt one has in theory to copy PIR to IRR, then see if the m=
ax
> is larger then the current PPR.

Yeah, this is what my untested hack-a-patch tried to do.

> Since we don't want to write to guest memory,

The changelog is misleading/wrong.  Writing guest memory is ok, what isn't =
safe
is blocking or sleeping, i.e. KVM must not trigger a host page fault due to
accessing a page that's been swapped out.  Read vs. write doesn't matter.

So KVM can safely read and write guest memory so long as it already mapped =
by=20
kvm_vcpu_map() (or I suppose if we wrapped an access with pagefault_disable=
(),
but I can't think of a sane reason to do that).  E.g. nVMX can access a vCP=
U's
PID mapping, but synthesizing a nested VM-Exit will cause explosions on nSV=
M.

> and the IRR here resides in the guest memory, I guess we have to do a
> 'dry-run' version of 'vmx_complete_nested_posted_interrupt' and call it f=
rom
> kvm_guest_apic_has_interrupt().

nested_ops->has_events() is the much better fit, e.g. the naming won't get =
weird
and we can gate the whole thing on is_guest_mode().  Though we probably nee=
d a
wrapper to handle any commonalities between nVMX and nSVM.

> What do you think? I can prepare a patch for this.

As above, this is what I tried to do, sort of.  Though it's obviously broke=
n.  We
don't need a full dry-run because KVM only needs to detect events that are =
unique
to L2, e.g. nVMX's preemption timer, MTF, and pending virtual interrupts (h=
mm,
I suspect nSVM's vNMI is broken too).  Things like INIT and SMI don't requi=
re
nested virtualization awareness because the event itself is tracked for the=
 vCPU
as a whole.

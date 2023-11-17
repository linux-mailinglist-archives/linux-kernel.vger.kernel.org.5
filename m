Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB32E7EEDE6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjKQIyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjKQIyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:54:12 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ED5D51;
        Fri, 17 Nov 2023 00:54:09 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-280165bba25so1319404a91.2;
        Fri, 17 Nov 2023 00:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700211248; x=1700816048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UF2GAnyVb2bdtM3mXaiFNf7QFP+qY3dG9x8rXOX7WLo=;
        b=QfNu2exY1GrzZgzB+m4ecbYpx7cs/r0la3Q6+AkFScPpMkfZAEU6oS5Q2+bluIY6Lz
         1TCNdL24Nrx4JGyHzV/VGKxHCqjzaXis/slZW+4Xp27GUpZhndJnZ9w0n1syTNP+Sq26
         LRwzO8YrxJr/hXkCiHDvWahYXEl3VybbUb45jwx4W7uhrWOBFSkFn9/Fy0mPpIIv+Dzh
         77JXi3Llb/gYm5M7fnJ7Eiz0rYUUVW56N4zad5RTmUdvgGbZypW3WhusOEfoN/FRmzb7
         EdYUiaDDxUXkCD3TBgRwRocuGrmp3ckgTI+J7sDTk/Ia/kU82maiWa4Eg6TOzC4u1krP
         a9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700211248; x=1700816048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UF2GAnyVb2bdtM3mXaiFNf7QFP+qY3dG9x8rXOX7WLo=;
        b=oN6zR+cPj//OYEetNQHw32XM/+Qn+tfBj+xGk3iBVKIylgpPv3npVW9ZZQVwSg/a6H
         1B+9vMxd1IKOSSjuHviW2ftbYMRKDnKddSqFD8pncl0W86nZWbp3R9YucMJjkftCIZ8h
         NxWDowfzZ4xTQvgtzATaHDddzZvlq1knR+K0HMwEqWtaxojRlDozeePvbAGRLKqdyaTZ
         ByLR2sFspoSwibcg2Bws5sOZS+QeIoUUAi1LsP5IwHs2nB/TxsT+W9xQLCcUMRYcE6Vu
         npN8bpU45TzytBZzaXJIenDRIIt8Ozszdl+wEDnm/PQOcVxQ/R0FP8Dy82kZ0fDfFXXt
         dP7g==
X-Gm-Message-State: AOJu0YzW7yEDX8fN3cwN5yt9SfiPfNGRucPHDk5qHvghaHDSL04iAa1w
        nSg5cVWMFzlbHLGbRpNoxL02D2gIQT1O/SqTgF0=
X-Google-Smtp-Source: AGHT+IF7oXkS/1RB+oLTBCLHSizeyncxttXI9b7oF67DA/iSBopB2bKhtbUgy8F2r2t9mc3eOz0L34w3tWUnfjLUCkU=
X-Received: by 2002:a17:90b:4c49:b0:280:5e8:58b1 with SMTP id
 np9-20020a17090b4c4900b0028005e858b1mr18638268pjb.33.1700211248361; Fri, 17
 Nov 2023 00:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20231107202002.667900-1-aghulati@google.com>
In-Reply-To: <20231107202002.667900-1-aghulati@google.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 17 Nov 2023 16:53:55 +0800
Message-ID: <CAJhGHyBtis3SkNZP8RSX5nKFcnQ4qvUrfTMD2RPc+w+Rzf30Zw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] Support multiple KVM modules on the same host
To:     Anish Ghulati <aghulati@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        peterz@infradead.org, paulmck@kernel.org,
        Mark Rutland <mark.rutland@arm.com>
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

On Wed, Nov 8, 2023 at 4:20=E2=80=AFAM Anish Ghulati <aghulati@google.com> =
wrote:
>
> This series is a rough, PoC-quality RFC to allow (un)loading and running
> multiple KVM modules simultaneously on a single host, e.g. to deploy
> fixes, mitigations, and/or new features without having to drain all VMs
> from the host. Multi-KVM will also allow running the "same" KVM module
> with different params, e.g. to run trusted VMs with different mitigations=
.
>
> The goal of this RFC is to get feedback on the idea itself and the
> high-level approach.  In particular, we're looking for input on:
>
>  - Combining kvm_intel.ko and kvm_amd.ko into kvm.ko
>  - Exposing multiple /dev/kvmX devices via Kconfig
>  - The name and prefix of the new base module
>
> Feedback on individual patches is also welcome, but please keep in mind
> that this is very much a work in-progress

Hello Anish

Scarce effort on multi-KVM can be seen in the mail list albeit many
companies enable multi-KVM internally.

I'm glad that you took a big step in upstreaming it.  And I hope it
can be materialized soon.


>
>  - Move system-wide virtualization resource management to a new base
>    module to avoid collisions between different KVM modules, e.g. VPIDs
>    and ASIDs need to be unique per VM, and callbacks from IRQ handlers ne=
ed
>    to be mediated so that things like PMIs get to the right KVM instance.

perf_register_guest_info_callbacks() also accesses to system-wide resources=
,
but I don't see its relating code including kvm_guest_cbs being moved to AV=
C.

>
>  - Refactor KVM to make all upgradable assets visible only to KVM, i.e.
>    make KVM a black box, so that the layout/size of things like "struct
>    kvm_vcpu" isn't exposed to the kernel at-large.
>
>  - Fold kvm_intel.ko and kvm_amd.ko into kvm.ko to avoid complications
>    having to generate unique symbols for every symbol exported by kvm.ko.

The sizes of kvm_intel.ko and kvm_amd.ko are big, and there
is only 1G in the kernel available for modules. So I don't think folding
two vendors' code into kvm.ko is a good idea.

Since the symbols in the new module are invisible outside, I recommend:
new kvm_intel.ko =3D kvm_intel.ko + kvm.ko
new kvm_amd.ko =3D kvm_amd.ko + kvm.ko

>
>  - Add a Kconfig string to allow defining a device and module postfix at
>    build time, e.g. to create kvmX.ko and /dev/kvmX.
>
> The proposed name of the new base module is vac.ko, a.k.a.
> Virtualization Acceleration Code (Unupgradable Units Module). Childish
> humor aside, "vac" is a unique name in the kernel and hopefully in x86
> and hardware terminology, is a unique name in the kernel and hopefully
> in x86 and hardware terminology, e.g. `git grep vac_` yields no hits in
> the kernel. It also has the same number of characters as "kvm", e.g.
> the namespace can be modified without needing whitespace adjustment if
> we want to go that route.

How about the name kvm_base.ko?

And the variable/function name in it can still be kvm_foo (other than
kvm_base_foo).

Thanks
Lai

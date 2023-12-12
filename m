Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDFE80F0D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377163AbjLLP3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbjLLP33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:29:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB9E1FC9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:28:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcc6933a14so152842276.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702394936; x=1702999736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESTPXNxaOVzfRXXRx0Fvol8yzry2uxBEEuLKqef2q4U=;
        b=BkYDT2p7AZjoPKT1n33qcBzraBObsSid1Kav0bwVkxm03TEVNC9zjkvdoIvsP0gO75
         moN91EoItYKY7bE8DYrJiANZQGFCmkf5HIebed+p+oequNpXhL+YOR4EpL4dpgIKSQ5Q
         rdxafRPM1EMvN39DPwz196VoqroHUedjHpsNgY60Ny4L70huLqKg9p0/ZqM3NMyNGdm6
         B2u/IQXRbgTONYPciifuv1nD9dRK0KUIoy1No1oaQwluBNg6Ll9BXgX2qVuEIV52N94P
         uqorvgEZE7Y9ffnxMRIbnnF1PGv2zPAMLd+YB1lWZuWINHkNV+Y+C0LRq892mFgzBrA5
         /IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394936; x=1702999736;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ESTPXNxaOVzfRXXRx0Fvol8yzry2uxBEEuLKqef2q4U=;
        b=V9vWkzERuupIFVGC7NcvVTEDqPuZZ1T9giEuiDg9bj6a7rakvfzqYVep4Enq97oSdv
         K5LYPW4cl5hNa+HzgM2Tv++YuOuItpERxC3dVL1J1teMEkFZxYmOVKiz6g4dWerKfNaC
         s+o+LLsH2MHn4L9vsSr1yz7tvSwhJtKX1fZF/VoasHl7mcO8tItDy5ZVHKHM4JGs7cyB
         qa4SdT/5FSci5J3rs3lszsqQeE8CyguveqsmHc/6NyYx735L6BqRwuQdBmGJhgXYikkd
         VMc3Y0EbX6kfVf1A40/HEQPQV1QzDdV3VvQoL0JDe9aAQJX4RLQJXlJXUPYCizVgMee8
         Lxeg==
X-Gm-Message-State: AOJu0Yxt6KPSmuKAk9+bMVuiota0LEp/KIgmUOkFDDnV+b6CYyX7v7ku
        9YO2maAxofd5XkayXxD3JCjn++jE7SQ=
X-Google-Smtp-Source: AGHT+IHBX6jt6VDhWuABWGol0Nx+Ii84S8r8nT9g/gNamSIHnZwQhzhs+bFmpCR2BuKO/hKALNdpvESE74w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:db94:0:b0:db4:7ac:fea6 with SMTP id
 g142-20020a25db94000000b00db407acfea6mr41805ybf.7.1702394935890; Tue, 12 Dec
 2023 07:28:55 -0800 (PST)
Date:   Tue, 12 Dec 2023 07:28:54 -0800
In-Reply-To: <CALMp9eTT97oDmQT7pxeOMLQbt-371aMtC2Kev+-kWXVRDVrjeg@mail.gmail.com>
Mime-Version: 1.0
References: <20220921003201.1441511-11-seanjc@google.com> <20231207010302.2240506-1-jmattson@google.com>
 <ZXHw7tykubfG04Um@google.com> <CALMp9eTT97oDmQT7pxeOMLQbt-371aMtC2Kev+-kWXVRDVrjeg@mail.gmail.com>
Message-ID: <ZXh8Nq_y_szj1WN0@google.com>
Subject: Re: [PATCH v4 10/12] KVM: x86: never write to memory from kvm_vcpu_check_block()
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     alexandru.elisei@arm.com, anup@brainfault.org,
        aou@eecs.berkeley.edu, atishp@atishpatra.org,
        borntraeger@linux.ibm.com, chenhuacai@kernel.org, david@redhat.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, james.morse@arm.com,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mlevitsk@redhat.com,
        oliver.upton@linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, pbonzini@redhat.com,
        suzuki.poulose@arm.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023, Jim Mattson wrote:
> On Thu, Dec 7, 2023 at 8:21=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> > Doh.  We got the less obvious cases and missed the obvious one.
> >
> > Ugh, and we also missed a related mess in kvm_guest_apic_has_interrupt(=
).  That
> > thing should really be folded into vmx_has_nested_events().
> >
> > Good gravy.  And vmx_interrupt_blocked() does the wrong thing because t=
hat
> > specifically checks if L1 interrupts are blocked.
> >
> > Compile tested only, and definitely needs to be chunked into multiple p=
atches,
> > but I think something like this mess?
>=20
> The proposed patch does not fix the problem. In fact, it messes things
> up so much that I don't get any test results back.

Drat.

> Google has an internal K-U-T test that demonstrates the problem. I
> will post it soon.

Received, I'll dig in soonish, though "soonish" might unfortunately might m=
ean
2024.

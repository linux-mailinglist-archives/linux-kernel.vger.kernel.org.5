Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6877CC990
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343900AbjJQRLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343863AbjJQRLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:11:09 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFB8F5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:11:08 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9c145bb5bso7845ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697562668; x=1698167468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYRiu9lSScYzjuPNTRfPjUaha4Cty0VP8HNHJXHNDls=;
        b=fHww+4mvszkXGZWotRCgYzNFytJzmMs6Vw5TBL7j+Zat4huTQMM3qF5lXAXxwT/sdt
         LPYt0DQDn7Je9yDOXGgVbUldCgwdOb2Hv2xxG8nQpZIuxpvkL4BzUjJN5gf1yQ9Rcp96
         HPvYVoDjuC73kLT94+vj5tl7/ZPoahf/j5R2gl/S1X7B73VhRyy/ZiofS/J5m0PGDNb4
         nUcrUAXoaxDXFQsHgsp4cITEuChi+YLXi4Po4sQS99bT3VuSK+e/Uejkk7yQV7GgPqlo
         z0ap8NeNcwoLjN573G4hPxTatQEB/QRzrvUcXpNWcbNkaH7qu5ExpCaTZwG0n4R2f9Gk
         ynNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697562668; x=1698167468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYRiu9lSScYzjuPNTRfPjUaha4Cty0VP8HNHJXHNDls=;
        b=bQnZ0ABJqSZciU1NwZr09Vtykjk7Fi9GOOUYjTyGhW6pIkIRPRWaJiI0yIDsw7Nne5
         Pohx+p2C35WgBUF2+md8UNSKWro7mpkFy00rdD/xotQaJCIXYuDIOi0UHvYfLPqO5LkE
         Laxgf9QS0Vri9Q5A6XiXCNULqIk4Azy20T75izBCA8YhngDKv2R/BnZ0XQNmsmBUs06X
         43TyQSqI+171gU0vhvvvXuk5n0YkBB8DaxhuMEGXFaGFJhtX/nudZ4YQNj3oGVmMJpX5
         8QCNiSNJZv04tId+Xlt254wiYPJqsbN+xhx6X1mM34SQpSNee3RAYbLfZhyj/DK6nth7
         sG1A==
X-Gm-Message-State: AOJu0YzkZUR3Y2jZtPVi5kVeHbizs3ZOIciZg/vmCG/TJWKNVWrm5XVC
        fYLbEhRgidAHlFiMRxZRDaWHhCogKmkrQnqPeZFZ6w==
X-Google-Smtp-Source: AGHT+IFRYWvFaJ0WInRTJyr+F9zMf0+RQKXl4mnaUaW2eO670fDT8aRdRXn0jZoCF3qiP5KSAr97AZqkZIqNS1w8Bx0=
X-Received: by 2002:a17:902:6b47:b0:1c9:d7d8:862c with SMTP id
 g7-20020a1709026b4700b001c9d7d8862cmr17098plt.10.1697562667428; Tue, 17 Oct
 2023 10:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231009230858.3444834-1-rananta@google.com> <20231009230858.3444834-11-rananta@google.com>
 <e0fdb0ea-2f08-6343-1765-afe32510f3a7@redhat.com>
In-Reply-To: <e0fdb0ea-2f08-6343-1765-afe32510f3a7@redhat.com>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Tue, 17 Oct 2023 10:10:55 -0700
Message-ID: <CAJHc60wQuCM_H_ksSWUdCjJj30Stzn1aEr4=jvzqM0ZvhuN5gQ@mail.gmail.com>
Subject: Re: [PATCH v7 10/12] KVM: selftests: aarch64: Introduce
 vpmu_counter_access test
To:     Sebastian Ott <sebott@redhat.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shaoqin Huang <shahuang@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 8:48=E2=80=AFAM Sebastian Ott <sebott@redhat.com> w=
rote:
>
> On Mon, 9 Oct 2023, Raghavendra Rao Ananta wrote:
> > +static void guest_code(uint64_t expected_pmcr_n)
> > +{
> > +     uint64_t pmcr, pmcr_n;
> > +
> > +     __GUEST_ASSERT(expected_pmcr_n <=3D ARMV8_PMU_MAX_GENERAL_COUNTER=
S,
> > +                     "Expected PMCR.N: 0x%lx; ARMv8 general counters: =
0x%lx",
> > +                     expected_pmcr_n, ARMV8_PMU_MAX_GENERAL_COUNTERS);
> > +
> > +     pmcr =3D read_sysreg(pmcr_el0);
> > +     pmcr_n =3D get_pmcr_n(pmcr);
> > +
> > +     /* Make sure that PMCR_EL0.N indicates the value userspace set */
> > +     __GUEST_ASSERT(pmcr_n =3D=3D expected_pmcr_n,
> > +                     "Expected PMCR.N: 0x%lx, PMCR.N: 0x%lx",
> > +                     pmcr_n, expected_pmcr_n);
>
> Expected vs read value is swapped.
>
Good catch! I'll fix this in v8.
>
> Also, since the kernel has special handling for this, should we add a
> test like below?
>
> +static void immutable_test(void)
> +{
> +       struct kvm_vcpu *vcpu;
> +       uint64_t sp, pmcr, pmcr_n;
> +       struct kvm_vcpu_init init;
> +
> +       create_vpmu_vm(guest_code);
> +
> +       vcpu =3D vpmu_vm.vcpu;
> +
> +       /* Save the initial sp to restore them later to run the guest aga=
in */
> +       vcpu_get_reg(vcpu, ARM64_CORE_REG(sp_el1), &sp);
> +
> +       vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_PMCR_EL0), &pmcr);
> +       pmcr_n =3D get_pmcr_n(pmcr);
> +
> +       run_vcpu(vcpu, pmcr_n);
> +
> +       vm_ioctl(vpmu_vm.vm, KVM_ARM_PREFERRED_TARGET, &init);
> +       init.features[0] |=3D (1 << KVM_ARM_VCPU_PMU_V3);
> +       aarch64_vcpu_setup(vcpu, &init);
> +       vcpu_init_descriptor_tables(vcpu);
> +       vcpu_set_reg(vcpu, ARM64_CORE_REG(sp_el1), sp);
> +       vcpu_set_reg(vcpu, ARM64_CORE_REG(regs.pc), (uint64_t)guest_code)=
;
> +
> +       /* Update the PMCR_EL0.N after the VM ran once */
> +       set_pmcr_n(&pmcr, 0);
> +       vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_PMCR_EL0), pmcr);
> +
> +       /* Verify that the guest still gets the unmodified value */
> +       run_vcpu(vcpu, pmcr_n);
> +
> +       destroy_vpmu_vm();
> +}
Thanks for the suggestion! I'll add this test case in v8.

- Raghavendra
>

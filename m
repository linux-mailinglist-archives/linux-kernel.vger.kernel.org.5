Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFEB7D0200
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346334AbjJSSqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345159AbjJSSqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:46:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDFB132
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:46:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9d4f08d7cso29395ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697741194; x=1698345994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzimnIJUhNRzR0e86eiXvX1SAfFmJjvPI0besOVrjYo=;
        b=lXHF26vKzY6ND8mWoXtTkOW/kYp6wywLpKH9Uk1k+g0qxs5rMwhdvM2Pr+cvRiQN+i
         YZQ2JiBZYYPYrKFc7NRlUBQscQCpTXb7PGpnTN1fRLAzHtcaSqvQmHj54qlaNjPNkrYd
         cbhZL5n/Y9H75GgMckJWTJ5AEn0kwl9m0nhM+XrueYQH/hhy4TWCf1lVmWyAd14kXQZ9
         dH+dvGUe97TTDviiccqSa1zzzqVoTIbr2OSGwZcc5zJvtHFUNL4TrM9A9lqtmSQB0G6E
         gBVyrfcFTsyq7Ie3UTQUTmTAoKurQvIl75Q3i3e47EEwCyV/9Vv7TENDGjWW1IZw0LP7
         itBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697741194; x=1698345994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzimnIJUhNRzR0e86eiXvX1SAfFmJjvPI0besOVrjYo=;
        b=q/mInSb9LOMSY2jV9X1GaoKUTi+PnDE6wCD3p0nGG2Kbc8oQbO4yEvlc87dfwgsZYu
         dEabI6KNSh37C5rnZqQHcjWkqB+y5QZuRlHg+F/4pbQhum487qxqW1GVq53ruCariWP8
         KV65Bj4Hz/JIl7KTW+wZKq7B1XRhFCeCPSeB/oFw02GLgWLEfdoqIdqrzk68hvU63Ek8
         E4a+VuEZcWa5r7W+gTNclUFLvUkwp93ye4JAoFw7D92LVzP38jFw//DNSDCyMSomEegt
         n7IBW9a2RqMc5UlOu9YsnKI87oibEc27PnaYNo2GV+z4QxUrynFqKGFRK8C6vOa2UbHa
         iw5w==
X-Gm-Message-State: AOJu0Yws1YApe3hXDVbl9+gHv6irBDOhAbtJzByAEc+PeEhZAtrtjVPU
        ebTt5sevHt//qWJubKSELmDNkOQM1giX0OCcsmj8Sg==
X-Google-Smtp-Source: AGHT+IF1iIay7XDfRI6yuu68OTiD12ElouK9S/gc49Gt7kiPNlPT/ubhARUr5Bk9HL7fy+yrOmMZHHH7f+G2DJBfj4s=
X-Received: by 2002:a17:902:e949:b0:1c1:efe5:ccf8 with SMTP id
 b9-20020a170902e94900b001c1efe5ccf8mr21921pll.17.1697741194099; Thu, 19 Oct
 2023 11:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231009230858.3444834-1-rananta@google.com> <20231009230858.3444834-4-rananta@google.com>
 <53546f35-f2cc-4c75-171c-26719550f7df@redhat.com> <CAJHc60wYyfsJPiFEyLYLyv9femNzDUXy+xFaGx59=2HrUGScyw@mail.gmail.com>
 <34959db4-01e9-8c1e-110e-c52701e2fb19@redhat.com> <CAJHc60xc1dM_d4W+hOOnM5+DceF45htTfrbmdv=Q4vPf8T04Ow@mail.gmail.com>
 <CAJHc60yr5U+sxSAaZipei_4TNaU0_EAWKLG8cr+5v_Z1WYRMuw@mail.gmail.com>
In-Reply-To: <CAJHc60yr5U+sxSAaZipei_4TNaU0_EAWKLG8cr+5v_Z1WYRMuw@mail.gmail.com>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Thu, 19 Oct 2023 11:46:22 -0700
Message-ID: <CAJHc60yQSzsuTJLcyzs5vffgRzR5i0vKQwLnhavAon6hoSkb+A@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] KVM: arm64: PMU: Clear PM{C,I}NTEN{SET,CLR} and
 PMOVS{SET,CLR} on vCPU reset
To:     Eric Auger <eauger@redhat.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 2:16=E2=80=AFPM Raghavendra Rao Ananta
<rananta@google.com> wrote:
>
> On Tue, Oct 17, 2023 at 9:59=E2=80=AFAM Raghavendra Rao Ananta
> <rananta@google.com> wrote:
> >
> > Hi Eric,
> > On Tue, Oct 17, 2023 at 2:23=E2=80=AFAM Eric Auger <eauger@redhat.com> =
wrote:
> > >
> > > Hi,
> > > On 10/16/23 23:28, Raghavendra Rao Ananta wrote:
> > > > On Mon, Oct 16, 2023 at 12:45=E2=80=AFPM Eric Auger <eauger@redhat.=
com> wrote:
> > > >>
> > > >> Hi Raghavendra,
> > > >>
> > > >> On 10/10/23 01:08, Raghavendra Rao Ananta wrote:
> > > >>> From: Reiji Watanabe <reijiw@google.com>
> > > >>>
> > > >>> On vCPU reset, PMCNTEN{SET,CLR}_EL0, PMINTEN{SET,CLR}_EL1, and
> > > >>> PMOVS{SET,CLR}_EL1 for a vCPU are reset by reset_pmu_reg().
> > > >> PMOVS{SET,CLR}_EL0?
> > > > Ah, yes. It should be PMOVS{SET,CLR}_EL0.
> > > >
> > > >>> This function clears RAZ bits of those registers corresponding
> > > >>> to unimplemented event counters on the vCPU, and sets bits
> > > >>> corresponding to implemented event counters to a predefined
> > > >>> pseudo UNKNOWN value (some bits are set to 1).
> > > >>>
> > > >>> The function identifies (un)implemented event counters on the
> > > >>> vCPU based on the PMCR_EL0.N value on the host. Using the host
> > > >>> value for this would be problematic when KVM supports letting
> > > >>> userspace set PMCR_EL0.N to a value different from the host value
> > > >>> (some of the RAZ bits of those registers could end up being set t=
o 1).
> > > >>>
> > > >>> Fix this by clearing the registers so that it can ensure
> > > >>> that all the RAZ bits are cleared even when the PMCR_EL0.N value
> > > >>> for the vCPU is different from the host value. Use reset_val() to
> > > >>> do this instead of fixing reset_pmu_reg(), and remove
> > > >>> reset_pmu_reg(), as it is no longer used.
> > > >> do you intend to restore the 'unknown' behavior at some point?
> > > >>
> > > > I believe Reiji's (original author) intention was to keep them
> > > > cleared, which would still imply an 'unknown' behavior. Do you thin=
k
> > > > there's an issue with this?
> > > Then why do we bother using reset_unknown in the other places if
> > > clearing the bits is enough here?
> > >
> > Hmm. Good point. I can bring back reset_unknown to keep the original be=
havior.
> >
> I had a brief discussion about this with Oliver, and it looks like we
> might need a couple of additional changes for these register accesses:
> - For the userspace accesses, we have to implement explicit get_user
> and set_user callbacks that to filter out the unimplemented counters
> using kvm_pmu_valid_counter_mask().
Re-thinking the first case: Since these registers go through a reset
(reset_pmu_reg()) during initialization, where the valid counter mask
is applied, and since we are sanitizing the registers with the mask
before running the guest (below case), will implementing the
{get,set}_user() add any value, apart from just keeping userspace in
sync with every update of PMCR.N?
> - For the guest accesses to be correct, we might have to apply the
> same mask while serving KVM_REQ_RELOAD_PMU.
>
> Thank you.
> Raghavendra
>
> > Thank you.
> > Raghavendra
> > > Thanks
> > >
> > > Eric
> > > >
> > > > Thank you.
> > > > Raghavendra
> > > >> Thanks
> > > >>
> > > >> Eric
> > > >>>
> > > >>> Signed-off-by: Reiji Watanabe <reijiw@google.com>
> > > >>> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > > >>> ---
> > > >>>  arch/arm64/kvm/sys_regs.c | 21 +--------------------
> > > >>>  1 file changed, 1 insertion(+), 20 deletions(-)
> > > >>>
> > > >>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.=
c
> > > >>> index 818a52e257ed..3dbb7d276b0e 100644
> > > >>> --- a/arch/arm64/kvm/sys_regs.c
> > > >>> +++ b/arch/arm64/kvm/sys_regs.c
> > > >>> @@ -717,25 +717,6 @@ static unsigned int pmu_visibility(const str=
uct kvm_vcpu *vcpu,
> > > >>>       return REG_HIDDEN;
> > > >>>  }
> > > >>>
> > > >>> -static u64 reset_pmu_reg(struct kvm_vcpu *vcpu, const struct sys=
_reg_desc *r)
> > > >>> -{
> > > >>> -     u64 n, mask =3D BIT(ARMV8_PMU_CYCLE_IDX);
> > > >>> -
> > > >>> -     /* No PMU available, any PMU reg may UNDEF... */
> > > >>> -     if (!kvm_arm_support_pmu_v3())
> > > >>> -             return 0;
> > > >>> -
> > > >>> -     n =3D read_sysreg(pmcr_el0) >> ARMV8_PMU_PMCR_N_SHIFT;
> > > >>> -     n &=3D ARMV8_PMU_PMCR_N_MASK;
> > > >>> -     if (n)
> > > >>> -             mask |=3D GENMASK(n - 1, 0);
> > > >>> -
> > > >>> -     reset_unknown(vcpu, r);
> > > >>> -     __vcpu_sys_reg(vcpu, r->reg) &=3D mask;
> > > >>> -
> > > >>> -     return __vcpu_sys_reg(vcpu, r->reg);
> > > >>> -}
> > > >>> -
> > > >>>  static u64 reset_pmevcntr(struct kvm_vcpu *vcpu, const struct sy=
s_reg_desc *r)
> > > >>>  {
> > > >>>       reset_unknown(vcpu, r);
> > > >>> @@ -1115,7 +1096,7 @@ static bool access_pmuserenr(struct kvm_vcp=
u *vcpu, struct sys_reg_params *p,
> > > >>>         trap_wcr, reset_wcr, 0, 0,  get_wcr, set_wcr }
> > > >>>
> > > >>>  #define PMU_SYS_REG(name)                                       =
     \
> > > >>> -     SYS_DESC(SYS_##name), .reset =3D reset_pmu_reg,            =
       \
> > > >>> +     SYS_DESC(SYS_##name), .reset =3D reset_val,                =
       \
> > > >>>       .visibility =3D pmu_visibility
> > > >>>
> > > >>>  /* Macro to expand the PMEVCNTRn_EL0 register */
> > > >>
> > > >
> > >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371457D3E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjJWRm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjJWRm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:42:57 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD43498
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:42:55 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3575826ba20so6375ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698082975; x=1698687775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBXLA8TPJ+R5jc8eUaCSA4IRG8aS6kWKghdqJo/ZP+w=;
        b=MyBRMZ8aL+M1xm4sQaq725/OwJxZs39kxOTDUvj1YHFwwe7m3DWwe6I5qDY7W8zQaG
         u4Oo+3wKV7EDYXG9Oq8wHp9zvzmZCbVEKydwUAHUm5jH703anK6brH8iP1ewLFrVS4my
         hCnfR6Jb13fp6Tu2LaDDE3lcSN9TMHZ4/vtSRV+cOZMBXBtoQ2qdoRbjEkLSxQ8sW14P
         0Y4JVHYVW0vPKopQzhvJWw8M0lxKYJGvrVEAJcPu4ixonBaNs7ayKVh/mDQj8oLeq2Ob
         LHO3AR0m/FTCAzAWy8wAoOkI1fqJtgEya+A74JhlcYuxIL4ezNQGH8A3vpg/05rv2rdc
         6Nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082975; x=1698687775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBXLA8TPJ+R5jc8eUaCSA4IRG8aS6kWKghdqJo/ZP+w=;
        b=p4eq74MwXJi+ucHYorJKdOfGfuceTbozJ9TIUxdmdxLiahw6iXw1S4j5a8sF8kPJmT
         o4KAAQJ0MMEchuFzM+MbQdZGZTXs9FaRzqoS57/buVUZ11TYsnXRpFNPVZiYB5XZ5YHI
         yy4uEPn+xLBVDxvv26tu1RX1pGHqXdMOyNILt9Dt6Va+CWfMWMutvmCYOxZgdLOkSzKv
         phiQT2b14zGyI6UXYCp4CTlfC5wX98dsf9SNmPtpmmIvCHBWP/q7jBHdzSSYRAnwEsov
         WNMnzcWR78Hgxb5k21a7FFz9I6v3pSiA8O4tSBXGlS5SRdtP4PjEN3v0qwzd/BrPBaKc
         t9vw==
X-Gm-Message-State: AOJu0Yw1BNRs4Ld8yjX0GFs2wyLixjgxKnvD3eEzr1JmZ9qeTZauZKCt
        keGFNTcUgxdUAyHNZseMLJkEL8r79FcamsqZqUnT0A==
X-Google-Smtp-Source: AGHT+IFOLMLfZ/CbMtl3aYr9wCDJJ/AkWXKomQ1ThhlnhF2P9M/9E+1cO1Nj9S7F060LZgwP9Ug5HzsRJ/45KmsTmjY=
X-Received: by 2002:a05:6e02:1d0a:b0:357:ca4f:a275 with SMTP id
 i10-20020a056e021d0a00b00357ca4fa275mr13270ila.29.1698082975047; Mon, 23 Oct
 2023 10:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231020214053.2144305-1-rananta@google.com> <20231020214053.2144305-7-rananta@google.com>
 <86y1ft4ijm.wl-maz@kernel.org>
In-Reply-To: <86y1ft4ijm.wl-maz@kernel.org>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Mon, 23 Oct 2023 10:42:43 -0700
Message-ID: <CAJHc60xijk_QpxK-eDzdY2g2OXXaQ3En=fBfBe45hAjuJMFNUw@mail.gmail.com>
Subject: Re: [PATCH v8 06/13] KVM: arm64: Sanitize PM{C,I}NTEN{SET,CLR},
 PMOVS{SET,CLR} before first run
To:     Marc Zyngier <maz@kernel.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
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

On Mon, Oct 23, 2023 at 5:42=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Fri, 20 Oct 2023 22:40:46 +0100,
> Raghavendra Rao Ananta <rananta@google.com> wrote:
> >
> > For unimplemented counters, the registers PM{C,I}NTEN{SET,CLR}
> > and PMOVS{SET,CLR} are expected to have the corresponding bits RAZ.
> > Hence to ensure correct KVM's PMU emulation, mask out the bits in
> > these registers for these unimplemented counters before the first
> > vCPU run.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  arch/arm64/kvm/arm.c      |  2 +-
> >  arch/arm64/kvm/pmu-emul.c | 11 +++++++++++
> >  include/kvm/arm_pmu.h     |  2 ++
> >  3 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index e3074a9e23a8b..3c0bb80483fb1 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -857,7 +857,7 @@ static int check_vcpu_requests(struct kvm_vcpu *vcp=
u)
> >               }
> >
> >               if (kvm_check_request(KVM_REQ_RELOAD_PMU, vcpu))
> > -                     kvm_pmu_handle_pmcr(vcpu, kvm_vcpu_read_pmcr(vcpu=
));
> > +                     kvm_vcpu_handle_request_reload_pmu(vcpu);
>
> Please rename this to kvm_vcpu_reload_pmu(). That's long enough. But
> see below.
>
Sounds good.

> >
> >               if (kvm_check_request(KVM_REQ_RESYNC_PMU_EL0, vcpu))
> >                       kvm_vcpu_pmu_restore_guest(vcpu);
> > diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> > index 9e24581206c24..31e4933293b76 100644
> > --- a/arch/arm64/kvm/pmu-emul.c
> > +++ b/arch/arm64/kvm/pmu-emul.c
> > @@ -788,6 +788,17 @@ u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool=
 pmceid1)
> >       return val & mask;
> >  }
> >
> > +void kvm_vcpu_handle_request_reload_pmu(struct kvm_vcpu *vcpu)
> > +{
> > +     u64 mask =3D kvm_pmu_valid_counter_mask(vcpu);
> > +
> > +     kvm_pmu_handle_pmcr(vcpu, kvm_vcpu_read_pmcr(vcpu));
> > +
> > +     __vcpu_sys_reg(vcpu, PMOVSSET_EL0) &=3D mask;
> > +     __vcpu_sys_reg(vcpu, PMINTENSET_EL1) &=3D mask;
> > +     __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) &=3D mask;
> > +}
>
> Why is this done on a vcpu request? Why can't it be done upfront, when
> we're requesting the reload? Or when assigning the PMU? Or when
> setting PMCR_EL0?
>
The idea was to do this only once, after userspace has configured the
PMCR.N (and has no option to change it), but before we run the guest
for the first time. So, I guess this can be done when we are
requesting the reload, if you prefer.

When assigning the PMU, it could be too early to sanitize as the
userspace would not have configured the PMCR.N yet.
It can probably be done when userspace configures PMCR.N, but since
this field is per-guest, we may have to apply the setting for all the
vCPUs during the ioctl, which may get a little ugly.

Thank you.
Raghavendra

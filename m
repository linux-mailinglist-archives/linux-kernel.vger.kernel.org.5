Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B098108D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 04:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378429AbjLMDsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 22:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjLMDsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 22:48:22 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70C9D2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 19:48:26 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1f5bd86ceb3so4729338fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 19:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702439306; x=1703044106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clomx9PL4E/h6EqVWy6k5UtmANF6+S2n+IcanEDP7iw=;
        b=l1zGqCMVEoBeB9fSsZMLI6hWpscYG1oRN2SwRzx7v2LdPPeVTdQo0sDsCvay8fTnYu
         KWjl8VI2GC01gktsZRSEkJvCU+X16KxuIO9aJx2FJ0zXr33+uACELJq0gRU6Ku20wOfp
         3LZlGpL2/LS+V5s6o3eLYcyOaoRih7HLWm+O4ha/11nBS0PuM7Dc85sciSy867l7nm97
         KPMqe+cRbxETUyFcdF4FvBPnmQG/Vi8yJO8fYrhm4aKjqycBg1bs9Uc6c/CE70yA2SQJ
         zcpchv0pc8757jFSX7cYzfwswBPWMHt00YdCrBfztuOWXbQCE0GWJ6aCe69QN46rf3SM
         P2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702439306; x=1703044106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clomx9PL4E/h6EqVWy6k5UtmANF6+S2n+IcanEDP7iw=;
        b=cRAaGs3G57aJkDwjCP4QZYdVY3TZ6/azFopdo6wQOuocUe1nbNl1IkjGWHjt8uX1d7
         56U8z0NEKyZS57QGfWhq7YLH8PCebV98jy+qcelUMX7S4ikp37+o5O+4XpNNZHRCIu+i
         pXzuiwej+TBRWyymvb9hzdLhfB+wEbyg3+FaDEtYNtxcRZtUWwZelqHpKV2xc+6kYW1z
         0T6WCGx5zf9uTcnrlIjDUsOMbA5ZZNSepP8AKGUvfc5U6ulcsuW5vdTNeM95iyrd0w4O
         aYsqjx3HEpY97V+xFfQkoU9sPbYAsDHkcOOI1CnQEdmubVQKkf78rRovPXvI2JY3COTY
         6pIw==
X-Gm-Message-State: AOJu0YyimBoJ1SJ7uOV0sa4F3LUuauRBw646VDc/E3xnvHT4iagOFpOD
        FZCA0uaC9WZN8cGaouIfawqGcRYKqfpiaZh9MxR85A==
X-Google-Smtp-Source: AGHT+IHaD7oMNiw44MXxn+uDeF6j7vus4UTyBrcemloFE3EsCuYwUQ2y1gCTT2NYO5EC6m2cG+Vf+ppSjaTtGglMAhY=
X-Received: by 2002:a05:6870:e8c5:b0:203:27d2:8db4 with SMTP id
 r5-20020a056870e8c500b0020327d28db4mr82714oan.108.1702439306195; Tue, 12 Dec
 2023 19:48:26 -0800 (PST)
MIME-Version: 1.0
References: <20231212053501.12054-1-yongxuan.wang@sifive.com> <CAK9=C2VOXj5oCAZEPS24K98UmQycupoJCcATGDNr+HFr9aVCPw@mail.gmail.com>
In-Reply-To: <CAK9=C2VOXj5oCAZEPS24K98UmQycupoJCcATGDNr+HFr9aVCPw@mail.gmail.com>
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date:   Wed, 13 Dec 2023 11:48:15 +0800
Message-ID: <CAMWQL2gWGYYD1mFHOnd6oQGvAmh6UHb9w++KMOTLbB9p=om-2Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] RISCV: KVM: should not be interrupted when update the
 external interrupt pending
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 12:03=E2=80=AFAM Anup Patel <apatel@ventanamicro.co=
m> wrote:
>
> On Tue, Dec 12, 2023 at 11:05=E2=80=AFAM Yong-Xuan Wang
> <yongxuan.wang@sifive.com> wrote:
> >
> > The emulated IMSIC update the external interrupt pending depending on t=
he
> > value of eidelivery and topei. It might lose an interrupt when it is
> > interrupted before setting the new value to the pending status.
>
> More simpler PATCH subject can be:
> "RISCV: KVM: update external interrupt atomically for IMSIC swfile"
>
> >
> > For example, when VCPU0 sends an IPI to VCPU1 via IMSIC:
> >
> > VCPU0                           VCPU1
> >
> >                                 CSRSWAP topei =3D 0
> >                                 The VCPU1 has claimed all the external
> >                                 interrupt in its interrupt handler.
> >
> >                                 topei of VCPU1's IMSIC =3D 0
> >
> > set pending in VCPU1's IMSIC
> >
> > topei of VCPU1' IMSIC =3D 1
> >
> > set the external interrupt
> > pending of VCPU1
> >
> >                                 clear the external interrupt pending
> >                                 of VCPU1
> >
> > When the VCPU1 switches back to VS mode, it exits the interrupt handler
> > because the result of CSRSWAP topei is 0. If there are no other externa=
l
> > interrupts injected into the VCPU1's IMSIC, VCPU1 will never know this
> > pending interrupt unless it initiative read the topei.
> >
> > If the interruption occurs between updating interrupt pending in IMSIC
> > and updating external interrupt pending of VCPU, it will not cause a
> > problem. Suppose that the VCPU1 clears the IPI pending in IMSIC right
> > after VCPU0 sets the pending, the external interrupt pending of VCPU1
> > will not be set because the topei is 0. But when the VCPU1 goes back to
> > VS mode, the pending IPI will be reported by the CSRSWAP topei, it will
> > not lose this interrupt.
> >
> > So we only need to make the external interrupt updating procedure as a
> > critical section to avoid the problem.
> >
>
> Please add a "Fixes:" line here
>
> > Tested-by: Roy Lin <roy.lin@sifive.com>
> > Tested-by: Wayling Chen <wayling.chen@sifive.com>
> > Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > ---
> >  arch/riscv/kvm/aia_imsic.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> > index 6cf23b8adb71..0278aa0ca16a 100644
> > --- a/arch/riscv/kvm/aia_imsic.c
> > +++ b/arch/riscv/kvm/aia_imsic.c
> > @@ -37,6 +37,8 @@ struct imsic {
> >         u32 nr_eix;
> >         u32 nr_hw_eix;
> >
> > +       spinlock_t extirq_update_lock;
> > +
>
> Please rename this lock to "swfile_extirq_lock".
>
> >         /*
> >          * At any point in time, the register state is in
> >          * one of the following places:
> > @@ -613,12 +615,17 @@ static void imsic_swfile_extirq_update(struct kvm=
_vcpu *vcpu)
> >  {
> >         struct imsic *imsic =3D vcpu->arch.aia_context.imsic_state;
> >         struct imsic_mrif *mrif =3D imsic->swfile;
> > +       unsigned long flags;
> > +
>
> Add a short summary in a comment block about why external interrupt
> updates are required to be in the critical section.
>
> > +       spin_lock_irqsave(&imsic->extirq_update_lock, flags);
> >
> >         if (imsic_mrif_atomic_read(mrif, &mrif->eidelivery) &&
> >             imsic_mrif_topei(mrif, imsic->nr_eix, imsic->nr_msis))
> >                 kvm_riscv_vcpu_set_interrupt(vcpu, IRQ_VS_EXT);
> >         else
> >                 kvm_riscv_vcpu_unset_interrupt(vcpu, IRQ_VS_EXT);
> > +
> > +       spin_unlock_irqrestore(&imsic->extirq_update_lock, flags);
> >  }
> >
> >  static void imsic_swfile_read(struct kvm_vcpu *vcpu, bool clear,
> > @@ -1029,6 +1036,7 @@ int kvm_riscv_vcpu_aia_imsic_init(struct kvm_vcpu=
 *vcpu)
> >         imsic->nr_eix =3D BITS_TO_U64(imsic->nr_msis);
> >         imsic->nr_hw_eix =3D BITS_TO_U64(kvm_riscv_aia_max_ids);
> >         imsic->vsfile_hgei =3D imsic->vsfile_cpu =3D -1;
> > +       spin_lock_init(&imsic->extirq_update_lock);
> >
> >         /* Setup IMSIC SW-file */
> >         swfile_page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO,
> > --
> > 2.17.1
> >
> >
>
> Regards,
> Anup

Hi Anup,

Thank you! I will update in next version.

Regards,
Yong-Xuan

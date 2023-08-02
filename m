Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CB276DB82
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjHBX3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjHBX3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:29:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E032690
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 16:29:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc0075ab7aso35915ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 16:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691018944; x=1691623744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4Cpxp6Pku565KQX/OGtqaeqvGA0IKhVwq6ynNOZ9r0=;
        b=fFTplzOAgW5+YW0+6iv4fkiN86H6j11X1pwoSxH+UbZ6p7iYCmpU0kuNqQBfel9T5G
         TeHCwy18VTn4JwR0FocGU0dkHDSQ01w0aCShr72E11WRUJ0CH751ArFGzoZUkTYgcDou
         gpT/KoBW3YaVs/k6v5HBuDGdwQ8fJdnUpJjdrS7LEtN9Uwz7yeQN9HB4kn1GVc0KUKqc
         DmlFiExHRsSljlkGVAJKSI7bbzKb2/ECq55k51gfA8LRkuFLjGvgB4kOf7KBZm79RD0a
         40vexDUVr9QAtQr7cD7Kllq93RNs7LMjDkavplv45/IYcQbfxyQND1D7JcDZaz5TIdZ5
         l/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691018944; x=1691623744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4Cpxp6Pku565KQX/OGtqaeqvGA0IKhVwq6ynNOZ9r0=;
        b=gXRtt59xonw79Vqyf9uhb6XjFFYJaNBTkDc8Iw8UjabKQyfxrSxrNn+/0623B40Hxl
         40eonJzO627+/nPHoguoEtwGA7Pla2zb83cpLfjv4loaPieJ6t7tboeCA+6H2fnbKm45
         zkbwfiFo4FkNnHCM3+Y+RWW1DALJpJPRJr8wsK9onVDWJ4TQXi07YHBCuc7r5XU3M2y1
         kdpSr+8FQf+tNnAvVFzDruXxegK92ehMMtlx5qmNM63np25q/54RZG4kbcT7ZMuuMT9y
         VsfJlwM518gF96jRQEipsL4UKWen0TSoV9ess6Mf/JbmE1Q7Nqwrss06MtZVfgXQOlNH
         oFuw==
X-Gm-Message-State: ABy/qLanaqBdsfeLSr8BK/clwHejHiVdpFsZxSd1I84gmS5GUiLgloTa
        HM17aFIESB6/lGLEft2F6KqdNGVSNKLa8hQJXLhz+A==
X-Google-Smtp-Source: APBJJlG1dr/uy6dgVj2w+3yAHutiDqre/zphK0p3aHVqG2DYCooyBFbGflKhgzehlkYIwCQRRRLEXuzHej99+96ASLI=
X-Received: by 2002:a17:902:c40f:b0:1b0:53dc:1f78 with SMTP id
 k15-20020a170902c40f00b001b053dc1f78mr966525plk.28.1691018944272; Wed, 02 Aug
 2023 16:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230722022251.3446223-1-rananta@google.com> <20230722022251.3446223-3-rananta@google.com>
 <87tttpr6qy.wl-maz@kernel.org> <ZMgsjx8dwKd4xBGe@google.com> <877cqdqw12.wl-maz@kernel.org>
In-Reply-To: <877cqdqw12.wl-maz@kernel.org>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Wed, 2 Aug 2023 16:28:52 -0700
Message-ID: <CAJHc60xAUVt5fbhEkOqeC-VF8SWVOt3si=1yxVVAUW=+Hu_wNg@mail.gmail.com>
Subject: Re: [PATCH v7 02/12] KVM: arm64: Use kvm_arch_flush_remote_tlbs()
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, I'll change it to kvm_arch_flush_vm_tlbs() in v8.

Thanks,
Raghavendra

On Wed, Aug 2, 2023 at 8:55=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 31 Jul 2023 22:50:07 +0100,
> Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Thu, Jul 27, 2023, Marc Zyngier wrote:
> > > On Sat, 22 Jul 2023 03:22:41 +0100,
> > > Raghavendra Rao Ananta <rananta@google.com> wrote:
> > > >
> > > > Stop depending on CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL and opt to
> > > > standardize on kvm_arch_flush_remote_tlbs() since it avoids
> > > > duplicating the generic TLB stats across architectures that impleme=
nt
> > > > their own remote TLB flush.
> > > >
> > > > This adds an extra function call to the ARM64 kvm_flush_remote_tlbs=
()
> > > > path, but that is a small cost in comparison to flushing remote TLB=
s.
> > >
> > > Well, there is no such thing as a "remote TLB" anyway. We either have
> > > a non-shareable or inner-shareable invalidation. The notion of remote
> > > would imply that we track who potentially has a TLB, which we
> > > obviously don't.
> >
> > Maybe kvm_arch_flush_vm_tlbs()?  The "remote" part is misleading even o=
n x86 when
> > running on Hyper-V, as the flush may be done via a single hypercall and=
 by kicking
> > "remote" vCPUs.
>
> Yup, this would be much better.
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

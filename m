Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0348E7873D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242158AbjHXPQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242097AbjHXPPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:15:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E421199D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:15:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d6adc83eb10so7807062276.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692890145; x=1693494945;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCC0wwp7wWSIy0MrdACmgS4Vp0ye9VEhwI7wuPMec4A=;
        b=FtVfL5Tf+6L+aGO+3VLVFfVEdfsELAv/SkE1PTKpiAC3gFVBjTzmjrn/G6noL3tCwT
         nY/EAJeRp1nUZ1X8yuA3Jxf69ZaoSNHuvOQh3ULPUAYpMu4LVrXdZw1h4nH2PAlfwGQ5
         HGQOfNLw0wvbAHb80uzDgzcI3HY8lXjzMoOoHDVH4Pz8HXQOOW7DfntGjjOL04U2gBH5
         ZxYs546ol999Lp9xjtgeFXwtR0AaARSkkT0m/gVyhfqtUMb/pTpVMTXHfDw9wPW17NyP
         1E6e3/AVVS3EyluWhAt1DasCBBld/p7NdQ0UhAyRFy01f8SCDMvj/nvu0ZKPtEv3L+Gt
         UNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692890145; x=1693494945;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BCC0wwp7wWSIy0MrdACmgS4Vp0ye9VEhwI7wuPMec4A=;
        b=BEebQlcMoVweqLU167jsx8cQKUOMrzo3uOovWsBu8OPfYv0hXCuwfSY83wMK9Cjbma
         eBLs+U/ZFG8WbcGjMLhbXg29++R+pAgjkGPsIbsvCtawmx9EaFk11cZM3uv9DCwTmGeV
         jF7kPY8RXgeIFdxkWGHcKOvXqAhlkkVaCGF43e9qxnLbKU5TS0l5yHEMwdCI6QoWXDM7
         qGdS0EFhw0LdDX14YYzj4V07YS9n4s1x6y3cu7xKzKhIvLv19lhmdzv4qKlftCgA2syN
         9DFq0cEhQzQP/YfM4Vnw21kD1ROLA3il0aAmclLb67lCZGePa63T+A2cMcJuoEIJl3QS
         2nNA==
X-Gm-Message-State: AOJu0YwRS8VDmYA6K+z8n8CMPFF9VVt/Za1Y/LxVkx1sR2pk4pObYotz
        r868LS3s8KLDdA0pa78vPTpdhOf1fLQ=
X-Google-Smtp-Source: AGHT+IEE5MT+OR26AI25mjbMCPL/tYmhkhOKeyxLgW2HJM/WWK+y8/HYNn2t4mxnVIC7aAY/Rh8OZ4/3wmA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2484:0:b0:d74:cdd7:d491 with SMTP id
 k126-20020a252484000000b00d74cdd7d491mr186602ybk.5.1692890145678; Thu, 24 Aug
 2023 08:15:45 -0700 (PDT)
Date:   Thu, 24 Aug 2023 08:15:44 -0700
In-Reply-To: <CAD=HUj7F6CUNt_9txEu0upB=PBwJzkL5dBhNs_BVHX1cicqBgw@mail.gmail.com>
Mime-Version: 1.0
References: <20230704075054.3344915-1-stevensd@google.com> <20230704075054.3344915-6-stevensd@google.com>
 <20230705102547.hr2zxkdkecdxp5tf@linux.intel.com> <CAD=HUj7F6CUNt_9txEu0upB=PBwJzkL5dBhNs_BVHX1cicqBgw@mail.gmail.com>
Message-ID: <ZOd0IMeKSkBwGIer@google.com>
Subject: Re: [PATCH v7 5/8] KVM: x86/mmu: Don't pass FOLL_GET to __kvm_follow_pfn
From:   Sean Christopherson <seanjc@google.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     Yu Zhang <yu.c.zhang@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Xu <peterx@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023, David Stevens wrote:
> On Wed, Jul 5, 2023 at 7:25=E2=80=AFPM Yu Zhang <yu.c.zhang@linux.intel.c=
om> wrote:
> >
> > On Tue, Jul 04, 2023 at 04:50:50PM +0900, David Stevens wrote:
> > > @@ -4529,7 +4540,8 @@ static int kvm_tdp_mmu_page_fault(struct kvm_vc=
pu *vcpu,
> > >
> > >  out_unlock:
> > >       read_unlock(&vcpu->kvm->mmu_lock);
> > > -     kvm_release_pfn_clean(fault->pfn);
> >
> > Yet kvm_release_pfn() can still be triggered for the kvm_vcpu_maped gfn=
s.
> > What if guest uses a non-referenced page(e.g., as a vmcs12)? Although I
> > believe this is not gonna happen in real world...
>=20
> kvm_vcpu_map still uses gfn_to_pfn, which eventually passes FOLL_GET
> to __kvm_follow_pfn. So if a guest tries to use a non-refcounted page
> like that, then kvm_vcpu_map will fail and the guest will probably
> crash. It won't trigger any bugs in the host, though.
>=20
> It is unfortunate that the guest will be able to use certain types of
> memory for some purposes but not for others. However, while it is
> theoretically fixable, it's an unreasonable amount of work for
> something that, as you say, nobody really cares about in practice [1].
>=20
> [1] https://lore.kernel.org/all/ZBEEQtmtNPaEqU1i@google.com/

There are use cases that care, which is why I suggested allow_unsafe_kmap.
Specifically, AWS manages their pool of guest memory in userspace and maps =
it all
via /dev/mem.  Without that module param to let userspace opt-in, this seri=
es will
break such setups.  It still arguably is a breaking change since it require=
s
userspace to opt-in, but allowing such behavior by default is simply not a =
viable
option, and I don't have much sympathy since so much of this mess has its o=
rigins
in commit e45adf665a53 ("KVM: Introduce a new guest mapping API").

The use cases that no one cares about (AFAIK) is allowing _untrusted_ users=
pace
to back guest RAM with arbitrary memory.  In other words, I want KVM to all=
ow
(by default) mapping device memory into the guest for things like vGPUs, wi=
thout
having to do the massive and invasive overhaul needed to safely allow backi=
ng guest
RAM with completely arbitrary memory.

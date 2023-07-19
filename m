Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F011B7597E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjGSOPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjGSOPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:15:14 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F58C10FC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:15:12 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b888bdacbcso36985835ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689776112; x=1692368112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpT1srfgRytmcGt7uikxVNkA3BifxPUMvb756SCoWfo=;
        b=j6O4A4Kn8RrMiTsmWugcLoaBmDhdEOi6nm13D61dQWbrv/4yDEEVo/KZUz/JqdfsPo
         ZnKg9K95Lj7ZE2/dyLjlrZe55VZWZdtTVn9fgyfdtCrw5ElGnLLq/Qm5V23hi657OpUr
         Ebqn7DpgmWmZ6MQquOf5BjnPEIp0JeTMJYNB26HnYKqlFJQ9PECoKhiIFC6MpAGppjwD
         QEmzIJjuF0aS8nAXfMaVCs/HL9rulvVWCoWXejxaQyjwn7Vpfe71Kirx4tiYJoYvfJy1
         s3tsizGDD9BtrGq0rYlfmNI7dH4xGaeqfoCnPAOEbyXtpSJtpl3/bu64M8d1b+aFanZ/
         4psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689776112; x=1692368112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpT1srfgRytmcGt7uikxVNkA3BifxPUMvb756SCoWfo=;
        b=FWDeb8naK9XMrmbNZ7Q/bHyRFMP9GD0s4s3KDYgq0Tt5q648ziNgkuiSE0v1l2m10M
         6iiDzZGhuk7SBBAqOfH6zTdeRsLb1gjVkqsGYwhImfdpQXCidx2oSGMT6a8tF1TzE1RL
         SIiPwf2tmRjAKzeC2Tddtwz7YOnwU0BHtT8ZYN1EpYZNbaqLZxx3L2tc2329dAfn+ZsX
         YgIkio3RFFqAWERQ1V8YrJ/S7HmgXzOueeiTUFc0Wlfn7ZWWNRRc9oAixEh3XljEiB/S
         XwqRJiMD5M3nsM7BJQre2SdlawU+lkGmd0u/3sADHhA6DuEVw2vpYlmhau7pMM2/5E6Q
         SLcA==
X-Gm-Message-State: ABy/qLZQtk9Bh8mVj8UofJkwNOGLg4Hjc+T6NtZId4ndO9QjrYFWUArx
        jRmnOtSbrERJIc1N1ypyHZLE0wHlRn0=
X-Google-Smtp-Source: APBJJlG/y4qA2BEDL4k7hIJJKli+sdbNpvQf/prgfQp/iya4mlyKn4vdU0WvDm35KgLLUXfLwfwgiDZvoZw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e812:b0:1ae:6895:cb96 with SMTP id
 u18-20020a170902e81200b001ae6895cb96mr14210plg.5.1689776111918; Wed, 19 Jul
 2023 07:15:11 -0700 (PDT)
Date:   Wed, 19 Jul 2023 07:15:09 -0700
In-Reply-To: <20230719073115.vuedo2cf3mp27xm4@yy-desk-7060>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-6-seanjc@google.com>
 <20230719073115.vuedo2cf3mp27xm4@yy-desk-7060>
Message-ID: <ZLfv7aRq5W52ezek@google.com>
Subject: Re: [RFC PATCH v11 05/29] KVM: Convert KVM_ARCH_WANT_MMU_NOTIFIER to CONFIG_KVM_GENERIC_MMU_NOTIFIER
From:   Sean Christopherson <seanjc@google.com>
To:     Yuan Yao <yuan.yao@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
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

On Wed, Jul 19, 2023, Yuan Yao wrote:
> On Tue, Jul 18, 2023 at 04:44:48PM -0700, Sean Christopherson wrote:
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 90a0be261a5c..d2d3e083ec7f 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -255,7 +255,9 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> >  int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
> >  #endif
> >
> > -#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
> > +struct kvm_gfn_range;
> 
> Not sure why a declaration here, it's defined for ARCHs which defined
> KVM_ARCH_WANT_MMU_NOTIFIER before.

The forward declaration exists to handle cases where CONFIG_KVM=n, specifically
arch/powerpc/include/asm/kvm_ppc.h's declaration of hooks to forward calls to
uarch modules:

	bool (*unmap_gfn_range)(struct kvm *kvm, struct kvm_gfn_range *range);
	bool (*age_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
	bool (*test_age_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
	bool (*set_spte_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);

Prior to using a Kconfig, a forward declaration wasn't necessary because
arch/powerpc/include/asm/kvm_host.h would #define KVM_ARCH_WANT_MMU_NOTIFIER even
if CONFIG_KVM=n.

Alternatively, kvm_ppc.h could declare the struct.  I went this route mainly to
avoid the possibility of someone encountering the same problem on a different
architecture.

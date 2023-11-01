Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C2E7DE541
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344732AbjKARVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344690AbjKARVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:21:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF2F129
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:20:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7cc433782so525647b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 10:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698859256; x=1699464056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TDeMHyg6nuM6uHT2NhRlyelK+fI/RFOQGU6FtIWq+2I=;
        b=nuXm2KocmpbxdbmXC+RtU7wGzmV0XtSzPB/k+4qzCth2TwazsSLX7PN0/rZ1zlQZJD
         VKcmWJfjCrCvn7AfEI+stBdTXKzpnOdUiE6YUNPl2ApjjBkUqj9z4lAffMcU+Xlszani
         lvauQkrJI4j4WtxHeYS1QguZYRIDohvpgZuzMWEUGZRaTMepGNdsg5piEJF3syRCRDvJ
         aoDVKgQtahhFcz7fNT55NBQH0JxS6YJF0vXBDLxOQRsplMLRsiWzBF8Emlz7aOIfRfpn
         HUDkKaEu8xhFAeUXZjG+QQLtuIppMrGplUvRq8OJf9DLLZAZ00IntUyx7XzikS8vx4sF
         gpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698859256; x=1699464056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDeMHyg6nuM6uHT2NhRlyelK+fI/RFOQGU6FtIWq+2I=;
        b=pmBDEXuvG2F+AFAEJXmg4gmu4yV7BqLIQNTfIO2XiwxCSHtvA0w/osdyZFjVhWMMon
         iEePpyPqXPjdQAB6ez56XhSqXSkNdh/A5JmCeVwt7JtbfCqXlpYc0727w6JYdk1KzjYp
         9cJgd5Xwu4mtrpIAwAUXcMfoLmjPuYkjjgBfpk2ovrsv9OhNOqR+rWum7P8imu6gmH7O
         jRYrj7CzjLqgoswTVNul08gKcek1TqGMTFXrJtMyYQwhBAHZU41ZF2Tj/EhjEUmB6rmW
         XLx0g1TYbJm11Y5aSGkBmefsiKfKsnx97AvS7Ojp06lekVja2HdVxb+mAmqE/+1tXkdF
         DW+g==
X-Gm-Message-State: AOJu0YwYI6Wp5QaIOhlvpFjyiiSairScdR6pszSeZVxR9fEsfDnMwFmi
        +0Z0O0H5n9imLzRkPGEZC7JNrWfxESA=
X-Google-Smtp-Source: AGHT+IFwGVOPpso45s8V613XF539Qxh3lGXMwKqbbJhIsTxBDYEsG0+0t68Cu9sJzvzKgPmuAbddDRn/tvw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:7702:0:b0:d9a:6007:223a with SMTP id
 s2-20020a257702000000b00d9a6007223amr319245ybc.8.1698859255708; Wed, 01 Nov
 2023 10:20:55 -0700 (PDT)
Date:   Wed, 1 Nov 2023 10:20:54 -0700
In-Reply-To: <5c5eb1cc92d05fb7717fe3480aeb7b20e7842d05.camel@redhat.com>
Mime-Version: 1.0
References: <20230914063325.85503-1-weijiang.yang@intel.com>
 <20230914063325.85503-13-weijiang.yang@intel.com> <5c5eb1cc92d05fb7717fe3480aeb7b20e7842d05.camel@redhat.com>
Message-ID: <ZUKI9oqwaZ46dHeX@google.com>
Subject: Re: [PATCH v6 12/25] KVM: x86: Refresh CPUID on write to guest MSR_IA32_XSS
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023, Maxim Levitsky wrote:
> On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> > @@ -312,6 +313,17 @@ static u64 vcpu_get_supported_xcr0(struct kvm_vcpu *vcpu)
> >  	return (best->eax | ((u64)best->edx << 32)) & kvm_caps.supported_xcr0;
> >  }
> >  
> > +static u64 vcpu_get_supported_xss(struct kvm_vcpu *vcpu)
> > +{
> > +	struct kvm_cpuid_entry2 *best;
> > +
> > +	best = kvm_find_cpuid_entry_index(vcpu, 0xd, 1);
> > +	if (!best)
> > +		return 0;
> > +
> > +	return (best->ecx | ((u64)best->edx << 32)) & kvm_caps.supported_xss;
> > +}
> 
> Same question as one for patch that added vcpu_get_supported_xcr0()
> Why to have per vCPU supported XSS if we assume that all CPUs have the same
> CPUID?
> 
> I mean I am not against supporting hybrid CPU models, but KVM currently doesn't
> support this and this creates illusion that it does.

KVM does "support" hybrid vCPU models in the sense that KVM has allow hybrid models
since forever.  There are definite things that won't work, e.g. not all relevant
CPUID bits are captured in kvm_mmu_page_role, and so KVM will incorrectly share
page tables across vCPUs that are technically incompatible.

But for many features, heterogenous vCPU models do Just Work as far as KVM is
concerned.  There likely isn't a real world kernel that supports heterogenous
feature sets for things like XSS and XCR0, but that's a guest software limitation,
not a limitation of KVM's CPU virtualization.

As with many things, KVM's ABI is to let userspace shoot themselves in the foot.

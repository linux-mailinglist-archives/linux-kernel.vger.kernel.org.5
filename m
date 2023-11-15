Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824B97EC6BF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344375AbjKOPJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343952AbjKOPJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:09:21 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92FAB8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:09:18 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc56cc8139so11196505ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700060958; x=1700665758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r39GnHM5bN5YuWeX4taddVxZqZSztKdXAkWyIoY43Wo=;
        b=2Y16O+5x6Jbce4BxgT6Z+vMDFfRVva3mDQMtTO8/W8t1P7qw1vD94TYr+BBFGmIKih
         DyDpJtVwhFkXNRfI//1ZLFHNljMLI+4bdT3KT4P2AjPsKdt3qPIADeVNkRyEkY2lhT6W
         UMju58oifU4eAzkVzDciUHmUJbDVe042sVpmV/ngmjOZgT3DAJ0u9c8O8qgVTBp+J+km
         Gio6YnCprERGaujNjkVN106T0QmBsuaaBlWCRYzzymbBUoSF1R7SyhH5xUCY6rKtiqdL
         +g5vixlaY2uocmpuDaGNFcLh/aawLjRgJCz9H3IeNQBBaUPPavGedswcUErYK+Rr4vfa
         sMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700060958; x=1700665758;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r39GnHM5bN5YuWeX4taddVxZqZSztKdXAkWyIoY43Wo=;
        b=jPm4OnBPzDGaINxYij/WMMdQTxtMfSw4kWt0bssR+CS/YuzJNyerSrytw23jHImCU6
         LSZQDMcobGslJIzQGK4k3caIrEN8Pc5fhf2LFQru+Y38GWmf+ChcOpj+JRqNcqHu3few
         wPohV4dfkPAkluKcoxU8JDpYcEOsjVyjgFGDgkV/ILP5AxJRGxg4AS2IGKxQe2UWbApg
         ph1jgXsI9QpXE0JjkZQoZTfjyIpkI+aQ552iSGM39Bmpdo81zdybNEsS5GBN6yFJn/+N
         JJ/f/QV5ZgvLpJlM5jbKgqgjXNe9mrcrmUOkqo7YLn2gmj2cwtg5FRDuO1FJncHgrWyd
         yGqw==
X-Gm-Message-State: AOJu0YwNE+Dxl1m+RKy6/uaCnEe1QxU+5WdBNpR0xwlcQdvc4/PJ8mby
        s6Dc6mypNOdgCGA1tbtK46KG7W9qBeQ=
X-Google-Smtp-Source: AGHT+IG3qu3lFpMuQCfcgeEIlbULEmHkvJwhR5/zE7upNlxp4Rd+jCAiKWz5+AvxCJXFT41oeQkNPes24J4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:4292:b0:1cc:166f:91c8 with SMTP id
 ju18-20020a170903429200b001cc166f91c8mr1456351plb.1.1700060958209; Wed, 15
 Nov 2023 07:09:18 -0800 (PST)
Date:   Wed, 15 Nov 2023 07:09:15 -0800
In-Reply-To: <9395d416-cc5c-536d-641e-ffd971b682d1@gmail.com>
Mime-Version: 1.0
References: <20231110235528.1561679-1-seanjc@google.com> <20231110235528.1561679-7-seanjc@google.com>
 <ffec2e93-cdb1-25e2-06ec-deccf8727ce4@gmail.com> <ZVN6w2Kc2AUmIiJO@google.com>
 <9395d416-cc5c-536d-641e-ffd971b682d1@gmail.com>
Message-ID: <ZVTfG6mARiyttuKj@google.com>
Subject: Re: [PATCH 6/9] KVM: x86: Update guest cpu_caps at runtime for
 dynamic CPUID-based features
From:   Sean Christopherson <seanjc@google.com>
To:     Robert Hoo <robert.hoo.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023, Robert Hoo wrote:
> On 11/14/2023 9:48 PM, Sean Christopherson wrote:
> > On Mon, Nov 13, 2023, Robert Hoo wrote:
> ...
> > > u32 *caps  = vcpu->arch.cpu_caps;
> > > and update guest_cpu_cap_set(), guest_cpu_cap_clear(),
> > > guest_cpu_cap_change() and guest_cpu_cap_restrict() to pass in
> > > vcpu->arch.cpu_caps instead of vcpu, since all of them merely refer to vcpu
> > > cap, rather than whole vcpu info.
> > 
> > No, because then every caller would need extra code to pass
> > vcpu->cpu_caps,
> 
> Emm, I don't understand this. I tried to modified and compiled, all need to
> do is simply substitute "vcpu" with "vcpu->arch.cpu_caps" in calling. (at
> the end is my diff based on this patch set)

Yes, and I'm saying that

	guest_cpu_cap_restrict(vcpu, X86_FEATURE_PAUSEFILTER);
	guest_cpu_cap_restrict(vcpu, X86_FEATURE_PFTHRESHOLD);
	guest_cpu_cap_restrict(vcpu, X86_FEATURE_VGIF);
	guest_cpu_cap_restrict(vcpu, X86_FEATURE_VNMI);

is harder to read and write than this

	guest_cpu_cap_restrict(vcpu->arch.cpu_caps, X86_FEATURE_PAUSEFILTER);
	guest_cpu_cap_restrict(vcpu->arch.cpu_caps, X86_FEATURE_PFTHRESHOLD);
	guest_cpu_cap_restrict(vcpu->arch.cpu_caps, X86_FEATURE_VGIF);
	guest_cpu_cap_restrict(vcpu->arch.cpu_caps, X86_FEATURE_VNMI);

a one-time search-replace is easy, but the extra boilerplate has a non-zero cost
for every future developer/reader.

> > and passing 'u32 *' provides less type safety than 'struct kvm_vcpu *'.
> > That tradeoff isn't worth making this one path slightly easier to read.
> 
> My point is also from vulnerability, long term, since as a principle, we'd
> better pass in param/info to a function of its necessity.

Attempting to apply the principle of least privilege to low level C helpers is
nonsensical.  E.g. the helper can trivially get at the owning vcpu via container_of()
(well, if not for typeof assertions not playing nice with arrays, but open coding
container_of() is also trivial and illustrates the point).

	struct kvm_vcpu_arch *arch = (void *)caps -  offsetof(struct kvm_vcpu_arch, cpu_caps);
	struct kvm_vcpu *vcpu = container_of(arch, struct kvm_vcpu, arch);

	if (!kvm_cpu_cap_has(x86_feature))
		guest_cpu_cap_clear(vcpu, x86_feature);

And the intent behind that principle is to improve security/robustness; what I'm
saying is that passing in a 'u32 *" makes the overall implementation _less_ robust,
as it opens up the possibilities of passing in an unsafe/incorrect pointer.  E.g.
a well-intentioned, not _that_ obviously broken example is:

	guest_cpu_cap_restrict(&vcpu->arch.cpu_caps[CPUID_1_ECX], X86_FEATURE_XSAVE);

> e.g. cpuid_entry2_find().

The main reason cpuid_entry2_find() exists is because KVM checks the incoming
array provided by KVM_SET_CPUID2, which is also the reason why
__kvm_update_cpuid_runtime() takes an @entries array instead of just @vcpu.

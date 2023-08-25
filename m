Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85763788BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343777AbjHYOcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343781AbjHYOcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:32:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB36C19A5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:32:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d6b7eb39ef0so1230917276.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692973947; x=1693578747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HQ6haPxXRPrLc3nfS+wWnCF+vxDB+s3WtEWUjGbPl3U=;
        b=QFJWRWDdZRKNchq4kvTgTWEsh2sq/eaOkv6aYqTWyVBna3NHNtxGyouxLpnd930uF6
         xrM4K51Q3whGK5a6HYWpIzYCSsW/3qTS+KiSXuKk+0yMdclapZH+8hCwopte/mgBnf+N
         fPimfX6W5HhFoBvVZBvLjqj8+y6NgO1lWrbc66FpCfPfAJ7sP6iKn3NzCjD6guzZ7xeW
         rDYim80zrJ0b/zA++q7Za9g5MsQTNAk4CnuOuFsW/75e1LvQR4FJg1EAsJpsp/V1L0w+
         TSUdfWP7FvnksJDv45iXqehtLEAxSDtGFqFB2FX1EcMU0NbxXlF79DVnlTvLSdaxNYIO
         Gj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692973947; x=1693578747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQ6haPxXRPrLc3nfS+wWnCF+vxDB+s3WtEWUjGbPl3U=;
        b=fjcTHS7G8MOEZFXJBsrP8O+MsYNs/UAmKFm/r37hyPBJ3FMDntV86oO3lwqcOFhMC0
         EOaDUsh4u6RhjG9/EG0iK95XbT7N8OgDeWB+H+MwkzAr1xsFl8wCQEQZDxKyjBVTC62l
         Rr23vqVnicAVk14DZRPrTurgJHJ5Sh6FyTag7S3/ebDntcsMN5zX8Dg6GKRg/+XzrmYO
         PE2Gw3WBMuwTKi9TtjNg0NNXFlU8vVgCihtAVkWAfOmtwMxbi9/5dXSMk0wKfwA7Bq/+
         KA2ylD7qFA+ZCNcH2L4yWLyWenygCOuVIt6SCEElt2OqLvma1m87K9XBf0B1t/e+FgOR
         hoWQ==
X-Gm-Message-State: AOJu0YwMgK84XQ5JyXpsuB8KxEECYIQIIWAxdv198UvxVx9CATNlxpLB
        PxMK2zvmHdmfUd89muQpgBOu6qz8C/Y=
X-Google-Smtp-Source: AGHT+IFocahQjWwZvsNLpgLkTDn+wOdt4THJOyEU0cdzGulBNnPV/7XHKB2wI0iHmqEvaGiljZWFNe4ibyA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1141:b0:d58:6cea:84de with SMTP id
 p1-20020a056902114100b00d586cea84demr671668ybu.11.1692973947233; Fri, 25 Aug
 2023 07:32:27 -0700 (PDT)
Date:   Fri, 25 Aug 2023 07:32:25 -0700
In-Reply-To: <9dddb2ef-e021-087d-f0ea-9e0e3d8843b9@amd.com>
Mime-Version: 1.0
References: <20230825013621.2845700-1-seanjc@google.com> <20230825013621.2845700-5-seanjc@google.com>
 <9dddb2ef-e021-087d-f0ea-9e0e3d8843b9@amd.com>
Message-ID: <ZOi7eRkDWZcrEhp4@google.com>
Subject: Re: [PATCH v2 4/4] KVM: SVM: Treat all "skip" emulation for SEV
 guests as outright failures
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wu Zongyo <wuzongyo@mail.ustc.edu.cn>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023, Tom Lendacky wrote:
> On 8/24/23 20:36, Sean Christopherson wrote:
> > Treat EMULTYPE_SKIP failures on SEV guests as unhandleable emulation
> > instead of simply resuming the guest, and drop the hack-a-fix which
> > effects that behavior for the INT3/INTO injection path.  If KVM can't
> > skip an instruction for which KVM has already done partial emulation,
> > resuming the guest is undesirable as doing so may corrupt guest state.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/svm/svm.c | 12 +-----------
> >   arch/x86/kvm/x86.c     |  9 +++++++--
> >   2 files changed, 8 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 39ce680013c4..fc2cd5585349 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -364,8 +364,6 @@ static void svm_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
> >   		svm->vmcb->control.int_state |= SVM_INTERRUPT_SHADOW_MASK;
> >   }
> > -static int svm_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
> > -					 void *insn, int insn_len);
> >   static int __svm_skip_emulated_instruction(struct kvm_vcpu *vcpu,
> >   					   bool commit_side_effects)
> > @@ -386,14 +384,6 @@ static int __svm_skip_emulated_instruction(struct kvm_vcpu *vcpu,
> >   	}
> >   	if (!svm->next_rip) {
> > -		/*
> > -		 * FIXME: Drop this when kvm_emulate_instruction() does the
> > -		 * right thing and treats "can't emulate" as outright failure
> > -		 * for EMULTYPE_SKIP.
> > -		 */
> > -		if (svm_check_emulate_instruction(vcpu, EMULTYPE_SKIP, NULL, 0) != X86EMUL_CONTINUE)
> > -			return 0;
> > -
> >   		if (unlikely(!commit_side_effects))
> >   			old_rflags = svm->vmcb->save.rflags;
> > @@ -4752,7 +4742,7 @@ static int svm_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
> >   	 */
> >   	if (unlikely(!insn)) {
> >   		if (emul_type & EMULTYPE_SKIP)
> > -			return X86EMUL_RETRY_INSTR;
> > +			return X86EMUL_UNHANDLEABLE;
> 
> Trying to follow this, bear with me...
> 
> This results in an "emulation failure" which fills out all the KVM userspace
> exit information in prepare_emulation_failure_exit(). But because of the
> return 0 in handle_emulation_failure(), in the end this ends up just acting
> like the first patch because we exit out svm_update_soft_interrupt_rip()
> early and the instruction just gets retried?

Yep.  It's a bit more labyrinthian than I'd like, but the soft injection already
relies on this behavior to handle the case where x86_decode_emulated_instruction()
fails.  That's a much more theoretical path, but I'm pretty sure if could trigger
if the guest is replacing the INT3 from a different vCPU and KVM's emulator doesn't
know how to decode the new instruction.

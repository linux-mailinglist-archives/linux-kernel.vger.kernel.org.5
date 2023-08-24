Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE526787591
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbjHXQjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbjHXQjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:39:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F46C10FE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:39:06 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58d428d4956so1170547b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692895145; x=1693499945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oSWjVnNvwfGLEjJ0JtbPtIP+crfjUSSaSHl9Qe/5LQI=;
        b=eKV9udyca9qrtpGlrVfGDjlotiZQr0q1/I6vqI8C88cluwY/dQOApyjmgzaEbnZAHw
         aTC5MQx54dJsei1iF90RbwdlmuSY78YtDXv+wBr//vmIIHe6FChe0mrQV/JZ5tByIImO
         0b4ypU6MT3Fp+DfLBPPsfuQQj+9x6gP6eA4SLhYfZFkjIg2Wd9vlZhtWtAWgJgrsXmUy
         QWmmYKRN478oc4hZbjzSUHvOrvPSR2YnRiFnYLV1g0caFjvoFZcdkn80vHslVzLpbME/
         a4+YsJI0dzzFbvHsC5jQmmHVEeaCUhCAjU+FH4at3OAbHZjzSfCr94VOrBrVFB7u9n2z
         J7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692895145; x=1693499945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSWjVnNvwfGLEjJ0JtbPtIP+crfjUSSaSHl9Qe/5LQI=;
        b=cqtgi62wsE3O2wmkrwppvauqrfOSfhd0jy9H58k6bLMp25CFQnxMUtKqOctIw+E3Hd
         x4mC7QmcjJh5tpewImd0SLuIawwv4Fl2Pa/AWAHIEj+8+aabO/C4l5L/6f9JRAZohBzO
         5L9uMnFFjkqJGqdHzuJ6lEJ2cXk3h/5Wav9eY2o50yBjTQHoY2603/nZ6PZqJMaKKPX+
         TAkvKNs6r7xUF3/Rlxhp1foiEmJU8GybiEG1quBoqfg7PQ+Wz+9xt+tVGzyFZm2MTvCP
         yAblPaizCSeDZjnKi9Tb4LW8edljwpl4kQmn+t9Lvvy+foIwEiNFcWrBgMQOzuSPPj9E
         i5fA==
X-Gm-Message-State: AOJu0YxP4v87GV0mhcNClxXEXWkyqK1bx5RjEMIM8WKnOHit2LsKXtez
        rAxSs5akamEHYex+nEQxJJijNgCQKB0=
X-Google-Smtp-Source: AGHT+IH/hEV0nUIravAftmppsuilVvyeJ+gf6l1YtqzCiCE2YJ6HCxbTMD6ECqu9LwTAe2ynQuk6uzHHKHY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b71a:0:b0:56c:f8b7:d4fa with SMTP id
 v26-20020a81b71a000000b0056cf8b7d4famr228654ywh.7.1692895145438; Thu, 24 Aug
 2023 09:39:05 -0700 (PDT)
Date:   Thu, 24 Aug 2023 09:39:03 -0700
In-Reply-To: <20230821170520.dcovzudamnoqp7jc@treble>
Mime-Version: 1.0
References: <cover.1692580085.git.jpoimboe@kernel.org> <a4d62162bcb501e50b0bb19b748702aa12260615.1692580085.git.jpoimboe@kernel.org>
 <45ef7bcc-d52e-3759-403b-e4b5a79a4a4f@citrix.com> <20230821162337.imzjf3golstkrrgd@treble>
 <ZOOSXc9NE1rMHDZ1@google.com> <20230821170520.dcovzudamnoqp7jc@treble>
Message-ID: <ZOeHp0skdfrARNFe@google.com>
Subject: Re: [PATCH 03/22] KVM: x86: Support IBPB_BRTYPE and SBPB
From:   Sean Christopherson <seanjc@google.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023, Josh Poimboeuf wrote:
> On Mon, Aug 21, 2023 at 04:35:41PM +0000, Sean Christopherson wrote:
> > There are more wrinkles though.  KVM passes through MSR_IA32_PRED_CMD based on
> > IBPB.  If hardware supports both IBPB and SBPB, but userspace does NOT exposes
> > SBPB to the guest, then KVM will create a virtualization hole where the guest can
> > write SBPB against userspace's wishes.  I haven't read up on SBPB enought o know
> > whether or not that's problematic.
> > 
> > And conversely, if userspace expoes SBPB but not IBPB, then KVM will intercept
> > writes to MSR_IA32_PRED_CMD and probably tank guest performance.  Again, I haven't
> > paid attention enough to know if this is a reasonable configuration, i.e. whether
> > or not it's worth caring about in KVM.
> > 
> > If the virtualization holes are deemed safe, then the easiest thing would be to
> > treat MSR_IA32_PRED_CMD as existing if either IBPB or SBPB exists.  E.g.
> 
> I can't think of a reason why the holes wouldn't be safe, i.e. AFAICT
> there's no harm in letting the guest do whatever type of barrier it
> wants even if it's not technically supported by their configuration.
> 
> Question: if we're just always passing PRED_CMD through, what's the
> point of having any PRED_CMD code in kvm_set_msr_common at all?

Emulation :-(  KVM's emulator supports WRMSR, and on Intel without unrestricted
guest, it's unfortunately necessary for KVM to emulate large swaths of guest code.
Emulating WRMSR on other hardware setups is far less likely, but still plausible.

KVM's ABI is also that userspace is allowed to write guest MSRs that KVM says exist,
so KVM needs to at least not reject KVM_SET_MSRS.

Whether or not it makes sense for KVM to forward the WRMSR the hardware is
definitely debatable, especially for writes from host userspace.  But IIUC, at
at worst the WRMSR from KVM could be a noisy neighbor for an SMT sibling, so IMO
it's not worth the brain power needed to determine whether or not KVM can safely
omit the WRMSR.

> Also, since you're clearly more qualified to write this patch than me,
> can I nominate you to do so? :-)

Sorry, didn't mean to ghost you.  I can write the patch, but I won't get to it
before next week some time.

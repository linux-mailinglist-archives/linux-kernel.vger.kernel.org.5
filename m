Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92717D8A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344739AbjJZVXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZVXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:23:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1471AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 14:23:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a8ead739c3so12195647b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 14:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698355380; x=1698960180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N16opPDMh2MtQdZI6n+iYWwhhV2tySRlDoDMCXghPSg=;
        b=tW0tdpJCzDjqvaWkEgER1akFluzgDHehTSAqmh14T6/DYxAaMqvxfAGrhHs+Zm+f2L
         nBv8f63/eJ2JvKwusuMNw3ydP5+P6acqjEkGZn8G7FSeTB9ip3xwHoqdx7iNrVLES5f4
         +E8GeemIUIGUH/KF0GAU3daKfSia64wxG7X3VOLJPOYd70JfHg0Pf+uAg/jRX51ZOMub
         s2K5zMuoDo7TTb/Kt3kLthtgpDSmd2NnmocIau78VzJ5y5LMCa7+Cb/heRmcRQkeggPR
         6ZP1zh244175ZuQtMBUkB95DZ8Y6fCqPez4Qjhht37k47yAh6Ul4bIUoa1egYUqU8FTL
         HKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698355380; x=1698960180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N16opPDMh2MtQdZI6n+iYWwhhV2tySRlDoDMCXghPSg=;
        b=Ry1wt/efyPgIO2s4uLDLuOE+4U3xqyFnzBG5JM2UDh52pub8km+si6t1GemJkKOc7z
         wmIdHkauqVnTboVmvtCaFYCprZDD8zRXnlVvqF5sKzxUvR+hL6BWqAZERmPqUqCMkH3R
         VwBHnmieIA4fvnzCD//WCj8ZHjbBEEIkmJgEhG3I4G25bD37cBKI0J3ELT83SAnzVVdZ
         I5McJNVPt3k8BmvdHPeNA8qgemYx8LXSAEbI7TdDbUTh4SbyC560SiaiEjxUcOcoOxZp
         I+KxtsvKjrI8Ap6pRcZlyGBvviKf0a3PwbwuRNR0XJ/YADwn+uRuyNNAWZ0PrLdVTn0b
         +Zpw==
X-Gm-Message-State: AOJu0Yz6u1WBYQTaBHmJYEYnKRBuCvQ021PghCyQawHI9gQ1uWyh4att
        Paj24BlIRFrlLuWw1+fo7XumsudQ/WA=
X-Google-Smtp-Source: AGHT+IF/OE8Q5YRB4aDY0tUe8C3rqxSvK3ckwmqPiqpkJm2RHeMEZkjbXTXdwikBk2kuBbypqgWBiHzlcPg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d443:0:b0:5a8:6397:5bd6 with SMTP id
 w64-20020a0dd443000000b005a863975bd6mr15531ywd.3.1698355380052; Thu, 26 Oct
 2023 14:23:00 -0700 (PDT)
Date:   Thu, 26 Oct 2023 14:22:58 -0700
In-Reply-To: <20231026204810.chvljddk6noxsuqi@desk>
Mime-Version: 1.0
References: <20231025-delay-verw-v3-0-52663677ee35@linux.intel.com>
 <20231025-delay-verw-v3-6-52663677ee35@linux.intel.com> <ZTq-b0uVyf6KLNV0@google.com>
 <20231026204810.chvljddk6noxsuqi@desk>
Message-ID: <ZTrYsls7ya5yOdSV@google.com>
Subject: Re: [PATCH  v3 6/6] KVM: VMX: Move VERW closer to VMentry for MDS mitigation
From:   Sean Christopherson <seanjc@google.com>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>, tony.luck@intel.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023, Pawan Gupta wrote:
> On Thu, Oct 26, 2023 at 12:30:55PM -0700, Sean Christopherson wrote:
> > >  	if (static_branch_unlikely(&vmx_l1d_should_flush))
> > >  		vmx_l1d_flush(vcpu);
> > 
> > There's an existing bug here.  vmx_1ld_flush() is not guaranteed to do a flush in
> > "conditional mode", and is not guaranteed to do a ucode-based flush
> 
> AFAICT, it is based on the condition whether after a VMexit any
> sensitive data could have been touched or not. If L1TF mitigation
> doesn't consider certain data sensitive and skips L1D flush, executing
> VERW isn't giving any protection, since that data can anyways be leaked
> from L1D using L1TF.

That assumes vcpu->arch.l1tf_flush_l1d is 100% precise and accurate, which is most
definitely not the case.  You're also preventing the admin from choosing between
being super paranoind (always flush L1D) and mostly paranoid (conditionally flush
L1D, always flush CPU buffers).

AIUI, flushing the L1D is crazy expensive compared to flushing the CPU buffers,
so it's entirely plausible for someone to want to choose the mostly paranoid
option.

Side topic, isn't the NMI path missing a call to kvm_set_cpu_l1tf_flush_l1d()?

> > 	/*
> > 	 * The MMIO stale data vulnerability is a subset of the general MDS
> > 	 * vulnerability, i.e. this is mutually exclusive with the VERW that's
> > 	 * done just before VM-Enter.  The vulnerability requires the attacker,
> > 	 * i.e. the guest, to do MMIO, so this "clear" can be done earlier.
> > 	 */
> > 	if (static_branch_unlikely(&mmio_stale_data_clear) &&
> > 	    !cpu_buffers_flushed && kvm_arch_has_assigned_device(vcpu->kvm))
> > 		mds_clear_cpu_buffers();
> 
> This is certainly better, but I don't know what scenario is this helping with.

Heh, that's host I feel about moving VERW to just before VM-Enter.  I have a hard
time believing there's meaningful sensitive that's accessed in __vmx_vcpu_run().
The closest thing is probably CR2, but that's a very dubious vector since CR2 will
hold a guest value for most VM-Enters.

I'm not against moving VERW close to VM-Enter because it's relatively straightforward,
but if we're going to be super paranoid, why not go all the way and not have to
worry about what ifs?

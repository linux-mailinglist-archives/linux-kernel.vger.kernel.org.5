Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3286B760154
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGXVkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjGXVkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:40:08 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC8810D9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:40:06 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bb83eb84e5so22995915ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690234805; x=1690839605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8BXNvlgPl86R5u1hRBm87aT1u2p7UCsAkEmDEcFG3FM=;
        b=WQVwrhACND8PT5c7alEIYasKcI4Gp7ux8sDxSBc+Z2bJbXkeTQ5jBOUHXIeOX7mlDT
         IA9pzFYjQzEITJml3F0PjSrEsUo05ZsNqrb8ZwrdQPd0nMVfILzegzYolD0BGNic81Gz
         s/fdxjhr9ssohjwdFcYBZFpTEIY+Cqf0ZgzvRQr8pLNrIFSvHblY82xsimwQ5Hoxpxag
         ZEchK0cmfSc5EC0KjP2jeYQcYdm/+0G52yT8+C/fGHF0OSFhlgDympjozQGmHyuKGxkf
         fMrqX+sFQNcqhs5SEIEVfG4p8fZpQ9QGuGj6l2J8Jvr1lkwN+TT1rHadFW5PB+D/1gaQ
         ICdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234805; x=1690839605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BXNvlgPl86R5u1hRBm87aT1u2p7UCsAkEmDEcFG3FM=;
        b=MZASTdlhsFhirLEjvad3v73hXYabIfBa5+U6uw3k7JQcm3c0hiTe1DZb/T4bkXg/zd
         +a8F3GN8xLf4naHdmYI8cgpluGhookkSXKOMg+s4X8+3JaHspmYtP4oDypAR+/gqpcyi
         Zxn6k3RssJpbirqyEsZy7p6r8sQIbR1bDCldsIGBpNVaC/aA03W9iwzivaNZtjuJWBSZ
         KKuP5x1B4wwdBEjQyxENPf4WDZ5Kqs4SS+SHS1rZGFDZs4JC1NjHDdsC29AEdVQL5P9Q
         oYvU0hoavWftdkrVajiKlUqg3ED2JYVqsYCFPh6aAjI8CspqZag/avs8yuvD3pFSvQ9w
         uyow==
X-Gm-Message-State: ABy/qLbvRnyMmFGiVSwsF51Qi/o8n75TQkLN66+8pEVYBDB/iaBEakId
        p1Zr7YPdH38y7PGv8Eag0jlMTWSruU0=
X-Google-Smtp-Source: APBJJlGr3Xi9CBngHaiIYWxM1PJJW9h3BT6/cv5dUH1y6ZztFyeHVEzhLcBu5fYxBfWr79u2kv7wLBA+Mcw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:32c3:b0:1b9:e338:a90d with SMTP id
 i3-20020a17090332c300b001b9e338a90dmr44909plr.3.1690234805271; Mon, 24 Jul
 2023 14:40:05 -0700 (PDT)
Date:   Mon, 24 Jul 2023 14:40:03 -0700
In-Reply-To: <20230724212150.GH3745454@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
References: <20230721201859.2307736-1-seanjc@google.com> <20230721201859.2307736-15-seanjc@google.com>
 <20230724212150.GH3745454@hirez.programming.kicks-ass.net>
Message-ID: <ZL7vs9zMatFRl6IH@google.com>
Subject: Re: [PATCH v4 14/19] KVM: SVM: Check that the current CPU supports
 SVM in kvm_is_svm_supported()
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
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

On Mon, Jul 24, 2023, Peter Zijlstra wrote:
> On Fri, Jul 21, 2023 at 01:18:54PM -0700, Sean Christopherson wrote:
> > Check "this" CPU instead of the boot CPU when querying SVM support so that
> > the per-CPU checks done during hardware enabling actually function as
> > intended, i.e. will detect issues where SVM isn't support on all CPUs.
> 
> Is that a realistic concern?

It's not a concern in the sense that it should never happen, but I know of at
least one example where VMX on Intel completely disappeared[1].  The "compatibility"
checks are really more about the entire VMX/SVM feature set, the base VMX/SVM
support check is just an easy and obvious precursor to the full compatibility
checks.

Of course, SVM doesn't currently have compatibility checks on the full SVM feature
set, but that's more due to lack of a forcing function than a desire to _not_ have
them.  Intel CPUs have a pesky habit of bugs, ucode updates, and/or in-field errors
resulting in VMX features randomly appearing or disappearing.  E.g. there's an
ongoing buzilla (sorry) issue[2] where a user is only able to load KVM *after* a
suspend+resume cycle, because TSC scaling only shows up on one socket immediately
after boot, which is then somehow resolved by suspend+resume.

[1] 009bce1df0bb ("x86/split_lock: Don't write MSR_TEST_CTRL on CPUs that aren't whitelisted")
[2] https://bugzilla.kernel.org/show_bug.cgi?id=217574

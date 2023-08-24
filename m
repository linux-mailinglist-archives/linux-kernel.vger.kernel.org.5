Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2364178731F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbjHXPAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241995AbjHXPAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:00:08 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902721BE7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:00:04 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-563ab574cb5so7381581a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692889204; x=1693494004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qsu60wTG8AVkLDYq+gXQfYDEyCx9N3ghgdVFvKqavKw=;
        b=Y2f43sSu1xbW9I4if4DDu1HhOslQy8QKrSlegj752bgJM4thRpMDiYB66AaVmruiaU
         O7oLvdvEw7V+6Y7mczElBrJ53+kLu+mMW6z/cRyOHxpU64uI53flTuz3o57FMef8W1uK
         Xn43rAbMfQA3uzjJ223aweuQ/O6rkwaL3q8Cn7SK4OQGlCL7z/jv29kIGCYcZ4UcJMir
         V0YEE4GqnnrUIh+rmCUEyr7/maxBdPDdWB74HeGDTb3GMgfLzLCYyQU1kYftPal9HA6F
         bWrxZYHya5IWUYl3uykhVIhqEmurOREb2NqTELjN/pQmMN4UbtBWE7JTP7X1v+NxXzvt
         LFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692889204; x=1693494004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qsu60wTG8AVkLDYq+gXQfYDEyCx9N3ghgdVFvKqavKw=;
        b=GKb34QrcLWHUEUiDSkv3q8pSiX1IQejSnedLR8zGYeIt0BsNqZoIY6ofctWoN0DIXJ
         3IsUXpp8bzN9wuBzW2E0OAhciZ5CdasiLbS1GJgmLR+mEa1AmvrYrQB3XiRkI9kcMnzB
         769aiN7x/ceQXXVKk+XJ0KKECX1eD4c3uj081LcSbbddW5tmc9ElXi0wsIsMADKJqrRk
         4w7BmBbCHG251DJqWDc0D+A4q2Ui+54nUbuluClQgpx36m6RMKY45AK+wEEu3EcUBXi+
         8icRDxfgFPWXkPDyJfWqDCSesNiHSvPG70uwrggC6XVlGeabxboTVFo8PB5TPD1pWA2t
         unkw==
X-Gm-Message-State: AOJu0Yx5MvIeE/mQXpPxvi3/axYuvj0ACk4c6eyPIgS/ndj4AHr6wrRK
        w9qQqiDyYx0YTDj2scLW2eesFt85XiU=
X-Google-Smtp-Source: AGHT+IHbW/tvpDFMlAKxJ339o5wxxroXUvlUg85wo3s3hE8PuqSOrXLNVMrkUcL65C45EHyPEIY3cUnUwes=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:6f86:0:b0:56c:50c0:fbad with SMTP id
 k128-20020a636f86000000b0056c50c0fbadmr1782203pgc.8.1692889203873; Thu, 24
 Aug 2023 08:00:03 -0700 (PDT)
Date:   Thu, 24 Aug 2023 08:00:01 -0700
In-Reply-To: <7f9587ed-36af-4cfe-3699-45ceb63b15c6@grsecurity.net>
Mime-Version: 1.0
References: <20230824010512.2714931-1-seanjc@google.com> <ZOavFlKo2/sixUTk@google.com>
 <7f9587ed-36af-4cfe-3699-45ceb63b15c6@grsecurity.net>
Message-ID: <ZOdwccVcfl+CH6+k@google.com>
Subject: Re: [PATCH 5.15] Revert "KVM: x86: enable TDP MMU by default"
From:   Sean Christopherson <seanjc@google.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
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

On Thu, Aug 24, 2023, Mathias Krause wrote:
> On 24.08.23 03:15, Sean Christopherson wrote:
> >> This reverts commit 71ba3f3189c78f756a659568fb473600fd78f207.
> >>
> >> Link: https://lore.kernel.org/all/ZDmEGM+CgYpvDLh6@google.com
> >> Link: https://lore.kernel.org/all/f023d927-52aa-7e08-2ee5-59a2fbc65953@gameservers.com
> >> Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> >> Cc: Mathias Krause <minipli@grsecurity.net>
> >> Signed-off-by: Sean Christopherson <seanjc@google.com>
> >> ---
> >>  arch/x86/kvm/mmu/tdp_mmu.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> >> index 6c2bb60ccd88..7a64fb238044 100644
> >> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> >> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> >> @@ -10,7 +10,7 @@
> >>  #include <asm/cmpxchg.h>
> >>  #include <trace/events/kvm.h>
> >>  
> >> -static bool __read_mostly tdp_mmu_enabled = true;
> >> +static bool __read_mostly tdp_mmu_enabled = false;
> >>  module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0644);
> >>  
> >>  /* Initializes the TDP MMU for the VM, if enabled. */
> >>
> >> base-commit: f6f7927ac664ba23447f8dd3c3dfe2f4ee39272f
> >> -- 
> 
> Acked-by: Mathias Krause <minipli@grsecurity.net>
> 
> I guess this means no hope for
> https://lore.kernel.org/stable/234e01b6-1b5c-d682-a078-3dd91a62abf4@grsecurity.net/
> :/

Ya, not going to happen, sorry :-(

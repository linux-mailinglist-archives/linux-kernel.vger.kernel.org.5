Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D216B7793C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjHKQDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjHKQDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:03:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CAA270E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:03:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d66af3c8ac7so961780276.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691769800; x=1692374600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QicQJOjgKiKxRkWAIMkdNTxOHsl5Eu2cMoQS7IuOwSg=;
        b=vryuFQCyes4h26kYwko7fb7ZPaHOi9ZTZZmdOlBsPUU5YTqwe8xp6L4IWHJY0E/WbR
         IBExdw6x3z0OltjlQ9M6j6An/MhX6XMATLPZK+RKbbtO2WOidd+LCXQlQ1R0PBvCyFKT
         tE6uOig5U94yBGQrNy8+vRdsvmWnXHUYcdUtzhG75sOtA5hPtiAfMFBAG4CO92BInMLq
         3shoLMyip80G9w4crpPnW8U2SFeeEgTJIaBcdVxj1Qj0jvWZKcP832P8PQQCHg+J0sI+
         DV2nbpn+r1seM3WbR6yrQq2TwRa16toZfi1xTDIEkict4f/NO/7YymUrnE0x4tPTo0L+
         3M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769800; x=1692374600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QicQJOjgKiKxRkWAIMkdNTxOHsl5Eu2cMoQS7IuOwSg=;
        b=CCCf3VkKhbWI7Z7xsl/TKJCYwQIsbaCNWEjG9bAgj7CheZst31XVFQj/g7ER92xoi0
         ve//OpwwYaj+D9AgMk12TtaLBtTH63M5wfrUL4cgo7TjgBe9vT1SbjOFu0sVAGr/6rDo
         ddv7NfJbeoXRmRjRZED8vgL5BjgO5cKlKnlEma95Hiql+4z7UbNP+ectJqLi0WpW2o1N
         GzYoPg43U5BUc/ZJXPkTq9CKKEe7BfTIZ/ElbYU1IaUmco3pno15u3T8rzrZ90y6v5KE
         adqAP63MY/d/jpiAfb0r8jbjICFNju2KSCriZvQFsBFmCU3K8UIrcM4V9FaM5A/9GX0F
         2bMQ==
X-Gm-Message-State: AOJu0YwhBnm/n7DQB8GrG0760j8U6w5gFb16+kiRCdGfWhMZU/1snXn9
        DBLrWj2X7RoCqjM2VLUTZaA6V2jDfuI=
X-Google-Smtp-Source: AGHT+IH/0S0tZVg7nutYPISR/350fmANEZNBDNDpLeLf48SQ6mV0KbhkYUQOH6L1xSH30hdOAKnWDqRIXyM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:b097:0:b0:cb1:918b:d19b with SMTP id
 f23-20020a25b097000000b00cb1918bd19bmr41895ybj.0.1691769800394; Fri, 11 Aug
 2023 09:03:20 -0700 (PDT)
Date:   Fri, 11 Aug 2023 09:03:18 -0700
In-Reply-To: <20230811140941.GB193223@dev-arch.thelio-3990X>
Mime-Version: 1.0
References: <20230810132706.GA3805855@dev-arch.thelio-3990X>
 <20230810133216.GKZNTm4KpohRR4gVsT@fat_crate.local> <20230810134056.GA130730@dev-arch.thelio-3990X>
 <20230810144344.GLZNT3oM6MLVdzGlyd@fat_crate.local> <20230810150706.GA42856@dev-arch.thelio-3990X>
 <20230810151410.GNZNT+wn/cLBWiU6dO@fat_crate.local> <20230810154831.GA38495@dev-arch.thelio-3990X>
 <20230810161414.GA4000@dev-arch.thelio-3990X> <20230811101456.GDZNYKIHs1k7ri8hrI@fat_crate.local>
 <20230811140941.GB193223@dev-arch.thelio-3990X>
Message-ID: <ZNZbxhL5ZJD1Sd9P@google.com>
Subject: Re: Hang when booting guest kernels compiled with clang after SRSO mitigations
From:   Sean Christopherson <seanjc@google.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Fri, Aug 11, 2023, Nathan Chancellor wrote:
> On Fri, Aug 11, 2023 at 12:14:56PM +0200, Borislav Petkov wrote:
> > On Thu, Aug 10, 2023 at 09:14:14AM -0700, Nathan Chancellor wrote:
> > > Not sure how helpful that will be...
> > 
> > Yeah, not really. More wild guesses: if you uncomment the UNTRAIN_RET in
> > __svm_vcpu_run() on the host, does that have any effect? Diff below.
> 
> Unfortunately, that seems to make no difference...
> 
> I did have to switch to the Ryzen 3 box for testing, as I am not at home
> for a couple of days and I did not want to lose access to my workstation
> if I took a bad update since it has no remote management capabilities.
> Something I noticed in doing so is that the VM boot on that machine
> appears to get farther along than on my Threadripper 3990X, but I still
> see a hang with a stack trace similar to the one that I reported in the
> initial post with '-smp 2', so I think it is the same problem but
> perhaps the more cores the VM has, the more likely it is to appear
> totally hung? Might be a red herring but I figured I would mention it in
> case it is relevant.

Might be the flags bug that borks KVM's fastop() emulation.  If that fixes things,
my guess is that bringing APs out of WFS somehow triggers emulation.

https://lore.kernel.org/all/20230811155255.250835-1-seanjc@google.com

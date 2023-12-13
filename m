Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB70811A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjLMRBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMRBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:01:14 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2319B9C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:01:21 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcdcc99e29so264614276.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702486880; x=1703091680; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tBbCvvAbfrdh23iT+WwFecyH8e6C96pOJEulkEptHYE=;
        b=f3YD/9f2F1vfPHFmM9wYBfYZFdwfWMm+ekF8Km1XgAbVEEzPJdSmTPFWRO6rkUqiRx
         3isrpcBEc0R5vgiCikWWCeVy7ZnM24qlbfKxa5/Wu1rEvv2ha5UiKOfEVtwkj1hXWJnc
         JX67IZrZbK3EaNsDHByAozeDi0+nDvG6zOy46YIfNFU+VHQrH99HcJpkEatWJ4c4mSMX
         Yq9QIa7bjn/58FG0gBFe0TzUAvXI8DKfvFRdfrqcZ+w4x/XpiQSRqccOcwFlnQ9n+Sep
         xx8XQAmxHivLYV51Qwm+v5zezjoPYeBiAYBn1OFnlwMM2RAuzwJI7V75NLv0Biozr1NH
         +RnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486880; x=1703091680;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBbCvvAbfrdh23iT+WwFecyH8e6C96pOJEulkEptHYE=;
        b=u+8+ibRZ6IJFfuRRyaXxzrZrLtklg/hULEO3HfDHxW+Lk25DD2zVzGlmHa5dUiawGD
         q+9/TVMdet4cY+/q8po9GCjBAZfoW+R+bOBYXCffAB6YU6cEG95nLA7ojDFEynqFN97J
         XkwhrfbOorXeNxYEWu+6+qrgkwFkODo97iIcBYQS9QVCkpJmhuzVy8NIza3MgPR0j6BE
         fO0+eRB1KrAHyMXqLx2/8d6Ozvrwt1/pj+DKguB+e2+RZjsKTOeonaJfWXHYKu5S4eKV
         YZChX8TImrwKTervAv7wFLEiS6T1oTWUInBtYse2KnziizHVBaiedFwN/wxUcDDO7wmU
         z3Sg==
X-Gm-Message-State: AOJu0YzGEEf43WFgXbC8B6wtdssgikpL97cQGs40L8OP4+HEqHZU45vR
        sd5TMlVpu88ucss9RbvAv29HBQQmZ8M=
X-Google-Smtp-Source: AGHT+IEyZ+uONV8Dhhp5xu8cUqXpYmvSlrh5N8bZOFr3e6ylPDRYbfi5xXr7UbRWLhU/SyrWbxX3k3h8RAw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:14d:b0:db5:3aaf:5207 with SMTP id
 p13-20020a056902014d00b00db53aaf5207mr135703ybh.3.1702486880334; Wed, 13 Dec
 2023 09:01:20 -0800 (PST)
Date:   Wed, 13 Dec 2023 09:01:18 -0800
In-Reply-To: <0591cb18-77e1-4e98-a405-4a39cfb512e1@gmail.com>
Mime-Version: 1.0
References: <20231206032054.55070-1-likexu@tencent.com> <6d3417f7-062e-9934-01ab-20e3a46656a7@oracle.com>
 <0591cb18-77e1-4e98-a405-4a39cfb512e1@gmail.com>
Message-ID: <ZXnjXuLXl4mfVUJC@google.com>
Subject: Re: [PATCH v2] KVM: x86/intr: Explicitly check NMI from guest to
 eliminate false positives
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Dongli Zhang <dongli.zhang@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Dec 13, 2023, Like Xu wrote:
> 
> 
> On 13/12/2023 3:28 pm, Dongli Zhang wrote:
> > Hi Like,
> > 
> > On 12/5/23 19:20, Like Xu wrote:
> > > From: Like Xu <likexu@tencent.com>
> > > 
> > > Explicitly checking the source of external interrupt is indeed NMI and not
> > > other types in the kvm_arch_pmi_in_guest(), which prevents perf-kvm false
> > > positive samples generated in perf/core NMI mode after vm-exit but before
> > > kvm_before_interrupt() from being incorrectly labelled as guest samples:
> > 
> > About the before kvm_before_interrupt() ...
> > 
> > > 
> > > # test: perf-record + cpu-cycles:HP (which collects host-only precise samples)
> > > # Symbol                                   Overhead       sys       usr  guest sys  guest usr
> > > # .......................................  ........  ........  ........  .........  .........
> > > #
> > > # Before:
> > >    [g] entry_SYSCALL_64                       24.63%     0.00%     0.00%     24.63%      0.00%
> > >    [g] syscall_return_via_sysret              23.23%     0.00%     0.00%     23.23%      0.00%
> > >    [g] files_lookup_fd_raw                     6.35%     0.00%     0.00%      6.35%      0.00%
> > > # After:
> > >    [k] perf_adjust_freq_unthr_context         57.23%    57.23%     0.00%      0.00%      0.00%
> > >    [k] __vmx_vcpu_run                          4.09%     4.09%     0.00%      0.00%      0.00%
> > >    [k] vmx_update_host_rsp                     3.17%     3.17%     0.00%      0.00%      0.00%
> > > 
> > > In the above case, perf records the samples labelled '[g]', the RIPs behind
> > > the weird samples are actually being queried by perf_instruction_pointer()
> > > after determining whether it's in GUEST state or not, and here's the issue:
> > > 
> > > If vm-exit is caused by a non-NMI interrupt (such as hrtimer_interrupt) and
> > > at least one PMU counter is enabled on host, the kvm_arch_pmi_in_guest()
> > > will remain true (KVM_HANDLING_IRQ is set) until kvm_before_interrupt().
> > 
> > ... and here.
> > 
> > Would you mind helping why kvm_arch_pmi_in_guest() remains true before
> > *kvm_before_interrupt()*.
> > 
> > According to the source code, the vcpu->arch.handling_intr_from_guest
> > is set to non-zero only at kvm_before_interrupt(), and cleared at
> > kvm_after_interrupt().
> > 
> > Or would you mean kvm_after_interrupt()?
> 
> Oops, it should refer to kvm_after_interrupt() as the code fixed. Thank you.

No need for another version if that's the only hiccup, I can fixup when applying.

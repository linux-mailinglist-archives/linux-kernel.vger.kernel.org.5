Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F52E7D1964
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjJTW4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjJTW4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:56:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADFCD7A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:56:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a828bdcfbaso19324557b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697842603; x=1698447403; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wuE33JR6uRipbrn8kdzQrSZIpZ8wHAHfWDfHw4x2Go=;
        b=3eiPf0+PzGX70YmdaODsJ7bUJcU5w32j2jYgh+cKURMXGAIAINfIhjWo3wNpHiuOKU
         n3kYQKQzu3kdVN6NaK4cgmiOWB/3AxA54FOoJeNxYxHDqqFVAAOUmyHCCI//o12qUWwM
         GH2ZowGMd86tZgR7nmTQCKDrriMqZ4db2LZey1LrWk6mEdJTlklJYIFDQCSf5sI016sn
         IZnH0lkNj9b6WNBj62rvhPIFHLnftqivD+/D4stFxmPsSDknzKN7kcXwWKS698Rexssb
         31RGCYxVgbpNrmk6v2LwSOr0BkA7akwT40U64edruA0I9Z0oopvqP+9n6Iv118xsjJnD
         RAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697842603; x=1698447403;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wuE33JR6uRipbrn8kdzQrSZIpZ8wHAHfWDfHw4x2Go=;
        b=DJbt7oPcG8C4EyyASyDUujbx8G9aydBnGaFkd1QSYxDVptcl4/mGrGnSDIrhmCBAUU
         LzH7CDS8TdIYX5e++J94orzIYiCbJ4KTgjTwNpWf6UJ/p8ul6GL6EaS7zZOWKghO5C44
         LLCghQzJ6rX7FwiDPoCEJY6dkSmLKDTWuBqwCLx9pqmQe/KEELMLR+6WSSo8FWSA9788
         ch6i46bkAn80BtN4P7Dpj1LQJhgwCFTVajf+tSCOVaJUlJe5m25wLxxrgKWT/I6tyVkb
         Q850AC0CKfiGzkK5S0aS43pDs1+XylmnzjxNNHK2skfrtSh3AZHdR9bImDSeTFJY1WF+
         8hOg==
X-Gm-Message-State: AOJu0Yzl5kCe5agBFuQzFDNzGCqj5A4yv+2la8lZj57ElcD92WkHlC8S
        TLpi4IP8YhNGtiMtVSaqqp4HNxxZugc=
X-Google-Smtp-Source: AGHT+IEFeC6rrkwTpPozE6wC3tZ7yqN0ETi+88hv8Jirws+BdHPbVzuw5siyvgARe8gtQf5TRxiGRXB9Rjk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:dd10:0:b0:577:619e:d3c9 with SMTP id
 g16-20020a0ddd10000000b00577619ed3c9mr80276ywe.10.1697842603528; Fri, 20 Oct
 2023 15:56:43 -0700 (PDT)
Date:   Fri, 20 Oct 2023 15:56:21 -0700
In-Reply-To: <20231005031237.1652871-1-jmattson@google.com>
Mime-Version: 1.0
References: <20231005031237.1652871-1-jmattson@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <169766229957.1906201.16765121392662291005.b4-ty@google.com>
Subject: Re: [PATCH v2] x86: KVM: Add feature flag for CPUID.80000021H:EAX[bit 1]
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2023 20:12:37 -0700, Jim Mattson wrote:
> Define an X86_FEATURE_* flag for CPUID.80000021H:EAX.[bit 1], and
> advertise the feature to userspace via KVM_GET_SUPPORTED_CPUID.
> 
> Per AMD's "Processor Programming Reference (PPR) for AMD Family 19h
> Model 61h, Revision B1 Processors (56713-B1-PUB)," this CPUID bit
> indicates that a WRMSR to MSR_FS_BASE, MSR_GS_BASE, or
> MSR_KERNEL_GS_BASE is non-serializing. This is a change in previously
> architected behavior.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] x86: KVM: Add feature flag for CPUID.80000021H:EAX[bit 1]
      https://github.com/kvm-x86/linux/commit/329369caeccb

--
https://github.com/kvm-x86/linux/tree/next

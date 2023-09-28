Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AFD7B1F12
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjI1N6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjI1N6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:58:00 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781BF19D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:57:58 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-533c5d10dc7so12611872a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695909477; x=1696514277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqzYMI+5dukgNJTTKsc8LJCDP3hbv8tZckRPxqjHqco=;
        b=GpKqzV5m7XqEREKROum+IrFTJf1W1mQFGkSPXGXjsAIMv5cGNC8fyVBNjA1mWr4mSR
         em918z2aSmrmjRBM3gX+HSeC4XWzAkQhdm/PD7BeP43ZMphp7MxkcBdcHe19U90F2M25
         b9jkVhd+1fhhXvf/TcJWIFfHL93qOW/IBFsy1W0wlOsJC3rj1CZtSf3RwNHD2n+ws14X
         YOlJicVSXHaI1aW3pF3dSYDuZNzC3zGRdfd+MrRyh9F1BAGNtYfDOG2YFvkJolqkk06s
         Esi6hf2Q/YRD6jXBlW7xAFJbLDcGsYW0VfdEtpXvgVtOBV+jp2AQnXF7Fdy9klbc7W1W
         ZbFg==
X-Gm-Message-State: AOJu0YwHVbRoS2eJKKdQM/cHrmT+a8qUndnlbJjv22zVCUJCAfvn+qAO
        b0Ah9FgPwreEQPmWKns++7I=
X-Google-Smtp-Source: AGHT+IHJj+Pz14F3xHhdOuqhvuYTpa/XpWu7y2ylvMhcDuB8PxO8ADoeLCQpis6ZAcaXEPavZDYdYw==
X-Received: by 2002:aa7:d451:0:b0:530:bd6b:7a94 with SMTP id q17-20020aa7d451000000b00530bd6b7a94mr1482581edr.24.1695909476656;
        Thu, 28 Sep 2023 06:57:56 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-019.fbsv.net. [2a03:2880:31ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id q19-20020a056402041300b005330e1e7da0sm9603208edv.92.2023.09.28.06.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 06:57:56 -0700 (PDT)
Date:   Thu, 28 Sep 2023 06:57:54 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/bugs: Add a separate config for each mitigation
Message-ID: <ZRWGYn4Y+2v/S6Ar@gmail.com>
References: <20230628142129.2468174-1-leitao@debian.org>
 <ZRV1bIuSXjZ+uPKB@gmail.com>
 <a5fbcf09-2445-28f1-4113-0de4f72b7f90@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5fbcf09-2445-28f1-4113-0de4f72b7f90@intel.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 06:40:18AM -0700, Dave Hansen wrote:
> On 9/28/23 05:45, Breno Leitao wrote:
> > 1) Create one Kconfig entry per mitigation, so, the user can pick and
> > choose what to enable and disable. (Version 3 of this patch. May need a
> > re-spin due to the new mitigations being added.)
> 
> This means, what, roughly 18 today?
> 
> #define X86_BUG_CPU_MELTDOWN		X86_BUG(14)
> ...
> #define X86_BUG_GDS                     X86_BUG(30)
> 
> Plus two bonus ones:
> 
> #define X86_BUG_SRSO                    X86_BUG(1*32 + 0)
> #define X86_BUG_DIV0                    X86_BUG(1*32 + 1)
> 
> ... and we've slowed down the rate at which we're adding these, but
> we're still seeing a couple a year.
> 
> Perhaps Pawan and the others actually _doing_ the patches for these can
> speak up, but I don't think adding a Kconfig option will be too much
> additional work for each new X86_BUG.
> 
> I still think it's highly unlikely that someone will come through and
> pick and choose among a few dozen vulnerabilities.

That is what my experience tells me as well. You either have a insecure
and fast kernel, or a hardened one. In some big companies, you can have
both, and choose which one you want to boot depending on the workload.

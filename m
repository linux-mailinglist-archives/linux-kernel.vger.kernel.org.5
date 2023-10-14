Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C809D7C9410
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjJNKE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjJNKE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:04:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0193FB3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 03:04:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a9f139cd94so463607366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697277864; x=1697882664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4aHVvs+T5FOHBa8J3aziokf4Z6rf553mjVWTzRAy90=;
        b=ffs7wENrCd+QG5Wo0o1C55GaJmBUbI6jmU5SDv4R5/W+XgORdeN5zxynl9oJ8l/h7D
         Tvq0AQ3saqyidB5tBSFQ1urYbC9fvrvPLBVNoKZKKo6qcx3OftY/gNBRXwkTJKSrtxMY
         y69f42Cguh74GUmGSgCZHhiV2ou/kfewyJO8yxn1hYB/w3K2PI2hO43qUykOfykMu/5d
         QWJRegaWY7S1Vht96AR1cQrX6BKafi0cBpVR+JcghYxhbuPB43pN4df0LLNq+6aOmFpg
         ja32Fmq1ag4hwmcIGqZg6eDHMbNCnG0tX6v8o5dfRKLnQnhB+zRqZgIjmbtIGEYN2T10
         Tz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697277864; x=1697882664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4aHVvs+T5FOHBa8J3aziokf4Z6rf553mjVWTzRAy90=;
        b=J728y+6A1vF4I4PycXD6/OS7psJnfAkSbx4uMwN5BhYfkDGWC0kSqJF5Vs8lJ/5y48
         ZH4cG7xlWE02XdtoFhXewvnMURkWiSIT34XsnQQyq6H4gtUFhqFf4xY1e0tjHA2nR9Vr
         QptZXLKI0Rg18M6PShr6AMKvXokhAyC4O7k7oSX5sXsHCxl2Hd626uxtSj5KW2XacQ/7
         maduTG3hrZPsQfmtKCVra4MuiFzCdihYBBoAMDEOPcLCTpGNkUYqR4qnhhgN1JfH/RG6
         jqnTMHXZnfjFe/5EdcwYxU8OpLEpjX6pJkcmxH97kxk6ov1CXpgDCEn+k1MpRaHRiOG4
         hCFg==
X-Gm-Message-State: AOJu0YwD8ixLYsKDrn4bxvAGdRk9Uc/Yg7AyiGvFqma0bVw+q4YYVg4X
        DxJOrV8msOBMpXhQaXrCXT4=
X-Google-Smtp-Source: AGHT+IHVebeuQOvhYnosEFnRL4nO2T0QOFdRGkbgGwu1cMNHQL4VAiBVH71ut8FyCEmZWn+TBFqK9A==
X-Received: by 2002:a17:907:6e9f:b0:9be:7dd3:40ab with SMTP id sh31-20020a1709076e9f00b009be7dd340abmr1449461ejc.2.1697277864201;
        Sat, 14 Oct 2023 03:04:24 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id mm12-20020a170906cc4c00b009b2ca104988sm728298ejb.98.2023.10.14.03.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 03:04:23 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 14 Oct 2023 12:04:21 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH tip] x86/percpu: Rewrite arch_raw_cpu_ptr()
Message-ID: <ZSpnpfn/mSYrgC9C@gmail.com>
References: <20231011204150.51166-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011204150.51166-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Uros Bizjak <ubizjak@gmail.com> wrote:

> Implement arch_raw_cpu_ptr() as a load from this_cpu_off and then
> add the ptr value to the base. This way, the compiler can propagate
> addend to the following instruction and simplify address calculation.
> 
> E.g.: address calcuation in amd_pmu_enable_virt() improves from:
> 
>     48 c7 c0 00 00 00 00 	mov    $0x0,%rax
> 	87b7: R_X86_64_32S	cpu_hw_events
> 
>     65 48 03 05 00 00 00 	add    %gs:0x0(%rip),%rax
>     00
> 	87bf: R_X86_64_PC32	this_cpu_off-0x4
> 
>     48 c7 80 28 13 00 00 	movq   $0x0,0x1328(%rax)
>     00 00 00 00
> 
> to:
> 
>     65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax
>     00
> 	8798: R_X86_64_PC32	this_cpu_off-0x4
>     48 c7 80 00 00 00 00 	movq   $0x0,0x0(%rax)
>     00 00 00 00
> 	87a6: R_X86_64_32S	cpu_hw_events+0x1328
> 
> The compiler can also eliminate redundant loads from this_cpu_off,
> reducing the number of percpu offset reads (either from this_cpu_off
> or with rdgsbase) from 1663 to 1571.
> 
> Additionaly, the patch introduces 'rdgsbase' alternative for CPUs with
> X86_FEATURE_FSGSBASE. The rdgsbase instruction *probably* will end up
> only decoding in the first decoder etc. But we're talking single-cycle
> kind of effects, and the rdgsbase case should be much better from
> a cache perspective and might use fewer memory pipeline resources to
> offset the fact that it uses an unusual front end decoder resource...

So the 'additionally' wording in the changelog should have been a big hint 
already that the introduction of RDGSBASE usage needs to be a separate 
patch. ;-)

Thanks,

	Ingo

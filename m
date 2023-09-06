Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D9F794612
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 00:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245003AbjIFWRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 18:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245004AbjIFWR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:17:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C433419B9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 15:17:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401da71b85eso3732575e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 15:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694038641; x=1694643441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kJZk/zxJ8Y7Q7IuqEMN7PRH78X9vNX0KyajRK/cje4=;
        b=FBzU1JS5i+S7/2Qk424w8pqH9GXBJ4Rviie4NkhQ2SQiVqHQeeBT/buBbHMEl4HXWr
         IAgicyQ5R8Ck35SruM32M4EJN1u/qu28/BKeuEBauwu6rODYjc6+1ZpDve1mq5+UUSYW
         r4eyQqDeCBL3L3Bk2MTGLbf2Jz7GZyOkpJL12+yI+sHj7h5zjbf0zhTywY2v0dq4Hheh
         UCL+xyaLdARN8Sxxd341Ms3VUJCskwZahCq80IWG/CTVJqvaRmGlUqSjFwCLajKWkHNl
         El6SDQ6znZIGWpCbRqxp+bXgiYXdwyV+CafVncineFDM/tEeZdI0oP0Gs0+Cln9JwCMB
         AZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694038641; x=1694643441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kJZk/zxJ8Y7Q7IuqEMN7PRH78X9vNX0KyajRK/cje4=;
        b=PTKtfmMb4URpBmX1MIlV9Wdci5WCEXBNP3LCbXKLYAE7Ea/17r2vq5mSSNlQ/+GHKn
         DaIrPnbSFz77EXcpxkq7P2sqZN5OzXjZ7dR3C5o7fK1ZUA2MGltytI4zn0MTuxur+IGl
         u3+fU3PoiMumyz+mkZSl2nKTfCezpQJ59yo5044wBOEgNk+dDE41+Q4Qo7Bs7G84wK0X
         esiDhNIVJqo0ygt6XPegwC9D4gjiVL9qc43x0fKgwPxY55PdYQ3+PfApjwtxuub7kEI5
         Zq4GPEfwv96JOdURaXSlMu11tiAtWOV+SApg37KheifFP/KCZmWDpNCCCu7slz3fnO7Q
         dCqw==
X-Gm-Message-State: AOJu0YwHBPZDsO17jKDgRPVxuFIuTx39hFpdtL36HbQzrCcYSfEhs9MI
        jk7hA7mTuPlAoxO6xodw5ns=
X-Google-Smtp-Source: AGHT+IHJJC5uKtljD2VBWtTEm7YvMae7iC7hBRdgGueHwMlBZL9p1q1sf6vFr/jkYDhDvQYKFPga7A==
X-Received: by 2002:a05:600c:21cd:b0:401:d803:6241 with SMTP id x13-20020a05600c21cd00b00401d8036241mr3298018wmj.21.1694038640925;
        Wed, 06 Sep 2023 15:17:20 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c3b9000b003fe407ca05bsm708181wms.37.2023.09.06.15.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 15:17:20 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 7 Sep 2023 00:17:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, Peter Anvin <hpa@zytor.com>
Subject: Re: [patch 1/2] x86/microcode/32: Move early loading after paging
 enable
Message-ID: <ZPj6biwRb30FKTyH@gmail.com>
References: <20230822121936.476984181@linutronix.de>
 <20230822121953.976548391@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822121953.976548391@linutronix.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> 32-bit loads microcode before paging is enabled. The commit which
> introduced that has zero justification in the changelog. The cover letter
> has slightly more content, but it does not give any technical justification
> either:
> 
>   "The problem in current microcode loading method is that we load a
>    microcode way, way too late; ideally we should load it before turning
>    paging on.  This may only be practical on 32 bits since we can't get to
>    64-bit mode without paging on, but we should still do it as early as at
>    all possible."
> 
> Handwaving word salad with zero technical content.
> 
> Someone claimed in an offlist conversation that this is required for curing
> the ATOM erratum AAE44/AAF40/AAG38/AAH41. That erratum requires an
> microcode update in order to make the usage of PSE safe. But during early
> boot PSE is completely irrelevant and it is evaluated way later.
> 
> Neither is it relevant for the AP on single core HT enabled CPUs as the
> microcode loading on the AP is not doing anything.
> 
> On dual core CPUs there is a theoretical problem if a split of an
> executable large page between enabling paging including PSE and loading the
> microcode happens. But that's only theoretical, it's practically irrelevant
> because the affected dual core CPUs are 64bit enabled and therefore have
> paging and PSE enabled before loading the microcode on the second core. So
> why would it work on 64-bit but not on 32-bit?
> 
> The erratum:
> 
>   "AAG38 Code Fetch May Occur to Incorrect Address After a Large Page is
>    Split Into 4-Kbyte Pages
> 
>    Problem: If software clears the PS (page size) bit in a present PDE
>    (page directory entry), that will cause linear addresses mapped through
>    this PDE to use 4-KByte pages instead of using a large page after old
>    TLB entries are invalidated. Due to this erratum, if a code fetch uses
>    this PDE before the TLB entry for the large page is invalidated then it
>    may fetch from a different physical address than specified by either the
>    old large page translation or the new 4-KByte page translation. This
>    erratum may also cause speculative code fetches from incorrect addresses."
> 
> The practical relevance for this is exactly zero because there is no
> splitting of large text pages during early boot-time, i.e. between paging
> enable and microcode loading, and neither during CPU hotplug.
> 
> IOW, this load microcode before paging enable is yet another voodoo
> programming solution in search of a problem. What's worse is that it causes
> at least two serious problems:
> 
>  1) When stackprotector is enabled then the microcode loader code has the
>     stackprotector mechanics enabled. The read from the per CPU variable
>     __stack_chk_guard is always accessing the virtual address either
>     directly on UP or via FS on SMP. In physical address mode this results
>     in an access to memory above 3GB. So this works by chance as the
>     hardware returns the same value when there is no RAM at this physical
>     address. When there is RAM populated above 3G then the read is by
>     chance the same as nothing changes that memory during the very early
>     boot stage. That's not necessarily true during runtime CPU hotplug.
> 
>  2) When function tracing is enabled, then the relevant microcode loader
>     functions and the functions invoked from there will call into the
>     tracing code and evaluate global and per CPU variables in physical
>     address mode. What could potentially go wrong?
> 
> Cure this and move the microcode loading after the early paging enable and
> remove the gunk in the microcode loader which is required to handle
> physical address mode.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Peter Anvin <hpa@zytor.com>
> Link: https://lore.kernel.org/lkml/1356075872-3054-1-git-send-email-fenghua.yu@intel.com
> ---
>  arch/x86/kernel/cpu/microcode/amd.c      |   31 +-------
>  arch/x86/kernel/cpu/microcode/core.c     |   40 ++---------
>  arch/x86/kernel/cpu/microcode/intel.c    |  108 +++----------------------------
>  arch/x86/kernel/cpu/microcode/internal.h |    2 
>  arch/x86/kernel/head32.c                 |    3 
>  arch/x86/kernel/head_32.S                |   10 --
>  arch/x86/kernel/smpboot.c                |   12 +--
>  7 files changed, 35 insertions(+), 171 deletions(-)

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Frankly, the general principle is that we should run as little Linux kernel 
code before paging is enabled as possible.

If a system is so broken that it requires a microcode update before it can 
even enable paging is IMO so terminally broken that it should be firmware 
patched at the factory (to have a proper microcode), or recalled from the 
market. It's not something we should make the kernel more fragile for.

Thanks,

	Ingo

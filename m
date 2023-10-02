Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63FF7B53C4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbjJBNMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237193AbjJBNMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:12:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3101AB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:12:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9adb9fa7200so687036466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 06:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696252358; x=1696857158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBXg/Y5zC2Ag38775wv7NWrf2d8CrOUkuj3/EMC7Rl4=;
        b=RltzSitRLGn3ipFhZqCwKHJ41qeHqUuTQyUfv027XEL3uzRaIKf12lxYq0BlNX/oW3
         3ZEARGmh+l25R8EdCG+WeFh1++dcMy5LXCTGwJeso/cv9Lg9feJUipHVEgfTld28zMtq
         XHHtU4PVD/ThUyob8KI7/blx1R7DkS1C9O+sCvxRToKlmNy0lPXhQeYLFkIFsOSg6DbR
         XdNMx4IaHg+/MSoiVadUoIcqdyS1E6iRpFjN/xI1GrnSVO4OpVcunaPCunpkPnYdf52i
         FWnaLiC4cN1EBngnuEIctQ6oTUm/+EWurnqU5MT7ZIg99DK5P1kZSZZqjYymwCES67tB
         Gg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252358; x=1696857158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBXg/Y5zC2Ag38775wv7NWrf2d8CrOUkuj3/EMC7Rl4=;
        b=U9psbwRzHLvb/GwS1fvweUfupcF7aKxX+b6wryBxXstP2OdTSMQo+BZcAbYKnKUj/e
         tXoKhT8ddUx/QM3KPsj3dFtljajzkA4X0ECnri3jjj6mDUPixG6JnMHKEnlv9t7PrzDT
         dYaNCrfqZ2pOYgtxeA0ujKwUCnOEFfaHL+r4K7m3e8TmuHXL+Fequ8m1Ff6S/5pr0I/r
         h5P7Uw4L0083xAa7VDmz9ssW/fEMzOcwkldX5kLzb1gbGo9AoqDpMnto0XCmQjYKKPlR
         cbREK+aaR3qeV52mJ6hl++cVuIQi6YfKbZ5KYF7xRVEHjwi1uve+WvW2QG/Adp0SBwb9
         +56w==
X-Gm-Message-State: AOJu0YyrH/x35o+7oeKd0bPBGIe7isBeO3aBTcUQju0Mg5tt0Cja48mM
        YJgGErMNIefRruml281r0uI=
X-Google-Smtp-Source: AGHT+IGbO8OfLSbWoEgknmgf15bFAvzUttnFFW78bDkkx8UO4bJr4fDSSnRdC7+y35+xdUwd/ZBwWA==
X-Received: by 2002:a17:907:2d88:b0:9ae:5879:78dd with SMTP id gt8-20020a1709072d8800b009ae587978ddmr11537387ejc.1.1696252357848;
        Mon, 02 Oct 2023 06:12:37 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id ce21-20020a170906b25500b009ad850d4760sm16887882ejb.219.2023.10.02.06.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 06:12:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 2 Oct 2023 15:12:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86_64: test that userspace stack is in fact NX
Message-ID: <ZRrBwwf4nUiTju8Z@gmail.com>
References: <4b78a714-5ac3-4783-8256-1dda4673db01@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b78a714-5ac3-4783-8256-1dda4673db01@p183>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Here is how it works:
> 
> * fault and fill the stack from rsp with int3 down until rlimit allows,
> * fill upwards with int3 too, overwrite libc stuff, argv, envp,
> * try to exec int3 on each page and catch it with either SIGSEGV or
>   SIGTRAP handler.
> 
> Note: trying to execute _every_ int3 takes 30-40 seconds even on fast
> machine, so only 1 int3 per page is tried.
> 
> Tested on F37 kernel and on custom kernel which did
> 
> 	vm_flags |= VM_EXEC;
> 
> to stack VMA.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  tools/testing/selftests/x86/Makefile   |    3 
>  tools/testing/selftests/x86/nx_stack.c |  167 +++++++++++++++++++++++++++++++++
>  2 files changed, 170 insertions(+)

Ok, that's a good idea, but could the test case please output something
human-readable that indicates whether the test was a success or not?

A typical testcase output is like:

  kepler:~/tip/tools/testing/selftests/x86> ./sigaltstack_32 
  [RUN]	Test an alternate signal stack of sufficient size.
	Raise SIGALRM. It is expected to be delivered.
  [OK]	SIGALRM signal delivered.

Or:

  kepler:~/tip/tools/testing/selftests/x86> ./test_vsyscall_64 
  ...
  [OK]	vsyscalls are emulated (1 instructions in vsyscall page)
  ...

... where the 'OK' denotes success of a test.

The nx_stack testcase only outputs:

  stack min 00007fffd75b5000
  stack max 00007fffd7db5000

... with only the exit code denoting success/failure.

Thanks,

	Ingo

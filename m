Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB957E9125
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 15:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjKLOTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 09:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLOTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 09:19:40 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A7B2D54
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 06:19:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2801d7f46f9so2984775a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 06:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699798777; x=1700403577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2x7te98qyLMcqqpUUp3QdWFkHj0fDiNUEndC2gQVTo=;
        b=Ir23/EU1O+12W0lOnexue5cYHlTTj8CaRLqaj+zUDl0NzeRYuk9+53jQ7rwjDurfr0
         0QQ7pWQez/iMBLIBx5BFuiHaQ+LFSUIshB82uLaEUPMt4/OQna3jRvCSwpJRo0gbXynX
         jxAzjuEGajFz0juv9Wv/e+wOZ3wcOxw9VagBTG9BC8yFYAPl41hR5qjwtfQ/Z+2kq6+G
         EsylGFrCVqTDx34ve+G9ICU//Ii4LP3qMEVkMm0ciM8UezU3rMnAYNCkAj2QXKZtYobz
         pxuoWoSPJnO7wgsUPjV+Zybl114jJ6UqFZRbsuLIArmS0O19VG8nKb3VN19tbd5LB3t0
         znrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699798777; x=1700403577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2x7te98qyLMcqqpUUp3QdWFkHj0fDiNUEndC2gQVTo=;
        b=OBibyyjEnV/zdtzrx1Meg2XDdcyJMZw9R2HuzxvM1UNT5wSUAoaBE7pJeFvn3YWA3z
         L05/uqtBSTkQghB1HYU7LAifu5YsZesVagxiJP47Lc76ySPJcL/ux6KpYX0+ek9JqGzZ
         tI+KQo4yw7xoYxzkCuqJt3eAyFVMUxnzpc8ZeTSjXtndl44goyNsMpv1j6YcM8irEGA8
         r0sdfhkC01J2q/3yMCK0bLSrHUKB1Syd1tw5g36qlfSjcYzPaGVIOk1qayKzhbX6NeAC
         ZYJk/P+os33z8VYkxG11HTYS5uNP9mPv2zlJ9ZSjPmZR59QxiwRyh5OZn20xUZWageGL
         0VNA==
X-Gm-Message-State: AOJu0Yxp4j0EnU4mWRy54+/w1msT9oYv++U8mw4lHMdJux0PgE5o80HW
        ZV1cQQRNM5AouddanUy3yCo=
X-Google-Smtp-Source: AGHT+IFs7vRYO/jBIOBCxjC6BPwaui3YL+LZjNHUb5A+HtKgGCC2hf1mCj5CKjsqS0s8MQ9QM+cOow==
X-Received: by 2002:a17:90b:1b46:b0:281:10d:6067 with SMTP id nv6-20020a17090b1b4600b00281010d6067mr2267502pjb.16.1699798777109;
        Sun, 12 Nov 2023 06:19:37 -0800 (PST)
Received: from [220.72.86.232] ([220.72.86.232])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902e54500b001c9bc811d59sm2600124plf.307.2023.11.12.06.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 06:19:36 -0800 (PST)
Message-ID: <1f6e21c1-7340-ed40-f2a7-66c063b453cb@gmail.com>
Date:   Sun, 12 Nov 2023 23:19:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqdesc: Fail check on early_irq_init allocation.
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        shjy180909@gmail.com, austindh.kim@gmail.com
References: <20231111170035.10386-1-p4ranlee@gmail.com>
 <87fs1bxe9h.wl-maz@kernel.org>
Content-Language: ko
From:   Paran Lee <p4ranlee@gmail.com>
In-Reply-To: <87fs1bxe9h.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-12 오후 11:00, Marc Zyngier wrote:

Thanks for the code review Marc!

I think function alloc_descs() in irqdesc.c has also alloc_desc() fail
handling, and there's kernel-wide code consistency checking for
allocation failures, and I thought it would be nice to mark it.
So that the code is aware of it.

Even if it panics with a null derefence reference.

> A failing allocation already results in a massive splat describing how
> the allocation failed. Further use of the NULL pointer will also
> result in a terminal oops, particularly if this happens this early in
> the boot sequence.
> 
> So what do these BUG_ON() calls buy us?
> 
> 	M.
> 

If anyone has any ideas on how to get a little fancier with the allocation,
I'll send a v2 patch in that direction.

BR
Paran Lee

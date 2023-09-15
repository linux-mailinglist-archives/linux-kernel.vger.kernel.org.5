Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90E27A1A98
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjIOJcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjIOJcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:32:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0DDCED
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:32:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31f7638be6eso1763603f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694770361; x=1695375161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HETKbupRhTYs1z9MLvczngFisFfV/0QzW50/Eiut1z4=;
        b=Bnw46qXMq1iYxHtxcTTCbMtt7WEZ5F0v7aKGClRfHgXsWh2oQhMgZdMuVhofIzycqP
         kWekxGcA9dKVuXTRb2ZTQHyuB6FD+mul1QmGvkaUv/aVIwJd5jKWI/iE+toTvZG0G8Ge
         AbeuPy9PH0+yvXbWRlSPoDkU5zHCuDdbEfrOQkERbkrFLBuFXvAVxogbIfJ5sJw28+QD
         yy6X6iXVB75hL20F67iXFg6hgBLeXnyfBve+bl5k4L5F2lbQekE5McYtb/xPPUTypDNR
         AXw6rntaw0m7nBbZ18ZSDTAtvA3MbYpuk513ke2Sm6xZ5pTqivksFNRq2en+VqkG42IC
         5PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694770361; x=1695375161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HETKbupRhTYs1z9MLvczngFisFfV/0QzW50/Eiut1z4=;
        b=mvQYq6moztmIph5zBPBeGhEiZkj+SJhP/TKpURd5+JqCiXeNotO1cZkQ2p9kjyg13K
         7trO0vL3C/1cWT/5bdvsNpqEfC1+7tX9/DGbtCwS+Zf5NRFTzDzaLlxQTTUgz1lLlIW7
         /31HXGawOOadH+BNKahYVVuPupXWHhtvxbXRr+R7OqvKMIfyaC1ECYvu2osgDcroKR4E
         O+sSNhFKOqskquZEISuFTkGF9bPT2VeDaQeJJu6u+upRDF+3i44QW5nzTBrweavIVZxv
         wTKBn4keXef1kGzGdqzYBcMxWuiQzIjauCQmPrfygkh7N7KIY9ffPW36lbaO4IUl8LES
         Ke5w==
X-Gm-Message-State: AOJu0YwjEu4/xbTZl8dAmJPHIa/zh9rxTpSsrdL/1bt8DNY0tYDvHO13
        ZeA6FzYV6K+LJCgH3d+oDE0=
X-Google-Smtp-Source: AGHT+IHCTwneR8c2SNEnOg6XrWMjyFnTAG+5GiPew/rJysjCFZm8QIppYR64TsM2ynWOerEhQPwQdA==
X-Received: by 2002:adf:f7c4:0:b0:31f:ea18:6f6b with SMTP id a4-20020adff7c4000000b0031fea186f6bmr1120906wrq.19.1694770361264;
        Fri, 15 Sep 2023 02:32:41 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d4cd2000000b0031762e89f94sm3902903wrt.117.2023.09.15.02.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:32:40 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 15 Sep 2023 11:32:38 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH v2] x86: Fix build of UML with KASAN
Message-ID: <ZQQkthfNuV3dOhZe@gmail.com>
References: <20230915-uml-kasan-v2-1-ef3f3ff4f144@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915-uml-kasan-v2-1-ef3f3ff4f144@axis.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> Building UML with KASAN fails since commit 69d4c0d32186 ("entry, kasan,
> x86: Disallow overriding mem*() functions") with the following errors:
> 
>  $ tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
>  ...
>  ld: mm/kasan/shadow.o: in function `memset':
>  shadow.c:(.text+0x40): multiple definition of `memset';
>  arch/x86/lib/memset_64.o:(.noinstr.text+0x0): first defined here
>  ld: mm/kasan/shadow.o: in function `memmove':
>  shadow.c:(.text+0x90): multiple definition of `memmove';
>  arch/x86/lib/memmove_64.o:(.noinstr.text+0x0): first defined here
>  ld: mm/kasan/shadow.o: in function `memcpy':
>  shadow.c:(.text+0x110): multiple definition of `memcpy';
>  arch/x86/lib/memcpy_64.o:(.noinstr.text+0x0): first defined here

So the breakage was ~9 months ago, and apparently nobody build-tested UML?

Does UML boot with the fix?

> UML does not use GENERIC_ENTRY and is still supposed to be allowed to
> override the mem*() functions, so use weak aliases in that case.
> 
> Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> Changes in v2:
> - Use CONFIG_UML instead of CONFIG_GENERIC_ENTRY.
> - Link to v1: https://lore.kernel.org/r/20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com
> ---
>  arch/x86/lib/memcpy_64.S  | 4 ++++
>  arch/x86/lib/memmove_64.S | 4 ++++
>  arch/x86/lib/memset_64.S  | 4 ++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
> index 8f95fb267caa..47b004851cf3 100644
> --- a/arch/x86/lib/memcpy_64.S
> +++ b/arch/x86/lib/memcpy_64.S
> @@ -40,7 +40,11 @@ SYM_TYPED_FUNC_START(__memcpy)
>  SYM_FUNC_END(__memcpy)
>  EXPORT_SYMBOL(__memcpy)
>  
> +#ifdef CONFIG_UML
> +SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
> +#else
>  SYM_FUNC_ALIAS(memcpy, __memcpy)
> +#endif
>  EXPORT_SYMBOL(memcpy)

Meh, the extra 3 #ifdefs are rather ugly and don't really express UML's 
expectations here.

So how about introducing a SYM_FUNC_ALIAS_MEMFUNC() variant on x86 in a 
suitable header, which maps to the right thing, with a comment added that 
explains that this is for UML's mem*() functions?

Thanks,

	Ingo

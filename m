Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA85F77BFE4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjHNSeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjHNSde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:33:34 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D19A10F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:33:33 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686c06b806cso3035123b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692038013; x=1692642813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8iwZg12OLuhKmVur/3KwHW/8LJxcNDVt1vwEiERMGA=;
        b=bFFqbLkEpK7yIJMGtIvYU+M+BhgGIQ6EuxXiqxJXKdluI9eyiHNw6zWy58WyqWDYS7
         PNX3Ltz3Hv8rQyoWH1aYcEUjZVJSC6leddeGvziv/G5VPUH+Q4f8oQtHPAa1tXzbHyMw
         xaoKqVMs9yciwG/L14RqjSGjc5vmWl1o/+J2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692038013; x=1692642813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8iwZg12OLuhKmVur/3KwHW/8LJxcNDVt1vwEiERMGA=;
        b=WwCLGXk83ZsBmcQw8pcrxGzuGrHJt5Z9MXrbY3Onz3UFjAW04kC72Xda5eEwpg75sd
         VUtjdkZ4PxnvWerkGMo6vGISz/xkf2EArLW2dFoYzqApNvXiXpBM3II/xQ4TijWXJFTd
         cpQbfSjcgEiRhmZcFB4BlBfuqZy637mUS22rC52yjVf6C1PvKCOgNj6lmqEKyiB8AwIK
         trzW2TdsX7dUZa7eCMLlGTF3pcwh3V/zibglbOb4dKuZk+xoZDgqT2tueAIrK+rFLzAT
         gyitq3krufFZPhjIQJXd7BzbORyB7GaLPJj+LyXLLbxDShFuuNJR/ljM8jfPcoRRSm/z
         BpUQ==
X-Gm-Message-State: AOJu0Yx78TjJ8i/M7VKprc+VIDAuP+SgSTcFbuwj9wH2xiyXK/YbcRMU
        +x9QI/RzrZoshOvC5OszMCP5Iw==
X-Google-Smtp-Source: AGHT+IEklZccVL6cUi3mOUlAJqnCYsINOyo2Bwkp+4IkA+X5znYYwIyoEN7NI88uHvmjTxQq2W/Tqg==
X-Received: by 2002:a17:90a:cb06:b0:26b:2538:d717 with SMTP id z6-20020a17090acb0600b0026b2538d717mr6989311pjt.25.1692038012892;
        Mon, 14 Aug 2023 11:33:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b00262eccfa29fsm10161456pjt.33.2023.08.14.11.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:33:32 -0700 (PDT)
Date:   Mon, 14 Aug 2023 11:33:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] riscv: SCS support
Message-ID: <202308141131.6B90A4205@keescook>
References: <20230811233556.97161-7-samitolvanen@google.com>
 <20230814175928.GA1028706@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814175928.GA1028706@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 10:59:28AM -0700, Nathan Chancellor wrote:
> Hi Sami,
> 
> On Fri, Aug 11, 2023 at 11:35:57PM +0000, Sami Tolvanen wrote:
> > Hi folks,
> > 
> > This series adds Shadow Call Stack (SCS) support for RISC-V. SCS
> > uses compiler instrumentation to store return addresses in a
> > separate shadow stack to protect them against accidental or
> > malicious overwrites. More information about SCS can be found
> > here:
> > 
> >   https://clang.llvm.org/docs/ShadowCallStack.html
> > 
> > Patch 1 is from Deepak, and it simplifies VMAP_STACK overflow
> > handling by adding support for accessing per-CPU variables
> > directly in assembly. The patch is included in this series to
> > make IRQ stack switching cleaner with SCS, and I've simply
> > rebased it. Patch 2 uses this functionality to clean up the stack
> > switching by moving duplicate code into a single function. On
> > RISC-V, the compiler uses the gp register for storing the current
> > shadow call stack pointer, which is incompatible with global
> > pointer relaxation. Patch 3 moves global pointer loading into a
> > macro that can be easily disabled with SCS. Patch 4 implements
> > SCS register loading and switching, and allows the feature to be
> > enabled, and patch 5 adds separate per-CPU IRQ shadow call stacks
> > when CONFIG_IRQ_STACKS is enabled.
> > 
> > Note that this series requires Clang 17. Earlier Clang versions
> > support SCS on RISC-V, but use the x18 register instead of gp,
> > which isn't ideal. gcc has SCS support for arm64, but I'm not
> > aware of plans to support RISC-V. Once the Zicfiss extension is
> > ratified, it's probably preferable to use hardware-backed shadow
> > stacks instead of SCS on hardware that supports the extension,
> > and we may want to consider implementing CONFIG_DYNAMIC_SCS to
> > patch between the implementation at runtime (similarly to the
> > arm64 implementation, which switches to SCS when hardware PAC
> > support isn't available).
> 
> I took this series for a spin on top of 6.5-rc6 with both LLVM 18 (built
> within the past couple of days) and LLVM 17.0.0-rc2 but it seems that
> the CFI_BACKWARDS LKDTM test does not pass with
> CONFIG_SHADOW_CALL_STACK=y.
> 
>   [   73.324652] lkdtm: Performing direct entry CFI_BACKWARD
>   [   73.324900] lkdtm: Attempting unchecked stack return address redirection ...
>   [   73.325178] lkdtm: Eek: return address mismatch! 0000000000000002 != ffffffff80614982
>   [   73.325478] lkdtm: FAIL: stack return address manipulation failed!
> 
> Does the test need to be adjusted or is there some other issue?

Does it pass without the series? I tried to write it to be
arch-agnostic, but I never tested it on RISC-V. It's very possible that
test needs adjusting for the architecture. Besides the label horrors,
the use of __builtin_frame_address may not work there either...

-- 
Kees Cook

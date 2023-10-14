Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE93A7C9261
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 05:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjJNDEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 23:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJNDEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 23:04:47 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE083A9;
        Fri, 13 Oct 2023 20:04:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so901023b3a.1;
        Fri, 13 Oct 2023 20:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697252684; x=1697857484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tkmT5RX8v7VrB7rbJu0hYTNQC/OFJh9NeX4vrDd9wBY=;
        b=BLdzhAVB0bDl9UCwwS1DmfdGYoWl7mRY+NH+P/O2h4IR+XPfFuaCpXZRCGqfDwJvCH
         0yMq0iTlX8b3xI7fdljQIS3P7pn1oUF99KGXcZ5JoITtze3hLr/MQkrrWf1MtP55cwad
         wqDfBiIHxdlp0XXUFW4tM1zucqu/TC+HH+UW3rGWSWFw0Ih/nvsZsYFnz5tRz5R3ZTgC
         2y/vcUlyx8Iwsp5gPiQxkQaF8JTTX2KNZ86+n37IV+X9tj0J2hlxhbLrr2AWhWAK4Jwz
         FZKzyJLVWfNu6PyHTIwZnNB0BPD8pKL+3+9kFF89zZJMbZlZ26ijUvh5jjrdgQL+251l
         M7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697252684; x=1697857484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkmT5RX8v7VrB7rbJu0hYTNQC/OFJh9NeX4vrDd9wBY=;
        b=mj9pZBOPI0Z4/pi4YLjE8lzXRxgGUeBM3nGwLKDfsE2vBfjuao4t5LFxr2f8xvLKqP
         BSc4t2IFkrn5JgGcFIvx9XBi+sKxNwAao2ZONBNqYksChn2XKH55V+gONtTHwqJWWqq7
         jM4SY7s5gLfRwrZwTnDaHxrdLGka8tf4jpSlaYRIRqCYN/eqeQKTGWMj2jM6aAuPRE+2
         EjjoWrNhWkmaUBS2UevRBbvyzPHBMwQ+5T/r9Xg9/BizVCYg4Ysm/aSnC51htkycqlCp
         2LHu4XfkMTYO0e2wn4QB+lZu8ZE+knbCKf4dmK/EEzrVSNXg1X4XLQzMnF+q3QfdbxhO
         XIag==
X-Gm-Message-State: AOJu0YzQR9jLPEeV8KgCnSk72dtRdt1KsTQ+8JJW/MiNSUsNADRhP8BL
        AiJ5zBTA5QZUQaofTzQGH3s=
X-Google-Smtp-Source: AGHT+IG0luxGMVCiiu/e7olkjVkBiHhOENnweMoA1ppTeqdfrgjznDhE5JBrMvoJo3mzbfy8uWRZIQ==
X-Received: by 2002:a05:6a00:1592:b0:68f:cf6f:e212 with SMTP id u18-20020a056a00159200b0068fcf6fe212mr28693521pfk.20.1697252683916;
        Fri, 13 Oct 2023 20:04:43 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:469c:3411:2771:1b7f])
        by smtp.gmail.com with ESMTPSA id z10-20020aa79f8a000000b00690d4c16296sm1945364pfr.154.2023.10.13.20.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 20:04:43 -0700 (PDT)
Date:   Fri, 13 Oct 2023 20:04:40 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-input@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] Input: Annotate struct ff_device with __counted_by
Message-ID: <ZSoFSF9xYeyei4JL@google.com>
References: <20231006201739.work.350-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006201739.work.350-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 01:17:39PM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ff_device.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-input@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied, thank you.

-- 
Dmitry

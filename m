Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD0977C21A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjHNVJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjHNVJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:09:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD15E5E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:09:30 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bdb801c667so28440215ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692047370; x=1692652170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4PuvQpJrJqrNy7astmt5IVebXoF5w/a9tG+pRmbryqo=;
        b=kxnjP4K14WJSvLPejXWZrEY2njof9Zmsz4pFZ+tWjEdwYQPwfyIy1Mbf1S1FDVBq9l
         9MWRs8VsKnOSdrE1QbDjEkJezJ9LJ2HWu8lANe7NqKHvNsNkhjfFXFiphBgOObgoJjGR
         Gfg8K0Q8n07N+ZzpKj9/KJ0ZLGM2DIevYNjic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692047370; x=1692652170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PuvQpJrJqrNy7astmt5IVebXoF5w/a9tG+pRmbryqo=;
        b=W8e7l/7a1861GpGqjEezg7oaH28qmgfModWLyEqCYvcvRT3RCGc45/Z9+YNV1vhNEl
         WdKG8Fan3poph25aB2CA11ho2Qa4erK+8LZuoMUPECV051s2AktYuaKVc2qTtzAcEbZk
         r3Oy8zBm1/3ka/AI4gFmsbnKATnBSYx5A3Nxdn2pjjXYiHz7+I1RPbysCQUj1Uggy5In
         +BDo2ZrqB4S5bzxiJOnzTreWmczj3yZGLCsl6OEOlAliL6YC1OKjcwlBpwdrtCsHAHmO
         ybyJk7uWvTZJj8gRkcsjrKoT6UiVeGLmEgEjrOr2zqGZeVvdrpZ+6UjIWF8bQJuHK8uu
         zVpA==
X-Gm-Message-State: AOJu0YxQqEJLgPR0451Fhb8uX55pX31xnVnwuCcYjBCSf57DhUGRlaw2
        5CNrepjt2QU7OF4+PZjW5EJDrw==
X-Google-Smtp-Source: AGHT+IFYeDWP5PYNKsk0YR+BiKLZK4N4Rwa0P0VjZkZ6hsNlrW8rO0WgiTO5nntV4saLBRmYH2B/dg==
X-Received: by 2002:a17:902:ee44:b0:1b0:6038:2982 with SMTP id 4-20020a170902ee4400b001b060382982mr10965327plo.41.1692047370203;
        Mon, 14 Aug 2023 14:09:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iw3-20020a170903044300b001b857352285sm9941444plb.247.2023.08.14.14.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 14:09:29 -0700 (PDT)
Date:   Mon, 14 Aug 2023 14:09:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] riscv: SCS support
Message-ID: <202308141409.76B8A274BF@keescook>
References: <20230811233556.97161-7-samitolvanen@google.com>
 <20230814175928.GA1028706@dev-arch.thelio-3990X>
 <202308141131.6B90A4205@keescook>
 <CABCJKueV8N4pDBFmw0aWn3wqeyjWUVTGotiC-gjMohJtw=_97Q@mail.gmail.com>
 <CABCJKue93aSknVnr8Mc1uaw5D5vk7xaPxaGp8JMqvvjqqHY3jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKue93aSknVnr8Mc1uaw5D5vk7xaPxaGp8JMqvvjqqHY3jQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:18:30PM -0700, Sami Tolvanen wrote:
> On Mon, Aug 14, 2023 at 11:57 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> > Looks like __builtin_frame_address behaves differently on RISC-V.
> > After staring at the disassembly a bit, using
> > __builtin_frame_address(0) - 1 instead of + 1 seems to yield correct
> > results.
> 
> Elliott was kind enough to point out to me off-list that this behavior
> has been documented here:
> 
> https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-cc.adoc#frame-pointer-convention
> 
> I'll include a patch to fix the test on RISC-V in the next version.

Perfect! Thanks for figuring out the offset. :)

-- 
Kees Cook

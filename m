Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295227BC047
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjJFU1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjJFU07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:26:59 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525FFC2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:26:57 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-692a885f129so2138970b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696624017; x=1697228817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ik+8xyOrxrDENzMU2+XdXOoH+BEnHgLDW/RYA7oHq4=;
        b=gD3kK/oSz9HpK1bX6ilsgqMakimaq8cgsY52n1LikFP8Titet9S97kTAwIIa6d7y4F
         1RJWF9rdgeOWQCoB/ft170/3JQTKpCxY8FKvdmNzTXAbASZPDsG2tjd7EtEk2XqpVNZH
         Wix9Eo44RUWCVF5p0lzNn79tIabC7ZQGPe5uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624017; x=1697228817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ik+8xyOrxrDENzMU2+XdXOoH+BEnHgLDW/RYA7oHq4=;
        b=vRh/sjD5oLo7FDAFIcf5Xtktrwzc5LA0YSPRmyjzJfTLpJxR4AUi9iymPDlOv6PqOt
         Vbm+tQLkXRC5KQQr8OUGqXoylxiwjuID/b93iuXgLxKZDJxlJ/RUd/vXbQNe4lqIyAJr
         EHzjQnTy2a6Ssy3K10UA32NxF5zHRQ0kchkM8e/wRdJdVpXx/8Q9dodH/GIfBwf1v0Qc
         i1aWX8IPfI34cdjFzZjKwK/SpcWxwpKSeekewuWRZmEInkPEg+xEsWnTeVNmDz6xoqTI
         vggvmVEmdqo3+3TL5jmzvBlVIlN7hp0W0EnYoyJpARZzY542KlX5MU9q7oVf2R4ybCUe
         O97Q==
X-Gm-Message-State: AOJu0Yyqdk9UJ7kZ7+DoYVzOqm7Vlg0KbUEENSkQKYMpYOsa2UsY4PrO
        1rgu8NQN8lq3S1b7tda7RsJL7Q==
X-Google-Smtp-Source: AGHT+IG2uZ4oQ6pqs/gPUxE9hmNLIVY3TcFTdzCBj+5FryP0YVUJaPRylWXG7huLOl6hdWH/tBpVog==
X-Received: by 2002:a05:6a20:3942:b0:14b:8023:33c8 with SMTP id r2-20020a056a20394200b0014b802333c8mr10453505pzg.2.1696624016776;
        Fri, 06 Oct 2023 13:26:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c8-20020aa78c08000000b0069102ae6d93sm1952733pfd.14.2023.10.06.13.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:26:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>
Cc:     sparclinux@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sparc: Annotate struct cpuinfo_tree with __counted_by
Date:   Fri,  6 Oct 2023 13:25:46 -0700
Message-Id: <169662394357.2154428.12028362294967452741.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175159.work.357-kees@kernel.org>
References: <20230922175159.work.357-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 10:52:00 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct cpuinfo_tree.
> 
> [...]

Since this is a trivial change and it's been 2 week without further
discussion, I'll snag this patch.

Applied to for-next/hardening, thanks!

[1/1] sparc: Annotate struct cpuinfo_tree with __counted_by
      https://git.kernel.org/kees/c/cfa36f889f23

Take care,

-- 
Kees Cook


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26527781280
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379284AbjHRR74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379318AbjHRR7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:59:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DF44486
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:58:56 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso917782a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692381535; x=1692986335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXWn1H6PaMCP3yeQaXdUby2KRE3fNHvqcyLkYIyGiaw=;
        b=VOhEHDw6QsEW+1ZsUQGRv4DVy8ZGywkEJnmW+FmHNmUOmTi67RY6yU8Z0Vl+8HhQr7
         2+JhLYBREnkB743S/lCi3ST+HvJa62ONXc0rDCgaFSidIjQ/J0mopW5eRaBa6wHk4wB6
         fOsfLymp+wlBamHiNkg+XO+Wt7AwE/NilcLxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692381535; x=1692986335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXWn1H6PaMCP3yeQaXdUby2KRE3fNHvqcyLkYIyGiaw=;
        b=JjamEdh39pIDPTth0DSBPg8Fk3QcX+EoLgCtALTEJpCuSiOWPMPBREBn2Rr+f2FaVq
         ipJk54adFMg+t6iHk1eJ+SZLFmc12FSJ8afkcpk+SSKb89Ht7gfDKEXTvOCeyTtepW2L
         I/KPO8hgb70XZ0QcuDnovXD1ouDKpqXqnxpMrDghWzPCZv+LbgytBfJq0aKVa8VMD0cC
         HUOf3Bkzq7eCS4pi8qjpWasG05KUcgBnsJNxc3XV4DhmfFrUSM9+TVQhnSh4LLXErPbT
         XSNxzHc9dwpNeBQ1zmoz/eNTm1yRKEb78zMMgqD9BX9T8Xki2QqBWSRle5kILNbT+Ya7
         QTIg==
X-Gm-Message-State: AOJu0Yxz9tqRw2dELMM7XlvLFEDbbGnAn7h51YdmsTXEVnR9OjW46sfR
        6WXYIKaIbp/i+/b5YPhYUY7MxA==
X-Google-Smtp-Source: AGHT+IEfibPi7yaGFSOCm8RGtUYUSuEPp7lZFgkZrkN4e6SwvT5vmrzO8rZthv/Hx28otk3QObEbbw==
X-Received: by 2002:a17:902:c086:b0:1be:e7ba:3a97 with SMTP id j6-20020a170902c08600b001bee7ba3a97mr3173197pld.15.1692381535438;
        Fri, 18 Aug 2023 10:58:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902dad200b001b892aac5c9sm2023752plx.298.2023.08.18.10.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 10:58:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Compiler Attributes: counted_by: Adjust name and identifier expansion
Date:   Fri, 18 Aug 2023 10:58:49 -0700
Message-Id: <169238152725.1457791.7913447764812747495.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817200558.never.077-kees@kernel.org>
References: <20230817200558.never.077-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 13:06:03 -0700, Kees Cook wrote:
> GCC and Clang's current RFCs name this attribute "counted_by", and have
> moved away from using a string for the member name. Update the kernel's
> macros to match. Additionally provide a UAPI no-op macro for UAPI structs
> that will gain annotations.

Applied to for-next/hardening, thanks!

[1/1] Compiler Attributes: counted_by: Adjust name and identifier expansion
      https://git.kernel.org/kees/c/c8248faf3ca2

Take care,

-- 
Kees Cook


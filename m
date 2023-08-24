Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADC1787859
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbjHXTEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243149AbjHXTDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:03:40 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CABE1BCE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 12:03:38 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a850f07fadso132309b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692903818; x=1693508618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIOxOAbASEK1ExaxZknXwWWIX7BvuBO6qbXSqSkkplM=;
        b=in7SDO1nCpMs1pW6kZW2GONP33S6cr0Tzr+D5zoGf9HonygP8+Ho7kWZjEoOKA6s4g
         d45VlJ3vVhh4ACl/LqFkXaO6QnczQHQEIYYLcD8RA32+ejXBnWfwneKIsA51JyVJQXSx
         E13fyTljsypiqKlxyoOqjClb4wwL/+i2nmGAsnEFF51vn2E1vWxKyb8skn90GlH869CV
         zcxOC0fDSVNKJlZcGfzEkSIPtie6yKijQyiP9J6zUeRMAOhxKYaa6NaN36Ow6+1w8FAH
         oTemG/zutFjoDyqFV7AZLpo6aCZpB5ZtrdBkImv4isq7MqSEQZZriBzlnXmpSqan0vMF
         7zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692903818; x=1693508618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIOxOAbASEK1ExaxZknXwWWIX7BvuBO6qbXSqSkkplM=;
        b=NlEN6zMFCQ2cu4iDVs+HiRv/bzgp6qwCTj3+ltpOx8uOBOs43Qj1wFDRVyS4VsWkia
         8jz2SG69ZnNh+eA7EfLCCfZ4Bfx5faLKz5Ek2ivTVNSiiXLJS0Tbo7YQCGyIeRrFJ39S
         B52chLinWY3w/I8JoZmAykCi2l9/IbOJOHiwmU3zmnObfZu9c4wiAY06cnZ9H9e+R/lA
         8XpveZiPSeHvH019IdhseWOsMFWzOcGyyscCjpJA2YsKqch4/LyMBdfn1JB7YaSjWt3X
         F0IRBX04OSdjCnkucfB7CiCodwkCVJhFf8P0H0tSFvLevNoYUhaF2a9d71VHEzaiE/w+
         Jz2w==
X-Gm-Message-State: AOJu0YyAXwgHYE3c+fh79xcsQKn7r9v6+X/wqi7HtMfnqWEy0LHP/QUK
        o0YsZt0/MMPHSX+1mFiVFVlho5vc3RqMtErv+rCrXQ==
X-Google-Smtp-Source: AGHT+IEXfuxs+RNxF7LKh6GmsWDesiSbOR2nqSO8VUt1beRy2Mdk4QadJhGLc+bzDHcxONvRodJuItf2jppA6SS8Bts=
X-Received: by 2002:a05:6808:10cd:b0:3a7:458e:3df4 with SMTP id
 s13-20020a05680810cd00b003a7458e3df4mr600019ois.56.1692903817600; Thu, 24 Aug
 2023 12:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230815203442.1608773-8-samitolvanen@google.com>
 <20230815203442.1608773-10-samitolvanen@google.com> <d3696b2a-3d21-4ab6-8cef-20b8ee21742f@rivosinc.com>
In-Reply-To: <d3696b2a-3d21-4ab6-8cef-20b8ee21742f@rivosinc.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 24 Aug 2023 12:03:00 -0700
Message-ID: <CABCJKud+24TGRX7b8Tb83HdWApC83adY=o2JpejRTHA4nkfpMg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] riscv: Deduplicate IRQ stack switching
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cl=C3=A9ment,

On Thu, Aug 24, 2023 at 1:12=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> Some defines for stack frame offsets could be added in asm-offsets for
> the offsets:
>
>         DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe),
> STACK_ALIGN));
>         OFFSET(STACKFRAME_FP, stackframe, fp);
>         OFFSET(STACKFRAME_RA, stackframe, ra);
>
> And you can probably increment the stack at once (saving two addi in
> prologue/epilogue) for both RA and FP and reuse the asm-offsets defines:
>
>         addi    sp, sp, -STACKFRAME_SIZE_ON_STACK
>         REG_S   ra, STACKFRAME_RA(sp)
>         REG_S   s0, STACKFRAME_FP(sp)
>         addi    s0, sp, STACKFRAME_SIZE_ON_STACK

Thanks for taking a look!

I just copied the existing inline assembly here, but I do agree that
defining stack frame offsets and avoiding the extra addis is a cleaner
approach. I'll change this in v3.

Sami

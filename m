Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429727B8D8E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243809AbjJDTmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjJDTmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:42:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4108FAB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:42:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-532c81b9adbso263161a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696448558; x=1697053358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3AS8/ldRUhDLTU3ok2wYBCdckpl9gBQpS3F0Riyq+Ts=;
        b=K+cEIfyoSWYi+7NvE/VxsbSLH9QRdQpcpet4VrJqeJavxlTQOrVR6gmGW/xHGVyqpy
         Cqd42N+/nfenGgIcFnZIhXPyxWC35c0WygVIMZFTX5jO7HPOrb3rQ4yKYBEdfmsXYc0V
         rXqBqlsIA6DGdnYftjPfV7kGk6EAer1B47EnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696448558; x=1697053358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AS8/ldRUhDLTU3ok2wYBCdckpl9gBQpS3F0Riyq+Ts=;
        b=uDLouSHKqdlL68cfXGyIoppzr+G14f79oCAw3kS6Kyn8dbGAaHMODgE6qQaYogoli6
         hl1QVCaiZG9+FNKG+tO+toqtLYJixef48rKf3I05DdxwUJYgz9sjdwMg3C/pSTyR3niJ
         I6tkUdqvkAq8JnqWi7x3qFyUwzDR8j6lDXgvo/RKjV4Xoy+O4O6mVnv6t/B4InVMPmxu
         usYm1ZXXu5ghWi0UQvOpWQa6Np78o8Dm82+UI/U5LOPhL+Why+XDAcZsrsycXN4hmEBu
         7m/B1R/N4FwdjSM1OrfQAB3iGsbfCJtH8PQvBoBMkwNtlAbVn8iL4+Jia2uuE2uVUV9T
         stog==
X-Gm-Message-State: AOJu0YzjG0UHNtoaHgiU9s88LGvm+I25SGkA3tziApT9Ul8vJ6PWwjEy
        vz+m2qr8PZ35JLDkWqzT9afAyPqa/TSLLkTFgBkQog==
X-Google-Smtp-Source: AGHT+IGiiBGpYz29k63/BZ1j6YY18CGX3k5EAbfuwrQLTWUcT2DgYne5TA/dWG6mzfOU6bmiB/yfyA==
X-Received: by 2002:a17:906:2111:b0:9a1:af6f:e373 with SMTP id 17-20020a170906211100b009a1af6fe373mr2931550ejt.42.1696448558652;
        Wed, 04 Oct 2023 12:42:38 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id s17-20020a170906c31100b009adc77fe164sm3290136ejz.66.2023.10.04.12.42.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 12:42:37 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so240465a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 12:42:37 -0700 (PDT)
X-Received: by 2002:a05:6402:12c3:b0:533:310b:a8aa with SMTP id
 k3-20020a05640212c300b00533310ba8aamr3142717edx.13.1696448557137; Wed, 04 Oct
 2023 12:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <ZR2U4DLycLT5xFH6@gmail.com> <20231004192404.31733-1-ubizjak@gmail.com>
In-Reply-To: <20231004192404.31733-1-ubizjak@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Oct 2023 12:42:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuRGzhuETLYDoi4hM6RAxHVL0ptuRb3TH-od+348Y8zA@mail.gmail.com>
Message-ID: <CAHk-=wjuRGzhuETLYDoi4hM6RAxHVL0ptuRb3TH-od+348Y8zA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/percpu: Use C for percpu read/write accessors
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unrelated reaction..

On Wed, 4 Oct 2023 at 12:24, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> the code improves from:
>
>  65 8b 05 00 00 00 00    mov    %gs:0x0(%rip),%eax
>  a9 00 00 0f 00          test   $0xf0000,%eax
>
> to:
>
>  65 f7 05 00 00 00 00    testl  $0xf0000,%gs:0x0(%rip)
>  00 00 0f 00

Funky.

Why does gcc generate that full-width load from memory, and not demote
it to a byte test?

IOW, it should not be

  65 f7 05 00 00 00 00 testl  $0xf0000,%gs:0x0(%rip)
  00 00 0f 00

after optimizing it, it should be three bytes shorter at

  65 f6 05 00 00 00 00 testb  $0xf,%gs:0x0(%rip)
  0f

instead (this is "objdump", so it doesn't show that the relocation
entry has changed by +2 to compensate).

Now, doing the access narrowing is a bad idea for stores (because it
can cause subsequent loads to have conflicts in the store buffer), but
for loads it should always be a win to narrow the access.

I wonder why gcc doesn't do it. This is not related to __seg_gs - I
tried it with regular memory accesses too, and gcc kept those as
32-bit accesses too.

And no, the assembler can't optimize that operation either, since I
think changing the testl to a testb would change the 'P' bit in the
resulting eflags, so this is a "the compiler could pick a better
instruction choice" thing.

I'm probably missing some reason why gcc wouldn't do this. But clang
does seem to do this obvious optimization.

              Linus

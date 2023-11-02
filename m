Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26717DF8BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjKBR3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjKBR3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:29:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7107E188
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:29:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9becde9ea7bso463642066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698946144; x=1699550944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uyMmGK3pqJfPbS0jfDAKY0ZEUhFBNW+33Pb+xOdwSj8=;
        b=HtxS4UWJ7P+AUjstYVMcY1FTYES9KCGoD+TwVyUp6iWHXKGkbMZlKWTFbhPZxtKseF
         SRK2YM5MEjUQ8rpOoGu3yW3yNjr4fPnKf+AAACTt9B2XfR4QmTY1yQcM5K5nxrb/MYum
         q+yHh0+tuWuF7xzftUlY6MyCbGPSb4DVXSxbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698946144; x=1699550944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyMmGK3pqJfPbS0jfDAKY0ZEUhFBNW+33Pb+xOdwSj8=;
        b=Z90Vug6Sa+Ec1Qtsr3Ce56zsCclSBKIeWjN7gNoi0fMgy8zOCSiB2wCpsUb5qWAnHq
         eAQ0BG+Xe3sM9TCtaaki7oPPAxVa4V0U2k37RBz6y9Vi/v9xm5+CBUqon6T1gUFNVdOu
         FZNA34NN5MPny9x7KOn/DYNRiLezn7qeCmBUrAT+lh/NnQ2jy1Zbwh0lImyIPglSSgrQ
         Ln6H31pgZ1agPKkBL0ACapAoWLOsIW5jnIxEAQUWMwH0HS9mMfnxH1y76rgIlzb0/+qV
         z3NYb5G+2+RdMDjINkeWjT1Ml5tVHPZm84mbyn0RCgqfq/hvevTbKG6G8zV4VWw2M1qW
         5/rA==
X-Gm-Message-State: AOJu0Yw9MUb7JyCtBMhxvvQZKESgtvMJ4XadgraL35t59Zh8XmdjFCLQ
        l3naHCM7W//zqoaddwLGK7rDEb+sEzvCFoIUmAQxCA2c
X-Google-Smtp-Source: AGHT+IHJ+WjIWGSz+vnORZEJ4sbhqN/i9zWkzC/pcAGMyBUuLEuryrFOlwoStPhT2eyQaC9eOOVu1w==
X-Received: by 2002:a17:906:c107:b0:9a2:295a:9bbc with SMTP id do7-20020a170906c10700b009a2295a9bbcmr355167ejc.37.1698946143646;
        Thu, 02 Nov 2023 10:29:03 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id cb20-20020a170906a45400b009c4cb1553edsm1395440ejb.95.2023.11.02.10.29.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 10:29:03 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9c3aec5f326so459727766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:29:02 -0700 (PDT)
X-Received: by 2002:a17:907:1c87:b0:9a9:f0e6:904e with SMTP id
 nb7-20020a1709071c8700b009a9f0e6904emr470853ejc.16.1698946142622; Thu, 02 Nov
 2023 10:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <340fc037-c18f-417f-8aaa-9cf88c9052f4@app.fastmail.com> <8ff191a0-41fa-4f36-86e8-3d32ff3fe75c@web.de>
In-Reply-To: <8ff191a0-41fa-4f36-86e8-3d32ff3fe75c@web.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Nov 2023 07:28:45 -1000
X-Gmail-Original-Message-ID: <CAHk-=whFLZ67ffzt1juryCYcYz6eL_XjQF8WucDzwUR5H65+rA@mail.gmail.com>
Message-ID: <CAHk-=whFLZ67ffzt1juryCYcYz6eL_XjQF8WucDzwUR5H65+rA@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for v6.7
To:     Frank Scheiner <frank.scheiner@web.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 at 00:24, Frank Scheiner <frank.scheiner@web.de> wrote:
>
> so the ia64 removal happened despite the efforts - not only from us - to
> keep it alive in Linux. That is a - sad - fact now.

Well, I'd have personally been willing to resurrect it, but I was told
several times that other projects were basically just waiting for the
kernel support to die.

Has the itanium situation really changed?

The thing is, nobody doing new kernel code wants to deal with itanium,
so relegating it to the same situation that i386 support was ("it
still works in old kernels") doesn't seem to be a huge issue for the
people who actually want to use those machines.

That said, I'd be willing to resurrect itanium support, even though I
personally despise the architecture with a passion for being
fundamentally based on faulty design premises, and an implementation
based on politics rather than good technical design.

But only if it turns out to actually have some long-term active
interest (ie I'd compare it to the situation with m68k etc - clearly
dead architectures that we still support despite them being not
relevant - because some people care and they don't cause pain).

So I'd be willing to come back to the "can we resurrect it"
discussion, but not immediately - more along the lines of a "look,
we've been maintaining it out of tree for a year, the other
infrastructure is still alive, there is no impact on the rest of the
kernel, can we please try again"?

               Linus

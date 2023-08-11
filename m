Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CDE7796CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbjHKSI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbjHKSIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:08:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D5E30D7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:08:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c93638322so465376366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691777333; x=1692382133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yc08NlpUYdnLIv24Lptdj+fSBDTOBa932kABNWFPLk4=;
        b=RTI9CzjdQxEP0jZXYgxQ3j2i1YZAC8sl1U/7EIGDRWPhv19dJWaIuMluPdJdzcF0av
         Vcixa4tBFowA+nSUcvMJnURifDp6/MWYeU7k7SAcBrAW2XorJYSov0tlbz7bT/PodKXw
         srHWL9g1riPcLR63fGfD162p5bZ2jUehcDVQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691777333; x=1692382133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yc08NlpUYdnLIv24Lptdj+fSBDTOBa932kABNWFPLk4=;
        b=bpIAYE/YEZDzGB+c7G9Pyk90lHkcgLI3s2gkMvEep6SZeU5j5tGK7qq+oQh1bAe1pO
         t+sxBHcMZ/4aQF+winqjMNu8CXFSzjFwhKo8vRL6Gy+s9x+q+40OY6oGWkhZgOcYIRGy
         6UH8B3RrClWOYX2SmYm/O0Duqt3EMkNPFw9mjq47u9gB76rZvUxLsZuEWCBhOF+AROQd
         OvNjfH17+rfojxiW3n7a0quvgYNAa1RlcK0S4d0zo6Y5nEAYnkGVVFdJuKzIKv3eVR/J
         sN1dTFonszP1Nu7tQ7Lb/WE0EnakPl9JW4C89U8tvsv1ZYAoTfsE3XVS+pCgNf0W2t8F
         FT0g==
X-Gm-Message-State: AOJu0YzV6YfSAKReFsp6w6yL09/XXwbgncwBNKgNJvfzatZT8vJdFNj0
        +b3HGUfntdWhqb4RkAAdA7DTfeGpTy3oHR6S0aaZr+3V
X-Google-Smtp-Source: AGHT+IFsZAIgXlO4dmKNnNhNaeNrJfVfAm6ZAs6IGfFt3v+00iVfUJh6HfriSaAC6O2Z/eohsbuUQA==
X-Received: by 2002:a17:906:cc0d:b0:989:450:e565 with SMTP id ml13-20020a170906cc0d00b009890450e565mr3255738ejb.23.1691777324360;
        Fri, 11 Aug 2023 11:08:44 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id j23-20020a170906411700b00988e953a586sm2518685ejk.61.2023.08.11.11.08.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 11:08:44 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so6941676a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:08:43 -0700 (PDT)
X-Received: by 2002:aa7:dad9:0:b0:521:ad49:8493 with SMTP id
 x25-20020aa7dad9000000b00521ad498493mr3461940eds.6.1691777323138; Fri, 11 Aug
 2023 11:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <3710261.1691764329@warthog.procyon.org.uk> <CAHk-=wi1QZ+zdXkjnEY7u1GsVDaBv8yY+m4-9G3R34ihwg9pmQ@mail.gmail.com>
 <3888331.1691773627@warthog.procyon.org.uk>
In-Reply-To: <3888331.1691773627@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Aug 2023 11:08:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsKN50RfZAP4EL12djwvMiWYKTca_5AYxPnHNzF7ffvg@mail.gmail.com>
Message-ID: <CAHk-=whsKN50RfZAP4EL12djwvMiWYKTca_5AYxPnHNzF7ffvg@mail.gmail.com>
Subject: Re: [RFC PATCH] iov_iter: Convert iterate*() to inline funcs
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 at 10:07, David Howells <dhowells@redhat.com> wrote:
>
> Hmmm...  It seems that using if-if-if rather than switch() gets optimised
> better in terms of .text space.  The attached change makes things a bit
> smaller (by 69 bytes).

Ack, and that also makes your change look more like the original code
and more as just a plain "turn macros into inline functions".

As a result the code diff initially seems a bit smaller too, but then
at some point it looks like at least clang decides that it can combine
common code and turn those 'ustep' calls into indirect calls off a
conditional register, ie code like

        movq    $memcpy_from_iter, %rax
        movq    $memcpy_from_iter_mc, %r13
        cmoveq  %rax, %r13
        [...]
        movq    %r13, %r11
        callq   __x86_indirect_thunk_r11

Which is absolutely horrible. It might actually generate smaller code,
but with all the speculation overhead, indirect calls are a complete
no-no. They now cause a pipeline flush on a large majority of CPUs out
there.

That code generation is not ok, and the old macro thing didn't
generate it (because it didn't have any indirect calls).

And it turns out that __always_inline on those functions doesn't even
help, because the fact that it's called through an indirect function
pointer means that at least clang just keeps it as an indirect call.

So I think you need to remove the changes you did to
memcpy_from_iter(). The old code was an explicit conditional of direct
calls:

        if (iov_iter_is_copy_mc(i))
                return (void *)copy_mc_to_kernel(to, from, size);
        return memcpy(to, from, size);

and now you do that

                                   iov_iter_is_copy_mc(i) ?
                                   memcpy_from_iter_mc : memcpy_from_iter);

to pass in a function pointer.

Not ok. Not ok at all. It may look clever, but function pointers are
bad. Avoid them like the plague.

            Linus

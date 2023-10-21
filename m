Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC9B7D1EE0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 20:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjJUSI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 14:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJUSI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 14:08:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550FFD6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 11:08:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c603e2354fso401276166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 11:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697911729; x=1698516529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=riI2Gx31LBdznSH8wFDQvGpcc769IU1d5o0vtYVXSEA=;
        b=RWrAhrcdNLRs2bP8bovqUFvASt93kPhHsJaT+SHY3pBrC0t/6vIpB4xf9SF8VKniMR
         I/0zNOKHyY0oiV4BkPpQvvw0ACPN86wb6LXHqHT4b0mukqzUOxKu0VlHhwthjI9aYtRz
         Fcw+GXoM0G1LcX4jLn+Xemd5pkyLkGwRP6HHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697911729; x=1698516529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riI2Gx31LBdznSH8wFDQvGpcc769IU1d5o0vtYVXSEA=;
        b=Ur7cFdYMi2G64aiZDdm8YRP4w7r8OcZ9+QPasDRohiPRKyyf45aQJYcXPiw1YjVWIQ
         lr8ezwrAG71z5XIz6RsH31nd3wJxUj3BaW1qGpe8ndJSQ6GuaOsrSBTqGd4A5/OhgDdi
         EPKC58diU//wFvoOW9VNQnIMGLewtMC+2s4gfnjZiwXVQFcmGtL/Ef9EGzE3cKY4IXIa
         bw8JWG2yPPMQWJ3uYbokoLDKTNyooEQmem+2rViN27O/z8+r/Rg1nfV6r+SHGAzcQpOc
         wIgOtY8Q5W+O7E6TyqGgWbwISjNnsuSPQzK9xMYaDodQCJvF4MB98mjyjBEuvfGZjpDw
         2KfQ==
X-Gm-Message-State: AOJu0Yy1nBRKrYq5rN+Q5qz7c98ymVjzblKmw+vJ1km01dg2OGw53NyF
        Y/EIssBosBKTLM96wPasF7GsHnuL7h00jF+fQd9JNj6D
X-Google-Smtp-Source: AGHT+IHi5o3qeXa8OQphZbY5mJCAuPkO/jc0kOnmEav7O2teOVJFK49XT+GDW0pkO3nya/7hwcKfyQ==
X-Received: by 2002:a17:907:7f15:b0:9c5:7f5d:42dc with SMTP id qf21-20020a1709077f1500b009c57f5d42dcmr7879955ejc.33.1697911729508;
        Sat, 21 Oct 2023 11:08:49 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id m21-20020a509315000000b0053db1ca293asm3788418eda.19.2023.10.21.11.08.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 11:08:48 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso4033267a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 11:08:48 -0700 (PDT)
X-Received: by 2002:a50:d49e:0:b0:533:ccec:552 with SMTP id
 s30-20020a50d49e000000b00533ccec0552mr4827141edi.9.1697911728338; Sat, 21 Oct
 2023 11:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01697881440-ext-2458@work.hours> <CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Oct 2023 11:08:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxAk=PQBX4OvscNfGKfc+M8iKmNd6D39wOZzXV0k729w@mail.gmail.com>
Message-ID: <CAHk-=wjxAk=PQBX4OvscNfGKfc+M8iKmNd6D39wOZzXV0k729w@mail.gmail.com>
Subject: Re: [GIT PULL] s390 fixes for 6.6-rc7
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just re-quoting my suggestion here and adding Andy and Dmitry, who did
the original bitmap_alloc() helper interfaces a few years ago.

Also adding Kees in case he has any hardening suggestions, since this
is about (incorrect) overflow handling.

Kees: see my rant about mindlessly doing overflow handling in the wrong place in

   https://lore.kernel.org/all/CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com/

in case you or somebody has a better idea for BITS_TO_LONG handling
than just "you need to check for zero before and after".

             Linus

On Sat, 21 Oct 2023 at 10:56, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If you *do* want to add proper overflow handling, you'd need to either
> fix BITS_TO_LONGS() some way (which is actually non-trivial since it
> needs to be able to stay a constant and only use the argument once),
> or you do something like
>
>         if (!bits)
>                 return ZERO_SIZE_PTR;
>         longs = BITS_TO_LONG(bits);
>         if (!longs)
>                 return NULL;
>         return vzalloc(longs * sizeof(long));
>
> and I'd suggest maybe we should
>
>  (a) do the above checking in our bitmap_alloc() routines
>
>  (b) also change our bitmap_alloc() routines to take 'size_t' instead
> of 'unsigned int' bit counts
>
>  (c) and finally, add that vzalloc() case, but simply using
>
>         kvmalloc_array(n, size, flags | __GFP_ZERO);
>
> instead.

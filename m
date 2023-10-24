Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C427D5B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbjJXTcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjJXTct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:32:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25E910C6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 12:32:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so5521415a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698175965; x=1698780765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz2UiFW5H33iZ4N++uZ6e03nG8WnF5BOmzOOzIXzHlc=;
        b=AMMnbyrxnwb4Wd2Divu7uVHhOlH0wHlKyBnM8ebKtJiDJUkh8Fqz1y+wifxMFO+dJQ
         Ot0joZEHM/9CYdP1bVYf1A9tOQ9bvcypKBlAd3wB7BcN8LXDMjjxj3jKDyN2mxI6fGEl
         RrUqxlAlGyaA1XHqAEb4xCdrjJDRjDp6Ij3wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698175965; x=1698780765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lz2UiFW5H33iZ4N++uZ6e03nG8WnF5BOmzOOzIXzHlc=;
        b=edUTa1qubVGX6eSAhvSQ7TelWhnk1tc7djAkiJZAo70+kWJytKaegekYkh6jqlihpj
         lT2bw14+IIPuwLAN8hm7aypkCJPtoQSA+Q9sXmn8AdeDE6eSeJkh16qF3CsHR9Bo2Qnc
         bO6JlqfdJE6L1CUE5eSIPegnqBjN2irzXb+Llp4oEVF0g9Obx9hyEJ+Dk86ihMxTwHMR
         +V+qzVrL4JQps2m+zrTjeoCykJjgo6+LwWrnEbzikuG0oX/AcPMamXffNRzXHdN4O3rH
         NDN3ETCML4p7m6dO6lCLDS/8X+S/Az7uCNPAZfqhkl1O6bSyyyYx35hlMqaZzutC9K4M
         RATA==
X-Gm-Message-State: AOJu0YxeiOqYqOikBU5yMC0Nov/nS5qkhnLstZbwxq3ApcJUThBtRV8G
        HBSOk9GdITZXS08LyLBuwr4Oq2NRN6Sndg1alIafN2yo
X-Google-Smtp-Source: AGHT+IEdTbTZv8LDORJoQinISrn4DNK7gBHcUfS+P0Pl3EJEDdpvvef44t/NmkR5gA4VoLxWnMrpHw==
X-Received: by 2002:a50:9ec4:0:b0:53d:9471:76b3 with SMTP id a62-20020a509ec4000000b0053d947176b3mr9415086edf.7.1698175965558;
        Tue, 24 Oct 2023 12:32:45 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id cf15-20020a0564020b8f00b0053deb97e8e6sm8215590edb.28.2023.10.24.12.32.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 12:32:44 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so5521375a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 12:32:44 -0700 (PDT)
X-Received: by 2002:a17:906:7956:b0:9be:e153:3b82 with SMTP id
 l22-20020a170906795600b009bee1533b82mr10308422ejo.17.1698175964167; Tue, 24
 Oct 2023 12:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231024161931.78567-1-sebastian.reichel@collabora.com> <20231024161931.78567-2-sebastian.reichel@collabora.com>
In-Reply-To: <20231024161931.78567-2-sebastian.reichel@collabora.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Oct 2023 09:32:27 -1000
X-Gmail-Original-Message-ID: <CAHk-=whYDbZ29fx_xeSxtYSjtF8WJkaLjzyB8RN5_Rk9Sh-YyQ@mail.gmail.com>
Message-ID: <CAHk-=whYDbZ29fx_xeSxtYSjtF8WJkaLjzyB8RN5_Rk9Sh-YyQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>, kernel@collabora.com
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

[ Since you're cc'ing the s390 people, I assume that means that this
all ended up being a follow-up to the s390 issue discussion ]

On Tue, 24 Oct 2023 at 06:19, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Add a new DIV_ROUND_UP helper, which cannot overflow when
> big numbers are being used.

This is really horrendously bad on some architectures (ie it might
require *two* divisions):

> +#define DIV_ROUND_UP_NO_OVERFLOW(n, d) (((n) / (d)) + !!((n) % (d)))

but David Laight at least had a suggestion for that: when allowing
multiple uses, you can just do

   #define DIV_ROUND_UP(n,d) ((n) ? ((n)-1)/(d)+1 : 0)

so now you're back to just one division and no horrible extra expense.

But we can't allow those multiple uses in general, sadly.

I would really prefer to just make our regular DIV_ROUND_UP() DTRT.  But:

 - people do use it with complex first arguments (ie function calls
etc) that we don't want to evaluate twice

 - we can't make it an inline function, because the types aren't fixed

 - we can't even use a statement expression and __auto_type, because
these things are used in type definitions etc and need to be constant
expressions

That last thing means that even the "__builtin_choose_expr()" doesn't
work, because the statement expression still needs to be _parsed_ as
such, and that's not something we can do in those contexts.

Very annoying. Let me think about this.

                     Linus

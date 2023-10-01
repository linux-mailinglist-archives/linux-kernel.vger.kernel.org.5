Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433F67B48BB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 19:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbjJARHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 13:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjJARHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 13:07:39 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5FE83
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 10:07:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a645e54806so2117380366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696180055; x=1696784855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y1EwXB3ACw8rU2iY8eIOX3kGcDY5wuwungnWhtsiWk=;
        b=Ur+TIT3HJ9w3TqeT8pVlPWQ+TosVMZrsEAjv4+BV7jgIRSD0M2ifWOinAn5OqnM5cC
         RkU6AAb9sI4QXJ8iQ3jXNU3TNSGX8iFudtyD4i7K3KEzvbUBeRtOU9+Wigau0Ln86h9f
         8WSOj3pS8DS5j29rBK155WhseIp6qjJ1hvkVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696180055; x=1696784855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Y1EwXB3ACw8rU2iY8eIOX3kGcDY5wuwungnWhtsiWk=;
        b=mks0RuhDWrJkwoYw1HY+c6DVWr0faF5tv70ZgyFOnEUuoh6BBnFDArC2i8XhF9syTe
         XJ62MJqF8MOgSDFxFK8/dkhw5wXbcIvwNWhcn11aqKS2Mg1I9PD73pP0ZzFkKKZQuqu5
         guF6fk+eYkc3fUe8Fi7eILYTIdbB9cLb8nV046JAiAwoiNmYOARX66jF2KrI0j1daVJW
         kQdleNFDL9myC8+91wIPoghtK4AojRtFcJ5T2c5xf6yrH9C86WkxZydZQ88GuPWssk4C
         uWh01547aClkifpyPYz7lcKY9gD5+yF+R4jgUc7/mC1kwR41K6Op7GtA0KfAf4rxNwgC
         RgWQ==
X-Gm-Message-State: AOJu0Yza6eYr0M7kZRw0C9CfkzJxNxYOYrPAlBVQh6fiyqdT/igBa2GL
        fuw1DPCTU542KNIK+Uz3e5lurufkME76Z7FpEOVJX61h
X-Google-Smtp-Source: AGHT+IE2diKemTWk+P9Dd1LPAYBHYictCky+4Ezbo0tA7cn6wHEhrnRl62uYH0wuoqoJ9d/fJifLUw==
X-Received: by 2002:a17:906:3050:b0:9ad:e180:16e3 with SMTP id d16-20020a170906305000b009ade18016e3mr8175630ejd.37.1696180055049;
        Sun, 01 Oct 2023 10:07:35 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id rh27-20020a17090720fb00b0099b6becb107sm15747128ejb.95.2023.10.01.10.07.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 10:07:33 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-533c5d10dc7so17542406a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 10:07:33 -0700 (PDT)
X-Received: by 2002:aa7:c390:0:b0:532:e71b:5ead with SMTP id
 k16-20020aa7c390000000b00532e71b5eadmr7241418edq.32.1696180053110; Sun, 01
 Oct 2023 10:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231001131620.112484-1-ubizjak@gmail.com>
In-Reply-To: <20231001131620.112484-1-ubizjak@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Oct 2023 10:07:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6P8pPg-x4BPUQj-wE0xC7HkGzFk89ftuji8MVo+RRxw@mail.gmail.com>
Message-ID: <CAHk-=wg6P8pPg-x4BPUQj-wE0xC7HkGzFk89ftuji8MVo+RRxw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] x86/percpu: Use segment qualifiers
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2023 at 06:16, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> This patchset resurrect the work of Richard Henderson [1] and Nadav Amit [2]
> to introduce named address spaces compiler extension [3,4] into the linux kernel.

So apparently the extension has been around for a while (since gcc-6),
but I don't actually find any single major _user_ of it.

Debian code search finds exactly one case of it outside of the
compilers themselves:

  #  define THREAD_SELF \
    (*(struct pthread *__seg_fs *) offsetof (struct pthread, header.self))

in glibc/sysdeps/x86_64/nptl/tls.h, and even that isn't very widely
used (it seems to be a pthread_mutex implementation helper).

So the coverage testing of this thing seems very weak. Do we have any
other reason to believe that this is likely to actually be reliable
enough to use?

                     Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B581C7A333B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 00:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjIPW0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 18:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjIPW0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 18:26:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5B41BF
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 15:26:01 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50300141a64so1360283e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694903159; x=1695507959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r9idXErWZI7pNQUkUS1qR53dXjSp7SyDv32PM6WVIlo=;
        b=D0+EXYBsjJYNf4JseaWdf7sDE7XKUSh6qxONeU9hUkrJtvQ3Sxe8n3TTjI62iE8VvB
         dK+Jwyhj0UOtUPw3+tfDimLtF81+v2n7xdl/0lII+69Lkiwhloqi8pzhGxr35ZFuXtQI
         eDwmeqJrgpk+aJ/cx1cF98iIrtOivrfM/6/gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694903159; x=1695507959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9idXErWZI7pNQUkUS1qR53dXjSp7SyDv32PM6WVIlo=;
        b=IpIQLDtKNqcETDNWNhjaeIypW2WOXqpVZWJczseI9np4KPWl2TLsywDAu+gZKv4N7Q
         9ja3DyrvIXXZ4MiEMUy20JuSz7IE4Q2rSx2h+hfMb4lw5moNfXLBITqndHYO3Zr5PZ14
         Sk2BoLy0/6aBnbk8bEHGESLuidfhxVNIo7Le2XV+bDXhK5JMFHaxl0SLljj4YPjU6asl
         dYr56xOu/W+pvEjRTHcCXqg8yrkfqLqgSdyTkrhUdp/yEFqy+EdWB0wutB6rxN/uxrUj
         UYO888F1LUuwrEzY6ljyLL2++dbN91BMYNYFd7QnmnabqtPeS0/aboytkTMG4mvystSO
         qdmg==
X-Gm-Message-State: AOJu0YyAZeMy8ymBMWKBT6DfXJc58NTwYKWv0WB0ySjRtMxC4ULOJyaE
        3bYbWyC3po7z6E1VgG0igO8UaDWdxOQu53HQRGkgDoGa
X-Google-Smtp-Source: AGHT+IF9LP/TQtniQIHFI3FVVhhT+sSiCdJpvdJEmLyRZg5bI2/oVyHwnpzuhXUNT9IthqvpdvNhWg==
X-Received: by 2002:a05:6512:a84:b0:4fb:745e:dd01 with SMTP id m4-20020a0565120a8400b004fb745edd01mr5522058lfu.45.1694903159703;
        Sat, 16 Sep 2023 15:25:59 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id b28-20020ac2563c000000b004fbc95a4db3sm1176177lff.28.2023.09.16.15.25.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 15:25:58 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-501eec0a373so5293295e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 15:25:58 -0700 (PDT)
X-Received: by 2002:a05:6512:1321:b0:500:99a9:bc40 with SMTP id
 x33-20020a056512132100b0050099a9bc40mr5258347lfu.69.1694903157814; Sat, 16
 Sep 2023 15:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <1694366957@msgid.manchmal.in-ulm.de> <ZQWUzwiKWLk79qbp@debian.me>
 <CAHk-=wh29JJSVGyJM7ubxOs51-Nxp6YnmU9Bw1gdOk3rrQ_0mg@mail.gmail.com>
 <CAHk-=wjrEjaUw3oFVEYpF=AWAwrSM3sQTQHuPfFjFdQsvQxHeg@mail.gmail.com> <40eecbdf-40d4-0fa2-6718-3875ed852104@virtuozzo.com>
In-Reply-To: <40eecbdf-40d4-0fa2-6718-3875ed852104@virtuozzo.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Sep 2023 15:25:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRnv92Y-b69OTefTxVHbmtnijNt8Dw7BFe+fgJTHK60A@mail.gmail.com>
Message-ID: <CAHk-=wjRnv92Y-b69OTefTxVHbmtnijNt8Dw7BFe+fgJTHK60A@mail.gmail.com>
Subject: Re: Possible 6.5 regression: Huge values for "commited memory"
To:     Michael Labiuk <michael.labiuk@virtuozzo.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        Linux PARISC <linux-parisc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sept 2023 at 15:20, Michael Labiuk
<michael.labiuk@virtuozzo.com> wrote:
>
> This patch fixes problem with counter for committed memory.
>
> Thanks!

Oh, no, thank *you*. With the bisection, this was fairly straightforward.

A silly mistake in the original patch, but hard to see without a clear
"this is when the problem was introduced".

           Linus

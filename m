Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3A4781DDA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjHTMs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 08:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjHTMsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 08:48:24 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176E746A9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 05:48:02 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so36346661fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 05:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692535680; x=1693140480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EAlwOLhvodbStS7U0JzC0JNPjiXvdKGT5YChhjDmGgM=;
        b=fcrxMHYMQRMMra3W/WCtJSpdf4cqQDbWjkFWZNS5ya4UaRHBr/TL5DWgBcJm+30xPx
         9w5s7glsbYt/2o2CZojejJX1w7QwgvwuaGx8b3GvGt2jvuk5KUmkMwo4vA0KP+VauUkS
         ZUR17eHag0ypEtHOc3LLps9EOa2HGJH6ZJaIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692535680; x=1693140480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAlwOLhvodbStS7U0JzC0JNPjiXvdKGT5YChhjDmGgM=;
        b=T0kgPD6F/EotstcgZNETtZULVZEryLhG/9nC0Uhb7jj1s5xXew0PxqGojtdUytSSPK
         cKC6N9+sbRa2C7dgr4AstrvT+PjlljME6QI/Kf2eYJnpcdc1C2ghdPrK24e/SgSRzqba
         v6LEtJzirdR9ruxbteC1r2wFITHzLGUJqrqVlIY4nQ5F45RCA/ShyIqzXSUlw7+/U2J3
         xklGarLDSsSdhKP+TTGtHvs+sZaWT9CM+gxGAiOqYyhJpm3CbTbynTBk8MNl4+e8JDHi
         7NLRkNZKDNWq+teeSCI2AOXkhsLIvzoXd7bOftOXhXkfM3omaVmhbCahobGbYCYnXDTu
         RoiA==
X-Gm-Message-State: AOJu0YxNkd4Q6sH7d8BoGahTi4wDYjoTWgvfa2AMbbiZlgw5QD+kgsT3
        F6i0XzRfNMEvfMYmbVaS5ZG//+24LvLEWuv6j8rSnRus
X-Google-Smtp-Source: AGHT+IEmzqszuk5xy2ENBnaYg5AmPd5/NtlPxw0/xxeBxfBXLvjeDGWSrM0luwpfWjfOrYh9LjYcKg==
X-Received: by 2002:a19:791d:0:b0:4fb:7675:1c16 with SMTP id u29-20020a19791d000000b004fb76751c16mr2261093lfc.49.1692535679926;
        Sun, 20 Aug 2023 05:47:59 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id c25-20020a170906529900b0099cf840527csm4526073ejm.153.2023.08.20.05.47.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 05:47:59 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-525597d891fso3147635a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 05:47:59 -0700 (PDT)
X-Received: by 2002:aa7:d996:0:b0:522:d6f4:c0eb with SMTP id
 u22-20020aa7d996000000b00522d6f4c0ebmr2577796eds.40.1692535679006; Sun, 20
 Aug 2023 05:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230820104303.2083444-1-mjguzik@gmail.com> <ZOH62Zi/yao/oC8y@casper.infradead.org>
 <CAGudoHG3OxoYKSwDmJYEDOj6LmDMsQDs3SD5nBdrzA5Vc1_H0A@mail.gmail.com>
In-Reply-To: <CAGudoHG3OxoYKSwDmJYEDOj6LmDMsQDs3SD5nBdrzA5Vc1_H0A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Aug 2023 14:47:41 +0200
X-Gmail-Original-Message-ID: <CAHk-=wh=cECn7SLr31VXwtJq-wYnt5+VcERnvAmEVktdEKqR=w@mail.gmail.com>
Message-ID: <CAHk-=wh=cECn7SLr31VXwtJq-wYnt5+VcERnvAmEVktdEKqR=w@mail.gmail.com>
Subject: Re: [PATCH] mm: remove unintentional voluntary preemption in get_mmap_lock_carefully
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2023 at 14:41, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> On 8/20/23, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Except now we search the exception tables every time we call it.
> > The now-deleted comment (c2508ec5a58d) suggests this is slow:

Yeah, that was the intent.

But I agree that we should basically avoid trying to sleep just as we
got the lock.

> My first patch looked like this:

Well, that's disgusting and strange.

> -               might_sleep();
> +#if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
> +               __might_sleep(__FILE__, __LINE__);
> +#endif

Why would you have that strange #ifdef? __might_sleep() just goes away
without that debug option anyway.

But without that odd ifdef, I think it's fine.

            Linus

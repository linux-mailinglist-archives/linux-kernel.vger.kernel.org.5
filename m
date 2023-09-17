Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5717A36A2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 18:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbjIQQrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 12:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbjIQQqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 12:46:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC9511D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 09:46:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c1c66876aso454894566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694969192; x=1695573992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0paMOWTj7qFjWlnbMH8/b4zKX3pixZT+0KYdXbHqu5E=;
        b=Gsa1NmXZ8188yNiosasLjNSC5T8hO74jHELIHdsbuPGRo6fYUMM0QAZJjp4feg+lCR
         uznSXM0aLEztvokrdLH8OsWPf1BvGHGv2h13b4b5THuLXot680C2vkOzrM1BYgdRo1XO
         Q+A13mz77jvmTgC45YcIHLmFmLPjVTyzPLBMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694969192; x=1695573992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0paMOWTj7qFjWlnbMH8/b4zKX3pixZT+0KYdXbHqu5E=;
        b=e6HE2rOZAxwJ1r632MuHC4Gu37p4L/+TJDEOvNouCpoWSxv2oaDg8gzlV3UWR/gcEU
         z60tR5E62/rEAQqMY6TZkuYDBUuLXrBpOr4dIahP9MwlZSQ13Fx7WA16wFvwq82N5ZoG
         4afDksZ0bjCumGVVK3q/jCTJIFW2wEaS8Q5lc7280F7hs/50aIjYwq8UCBfO1Yql0v0B
         UDrNuPFhWsPPKRDfVVWgoGQkN+wTiEq23UAiyzlHDE1IyunbLJRR4c3IDpnO2ik/Blf1
         xE/UOoz4D7mPD5LPx05+rSLsxxqrIzsjHelO9fZZ/kwTzDkddNflToP+i+IoFJmESUsM
         FI7w==
X-Gm-Message-State: AOJu0YwoaUQJ0O84eyTaWL/KnpHFBeP0c95bhKKvgaq5ZFtAOF1zwP7/
        j8hLeKCVBZ25Hcijq7U0SzfXAJ6OzyqhY65yk1eM/VBa
X-Google-Smtp-Source: AGHT+IFMO9X+3Am1KwzF08GGoQ5HFP2tYrL6AOW3aZp6WOfjEbbjotKsM+LFr3zY3pUObJgkzYLxcg==
X-Received: by 2002:a17:906:10cd:b0:9a1:ea01:35b1 with SMTP id v13-20020a17090610cd00b009a1ea0135b1mr5904549ejv.62.1694969191570;
        Sun, 17 Sep 2023 09:46:31 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id x6-20020a170906710600b00992e14af9c3sm5239180ejj.143.2023.09.17.09.46.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 09:46:30 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-52683da3f5cso4741212a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 09:46:29 -0700 (PDT)
X-Received: by 2002:a50:e70a:0:b0:52a:1d54:2534 with SMTP id
 a10-20020a50e70a000000b0052a1d542534mr6243521edn.25.1694969189489; Sun, 17
 Sep 2023 09:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230917091225.6350-1-brgl@bgdev.pl> <20230917091225.6350-2-brgl@bgdev.pl>
In-Reply-To: <20230917091225.6350-2-brgl@bgdev.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Sep 2023 09:46:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjr5N-2ZKgn_gPaMapprn1vbBxzsdp4fJY+2iC=1H2T5g@mail.gmail.com>
Message-ID: <CAHk-=wjr5N-2ZKgn_gPaMapprn1vbBxzsdp4fJY+2iC=1H2T5g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: sim: fix an invalid __free() usage
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

On Sun, 17 Sept 2023 at 02:12, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> +               has_line_names = true;
> +               max_offset = max(line->offset, max_offset);

I really don't understand why you kept this old broken logic.

I sent a much better version of this function that didn't need that
pointless has_line_names thing or the 'max()' thing, by just making
the code a lot simpler.

Whatever.

> +       line_names_size = gpio_sim_get_line_names_size(bank);
> +       if (line_names_size) {
> +               line_names = kcalloc(line_names_size, sizeof(*line_names),
> +                                    GFP_KERNEL);
> +               if (!line_names)
> +                       return ERR_PTR(-ENOMEM);
> +
> +               gpio_sim_set_line_names(bank, line_names);
>
> -       if (line_names)
>                 properties[prop_idx++] = PROPERTY_ENTRY_STRING_ARRAY_LEN(
>                                                 "gpio-line-names",
>                                                 line_names, line_names_size);
> +       }

But I do like this reorganization.

            Linus

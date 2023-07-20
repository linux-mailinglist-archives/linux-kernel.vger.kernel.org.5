Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33C775BB82
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjGUA0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjGUA0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:26:18 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBC130E4;
        Thu, 20 Jul 2023 17:25:54 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-56598263d1dso975432eaf.0;
        Thu, 20 Jul 2023 17:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689899132; x=1690503932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKQ1SX7sz20Rq+RgVuW3lmkwQjRCN042BG35SDexWJ4=;
        b=C80m90DQz974zcdRW2gPrYhnXnn+FBLjrMvye70Jb0fSYRaYKkftFOoP/ktiC9zbXs
         VpJr6USIzxdJSIMDXhuvW7WjLYYtnSdmviaBZfyw8OAMP//KMeX0JqYC9Z2U5LpskA3J
         X/ZH0kb4tI9s+Q6M5OQnNsQUSD6V1GBObgVAnCe5l6Jlt9iC6oXJO0ONtmMKYBnVvfvg
         UTV+C7NIFrZEG6dQztQkmHNmlmG25OP/4A6LzOgRjAQNO0SEPNZesfsyrjQB0fmdsoN5
         AsBu1FdasNg4Z1An8D31djLM2dWbzhm+lzh/it7Pk5ZE+6j48ytkrctkp7hLKFZ5tPqg
         RXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689899132; x=1690503932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKQ1SX7sz20Rq+RgVuW3lmkwQjRCN042BG35SDexWJ4=;
        b=GTR829kx+zyRlbUqbpsYdW49TyY/xFo2SjC4FocOxJT3oTtbrbX4dodhfmBeNdgar0
         uBa0kTDHbbyK8g+HJEWahrLo0VSx1dChjXukyFl70SjK/Z/HEFdJXLf3VFTt1WKXlDVN
         8PWg8SlqNzOKQJ0pNiZ4XMtbZI1Wkuk8RYu1x98Dya5TiesbmvtNP+2n6annqpm0lZM9
         D5RvcxiXSed2u5T0TvS2Mqfg/b6fdUNiREUzB4OMCSj0uqyepEfSdP/BaOttQTRQGgJV
         PLnGd9Y+Fw8wHZhd35q2pT+QnmkoTNNCrr54NkFRK0aF/m1h0+4kgJBqC6BDH7zqPirA
         BqnQ==
X-Gm-Message-State: ABy/qLZn/LSYHnadtgL0ldWK0G5DV4huM9Se+qj7a3XnzG2BCSDjL8Mw
        eej9xBoY/f3EOfhEmJXj7R0=
X-Google-Smtp-Source: APBJJlFe1hCODkk6vRGjnezWT0EPGPPaWbZkM7wT0oHqbRCQnjzEh9JA0pY5kQ0iHGLqN5Ju1cHTcw==
X-Received: by 2002:a05:6808:1929:b0:3a3:7c33:9a0d with SMTP id bf41-20020a056808192900b003a37c339a0dmr609273oib.48.1689899131926;
        Thu, 20 Jul 2023 17:25:31 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t25-20020a056808159900b0039ee1de4e6esm928210oiw.38.2023.07.20.17.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 17:25:31 -0700 (PDT)
Message-ID: <a8105c9b-2a20-51c5-462c-4d28b8963051@gmail.com>
Date:   Thu, 20 Jul 2023 11:02:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] rust: init: add support for arbitrary paths in
 init macros
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Asahi Lina <lina@asahilina.net>
References: <20230719141918.543938-1-benno.lossin@proton.me>
 <20230719141918.543938-9-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230719141918.543938-9-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 11:21, Benno Lossin wrote:
> Previously only `ident` and generic types were supported in the
> `{try_}{pin_}init!` macros. This patch allows arbitrary path fragments,
> so for example `Foo::Bar` but also very complex paths such as
> `<Foo as Baz>::Bar::<0, i32>`.
> 
> Internally this is accomplished by using `path` fragments. Due to some
> peculiar declarative macro limitations, we have to "forget" certain
> additional parsing information in the token trees. This is achieved by
> using the `paste!` proc macro. It does not actually modify the input,
> since no `[< >]` will be present in the input, so it just strips the
> information held by declarative macros. For example, if a declarative
> macro takes `$t:path` as its input, it cannot sensibly propagate this to
> a macro that takes `$($p:tt)*` as its input, since the `$t` token will
> only be considered one `tt` token for the second macro. If we first pipe
> the tokens through `paste!`, then it parses as expected.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

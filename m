Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738CD75BB81
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjGUA0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjGUA0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:26:17 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7689C270D;
        Thu, 20 Jul 2023 17:25:52 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a1e6022b93so992628b6e.1;
        Thu, 20 Jul 2023 17:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689899127; x=1690503927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VeltO9PjU3Yqjbdf6G2ByRCeL2krBZR93hUWkSW1uTM=;
        b=idOpyw0MlYvoYEDzVBsa0aQ2Rn8KOjoNY5Vlxc6aWEqi3bsw/DA80M9us1xnvIFPsh
         Lce2jPTHoBCzlsROrUuJ+En5Zh98C3lPDQfYh8PauAWX/Vqc23jSqCkBjmY7QUDsCJhd
         l8vB+08ezhvBz1G/Vnq4j6EBmRCtWEOKNi3inRJMCz9oSWOOG/+vv1JuadQMeZiTv3qH
         NqEV5u0ynugT1k3TXOBa+KipJ99ZzxxTYDvnqkeCkYynckplRpSgIyswg0vBX89h+Qym
         OXEz7fk/bM3kHmoIYMK9E4jif74mLwCPRDx2YcK9LA6D7mWStMzryrAMnkHy+2pi0RDP
         cdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689899127; x=1690503927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VeltO9PjU3Yqjbdf6G2ByRCeL2krBZR93hUWkSW1uTM=;
        b=TaGjivAp39ceUKIYT1wdM7Y7WIRtpu7iTKVzmNkZX2ugr2UbfzWqxyi5l2J4XFdb/F
         Rfa3XsCXoW05k3uvgeoeAAV2xUdDP2F5yEN1Bp/hBLc7b6ltvfSNvetM/D1VY92j4Uya
         y47xbnUnTnAm3qGjUFyasT7NKx/puIsUJ9eVgM2qZV0BJgD1r2QESb5IPPIBCWgyEQC2
         PYOLRkjMn9xe0xYk/tp1V9k7cpG9EEDQGhEi0FnVf35xw+EQJXBIoVysrhIJ2EAIUbIH
         M9viEo+4+uYeSYuVZJduHoJZtYYurHB3tJcPJdELzO9RLQeYRMlSFp6KZRzC+7X0A4uS
         Bzkw==
X-Gm-Message-State: ABy/qLb9wpeFnWUm0d8ZnG8VsSLEkYRWoXN07HMVxFP6PCKw4RzQdAmj
        Fqe3+78U0XLuKE811C88hSo=
X-Google-Smtp-Source: APBJJlHTfYgW2E0t+18/rxfWddD/5Sxtr5z4aaTUZrbL+zoqJZYmCA8+Ea55ghjZw6xPYSj/lKlqBg==
X-Received: by 2002:a05:6808:c6:b0:3a3:660c:bdb0 with SMTP id t6-20020a05680800c600b003a3660cbdb0mr450469oic.54.1689899127705;
        Thu, 20 Jul 2023 17:25:27 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t25-20020a056808159900b0039ee1de4e6esm928210oiw.38.2023.07.20.17.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 17:25:27 -0700 (PDT)
Message-ID: <486a1bce-dccf-b7a9-a600-e9b8a8f36a97@gmail.com>
Date:   Thu, 20 Jul 2023 10:59:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] rust: init: Add functions to create array
 initializers
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
 <20230719141918.543938-8-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230719141918.543938-8-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 11:20, Benno Lossin wrote:
> Add two functions `pin_init_array_from_fn` and `init_array_from_fn` that
> take a function that generates initializers for `T` from usize, the added
> functions then return an initializer for `[T; N]` where every element is
> initialized by an element returned from the generator function.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Reviewed-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> [...]
> +/// Initializes an array by initializing each element via the provided initializer.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// use kernel::{error::Error, init::init_array_from_fn};
> +/// let array: Box<[usize; 1_000_000_000]>= Box::init::<Error>(init_array_from_fn(|i| i)).unwrap();
> +/// pr_info!("{array:?}");
> +/// ```

Rather than debug printing the array I'd suggest to assert the struct
size or its elements instead.

> [...]
> +
> +/// Initializes an array by initializing each element via the provided initializer.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// use kernel::{sync::{Arc, Mutex}, init::pin_init_array_from_fn, new_mutex};
> +/// let array: Arc<[Mutex<usize>; 1_000_000_000]>=
> +///     Arc::pin_init(pin_init_array_from_fn(|i| new_mutex!(i))).unwrap();
> +/// pr_info!("{}", array.len());
> +/// ```
> [...]
Same as above.

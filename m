Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE207710DA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjHERQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHERQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:16:39 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28AD4224;
        Sat,  5 Aug 2023 10:16:37 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bc8d1878a0so2818290a34.1;
        Sat, 05 Aug 2023 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691255797; x=1691860597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rL5SC6y9dvPzUYDybQ3gGjXw2kJahDYfGuXDmzq8TRU=;
        b=HVzupGpnwS5LMs8J3dtms6njTuahOpoHhg8W6nY+TQQ6btKzbyaHtVM8BoBT9Qvt4l
         V8JWgz7JNYeR7/hJnFJ++gu7U1TLOvuZqjvHk5lld+Y/a7amzlSROfTRh5+nnPTul6IA
         KMTip2b+Y/lziq7UbH2/spXusoY+dM4BGjkHT69irlxRkN/QINu8LhjMvRwufX6Xd3Y9
         1HgsPqPYjkmoj3WmbrML6rJSxJVPm2VQy7hvHl4Ta1z7oJhjuju0W+j2IZdVKYTZaAqM
         VCZC512Tdr55V4NE4iNw8oMiar9wmYf0vlJonjFqA5plK/Y9VolYCB29SIM8fyOy7Zp7
         K0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691255797; x=1691860597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rL5SC6y9dvPzUYDybQ3gGjXw2kJahDYfGuXDmzq8TRU=;
        b=Jlg7yTxPUdiEyU+mnTT9TiGvk9QNYiyrUF8AN0BxB/DWC6q0Jl7vzcxNwgt4/LtiRQ
         9mED7+QMIiH5j8vlVHKkFmvVvGspjY/pPXyRALie0pUaG5HqpC+b9jI8qf8B/nuB2oTu
         IuHquCAIEJ/OdQ278gRfStwGKdbyjvx2NMlDDyyP5Zr1adYrwB6XTgHH5b82Llh/QqAL
         W6hutAQIC/jtVHL3gYpxmO/pQcZBi7rbj+igK/rZ+uYMoXrze9HwU1fAEDj6ja7Yw579
         lWqOVj5SHv2fUxrl13+8IXmFUBxZJ+/tYGlU0hVcGmNMk4nonfCAr/I1ICBog2Fo+UXh
         UTpw==
X-Gm-Message-State: AOJu0Yz4zaLCe9KV06QQKZutgyxWN73Pz8kestdJBAQUB6n0qEfagtYI
        OwknGGOWCVcVRO9FvgyMEaU=
X-Google-Smtp-Source: AGHT+IE8KWOjass/oUeMAwJ7dLFuqUQP9oeFZ8gxkYV7jFa8TCkuZiadUxzgUq5CUNtAuD49DePnKg==
X-Received: by 2002:a9d:6a4b:0:b0:6b7:4a86:f038 with SMTP id h11-20020a9d6a4b000000b006b74a86f038mr5882933otn.15.1691255797131;
        Sat, 05 Aug 2023 10:16:37 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id r7-20020a056830134700b006af9d8af435sm2702963otq.50.2023.08.05.10.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 10:16:36 -0700 (PDT)
Message-ID: <b3c013cf-8447-4159-8fb9-a4e230689450@gmail.com>
Date:   Sat, 5 Aug 2023 14:12:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] rust: init: implement `Zeroable` for
 `UnsafeCell<T>` and `Opaque<T>`
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230729090838.225225-1-benno.lossin@proton.me>
 <20230729090838.225225-11-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230729090838.225225-11-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/23 06:10, Benno Lossin wrote:
> `UnsafeCell<T>` and `T` have the same layout so if `T` is `Zeroable`
> then so should `UnsafeCell<T>` be. This allows using the derive macro
> for `Zeroable` on types that contain an `UnsafeCell<T>`.
> Since `Opaque<T>` contains a `MaybeUninit<T>`, all bytes zero is a valid
> bit pattern for that type.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

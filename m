Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0F975BB84
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjGUA0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjGUA0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:26:21 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124FE30F3;
        Thu, 20 Jul 2023 17:26:00 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a3b7f992e7so992485b6e.2;
        Thu, 20 Jul 2023 17:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689899140; x=1690503940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8re1DDESpFwS5iE50jeCc4KxITfQ7pjxebZ/KISRzDI=;
        b=HSmPpJXAqq+n+Xn0PgOj5d9xWy3K/OO70HmsGzuwRjK25LXMGmVFrEtRqEDzyr7IZ0
         Lx6kvjQHnPluFbRtjyvvH5ktR16q5ZHEe2mqXFUEayHF+ZcQknEcVeMFoGJwSvMtNSIJ
         sk6r9YCO7aj55vyKERsRdorwZkMxmWy//QCHracLvP7XP9UotvD4jllhkecZOipiM18H
         FVfatieM0mi2WmWmI8Upit3M004kmehcHALyYEQJfWdmWovCS+YiqRGqz0er2IRkrQ4c
         E6hRJ3XZftiIBr3PibYRaQJWSEvOjFq49BF9GkRzTuQmw2v/Vkr67kAvDx2yZvj64QTT
         WBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689899140; x=1690503940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8re1DDESpFwS5iE50jeCc4KxITfQ7pjxebZ/KISRzDI=;
        b=X3gfYnX9W4tnRwRUCt7fUdl0akAjE6DaRyN214UiCTr/CecbP0fzApE1jVxC/ohIe/
         5xldRIVMnYjlGvEM+fG9QDSrOBe0t3HOGK1kgawRp29AekxGp8oMNJtkDmIz4Jlm/t2V
         kkqdzAR9WZNRX9KXJflQqTdFVbGZI+sECompx2fdUxpxvukKVYXsA4H6xZBkuJKfWQyj
         3ykv0jJjuGYuqlWW3bNztnwqfn6xa2zWTBLcNd2eEtTyZqo5plTHgcHrTxKlmpilSzQk
         1XFOWEGMIVKmlVVIHZmChyEcNi1onVVO/LINEVMLpxdeA601IVZOmKaiKCfF+wkuapAS
         I4Gg==
X-Gm-Message-State: ABy/qLZuGyFan8ArOZNeFtNr5i74UFXRIbjeXOHSJzrCTaiCkX+tAsQw
        KnbEJMW1fTlkyPr/WGTfKDs=
X-Google-Smtp-Source: APBJJlF+n9hpzWKRizh91wBAn0NYCHLmgbKA6Z6YsxH1ZjZkSimp7W7sw8sjLa2SnYiT35H8LrijZQ==
X-Received: by 2002:a05:6808:a89:b0:3a3:f1b3:9b8e with SMTP id q9-20020a0568080a8900b003a3f1b39b8emr425039oij.28.1689899140368;
        Thu, 20 Jul 2023 17:25:40 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t25-20020a056808159900b0039ee1de4e6esm928210oiw.38.2023.07.20.17.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 17:25:40 -0700 (PDT)
Message-ID: <81c02c89-c861-7b50-606f-f9bccbc099c4@gmail.com>
Date:   Thu, 20 Jul 2023 11:07:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] rust: init: make `PinInit<T, E>` a supertrait of
 `Init<T, E>`
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
References: <20230719141918.543938-1-benno.lossin@proton.me>
 <20230719141918.543938-11-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230719141918.543938-11-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 11:21, Benno Lossin wrote:
> Remove the blanket implementation of `PinInit<T, E> for I where I:
> Init<T, E>`. This blanket implementation prevented custom types that
> implement `PinInit`.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> [...]
> @@ -968,6 +956,12 @@ unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
>           Ok(())
>       }
>   }

I'd put an empty line here, so to separate each block.

> +// SAFETY: Every type can be initialized by-value. `__pinned_init` calls `__init`.
> +unsafe impl<T, E> PinInit<T, E> for T {
> +    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
> +        unsafe { self.__init(slot) }
> +    }
> +}
>   
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

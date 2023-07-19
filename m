Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F3275BB7E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjGUAZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjGUAZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:25:44 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D5B30EA;
        Thu, 20 Jul 2023 17:25:19 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a37909a64eso952361b6e.1;
        Thu, 20 Jul 2023 17:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689899118; x=1690503918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFIBwtmo2IIbiaxwKJGeWrtXlnHB7ucvw4QiyNqWMKM=;
        b=AgDHG+aPobDVWwpkGdmJ4jWljkAyKr7gH0LrLyhn7+Jp7Cw87ZYdFOmtiZarT6mdjL
         yEPVyQdjSXgp+gq1oXxngeaGn1aqTlIrYYOQSudkxsI8OHljGw70fTMobH0hItNbgpuR
         77rr1YlT5/aSwPSxYHoBns/bUNj2Sj2sih0fnMrO3yZBDAozPoQGBUDeEqyCmqOMuh8t
         x9p0rKhbq+S0mFBZW169Ej/6lePLEK/UPzIqGuF0XOLw+uFYANW5+8a4dYd+4bDwOadE
         nZhNOKuaBydaUeBeJfbao0bD4iib63Y/5LWUkZq06Zp3MLcINWk8fpx+Af4SP903OUfS
         PCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689899118; x=1690503918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFIBwtmo2IIbiaxwKJGeWrtXlnHB7ucvw4QiyNqWMKM=;
        b=KZWvwMRdmRj1HUGRAsZeVCQULXcBLXHpg6dh05wz1y7WqU2nER54j+3aJRge9Fe8S0
         SSCJYNVn80wHVgdiZDpfXKS/WOplr/qtcF9MtBw5DlRTm6vG25I8ujr/qRgOaqkHohdL
         fRdXsY3KLzzTT2W56kVgGahS7aCtk0FELOnunuGDiDxvFBM6NhG/Xn9P1mZXFTG07ya1
         W4FhCzY5XU4GT628CgzIgCiWnKqgVpeUPIlH6dAZelNEjmRAGBo/KWUphnShNFJv0O9u
         NlUtiMVBesXuev/WW8Ye2Q6rxoKL3SMpGuCoec+4+XVOOnajbYAkx4xD3McMffoPpe7R
         DbSg==
X-Gm-Message-State: ABy/qLaMDSFS5uy1NoRBJep7Bfx+N18OONeXb6oUPg5j/nCpLYZcOLHS
        I1sf7Hf6ymDNTq/69126IWw=
X-Google-Smtp-Source: APBJJlGgB99Rhaf0oBq3kzK9ReZbPQ5DtRmjDFUepFyssJtRnAL679aMVLUM2I4YQjXo2sN+lY+ALQ==
X-Received: by 2002:a05:6808:1409:b0:39e:5892:8539 with SMTP id w9-20020a056808140900b0039e58928539mr586637oiv.9.1689899118692;
        Thu, 20 Jul 2023 17:25:18 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t25-20020a056808159900b0039ee1de4e6esm928210oiw.38.2023.07.20.17.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 17:25:18 -0700 (PDT)
Message-ID: <41d543d4-ab21-d10f-f484-4d5360fed7c2@gmail.com>
Date:   Wed, 19 Jul 2023 16:07:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] rust: init: make initializer values inaccessible
 after initializing
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
 <20230719141918.543938-6-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230719141918.543938-6-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 11:20, Benno Lossin wrote:
> Previously the init macros would create a local variable with the name
> and hygiene of the field that is being initialized to store the value of
> the field. This would override any user defined variables. For example:
> ```
> struct Foo {
>      a: usize,
>      b: usize,
> }
> let a = 10;
> let foo = init!(Foo{
>      a: a + 1, // This creates a local variable named `a`.
>      b: a, // This refers to that variable!
> });
> let foo = Box::init!(foo)?;
> assert_eq!(foo.a, 11);
> assert_eq!(foo.b, 11);
> ```
> 
> This patch changes this behavior, so the above code would panic at the
> last assertion, since `b` would have value 10.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

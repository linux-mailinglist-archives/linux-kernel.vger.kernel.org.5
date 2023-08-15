Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FF677C4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjHOBEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjHOBEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:04:08 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99525E65;
        Mon, 14 Aug 2023 18:04:07 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bd0911c95dso4458570a34.3;
        Mon, 14 Aug 2023 18:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692061447; x=1692666247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9HOC4ki6E5bzT2JuiqqGPDcSiKjjcSrTtPrdwQPQGz8=;
        b=jbYOJKt2HrwiG9nGKVPbLLAqsekGwWN9YHjlnysZeAn2YmLpkr8tMF9tD1JZvAKYGJ
         vbEmimNdaUYAI0wPBlwg4EMnrLuofS4DS0D8o7hf+znUu75sSQ5XpvQCmRgxPeRg6EUg
         dTb2llVelhI+k/aUayXYMyyMaxMMhaqDXsllbybpIoP8Z2kOQM1pnG0EFkNljIo0AlvG
         zT9IbYZ1FsCTBa5gCuIXOnY1PEn61nTlmxGp0N9IrTsg1i0xQvHmdjYKYv8whU2MBhrc
         NWQa7kVLuzZviA4ZV6Ywt4xsfC1yruywlS26IRrZDXBKph1PuY4RTBY/DkL9Ir8Rtqq4
         GqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692061447; x=1692666247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HOC4ki6E5bzT2JuiqqGPDcSiKjjcSrTtPrdwQPQGz8=;
        b=eYAwVRhmnWQOPeYaXSQXllUC1HgXnSKB3DlDwxCTzI3MG7dtZ1hk8G0rU0RTzXmelM
         mWeTnJs/bN+SIIBBClVuCgzieuegWOP2tmWyZQHbarbZz7RahwMUyzqq7W7thm1fS7WP
         KqK6Z93XXanb7ICDoI4wrlotYYQw0xGuBiTLsy0o36FQgJ2Biadp88ItIzaAM17V51Hu
         92/DWiUVTyr3VEsgak1j+SRckEj7HKWM/KBaJ3sciEU0vGHtdji/ZuIhXFJgxDUJl+Zb
         RlyhGh8aCLhPDMZgIcOn+CODJye5TVyaXB/U5ItBauitxzRKHy4k1DnFCPZE9IL4/EFK
         DTKA==
X-Gm-Message-State: AOJu0YyJHMdDS6VQq47rCsCS9hFbB1W9/dL/ja3xqHzXTxfzQCVjaY5c
        l0bxQypuGsA/CnYCzHDX1mU=
X-Google-Smtp-Source: AGHT+IFjL4ZIFRI3nxNAgw+fCZpcg4FoDRRJtnLZcUwYFTqwnD757hfZPvlq7Ph81yECYktr9ladPA==
X-Received: by 2002:a9d:6c5a:0:b0:6b9:2e88:79cc with SMTP id g26-20020a9d6c5a000000b006b92e8879ccmr9978004otq.19.1692061446767;
        Mon, 14 Aug 2023 18:04:06 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id v10-20020a9d7d0a000000b006b87f593877sm4781985otn.37.2023.08.14.18.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 18:04:06 -0700 (PDT)
Message-ID: <ff20038d-8b42-471d-b625-8cf0e343a915@gmail.com>
Date:   Mon, 14 Aug 2023 22:04:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/13] rust: add derive macro for `Zeroable`
To:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
References: <20230814084602.25699-1-benno.lossin@proton.me>
 <20230814084602.25699-4-benno.lossin@proton.me>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230814084602.25699-4-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 05:46, Benno Lossin wrote:
> Add a derive proc-macro for the `Zeroable` trait. The macro supports
> structs where every field implements the `Zeroable` trait. This way
> `unsafe` implementations can be avoided.
> 
> The macro is split into two parts:
> - a proc-macro to parse generics into impl and ty generics,
> - a declarative macro that expands to the impl block.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> v3 -> v4:
> - add support for `+` in `quote!`.
> 
> v2 -> v3:
> - change derive behavior, instead of adding `Zeroable` bounds for every
>    field, add them only for generic type parameters,
> - still check that every field implements `Zeroable`,
> - removed Reviewed-by's due to changes.
> 
> v1 -> v2:
> - fix Zeroable path,
> - add Reviewed-by from Gary and Björn.
> 
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

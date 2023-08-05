Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4C87710DB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjHERQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHERQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:16:53 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A65421F;
        Sat,  5 Aug 2023 10:16:44 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bca38a6618so2783857a34.3;
        Sat, 05 Aug 2023 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691255803; x=1691860603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tlgFUrfwkd93DPT5NqDrRN88RXNQ2a4I+m8qQ9rvrKI=;
        b=hYeZOHpPQK8RFulsfbHf9ZUwDgKyabavdliujDu/PuWcIboLBC2FoFYtS0qDrTkfJg
         hLZRe/I6ZVs2HrNMdsXXQy/b2Zi4Hd76AtDzgKY7mBhDCWO3kfA5lMDq3rgeztZzg9RS
         y0ueH0bVqXuFzLJv8K7B9tE2F79N/yza0YpXYWUTmqAzfJjXjtUJ+yWMnxoLWNgadUvh
         EJjv4jI2yEB0WJnUKTdJqNVGWcuzD1f7Wd0RVctg5vTTI8Py2i+cFDGJ60JbxEnBS/Rr
         afpi15g8dYKnTimlVRCLmOh852V7Wq92v4yZKOrTptTQy1C8rFt5lg5+9BZMS3ee1Rp9
         1mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691255803; x=1691860603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlgFUrfwkd93DPT5NqDrRN88RXNQ2a4I+m8qQ9rvrKI=;
        b=NXMcqW3EgHXvaJ3sujNE94n2l8FLvx9G/LRpp6FlLRqsdV2cr6pW/+WaRcGHkWsovN
         MypTBSV1P16dTQ77HDIah98rku/A7gfIRwSvOVT5V00hJ8RUSXcE2TAz7X3HtghfHrwT
         VumPT7dpg1LdSIwNm3TjIC9m0GhtgWEd3LmiBugXKU+54dB+HJsD9juq6+akBxDMEKEe
         SQiVaqS2ejuhZhct/2nDPq3IYA+p5Z2hvdEKN6A0Z7TihleNF0GVsgtjAV2IkfAVGJge
         mdTIyWjga0t5IN+4pdoOOCPv+TF3ExOnpjdpc74/h+EEZHQx+NZhBxNvAweFV2jK8fHL
         Umrg==
X-Gm-Message-State: AOJu0YzQlJlqlnqDv1PdekHxcsx+FKEFC+r6wrvagAG4b1kjHHbvVaXL
        4di/YnE2ZwmVQTV0hUSm8Ag=
X-Google-Smtp-Source: AGHT+IEwuhbnxdDEaD8ad87vIkEfQKmcnCCy0VrglOlkjtE77TBzFGrDJWAPiqRl3y0N3K2sR3kRTw==
X-Received: by 2002:a9d:4813:0:b0:6b9:b1a7:1f92 with SMTP id c19-20020a9d4813000000b006b9b1a71f92mr5283946otf.8.1691255803327;
        Sat, 05 Aug 2023 10:16:43 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id r7-20020a056830134700b006af9d8af435sm2702963otq.50.2023.08.05.10.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 10:16:42 -0700 (PDT)
Message-ID: <a481246e-a3d5-4b63-8acd-6da5e2636645@gmail.com>
Date:   Sat, 5 Aug 2023 14:15:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] rust: init: add `{pin_}chain` functions to
 `{Pin}Init<T, E>`
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
References: <20230729090838.225225-1-benno.lossin@proton.me>
 <20230729090838.225225-13-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230729090838.225225-13-benno.lossin@proton.me>
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
> The `{pin_}chain` functions extend an initializer: it not only
> initializes the value, but also executes a closure taking a reference to
> the initialized value. This allows to do something with a value directly
> after initialization.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> [...]
> +    /// First initializes the value using `self` then calls the function `f` with the initialized
> +    /// value.
> +    ///
> +    /// If `f` returns an error the value is dropped and the initializer will forward the error.

It's way more clear now... Thanks!

> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

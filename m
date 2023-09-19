Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD507A6B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjISTSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjISTSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:18:21 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9ABB3;
        Tue, 19 Sep 2023 12:18:15 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6c0a42a469dso3811950a34.2;
        Tue, 19 Sep 2023 12:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695151095; x=1695755895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCBXfknjcKlJ87Ma2vPA5KpThwoWvwYiLk2uZMEjHCA=;
        b=R6Uqq19BPR1oFzbl0m7XtEaIJ6ufIf9ngOQ3OxG4hCIwAXEw3GB6qCd7TJTgPscnhk
         vkYaqbcoPaW1hccKAqsb95rCCUG+tf9Yw4Tcx+4Ls6vxMxb5/IdtMLIP/n2aFE2faZLq
         YD5pntjSfXO5xsaesJtCFuiP9ZE+0YZaJM1LvNp9RZE2Fvp00du8kzUc9tvb+091wcbr
         duBuR5NZWW07mwGbe3vshYZR1OZXWy0DRu189hoNFXZgfd364L8JmDwgt6o9sphJ23b5
         YEHojBiAAuSYd/XU5iwA6D0Wan1xzU6XDx9F1wpcbwWxbZAmHQky8yT5hS5MXbxr6/n/
         45Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695151095; x=1695755895;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCBXfknjcKlJ87Ma2vPA5KpThwoWvwYiLk2uZMEjHCA=;
        b=WHbYDXICcPtUdpaRdN1qzbalkAWMasqUg9sJ30DjXOgQak21cQS3bsio8DgQYC8A07
         tw6JY2SW2IEEs+oLO+fAvuEORwhjVz6iWVOV2a1iG3hs/3Nm0KhrnD1iKeDFKIIr5mIk
         DnVHXA2BVoT2E4CZ+Dc8Ra+HVK0+0VvgySQOQQ6mVzS0EOTzmwzXUPyCz2Ck30Dqv61C
         6mxAoTHfGLfwZ7LsheK4/koVfXEi9Rw7pugVPopbKXMk9ZIeBi3OgGGoN4Xf1SswO0wZ
         0yHf1HnRwqkr3GtYAX8+Ckx0YRAjTWptA1CFixwuU2mQm3gv2a/jBPjMvEAoY/i+pvWe
         BEyg==
X-Gm-Message-State: AOJu0Yy3JC1+oXdS1wfLnB1LhjvdfmyPvhecqxzP0DFljdXyYjFNpG2A
        PK68YHwNoHY32W73AEe2ATw=
X-Google-Smtp-Source: AGHT+IFPnR50kUooGoy4QaFEoPXgx8xMzh6YGAm994Z3Zd28H2mMjA7xcD70u4YD1lZSS3AdffOf3g==
X-Received: by 2002:a9d:7549:0:b0:6bd:67c:ba9c with SMTP id b9-20020a9d7549000000b006bd067cba9cmr527494otl.35.1695151095049;
        Tue, 19 Sep 2023 12:18:15 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id p9-20020a0568301d4900b006b9b0a08fdasm5297744oth.59.2023.09.19.12.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 12:18:14 -0700 (PDT)
Message-ID: <80964285-ec54-434e-8c36-9efaa363f126@gmail.com>
Date:   Tue, 19 Sep 2023 16:18:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: Respect HOSTCC when linking for host
Content-Language: en-US
To:     Matthew Maurer <mmaurer@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
References: <20230918234412.363087-2-mmaurer@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230918234412.363087-2-mmaurer@google.com>
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

On 9/18/23 20:43, Matthew Maurer wrote:
> Currently, rustc defaults to invoking `cc`, even if `HOSTCC` is defined,
> resulting in build failures in hermetic environments where `cc` does not
> exist. This includes both hostprogs and proc-macros.
> 
> Since we are setting the linker to `HOSTCC`, we set the linker flavor to
> `gcc` explicitly.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
> 
> Updated the patch to reflect Nick's comment that KBUILD_HOSTLDFLAGS
> should be respected as well.
> 
> I did not switch it to use HOSTLD for two reasons:
> * That variable is not globally defined - it is only available in two
>    subdirectories of tools/
> * C host scripts are linked by HOSTCC as well, even when linking a
>    collection of object files. It *prints* HOSTLD, but invokes HOSTCC.
>    See scripts/Makefile.host cmd_host-cmulti for an example.
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

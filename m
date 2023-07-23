Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A4875E2B0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGWOfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGWOfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:35:03 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C4610F4;
        Sun, 23 Jul 2023 07:35:01 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a4062577c0so2959337b6e.0;
        Sun, 23 Jul 2023 07:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690122900; x=1690727700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hVbV6PPK4bQ78C5FPPLzZso3da8dxH89LJc/QzUTSs=;
        b=JWkEpKntYVBuB6E1XatdkZtXVt73rBdbJGE0d5xAPFTEdSwmf1jYbPKEAkJ5idN9vp
         rOMBT5zkC+hVmjV9TjJgbwKTmp7UDHFUI9lUvYfO8lUVBuSiayofy8aYl37TXi8X0EKL
         WLVmd+C8Vq99HWrh5qX7sEBbThTiQQLhrJ8fOvojX0WBR9DtDnHa4oNpR8oEphZg0/eL
         7TrkmgyrCmaPcgunASu/NKKyV12TUOHmbv+BsHvMg04fCAFCuO8TwyeDa+6nlZwYsQ5s
         zIXUVVwuEAAdsfPyuHZgq/A6XSg6O9ht63J+4nZY0QH6J+Lz3kbDsbecxAbpRXECwaxR
         8sgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690122900; x=1690727700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hVbV6PPK4bQ78C5FPPLzZso3da8dxH89LJc/QzUTSs=;
        b=LlMt0f8h5m0M5N9x2FO0ltG9CDdK55AMIZz9sWCJjD8+LwQmleBD/3YZ48jWuo7DfE
         xMH9NKdaTj8lE24Ln/Dw37C83iLZguh+UnTxEmOOokGKH0zWs/V3glp8+9vIPLKi2hFx
         3SNZecBcL4eagBXtUs57t5QLb7jIPaM6ITLX/jNZdzv+pbQfZ4vdqnWnM6LHrI5el18P
         hTb435xUkyWkKbFr1qwSRjf4YImWRAG9blcE181Z4wfiFwGTxqfYsiDDVuSAJg5VenWl
         4p1FQFtzHr3z8mNMiqDjp0qPTcmSB+cq/fq+RdZKtQGWoRPX6FTtGSD82q7CA6FO1ppF
         K4qg==
X-Gm-Message-State: ABy/qLZLpprOVOP6BzbOkhEjzmtK6DWkwDPgt+DZGCP1+AmXm16YDwzx
        hGTRRbcDTuwVhP0Qo83D7RQ=
X-Google-Smtp-Source: APBJJlG0yD0GorNtcgbwNsnxx1O75lYChESB8+iiUX9xQbMDeKstYsQPW1OQLn7V8L5A70F1wbfuAg==
X-Received: by 2002:a05:6808:1310:b0:3a1:f18d:2fe8 with SMTP id y16-20020a056808131000b003a1f18d2fe8mr6198281oiv.10.1690122900514;
        Sun, 23 Jul 2023 07:35:00 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id o204-20020a4a2cd5000000b0055e3dd89c12sm3508157ooo.1.2023.07.23.07.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 07:35:00 -0700 (PDT)
Message-ID: <01d23a2c-1e30-b660-7997-6d9c29b9dcf1@gmail.com>
Date:   Sun, 23 Jul 2023 11:34:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kbuild: rust: avoid creating temporary files
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Raphael Nestler <raphael.nestler@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        stable@vger.kernel.org
References: <20230723142128.194339-1-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230723142128.194339-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/23 11:21, Miguel Ojeda wrote:
> `rustc` outputs by default the temporary files (i.e. the ones saved
> by `-Csave-temps`, such as `*.rcgu*` files) in the current working
> directory when `-o` and `--out-dir` are not given (even if
> `--emit=x=path` is given, i.e. it does not use those for temporaries).
> 
> Since out-of-tree modules are compiled from the `linux` tree,
> `rustc` then tries to create them there, which may not be accessible.
> 
> Thus pass `--out-dir` explicitly, even if it is just for the temporary
> files.
> 
> Similarly, do so for Rust host programs too.
> 
> Reported-by: Raphael Nestler <raphael.nestler@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1015
> Reported-by: Andrea Righi <andrea.righi@canonical.com>
> Tested-by: Raphael Nestler <raphael.nestler@gmail.com> # non-hostprogs
> Tested-by: Andrea Righi <andrea.righi@canonical.com> # non-hostprogs
> Fixes: 295d8398c67e ("kbuild: specify output names separately for each emission type from rustc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]
Tested-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

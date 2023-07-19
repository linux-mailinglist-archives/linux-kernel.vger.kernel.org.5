Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CAF759D73
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGSSfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjGSSf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:35:28 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B171FFB;
        Wed, 19 Jul 2023 11:35:18 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a3b7fafd61so5290983b6e.2;
        Wed, 19 Jul 2023 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689791717; x=1690396517;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WPhThja73rMrwtCLzLlEodMjDA/ciBfmdIGUhDH+5vQ=;
        b=X+Z+q0Ps8A7gvg57y6lo4X3jlA2aRilCfFsCwdxkuxGPIk3h0dhuB0CfJYcvPVaLHT
         tQYWNvqAMkdWsYjU/X+IzJMmLjQ+ZOsaZ3iB9O5IzCj/U+OYN1eZP0xT0wgqpP1ipMA7
         OCktBzVSn6oy0dgLtG9dvQsWApnxlWn83JZANN2J3pjWHxQJ63i/vm+zbongHy0TJMUI
         JxRQ4IgT2HaSnqsBCRrKBBE+9gaa6hGPmqjHKwb/LHmQBPM/CABIdr0rBJ/8fj1HISR8
         9ChmX8tSa9KeoSWfSd9eqzLAKW97WbX8wt4zHLhbPI1XNSbZAMyTYyNtl91nbdrjVPFR
         Nu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689791717; x=1690396517;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPhThja73rMrwtCLzLlEodMjDA/ciBfmdIGUhDH+5vQ=;
        b=TkW/KEM0Xmyxk9DTWSOkrTdEhxDDvwr0JqyEC1jz5CD9sYas4jLhJFVTGVteZNz3QY
         ddNkE1tt8PtRIA35npkCxzR82oLRn+tvxWuFtZWhgYuM5HEuhxD1UF4ShMfCAqnIKdes
         tCzHoX+XBxSxJ/jNGHg1OaiIFY5tXt0jOPq/BshT51cwRZmlcNJ/Ub8xYDcVVEwxVQiN
         /JnbxXpSQeDCMJiEHINEdg52MqxQtY9YhvVQhe0ayu2ECDcbwP9y8LkBTEca4oq8Gz/V
         oOLb5B5DVx2ZF+ht8K54JU28s1E2jhmRi4WVXz/+ZSM9ZbmoqKzvydSCn3f1hpcixyyv
         YZaw==
X-Gm-Message-State: ABy/qLbKSjogfbUOxmYD3RSgbLH3L9RHpOrB8fRH12tB84XVJKxjxuVK
        +cUR6vTwqB4YL0GAx0ucsuk=
X-Google-Smtp-Source: APBJJlHVEHlTyIvqzFTB4W0vefUBSAK+mOmKyVCwFbKOOhaY3peS5u1nNan1QlfcMHTg8RLq496Rcw==
X-Received: by 2002:a05:6808:157:b0:3a3:79ef:e2d3 with SMTP id h23-20020a056808015700b003a379efe2d3mr6395705oie.29.1689791717505;
        Wed, 19 Jul 2023 11:35:17 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id y7-20020a056808130700b003a3860b375esm2042016oiv.34.2023.07.19.11.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 11:35:17 -0700 (PDT)
Message-ID: <c3385c4a-1864-e602-379d-fc0184053ea6@gmail.com>
Date:   Wed, 19 Jul 2023 14:44:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH] kbuild: rust: avoid creating temporary files
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
References: <20230718055235.1050223-1-ojeda@kernel.org>
Content-Language: en-US
In-Reply-To: <20230718055235.1050223-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 02:52, Miguel Ojeda wrote:
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
> Reported-by: Raphael Nestler <raphael.nestler@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1015
> Reported-by: Andrea Righi <andrea.righi@canonical.com>
> Tested-by: Raphael Nestler <raphael.nestler@gmail.com>
> Tested-by: Andrea Righi <andrea.righi@canonical.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03EE7A35AC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 15:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjIQNYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 09:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjIQNYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 09:24:17 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B38130;
        Sun, 17 Sep 2023 06:24:11 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3aa14d8641cso2602451b6e.3;
        Sun, 17 Sep 2023 06:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694957051; x=1695561851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WowTavHHUt6VXrXWYAIAmM5GQAVg53+hUmPjaFGm7W8=;
        b=dhyiUTh8x46T1uJ3OtUkdONibVXePNhq4VVgT7hwZIlxRa770kDDjMYeC8WKX4Pgjf
         EaIFRfhanxdwS3V5yhvnpjPGNBmHncrYqds+UMCBbNP6RNUOi+Rxsy1IPcQdYUAtHJI7
         dxvqTJ6i5EMT9PFY+MDjA7NK+kIfGOvbVhsAG2z/W/VfFe4R7tAcuHatHuXHPl/EDem1
         TcjTfnYRI1RosGWB3d4NXyFkcsv+ofHDJEUHhwDn/MVe6Jvfk5gZ1FF3rJLljlxxWyKY
         LmoetcFI9yZmovgoSePSQfUD9OD5O1Thf3PBXY1sN6GScITEiuxsxpM8meigCchSNqDu
         eA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694957051; x=1695561851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WowTavHHUt6VXrXWYAIAmM5GQAVg53+hUmPjaFGm7W8=;
        b=HDKl5yYpnOaUvoQomv8mBMk7zecnzQjCLhY+ulVvtkSsBtk29bFQH+lHIY+o8PwtYk
         JdRja9RM0q/8xQn4I8Wur2BoYvFE1QKb733ReBK95WSkPoDN9VvSJFkqIo2COQm0xpEd
         8yM+18XCGpka/4cK+UJrzntpYYzgcekG9c/Q4jYZk79U7nX6yUpDLgZZ3tkJ6QSTMsD6
         oszNnCBRk7/yJpFl2BH6IuPcwyHHZtecM8OXM0pdFKK1qe4xJqsglxyrEtVIQAyeOhUo
         rH6g1RGH0WmLXe9U4hhkFyGnttfZDgwR6oKum92LQV5LOg6vkqH2+xiSV1nNBr5TLn/J
         +30g==
X-Gm-Message-State: AOJu0YzjYSMMn/JzaYhza+vnDOWhnSBhAOclu8LSIfhC4JkUYSVRdIVU
        x3qT4faNJSPA2D83URxZBvry7RDA27U=
X-Google-Smtp-Source: AGHT+IEKBFAE86erU9orG9yXk0jnwDalBuX9QqwQG8NALM6qlYFHn1bzDFyyAJrR6X/7Bh0MS1fF/w==
X-Received: by 2002:a05:6870:548f:b0:1d5:f43a:3a5c with SMTP id f15-20020a056870548f00b001d5f43a3a5cmr8738173oan.45.1694957051135;
        Sun, 17 Sep 2023 06:24:11 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id zf6-20020a0568716a8600b001d4d7238a78sm3932734oab.54.2023.09.17.06.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 06:24:10 -0700 (PDT)
Message-ID: <0ed5448e-cd54-4a99-9389-e27deddfda90@gmail.com>
Date:   Sun, 17 Sep 2023 10:24:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: Respect HOSTCC when linking for host
To:     Matthew Maurer <mmaurer@google.com>, Finn Behrens <me@kloenk.dev>
Cc:     =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
References: <20230915172900.3784163-1-mmaurer@google.com>
 <9966E047-44E7-4665-9628-169F3EBE2F06@kloenk.dev>
 <SLZSYLg5E9OQKI546K87wxTYYLNlT1xM-LhC4W1JFhIate6PFsKq27RcBNhSjUkErYDlzsZB4F2Vc2KOP9tDThg58_tXycWn3K29mQXlFtU=@protonmail.com>
 <0561303E-2089-43FC-AA31-836C7BB844B7@kloenk.dev>
 <CAGSQo02p0LWZgV8oVidwvN6X__rv3-rj+ZVg9SaZ5Kx+zYahYQ@mail.gmail.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CAGSQo02p0LWZgV8oVidwvN6X__rv3-rj+ZVg9SaZ5Kx+zYahYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/23 16:54, Matthew Maurer wrote:> Yes, thanks Bjorn - "gcc" is the linker flavor used for "Use the C
> compiler as a linker".
> 
> With regards to HOSTLD, I was trying to make the minimum possible
> change. Currently, it is using the command `cc` as a linker, so this
> would preserve existing behavior when HOSTCC is unset.
> 
> If we would prefer `HOSTLD` instead we can do that, but we would need
> to additionally inspect `LLVM` to set the linker flavor accordingly
> (e.g. set ld vs ld.lld).

LLVM can use all of bfd, gold, lld and mold plus each and one of them
support roughly the same set of flags, so we can kinda ignore the
differences between them.

> Do folks have strong opinions between these? My primary concern is to
> avoid calling programs by foo when their HOSTFOO variable is set.
> 
> See https://doc.rust-lang.org/rustc/codegen-options/index.html#linker-flavor
> for details on linker flavor settings.

If I were to talk about my experiences with CMake then I'd say that
build systems tend to kinda ignore your linker choice if you thought
that it was going to be used standalone. I think KBuild does indeed
honor it, so if we can go ahead with that then we could do so.
Although I don't know what else would bring upon the table.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA05B7B271F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjI1VHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjI1VHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:07:35 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E84B7;
        Thu, 28 Sep 2023 14:07:34 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3ae0135c4deso7715463b6e.3;
        Thu, 28 Sep 2023 14:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695935253; x=1696540053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qIlKEJnw0fFoB8aDGwN3C/vOYWFmYPRhpPxSRX2qmyg=;
        b=mrVe/8GS0+AGXo7bS4iO83gLxZFHgUceu6SGPlv3+TYdxLtcJXgmgG0hZFRVqgWuei
         hFwj86nOxFyI1Ce21kFa24SHoHXrWyaOFn6xPYN+sewkxjeNUT4PV02UZFw1Wy2IlBGd
         JaS2nElVhJA48t1IaMyfm7pIe+Flvp1v9XIXb/KBPDeCx1iQet8SdndPfGPiiF+x2KpF
         2iI6k49ZpJYMsnKpllK5ijZBruXPzByyk9XLCFFn2B3T+Mf/GKRDHmykBQshUpEnYZLi
         3l7Rb9RBATxyKkFkVLUz3zJBnwtnLE6op9TpaT2PSotsKIHYLBP8wexJNmaZbqxizUU0
         B0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695935253; x=1696540053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIlKEJnw0fFoB8aDGwN3C/vOYWFmYPRhpPxSRX2qmyg=;
        b=hhEZ8z5tqEsdc1hVOQk1NqoRiHvuh/uP+3wj0TKJFMVtGhstYWXOuVq5D0d6vpdeb/
         v8UycFjVAsJq0MOdpqeXHoNEiKK1gF71m3B1gyuOcYwlhCD9l4WwlLHFbqFbJ+MOPOus
         icCz01mGKPkCn9BT0rqq6NIi8Of6lJz9mtXms8PN8F50gbC28plFKUytGhioy+5ZILvK
         FE/f+4pL2/nZdeDFyU8lwgDDK1ZNOmwYBh/tgnZkTlA4zZBqsZya8C8wgB+1LUdeqm8v
         lv2KJnKKE4uhc8QB17E9VhMfuJ9/cCN/xuDvNU0ZSHNLH/CEKBhoqkf70tikqUuDuVTk
         b+eA==
X-Gm-Message-State: AOJu0Yz4RVEsrIo7Py1WVzo+punqVDobK+FmKCsH8mscb85n4RVLLxYs
        QcZ6jW64m76ICFl3r5tgITs=
X-Google-Smtp-Source: AGHT+IG/wdC9TA1MZk6fSBU2RRw1BACeiIsuv/wTqo+LvBSGWzHVlF55AtGJGT7QdWxF+oHCueXdoQ==
X-Received: by 2002:a05:6808:1450:b0:3a7:5309:f1f with SMTP id x16-20020a056808145000b003a753090f1fmr2846373oiv.45.1695935253446;
        Thu, 28 Sep 2023 14:07:33 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7820c000000b0068fda1db80bsm13766692pfi.75.2023.09.28.14.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 14:07:32 -0700 (PDT)
Message-ID: <91c25e18-ff97-46a2-a50a-493c00bbc156@gmail.com>
Date:   Thu, 28 Sep 2023 18:02:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: Respect HOSTCC when linking for host
To:     Matthew Maurer <mmaurer@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
References: <20230928194801.2278999-1-mmaurer@google.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230928194801.2278999-1-mmaurer@google.com>
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

On 9/28/23 16:48, Matthew Maurer wrote:
> Currently, rustc defaults to invoking `cc`, even if `HOSTCC` is defined,
> resulting in build failures in hermetic environments where `cc` does not
> exist. This includes both hostprogs and proc-macros.
> 
> Since we are setting the linker to `HOSTCC`, we set the linker flavor to
> `gcc` explicitly. The linker-flavor selects both which linker to search
> for if the linker is unset, and which kind of linker flags to pass.
> Without this flag, `rustc` would attempt to determine which flags to
> pass based on the name of the binary passed as `HOSTCC`. `gcc` is the
> name of the linker-flavor used by `rustc` for all C compilers, including
> both `gcc` and `clang`.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---

Psst, next time I'd recommend putting patch version to version changes
here. Still, LGTM.

> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

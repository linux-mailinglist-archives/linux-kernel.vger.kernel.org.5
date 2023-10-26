Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ADC7D8A80
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344880AbjJZVkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJZVkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:40:05 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD2DDC;
        Thu, 26 Oct 2023 14:40:03 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5845213c583so813093eaf.0;
        Thu, 26 Oct 2023 14:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698356403; x=1698961203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/kCC9Xleu4oCsZEw8qSGwEvAQ/otiVovpFVr+FE6EI=;
        b=LuP+gdWIsdfpnbiBETNDxhrm31VQ5VhJhRsC8bm0EExMag/bhQxs0WBJJg0IVa7/me
         2k5VLrYQgqIBBBfgp9VxwQbEfg7iFzoIKe1V9qG/WsSQUTfrqdi2LTNyAyWovpDSzubl
         A0/wgUxzvI9KUzSv4UXFkLLodVwgWo6C+m4rfGUzzSi1WOwpYkMSajfmElZnBhkm3u0g
         4bSV6gpWR29CBWAbAbdM3Vfnf/rUER7azakJ/KIU9al4b+cBI+b4gylZrEMQ57145JqN
         T/wBTVrj4I46OAa94q4+wbUe3Y1XjODXoCeYxZAxTVIdFZLQkBn4Wz1omf0nNrjqwoKC
         wuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698356403; x=1698961203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/kCC9Xleu4oCsZEw8qSGwEvAQ/otiVovpFVr+FE6EI=;
        b=NGO7TizRbS14k0vOATmEdMU5a01r9bYlW73u/PfC9l4ZX+OX5NjEBbNYWgyGIiPg8b
         vHrxEMXOffCBcsa9Z0IHLOGOF6wpGZNB5L3V/xYUlmXooW/wAQ35GNkbHtp04/M6ZIEG
         uH9dRxU+cr4cN3QXXKnKMkLrYLLmtCJpern6OjTnqu7unsxrUNSIVDLhXIkUmHj3LCom
         2pfM1k/Jv02Xa+y0h1rdothjMrEuifwgktsCpi+hQQIiQ37M9FpJ40nKEoC2BUK7eshN
         FB10OjLe5dS08MqHut04KtjPSqc7olZeuNEIvDzZvhXnTaiwFxmwav8xseoXsDUk/jLK
         YnaQ==
X-Gm-Message-State: AOJu0Yw2/nAzrVWOvky7Ffmr+djIAJI1EEj4W4s6Ii4Un8dVoyCc9ncU
        Dm5UOkvk5LFTOvCCZHnH9O4=
X-Google-Smtp-Source: AGHT+IF4vcJJttRendP+WhRmxvB3EgbznP32Mj3wnikyVDUtJeOLULzTVgObhondXeewdPg9BV47cw==
X-Received: by 2002:a05:6358:5292:b0:168:d3b3:7173 with SMTP id g18-20020a056358529200b00168d3b37173mr1469635rwa.25.1698356403089;
        Thu, 26 Oct 2023 14:40:03 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id c26-20020a63961a000000b005891f3af36asm68472pge.87.2023.10.26.14.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 14:40:02 -0700 (PDT)
Message-ID: <14fc783f-43a3-46cd-98a1-01556b9f99f6@gmail.com>
Date:   Thu, 26 Oct 2023 18:39:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: macros: improve `#[vtable]` documentation
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Asahi Lina <lina@asahilina.net>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Viktor Garske <viktor@v-gar.de>, Finn Behrens <me@kloenk.dev>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231026201855.1497680-1-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231026201855.1497680-1-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 17:19, Benno Lossin wrote:
> Traits marked with `#[vtable]` need to provide default implementations
> for optional functions. The C side represents these with `NULL` in the
> vtable, so the default functions are never actually called. We do not
> want to replicate the default behavior from C in Rust, because that is
> not maintainable. Therefore we should use `build_error` in those default
> implementations. The error message for that is provided at
> `kernel::error::VTABLE_DEFAULT_ERROR`.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> v2 -> v3:
> - don't hide the import of the constant in the example
> - fixed "function" typo
> - improve paragraph about optional functions
> - do not remove the `Send + Sync + Sized` bounds on the example
> 
> v1 -> v2:
> - removed imperative mode in the paragraph describing optional
>    functions.
> 
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

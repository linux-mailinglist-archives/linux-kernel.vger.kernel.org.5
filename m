Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EADF8125CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 04:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443068AbjLNDNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 22:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNDNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 22:13:45 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D922D0;
        Wed, 13 Dec 2023 19:13:52 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1fb33059466so5402769fac.2;
        Wed, 13 Dec 2023 19:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702523631; x=1703128431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xfe6G/+lWo1DQS2DwiB9RkFIHFnA2iv0Ouilk3h+svg=;
        b=hmIuJleeVUahWXnc8gvSmufp4KEloOArYcVi3wYXspIlsGFMm5wm3aApVb6gXtWcP2
         fzz8+Se9ExZSbTvrNk1CNWbQ2Hz1cToZDAyHyfUeF+NJCId3vheGv61THnATlgZcKa/h
         t6XYW0gWjaP4t+2IUatnhkE/z3g56Tdo3wTTa8fjNc+2xE6eRTX39XLrDKxOhSf06Qem
         BkDDxMDlDtYnPjHof7zAHw/QU+ipV7dyGOHFdiWD9zWO6VjnKxE1i3KL113RnISORRU7
         kwMDF7WvZtd0/P+tYeqvlJRgiczugTZrwSHXreJnMzY+ZxIxf/Cq+peZ+pCGmHMDFWPz
         qTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702523631; x=1703128431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfe6G/+lWo1DQS2DwiB9RkFIHFnA2iv0Ouilk3h+svg=;
        b=eRltxhpBo4tNw8Ztqvmq7EHw5WDrvUul0MYCUKuzeO8b7o+yJKqaIIqvwi9egE+XjC
         c336+LHSZDcmdLV0nHMqeiBmgJhK9Dn6dJ8Y6vpiHWQrBk3Iv5Nxi9cP6fwsYS+Flvr9
         9P9x1bAY0PSKif0ZXU0DkSkNRMfaSdkSV2RQZceop2vuTO98j5Y/nqymotMsCmiGRzEk
         OoXSvbjRN3g5BMpB83h5mu1ZIH9ZWBld+p1q4sMu+5QGYiFvLUTbhgH+2XDmypz82oXF
         ubz1Q1xqlDtgPw1IDhcRViknhHmcRmlU28OEcLfnn21qprF/ITAVnCNpH8PpRVQPLxLJ
         36xw==
X-Gm-Message-State: AOJu0YzZz4UmqIYhgFida2Bnr+v7qD/0d3FH/yBmZLswjZS+efwRq0tD
        UJkXNmm0VOFIKNZFI3henoA=
X-Google-Smtp-Source: AGHT+IG2Bd3WCKM1ocHYVo7O4Rs6lI8Oe4qFoIPc+atyNbrf8SNuBraJey7A/rFFES0b+bpZX9ZRtQ==
X-Received: by 2002:a05:6358:59:b0:170:17ea:f4f0 with SMTP id 25-20020a056358005900b0017017eaf4f0mr7109068rwx.61.1702523631447;
        Wed, 13 Dec 2023 19:13:51 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e80e00b001d0c37a9ccfsm11199832plg.303.2023.12.13.19.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 19:13:51 -0800 (PST)
Message-ID: <f9b8f95e-1e72-4907-9964-6a4ecfc435b1@gmail.com>
Date:   Wed, 13 Dec 2023 23:57:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rust: macros: add `decl_generics` to
 `parse_generics()`
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Asahi Lina <lina@asahilina.net>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213220447.3613500-1-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231213220447.3613500-1-benno.lossin@proton.me>
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

On 12/13/23 19:08, Benno Lossin wrote:
> The generic parameters on a type definition can specify default values.
> Currently `parse_generics()` cannot handle this though. For example when
> parsing the following generics:
> 
>      <T: Clone, const N: usize = 0>
> 
> The `impl_generics` will be set to `T: Clone, const N: usize = 0` and
> `ty_generics` will be set to `T, N`. Now using the `impl_generics` on an
> impl block:
> 
>      impl<$($impl_generics)*> Foo {}
> 
> will result in invalid Rust code, because default values are only
> available on type definitions.
> 
> Therefore add parsing support for generic parameter default values using
> a new kind of generics called `decl_generics` and change the old
> behavior of `impl_generics` to not contain the generic parameter default
> values.
> 
> Now `Generics` has three fields:
> - `impl_generics`: the generics with bounds
>    (e.g. `T: Clone, const N: usize`)
> - `decl_generics`: the generics with bounds and default values
>    (e.g. `T: Clone, const N: usize = 0`)
> - `ty_generics`:  contains the generics without bounds and without
>    default values (e.g. `T, N`)
> 
> `impl_generics` is designed to be used on `impl<$impl_generics>`,
> `decl_generics` for the type definition, so `struct Foo<$decl_generics>`
> and `ty_generics` whenever you use the type, so `Foo<$ty_generics>`.
> 
> Here is an example that uses all three different types of generics:
> 
>      let (Generics { decl_generics, impl_generics, ty_generics }, rest) = parse_generics(input);
>      quote! {
>          struct Foo<$($decl_generics)*> {
>              // ...
>          }
> 
>          impl<$impl_generics> Foo<$ty_generics> {
>              fn foo() {
>                  // ...
>              }
>          }
>      }
> 
> The next commit contains a fix to the `#[pin_data]` macro making it
> compatible with generic parameter default values by relying on this new
> behavior.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED08125CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 04:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443079AbjLNDNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 22:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjLNDNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 22:13:50 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC28ED0;
        Wed, 13 Dec 2023 19:13:56 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6d0985c70ffso2687494b3a.2;
        Wed, 13 Dec 2023 19:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702523636; x=1703128436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDtuMqJuLynsqBn4B64C9rOZU/1pf1QFeAH14FfwW+A=;
        b=l8Bf1plZ7tySeMqcJy8KwLiApDtiWJ7d5TLl1k0///lnLIUEZBTE3es7sDOfBJJIda
         kTlBI95i5Pg5nrDfhqezJZyiVwaKD27klThpFJ+p+tNuets66lO0eXaHm8VecPRnrvto
         oif7AbN8z/ANCQI4NjsgQK+8bD2koVQmkLQGu7Vy+/WAMvXc+Pe9qoe0d/7vkEElSMKX
         9KZuOc7AajpTVyEW90sDflAxmlK8ll1Jjdo10fzIkXtjo/IBZeA8d8wy53oj9B5e2aqi
         IhSYjPyJiDrGlHNPkY+mILFTQKA9qPsf17D1pxn99Yxo+2Di8yEQeXS1ekbRwJjMq79P
         NMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702523636; x=1703128436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDtuMqJuLynsqBn4B64C9rOZU/1pf1QFeAH14FfwW+A=;
        b=NzWYmgebBN979ceHVQIFiotXNLW7ffLU2552xXih5TCrJo2kEKgOCHrrP+2sxFReda
         JzoPHaTN8Lh0BrRBfbVO5nEG2H9CIW3t6dbhYOXV+qf1awGj/qCIYHNQUfjOCSuRd7HZ
         lM90y5jZpiV6Wxmp7Ey/ke7gZ8Q3zr9mu+CmKN/ImEtx1ykhTAa/Jzl4hCRTws+k28rA
         O8uG/ZUe9kAziy7lbmtMF2f3tSrNargK9pbOuzD2yA98tyEoLW6CI//DCIwLTxpnEX+B
         Z++8vMSbvRTP08whjFUfYlYybtEX4ChgsPS1gB1STpHvdidfwDpblRbYuO6k/OjmOidI
         CCrQ==
X-Gm-Message-State: AOJu0YyB0px5XJGc5H5+4m2FOphNBD7uaWL5tMmQian3dQGWT4pTyIL6
        WI6G/GH7w1gpjUEaT8V8fFU6mShCNSg=
X-Google-Smtp-Source: AGHT+IEpKFGDuxTfO3Hjzi7f/Cm2KZm4EWJFx6WprxdgMa/6PjSDexd9DPpJUJfx1uXgsHlIfYXOaw==
X-Received: by 2002:a17:902:e789:b0:1d0:a96d:3278 with SMTP id cp9-20020a170902e78900b001d0a96d3278mr5238863plb.90.1702523636228;
        Wed, 13 Dec 2023 19:13:56 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e80e00b001d0c37a9ccfsm11199832plg.303.2023.12.13.19.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 19:13:55 -0800 (PST)
Message-ID: <47af6a31-b0b4-42ff-9135-ba8f27ae5dd0@gmail.com>
Date:   Thu, 14 Dec 2023 00:11:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rust: macros: allow generic parameter default
 values in `#[pin_data]`
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213220447.3613500-1-benno.lossin@proton.me>
 <20231213220447.3613500-2-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231213220447.3613500-2-benno.lossin@proton.me>
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

On 12/13/23 19:08, Benno Lossin wrote:
> Add support for generic parameters defaults in `#[pin_data]` by using
> the newly introduced `decl_generics` instead of the `impl_generics`.
> 
> Before this would not compile:
> 
>      #[pin_data]
>      struct Foo<const N: usize = 0> {
>          // ...
>      }
> 
> because it would be expanded to this:
> 
>      struct Foo<const N: usize = 0> {
>          // ...
>      }
> 
>      const _: () = {
>          struct __ThePinData<const N: usize = 0> {
>              __phantom: ::core::marker::PhantomData<fn(Foo<N>) -> Foo<N>>,
>          }
>          impl<const N: usize = 0> ::core::clone::Clone for __ThePinData<N> {
>              fn clone(&self) -> Self {
>                  *self
>              }
>          }
> 
>          // [...] rest of expansion omitted
>      };
> 
> The problem is with the `impl<const N: usize = 0>`, since that is
> invalid Rust syntax. It should not mention the default value at all,
> since default values only make sense on type definitions.
> 
> The new `impl_generics` do not contain the default values, thus
> generating correct Rust code.
> 
> This is used by the next commit that puts `#[pin_data]` on
> `kernel::workqueue::Work`.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

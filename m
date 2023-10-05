Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54CA7BAC12
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjJEVal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjJEVaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:30:39 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA669E4;
        Thu,  5 Oct 2023 14:30:37 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c87e55a6baso11125345ad.3;
        Thu, 05 Oct 2023 14:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696541437; x=1697146237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6YH0gaIOtHibpvM+5oJJ8JDGFf9bKbLj2NBXdO+Yxm8=;
        b=J/55Dn66LZls2SWGWX1M5OVNP8EJicQngOYb9bsJDbMxjELTqKR3q1ryW9X4MIUfNZ
         zW4rAACH1LyCAh4lRK0WrMyigf6PDDUrOt73B3zhm1HTFklc9QShJGZLwTlcGrBH0HlZ
         EjsH+39x81MN4fvIzutP00ZDgDuXatDkR+a0pV71LBANplNpTZoNwDSoXOol3MwSvZTM
         JCXF+WQ+gjGt6YFhyFwBC8TfJyHVEM+mL3gTc91bDAyGrA6NiIurzaUQttVj/RLxC7ad
         rPsO35X8mJVlfkGfAiqYZ8saExVFRNCouezAU37nHhmpAEPQs5c/MJKD13NswWmYyXdE
         OE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696541437; x=1697146237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6YH0gaIOtHibpvM+5oJJ8JDGFf9bKbLj2NBXdO+Yxm8=;
        b=PZLKPb5xoRmgjFXfeGw0VjNhtcXn6fGyPML3cIo2g2bNPKBwcnxdq3LftFneCZtTyO
         rF8VHg6CO/Yc9ztJryH+pK4YNBjUnKmAM9v9uHkFc5Trf7cVNBPtIwAw87s20Zmav3ZB
         /chyB2TPGxFeGJHUE5t2iLQm7FN7t18pweQh1PsNSPQNQgtAnL0Jjy6aopJ5DRxVYHxA
         AyU7TH4jrqPbiJewSsN8SjEd1ylwRJYb9cYBgoadAyRuwny8MXFUT5Y77ee2fD/hODX5
         AqI80ucvOdvqLQ/kTMaCHLorNYx5Uo8uMdK+hBJHK9LMYaLEU7soqkxKWtb+HaZCx1a8
         KE6g==
X-Gm-Message-State: AOJu0Yz3Gx4z12oja3qTE1BeCoZg7Fhhg84rgkEl3g22q+U6nA1w9VIY
        dJd64RRCQJOMJnDdbZztFzE=
X-Google-Smtp-Source: AGHT+IHd9JBD1dZEVvgDQ1Vau9CJPSSHCHZsMtMrRMDiC7RY1bW3RbpsdPaDHNni5FOFkVpatfFiGw==
X-Received: by 2002:a17:902:a504:b0:1c3:308b:ecb9 with SMTP id s4-20020a170902a50400b001c3308becb9mr5877146plq.11.1696541437229;
        Thu, 05 Oct 2023 14:30:37 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903244700b001b8a00d4f7asm2230148pls.9.2023.10.05.14.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 14:30:36 -0700 (PDT)
Message-ID: <fc946540-bb9d-4db2-b5c8-00f7783e3082@gmail.com>
Date:   Thu, 5 Oct 2023 18:29:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rust: task: remove redundant explicit link
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20231005210556.466856-1-ojeda@kernel.org>
 <20231005210556.466856-2-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231005210556.466856-2-ojeda@kernel.org>
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

On 10/5/23 18:05, Miguel Ojeda wrote:
> Starting with Rust 1.73.0, `rustdoc` detects redundant explicit
> links with its new lint `redundant_explicit_links` [1]:
> 
>      error: redundant explicit link target
>        --> rust/kernel/task.rs:85:21
>         |
>      85 |     /// [`current`](crate::current) macro because it is safe.
>         |          ---------  ^^^^^^^^^^^^^^ explicit target is redundant
>         |          |
>         |          because label contains path that resolves to same destination
>         |
>         = note: when a link's destination is not specified,
>                 the label is used to resolve intra-doc links
>         = note: `-D rustdoc::redundant-explicit-links` implied by `-D warnings`
>      help: remove explicit link target
>         |
>      85 |     /// [`current`] macro because it is safe.
> 
> In order to avoid the warning in the compiler upgrade commit,
> make it an intra-doc link as the tool suggests.
> 
> Link: https://github.com/rust-lang/rust/pull/113167 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

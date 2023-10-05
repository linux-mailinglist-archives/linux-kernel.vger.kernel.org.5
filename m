Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B867BAC14
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjJEVaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjJEVao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:30:44 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0B5E8;
        Thu,  5 Oct 2023 14:30:42 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c736b00639so11516805ad.2;
        Thu, 05 Oct 2023 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696541442; x=1697146242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dko4d8emUH4vRaPizUWo+kG/JH4ZKaIw1NqUJC51xOs=;
        b=Owu5diykN8eBlEWG7c7/huQAWShLyK9C71Xvxls/PgBADM52ObifZoB9+S0GSwt2AJ
         zyg5XtCtL6eUfe9hDEHV8zneiExsIYcZYRKBvynzdZ69RdSBlDpHjxj9Om4hwuRvJ7MA
         4NtONLSUAmQAUjoJnoVR//+8prHW2S52+pUCA3U3uOpqAKj+Ray10eGwfC3w+CG8sEbN
         rih5hV/8LNQwwikudIMTH07mxEDVp9wsndFib4RLZGnTRrPHpn4Aatbsg5dE/J4hffZ3
         DMdQcmXdPdn/kEbtptpmV/z2DefAXeTaJI0spRMSl1Sx1SVuaj1BEyvTY5cDptT+Ygq2
         8boA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696541442; x=1697146242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dko4d8emUH4vRaPizUWo+kG/JH4ZKaIw1NqUJC51xOs=;
        b=BI0Vg5V4QVARdSC5Ux3NE5+bR7gYylmQXcAv7LSxwY5ZWz0O9F2U0ws9xTnHJ51t7S
         uBOOHzkL3gT3cLTzt04ta+cPNFqNVT3Zt0etOw365BTjz5mXq6CvKnn8olRvOaDNEcIV
         /SMvpXpkt0fbFYAxECMaFAD8Y2W21k9dP2T4KJYNmJCoa073JLgy6wQgRDXDrpbrNgZf
         9tlYNRZg41T91wCJDUd9S5Z9guSQFRAPq7kaPvzJ3UsmM5OyZY1rKO7UJfwzuyM3XFdM
         XQ2DypZiKYJ3O/GF4Kbrn5HgR+pQu/tGoqK5bGCXwr1pn13plnRPObg23hz2hkzWp4dG
         r1NQ==
X-Gm-Message-State: AOJu0YxcwI5wrWmENUMABVaIqik520NY5JWB27fujbxcU3myhdrrIDsX
        BJeT8OfTOnu8FjbAVUu81Ws=
X-Google-Smtp-Source: AGHT+IGwyfLpNVx4M4ugeDbLU5LxF7PM7KBrWvaOgWQpvRxV/ra0KCajJfTza2QCsQ1Zj8Ltm6TG4A==
X-Received: by 2002:a17:903:246:b0:1c0:b84d:3f73 with SMTP id j6-20020a170903024600b001c0b84d3f73mr7327634plh.53.1696541441949;
        Thu, 05 Oct 2023 14:30:41 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903244700b001b8a00d4f7asm2230148pls.9.2023.10.05.14.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 14:30:41 -0700 (PDT)
Message-ID: <a6525c99-68c9-4816-88d0-ebf8670e766b@gmail.com>
Date:   Thu, 5 Oct 2023 18:30:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rust: print: use explicit link in documentation
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
 <20231005210556.466856-3-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231005210556.466856-3-ojeda@kernel.org>
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
> The future `rustdoc` in the Rust 1.73.0 upgrade requires an explicit
> link for `pr_info!`:
> 
>      error: unresolved link to `pr_info`
>         --> rust/kernel/print.rs:395:63
>          |
>      395 | /// Use only when continuing a previous `pr_*!` macro (e.g. [`pr_info!`]).
>          |                                                               ^^^^^^^^ no item named `pr_info` in scope
>          |
>          = note: `macro_rules` named `pr_info` exists in this crate, but it is not in scope at this link's location
>          = note: `-D rustdoc::broken-intra-doc-links` implied by `-D warnings`
> 
> Thus do so to avoid a broken link while upgrading.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

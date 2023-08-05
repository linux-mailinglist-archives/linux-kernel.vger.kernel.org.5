Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28CB7710B0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjHERCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHERCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:02:43 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CDCE4A;
        Sat,  5 Aug 2023 10:02:42 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b9a2416b1cso2806944a34.2;
        Sat, 05 Aug 2023 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691254961; x=1691859761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMnejlW7wDowKm1T1ZpctakA9PoGnkwqsUF9BdHi/CA=;
        b=Zq6FOXJxC/YKO2IoXPEbM4Au8H7KPpMToMonCZKrYrLCdDdjvxwnrMDVzedz2ZZp3T
         5x9YbDcls9ZGBUj2mFNV0N6NY4OFGFgLnGbFWMAVgTVtvrKLUUgC0B90m34K04TdcBzr
         CHlsq/GuVSEjJByuTBMIYkg/GUG36NkyjtvfI6dPXJa66+MCzIlPlLSnvtOVC4f5o7Xg
         J0+cE3g2+EETMKlxtSCOvWnKS0v8W9ILxaffKqSZT+t9Hx5H9rdKEXTDaDWj9H3ugRLa
         NcxzFFSDm57SbmUYV1m2VhGVZtyqQ5dOUNDxbxhnpE7qhGmnL4YhEux59lAhmALLlCq5
         QERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691254961; x=1691859761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMnejlW7wDowKm1T1ZpctakA9PoGnkwqsUF9BdHi/CA=;
        b=eRJP7Tk3+/tWI12CnA8n7jm8JadS8TtTfZG1zfk/G/JFczSzsszJXTiBrs+KE7jwb7
         7d4CXl7l2xBk+estyFrekz2uMdCJAeJ9FRUs1tyXXJOpY3Qx88P3Y7fL+3xBHiT1EVZc
         S/Qvt96wI7GkAvYq/QNqb5mKT28oFbSslHdWrXPUPEvye/vPr3PsOojUl27m1O92+n0e
         49h5CZYrg3aX4INeL6dD5DqrpKSzb1c5Mn/oIMSX/pA+lUz/K2PS8QQpHV5Dq15D5LoU
         SY1YJUnB1DrozWbqRAmDHEv9V6+bDA58SaFlt1NZFttgwYzq3OwkU+Um54msk6ns8LYL
         OY9g==
X-Gm-Message-State: AOJu0YzZr4DlnJLBVu+FDbhbXLWI+aQs47MGFyDGuPj0+4rqvH7EcH27
        Cut/xYIK3YzypJJEDaxgs9I=
X-Google-Smtp-Source: AGHT+IFUFXI9hsEQXGyCxFKnzP19EUTqD3CRPgGffIqegI0gQjmFjfmUG5okKsZxVCdLAmtUx+TpaQ==
X-Received: by 2002:a9d:7345:0:b0:6bc:a054:c569 with SMTP id l5-20020a9d7345000000b006bca054c569mr4934463otk.38.1691254961298;
        Sat, 05 Aug 2023 10:02:41 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id p6-20020a9d7446000000b006b99f66444bsm2692977otk.71.2023.08.05.10.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 10:02:40 -0700 (PDT)
Message-ID: <9e2a0dc5-815a-4d11-ab3a-5a60a9946d47@gmail.com>
Date:   Sat, 5 Aug 2023 14:02:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: macros: vtable: fix `HAS_*` redefinition
 (`gen_const_name`)
Content-Language: en-US
To:     Qingsong Chen <changxian.cqs@antgroup.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
        rust-for-linux@vger.kernel.org
References: <20230803140926.205974-1-changxian.cqs@antgroup.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230803140926.205974-1-changxian.cqs@antgroup.com>
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

On 8/3/23 11:09, Qingsong Chen wrote:
> If we define the same function name twice in a trait (using `#[cfg]`),
> the `vtable` macro will redefine its `gen_const_name`, e.g. this will
> define `HAS_BAR` twice:
> 
> ```rust
>      #[vtable]
>      pub trait Foo {
>          #[cfg(CONFIG_X)]
>          fn bar();
> 
>          #[cfg(not(CONFIG_X))]
>          fn bar(x: usize);
>      }
> ```
> 
> Changelog:
> ----------
> v1 -> v2:
> - Use `BTreeSet` and existing `consts` as suggested by Alice and Gary.
> - Reword commit messages as suggested by Miguel.
> ====================
> 
> Fixes: b44becc5ee80 ("rust: macros: add `#[vtable]` proc macro")
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

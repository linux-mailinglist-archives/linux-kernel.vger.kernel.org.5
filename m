Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194827B449D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 01:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjI3XjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 19:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjI3XjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 19:39:22 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B86AC;
        Sat, 30 Sep 2023 16:39:20 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-692779f583fso11476797b3a.0;
        Sat, 30 Sep 2023 16:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696117159; x=1696721959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7UiXkhftRzj0Skpc2GwFos/rvPvaJTtHdtoUepzDE44=;
        b=mKya0blS+WomII6KGlqz5PHsoY4rLyvnfxofaUbSQkNFzmWvOoNpujCNrafmVRbjd6
         XtF6dexnHFelpZXlhFZ6VnMnyZcnBqhq4/8++eCPHEcycYUEnGcTWJj3F+tVkifG80LF
         lg7fy7TyfyZRi0BunuYsNLjMEHTu6uPPi2Rs4zq8QSlpMm5T2ndQXVjbyvRidGm46lgQ
         BMscgaDMU3mgtTAbDXJlj9Kq4zyLV666f1f3rcPzDOLxjNChSQW4TV1XkovjPbK4/SE0
         W6DDiRRAyHxK1WzKP1z7nQTo3HSIqKE6SzIRevvApLPqGiB2tC5e0w1AvhLsDvdF9xa8
         FnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696117159; x=1696721959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UiXkhftRzj0Skpc2GwFos/rvPvaJTtHdtoUepzDE44=;
        b=jVCaL/JtAZk5eLjXw+p/zLpbFBTgaT1aunwZ/PHVyiAJCNVA3urxDFolcuD9LTKcv8
         XcDUx8LUJ3zlESif7ywVSoHCBqZ4YLRI5x7ajX26VfuxgwXDrwwk5NK05th21mKgV16p
         3LJs+8ueA3+S+axyG0eBqotXCJvT/4O4scs7WAcKrrg4wkkoJzhUrAVD7D+LItAjmr3j
         rw8Cy16oLO0QzJu+E2Fv3tPlxt6CVPi7gHSSl9n1X33Zss5pOffLHOG4WIgrTPQdAIRO
         Ro/3xok/SNM/v6E0CV3E3vQe78MQw79IPQzZMU60Nyt0AuV6fFp5+tyWwuMDYc/a2rMb
         UMbw==
X-Gm-Message-State: AOJu0YxWY45UNLu1+9NBt+SpkLsXiloSN7aq0cyj72DLV6icMaWDIHiC
        bCleiK1wB7w019aphN4Kgag=
X-Google-Smtp-Source: AGHT+IGXIq55x0ZJ3lcTzmM9JQwiVJhJuvg1Ep6MwhINAP4meEZxyx1ENHI4T1hHAgl0c5T+5L7VtQ==
X-Received: by 2002:a17:903:230d:b0:1c0:98fe:3677 with SMTP id d13-20020a170903230d00b001c098fe3677mr7938066plh.56.1696117159562;
        Sat, 30 Sep 2023 16:39:19 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001bb892a7a67sm19135006plx.1.2023.09.30.16.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Sep 2023 16:39:19 -0700 (PDT)
Message-ID: <692c07f3-34c6-4bbb-b421-b71919573f90@gmail.com>
Date:   Sat, 30 Sep 2023 19:41:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: bindings: rename const binding using sed
To:     Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Wedson Almeida Filho <walmeida@microsoft.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230930133704.13313-1-gary@garyguo.net>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230930133704.13313-1-gary@garyguo.net>
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

On 9/30/23 10:36, Gary Guo wrote:
> Current for consts that bindgen don't recognise, we define a helper
> constant with
> 
>      const <TYPE> BINDINGS_<NAME> = <NAME>;
> 
> in `bindings_helper.h` and then we put
> 
>      pub const <NAME>: <TYPE> = BINDINGS_<NAME>;
> 
> in `bindings/lib.rs`. This is fine that we currently only have 3
> constants that are defined this way, but is going to be more annoying
> when more constants are added since every new constant needs to be
> defined in two places.
> 
> This patch changes the way we define constant helpers to
> 
>      const <TYPE> RUST_BINDING_<NAME> = <NAME>;
> 
> and then use `sed` to postprocess Rust code by generated by bindgen to
> remove the distinct prefix, so user of the binding crate can refer to
> the name directly.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> [...]
This one is a must have.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

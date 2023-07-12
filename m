Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280BC7511FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjGLUqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjGLUqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:46:31 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEF4A2;
        Wed, 12 Jul 2023 13:46:30 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1b06a46e1a9so5903664fac.2;
        Wed, 12 Jul 2023 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689194790; x=1691786790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjYp/GGGt1suSt9XKydx09ugNwhwrtHkiMgpJkM/lOc=;
        b=ncfNislj9zkZDbzfooNQKCoi3fZ/tNoj/jW86RpRgvnL/xWidIpWcLH6ayF7AetyXO
         qAHUWsEqwvY/NGG3fsTp3T5S1FjT/PNbxOToVwEQ82BTZcQAerhxx85WCv+6o+sVl5oF
         XmOVP70uv/1ZWlrvgrOlOXDPHUprmR+TjTvWD8V9/i5t9gafRdk/jZI6bg0k1+FuwnIr
         KDe5lzQr+yOdL9AFvjfJwOFbG9AxD/BxnV7lqt9o4cpBP1ytub13wm+8xwY46e7QiBIF
         FJcf4gGhW5HVpz9WAXW8y74oeWD0SGnqtQNxrrbAWkLXZPuzgApTeQiyIVeFFzaghT2V
         I36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689194790; x=1691786790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjYp/GGGt1suSt9XKydx09ugNwhwrtHkiMgpJkM/lOc=;
        b=SEvN85z8Nv2N0O/UDfShCwl3KMfGOaODmaeWHNs9vlF9Zw2Ys+90yGB2Vt3ME48/o/
         NbjqiqM9okdfYrtVW590iFeHx7xHCPaYzcf4npmA6YSZKanomHmaBxhEmLtLVFUH+LdT
         rKTvli+xYBp3Jfx5iYjg2yllAxLwmWs9rczyyLpZz63pJPlHH2m5Y9rwsg77NK/Ffh8H
         7uUpNOwEnzj0AQhRMdP3y7Z9IBJGdX9I56rPevbCiJbQjaMwHMepHh2e844fhsGQ/uro
         lMiHN7qUT1m0G5YbsBLYItq811XOH7OhVCJif0TJXNwoJhCGI8nXsJDMI60ylKl305YY
         fk9g==
X-Gm-Message-State: ABy/qLYG996LjYsYng+LR+OmonI9bDvfLFK3wIEGAVTZGhbWoIvFlqd1
        7ODE6pvx65a/IIwkJsavG6Y=
X-Google-Smtp-Source: APBJJlGB8IZyS5AEyRlG5pMJgxfMJIQfz18Bl/ywWLjb12fdCb0ahZIw7N3RXMtz/5OOeQxQTXct2g==
X-Received: by 2002:a05:6870:e313:b0:1b7:8950:f583 with SMTP id z19-20020a056870e31300b001b78950f583mr297915oad.33.1689194789797;
        Wed, 12 Jul 2023 13:46:29 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id ds53-20020a0568705b3500b001a6d15fc52fsm2397384oab.4.2023.07.12.13.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 13:46:29 -0700 (PDT)
Message-ID: <4b92e8be-32c8-0ac4-723f-59f2fc42e6b3@gmail.com>
Date:   Wed, 12 Jul 2023 17:33:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/9] rust: sync: add `Arc::{from_raw, into_raw}`
Content-Language: en-US
To:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>
References: <20230711093303.1433770-1-aliceryhl@google.com>
 <20230711093303.1433770-3-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230711093303.1433770-3-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/23 06:32, Alice Ryhl wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> These methods can be used to turn an `Arc` into a raw pointer and back,
> in a way that preserves the metadata for fat pointers.
> 
> This is done using the unstable ptr_metadata feature [1]. However, it
> could also be done using the unstable pointer_byte_offsets feature [2],
> which is likely to have a shorter path to stabilization than
> ptr_metadata.
> 
> Link: https://github.com/rust-lang/rust/issues/81513 [1]
> Link: https://github.com/rust-lang/rust/issues/96283 [2]
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

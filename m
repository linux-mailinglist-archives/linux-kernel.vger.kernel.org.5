Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0A37B4749
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjJAMMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjJAMMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:12:34 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6B492;
        Sun,  1 Oct 2023 05:12:32 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D44D23201263;
        Sun,  1 Oct 2023 08:12:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 01 Oct 2023 08:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1696162348; x=1696248748; bh=/AsSColXGkWSjllLUN3EiONCeSGJj3ZeJ8O
        xXQx3U9M=; b=D8ltTHChN8dMBqYyS1l2aj6kPoQiN7CzWyqeefEjExnLRNE61VP
        r7X5sP7CvuVBUOgnwGdtc5ffRlfMVdDVX1pzorMNNcsuoBqGqyw11axHlUa+roNQ
        CL+MBD8G6oD1H5r+a3ecwmBAEkXCUBlRG29dY15hQSHBpZySpJWc7ho5lWhzZYdl
        kXAMvLXEmkdrM5t1GTXm7FzLVpHIIdKz3H2w8PLyti+THLW7TXfzoHUcryTt1mUo
        BtTmIsaoqnBQDfryx7B8tW6GppRS+3b139RIKjt4mk2VXv98yuWLZZ/mpapz68iR
        Tiu4FH6HDuXyCA0HZQJ0BZwJ8uxPN9FcPEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696162348; x=1696248748; bh=/AsSColXGkWSjllLUN3EiONCeSGJj3ZeJ8O
        xXQx3U9M=; b=cyEalKmaFcRXmBvSO1C3+ZCqDhUIR3h2WANHk8uUuqhbQXprRdp
        52+46QXlaRiXcFFA3I+BguFKDjTyxRJ4jlooWS60Eh3RxFX1EGHQfXAZm1qyg+Rt
        pL11gt4d6Gda/26WTaTQ33mB6Cstx95YNCUI1wcaJ+2UHStqij8iGJPNQ5ynvsY9
        u5X4AspgxEdOZWBgODKA1naN0X3l9qutstzo1gH3fb3zG4lFTllqXRmMv96pbGDO
        8hw37gGCzh7++CczKCdfpjNvEjxEfSQV9rBtfPObkzxB2YJ7357V0kB1iRergozT
        zD9LbjjIinth9kGgQlSsIe48VX1wAUnoOmg==
X-ME-Sender: <xms:K2IZZS0c6YVOELAvj2rCtFZwszUpAdCgPk7Pzi044HA198TYcaSWzQ>
    <xme:K2IZZVGJA7u1fsLbXtzp5R5qUVvla1Ox3HckRtjz53hh3z9p2Iv9Es8PFAiA4-cV_
    xVp3sDE5x7bv-HxHg>
X-ME-Received: <xmr:K2IZZa6V7JmwTNNYY-C5ckSshCWTix1CTnDqiN0Ozjr7Si1_XyczCnpJvYukZN6Dt2PWYHBhXNOr00Yn7D5h3zoMZSf9pdfRukxW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlihgt
    vgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnhepfe
    fguefgtdeghfeuieduffejhfevueehueehkedvteefgfehhedtffdutdfgudejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgesrh
    ihhhhlrdhioh
X-ME-Proxy: <xmx:K2IZZT17gT0xOWKvlOZMZTeirz99xOTkClMQNOXWQZIeWJPSj_h5Lg>
    <xmx:K2IZZVELWkOwEq9INNxwdl2oTUQ4lu7ntfwGYG6LrBoI46Rzbj5YUw>
    <xmx:K2IZZc8zFMGFm98P3nTEaorjgJFHv7CqO_aDPRvwVFP80l8x71BIRQ>
    <xmx:LGIZZdGudjo6bBgpGV3mygpFbBiwsHutBqGFWpgp5NGvdRh6m5h02w>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Oct 2023 08:12:24 -0400 (EDT)
Message-ID: <45f5151e-76bc-4a86-a68f-3d8844e81323@ryhl.io>
Date:   Sun, 1 Oct 2023 14:12:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: bindings: rename const binding using sed
Content-Language: en-US-large
To:     Gary Guo <gary@garyguo.net>
Cc:     Wedson Almeida Filho <walmeida@microsoft.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20230930133704.13313-1-gary@garyguo.net>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230930133704.13313-1-gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/23 15:36, Gary Guo wrote:
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

Maybe it would make sense to use a less generic name for this sed 
replacement? E.g., maybe RUST_CONST_HELPER_ or something that's less 
likely to overlap with things that are not constants.

Alice

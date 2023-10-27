Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047687DA221
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjJ0VBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0VB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:01:29 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46891AA;
        Fri, 27 Oct 2023 14:01:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CDA005C00F7;
        Fri, 27 Oct 2023 17:01:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 27 Oct 2023 17:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1698440485; x=1698526885; bh=rwlpdi8ev9gAGVqrnmvKN/9d4ygxlJDbgsA
        rDSpR8bE=; b=p37XR05T/cTPb05b4k5TVgd4USs8jf3jzOAzTBItDgvhRKbf65X
        mHjcmMdceo3Rm/ZJS3we4Ybm+qHZFDqUlZe6f305SSQwiBk4C81lF8gosYKiWS1V
        d6iDAo6dxKl4i9zUqUv/RDL1fY32zpLygOgpNbkmTIuUyqwYqzJV//QfT9HVmjiE
        fMuCWvFkJW93voiqBE3VuKX01AaDw8ve9d3wMnWxZEKBz9Bac5Wk2T/9U1o9giTK
        fOoSq4UfWNCHFWTGp9PGARLUdZo7MpS/S/ErBLaCQ1WXjdAanb/Akzbv3ni/KbDh
        Uwsjna9Ow6HjXnoYpbwUyBmbzPK36ST3i6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698440485; x=1698526885; bh=rwlpdi8ev9gAGVqrnmvKN/9d4ygxlJDbgsA
        rDSpR8bE=; b=dhxyRlOT+TaTe5YjMLov24rW/w8DoXqo1maqGuKgWJry1Q7kxgP
        gi8nFBmXkEMKh12H9h1RXONt4rMz0VSofAT4FLHEf1wI1y7FHJ5Hv4La2nx5nBch
        AfO/VukR0z08mK+UDqWhKGsrIcOZpmd2tp7P/rv3OcukReEyDUhWbPIK4IgjBDsM
        fFmfIFoFFww8Nk5MgdlGGtpREwzhC9l8gWv1awVEzNuf6LRfLEJTfOm1IvmOS9LP
        V2na9r/IaD3tLoJcTZznYg1DXJDm1j/xkTrchB60usgQ71y5b0/yXvfE9AMmHiC5
        wnVFUpIu2/q1M7hiv8GEaAo89BEoUwrJQLg==
X-ME-Sender: <xms:IyU8ZTYLX09dLBC_aLV_7fymQO9V18KrRafS6HHdfHSWfJNqdD5bVw>
    <xme:IyU8ZSZmSKEbdjEXMfjIU3T1cArkww3nGybSDseKkvfG1QHl6rKgc_s_EGyG0x6zk
    4hxL7JSeL8g2z2Qhw>
X-ME-Received: <xmr:IyU8ZV_6Ac7GbI9OpMlBRAP8hFLPCR-bjN4uNrtUX6UtGeLgYvH1DslLOkr6W46o34eVjPkADBCcyylrpxARq2YdTVIV5xo8M5xK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    efgfeugfdtgefhueeiudffjefhveeuheeuheekvdetfefgheehtdffuddtgfdujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:IyU8ZZpgQPT4xSr0dRxiqa7mfs4E5XidW5IPt-9r70PkHUCvLApKDA>
    <xmx:IyU8ZepBb6z00zs39XoSe4CqFvWWnKSaCYTDJlf9gJ32eWXoMYrPuA>
    <xmx:IyU8ZfToNZHVD9fBDOeIbhixRRPZi2WPbJBbK36HJ1wNzqjuOyGGVQ>
    <xmx:JSU8ZZA5CR0LgqoBjz-dAZTsMBvCbnFxOin_ZExIq3CwuIB4GOqaIQ>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 17:01:20 -0400 (EDT)
Message-ID: <2999984f-56f1-4bb7-ba6d-0a74fbca7cbe@ryhl.io>
Date:   Fri, 27 Oct 2023 23:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: macros: improve `#[vtable]` documentation
Content-Language: en-US-large
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Asahi Lina <lina@asahilina.net>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Viktor Garske <viktor@v-gar.de>, Finn Behrens <me@kloenk.dev>
References: <20231026201855.1497680-1-benno.lossin@proton.me>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20231026201855.1497680-1-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 22:19, Benno Lossin wrote:
> Traits marked with `#[vtable]` need to provide default implementations
> for optional functions. The C side represents these with `NULL` in the
> vtable, so the default functions are never actually called. We do not
> want to replicate the default behavior from C in Rust, because that is
> not maintainable. Therefore we should use `build_error` in those default
> implementations. The error message for that is provided at
> `kernel::error::VTABLE_DEFAULT_ERROR`.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

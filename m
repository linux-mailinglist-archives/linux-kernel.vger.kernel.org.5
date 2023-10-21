Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8BA7D1D2D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 14:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjJUMpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 08:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUMpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 08:45:22 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2A11A4;
        Sat, 21 Oct 2023 05:45:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DCA865C018A;
        Sat, 21 Oct 2023 08:45:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 21 Oct 2023 08:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1697892313; x=1697978713; bh=Vz93kvNHnltIJPk151Ct3Vlh5dYIx/Zn9LB
        X7dhQlAM=; b=T9VHeW0zSi66w42NwPQP5cGb2Cc9u8FP707io0qFOuvIiAObutw
        V4jYgtOPz4t0L6DWWx0Y4TKKExp4NbCoULWk06DGmCyBxP649f269OHYac8A0hTZ
        2LAX2gSzb/hCbYc21H3srBXglU9/BqXQgOFhEKkWTPk8AmpEKiUtMF2X7HtkM8v/
        oDbUdj605yDQKjvIlUuJF7XMAClPsu2ChMvDFQcCdSWHIX14CiP9gpmvI43Ucc7h
        HrYB3R6uh+cmZbySOnVnwtFklhe43iPAP5EHakj87OiMBgWWO5vZy3PODMF59+me
        Q0YYdDYikJSn3CKCvOcHnvjskS0yndnEUKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1697892313; x=1697978713; bh=Vz93kvNHnltIJPk151Ct3Vlh5dYIx/Zn9LB
        X7dhQlAM=; b=m0Y29Ie2RPJn7Mg7LMQ33Rlq6QwZrO6QIdtYEn0ASAkiWZZOiju
        2QxlbNNnbuaINVJEQg8nuJIHOvHCSkzNyhycravPn7aYDxCBmYbuNdGNIrQni1Em
        Gs++5e0jHfgu6I45sIuG9phs8p7WS64tnQJe/Tv+bVZXQRS4vKqbgM1Ag2U/1SCW
        IwRFKH1MXj3N3Z/XQ4siYy/8BMOUAbdLzYhLfhgGMEATfdOBvZ3r09H/gD/7jfsV
        Brk1v1cigoQu0KFXvH8aBTGjyZ5+oWc9spwDLIYiwGf8Bc/t82D01F58H4Xh65so
        vGUJMWe5v1OBIjvl35XmRmsKYCc6JTZlpCQ==
X-ME-Sender: <xms:2MczZWYKM1Zuc4sc17iaJhXfR6YN9tuEVt4iTGcpdXVRPd4Six4QSQ>
    <xme:2MczZZYtEeEc2uAEyMLX-zn1DUUGpo3CFkD9QtmrEoWxb0rNbWxgkHVWWLAGYtP1C
    u9pcmm-RpreUP_EGw>
X-ME-Received: <xmr:2MczZQ-F7VSxD8iHXAX-g061DZCwTEpPS2k_7gk510hZsDc30-AR0SNj0hYOdNnKxLtwnwvpJKlmvjhgCvA4pvxwl9vxn-GS1JMF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedtgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlihgt
    vgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnhepfe
    fguefgtdeghfeuieduffejhfevueehueehkedvteefgfehhedtffdutdfgudejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgesrh
    ihhhhlrdhioh
X-ME-Proxy: <xmx:2MczZYqNZH-9raD8sgdyMuxF2_X9hdUmFz6bV0EYbqTKTkVx21YdBA>
    <xmx:2MczZRoEdviA2qOBFay0mF6g2F0HEQcuOZOtSfhNneH77LCxGQPJKQ>
    <xmx:2MczZWS3zaZpm0uZH2lOwqJ2w1bZBB9bP-oZT9O_MLp9m5bn9u4FyQ>
    <xmx:2cczZc0kQCF86zzjIYbaUuwQpXxn2cLRpbysqXqs9Uaf30Uy-w77fw>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 08:45:11 -0400 (EDT)
Message-ID: <1cc11492-248e-4b37-9608-b475acde3da2@ryhl.io>
Date:   Sat, 21 Oct 2023 14:45:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: macros: improve `#[vtable]` documentation
Content-Language: en-US-large
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
References: <20231019171540.259173-1-benno.lossin@proton.me>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20231019171540.259173-1-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/23 19:15, Benno Lossin wrote:
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

There is a minor nit below, and in reviews sent by others, but overall 
this looks fine to me.

>   /// # Examples
>   ///
>   /// ```ignore
> +/// # use kernel::error::VTABLE_DEFAULT_ERROR;
>   /// use kernel::prelude::*;
I probably wouldn't hide the import of VTABLE_DEFAULT_ERROR from this 
example.

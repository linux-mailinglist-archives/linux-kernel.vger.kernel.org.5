Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCFF7F8BC3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjKYOd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjKYOd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:33:26 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A7CD3;
        Sat, 25 Nov 2023 06:33:31 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.west.internal (Postfix) with ESMTP id A56AD3200A40;
        Sat, 25 Nov 2023 09:33:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sat, 25 Nov 2023 09:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1700922806; x=1701009206; bh=iOggTtekDCWGSAb7bSTK/5qkZpNiv+DKy/s
        YuWyx46o=; b=mzqhvznKYXd5bum2c65n/a672Xvwilsv3M/aJuzhBmVrfaF/Tmu
        6ohqSDXHYyCxn2ss4Pf5CJVF4Fy2KSTt+2szMi/geddBrgeK33c5GNvWEhW1hM7s
        EYBZTKHmos1/uN6DwE4r2SSZCiGJnumesSo7+bWK/R0Cr526Q2ffkKegA4Wmxzup
        99p92cabQvRXaGcM8JkKnbC6ohju3hlFQp7XnPLWjuPAUkYzmkApwHr5Zk46gz/O
        QhLfoTc0pZKq2mDCrUicyl0GUNaLMlLMsCxLq4xsegLy8PeeGkAalvfMAQCiq37t
        g51imw7HX7MGlzzh6P/eTtQSzPHM4O42/Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1700922806; x=1701009206; bh=iOggTtekDCWGSAb7bSTK/5qkZpNiv+DKy/s
        YuWyx46o=; b=i2UDmOcTWz+3bM5ShbqzFue6CAc6sLLkJJmU7jiJzTwBwxzfd2S
        U8fN3H6/Wr3xlpUlrjcfDWA9g2fTQoXEbaY14qlwCpnZGhfpU1lX4fbjADjT1qy7
        Lm+JShPrEEaBXK9zAbbXIBikO5SAraMo95p+so+FxTBH56z8GvNdQZfGF7l01m08
        11EK9GQmKdxtcYep+r70zSaTYm/mXqgwM3vkhHHDHEpWRP2gnIoSMOKIzPqLmhNC
        0DNIx6CfNv95smW4r2Cd0i+PkvAt5TzG+UpHbySdstVin+qpNH+zgVHPR1IpBal+
        9HzpRzhOx+x1TCKwjdIdoeGrQR//frvTgVQ==
X-ME-Sender: <xms:tQViZS9L4jq1lk5DpQaOLDY46pn-X7dlFqceTTaWcraKKUvmqJLn0g>
    <xme:tQViZStZMLuCqgSKgQTrYZeikYVCm6kb_1iWYoHR6-ziz7-9RnSNBYIBkRFFxpYab
    WhTWqhXXR1W2TbRiQ>
X-ME-Received: <xmr:tQViZYDxtpj2juCZCce11OGy4QnrIiTrcl9eAUZl3w-otroxKk3eUklmTZsDJ3T0RQRvr3jhsSNGi8DNDwxBud__f1sHkdiWNsvOcPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehjedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfhffuvfevfhgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    dvffetgeejveehueelueeileffgeelkeeikeeuffevveduffdtgfffveeiudefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:tQViZac_wUmrwqKZHcGUgh66Su4iTC-gVd6oxDTErIpDsLwvCBvsWA>
    <xmx:tQViZXPor8IKrrbspgFDMGVDEIbiQY20TFVKS8PgY4NDZJOEhh1giA>
    <xmx:tQViZUnnp3R_N-i-iWFarPgWjjsPC3xUmqvmycnZXjOot6jR2UxwuA>
    <xmx:tgViZbk-BjCPLiH6tPadbrGknCfQny-sqJpIQmhRDSHl-z7kLmLPQg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Nov 2023 09:33:22 -0500 (EST)
Message-ID: <45e5de7e-d787-4200-82dc-389cbdad9ee8@ryhl.io>
Date:   Sat, 25 Nov 2023 15:35:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH 3/3] rust: workqueue: add `#[pin_data]` to `Work`
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Tejun Heo <tj@kernel.org>
References: <20231125125024.1235933-3-benno.lossin@proton.me>
Content-Language: en-US, da
In-Reply-To: <20231125125024.1235933-3-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/23 13:51, Benno Lossin wrote:
> +        pin_init!(Self {
> +            work: Opaque::ffi_init(|slot| {

Surely there should be an <- here instead of the : character?

Alice

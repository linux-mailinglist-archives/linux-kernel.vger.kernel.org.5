Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEACC7ADB6B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjIYPaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjIYPaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:30:17 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B5D90;
        Mon, 25 Sep 2023 08:30:10 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id ACC555C26A7;
        Mon, 25 Sep 2023 11:30:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Sep 2023 11:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1695655809; x=1695742209; bh=TgAuFtIu6cq6sGedGPSBpY1cujauqO84fvC
        BuUD8cl0=; b=kXW43laceJenWVuo6y4LI4rWzr2fzjlUy+wFE9mUe7lI6wtTuEQ
        O+GlgygxiI58JYlsOJo85VB+J1BsLHTOZ+rjkQKyKXqKG3FLxstDBbAYxr9vpU/c
        UahN5mq97X+z4diXwEmzkVUlY7k7Zv2L15WMhuTnDvoFdulaxON98KqhbG4033TI
        nUCNQPVJHCoN3ssCxRXNr3QAuRy2Z3EswSCS+dlFW+5zaIg1VklcmboeALwzRsxG
        mZVGIGMHONvQ72h8NOg8jQjNE3hnlzGj3xYSqrDHxxdHSzQXobSiBFpzrX+tVgEF
        xcNSyj9syr1aawFsgFebgrl+GmKq8x4Eo+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695655809; x=1695742209; bh=TgAuFtIu6cq6sGedGPSBpY1cujauqO84fvC
        BuUD8cl0=; b=eqa9Pe/iz9+IhSailMcc0FYrcWXTuJjj943pDey/aqsnZJ/ZIUH
        MvBuLeVNUsdP/yRnFSbNvu4qZnOmJ++pVLO0Rf3uUW1reEoFOd5/ReyAk038hxLL
        vpT0zk5D/xaWP3iz/J0YVu3EEwM9+8JR5qRFNULwAM+ooC9ok0mU68Qh2sp8LUhd
        pcK2TAqpXK9yS0eL0YAqErm+I2IfLcWr9NhsMzasw/ndwXr8rF5EUvaHjlq8wr6e
        s+thtAWKEY/f/VCCSKSAGGKnZ6T0WYAZ/jqYO4PJvxlNdKF/Ptcj8yanqQUUzDdk
        2rtpUNgecMSDlR3yseCrGCgZsK2sRBzsF3w==
X-ME-Sender: <xms:gacRZVtl8U-yMgwwY3Bh9bERuAaDR4UhMu6pSosUnWCU-nx7IjcExQ>
    <xme:gacRZecFsozXhr0-yGYjn0MY2mp83SssOqx9r8rOHrkWOBcdK4aWH-XC_Wd8FawZ_
    kz4EQbP-IkGXlUXBg>
X-ME-Received: <xmr:gacRZYxlbpPARpNXaCPHJHIEksTG7ZuSdBqiGF_li6tbsQ870UFSEZ6Pv7c6oTfRcTasfz7a4hKYI3MH1h_p0-YVvCnbUC_t4Hq1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    efgfeugfdtgefhueeiudffjefhveeuheeuheekvdetfefgheehtdffuddtgfdujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:gacRZcNwMD8U3k_m4hPPv__PTrkAgxAoSHs4-9CpEhRYDUFYYp5GHA>
    <xmx:gacRZV_59radWZgSSahsDqZbhcuP-9M9X-Gd0YPb4h2d27GdC0muTw>
    <xmx:gacRZcUjrpEY_c607O_pUQwD4ox2_cNcLbcxKTezyqv7b_doL13ybQ>
    <xmx:gacRZW2hGpIvZ6xkiZ3LgfKVgV-rIgEOQdC_1-ilpT5za1KsM5Eqjw>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 11:30:07 -0400 (EDT)
Message-ID: <0b7fc71c-b3c7-4c29-92a9-587daa46ad59@ryhl.io>
Date:   Mon, 25 Sep 2023 17:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of
 `WithRef`
Content-Language: en-US-large
To:     Boqun Feng <boqun.feng@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, walmeida@microsoft.com,
        wedsonaf@gmail.com
References: <ZRGd4lsNP30L2yB3@Boquns-Mac-mini.home>
 <20230925150047.1961646-1-aliceryhl@google.com>
 <ZRGknJCB6tFgX3Gr@Boquns-Mac-mini.home>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <ZRGknJCB6tFgX3Gr@Boquns-Mac-mini.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/23 17:17, Boqun Feng wrote:
> On Mon, Sep 25, 2023 at 03:00:47PM +0000, Alice Ryhl wrote:
>>>>> I'm concerned about this change, because an `&WithRef<T>` only has
>>>>> immutable permissions for the allocation. No pointer derived from it
>>>>> may be used to modify the value in the Arc, however, the drop
>>>>> implementation of Arc will do exactly that.
>>>>
>>>> That is indeed a problem. We could put the value in an `UnsafeCell`, but
>>>> that would lose us niche optimizations and probably also other optimizations.
>>>>
>>>
>>> Not sure I understand the problem here, why do we allow modifying the
>>> value in the Arc if you only have a shared ownership?
>>
>> Well, usually it's when you have exclusive access even though the value
>> is in an `Arc`.
>>
>> The main example of this is the destructor of the `Arc`. When the last
>> refcount drops to zero, this gives you exclusive access. This lets you
>> run the destructor. The destructor requires mutable access.
>>
>> Another example would be converting the `Arc` back into an `UniqueArc`
>> by checking that the refcount is 1. Once you have a `UniqueArc`, you can
>> use it to mutate the inner value.
>>
>> Finally, there are methods like `Arc::get_mut_unchecked`, where you
>> unsafely assert that nobody else is using the value while you are
>> modifying it. We don't have that in our version of `Arc` right now, but
>> we might want to add it later.
>>
> 
> Hmm.. but the only way to get an `Arc` from `&WithRef` is
> 
> 	impl From<&WithRef<T>> for Arc<T> {
> 	    ...
> 	}
> 
> , and we clone `Arc` in the that function (i.e. copying the raw
> pointer), so we are still good?
> 

No, the raw pointer in the Arc was created from the immutable reference, 
so the raw pointer has the same restrictions as the immutable reference did.

Alice

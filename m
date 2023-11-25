Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A887F8D15
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjKYSYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjKYSYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:24:02 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49194D3;
        Sat, 25 Nov 2023 10:24:06 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 467D33200922;
        Sat, 25 Nov 2023 13:24:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 25 Nov 2023 13:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1700936640; x=1701023040; bh=6VzdufIFdS1KVHLqLyYYqDZbjY1xGQk8+nO
        uOIrXEKc=; b=y6xVQsvCSQKA1y0wl1rluezHfPeDaOcp9QHbqxiwSVkutUdGG7L
        lfetipLMqtccQX0IfAFQgjucUdqWqGSvcjMpZ057QhBTSTDunspNmSXWuhugCQyL
        dcggwKDwC4ZYuJZQgfZY02vIk4IfV7r4z3mt7fRCbI8c6IDh/xIGZXyaOzo9tZfk
        sdhOz+0NhlO5sd9OnG1bY38D8lkPqeCWPhLYc5R1Y17okpP57APn1RH6a93qlGvH
        tO03ibGcZb/a3EmxQzSjc2r+xEvhNMmuH8PnSRn5BqjossjO+XD7yTySh5rzHUEq
        MttrBfQKe+Ai+mT8X3SognqoM3RcUBc9e+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1700936640; x=1701023040; bh=6VzdufIFdS1KVHLqLyYYqDZbjY1xGQk8+nO
        uOIrXEKc=; b=MEjN9ghRN3Cd98RHBuJ9ufvyULVrigG1pvRD5jRLpHGP5yYN2fJ
        thc+Eq7dMhFCMvx8jBIoHALWo5puwptB0jWQc9mArVOSITxRpWAf5h0cjNT4Op/v
        X9vrC7ZWRdAqAJwjurIvFKJA6rENEii1iCO6NN2qzyoCPhXY7FP13qKpomyDQGPs
        8Ap7tKVhGjfzhkOKykqwFpJ9qLO3N1bg0uEG+Q+JqTTPMPjnb+wS1rtFwPif3Fx8
        p7Cj7J0iRELQHVV0FDu4dSeQpzpWhpBF8cAANj01QvhyoRx7IrKQMnkqbO8G0fjD
        JvFqECSrcAfROQFWZj1yhR2h613npGJ0U9A==
X-ME-Sender: <xms:wDtiZRtPaP82fRWJv1lBuTAwGJjkTddo3Q6ZkIKmCawZ49OC-Q3qIg>
    <xme:wDtiZacMVhVWrIW2mayVYXcLi7jQbKzXXg5k-T7Vlcx77Y-aeMRcqH0wqbtCyaj1r
    u9g646Yzy0w5JteZQ>
X-ME-Received: <xmr:wDtiZUzFVdg3XaTrJQBGhrquibz5zgo93gt3f6-EUq_O5_AADCy6lqGftn3f5H-6_5lHexz1JnO78ER-RiX5WhH55q_y0Lzbad3uciU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehjedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    epfefguefgtdeghfeuieduffejhfevueehueehkedvteefgfehhedtffdutdfgudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:wDtiZYO1ujr3a_PW8r8I-MGC8a6d0Ip4HcpYw3GYK-zfU3lBOtC_BQ>
    <xmx:wDtiZR-_muuifxiK_L45IFMPhbBSJxe0SJJfO4VRdJxShcDwaeMtJQ>
    <xmx:wDtiZYXWE-zSLjUHXAmXwNvQZJKeqIT9G8xkegNui-SfLL083m_IsQ>
    <xmx:wDtiZYWUkGsmymwMLR0g_uov_VbBW3pv-rSP2-I0ebgjOrhMPOOs1w>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Nov 2023 13:23:58 -0500 (EST)
Message-ID: <8562d4a9-2b9a-40ae-a37e-07406d650f4c@ryhl.io>
Date:   Sat, 25 Nov 2023 19:25:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rust: macros: allow generic parameter default values
 in `#[pin_data]`
Content-Language: en-US, da
To:     Greg KH <gregkh@linuxfoundation.org>,
        Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231125125024.1235933-1-benno.lossin@proton.me>
 <20231125125024.1235933-2-benno.lossin@proton.me>
 <2023112525-impatient-untwist-ee3d@gregkh>
 <t4HJjY0Oft2K2H1ssXTxZchdPTx25J6WqSJqAx75NiRUYg40BBLt1AHxm9ZF0UA70FkqIXb6Pp2sz3BErD-AyXmQCkU4xDvqyXHSinaWGb4=@proton.me>
 <2023112514-laziness-valium-7a25@gregkh>
 <5hsq7OfTOZ9Wi70n6p9nfFPr4IDJ9YECqWHEgsnMnzN3lcLeojK5ZlwR7nzDGdK5Wjrb95Jk60CGKszSiUhMsZQA2vlwSltMMypfk4HzgJM=@proton.me>
 <2023112500-pandemic-numbness-db06@gregkh>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <2023112500-pandemic-numbness-db06@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/23 17:03, Greg KH wrote:

>>>> Without this, the `#[pin_data]
>>>> macro would not allow specifying const generic parameter default values
>>>> and instead emit a compile error.
>>>
>>> That's nice, but it still doesn't tell me _why_ this is needed.  Why
>>> would I want any generic paramter default values at all?  Who needs any
>>> of this?  What will it be used for?  What does it actually do?
>>
>> `#[pin_data]` is a proc-macro that one can put on any struct to make the
>> pin-init API available for use with that struct. Since e.g. mutexes are
>> initialized using the pin-init API, you have to do this for anything
>> that contains a mutex.
>> This macro should be compatible with any struct definition even with
>> ones that have const generic parameter defaults. This was an oversight
>> in the original design, as it does not support that, since the proc
>> macro parsing cannot handle the `=` character.
>>
>> The short answer for why one would want to have const generic parameter
>> defaults is that the language supports it.
> 
> Wait, no, that's not what we do in the kernel.  We only add support for
> things that we actually need and use.
> 
> If you have no use for this, but it's here just "because we might want
> it someday", then we can't take it for obvious reasons.
> 
> So provide a user of the feature, and then we can actually understand if
> it is worth adding, or perhaps, it's not needed at all as other things
> can be done.

Here's how I see the proposed change: "The workqueue abstractions has to 
use a backdoor to implement something because the safe and more 
convenient API doesn't support it. Improve the safe API so that the 
workqueue does not need the backdoor, then update the workqueue to not 
use the backdoor."

>> And since there is nothing
>> that prevents `#[pin_data]` to be implemented for such structs, we
>> should it do it.
>> Rust generally aims to make all features compatible
>> with each other and we would like to do the same for our
>> libraries/customized features.
> 
> The kernel doesn't have a "library", that's not how we work, it's
> self-contained and does not export anything nor work with external
> libraries outside of its source tree.

I guess this is a question of terminology. What do you call the kernel's 
xarray if not a "library" for use by the rest of the kernel?

>> The longer answer is a concrete example of a usecase for const generic
>> parameter defaults: the `Work<T, ID>` struct of the workqueue bindings.
>> The `ID` parameter is used to identify multiple instances of `Work`
>> within the same struct.
> 
> Why not just declare them as different names?

I would have preferred to use a textual name rather than an id, but 
const generics currently only supports integers.

> And multiple workqueues in a single structure are ripe for problems, are
> you sure you need that?

Originally I had this in Binder for deferring both "flush" and "close". 
However, I changed that and now I use a bitfield to keep track of 
whether we need a flush or close. (So that if both operations are 
scheduled, I can guarantee that I run the flush operation first.)

We could remove the ID from the workqueue abstractions now that I no 
longer need it, but it would not really simplify that much in the 
workqueue abstraction. Its complexity comes from having to embed the 
work_struct inside a user-controlled struct, and once you have to 
support that, supporting exactly one or any number of work_struct fields 
is about the same difficulty.

The linked list abstraction (which I have not yet sent to the mailing 
list) has the same feature, and there, Rust Binder actually *does* need 
a single struct to have multiple list_head fields in some places, so at 
least the current state means that these APIs are more consistent with 
each other.

>> But if you only intend to have a single `Work`
>> struct embedded in your struct, then there is no need to distinguish it
>> from something else (after all there is only one) and therefore we want
>> people to just write `Work<T>`. This is where the author of
>> `Work<T, ID>` can write:
>>
>>      struct Work<T, const ID: usize = 0> {
>>          // ...
>>      }
>>
>> But the `= 0` syntax is currently not supported by `#[pin_data]`.
> 
> Why not just force a name for either way it is declared?  Wait, "id"?
> What is that for and what will require and define that?

Each work_struct field specifies an id as part of its type, and when you 
call `enqueue`, you use the same id to specify which work_struct to 
enqueue to the workqueue. The ids are purely a compile-time thing, and 
do not exist at runtime. If you give it an id for which there is no 
corresponding field, it will fail to compile. If you use the same id for 
two fields in the same struct, it will fail to compile. The id has to be 
a compile-time constant.

Furthermore, since the workqueue uses a default parameter, you only have 
to specify the id if you have multiple work_struct fields.

Alice

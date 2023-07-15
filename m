Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F57C754771
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 10:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGOIOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 04:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGOIOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 04:14:16 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2371835AE;
        Sat, 15 Jul 2023 01:14:14 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id F41985C0100;
        Sat, 15 Jul 2023 04:14:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 15 Jul 2023 04:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1689408849; x=1689495249; bh=Xoj9Xm8/Xd98EhXuvKJw7gbcAWTuMt5qlTz
        hZaCUcZA=; b=czFIb1Ix5sBw+Rqrc0P3Peeqt0KeEURhXqDTthtOOBeUl9DvOuy
        bEWb4uA2Bh6Pm37J7v7HCYowYHWxa0c1Y7OGzJGRh0IBk1NlTfGijlbNnp/noqmY
        8dCtQJrn17wgj1qK0cLdwwW4b51NGP7SsxODD8o4dzlkXcdsz2H1E1/8WyXBVVq4
        cRxd74RBWVkRQaIzefTOZcxf50OFDfLs/F7JyGyLB4wSe/ci0daNyJjdz7LHS+sj
        /yblcF8x6vlAHH18XiyjY6RsMIzj8BYKdMImX/4BkoknrSTXIpHIkpfWGL/4Vec0
        GFZlB/BpiJnieWC2YCw/5t9LkC42Pdpo5Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689408849; x=1689495249; bh=Xoj9Xm8/Xd98EhXuvKJw7gbcAWTuMt5qlTz
        hZaCUcZA=; b=gmeQg4/7x7VYZZrbBBgR60o0iPUsDUGHvlK3EnRnOp5kd5k6Evn
        vyMM/w4/4/p4FkwBheuRofnr1p9aoRPizjlQMUjH7LxxmDxhk6QpDtZ4RQNXTJzT
        nncO6Qor3DtZ2HOnKUljXNOroJoLDDA3qZfkUCyexBW+JEaf946uWn04I+iahg2f
        EtJGYw+AA+N3GIXBcapXfGFiIf84ajxGq441FJ/3XShLT08lUnRg5asIanG6jE1X
        o2+nwvlo0H6uxaryfSxdxzzWC0gwA+ZTBxwi5n489QZ6zGvv6THIXzBgQblB14zc
        qzlvRQRfXGrWwFJI3hmomiBHkYqjjqgcvmA==
X-ME-Sender: <xms:UVWyZJ_OJ7KSi3hE3G8ZZdKuyTLj3YLGXkOi8NWHpjPiEoS0gDps2A>
    <xme:UVWyZNvvH0NEy3xVF2tNYbxszi5xgJ_MHL0lEn-mdaSVxRRfzAOz_mgxL5-V277su
    0dwQzndOd7gB4pAuw>
X-ME-Received: <xmr:UVWyZHA6XEUVhkAh_PhYMvw1OFLDJNfDGQs5z1NCZxxtEee1fgbl5snm8s4BLKdAcQJSxji4bbsWHnjAYDb16A6WaGbctVuUtJlAcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeekgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheptehlihgt
    vgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnhephe
    duuddvteekvdektdduledugfffhfdugeejgeeuvdevtdetveejheehiefffeegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgesrh
    ihhhhlrdhioh
X-ME-Proxy: <xmx:UVWyZNft6Kic2apmVeAQTXD0roaE2Mgf-5apK0gRIZjvxlibVqwHjQ>
    <xmx:UVWyZOMyVCEvfnUZecWmGTzX_cO3rCZRrz8BcwDwozoACLPpcMmwhw>
    <xmx:UVWyZPk4vBrz0V-dp46IibsEqSjKOu-OI3WnvqwxIhwD8dvzKnTscQ>
    <xmx:UVWyZFmVcr17fcBSgNQSE2YVSlB6pZGryGBHIh-rmPS90n5yK5LaCA>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Jul 2023 04:14:06 -0400 (EDT)
Message-ID: <37795dc7-a121-b30b-76de-1ba6dd705c5e@ryhl.io>
Date:   Sat, 15 Jul 2023 10:14:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] rust: time: New module for timekeeping functions
Content-Language: en-US, da
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Josh Stone <jistone@redhat.com>,
        Gaelan Steele <gbs@canishe.com>,
        Heghedus Razvan <heghedus.razvan@protonmail.com>
References: <20230714-rust-time-v2-1-f5aed84218c4@asahilina.net>
 <87r0pax9a6.ffs@tglx>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <87r0pax9a6.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/23 03:17, Thomas Gleixner wrote:
> On Fri, Jul 14 2023 at 16:55, Asahi Lina wrote:
>> +ktime_t rust_helper_ktime_get_real(void) {
>> +	return ktime_get_real();
>> +}
>> +EXPORT_SYMBOL_GPL(rust_helper_ktime_get_real);
> 
> Colour me confused. But why does this need another export?
> 
> This just creates yet another layer of duct tape. If it's unsafe from
> the rust perspective then wrapping it into rust_"unsafe_function" does not
> make it any better.
> 
> Why on earth can't you use the actual C interfaces diretly which are
> already exported?

Currently, you can't call inline C functions directly from Rust. So we 
wrap them in non-inline functions for now.

It's something we definitely want to fix, but it hasn't been fixed yet.

Alice

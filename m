Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56A87B4739
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 13:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbjJALk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 07:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjJALky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 07:40:54 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1007ABD;
        Sun,  1 Oct 2023 04:40:51 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 844E15C0003;
        Sun,  1 Oct 2023 07:40:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 01 Oct 2023 07:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1696160448; x=1696246848; bh=8WHq2F+cLXArKpm8huR5coHN798rdLB0zNl
        u5b4ay5c=; b=Aunk1TX/6EGVjJFbTyvja9usoQL+74imS/TSloa7lVkRaqL9ljf
        eU2gVjg1jjZWOj91XJ9CyavWEXy6tRtSlcRkIaL7Ibva3uu7DfGXTIpr3zJ8eNu1
        1gZZovH3MFAhZdKSzx9F7aoGmxRXGv/A9+hM1IYIfOyRfijU48nzhSieNKNGIxRD
        DG3YcWX4ByhMgiTMKqfzGa6YzOue+SPfb7kSBGxC954AwZXOJ1V4E3y/0GbV/ErE
        kJ8PqZyv+CkHte3Pt6zy1DGG/LJTtbfMNf1g2HAf0qouW5MIQVgmtyPha6SzxBdH
        uArfcUVe3R1nvsno75m58oMCs2UvmGIErtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696160448; x=1696246848; bh=8WHq2F+cLXArKpm8huR5coHN798rdLB0zNl
        u5b4ay5c=; b=SiwNYMHGYXs8MyO/rRfLK4XXRik3FEostUwb7kox5QY10NHKgWt
        1ZPG1+WLeSuirHUu0zob9lJ00O/HIlT/MtNIt76VCw1FI3tKHtadL8ikcsA6PKYM
        O7movabugSgyAeaMV+JG/8wMEQDDrncOC9QTAIlkA0Y7XCjcmp5eTHwgxht95W+9
        xoqhEUE71q7Dp5pypjPF5NYqIpHuBM/MxZachM2o5OmPT9iju9cIqoeVTQiVMgkS
        4LG3xpLhFTm3urrvpmBg2n7vHOXSvRv9ptvDjl/Ep7v/epBqhHmlLvwLxrgKNfsI
        QfjymGqK9m9fvMUk/0CKhAsSxFs3TtPT4oQ==
X-ME-Sender: <xms:v1oZZZ2l2NnrdBWMicA8mzkt1vwsRx1WgRuIJc5d3nJCy5iycOOK_A>
    <xme:v1oZZQGuu4Ah3ZQnMrvz34i7qqwlc-gseZUF0AjHp6_l7clCiXEgnGj2h2VqtjA5-
    vYVVc0J-Cwh77Jqaw>
X-ME-Received: <xmr:v1oZZZ5UiqxQdN2ak8rdvg7eD_ZQOoZ218WjipQT531en3Vl2IsKYyPmqA0CJSbkmeywHXCMa0_vcg2ENY1tJcguTNdZI0UqWxU5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlihgt
    vgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnhepfe
    fguefgtdeghfeuieduffejhfevueehueehkedvteefgfehhedtffdutdfgudejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgesrh
    ihhhhlrdhioh
X-ME-Proxy: <xmx:wFoZZW1ndwluBc4tjUvx23ip-akb1AGgGnNgCPE0wOcMJZrgpje-Nw>
    <xmx:wFoZZcG7gmm5fmjcf79r4pytCE9HQgMEouo7R5Ltyd_bN-IrEyXgtw>
    <xmx:wFoZZX_zK1bDrl-ACUJaIFd2jdJ-ajfVpeDredVZFpkzEtL-8dPelQ>
    <xmx:wFoZZU_Ag9OBLK-rj5ty7iDjRyS2PfjqWlxAECpyaYfSWa2t2MjJ2A>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Oct 2023 07:40:45 -0400 (EDT)
Message-ID: <c2691aad-a73f-4bcc-a3d1-741335b4f63e@ryhl.io>
Date:   Sun, 1 Oct 2023 13:40:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: error: fix the description for `ECHILD`
Content-Language: en-US-large
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
References: <20230930144958.46051-1-wedsonaf@gmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230930144958.46051-1-wedsonaf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/23 16:49, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> A mistake was made and the description of `ECHILD` is wrong (it reuses
> the description of `ENOEXEC`). This fixes it to reflect what's in
> `errno-base.h`.
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/kernel/error.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

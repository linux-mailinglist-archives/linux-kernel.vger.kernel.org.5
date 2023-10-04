Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D7C7B8DA6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbjJDTtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjJDTtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:49:00 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB729E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:48:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 058A83200B34;
        Wed,  4 Oct 2023 15:48:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 04 Oct 2023 15:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1696448935; x=1696535335; bh=m+YtaNHzQeGnCoR5VELbPcNaBJr8BuhJhCG
        DiydOwyM=; b=VtjhnUVnQWbSSL2m5Vu5p1ueIV2tTe+F24x+q7dFFGk3MsIp1YK
        iQgaH+bfA8wSRvfglMry2Hph2e5YnRwUvRTqVjiNvvVBigfzdTwuKW+N8lQpjKiH
        RtRhEuqT0y7wZMvmnox4T7J948uu/n07TNtl4ziGnN7xjtNUglGCXMW70vAAot5W
        AiBLtmbii9txvSko6jdkYXWNFT67+78AyRcIaa4WtXfYlWaULyrTHnFQL7nhujXF
        Wz4x6kUI65bsdTK1ZPDXuif+fC6DEWqRi4jjhMF3NJ7jQ0g4n2To8eLNbfNqbssQ
        xHHLY3ACwbG2CaFyC1idIH9B6sqCERvYPPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696448935; x=1696535335; bh=m+YtaNHzQeGnCoR5VELbPcNaBJr8BuhJhCG
        DiydOwyM=; b=kL313fO69JOvFIS6+vVd0YaAbhojiybKvB7PbyW6NTQfoiuuQRQ
        9J2GTyEIvID7PIk3flN4ktCFX1e8Sl17Q/iujoo13+Jt6mgjlKLenonTgUDR8LYf
        omo65Ot8BjHXRgTDqYZ0IOvBd8yegeWFuCmpujaY6VYudkfqmVoevkq8pjoH8Okw
        pgsTyOeTbO4GEejrsLDOkQoUiFV0I2vCnsBFwLLwcbs38GHBylrONzwUraqj//oi
        jtIMB5p8uVVRTWfxPIA7E7TyaAVWTLOHW5XX629EDsLylTQqKdhQvOhJ8rn/RNhq
        /xspX2xKcJXOffuFBBv5Q3R3CoK7FEpzBnQ==
X-ME-Sender: <xms:psEdZV0VENkjVQcOqzWI5J2fCgpIrFj3dok6zlU_4cZzYe5M7vOAvg>
    <xme:psEdZcHCvH5RgCkpDhawsIPCnU5_tpo6iBsdUKKf4oKKrdWh6xZhc2Trb73JpcYcV
    2mv0fFp3O30WjGf0Q>
X-ME-Received: <xmr:psEdZV6qpGz2Xsey4GHLzYyA05yYmJJQv9lH96TwJ7JR0Ia8aRTT9sIQSUk1NJ2uPo6SCFod9V-49fceL9hyn30Xt-CINV0whKB5m5jd3_h1QC88KiVq28RjNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgedvgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeekjeelleefiedthfdtgfekgeehudefudeugeffvdfhudekleel
    fedtteejhedutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:psEdZS1quAo-q1_r6ecRaAsX_J0BMgN8P5MdVf9AN8koLL0L5QtCRA>
    <xmx:psEdZYFnqWN39u-mGLX6Cw_bES65Q7BmYKvEYHkX7qayzFOJafLH8A>
    <xmx:psEdZT-U8WuCJcM0v9U76Q21PRz1YCQ2_A48wPW3Ah1g4iF2wcY_5A>
    <xmx:p8EdZTBwIEMm32g21FP92PpT-C-_KUif9G2ZMUIFS0MKCsYB82Cyyw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Oct 2023 15:48:53 -0400 (EDT)
Message-ID: <e91a5006-ffa1-79a9-1679-cfb02bc974e7@sholland.org>
Date:   Wed, 4 Oct 2023 14:48:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3] RISC-V: Fix wrong use of
 CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
Content-Language: en-US
To:     Jiexun Wang <wangjiexun@tinylab.org>
Cc:     conor@kernel.org, guoren@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        falcon@tinylab.org, jszhang@kernel.org, tglx@linutronix.de
References: <20230913052940.374686-1-wangjiexun@tinylab.org>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20230913052940.374686-1-wangjiexun@tinylab.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/23 00:29, Jiexun Wang wrote:
> If configuration options SOFTIRQ_ON_OWN_STACK and PREEMPT_RT 
> are enabled simultaneously under RISC-V architecture,
> it will result in a compilation failure:
> 
> arch/riscv/kernel/irq.c:64:6: error: redefinition of 'do_softirq_own_stack'
>    64 | void do_softirq_own_stack(void)
>       |      ^~~~~~~~~~~~~~~~~~~~
> In file included from ./arch/riscv/include/generated/asm/softirq_stack.h:1,
>                  from arch/riscv/kernel/irq.c:15:
> ./include/asm-generic/softirq_stack.h:8:20: note: previous definition of 'do_softirq_own_stack' was here
>     8 | static inline void do_softirq_own_stack(void)
>       |                    ^~~~~~~~~~~~~~~~~~~~
>       
> After changing CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK to CONFIG_SOFTIRQ_ON_OWN_STACK,
> compilation can be successful.
> 
> Fixes: dd69d07a5a6c ("riscv: stack: Support HAVE_SOFTIRQ_ON_OWN_STACK")
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Jiexun Wang <wangjiexun@tinylab.org>
> ---
> Changes in v3:
> - changed to a more suitable subject line
> - fix the #endif comment at the bottom of the function
> 
> Changes in v2:
> - changed to a more suitable subject line
> - add a Fixes tag
> 
> ---
>  arch/riscv/kernel/irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Samuel Holland <samuel@sholland.org>


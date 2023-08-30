Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2563E78DFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbjH3T0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245545AbjH3PbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:31:18 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D60FB;
        Wed, 30 Aug 2023 08:31:15 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6A0BF5C00D4;
        Wed, 30 Aug 2023 11:31:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 30 Aug 2023 11:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1693409475; x=1693495875; bh=Q9MVoYIonRyskRfBCIP9y88rEy7hbWTJP9D
        lDE+1Rek=; b=TFmdkdxDJCh6QTuwU3AGuzXumkMQLdaMGMTXZeMFQ9IJuH2+F61
        1R6ExZnDwuJiA1eo5bcYmSqlUyuUeoL5lC+ioCfUoVhn6gh8Gfbs5eWCwYP78cZE
        1qYiJjkUGK/u7CfbVTw2PKCo/tDuGTUeHp2RbU05cJnl+rob3rNkoPSxW72qwvvG
        2CyBbisd4y8c4xSu4g66cB8t5UIw0U4VSizlH+21WI/QXOl7dn2PPZp6XKCT2QuH
        Lmm7AHsgwWUqm77rLgXcMkuj7RipbSg2xsr3TTp1hijDnoQTkDPOBt+BKeJc8XEV
        iaKvtPG8ijD0diOkC12baF7K6TIkWlGo6dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693409475; x=1693495875; bh=Q9MVoYIonRyskRfBCIP9y88rEy7hbWTJP9D
        lDE+1Rek=; b=XDcjE7uz8kS7bQYQhlN8VpeCymR09Xs6qfFDE74Ru+FWXsan+ES
        p5Z3+kB4Xp+vgmWW68wdwDkHIiLZow3wNbr6dGOOP4ISjtlQ88yDsaf916YwYjSr
        ZE17fBp/h6bx57e/eWZ1co1hJ4SDFT+Pb+wJdMv5NIzdgvTzBTOisqQ7rHXLmo5Q
        e0UFUiNGubH3z6ogzMKd/ecTblIZC8gVbSmg0vAkBa1qCdITn1xqalcTUb0e8a+C
        0luTc1x4KuKNSOqRoUK+c39g/jPtNDQetoNrvL5vk03nZCs36bPqHXVU8c5cnjQ3
        it0vkrIpXSXd/VgIeEwJBW6Q1CYVwCc31ag==
X-ME-Sender: <xms:wmDvZH_TC-KVSfxtykkyEc2-g85qjUg7wfM731Eg3csCfXbVzmmn6w>
    <xme:wmDvZDtDF0LGeGMH9-HrHiXT1tiT3GHUNnLGxs72PbHbwLQFrGL0wHtJvpbUfC0JW
    202RJaGZDy0j7k0HfI>
X-ME-Received: <xmr:wmDvZFD6EiZ1zh49iOvuFmx7X_RM0od-iLwDSREW_uEEvdfKsTv64fPYEynSIPt6cJsz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefkedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepudfhkeevvddtueekfeefgfetlefgueegueeltddtieejgeei
    heevgfehgfdvfeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:wmDvZDfgm6ms3MhGnJL8V4W5wwEQT8kblLRdegrkdKvym_dK1istKw>
    <xmx:wmDvZMOlx-PrcPBbNwKAoO_AIN49dIYUMnIckfJIJwYUfhIPoU4o3g>
    <xmx:wmDvZFlimcU7bZzDX6ygYUJH1PmLmFOctTYjth6aLZCLPtlGWgc6Nw>
    <xmx:w2DvZDlOME3JwXCFUc3VbCUN8nzunuyLJB2lVv3FOhUch0Bv0GaA8w>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 11:31:08 -0400 (EDT)
Message-ID: <a3e934eb-7517-f313-46d9-fd5335ce305e@flygoat.com>
Date:   Wed, 30 Aug 2023 23:31:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, diasyzhang@tencent.com,
        linux-kernel@vger.kernel.org
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
 <e62185ca-cdf6-bde9-ad46-f4150db9ed6d@linaro.org>
 <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
 <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org>
 <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
 <d11873a1-b552-71f5-1100-7464687f8bb4@linaro.org>
 <a084e6e9-46b0-42ef-b500-69c114ae11b2@flygoat.com>
 <3412e871-ae2b-bed0-88fb-2272f9db3af0@linaro.org>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <3412e871-ae2b-bed0-88fb-2272f9db3af0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/30 22:35, Krzysztof Kozlowski 写道:
>> What's the best way, in your opinion, to overhaul this property? As we don't
>> really care backward compatibility of DTBs on those systems we can just
>> redesign it.
> Deprecate the property in the bindings, allow driver to work with or
> without it and finally drop it entirely from DTS.

I'd love to have such configuration flexibility so I'd be sad to see it go.
+ Huacai and Binbin, what's your opinion?

If dropping such functionality in kernel is a must go, we can hardcode
to route all downstream interrupt to the first pin that passed to DT.

Thanks
- Jiaxun
> Best regards,
> Krzysztof
>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BC978DF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbjH3TMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245518AbjH3P0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:26:01 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2641A3;
        Wed, 30 Aug 2023 08:25:58 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C83925C01DE;
        Wed, 30 Aug 2023 11:25:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 30 Aug 2023 11:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1693409157; x=1693495557; bh=AaFcDVgrhZ295pye0qEwFTd49T4Nssp4TTQ
        GsEh1xIc=; b=aDsmhzs6QI4sIrgvfiBfztY/g8BZG8Hp9jhxVOjy4aRg5cidKQo
        u2cE+BGI/pQewviu5KmHsocF+w2KNNpSwsIjU6eKxAd2UXmMepLpqfU+Ijk8mPZF
        Uquho0cHv3PBhHW14rZ/sFpxD81V0L4srnLi8GX4rTJGmuUnJNAnb4L5nl2tufeW
        CvXeOEdIRpf1EcBC3L0b/m0DxOtv08TQBBXS8LKHxVzJ4wETNgqPhALxgoYTpz/2
        RtaR81bSu3K4cZobFly2O774Ckq3w/GuwYSTrZpvPx2avELD5Awnvi9Qa2Mj3m3g
        lZzbSKImOZIz0ziO04o/I1/41uGRDZK8FYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693409157; x=1693495557; bh=AaFcDVgrhZ295pye0qEwFTd49T4Nssp4TTQ
        GsEh1xIc=; b=dwU5GwuAtASSnsI3rhPslf55tZD4oLGZvdDGCCqvtxcHaUQfC+k
        bg3yqCFF4kRd20LC7eR9mjtzMSCh2n3otZqKVm2i7DAIvh4THvN2xycKCJsKJs5f
        zn6z5CZFjPwtI2qiIYf6xCLodyZkvVJSQSsM5yKtxGDAjXNBhGsVz27rQNSjcvDA
        g+C3T81IcnQ38H2rFjX7d8J99cMCEfJJMc3MUSiJIWeg3KUOCRPBHIbcNpb5FhjA
        YV7cx93dkAiYPLMQKMMks8asSrLR9vrOLMx5CJQAxVWNZjwrgUaOgguD0gGN9VqV
        u4Y9ZGR5Ni9EOWKTsCmDBJNFceg1YtFD3Ig==
X-ME-Sender: <xms:gl_vZDdcOgSNIg4It0AptkReM0-Zb5bMcOLe2zUFSbOVPcnmkm3A0A>
    <xme:gl_vZJPJXDjGH2rBxgJcHb8n_O2529xr-vqKr356rwpniGYahrJpwboITjg4_xMdz
    dMHwM1bMDZTcFjk6fA>
X-ME-Received: <xmr:gl_vZMg9gKHB6UHAQRVWt8-GqUgSqtzjoAsRQcUmhz7FpRyIluQbBV6SRXXaQCv5E16L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefkedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhephfehveeggeevieehgfdtveeigffgteehieehffetleetffeh
    hfeuteffudehfeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:g1_vZE9qX6T9airAv7FZo4C16WSxh6a9ejT_LormviSnKMHlFunn6g>
    <xmx:g1_vZPsBO3W0zimscDcE9iH_ffd2LU7h4uYse_A0-HEIq1wWuMpRWg>
    <xmx:g1_vZDH2MexKJ8ZStTa_5Bos4yKlUbHEcaomtR72h3CoYRqYTDL6FA>
    <xmx:hV_vZPGTWwpYRaKQPHaoh-n5Yu0rYQxPI4GHqSVQXmck_JY0S-GVmQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 11:25:50 -0400 (EDT)
Message-ID: <c7898abf-34ca-d0b4-fd0c-935100dcd3f2@flygoat.com>
Date:   Wed, 30 Aug 2023 23:25:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-GB
To:     Marc Zyngier <maz@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Binbin Zhou <zhoubb.aaron@gmail.com>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
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
 <86wmxcejav.wl-maz@kernel.org>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
In-Reply-To: <86wmxcejav.wl-maz@kernel.org>
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



在 2023/8/30 21:44, Marc Zyngier 写道:
[...]
>> What's the best way, in your opinion, to overhaul this property? As we don't
>> really care backward compatibility of DTBs on those systems we can
>> just redesign it.
> You may not care about backward compatibility, but I do. We don't
> break existing systems, full stop.
Ah it won't break any existing system. Sorry for not giving enough insight
into the platform in previous reply. As for Loongson64 all DTBs are built
into kernel binary. So as long as binding are changed together with all DTS
in tree we won't break any system.
> As for the offending property, it has no place here either. DT is not
> the place where you put "performance knobs".
Hmm, I can see various bindings with vendor prefix exposing device
configurations. If we seen this interrupt routing as a device configuration
I don't think it's against devicetree design philosophy.

Thanks
- Jiaxun
>
> 	M.
>


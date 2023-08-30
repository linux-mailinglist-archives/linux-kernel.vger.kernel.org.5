Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EDF78D2A8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 06:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbjH3EAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 00:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241941AbjH3D7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:59:35 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ECDEA;
        Tue, 29 Aug 2023 20:59:32 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DBB025C018F;
        Tue, 29 Aug 2023 23:59:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 29 Aug 2023 23:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1693367969; x=1693454369; bh=B7v0oKwXlhirKI8pFGlX+Cq5iQeRFkHRzlG
        lNb+nzfw=; b=2sADCFHW5sbgkFcJ0EdRYBEKUTK9VJaJe8hb6N904J9biqCdGaE
        EoqOTGYBYNs3HuvCYbFoD6SFg3DgAB6+WLf5uQnmg99nhRCSIkx9ppFW8vccXwTM
        SRkBxIYf2K0wTMnEizkh0J+KiP0P72c/A4DONtdrURWCb9FthfhwtnqnTNSHibHI
        H5iGxbnOpaTSyH5jTfMheC+rI6Vajre5fOCDJg3CsGD2p5s5ZvgSnwDkZDXj/+ka
        WDBdsFjgpZM3xwel/ZFeIaSM8+agec6cSBL4A0bAwS1q0wwCXabCQ0Flss2e+UK0
        pTgGzWJS/wSvdtkRod9SAsfHkUB/9zSB2MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693367969; x=1693454369; bh=B7v0oKwXlhirKI8pFGlX+Cq5iQeRFkHRzlG
        lNb+nzfw=; b=wmapuD0lAvq1BXqvqduR9c5acm+NKGsAeGoEVDr0iCAAEhmraH0
        pdrkUc7+1xa93AaDLhmMJCxi3BYA9AIOgHK1rXQKk1E+6gfHxQoJvyal38jU+WQo
        Is8W+5q+Z3Ir8SWPeIf+0MlqIlIWJYTs/uWb1EGZh4D/GS74pjGnR9ZMkpEkovBX
        yTqkRSDMvhuMW8s5zBZipl0Hyz/PzsZClK3yxk7/Ubz9lcPzjxqhn+9Wz/Q39Nj1
        q+7PGiqXN/C6dK1pKw5hjuXo2BU9yI4Qrzj0PHBnGMHCgJ47jWTlhwz/LZ2kv+2z
        45kG56Z62vpkfH5rlCbX0SkqXYZIeCafvAw==
X-ME-Sender: <xms:n77uZGKZjaSjbJtyTO3VrmGkLFGsSvz6uV_MMM0UaRiyVDL859IXFw>
    <xme:n77uZOJ2ZvI7aLlM_VkskAPaMFNubaQpEWv_RMQQR2KtuMe2xl49nn8jTSFUsCw2k
    uPFD-J-GAh2HmaGUzE>
X-ME-Received: <xmr:n77uZGsCKNBImJzesDkANPzsLZvRfVC9l9aQTj3gYVkXwH70r4sfpuR8CWrt1xfIhmJ->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefjedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepgeekgfevffegueefvdfftddtgedvhfduieevgeekgeeifffh
    tedtjedvfeelgfelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:n77uZLaVvNz2Yb9sxo2cJVRXX7ypArRitZFX45v-OYGjW5Z8dqFx8A>
    <xmx:n77uZNYG2X44Ojk8ra1mdGrcXfNr_-mfJrJspEO_sSq3LlUzz9H2xA>
    <xmx:n77uZHDJumBG00mbPA-jaUdEKMauy7TYOMz_9CMoHT2ztbqN7oxE5g>
    <xmx:ob7uZDwkXBp1_rEeue20-vGHOWnCPoJbcLE0g0Pu4CvVQ4gVNZejfg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Aug 2023 23:59:23 -0400 (EDT)
Message-ID: <a084e6e9-46b0-42ef-b500-69c114ae11b2@flygoat.com>
Date:   Wed, 30 Aug 2023 11:59:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Binbin Zhou <zhoubb.aaron@gmail.com>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
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
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Language: , en-GB
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
In-Reply-To: <d11873a1-b552-71f5-1100-7464687f8bb4@linaro.org>
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



在 2023/8/25 20:56, Krzysztof Kozlowski 写道:
[...]
> How did you sneak this property? The version - v2 - which was reviewed
> by Rob:
> https://lore.kernel.org/all/20190905144316.12527-7-jiaxun.yang@flygoat.com/
> did not have it.
>
> Now v3 suddenly appears with Rob's review and this property:
> https://lore.kernel.org/all/20200112081416.722218-4-jiaxun.yang@flygoat.com/
>
> Please help me understand this property appeared there and how did you
> get it reviewed?
Hi all,

It has been some years since this series was merged.
My vague memory tells me there was some off-list discussion made in IRC with
linux-arch folks and IRQ folks to come up with this binding design.

In this case I guess I forgot to drop Rob's R-b tag when updating this patch
between reversions. I  apologize for any inconvenience this may have caused.

>
>>                                                  <0xffffffff>, /* int1 */
>>                                                  <0x00000000>, /* int2 */
>>                                                  <0x00000000>; /* int3 */
> So now you will keep bringing more hacks for a hacky property. No, this
> cannot go on.

What's the best way, in your opinion, to overhaul this property? As we don't
really care backward compatibility of DTBs on those systems we can just 
redesign it.

A little bit background about this property, LIOINTC can route a 
interrupt to any of
4 upstream core interrupt pins. Downstream interrupt devicies should not 
care about
which pin the interrupt go but we want to leave a knob in devicetree for 
performance
tuning. So we designed such property that use masks corresponding to 
each upsteam
interrupt pins to tell where should a interrupt go.

Thnaks
- Jiaxun

>
> Best regards,
> Krzysztof
>


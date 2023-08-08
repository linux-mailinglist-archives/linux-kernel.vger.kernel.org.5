Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5940773E90
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjHHQcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjHHQbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:31:00 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB231394F;
        Tue,  8 Aug 2023 08:51:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 92B0432007F1;
        Tue,  8 Aug 2023 10:55:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 08 Aug 2023 10:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691506522; x=1691592922; bh=qM
        9p1VvgDQ68BCFOyyrSFNt07dndXA3zR/iN+rXNXdE=; b=EGvnh+3YW6raxmHExk
        l+oplb/Rkv4u8bnBVVIcjFu0rID8pDt3FBe2kyXloio02v/T9zaVNJxY2sBnlsK8
        GFxVzE08v6CIZ9RZ0MUZ8vP/vAztFKNM8pGkWBPTZGQeLuEkvolxOfuVQZGlqy9b
        WTBQfgJqeofF2qeCRrcXdCmPiuAcc3jcQJbssNnsx8ifl3hlXSLqpkoXiF/PE/Wp
        /LiSQXnH4YSxWIRLN5HhfgJJijd19hloeFviZklGXKvo4/nxaPUz3rV5d5NFlaTI
        3i91aP7VkQdDAwDRORO0bBpNCwrV2OZZFiUL/Ph+/QswHuVbXcWEh6Q2Uu863IlJ
        HNgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691506522; x=1691592922; bh=qM9p1VvgDQ68B
        CFOyyrSFNt07dndXA3zR/iN+rXNXdE=; b=iiAxVSVeGknxHB2f4jAZeQExin81r
        4FSRXd4RztPI9LtZbwVufhsvY8z34Hw5Cgq9LQEiaU+B9NGk+6u6Z8UVQGjIO+cp
        YIMpPs6nfMl+NLnIiTnDnwZRihb40DmaA47cg0HJZBBunIlhh0v1tk7cI4ktMhfB
        zeotgq0FTeTfgnZeT/wwWi7JMKVv62ozjPpftlpmE1aizCi0DXK7V3ZNqi8xXHel
        WRNbaHePp4CmPNIWkWT7TVCtq+PsSWArSISk/Nwz8d/8tDXyAq/yeUzgKYr2j/Jk
        RKKwMflAoXoX5/qaxulswaz2c/pXyXKGjz2/l0qQtRrjwM53xed4VPYrg==
X-ME-Sender: <xms:WFfSZFn8QXJQBZxWujkpLrCDAvk8i7qOs4jyV1N-xjOY16_67vtKFg>
    <xme:WFfSZA2E0gb7XUYmwJuW4BGgfSzZMpyd3OoA967QQBGTRN4iajSjU_h7NYlxZhryO
    dtbRANsvnI0bY-76kM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledvgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:WFfSZLo_ogOFHX6UVKrYjJM2u8mal53AaC42v-l3zX-woAB6nYHNaA>
    <xmx:WFfSZFmqsaEYE3OM4ZAiuW-lYv4KcxeEgU2YkrdEZibHMa-25xC2Gw>
    <xmx:WFfSZD1CAeyZjgxeehOdtm1TwIDclaDKbNgPzZdnVWSFucjQnqg6pQ>
    <xmx:WlfSZBOhyzm43yCApWoWXfPZxu-tKzrSHCK0a3Tgrn40b4obY5epqw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9C683B60089; Tue,  8 Aug 2023 10:55:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <8e6dce33-980a-4e63-9a8b-b681e3f9bf83@app.fastmail.com>
In-Reply-To: <CAPDyKFo7p=aEWWrW2OGbhN1tFjHanpqjLApzCMipdPSzE+NknQ@mail.gmail.com>
References: <20230803063703.5659-1-zhuyinbo@loongson.cn>
 <20230803063703.5659-3-zhuyinbo@loongson.cn>
 <4fef9725-7aea-43fb-b8ef-d20a4c6d9a68@app.fastmail.com>
 <CAPDyKFo7p=aEWWrW2OGbhN1tFjHanpqjLApzCMipdPSzE+NknQ@mail.gmail.com>
Date:   Tue, 08 Aug 2023 16:55:00 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Ulf Hansson" <ulf.hansson@linaro.org>
Cc:     "Yinbo Zhu" <zhuyinbo@loongson.cn>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, "Jianmin Lv" <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, "Liu Peibao" <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev,
        "Liu Yun" <liuyun@loongson.cn>
Subject: Re: [PATCH v6 2/2] soc: loongson2_pm: add power management support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023, at 16:42, Ulf Hansson wrote:
> On Thu, 3 Aug 2023 at 09:03, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Thu, Aug 3, 2023, at 08:37, Yinbo Zhu wrote:
>> > The Loongson-2's power management controller was ACPI, supports ACPI
>> > S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
>> > Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
>> > (USB, GMAC, PWRBTN, etc.). This driver was to add power management
>> > controller support that base on dts for Loongson-2 series SoCs.
>> >
>> > Co-developed-by: Liu Yun <liuyun@loongson.cn>
>> > Signed-off-by: Liu Yun <liuyun@loongson.cn>
>> > Co-developed-by: Liu Peibao <liupeibao@loongson.cn>
>> > Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
>> > Cc: soc@kernel.org
>> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> > Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>
>> I'm still waiting for Ulf to take a look here to see whether
>> this should be in drivers/genpd instead, but he might still
>> be on vacation.
>
> I don't think this belongs in drivers/genpd/ as it's not a genpd
> provider. Besides that, no further comments from me at this point.

Ok, thanks!

Let's try to finish discussing the suspend-address question
and merge it through the soc tree once that is resolved then.

     Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B5F7CBCA2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbjJQHpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjJQHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:45:05 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1437995;
        Tue, 17 Oct 2023 00:45:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 181BA3200AA5;
        Tue, 17 Oct 2023 03:45:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 17 Oct 2023 03:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697528699; x=1697615099; bh=DF
        BeCzjQflpg69NWHcq4wfPjEuoiGbDRh/Ql8FSePAM=; b=bsmZjlMSnCfjul68CW
        J5OXTUQN0yVKRhtgmzFwgVuNYbb00fCD6HN3yFwX/GuTgNOjp4bU4IcAQ/4iARgZ
        0AvsBLiOroNGlkiVI+pFr4Sqy5qztHArP9xbuVAIzdmyCDmRPC2TduNeq4bVcUWi
        aeIv3e4yF6ZBnHgH2UlX6IQw0cytZ3kdsq94trUKvbU8YRyUWd+gtZTH4VpPBBAD
        y6V6DDinhad1pI0NzeJe59YAMvQxffsTUyw8TAwiMNBSTmHWO9+xf9HYSADz39Fu
        jvwwoaxJ3RqC031r/OPj/HgVoOTOIXGcYEXeIbkXXllQyJ6Pf6P6+rjhxdJSAr7r
        /sAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697528699; x=1697615099; bh=DFBeCzjQflpg6
        9NWHcq4wfPjEuoiGbDRh/Ql8FSePAM=; b=FyWYgxbJ8lCVseKAGjkUINPR9xmnG
        SmtOCcBxMWZG/cOMEAAjyiJTVEpKcE14ALF2y3qCqGKEwRTNWD2lm1LjJXBHdyRh
        v7Q5ECBBYKjRpGPLExEW1tGRun1HSvBq9WBKn30LKkxhoDHMm1ircKRGE6B0i8jE
        lytmlAeFbl7jekmI3b8cudxYwwrfES2Mfdqa5SFjBChTxDahNjFEBiwEShCCcmBl
        gS52cV9tuHsMe/J83L91YeNIGxkSBARpMe/uJtTL/UzKXQvoCkPG7CZvPUkoW2OW
        94BsBpiDyTYwS1XkQN9FVn97lxGSYsAZLJ0SGcjR+p/1gDLUUuwUvVJgA==
X-ME-Sender: <xms:ezsuZSt7LcHK7_sdtlPiimUeGCVKaWc9cATvSpjcaYiu4esESfeKJQ>
    <xme:ezsuZXcvoDpXQdytXdBnj63KbBPbmxi4WNe-R4jPU8EIr2G-6MXN8RT4E3mH4smhB
    L4970ysvwj2RtfuBvs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedugdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ezsuZdx37cuBAVPUKKF03khlwpaXFAKuumCppwVOLRCNZQphDU4z9w>
    <xmx:ezsuZdMcf7mqrohM80iMu06zvYsV_5o3sDDTdyUla2T5P-Yhq3apKg>
    <xmx:ezsuZS-czPe_HdyaJ1NXqdx4Pmcr97mo2AuOOMBaxfznrqKalFZDQQ>
    <xmx:ezsuZZllfzjQdL0MbYKP0kUq9k6vWUYPs3nZ7sVnu7BY04m51cgd2A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 478EAB60089; Tue, 17 Oct 2023 03:44:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <6d362e80-9837-4dab-99a5-51b8eb241b5b@app.fastmail.com>
In-Reply-To: <2023101752-canteen-uniformly-acc1@gregkh>
References: <20231014211051.GA29518@matrix-ESPRIMO-P710>
 <3d1355bc-d359-4ff6-aee1-fbc84437efec@leemhuis.info>
 <2023101752-canteen-uniformly-acc1@gregkh>
Date:   Tue, 17 Oct 2023 09:44:38 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Thorsten Leemhuis" <linux@leemhuis.info>
Cc:     "Philipp Hortmann" <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Kalle Valo" <kvalo@kernel.org>,
        "Larry Finger" <Larry.Finger@lwfinger.net>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: [PATCH v2] staging: rtl8192u: Remove broken driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023, at 09:20, Greg Kroah-Hartman wrote:
> On Tue, Oct 17, 2023 at 07:33:49AM +0200, Thorsten Leemhuis wrote:
>> On 14.10.23 23:10, Philipp Hortmann wrote:
next-next-all/builder-live.log.gz
>> 
>> Made me wonder if this patch left something behind; a quick grep showed
>> something suspicious in drivers/staging/Makefile:
>> """
>> obj-$(CONFIG_RTL8192U)		+= rtl8192u/
>> """
>
> If you did 'make oldconfig' the option should have been removed and then
> this line wouldn't have triggered, right?  Odd, but I'll go drop this
> entry as well.

It looks like "make clean" enters both the obj-y and obj-n directories,
unlike 'make vmlinux' or 'make modules', which only care about
obj-m and obj-y.

      Arnd

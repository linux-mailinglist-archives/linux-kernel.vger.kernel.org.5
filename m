Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A43F794465
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244326AbjIFUU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjIFUU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:20:57 -0400
X-Greylist: delayed 465 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Sep 2023 13:20:52 PDT
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0070419A4;
        Wed,  6 Sep 2023 13:20:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id D74F7581298;
        Wed,  6 Sep 2023 16:13:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 06 Sep 2023 16:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694031186; x=1694038386; bh=4D
        QpkjWhlnU/jRaOv5cdvU9fDBTugxJNiIsRvReEP5Q=; b=B/0zM6yqj9l7vx9sk4
        eNPXsFyJgJcYg4fAxPjGMeD6oYtP6/MxD79AJifJc6ZZIbg+mQIpDI+/3AtxbMXL
        Ft+ECX9UGtQT7GxpY9ozLVVnKoVqFnPn/C80bZllK3I0G30w3ZKqUBKmhiHr6h5e
        JbQnidbQWuEToSqmf1ijLXt9v9+yug430tseWzahpScJ/yzr0b2VsubJ32jlVjLO
        fNeTuFnuVYgFGpobHBvSWM5bWV8j9vFTaZUaZp+uoEmgbJMhFn66NVUsrP9N4jcG
        CM2gndG8yjxDXyGIqAfjXWuUIOcz5hwk7rkgLk4PA5dCVijxnIem/aOR8qmnUM3E
        22mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694031186; x=1694038386; bh=4DQpkjWhlnU/j
        RaOv5cdvU9fDBTugxJNiIsRvReEP5Q=; b=I8BDpAvNFOe3vb6c6SYdbJSOvTHjC
        jWkK5/vL46nf4cbwv89chgSRUHu2AT1z/fjDP17xKeV7WCqtCojQEBRQHvJFxgSb
        tIpLbt7U3dBKxMbux9t6OgCAPXWQnJR6qPGj/ooER3OhjYxkrcs7N32IWS57dspJ
        sf6VWA4CDw8XJkt/rehjNnKji16SP9FI6po/GK5/TFg/Ka6ux7G5ptXQqo33X6CW
        YLWWO8LMtA9ShXpPbjy0jvE/OPCDf4GJvD9n8KqQaVFyUz/KMTm6JmoTceSFx7MY
        yW/mSH2nI1cIVqM6XYRxgmSSDNEZIb6Tkk8/IgcpXdg/gjalJm348HHAw==
X-ME-Sender: <xms:Ut34ZFd4r0fnLRJavypQ55BBrmGd4tfg4K6xGkBzqUBafIQ71ZFrxQ>
    <xme:Ut34ZDOD_tVL5KIp0FQ6kG9H0MAmI534dnH8pm8YEzhaV0C4LQwYl7fM60FpxOHz1
    NwL7osZ0f8lWodShQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Ut34ZOgGouuk1xWd80zCX_HPvgQuKqiJxWNppQopv8KFuzF5U0O_vA>
    <xmx:Ut34ZO_M9LhzJIZGWrLcuxiN4bSCzSnWUCepDsvSUtPS2z6M6wO5dA>
    <xmx:Ut34ZBvA8RrH1dVbVcg6-aKo5kihYmXpAJp3GXTjJsmR-C9eStAnuw>
    <xmx:Ut34ZFihV2WwqtoBQOOIDv381VDcDlTmMY-yv8lpSO6xYMmxEqn8PQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 88D49B60089; Wed,  6 Sep 2023 16:13:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <93e5e75d-3cfc-485b-9f81-54c82c58e24e@app.fastmail.com>
In-Reply-To: <6406fb2e-afb2-461d-9bac-aa157cf6d16f@leemhuis.info>
References: <20230901122424.247070-1-daniel@zonque.org>
 <6406fb2e-afb2-461d-9bac-aa157cf6d16f@leemhuis.info>
Date:   Wed, 06 Sep 2023 16:12:43 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thorsten Leemhuis" <regressions@leemhuis.info>,
        "Daniel Mack" <daniel@zonque.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        manikanta.guntupalli@amd.com
Cc:     linux-kernel@vger.kernel.org, stable@kernel.org,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Linux kernel regressions list" <regressions@lists.linux.dev>
Subject: Re: [PATCH] gpio: zynq: restore zynq_gpio_irq_reqres/zynq_gpio_irq_relres
 callbacks
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023, at 09:49, Thorsten Leemhuis wrote:
> CCing Arnd (wrote the culprit), Linus (reviewed it), Bartosz (applied
> it), and the regressions mailing list

Thanks

> On 01.09.23 14:24, Daniel Mack wrote:
>> Commit f56914393537 ("gpio: zynq: fix zynqmp_gpio not an immutable chip
>> warning") ditched the open-coded resource allocation handlers in favor
>> of the generic ones. These generic handlers don't maintain the PM
>> runtime anymore, which causes a regression in that level IRQs are no
>> longer reported.
>> 
>> Restore the original handlers to fix this.
>> 
>> Signed-off-by: Daniel Mack <daniel@zonque.org>
>> Fixes: f56914393537 ("gpio: zynq: fix zynqmp_gpio not an immutable chip warning")
>> Cc: stable@kernel.org
>
> This seems to be a regression report that comes straight with a fix, but
> there wasn't a single reply yet afaics. :-/ Maybe the extended list of
> recipients will get things moving. But to ensure this doesn't fall
> through the cracks, I'll add it to the list of tracked regressions.

I don't understand what the GPIOCHIP_IRQ_RESOURCE_HELPERS change
intended to do in the first place: Manikanta's patch changed the behavior
here with the addition of GPIOCHIP_IRQ_RESOURCE_HELPERS, while my patch
was a cleanup that removed the dead code.

Daniel's fix reverts both my cleanup patch and part of the original
change, which may or may not be what we want here.

      Arnd

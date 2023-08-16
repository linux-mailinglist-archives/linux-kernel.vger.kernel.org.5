Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F29177E23B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244843AbjHPNK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245414AbjHPNKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:10:44 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC1726BA;
        Wed, 16 Aug 2023 06:10:42 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9A3193200921;
        Wed, 16 Aug 2023 09:10:40 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 16 Aug 2023 09:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1692191440; x=1692277840; bh=dbk6un3F9NnxFuDCsKeUUKbwa0Jf99CB0Bc
        mOR3Wn+0=; b=CLEqak0tE68MU7X604tFBhFvR3ckdz9EVSqebZDPM4412w5LT32
        v39CH8OHGm1G46dZFDLtCVNJDg9Iqb/lXNC6YIZc4qKv8YuF1ocRjytH43SYOlVO
        x5K8Ianu6vf9dVHikV7j2zQk3cTu4+gbTWDPgeVXWrfUTJHcbzA4hFVIqtdFcGbQ
        n9WvYCZsLJDF8OpxjZp2DY+RdN1QHlHy58tqLrXukT4KbHRV7Zj8Kwul8QOuqHLW
        sNMOPFbLMYflBBiG6gG5XfKDOtS+lJ51zu4raPz7gho3HxC3QXB8hz/Dv8QBeYOF
        n+cL+LFUtuKWP/8N9W1jaf7ZSeXOhzbvYNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692191440; x=1692277840; bh=dbk6un3F9NnxFuDCsKeUUKbwa0Jf99CB0Bc
        mOR3Wn+0=; b=Ei+4V9vSBYhEDhIyw2K+eQBiq8yLHWNbg0Vyqb03n0nh9NiUtmu
        3YXh7IzxYKbFzhgwBkpfqkfaBn2/PWQHNBd9YG3zRC2Wd0qbmB/zYqfJg40il6YT
        sZJSzGVvsSV1jCBNQBavIUi9+tJAkjlT8Z3y6B50ichQEjlLmqz50klHvppwLjcZ
        IS3ZNrKwYlE87Pk+40xA4ylWSTiomicW37jPfGqtBGmMLIGwx1UFegnYrhpgFM4s
        1m7zhytJb11/eLsSRxCNEj9MECsLhpz28mQ+MG8d7156A1ot/viEXUM8HM0uCLJU
        sk9yjgzQNxYi8T58q9L99YOk1z4EZV4DMhQ==
X-ME-Sender: <xms:z8rcZGMqhiJVQkL9IjXfwu6mnuORyhH4MOQNJ6tTLpHgsNL0hCWNjg>
    <xme:z8rcZE8ab3LP9R4_kopyEp8YI4FkZEnFsfnW-PvI1gzmW1vDbYUguUdsM1a8-8hc2
    RM2tIW0-QftF3fdc74>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtledgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:z8rcZNSFJUXm7tJqf7pd6zJ-EhpqhX-9I0DqEBem-u93B8xOQvN4pw>
    <xmx:z8rcZGvfiaO3tkaZnFUGFgyt5KmPTxXcwNlIy9lNYpYAp-jGUHg73A>
    <xmx:z8rcZOcGVn25vovTgrgWsZD4t0r0gdxoKcMNA6RoCfJAaeh4ry4OGg>
    <xmx:0MrcZEvWn2oPgo6BgojWIa1ndLwZb8v7cKa1MK4BQTXiGxqNB7S0VA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7A443B60089; Wed, 16 Aug 2023 09:10:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <500a73ea-98e9-4b85-a34f-88a7bd98550d@app.fastmail.com>
In-Reply-To: <20230816113326.1468435-1-geert@linux-m68k.org>
References: <20230816113326.1468435-1-geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 15:10:19 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        "Valentin Caron" <valentin.caron@foss.st.com>
Cc:     linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: stm32: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023, at 13:33, Geert Uytterhoeven wrote:
> If CONFIG_PM_SLEEP=3Dn (e.g. m68k/allmodconfig):
>
>     drivers/rtc/rtc-stm32.c:904:12: error: =E2=80=98stm32_rtc_resume=E2=
=80=99 defined=20
> but not used [-Werror=3Dunused-function]
>       904 | static int stm32_rtc_resume(struct device *dev)
> 	  |            ^~~~~~~~~~~~~~~~
>     drivers/rtc/rtc-stm32.c:894:12: error: =E2=80=98stm32_rtc_suspend=E2=
=80=99 defined=20
> but not used [-Werror=3Dunused-function]
>       894 | static int stm32_rtc_suspend(struct device *dev)
> 	  |            ^~~~~~~~~~~~~~~~~
>
> Indeed, the previous change mixed up the semantics between
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() and NOIRQ_SYSTEM_SLEEP_PM_OPS().
> Fix this by using the modern NOIRQ_SYSTEM_SLEEP_PM_OPS() instead.
>
> Reported-by: noreply@ellerman.id.au
> Fixes: a69c610e13e2b2de ("rtc: stm32: remove incorrect #ifdef check")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

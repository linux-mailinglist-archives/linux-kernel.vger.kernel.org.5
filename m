Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ACC7C0498
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343519AbjJJT12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjJJT10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:27:26 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2883CA;
        Tue, 10 Oct 2023 12:27:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CCECF3200A9C;
        Tue, 10 Oct 2023 15:27:12 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 10 Oct 2023 15:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696966032; x=1697052432; bh=G+
        O2giSg3nsUU1PmtjUETbakIyQRebZUgOxuV8S3Wko=; b=RbBKakaxR01yy02owi
        8Gd5RUvkBg8X0tGsC6TH0Aj/8iu+gvTmGowey/8bKcRL9i31/AUzE4HE0RmwKjC8
        0vddXWeZI68Lrjh+jRNqEJzSC8HcLkukJ9Y3jRcu1MwbgFBGWCJq7lB+fUC7Ov1r
        MPTuEvuPfuDJjNJBgTffyWrUduDHeEARiYyV/PXbyadmNhu9Fu9kf8SDaKfqX/Uq
        IRysHs+R8BDLCImwKzZPelmusoLakH7qx5kYOGr8y6XMDc1NeZKl2e5QN9gw1Aic
        A7qNFGIR1X4WzOuKmibG2zQ1uR3CEk0402cWyjm564moiRH8Qn1N/sB/OSYvuUdQ
        b/3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696966032; x=1697052432; bh=G+O2giSg3nsUU
        1PmtjUETbakIyQRebZUgOxuV8S3Wko=; b=lE7Ci95rsVy7uu1yNxofaex0A/upg
        toWEMkTBdujv8KKMAldAIWM5m3BAUs87IwUzZx5kDIvWITdjstSPQJ6ZYxxXlH67
        0C0V66IjahRlg8/ap5/UO9UrDKAQ2cA/vOyyb0s36uE80ocmDXb5A1OeAUhFTCq4
        voMrlHVHzfjEy/pZPXwd3gq96Dzno4KD4HlQRrNyrDKVwKw06mjeM0VnK6VooEHZ
        oX8CqSjmpTyEOrwCh6pTz2aFlb6qV7XwC8ZQw8yCJWZB2nGh6F7AcMp+VM2xCjFB
        Mks9cYQCq+Ah+M/YETnVevaLxvMXjxTv0gDef0aMxOOKaMZflmr8Bw49Q==
X-ME-Sender: <xms:j6UlZcsIY4YOfcxTFm5kWR-r9SNvnzm_GHQx3iNNBQCBQCYNDAdjBw>
    <xme:j6UlZZc8K59RS64WSGWzBhd-NeeWszYWTzSyDb01QQuRXKk0kr4H5dAoga3PLWXHb
    2ZmVVoEN6cyUvtjZjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheehgddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:j6UlZXzObGJYPQwH1C-3EXr4t_iuhjg1a_5gZu56xUYKpv3zR5JQXA>
    <xmx:j6UlZfO-CtFK2I2kz2QDZW5ILwCdzPFIPgAH8zwRP0CdQ523PRYALQ>
    <xmx:j6UlZc9jaacYc5wYDjIlNsZ7Iz4NWPSDPfNUFbj4zQyLtNFe4HJemA>
    <xmx:kKUlZWcpif-uFlmOZSNzyMep3pyZdXMt7Gp51heMTBA5Adp9OmQN8g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 448A7B60089; Tue, 10 Oct 2023 15:27:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <a010cff7-176c-47a0-91bf-92177a9945b5@app.fastmail.com>
In-Reply-To: <7b764568ea372f0a947798fb3c2dac75.sboyd@kernel.org>
References: <20231009114514.120130-1-arnd@kernel.org>
 <7b764568ea372f0a947798fb3c2dac75.sboyd@kernel.org>
Date:   Tue, 10 Oct 2023 21:26:50 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stephen Boyd" <sboyd@kernel.org>,
        "Abel Vesa" <abelvesa@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>
Cc:     "Peng Fan" <peng.fan@nxp.com>, "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Jesse Taube" <Mr.Bossman075@gmail.com>,
        "Shengjiu Wang" <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: imx8: build base support for scu clk
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023, at 20:56, Stephen Boyd wrote:
> Quoting Arnd Bergmann (2023-10-09 04:44:55)
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> There is now a dependency on a function from the clk.c file, so
>> this also needs to be built:
>> 
>> aarch64-linux-ld: Unexpected GOT/PLT entries detected!
>> aarch64-linux-ld: Unexpected run-time procedure linkages detected!
>> aarch64-linux-ld: drivers/clk/imx/clk-imx8-acm.o: in function `imx8_acm_clk_probe':
>> clk-imx8-acm.c:(.text+0xbf0): undefined reference to `imx_check_clk_hws'
>> 
>> Fixes: d3a0946d7ac9a ("clk: imx: imx8: add audio clock mux driver")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>
> Is this another 
> https://lore.kernel.org/r/20230921093647.3901752-1-abel.vesa@linaro.org

I think that's correct and my patch is not needed any more now.
It looks like it was already obsolete when I sent it, but I can't
find out why that is. I'll let you know if it comes back.

     Arnd

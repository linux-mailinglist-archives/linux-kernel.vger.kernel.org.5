Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4690075CCB4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjGUPyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjGUPx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:53:56 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA80269F;
        Fri, 21 Jul 2023 08:53:29 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 23F203200990;
        Fri, 21 Jul 2023 11:53:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 21 Jul 2023 11:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689954784; x=1690041184; bh=9h
        Pn0vqDK5F4Kupt89UUmDtLQIxvFCQKDf5jwCD/rVE=; b=YMTYZo67fySHWULO6E
        Ynw7vXR6QCHo3+LO1PXJmKQY3h3qEKR13mS1vI4jsW4yMLYZeLbQGOLXvavWpj/v
        BT44AHcfYxke0EeNWldO3HHGdVnU+FiBq6YnIpLKpr6B/IFxafXKtmX7mqKrnfy5
        bFa2jcPjAltL8ugcQlMCAf1XVcvKMDdQedMdgSlfG1uqwKMUmLt1UA0WSLTKGn/i
        nRji/7rpZ7SPplPbtPjPGP8tAmFVHRN2c3oFX/f1V8865xnXUa1sBzgBd8+7dlzU
        vlp29bqlKC5FVTUeowk3uR73JjVmMMXPnckfJCcTujtx2QXFJE07p+oPjFoah1lb
        86vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689954784; x=1690041184; bh=9hPn0vqDK5F4K
        upt89UUmDtLQIxvFCQKDf5jwCD/rVE=; b=oneOUSr63ErkU897PPGwDKKr7BkXX
        U02UoooSEW86a8ho9bKWMp8x6aej4JeA9IbiSCk6KdZgU+z8bsfyF83yONYxJOmQ
        LDb6nNOuP5COmmiXDi89AQgmBgq8WJqgWKslJmPyuZ9hgq3/IFnRoIuNbObRMrqK
        8/CFDzrO+OiiLbO3mYCzWIt7/ZeIWUck7Vc7ePH50vfPo4hkXqTiLQlLyJJXZXj4
        hFC09ws2BTQZGDSbIGjLfcD882P6wEQca1KeLh/+GDA8dOzIOt736oqPYoylu/tk
        e0FEQ1oS76OUIHYBg1FwZBBgCc5MYCEK2XsOi3EWX8W2srf+9JkcvFYgw==
X-ME-Sender: <xms:4Km6ZHXs-n0p5vtx3LYYV46v2wziywExcvKQMer1UX-4aJzrdVOm8w>
    <xme:4Km6ZPnnGc5OE6ifbURb-Qjgg1K2a6-lSE7_yqNDPe-MddenFJ5yQTTfKaj2_SI4E
    d0y_03nC4uVjGdWqEs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:4Km6ZDbTXcZcyk3HkWJ0bnGNfl3rLTPRyTxhQyjGi2XLg9YpODiRRA>
    <xmx:4Km6ZCXeYJDe8OiWHBPe6RLLtqBuMCUITy5DqjszswbzYqzAvEPF4Q>
    <xmx:4Km6ZBmYM51PEEVjm4ygjGiKxPyx41FAJCswgaGzmYINtCMyZmyH4w>
    <xmx:4Km6ZBFFQvac8VbqUFDUjWPGzGrvw84n-K5lEArQY0-7E8WV4eFKKg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 440A2B6008D; Fri, 21 Jul 2023 11:53:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <4f8ce95e-99ac-40e0-9827-292ef0f67906@app.fastmail.com>
In-Reply-To: <ZLqg5g5cmx8gX9E1@orome>
References: <20230714174438.4054854-1-robh@kernel.org>
 <ZLqg5g5cmx8gX9E1@orome>
Date:   Fri, 21 Jul 2023 17:52:44 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thierry Reding" <thierry.reding@gmail.com>,
        "Rob Herring" <robh@kernel.org>, "Olof Johansson" <olof@lixom.net>
Cc:     "Sudeep Holla" <sudeep.holla@arm.com>,
        "Cristian Marussi" <cristian.marussi@arm.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        "Florian Fainelli" <florian.fainelli@broadcom.com>,
        "Broadcom internal kernel review list" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Jon Hunter" <jonathanh@nvidia.com>,
        "Michal Simek" <michal.simek@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] firmware: Explicitly include correct DT includes
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023, at 17:14, Thierry Reding wrote:
> On Fri, Jul 14, 2023 at 11:44:37AM -0600, Rob Herring wrote:
>> The DT of_device.h and of_platform.h date back to the separate
>> of_platform_bus_type before it as merged into the regular platform bus.
>> As part of that merge prepping Arm DT support 13 years ago, they
>> "temporarily" include each other. They also include platform_device.h
>> and of.h. As a result, there's a pretty much random mix of those include
>> files used throughout the tree. In order to detangle these headers and
>> replace the implicit includes with struct declarations, users need to
>> explicitly include the correct includes.
>> 
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  drivers/firmware/arm_scmi/driver.c | 4 ++--
>>  drivers/firmware/imx/imx-dsp.c     | 1 -
>>  drivers/firmware/imx/imx-scu-irq.c | 1 +
>>  drivers/firmware/imx/imx-scu.c     | 1 +
>>  drivers/firmware/mtk-adsp-ipc.c    | 1 -
>>  drivers/firmware/raspberrypi.c     | 1 +
>>  drivers/firmware/scpi_pm_domain.c  | 3 ++-
>>  drivers/firmware/stratix10-rsu.c   | 1 -
>>  drivers/firmware/tegra/bpmp.c      | 3 +--
>>  drivers/firmware/xilinx/zynqmp.c   | 1 +
>>  10 files changed, 9 insertions(+), 8 deletions(-)
>
> Not sure about the other maintainers, but I usually pick up
> firmware/tegra patches up through the Tegra tree and then they
> ultimately go through ARM SoC.
>
> Arnd, Olof, does it make sense for you guys to pick this up directly?

Sure, I was going to suggest the same thing.

Rob, can you send the patch to soc@kernel.org assuming nobody
has objections? Feel free to send this together with the bits
for drivers/soc, drivers/bus, arch/arm/mach-*/ and anything else
that usually gets merged this way.

     Arnd

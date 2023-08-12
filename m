Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA15779E50
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 10:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbjHLIys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbjHLIy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:54:29 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B473C28;
        Sat, 12 Aug 2023 01:54:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 919A45C00E7;
        Sat, 12 Aug 2023 04:53:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 12 Aug 2023 04:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691830403; x=1691916803; bh=SE
        nGcpG27n6iOUXoo8tDjCIBUt8tik6949s/gqlsr/k=; b=MIlP4XVDM9/3JO0cQt
        dg/ZbcaHdggJQkgkz1ABOzarv7hrkCKg/be2DAHLGJOcOmt+OjrzwxOceJ3q8bOr
        XzsxuuZt3v2/hXBcl7B2XMDGivpey6VE+tuT0XaF4Mm6f0geKTOTHa8IuSFO/Rcz
        gfX8GSkhB7cpvR8j1bUggkcotBd2BaQE6MIHXZRZt9HaX3tU9KFcZO6MO1slnyBa
        kBe0JjBQrsEj29OKYA47ou7Zg6osC9F3GUKQbFzVJ7n3S3GF7rCmINd+k7Mp9tXo
        qW/JEJJz2BzJSOefepShcr33RBL40TWoUlpO5p1ZQAYmJeXRhuKyLIOZv2Hi/tsP
        Hr7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691830403; x=1691916803; bh=SEnGcpG27n6iO
        UXoo8tDjCIBUt8tik6949s/gqlsr/k=; b=hNtIKDtKAmLTqJ77bx0sDpwNyMzXU
        boOAJ3Wse9veYN3csGBKuHADwdEstAr/WfI918waLqjUCTs8yQaLkRsmSt3SGxET
        pcjWAgG54yTrbZf16l5yD72x4rUMN+ghgJTnx4Qpnu9YXIWx3x01A5XKdHRUAmx7
        OKGvuANK8mg1Onr5RylDTew4TL5Uqw98Ujs6G8AFcckrXMxFculCOoXJF3GOXNLt
        Ai3MLWVss16RUeQ9yhsDuw6Xvnbshvg2qLZbS9U0sRysgC09E0UcqUdZ5U4d6gXE
        ltWtxF/nQ0C7o5TRmcptBlKFcncZi/LRNYW5bIMlM/IRZcOAuGnJkwjXQ==
X-ME-Sender: <xms:gkjXZOmiIngsPSt-0vMoYgu7wGBsbAN6lnPBGlz9qmhvYaY0M56-ug>
    <xme:gkjXZF3P3snSTLsqzA43nGEPuFn32q3vp6JvjKrGGdT9Y_5SLoydhNyEmCLoIfclE
    utA0vpSQz2sQZhnzIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddttddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:gkjXZMowSOmH1SWl79ZGtVk8uOsfkymQWvwjAzXZm7nWjRnS0VtvVQ>
    <xmx:gkjXZCmurZrEm8XQCmNlLmjEUy-tF-TuSHiEXjLFCvDJbVYr4sd7sQ>
    <xmx:gkjXZM3Bez4zyiJxzxIfXG60hOAbKFLUF0-fDApVXSnvg4BhCdTNGA>
    <xmx:g0jXZBs-tcjWTblYrKGg85aG6isIL9ITSiIFU5pjBPTbiZRY2hlUSA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C157FB60089; Sat, 12 Aug 2023 04:53:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <43e42ee5-7a56-49ba-8e06-5046ef85c98f@app.fastmail.com>
In-Reply-To: <20230809011542.429945-1-ychuang570808@gmail.com>
References: <20230809011542.429945-1-ychuang570808@gmail.com>
Date:   Sat, 12 Aug 2023 10:53:02 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Conor Dooley" <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [RESEND PATCH v2 0/3] Add support for Nuvoton ma35d1 rtc controller
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023, at 03:15, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
>
> This patch series adds the rtc driver for the nuvoton ma35d1 ARMv8 SoC.
> It includes DT binding documentation, the ma35d1 rtc driver, and device
> tree updates.
>
> The ma35d1 rtc controller provides real-time and calendar messaging
> capabilities. It supports programmable time tick and alarm match
> interrupts. The time and calendar messages are expressed in BCD format.
>
> This rtc driver has been tested on the ma35d1 som board with Linux 6.5-rc2.

Hi Jacky,

I see you added soc@kernel.org to Cc for all three patches, which
has put them into the patchwork tracker.

Now that the platoform support is merged, I do not pick up patches
for other subsystems through the soc tree, so please drop the Cc
here.

You can post the the dts change along with the driver, but the
correct process is that the subsystem maintainer(s) pick up the
DT binding and the driver once the review is complete, and then
you send the dts changes to soc@kernel.org. Depending on the
platform, there may be a lot of conflicting dts changes, so this
way you can aggregate any patches for these files before sending
them to the soc tree for inclusion, while I then merge them
with all the dts changes for other platforms and any global
cleanup. 

    Arnd

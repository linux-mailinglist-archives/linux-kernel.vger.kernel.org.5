Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32DA7F2D36
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjKUMbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjKUMa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:30:59 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E492D4F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:30:53 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2958D580484;
        Tue, 21 Nov 2023 07:30:53 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 21 Nov 2023 07:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1700569853; x=1700577053; bh=NL
        L+hKNFgPDW5AXo1itsxcxk/DzrgJ58Sa40xHQxSqY=; b=ajWY7ywLPWx7YeP6i/
        lLG3CQ9ElJNW0OTxSGF5ImE97g+x+8H/3FIUJXDcrTgEsJlilWvIKsFDQdt3LAEH
        JjZxjvmRdtfVumf7cv1oKrdL7sYwru9IElgsX3B2SM2LB3YxHPz8OZescoPxB5++
        YaL/rOev3X5ReunyzrS5rdAcUGs6U+PjpHyoTXqmTNQLiZBWqnEPEUO1dUFZEZp5
        lae+MYGETIMQGj95113f+5U8P1et2IYvL3+cEgS8c2HH9MDxWoq6zGiSeIJdLEJz
        V8wuBmBxU9SQLMPwkT5kX21zl+2XWXFwN+k+z5FrA9UoJXn08HOzeDmQEpq9rmHh
        IYhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700569853; x=1700577053; bh=NLL+hKNFgPDW5
        AXo1itsxcxk/DzrgJ58Sa40xHQxSqY=; b=NFXqJjPqlNtof5wYOYUOlzxlnJFSQ
        lx2hgvZ/hgifFx6FV3xOQpmlGmhJak5OiwpEbaGCIlI2AHzh3x6PmDPbrxiRQ2Cr
        NjwybXcQzFCjaWWrpA89F+uG+AG9eHgZXVltUATIoBp8ING2Gtm1ipQO/TeLjHmx
        c7xmtGBuebvott2khXXsO2NFcVHuIAOVG89VWygdt0v6/5uFGMU0hhwCvsPdRJ3z
        q47X3gCBQHVcJKu4gxa4IJlzg7r/ki0AuWJWMe1IdJrR5oL1CBWCquW0fg9zD9RH
        IDRwKV4Oie0c1XYZwEbm6KhnBRpxuHd+Q1wnowtwMdCCxzHBAfebQMKKQ==
X-ME-Sender: <xms:_KJcZd4WymcEIZZ5FQihVK1mNHh52yMj3d7NrB3hQ6IV9d5_sgmLtw>
    <xme:_KJcZa5MNaLHr_7aNtp7nOx9kRxeH5w9LvvajukDN8mHVYiurr4n-4fc9HeEGRLz7
    k1oAgguMa34oa7D3Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:_KJcZUdSXn_tS279wV_LRzAawG0zqzAA83eQW22Bpg5s-avusA5j6A>
    <xmx:_KJcZWI-bKlEd86e2IVt8q60vOlrr1esYSVcI3w3G4Tx60_sIj5Ciw>
    <xmx:_KJcZRJgvh2TxUPbNaE6W70Xu4x2HicMMtyP5GFmXA4EzpI83k-x5A>
    <xmx:_aJcZbCAi_duVzlD87oEqGfZumbpB_fjVqIWnUPNUdwAOuAG5pb8XQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2300EB60089; Tue, 21 Nov 2023 07:30:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <35f4c415-1d26-447f-91bd-eb192201c998@app.fastmail.com>
In-Reply-To: <20231121112056.1762641-3-ronak.jain@amd.com>
References: <20231121112056.1762641-1-ronak.jain@amd.com>
 <20231121112056.1762641-3-ronak.jain@amd.com>
Date:   Tue, 21 Nov 2023 13:30:30 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Ronak Jain" <ronak.jain@amd.com>,
        "Michal Simek" <michal.simek@amd.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        sai.krishna.potthuri@amd.com, "Tanmay Shah" <tanmay.shah@amd.com>,
        "Ben Levinsky" <ben.levinsky@amd.com>, nava.kishore.manne@amd.com,
        "Rob Herring" <robh@kernel.org>, dhaval.r.shah@amd.com,
        "Marek Vasut" <marex@denx.de>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        shubhrajyoti.datta@amd.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] xilinx: firmware: Add sysfs to get last reset reason
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023, at 12:20, Ronak Jain wrote:
> Add sysfs interface to get the last reset reason of the system from
> a user space.
>
> When the system reset happens whether intentionally or due to some
> errors, the firmware used to store the last reset reason and the same
> be queried by using the IOCTL API or the sysfs entry to know the
> reason behind the system reset and accordingly, the error can be
> diagnostic.
>
> Signed-off-by: Ronak Jain <ronak.jain@amd.com>

I'm fairly sure we already have other interfaces to access
the reset reason, please see if you can either reuse one
of the existing ones, or come up with a generic one that
can be used by others as well.

      Arnd

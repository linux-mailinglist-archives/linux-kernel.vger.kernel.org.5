Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C697BE21E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376929AbjJIOJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376431AbjJIOJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:09:27 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E719C99;
        Mon,  9 Oct 2023 07:09:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1E69232009CC;
        Mon,  9 Oct 2023 10:09:22 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Mon, 09 Oct 2023 10:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696860561; x=1696946961; bh=f4
        6k7jCKAySj37IySZF/TE6Spebue7lQjPpeIOI8W7c=; b=WjCI0tN5l+Dt2B7duw
        45qSABlcGtXaHOUkkYJHoFAocFesKxup835qIQa+XPhr4kpCTq7qXR9lsscllJs7
        Vl6dQfd3Bxx6vUKW+2Oxpbk6MYEozs4yZt/FX0Pcpo+4sPKPBElswm8SC07m3SWW
        6CvUSEjKNSpiDlErrk3/1rnBImhAHURT5ORA6uJXAvD/yHcDZ5EKUlwCfqry+EYq
        LCyQvshQGjjdZ5m4kNWOmf/nW0rF45EBsAXNckydP0Xly1MzCTkLowKP8wkB+Wjg
        YYJ/ypqmRKdim5fX9TvEtNvKbnw68PyS2OaS7PYPnup94/jXkTdPXJ51WvMxQocY
        xJdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696860561; x=1696946961; bh=f46k7jCKAySj3
        7IySZF/TE6Spebue7lQjPpeIOI8W7c=; b=FFzR38AdgLcnOHWixJhHcQvGKw2YT
        2yLlslO+s3FdtflecRzshxRL99w8db42qjpOUnIbUC6vIn9+W0+qFV7UpU+S8aGn
        Q2ulfMPTsJsOY2Zeed8VtK70RhC2JHJ6BoZeF1xHnjkSQMh+s+JFhXPEKdeMUiSQ
        7Zjjcn7gCrXH6H8qcQtFybyAbHNSeTv1KJE5pgykLhu+7SUKXEm0rUD9Ca59mxMV
        wHPpsILlDatZrKOhldQ7Cd3BjBQCCmehmwx+GRPzzjUzyV924hH4KZlHu3jpZJKR
        NSzuHlqSqnKYdhBdtkp9RzeLA2EB8NeDTpdWg/H2Wkbv5LOKLWytguVPw==
X-ME-Sender: <xms:kQkkZWhNIJxCw3ZixMT3myHuv3rxpGlsALGcN2Q8J8hoW38UTWX11w>
    <xme:kQkkZXCBIlPPdVG5nx-t1WFKkmmDSt5SvtxGUvHVs7So5sinlacpQAhVzNlEPDdjE
    stKu83XZjPC8Vi9HZ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kQkkZeEUnNBBXmp_vAfQD_ReaPeFLZGBRC67TdlnZ0nZj2WGC9RWNQ>
    <xmx:kQkkZfR1hq_okhrOdBTHDxOE3I9FNXOd0xL1UxGxMfJuJEaG2Gj76A>
    <xmx:kQkkZTw1bRufWChj0FgnsIsZ9UmCMTyIMahKajGqHvYpucBkuQfE0Q>
    <xmx:kQkkZaxH7_kusC6d9wM5-sA01BxXUv5mvRL4hlaSPzJJbl0gr0r2HA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 03ADB1700090; Mon,  9 Oct 2023 10:09:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <cace6f63-42a2-4848-9880-c48fb2b31fdf@app.fastmail.com>
In-Reply-To: <20231004115220.5c3776eb@kernel.org>
References: <20230927090029.44704-2-gregkh@linuxfoundation.org>
 <20231004115220.5c3776eb@kernel.org>
Date:   Mon, 09 Oct 2023 16:08:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jakub Kicinski" <kuba@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org, "Prarit Bhargava" <prarit@redhat.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>, jschlst@samba.org,
        "Doug Brown" <doug@schmorgal.com>
Subject: Re: [PATCH] net: appletalk: remove cops support
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023, at 20:52, Jakub Kicinski wrote:
> On Wed, 27 Sep 2023 11:00:30 +0200 Greg Kroah-Hartman wrote:
>> The COPS Appletalk support is very old, never said to actually work
>> properly, and the firmware code for the devices are under a very suspect
>> license.  Remove it all to clear up the license issue, if it is still
>> needed and actually used by anyone, we can add it back later once the
>> license is cleared up.
>
> Nice, Doug and Arnd also mentioned this in the past so let me add
> them to the CC as I apply this...

Yes, definitely, thanks Greg for getting this done. I think every
time this came up we concluded that it can be removed, we just never
finished the job.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/netdev/e490dd0c-a65d-4acf-89c6-c06cb48ec880@app.fastmail.com/
Link: https://lore.kernel.org/netdev/9cac4fbd-9557-b0b8-54fa-93f0290a6fb8@schmorgal.com/

Semi-related:

Since this removes one of the two callers of the .ndo_do_ioctl()
callback, I've had a new look at that bit as well and ended up
with a refresh of the missing bits of [1], which I'll submit next.

     Arnd

[1] https://lore.kernel.org/lkml/20201106221743.3271965-1-arnd@kernel.org/

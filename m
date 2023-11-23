Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7077F582C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344772AbjKWGZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjKWGZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:25:35 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15E619E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:25:41 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id ED13A5C0162;
        Thu, 23 Nov 2023 01:25:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 23 Nov 2023 01:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1700720740; x=1700807140; bh=/6
        WiKh+BjmdjXgEeTZ2JO9etMpJThQQYsX1jFQdOsOo=; b=4hrkdbgSg3UCa9qwM3
        q/pxx10fKttOlC11umZccw6vL+w7As257e9kAF9zbTxjSl+TsUFK881HwT91dt+K
        Ferxb4dxDOQrhJyH6yesSDN69VLZWO+grxZhfbXO39sIQrHh3iKcLtnSEuFlNqqG
        tEB5q06UxsU+z/+doVhO79DiRFHWe41BbPtgH6Tj/dclh5d2cSllQ4K3Q/L7J4Yj
        D4lgjHEfgS8qFCL/g+JwRYyz+uUswcay5DPrPcTdfA2t2+aXCpg0TFV82H/6Gi1R
        3ZOAtH9mZDzsMJkC83E44ZVBlYloqZ7jUpJFo/BzsR5jV/95lzUjfEh9sgPQsY4Y
        9I2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700720740; x=1700807140; bh=/6WiKh+BjmdjX
        gEeTZ2JO9etMpJThQQYsX1jFQdOsOo=; b=fjWeuEwEa+pCOU5mE/9NDjRE2Da/e
        J5Rn+G5bg+QmDQoab3/1IZtKa9R+c3d5PT6vUF6WXAIYwUP0FV9GcmoyE4HYtzgM
        M4muRjbNnQB/8obisWZO8Rfp+ACAsQqeWInPCZ+Zq3oa1IU9rFLR0uhhTLKyGx4E
        Wf56VsNBXeL4xYM/bQy4L2qRGOxMqfKiZUIddMtWwuiaNSnL3ENzH5lVb2R9EhHW
        S0g3WtfTD1MI3J4YMFHoVL2esNslDDodwYAvDn5e/Iyg5WjXbvYX8LmZpFkhQez0
        nZMB7lJ/9Mt+jlfkAoRnD0kNuSFap3+PMe8yZUzDzwtwnwjXfYrxpuUSQ==
X-ME-Sender: <xms:ZPBeZffSV2Tsn9FnExJq4DEqDLZuSexON6Bu7CfX_33uQC8N7Oh-UQ>
    <xme:ZPBeZVPZmJbMIY5ThGYVdUU2PvXjhZQSt-Nuq1Zg-kRKqvgfYbcNA4mI5XmD31Q1w
    gCjqWLbK5-XMdT7VmE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehvddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ZPBeZYhyObxWcSetOpSyArW4zgov8PrcQ4q7v66qrREMPT1OHaSxqw>
    <xmx:ZPBeZQ9gn4tRp0Ce7IHahAHWDbKL7mJfpHvjOIaycYlpAK3H36jD2w>
    <xmx:ZPBeZbskQW8-rR8bnl-wR-LdwGLAgThSyWZQp1OZxUnIcpmg07CGXA>
    <xmx:ZPBeZRUEbXz7S3I0scUZzeHzmkSu1BDpTcVOdo2lLoK2ujW2tQ5axA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 66535B60089; Thu, 23 Nov 2023 01:25:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <a9ef56fa-725f-4d18-b408-ce0ba13c2d6e@app.fastmail.com>
In-Reply-To: <ca200ed6-a70e-401e-b862-f690368e0266@kernel.dk>
References: <20231122224719.4042108-1-arnd@kernel.org>
 <ca200ed6-a70e-401e-b862-f690368e0266@kernel.dk>
Date:   Thu, 23 Nov 2023 07:25:13 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jens Axboe" <axboe@kernel.dk>, "Arnd Bergmann" <arnd@kernel.org>,
        linux-nvme@lists.infradead.org
Cc:     "Keith Busch" <kbusch@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>,
        "Sagi Grimberg" <sagi@grimberg.me>,
        "Chaitanya Kulkarni" <kch@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] nvme link failure fixes
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023, at 02:42, Jens Axboe wrote:
> On 11/22/23 3:47 PM, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> There are still a couple of link failures that I tried to address
>> with a previous patch. I've split up the missing bits into smaller
>> patches and tried to explain the bugs in more detail.
>> 
>> With these applied, randconfig builds work again. Please either
>> merge them or treat them as bug reports and find a different fix,
>> I won't do another version.
>
> Applied, but had to hand-apply hunk 9 of patch 3 due to a previous
> attempt at this:
>
> commit 23441536b63677cb2ed9b1637d8ca70315e44bd0
> Author: Hannes Reinecke <hare@suse.de>
> Date:   Tue Nov 14 14:18:21 2023 +0100
>
>     nvme-tcp: only evaluate 'tls' option if TLS is selected

Ok, thanks for merging my changes! The commit from Hannes
is what I had in my v1 for this, and it was a correct fix
as well, my patch 3/3 was just a more elaborate way to do
the same thing that I did since Hannes did not like my
version at first.

The 23441536b6 commit was not in linux-next yesterday, so
it looks like our patches crossed paths on the same day.

     Arnd

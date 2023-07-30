Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEAD768424
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 09:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjG3HU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 03:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjG3HU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 03:20:56 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7A419B7;
        Sun, 30 Jul 2023 00:20:55 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 03F845C006E;
        Sun, 30 Jul 2023 03:20:52 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute2.internal (MEProxy); Sun, 30 Jul 2023 03:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690701651; x=1690788051; bh=L5
        yMUbQktbxKTCHMBew6jTG9neKt+p6qnBeFuafRANc=; b=QTUiE8rG2v3rmJI5GY
        VFHa7XwwgyhRBqZzwjYSYA9wl5N873SBRXZx5z8vtL8h1VUlbSLQTuZLz9d8cMWm
        dEa40v8ljTGwHlJ2lk6QA7ZlvV8QVZhyOG3Z2psbw9xd1UElqoXgXILhrWWEy6PW
        VKHgpKOUY9kRk9DTL8XV/TErPhZ//81K1zfsvi76Cst/4C4pwC5ScsNmfNaIlxJa
        +jSs1ZUkQ70XV1oB4dxzjzWEgXgc8BahtYZ3dXaleJCJic3nGbTHi3cTtE6ap6Sh
        mFaqGSobQBESE+XrWW5YJaP1L5FfocC/r/OSJBKivJ/JjHW5+oDLcGOXe6n2PuRN
        0V+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690701651; x=1690788051; bh=L5yMUbQktbxKT
        CHMBew6jTG9neKt+p6qnBeFuafRANc=; b=HsujcvwzVTo2IvA/HSoWUHMGLzW7D
        K2/s+tvdCw9uziMXCb0ehV6gIfF8rcRBs2/OxZPyXmqh86q9xhc5EoG9ggJvYUJT
        v5jfvMnoBrBotE6Rj0nsMlDMrQ/mpZ/vbAPGOj2PwBeHY92F31pIX//LH6ynSkP/
        dws8mj3FyXgus03t/0LbKtccKMD8Qd2ip9gjVx4yMEqzLpwZtRdH5CIMU5hD/TW+
        U0HR7aqCeIWJ4Lu1pTPspRmzz8SlzIu+XnNp5ZP6f/t59tVPJsSZCKNlKh5s7YJ6
        CG/+iRcBZaRx2JEUwCCkp6CnSq9YXV1OaFB2Zyr2sFJojcNlQrN2T15ZA==
X-ME-Sender: <xms:Uw_GZDskHgBUQGOaUJtVwIjNKLQ8w8LPv2O74R-aW7Z6xDr7HtiUoA>
    <xme:Uw_GZEeLvPldRrWE_PUbRJKoISCpe98fNrbpxwE0XpuAouIrTUBp7bdqSI4oOskVC
    sbs-aYdxb4l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjedtgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfkrghn
    ucfmvghnthdfuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrh
    hnpeejleeigeehveeiffevheeigefgvdeuuedvfeeiteefgeelleegjeffudevfffffeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvg
    hnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:Uw_GZGxvPakyNGXYys8t-uRGDMobAcE5cy7WYUDK8wdt2SLjyoDx1w>
    <xmx:Uw_GZCPltuVLoCfbd1lXJ60ap1E3TQkpuoMIeoMrhMu-dkN3J-m3kA>
    <xmx:Uw_GZD_GRPNE01E80i9DLr73siN8THGlnIBcEdqwJGZwJXmAF_NFMg>
    <xmx:Uw_GZAGOCFCr_YWgLnS4z-UdgHSEr68Cp-qT-s7kX2Jx9cmY4F2MfA>
Feedback-ID: i31e841b0:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 84EB52A20085; Sun, 30 Jul 2023 03:20:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <016f771c-cfa7-4795-a0a4-9f486a5b5b0e@app.fastmail.com>
In-Reply-To: <87sf96kk6f.fsf@turtle.gmx.de>
References: <20230727200041.21404-1-svenjoac@gmx.de>
 <CAHk-=wgK9-Tx4BxYMrc0pg==mcaz3cjWF6-CBwVpM_BZAmf4JQ@mail.gmail.com>
 <87sf96kk6f.fsf@turtle.gmx.de>
Date:   Sun, 30 Jul 2023 15:20:31 +0800
From:   "Ian Kent" <raven@themaw.net>
To:     "Sven Joachim" <svenjoac@gmx.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     autofs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/*/configs/*defconfig: Replace AUTOFS4_FS by AUTOFS_FS
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Jul 30, 2023, at 2:06 PM, Sven Joachim wrote:
> On 2023-07-29 14:07 -0700, Linus Torvalds wrote:
>
>> On Thu, 27 Jul 2023 at 13:01, Sven Joachim <svenjoac@gmx.de> wrote:
>>>
>>> Commit a2225d931f75 ("autofs: remove left-over autofs4 stubs")
>>> promised the removal of the fs/autofs/Kconfig fragment for AUTOFS4_FS
>>> within a couple of releases, but five years later this still has not
>>> happened yet, and AUTOFS4_FS is still enabled in 63 defconfigs.
>>
>> Ok, I ran the script, and also decided that we might as well remove
>> the AUTOFS4 legacy naming stub entry by now.
>>
>> It has been five years, and people will have either picked up the new
>> name with 'make oldconfig', or they just don't use 'make oldconfig' at
>> all.
>
> I had not added the suggested the removal of AUTOFS4_FS from the Kconfig
> in my patch, because some projects seem to have have copy-pasted from
> the kernel's defconfig files, e.g. systemd[1].  Hopefully not a big deal
> for actual users, but worth mentioning.

Right, it's time to do this though.
Hopefully the systemd maintainers will post to the autofs mailing list for advice.

Ian

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CF57C95FA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 20:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjJNS7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 14:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjJNS7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 14:59:19 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4C0DA
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 11:59:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 08ACF5C0226;
        Sat, 14 Oct 2023 14:59:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 14 Oct 2023 14:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697309954; x=1697396354; bh=7l
        UanCG2PYVTMybzolsdF41bCQYpQ+LnkECeghf21F8=; b=abeD/3zkHKd9D06Tdf
        0kFJYkBYMSf8fLeO2A+Ncc49VYnIjYfhURlPCDfIRO1Yg2r9BzWjb+fSEzMoQrt5
        07phx4wo8ituPc/vtv10p9VwB7+XLq+PY4Ugtt0DE0icSX0l6L1K7Ch2X/fV3BVi
        yunw9rcc9q2+hTSACWNzTt8vU4VkuJuCsYESG86Pj1j/O1z0FfzGXgLLXuPTTufN
        izl/2rUGFL2ZPLqxLQezGvA2kMxC+z4rvIe+39nRMIWFSId5/YXsXafLj+D3InV+
        jb8WuVsz+0xvyFEOLa9nrixPGAe8G5VpvAtKM1adY6iXbxRRFlmlLRcm5LAUsspu
        6TJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697309954; x=1697396354; bh=7lUanCG2PYVTM
        ybzolsdF41bCQYpQ+LnkECeghf21F8=; b=EjzP9+QY3l9wtwaNQmBAUMdM+ST67
        4BNDWpN1+JQmb7fLBG8gqvh7UQienQ4ASpLhSwIKyyLDqG2jZTOz43RZvJ/rsj6Y
        hOg5yGszFoJvV/Z1fCXLSGfqj60CZIZaga1AAryGN9y5RxQlifzufWXDFTnECyuG
        2QwFzIT/6rJr6VXh0v4ix8s3id/U90+oKNrnBz9N7euAskw7eEN6j4+5EC5jeirA
        Fyh03rQUWN9OoS95YHlBYymRZ2nQCuB2EjjbMYwMTSm7SB7hctkR8TmrS5ZV6pp+
        IEfnhRWrsfQ0fIa1wRPoF6hUUwzVcAwSCrmCjOWrcspqekHq4kw6h/XwQ==
X-ME-Sender: <xms:AeUqZfPJCYnGrSfmPJlvqh_g8KevBicAe5A3ozO8SkIlAKar7OsW9g>
    <xme:AeUqZZ9qlVIcatTrbdsSVS3qaWrX1A67ohJ1ppenR4Fa3I9SN7WTuv_YsEz33GzyM
    4fBps645Pom_aSniDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieehgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:AeUqZeSXXYuegofgNDMTwjaIaUvuVzlp4kiGGfOCwqhvxCOkfgdExA>
    <xmx:AeUqZTvwY3Dec1531Jn1_mDgmzLfn1IHw61o2GYOsEpyUERnXGi2-A>
    <xmx:AeUqZXcPCoFcPkFvCt1d7NlEvxTckWc3WPRn90s4B20peFGf6kRkgA>
    <xmx:AuUqZT4kZ0a5AceW92svpa64lpLO0BC2hT0k03g3McJoL7STEw82sA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A0224B60089; Sat, 14 Oct 2023 14:59:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <6e7a13f0-e98a-474a-b6ac-6e107788c74f@app.fastmail.com>
In-Reply-To: <20231014164934.GA12750@matrix-ESPRIMO-P710>
References: <20231014164934.GA12750@matrix-ESPRIMO-P710>
Date:   Sat, 14 Oct 2023 20:58:52 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Philipp Hortmann" <philipp.g.hortmann@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Kalle Valo" <kvalo@kernel.org>,
        "Larry Finger" <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] staging: rtl8192u: Remove broken driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023, at 18:49, Philipp Hortmann wrote:
> Tests on rtl8192u hardware have shown that this driver is broken since
> 2016. Remove broken driver. Find fix for two of the bugs in mailing list:
> ("[RFC PATCH 0/2] staging: rtl8192u: Fix two crashing bugs")
>
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

Looks good to me, but I'd suggest adding the links to the patch you
mention and the discussion:

Link: https://lore.kernel.org/lkml/db98d9ac-7650-4a72-8eb9-4def1f17ea0d@app.fastmail.com/
Link: https://lore.kernel.org/lkml/cover.1697089416.git.philipp.g.hortmann@gmail.com/
Acked-by: Arnd Bergmann <arnd@arndb.de>

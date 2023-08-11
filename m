Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF231779964
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjHKV1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjHKV1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:27:17 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEA1212B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:27:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F28575C00B7;
        Fri, 11 Aug 2023 17:27:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 11 Aug 2023 17:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691789234; x=1691875634; bh=4V
        NI7jS/8qVbjFTBRtqsnBUfSpb9eImvRnT47kuj8XY=; b=bk8JtnrMXi5l+pPL/W
        a1R0q2mHUG0nMd6DTwTeAoE43YrMJmryF8JVjG9srBIr6Bnz1fAi/UZSII8FLZF6
        JX5CrCf5ZUK/y+wL0e6ZW35h2Vmx+W5hIRSGRkUGDS9jMIa0JBDjGMzMhOZd37OK
        bL2qCS50IyBThyYQoVx6oVsIUM7e4oLtTDBg9PRxkBtWFEao6KAfGY59D5QzICZR
        3ePYXsaIGXGtduHyFVZunrDBTD3jCVcuqkdrBqtHk37bPlj85G7Rzw+d3w433zVN
        Xjdm/HPkPRHm7DDeJOa4lIoaSHNb7YSg9TeA2RRZyD1dNHId1BNJfYQxevbeWm1V
        dvmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691789234; x=1691875634; bh=4VNI7jS/8qVbj
        FTBRtqsnBUfSpb9eImvRnT47kuj8XY=; b=3g5jyKj6jtmQc6Ft2o+QmxGX289lz
        gYbHhFWlrTky3jmpeciOatqW6dvgPC5IGERyv6AJnuQXUGShsOAs/8d9oknN0VYa
        zuMqhSa3aSrNZGi6JD8pXoozIwAPK96S2wHPfntoIP/IJaerwVXfGFt0wJKBzoFL
        NnbD2bYvABKXiZqfx8xOozjSctBnvBMJ8UXzM0Ey6OWD38GwMqOKnBmm6XdulLAH
        kFYN2r5Tq2tNCGwZBSo1LhQpY09dg+kIcPt89KVMOy0a2wFMZDe95HMG0t4h91Xu
        6QlFO3LxpBnTocHEDAupQuquYvoLnGAJaoiWePjjoT/jL2RDDo8qbeaPg==
X-ME-Sender: <xms:sqfWZPz0HAaXQ40PCIetscvZQODetI5oHf6wKS-8XxzhQdG0uhp9WA>
    <xme:sqfWZHTTtEZiUd46RTuAmyFyf1qLJxC6oXtLSgcxGvjbYQJUBog9yrRxLZ6AZCvv-
    QUxY-Vjug1dKw>
X-ME-Received: <xmr:sqfWZJWYSA8S4WrYuCZe0x2CSX9tZvZ9chd6wXncN7LjfekvbZYigJU9oC5352wYIbjIUFv3UT_QjnzpoxdBOXgOuxiAoToWNxktXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleekgdduheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:sqfWZJhBPt-5ALO6FeyWycEccacHsiUpxeiIsgphLWfwyJsbwf4wrg>
    <xmx:sqfWZBBC1IA1AJXTBTq0np5K-bIDsION0oYGQ2TaJ16GBfdL4BlEEg>
    <xmx:sqfWZCIdYdVR4r4GDGHFbvGqPtV_VrNe7zurQzieM9GhOyXMSB1wpw>
    <xmx:sqfWZF7FEuWwFRetKshEvumw2OjzYxyJzRydAVj1N9tD8-FR1hPdYg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Aug 2023 17:27:14 -0400 (EDT)
Date:   Fri, 11 Aug 2023 23:27:10 +0200
From:   Greg KH <greg@kroah.com>
To:     Pavan Bobba <opensource206@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: replace camel case by snake case
Message-ID: <2023081150-hamster-sulfide-4231@gregkh>
References: <ZNOK2u1sJoRAxhIC@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNOK2u1sJoRAxhIC@ubuntu.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 06:17:22PM +0530, Pavan Bobba wrote:
> Replace array name of camel case by snake case. Issue found
> by checkpatch
> 
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
>  v1 -> v2: 1. array name renamed from byVT3253B0_RFMD to by_vt3253b0_rfmd
>            2. typo in the subject line "small case" corrected with the
>               proper word "snake case"
> 
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
>  drivers/staging/vt6655/baseband.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
> index 0e135af8316b..cc8793256661 100644
> --- a/drivers/staging/vt6655/baseband.c
> +++ b/drivers/staging/vt6655/baseband.c
> @@ -499,7 +499,7 @@ static const unsigned char by_vt3253_init_tab_rfmd[CB_VT3253_INIT_FOR_RFMD][2] =
>  };
>  
>  #define CB_VT3253B0_INIT_FOR_RFMD 256
> -static const unsigned char byVT3253B0_RFMD[CB_VT3253B0_INIT_FOR_RFMD][2] = {
> +static const unsigned char by_vt3253b0_rfmd[CB_VT3253B0_INIT_FOR_RFMD][2] = {

Again, the "by" needs to just be dropped.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DD8798E5D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbjIHSmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjIHSmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:42:44 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2971F1BFF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 11:42:07 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 12EBF5C021C;
        Fri,  8 Sep 2023 14:18:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 08 Sep 2023 14:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1694197117; x=1694283517; bh=QX
        og+Yq/iwZf5L6bzGAt1Be4qBFAemehgXvmFDhUxgM=; b=a0h2EiCHGDHM8LPSDz
        H42px2kbvAbE8bo7VWXCYIFfmRLjPxDgjEWj9ghWa6SIPJ/5FhuzSsyo2lON/2hL
        He9mStIQEkDdGT6jFW/E4jTYZAjjyiqyviGd72R/VTOyr1qIZnjshyZWINiQYLeD
        fZcjce0HMN47m1qYQMnLXA7VhMuvPQuiOY31m7+a6IVA6E15BCAGalmjmDaIu9xf
        5D7qRRNgTCfKJZ4G1Dv62C4gwuBCAaQHM7TaDVZV7+KGR9Y3jfz34lKNYK5ka/bZ
        Jkal15Udf6lw7i4Taco37auNAkAG1XB0jj+gK0QjNv25o1hr+VvC/ydnI2zBSd3T
        gxdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694197117; x=1694283517; bh=QXog+Yq/iwZf5
        L6bzGAt1Be4qBFAemehgXvmFDhUxgM=; b=KSNOM2eZIq7Y5Km1CPztOXizMTWzq
        LRiaYMKcwZoweD/YaOloxgqTnhZsrtPfHc1nMY8iytj1mZZRcMbH9wkrZvUHnMOT
        Kmq5TH5+aPb95VOg+uVtbR7Pbnj41Wx3GXpfja7i/Urffod9+kGEZzarAbTmWVwk
        +TgVGdFiWYNWgGKrHrvc35yEEF6R6zFYc+ryyyrVsFJef7W99JV9THImHbGrl+9c
        R90LfNrBqCu2UueQGPv9781ieoQP1CidcF3iFi24F6KSQG6TkCJypLlEOfAXin7t
        N5NFmED6C1xiaNEs1l2n6OawI5VhyzVFN3p+x4x0Lxdddpr1qYE1R0mEg==
X-ME-Sender: <xms:fGX7ZLgAV5Ir8O4RatJHhC8mBNp5mIlxOwViK3cMbOZ6mA7duTckvg>
    <xme:fGX7ZIC6RvsUMyNT_V_-TcX27fkI0GUzn8CAIl3_4WkzhtFZ9HX2pwj9Hne8XQ2iL
    sedu92HPDwy_Y7Wlzc>
X-ME-Received: <xmr:fGX7ZLHADG5r96dOivJSgZx4YgLmVTVGpdqFt-ctYSq4qEfxj8u5DbglhR8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteek
    lefhleelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:fGX7ZIR9nLbjXxtyAMNpiFW_YwiHB6S2yM74Pa4x8OrF0IdSLKrncw>
    <xmx:fGX7ZIzNWcMG1Mq-mxfPf7BT9VA5JoO3mdpWM--3aoaOjV1NA9AO4g>
    <xmx:fGX7ZO7o3kGEqbm01F-T0QRNkzq5Hiu7blRA-ChQeKIrWr2C-i42AA>
    <xmx:fWX7ZEiKGVT-c1vDVIlppVPpjQLV3awzV2eyHxZ2TPgQEiHj2zlY3A>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Sep 2023 14:18:34 -0400 (EDT)
Date:   Fri, 8 Sep 2023 12:18:32 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Vijayendra Suman <vijayendra.suman@oracle.com>
Cc:     avagin@google.com, avagin@gmail.com, brauner@kernel.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, mingo@redhat.com, peterz@infradead.org,
        posk@google.com, vincent.guittot@linaro.org, wad@chromium.org,
        yu.c.chen@intel.com
Subject: Re: [PATCH] perf/benchmark: Fix ifdef in header file
 uapi/asm/unistd_32.h
Message-ID: <ZPtleIeOn/A6pIDC@tycho.pizza>
References: <20230308073201.3102738-7-avagin@google.com>
 <20230908173532.1055882-1-vijayendra.suman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908173532.1055882-1-vijayendra.suman@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:35:32AM -0700, Vijayendra Suman wrote:
> Typo error for __NR_seccomp
> 
> ifdef -> ifndef
> 
> Signed-off-by: Vijayendra Suman <vijayendra.suman@oracle.com>

Acked-by: Tycho Andersen <tycho@tycho.pizza>

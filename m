Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C3777AADA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 21:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjHMTS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 15:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjHMTS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 15:18:56 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8140518E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 12:18:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E55D13200368;
        Sun, 13 Aug 2023 15:18:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 13 Aug 2023 15:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691954335; x=1692040735; bh=lG
        5E+ZSscgZWtlQTdln7AyBIj97F64+JM6wMMoPAZtM=; b=bPQFjm/HdDocr9MCPV
        rBg3XNDI2BtEruxH8eJnD6lUECoVSfsP0O56QHNIxYTBH08xDHrzn+A/5aJw+s9W
        YwOavd1Sc0M+fazSWCjQFs1qkkz/PwsdCZ9KPJtZQKX+/nWh98X0W8hXL/PeZB2K
        5FKgt9aZDqNfvFVvrgkZMEWLdM1AmD6FqeWo1xRq+SBIEIJKNp7gpoY+aksXElue
        bJrhGvUVsHo0jZ1rQbCLo33oJhUwGhrjShRan/NE/iXyw1UxaAKecaYVbLuDAZyD
        vE52JMCpHL+JaghADbhSBXhNmMRxJNJPXUPdLQmPXcF76PSaEY3Emc20EocICWnd
        TZGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1691954335; x=1692040735; bh=lG5E+ZSscgZWt
        lQTdln7AyBIj97F64+JM6wMMoPAZtM=; b=bomY0eAyuUdg6Ze4IqN3rgMPyh5Vy
        4POGWzA9yLq3XFNuf9byTBFuCbgnv+NqTVTxBFDH/n5a8r9nMkr2x9jC5USfO3fB
        xHFt7zbacurwjwc1JaJ77ABmKvwLUpiRY0QcsFeUxy7bReXh8dw+vyJSQ73f+O+x
        /pWF0pmRt43X/fYl3vZS8oXyQpKYDPJyKZzlQKPEb+p/xwOAQ7RP6wlWkeCskxhk
        CqW0uoKsXuhfLlbRxoMJZibfXvKCaKIFA623sXNC9blXDG0Ak299pEEQuf0W8BSn
        QLnz1RBC5uU006GUvRFEgFmU1r1CS+fymz2Eo5ewMiIlveXNGzoLANpTQ==
X-ME-Sender: <xms:nyzZZJDrdoD0uQ_CqMnDoX35CyrBTWRw7OvVpcyjO50zgzADwDtAGA>
    <xme:nyzZZHjI-9reaQ0XP8vsPVlSuMMo3SiA-9DcrAWQjh_u8trBTxsCQI7x_8dNCAhPv
    w10aSR5VhSEG2LzAH8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtvddgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:nyzZZEmDUEm4nWpSz719oT2W9llYdVQ7eTZiNg1OPX1q9wSLxmPLFw>
    <xmx:nyzZZDzoaieaVPaxEeIkcdAwLJRWkTb8C37oyA8NJAofklzlBIInsw>
    <xmx:nyzZZOSNvjBzlfLib2AMHUaYuKfP95F7T-lD068OY2rEm0UP7qIyQQ>
    <xmx:nyzZZH5gxe2si0trLzMdq_z6mtHscN8dGnCEo0mdOV_KoEoTygI4uw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 16AECB60089; Sun, 13 Aug 2023 15:18:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <961b0945-f783-4a0e-a108-4549ec702d22@app.fastmail.com>
In-Reply-To: <20230813191655.474577-1-vgupta@kernel.org>
References: <20230813191655.474577-1-vgupta@kernel.org>
Date:   Sun, 13 Aug 2023 21:18:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Vineet Gupta" <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARC: -Wmissing-prototype warning fixes
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023, at 21:16, Vineet Gupta wrote:
> Anrd reported [1] new compiler warnings due to -Wmissing-protype.
> These are for non static functions mostly used in asm code hence not
> exported already. Fix this by adding the prototypes.
>
> [1] https://lore.kernel.org/lkml/20230810141947.1236730-1-arnd@kernel.org
>
> Signed-off-by: Vineet Gupta <vgupta@kernel.org>

Looks good to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

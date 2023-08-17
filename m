Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A0A77F69B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350927AbjHQMnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350921AbjHQMn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:43:26 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0FD2D6D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:43:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 53543580133;
        Thu, 17 Aug 2023 08:43:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 17 Aug 2023 08:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1692276199; x=1692283399; bh=O8
        D64D9ZxKe4zy+hw81tbMNCuqtgmzaesO9ivpE3ArQ=; b=QuHCOO/RSMr4Llucts
        aU3c+Kh5kz4Q0nwoCipRk+57PILjNRGQ0JAtMUsJxsf9dlqvaN86fR5I7WTsNQcX
        hgqcUy2ZjEIpOi0SnRjpRP+p4rzMn0xoOYYq2UW4COacobEn/UrdTX0O4KRHVzWa
        92zKUtEVjEy4LVXc6x4qCVErnyT50LV6ECLaXT/Wu7A8Q5m+Uk9qcGLRmwjazflR
        PfzqBqIKNWYUENxHXBJggddQOaLSAC74WGZ6E/RiijfDtVyC/pgE/MkrTcaNaVhx
        8rexWMMrFhwOeEoOL3eGdSzcqWFSgMdxU9v6pYEsn3HDZHCnOwJDZQ+RGO7GghnJ
        AJzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692276199; x=1692283399; bh=O8D64D9ZxKe4z
        y+hw81tbMNCuqtgmzaesO9ivpE3ArQ=; b=Rg06AqrgPniLcSm/FBOZ4hWiMmhAd
        po1B1mXcBR7XHQ9gJxtNggS2hzlhUqFYvNYVm7SJFxt7Ev+mwquznS6a2A0Yn0XE
        0Q1mjQB7xhiaWQLphZL/SGmWcVgYBH2Q1kCVoCzmMPxOvBQ9bEcTIl4S2y4DOxOg
        dRY2fUdELsplLfRTjaurLwNxvowVVQnetxcYxNhxtEp+nTPf0D3sghnDJnUL9hcC
        u/SQmluPKRZQDElJf/VyTVmodV7aLpzgL1urwLhFhSH+QqZOLVZdtz+SnK4od6sm
        hKpC6ATl5ciGq/jWsFG2LLq6D1iHh4D1116rd2AhMfkax1SXZWRtMFU4g==
X-ME-Sender: <xms:5xXeZKe111p5ZzkrkgiEBwKLJ6PSYTAeRO8Kuj9Lv60oo9l_Xi74Ww>
    <xme:5xXeZEN-9gp5qo33rE6o6v4Zc1MIThazt3Y2GU1fM-ttcS-uAZWExXY63K4Tf96gm
    xIp1DXolB6PjhpVOZI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:5xXeZLhMiJc1txFTs4wuJbUwjYOBDpT0CW7WD7aPlLKFUZ0IdbphLA>
    <xmx:5xXeZH9meYiroX8E-NQFRY3SW1ydrmk-5we-b2vwW9EOGUqspvEZvA>
    <xmx:5xXeZGuCHgnhsj8cED8n7BQ8vvt2az3wLrjXJf2HQgUX7eIDe_7Q-g>
    <xmx:5xXeZP5RMSuNIrkwVl-5dPWbDsVToKGnK2VEzlW4dse-DNq180iAlQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 10EE8B60089; Thu, 17 Aug 2023 08:43:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <6db95796-385e-48ef-a32f-a5fba63b4678@app.fastmail.com>
In-Reply-To: <38fe1078eb403eef74dc8f29387636fd7ecdf43c.1692276041.git.christophe.leroy@csgroup.eu>
References: <38fe1078eb403eef74dc8f29387636fd7ecdf43c.1692276041.git.christophe.leroy@csgroup.eu>
Date:   Thu, 17 Aug 2023 14:42:57 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/4xx: Remove WatchdogHandler() to fix no previous prototype
 error
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023, at 14:40, Christophe Leroy wrote:
> Building ppc40x_defconfig throws the following error:
>
>   CC      arch/powerpc/kernel/traps.o
> arch/powerpc/kernel/traps.c:2232:29: warning: no previous prototype for 
> 'WatchdogHandler' [-Wmissing-prototypes]
>  2232 | void __attribute__ ((weak)) WatchdogHandler(struct pt_regs 
> *regs)
>       |                             ^~~~~~~~~~~~~~~
>
> This function was imported by commit 14cf11af6cf6 ("powerpc: Merge
> enough to start building in arch/powerpc.") as a weak function but
> never defined and/or called outside traps.c
>
> As it has only one caller fold it inside its caller and remove it.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

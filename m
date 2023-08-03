Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D94776E51C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjHCJ72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbjHCJ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:59:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17D93A86
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D347E61D0C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135D0C433C8;
        Thu,  3 Aug 2023 09:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691056746;
        bh=5fI7/U96O/svCbo/exLZ+AoSAZig/ydM1Wn2uchQ8es=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=Lda71ZamqLE7DGG9s2kApPImV2AuQi4I57KpLBlKpnYe+WyYNquVC/bz9LNPrlasT
         52Yq49WvSMkI0vv50tja8a/vb51RVNSlcEUM6h3Z889qs42TJXTdCLl0Ev6o8O/fdY
         Dj9S7c8qYM+VNCmk2bochd+75m8UrXhgZiJflKR4dijKduT4CvCX9EJXeMwrJXr25N
         831SNM78XyQmcqCxcpIEX94BjIZduhf9A+j3UVfKHSza0R0SEBuZ9LBJ3M0qQyybkn
         GhQBXV0IncmJOf5fPN63agGqnd6atP1+5J0MHjxw/lkiymKiauDWPZv5kSkfWFmvrw
         Z+bmPZ5aAX2ZQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 023BB27C0054;
        Thu,  3 Aug 2023 05:59:04 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 03 Aug 2023 05:59:05 -0400
X-ME-Sender: <xms:aHrLZAPLq_Pczb3lOUCvdTTjK5eHIjrqI11sIYa5HPcPQkEYciUVmQ>
    <xme:aHrLZG8-RCEwBpb5fUgAxA-1ls__7WrIfgFMqAar_7DJHz42-Y0HMqnZki-D7RS55
    UEver-HAEDcOpPVPA8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedvgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvveeigfetudegveeiledvgfevuedvgfetgeefieeijeejffeggeehudeg
    tdevheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudejtddv
    gedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusgdrug
    gv
X-ME-Proxy: <xmx:aHrLZHSn2kHEE6rXRhklo5OBO_qIlW_WwuvNmOzIOZV0nz05sMcz1Q>
    <xmx:aHrLZIvwXrjLI0DJiDb7LXhj6G45_ksGDpGMbopheqAKTdu33nCtGA>
    <xmx:aHrLZIcR8VIDn7OkiiA7NYG3AvQ8cFUWDPWBmBY9LPRsAduAigllMg>
    <xmx:aHrLZNFrnG2fJ0gyqx0rdv1buTksyD-8N2ETKAMxjIATZnHLm8GJ4w>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6536DB6008D; Thu,  3 Aug 2023 05:59:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <820f673e-f5d8-4e65-b72c-913320fe1616@app.fastmail.com>
In-Reply-To: <13c836b31909f2eb64dcf2a5feb22c2a3173bba2.camel@physik.fu-berlin.de>
References: <20230802184849.1019466-3-arnd@kernel.org>
 <D28BDDE3-7FE6-4ACC-98B9-B6AB6D9518A3@gmail.com>
 <fecb873aefad8dd4c1d89935cf8f7790e9ba231d.camel@physik.fu-berlin.de>
 <4a3fae63-cf85-4e18-b785-1a438ec761aa@app.fastmail.com>
 <13c836b31909f2eb64dcf2a5feb22c2a3173bba2.camel@physik.fu-berlin.de>
Date:   Thu, 03 Aug 2023 11:58:43 +0200
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "D. Jeff Dionne" <djeffdionne@gmail.com>
Cc:     linux-sh@vger.kernel.org, "Rich Felker" <dalias@libc.org>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 3/4] sh: remove superhyway bus support
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023, at 11:36, John Paul Adrian Glaubitz wrote:
> On Thu, 2023-08-03 at 11:19 +0200, Arnd Bergmann wrote:
>> I looked at the clk conversion in the past, as this is not just
>> needed for the DT work, but also to remove CONFIG_HAVE_LEGACY_CLK.
>> The patch series I did a while ago renames the sh clk interfaces
>> to no longer conflict with COMMON_CLK, which should allow it
>> to coexist with a DT-enabled platform in the same kernel build.
>> Let me know if you'd like me to dig out and rebase that series,
>> it probably still applies and may help you here.
>
> Yes, that would be greatly appreciated. Please go ahead.
>
> FWIW, I am currently on vacation until August 15th, so I might be a bit
> slow with open source stuff. I am using the free time to get things done
> on my TODO list.

Ok, I'll start my own vacation on August 15, but should be able to
send you what I had before then.

       Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004D97996E9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 10:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbjIIIib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 04:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbjIIIi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 04:38:26 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94AE10FB
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 01:38:21 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1CCF358095D;
        Sat,  9 Sep 2023 04:38:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 09 Sep 2023 04:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694248701; x=1694255901; bh=eh
        Zt+B2jX5xBs+1bj5H5hfiU1YSfmNNpLPHz2pKWFMM=; b=Ir/EqWhglFD1ntvS3q
        hZWHZv8YhaBCZX26TOJ7pssLwsZPpb10sMwKBhLY9M6vVzIuADdaL/uAPkXzOmEn
        2ZjtZCNcpjWaPj3LAqgrBpR8QcZsjFs2Oyk4TLLN/GktrdrqO2+UKYzhB8NMEwww
        TNx6dL5G3j5enrPjysC5R1KWyX/Id224lBIxBO+EfLW700DNJZHz9UCibZpM9vKt
        xNyqCDGi+/KoyFB7wZYiec/1fE66yZNT6NMxfXZIPHgNVxQTC2mVs25cSDP9xRBB
        i3BX1BdOhQbDIX++NOFJIe3LRfOqSJN8mDQhk0PC1xOQ5S9qQmeCgq78zDTYhMYF
        /R/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694248701; x=1694255901; bh=ehZt+B2jX5xBs
        +1bj5H5hfiU1YSfmNNpLPHz2pKWFMM=; b=03u9Cw/H9C5y2i3STbp7a5Jpka1HA
        z5pg08EcooJDCxNOyjFqnyVSKUeTUXjmzpE+caCuGVhPq3kMYIb/5I37vgsjeoah
        IF4LUzTzM1NVVQKOrOqR0FN95MQOFgDOXu2Qn7Ko5rFoOWaE9scaq4L9JaFeVObs
        s8SrslgboCx+5U8HhS910gmv/X77kizuPX0cceOf4nUaawzQkaeXXeydKnX3sERM
        LotZwLSxPEZpX+v3mfHCpetkUs4909CYQjv1idFvyg+Hg9buYyxRQOI7QYDRCXEr
        0zqhnZMDQNMEAQnChNrb1i8J4TWGCmz4rkLQMlKxTuyhJYd+PKtRR0WPw==
X-ME-Sender: <xms:_C78ZMPoGp1gNarGyZpF65L02p1A89ACQmd8S1h4UN2tXiKPGviQbw>
    <xme:_C78ZC9pTgcPbdpwMpM0iEuXVjRohyZaxmMgHE17epwYUV069ERtwz24Mh8Tzi6p1
    -Zm2ehYeFAo-l0JiuE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:_C78ZDRblz9JwGy1yhxgANjUckPjHpcgLWsIYsTL0FAKFIcBU91yBQ>
    <xmx:_C78ZEv5NYA4n-vj_MlHK7JmB_sRC9Oegz_0b7uZD4kCVE47GHkgog>
    <xmx:_C78ZEdLXCyM90PV0LNm2cJ0goFctvPw0qH6OCSbAUxfCzLixUrxjA>
    <xmx:_S78ZCudcLPyXdryZOSBgFmYS6NYiSh0rqt2R0H8J7Q5lnJ_yYIy-A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D270FB60089; Sat,  9 Sep 2023 04:38:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <d98b2c68-9507-4a52-9670-6c117e704d04@app.fastmail.com>
In-Reply-To: <cover.1694093327.git.geert@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org>
Date:   Sat, 09 Sep 2023 10:37:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     "Finn Thain" <fthain@linux-m68k.org>,
        "Michael Schmitz" <schmitzmic@gmail.com>,
        "Philip Blundell" <philb@gnu.org>,
        "Greg Ungerer" <gerg@linux-m68k.org>,
        "Joshua Thompson" <funaho@jurai.org>,
        "Sam Creasey" <sammy@sammy.net>,
        "Laurent Vivier" <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/52] m68k: W=1 fixes
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 7, 2023, at 15:41, Geert Uytterhoeven wrote:
> Hi all,
>
> This patch series addresses the remaining (after [1]) warnings seen when
> building arch/m68k/ with W=1.  Perhaps surprisingly, this work has
> identified and fixes a genuine bug in the Sun-3 TLB handling (see [PATCH
> 39/52]).
>
> Most of the patches in these series are fairly trivial changes with a
> very low risk of introducing any regressions.  For the less trivial
> patches, I did look at the assembler output before and after.  As Arnd
> is working actively on enabling W=1 rather sooner than later, and if no
> one objects, I plan to rebase [1] and this series after the release of
> v6.6-rc1, and send it as a fixes pull request to Linus.
>
> Note that this series does not address warnings on Coldfire or MMU-less
> systems.
>
> Thanks for your comments!
>
> [1] "[PATCH 0/6] m68k: math-emu: Miscellaneous esthetical improvements"
>     https://lore.kernel.org/r/cover.1692283195.git.geert@linux-m68k.org

Thanks a lot for doing these, looks all good to me. I sent
two minor comments, but those patches are still ok.

Acked-by: Arnd Bergmann <arnd@arndb.de>

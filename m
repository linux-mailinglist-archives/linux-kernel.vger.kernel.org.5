Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E227B3AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjI2Th1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjI2Th0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:37:26 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD7FE7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:37:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B55F5320030E;
        Fri, 29 Sep 2023 15:37:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 29 Sep 2023 15:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696016242; x=1696102642; bh=/r
        nZ43krlTnKGjYuvqhBAItQLnGBofJgdfA6Jy4XxRE=; b=ZXTRiFHeE8YsIOex3R
        ikNNS92U0h8K+/2JL0C7JTwZ+VWBkEbcGdCwCMcY+Ul1anNIvmTYBjqu5g5neLMT
        M6iD/AdbrWVKtiBTCJbbJwlbWKN4rfV+nl+uatQpzy6uljYXQkwi7FUCFlP6bGOa
        U7Q8oHWNTsOSMqrqBFnuV0JW2r168jjjDKY1VsVrhrLuenz+ZYZxD5w7UwmIqO7k
        aN6a1MmX76TbzlZuo8CIiYMhzs7OMEtep2vjIq0cFh9t9dgEUYUvsxTfB+EE2n0u
        2gyqdX/WWbW8XTRtzx0SE+837OtUJfgmDEQDIt6LVv5FZIJrlw69JmLPWi0Ve3Sd
        HafQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696016242; x=1696102642; bh=/rnZ43krlTnKG
        jYuvqhBAItQLnGBofJgdfA6Jy4XxRE=; b=FTye3nUqUs9CxedjMOCorVMmR9bv+
        6NpUjHhhBJZFlQcyKm0d5rMpsO+YximgVZHVzND9IWPIk54GOvTxemhM6+xJsMJy
        9ZZP8bfT9SSNH2Bup/9TwuJdn4BTWAoQCA0/FdmrNfPHuQXH6rq/OviO22jz/GLZ
        Fqotv7E+hCszhRCgR1dO/M8/sIXOPRFLuQoa6xXivZdodGzBL3ID32AnF0eoJUMB
        SDOWiyjjjIcK7dn22mMQe6M2n+YLlpJwTWZTEtBvpT8zes6Z/jKSeH5uPZjWFQGx
        CAQ8nw0HAfFyWEy4KYfyocAR+BV41+uPuXE5vZjErMeKyDO8QAE8CT4Dg==
X-ME-Sender: <xms:cScXZegZSCNhyuxyl7xPChMRzWBjwY-T_BDIVczrpv9RUpQqOQ9SCA>
    <xme:cScXZfCTzyb3VjRVQSOsRu1hUClW6u3Wt7GN-FrPCaaSCbEdNp5J02MlqzUq8gytg
    BSUeXDbCiBAbqGucSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddvgddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:cScXZWH1633Ct5-DhBZIcAiu3p4yFW0TcsGGOB6I5l8NkP8MLjWLCg>
    <xmx:cScXZXQMPDSDPs9bO9xJQW3Jot5cRpgR1qWcuJDiIu5nzel7SQvfNw>
    <xmx:cScXZbxJ9X_ev-B51klxQlO4vYKI3Rg4j_8hACJawrcvKLufgj4l6A>
    <xmx:cicXZSnJD-4qY4ueVe43ZXE0e4ParBgTew_zKmlNPZxaU6NxztYz2w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B231AB60089; Fri, 29 Sep 2023 15:37:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <84b2de54-8337-42a3-a25c-a95cf2f3349f@app.fastmail.com>
In-Reply-To: <20230929082009.71843-1-angelogioacchino.delregno@collabora.com>
References: <20230929082009.71843-1-angelogioacchino.delregno@collabora.com>
Date:   Fri, 29 Sep 2023 15:36:57 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>, wenst@chromium.org,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "Rob Herring" <robh@kernel.org>, amergnat@baylibre.com,
        "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH] MAINTAINERS: Add Angelo as MediaTek SoC co-maintainer
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023, at 04:20, AngeloGioacchino Del Regno wrote:
> I am a top reviewer mainly for MediaTek SoC related patches in most
> subsystems and I've also been upstreaming both improvements, fixes
> and new drivers and devicetrees when required.
>
> The MediaTek scene saw a generous increase in number of patches that
> are sent to the lists every week, increasing the amount of required
> efforts to maintain the MTK bits overall, and we will possibly see
> even more of that.
>
> For this reason, and also because of suggestions and encouragement
> coming from the community, I'm stepping up to be a co-maintainer of
> MediaTek SoCs support.
>
> Signed-off-by: AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com>
> ---
>
> P.S.: I tried to reach to Matthias for almost two months, but I couldn't
> find any way to talk to him and he has been unresponsive on the mailing
> lists as well.
>
> P.P.S.: This also comes after Rob Herring's suggestion to have myself as
> a MediaTek SoC co-maintainer [1] and support from other people.
>
> [1]: https://lore.kernel.org/all/20230804225813.12493-1-robh@kernel.org/

Thanks for volunteering for this!

I have no information on what Mattias is doing, but I see that he
has not merged any patches since June, and that he never sent a 
pull request for your patches that are still in his for-next
branch.

I hope he's going to be ok, but let's plan for you to take over
for the moment, at least until Matthias is again able to keep
maintaining the platform in the near future.

Here is my suggestion for how to continue from here:

- Please send your MAINTAINERS file update to soc@kernel.org
  along  with any urgent bugfixes you may have, so I can forward
  them for 6.7. I'm wrapping up the current set of fixes at
  the moment, so this would be for next week's rc

- Create a git tree with the ususal branches (drivers, soc, dt,
  fixes, for-next) and ask Stephen Rothwell (on Cc) to add
  the combined for-next branch  to linux-next for integration testing

- Start each branch on 6.6-rc2 (usually we use rc1, but this time
  rc2 is a better candidate because of the last-minute
  drivers/pmdomain rename), and merge the corresponding branches
  from git://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git
  into those to avoids conflicts with his tree

- Add any further patches you want in 6.7 on top

- Send a first set of pull requests to soc@kernel.org for whatever
  you have merged as soon as you are confident about them,
  ideally by the end of next week.

- Send additional pull requests for fixups or late features in
  the weeks after that as you see fit.

See Documentation/process/maintainer-soc.rst for more details
on the above. When Mattias comes back, you can work out a new
process together with him.

       Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9ECE7CBF7D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbjJQJcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbjJQJb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:31:58 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6030C19A5;
        Tue, 17 Oct 2023 02:29:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DE9013200AC3;
        Tue, 17 Oct 2023 05:29:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 17 Oct 2023 05:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697534991; x=1697621391; bh=0+
        WiOi28HC5y6XPNzeCfToWHefJVknHsv8tRDnr5I3A=; b=M3DqHAU4V6utyyG/Gz
        0ZzIV0qofQaNpv9Wh1xWV4k71QH2ZRXYuWFAzyvrpjxaWpNslYAVpkBtFuSrVRPv
        qLafyssjyVu9yZuvBf1ZkT/JNHuqunpHlYkQ6e0Dex2Ta48R5c1miEzadWs7wup9
        /paBkR6vp4Ruk4QAUASpU5WYGjIENyxVb6hO4WUVgpGLhoqOrsziGY0jUanRCTd6
        yyVr9Rbp+cxVtSGjGEhHfx8LQEy3aQEFb3SS/nsT949FSwpLy/tLFVEe7rmtnlZb
        pHuOVoC/1z1dcFgdj+dWXBbwN7YXoWv2PbuRDCNvAO7gT35tVj9Oj9pNQnR5Yhpd
        wpqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697534991; x=1697621391; bh=0+WiOi28HC5y6
        XPNzeCfToWHefJVknHsv8tRDnr5I3A=; b=eSV/GRE4ZbBUvAHLPG7JXkfW8NN2S
        tLjnbi/9x4i3omoY8qz166gPPiSYqNn3yfuivfv0tgpfiNg+cvQote0uKpaBFouH
        3IMXUBGQcBwYl3UgoBJhtr9Khrl21Bwwc0gdGqsFM6/oV96ACaYY3/RBTljA8pym
        hPEl846TMtw9e+Kmqjht3jyHh2t7wNrMtHACNTZwqel6k6viUHQC7INHZNsgaIZj
        WWCVJa0in3UMfCAY6k2f2Z9smWCQp00NMTHt9mEWbsAYbi7CgX7e3XNZ/m7/eaJd
        ii0PtySqbinMAMXQWyuNU0BZB6AjtDRUm09ky80LwwVAzVUcNd5Pj+qZA==
X-ME-Sender: <xms:D1QuZZ2j1CFwteSmX5YvaJDJ8mEgJhdTSiV4Yu3FnR0yCSLajmO0NA>
    <xme:D1QuZQHUOrXkpQCwmoyGrzHQH0Y1wi3FQIA48rMzWEq4uAUdpTtstCEpDHB7PyLxG
    a1BcM-vx4BNQcrO6d8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:D1QuZZ6C0UqrYkLJPTu40U82ue2H79NcQY9X1ncGO8smcyL6kUqr2w>
    <xmx:D1QuZW39GcluuAwxIbBFt8Q7Qe7EAaw8VN3yX59kkeIdHnRtHb_F0A>
    <xmx:D1QuZcGZgFy0nDwExHYAFwrGBEerWxohGvT3wQbc7l2xuVLgeVL-ZA>
    <xmx:D1QuZYjPzIaPnHtYxQh539SEylHtvocDNGBKZXgfA94tMOPPG2hEVQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D9087B60089; Tue, 17 Oct 2023 05:29:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <8e279bd2-8766-4216-8dcb-9fff5b7e1280@app.fastmail.com>
In-Reply-To: <20231017085346.22917afd@canb.auug.org.au>
References: <20231017085346.22917afd@canb.auug.org.au>
Date:   Tue, 17 Oct 2023 11:29:30 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Olof Johansson" <olof@lixom.net>
Cc:     "Matthias Brugger" <matthias.bgg@gmail.com>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023, at 23:53, Stephen Rothwell wrote:
>
>   976868a021ee ("arm64: dts: mediatek: cherry: Configure eDP and 
> internal display")
>   6b6d5f5665af ("arm64: dts: mediatek: mt6795-xperia-m5: Add DSI 
> Display and its vregs")
>   db584927b355 ("arm64: dts: mediatek: mt6795-xperia-m5: Add display 
> backlight support")
...
>   142a80a9b568 ("arm64: dts: mediatek: mt8183-kukui: Add PMIC regulator 
> supplies")
>
> are missing a Signed-off-by from their committers.

I've dropped this branch from for-next now, it looks like
the rebase that I asked for caused the problem since the
patches were originally applied by Angelo but rebased by
Matthias.

Angelo, Matthias: Can you rebase and resend that pull request
another time? When you do, please make sure to send it
as a new thread rather than a reply to the original pull
request, otherwise patchwork gets a bit confused.

     Arnd

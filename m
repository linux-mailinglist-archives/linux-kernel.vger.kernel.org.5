Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230C079A099
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 01:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjIJXGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 19:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjIJXGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 19:06:32 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8EE106;
        Sun, 10 Sep 2023 16:06:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9EE963200564;
        Sun, 10 Sep 2023 19:06:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 10 Sep 2023 19:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jcline.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694387181; x=1694473581; bh=M2
        YbSJshShWvUhnLY8g4xtG6YDWHsJHJ87/h7S3BeSU=; b=G3kwH7/v/ywICkCB+T
        TdSKSIlZgSEPGKfTH8Xjj2n7qgv4YWYDtob+ttK71dVVWaokIJZwI4ibMCo1yjts
        rVsc6gXrAHpGzFGpvOt5bAddtwy2Dqko3C+R5BmlNuUrXNK6Kl00jPckh0H/OktF
        EeoG3Qd3mlTS9uja/mm1JckvnfdWRj2Kzyn96pqg/QPhySm+XNdheM3IYDtVRL3g
        NVHxy7CgLTixQ/wK83cNSgNUEAoK2c1ShDM+rBNYXPfyXdeqHh2PAB1WVPkM+te1
        gxhzEG4u0Bk4IsC4ZWe8eHKhhrdNTgQ5CVVNdu6ARWQ8Sw32jxlzcbDDHh8C80jY
        eU8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694387181; x=1694473581; bh=M2YbSJshShWvU
        hnLY8g4xtG6YDWHsJHJ87/h7S3BeSU=; b=ekL1wOQmTOQEioSQbMLE9R1Y3M89A
        vxjmlpSpnq4iPpoL2PFloSBaCm8X4s5l318uVAr9smqQ+YgLm4cCcOAqbnNFeiM0
        XdAWH5tKlbgl1yxEEVzIHkSsw4W1XUDr4xRNVsJpB1i9Ll2j9iHr7CxAZHsZrerp
        l3Bz4LnKWftwb8FebVCVjpdD+KID0B6H/MRpfpUJzYNwpRKFuRttz8M0FUCI0/1z
        WhZkSW5Si11lWllXV8+TYGAWIxpOTgxRmgmH+d+kzlmY7biN348sHNmIb0NKuBwL
        OyvHzxclv0IqaeuMmsJjLwDvfRqwja5L60TzPBgVZHkrx0dRSYhBILilg==
X-ME-Sender: <xms:7Ev-ZAmwVuRuUUnTYjadhWx6HkJ1hyW05alxAJWqkMBK2L17sAmXyw>
    <xme:7Ev-ZP0lU3m3dk1HfxbCK_3hJ4CsfDPWP0y0983WamsaON3erNmlADMDRO_OBUb8U
    VsroE79EjeI1FGQQ1s>
X-ME-Received: <xmr:7Ev-ZOrSJL_HW5bqRd8eYV3RzTF3qOB0udcfwOSIHbm6SRanPv6nw8Do-97WOcPeJqN0wjCk2m9VPMsCFDkLYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeifedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfgvrhgv
    mhihucevlhhinhgvuceojhgvrhgvmhihsehjtghlihhnvgdrohhrgheqnecuggftrfgrth
    htvghrnhephfefjeejueelueevveelvdehffeufeffvdejkeevteekieduudeludevgeeu
    vdeinecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgvrhgvmhih
    sehjtghlihhnvgdrohhrgh
X-ME-Proxy: <xmx:7Ev-ZMl1xxiEPh1ki9w--L0dpLusU-UvFeZG_tUnsI0TN9C8iLErWw>
    <xmx:7Ev-ZO2AT-DTPbLnGgwK3P5dv7JxYpaFH5wDeTggDHN_vxbzQ18Emw>
    <xmx:7Ev-ZDtvEdGQ1Ge0roRP1cfEagXVJDmv_iGWsGgvAowol_s5H0BKUw>
    <xmx:7Uv-ZHkpdn0r2XK6FYO4RTumPGb6Uuzd9fYxrXEKWs79xMfMzExGmw>
Feedback-ID: i7a7146c5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Sep 2023 19:06:20 -0400 (EDT)
Date:   Sun, 10 Sep 2023 19:06:19 -0400
From:   Jeremy Cline <jeremy@jcline.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: nfc: llcp: Add lock when modifying device list
Message-ID: <ZP5L6/zF6fE+ogbz@dev>
References: <20230908235853.1319596-1-jeremy@jcline.org>
 <20230910152812.GJ775887@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910152812.GJ775887@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 05:28:12PM +0200, Simon Horman wrote:
> On Fri, Sep 08, 2023 at 07:58:53PM -0400, Jeremy Cline wrote:
> > The device list needs its associated lock held when modifying it, or the
> > list could become corrupted, as syzbot discovered.
> > 
> > Reported-and-tested-by: syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
> > Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> 
> Hi Jeremy,
> 
> thanks for your patch.
> 
> I don't think you need to resubmit for this,
> I think this patch warrants a fixes tag:
> 
> Fixes: d646960f7986 ("NFC: Initial LLCP support")
> 

My bad, indeed. The lock in question looks to have been added in
6709d4b7bc2e ("net: nfc: Fix use-after-free caused by
nfc_llcp_find_local") which itself includes a couple fix tags, should
this reference that commit instead as it won't backport without that
one?

> Otherwise, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 

Thanks,
Jeremy

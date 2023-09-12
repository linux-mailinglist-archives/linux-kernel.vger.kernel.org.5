Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77DD79D51D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjILPkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILPkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:40:45 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DADA10DE;
        Tue, 12 Sep 2023 08:40:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2BEE35C023B;
        Tue, 12 Sep 2023 11:40:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Sep 2023 11:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jcline.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694533241; x=1694619641; bh=vd
        xprn+VLunJ+Ba1KePDdQ8b/yp76261BQa2lBK+CxE=; b=AJ7hJV1s7pfeQAa3Qh
        vNTywaHGJhoVph3GxX4hX98F3+HoybDiAqHP33z67xzU3bXSLghtYkJXxcmhO79J
        91PITxUkDNeaNUiUayE1aGKxl8nO55oBuZxFEr6fhu3VKUug9JNVI1BLotMMk0AC
        Vj9F1YJYHBD19nd4gY8d8gTB2LRBhO409+1rXQGz2ghqyzReb03tDE4Bh6hcI4J2
        t8EszkIKbgSdwk5MPku6nfVI0eKeeAalqRYpAAD46L/M6dvNZJxefhIRsL9NUQ/H
        5+pyCsPSSlzxKO9cKoPdIID8KaN8Rh6R74u25eoyeC9BI3ro/Z4ZtQX+puXD5a/p
        Duug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694533241; x=1694619641; bh=vdxprn+VLunJ+
        Ba1KePDdQ8b/yp76261BQa2lBK+CxE=; b=Xq4W7g5RYo6XiSHOwOxqSGJOX1kyE
        yg/PbEVL+mDRmeC18+aKI3ogxnU2gaFFXHUUfN1YIuz/ZeQ32l6vnRx7aCNPnyz6
        xIoxI2IYK4vjWd0lEDUbomD2PphyLbQ3GyFWDynUJYk42kjKZCcTX/8G8sMEmRr3
        mW/jJyPRJqUWG3aZpLLN6opktBorzgvmN0Gx6HtXQ9K7eDcz1ZgYhckP1GjcvbK3
        4gwooD2uhcTVr9aFN2tj1ty0OSiu1QprXCI3AtwpGRHsbCKkHeROL1ZIgIxkjtBd
        WfoLo+u5/h1v831jfESqrD2/oZ4xYZUIgrsaVJNyt6VJ8IqcbzOUFRqCw==
X-ME-Sender: <xms:eIYAZbjayQTooKedmvgwajwMg8UhShVmg-wX7AhYYzHGzsjIaS-IVg>
    <xme:eIYAZYCMCd500kAWs8DOMOBjWAtxoXhYxDzXOo7rjRSYxv2Yw-KzVyH3qDC8SfKGf
    pKuIvnrgnM5Tkrpz6E>
X-ME-Received: <xmr:eIYAZbEqrJvcZ-wf1RTdeVbuVvnxgT9xvzSnlgSIPjGQpOHvZ_SOffez48sq4nFdojQmoRiXvudI6VIbraHscw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfgvrhgv
    mhihucevlhhinhgvuceojhgvrhgvmhihsehjtghlihhnvgdrohhrgheqnecuggftrfgrth
    htvghrnhephfefjeejueelueevveelvdehffeufeffvdejkeevteekieduudeludevgeeu
    vdeinecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgvrhgvmhih
    sehjtghlihhnvgdrohhrgh
X-ME-Proxy: <xmx:eIYAZYSfuBT8Pt3oyzsIGYa2sJwFnlXBzbsYdgOW776etF6SP1DvvQ>
    <xmx:eIYAZYxH4HNGutPscgpy_knzwtir7jLWD3R9mqVG20OsZ7eJdJelAw>
    <xmx:eIYAZe7avLR1qCDRkutJf4t_n9MuY67mLyjyjJbGiY_zcsnqmBDMqQ>
    <xmx:eYYAZbw27w-pcDSWWxOkCBmq5aw_Eq3BnvsOamsuhQl0dq3WYVUcXQ>
Feedback-ID: i7a7146c5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 11:40:40 -0400 (EDT)
Date:   Tue, 12 Sep 2023 11:40:38 -0400
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
Message-ID: <ZQCGduvxodv4QQD7@dev>
References: <20230908235853.1319596-1-jeremy@jcline.org>
 <20230910152812.GJ775887@kernel.org>
 <ZP5L6/zF6fE+ogbz@dev>
 <20230911055904.GN775887@kernel.org>
 <20230911125251.GA23672@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911125251.GA23672@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 02:52:51PM +0200, Simon Horman wrote:
> On Mon, Sep 11, 2023 at 07:59:04AM +0200, Simon Horman wrote:
> > On Sun, Sep 10, 2023 at 07:06:19PM -0400, Jeremy Cline wrote:
> > > On Sun, Sep 10, 2023 at 05:28:12PM +0200, Simon Horman wrote:
> > > > On Fri, Sep 08, 2023 at 07:58:53PM -0400, Jeremy Cline wrote:
> > > > > The device list needs its associated lock held when modifying it, or the
> > > > > list could become corrupted, as syzbot discovered.
> > > > > 
> > > > > Reported-and-tested-by: syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
> > > > > Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> > > > 
> > > > Hi Jeremy,
> > > > 
> > > > thanks for your patch.
> > > > 
> > > > I don't think you need to resubmit for this,
> > > > I think this patch warrants a fixes tag:
> > > > 
> > > > Fixes: d646960f7986 ("NFC: Initial LLCP support")
> > > > 
> > > 
> > > My bad, indeed. The lock in question looks to have been added in
> > > 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by
> > > nfc_llcp_find_local") which itself includes a couple fix tags, should
> > > this reference that commit instead as it won't backport without that
> > > one?
> > 
> > Yes, I think that is likely.
> > Sorry for not noticing that.
> 
> And further, sorry for being vague in my previous email.
> Having now looked over 6709d4b7bc2e I agree it is
> the correct commit for a fixes tag for this patch.
> 

Super, thanks. If it's helpful I can re-roll the patch, otherwise I'll
just leave it as-is.

Thanks,
Jeremy

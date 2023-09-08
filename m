Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC88797FF0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 03:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbjIHBBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 21:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjIHBBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 21:01:16 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CF81BCD;
        Thu,  7 Sep 2023 18:01:12 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E4DD25C01BA;
        Thu,  7 Sep 2023 21:01:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Sep 2023 21:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jcline.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694134868; x=1694221268; bh=mq
        UbAARvEzLFdOXXw6WmrK9ZPi5BZyESCJj+vsEamq8=; b=BJoUUIYEy5JlLjPwOp
        KaNhJ4wM6/Je4U444aRSSKz/2ibisXqR5exso9IjGRcAZqZr0qFHRNU3lWru5Uuy
        fluuXUoXpvUyA8KIS0YmB5HIHB5xv4lCoFE6viVsXqH7zHN/BsRUizyXL27Alem8
        6H52NDuMNrJqiuZ4hT9j/f1f7HlcO8A1sSFvXNXUQaTD+FadpM5zhO/IBroFp4P8
        XLyQ7OOObFHsAsXh52t2xtNJY+l840Nv+VRR2A0N1NRECtPN8qbW7o9Q0ZYjUHnL
        Z5QJe3UYkeJdD8demUvaHXoRIOEfkGSNbE8IBgRhFhecFSEjzau1xqKX20tpEgYv
        ulWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694134868; x=1694221268; bh=mqUbAARvEzLFd
        OXXw6WmrK9ZPi5BZyESCJj+vsEamq8=; b=r1ugy3ZDH0yy5uj+DpTq/B3Ujqi/9
        nWRAl50p6vZgKmZ8ZZKl3SrGOU3NSG6ohf+HXTpA6Itt2qq2CDA5zO4EP/fChno7
        Khmol+b4btIF5BwpHJx7+fH1hOyVOrtiuuvWOh1dbFFBYsJbAySOTYevdR9Yd9tA
        ktrARV8yfMNnXaf9OywEonH287K9TLZnP1YjpvGLbRhIwRuSBwiWpUoDZtAiDc3p
        wOY/y1VBWF4jWnP6tfcFL7+5z8J/egS1sb6SWYaBJB/NJZ6LBbsD1+KQ9K8Vi/wG
        Nl5xohop6FrwJWSAAfNYXUK1+510N5HuM6M2dKjBiNn79JoEV9siwdv/g==
X-ME-Sender: <xms:VHL6ZHzHwPyPwVLO5I7FNbWnH1MdDvaIPRfCfhTcCUvfclBzsDyxvg>
    <xme:VHL6ZPRzlIfuygLYDrHAMalFkT0hRz0QXrNo6-AdtKy22nIwVGIkMXMBXw_r8DXCd
    1F2fsS_E2O8qHjevH4>
X-ME-Received: <xmr:VHL6ZBXvso7G3Jdhhx7fPAL9ene7sGXgcfG1DeuPL0CHmcaW7i-Bz8U6hqv4Dd4U-wX7TCidq52zN7bSkZrKqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehiedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfgvrhgv
    mhihucevlhhinhgvuceojhgvrhgvmhihsehjtghlihhnvgdrohhrgheqnecuggftrfgrth
    htvghrnhephfefjeejueelueevveelvdehffeufeffvdejkeevteekieduudeludevgeeu
    vdeinecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgvrhgvmhih
    sehjtghlihhnvgdrohhrgh
X-ME-Proxy: <xmx:VHL6ZBgWPGekxjdIx23-3Hj7iw6hui6aeytIaYskReirpsyrPBXOjQ>
    <xmx:VHL6ZJC80lqDqsV2j3NC_g2Ws1Q1KLBe38LgrN1DXOEc7mBDC0UkZA>
    <xmx:VHL6ZKJFyjbXM8X5fDTLE_puDIG4wtOI93MtRYxmW2_oGt0hpyLsNw>
    <xmx:VHL6ZOIE5Qkwq89Lt4kNOJPEGNtJVaHcuDfdMxxM63dNNAxy_UuB_w>
Feedback-ID: i7a7146c5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Sep 2023 21:01:07 -0400 (EDT)
Date:   Thu, 7 Sep 2023 21:01:06 -0400
From:   Jeremy Cline <jeremy@jcline.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com,
        "John W. Linville" <linville@tuxdriver.com>,
        Ilan Elias <ilane@ti.com>, Dmitry Vyukov <dvyukov@google.com>,
        Lin Ma <linma@zju.edu.cn>
Subject: Re: [PATCH] nfc: nci: assert requested protocol is valid
Message-ID: <ZPpyUryqAT9PJ/qd@dev>
References: <20230906233347.823171-1-jeremy@jcline.org>
 <20230907144112.GB434333@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907144112.GB434333@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 04:41:12PM +0200, Simon Horman wrote:
> Cc "John W. Linville" <linville@tuxdriver.com>
>    Ilan Elias <ilane@ti.com>
>    Dmitry Vyukov <dvyukov@google.com>
>    Lin Ma <linma@zju.edu.cn>
> 
> On Wed, Sep 06, 2023 at 07:33:47PM -0400, Jeremy Cline wrote:
> > The protocol is used in a bit mask to determine if the protocol is
> > supported. Assert the provided protocol is less than the maximum
> > defined so it doesn't potentially perform a shift-out-of-bounds and
> > provide a clearer error for undefined protocols vs unsupported ones.
> > 
> > Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> > Reported-and-tested-by: syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78
> > Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> 
> Hi Jeremy,
> 
> As a bug fix, with a Fixes tag, I'm assuming that this targets 'net'.
> As opposed to 'net-next'.

Yeah, that's fine, whatever the maintainers think is best works for me.
I'm an infrequent contributor, at best.

> 
> There is probably no need to repost for this, but in future please
> bear in mind the practice of specifying the target tree in
> the subject of Networking patches.
> 
>    Subject: [PATCH net] ...
> 

I'll try to keep that in mind if I send other Networking patches.

> Also, please include addresses indicated by the following in the CC list.
> 
>    get_maintainer.pl --min-percent 25 x.patch
> 

Likewise I'll try to remember this particular version if I send any more
network patches.

> The above notwithstanding, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 

Thanks!

- Jeremy

> > ---
> >  net/nfc/nci/core.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> > index fff755dde30d..6c9592d05120 100644
> > --- a/net/nfc/nci/core.c
> > +++ b/net/nfc/nci/core.c
> > @@ -909,6 +909,11 @@ static int nci_activate_target(struct nfc_dev *nfc_dev,
> >  		return -EINVAL;
> >  	}
> >  
> > +	if (protocol >= NFC_PROTO_MAX) {
> > +		pr_err("the requested nfc protocol is invalid\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	if (!(nci_target->supported_protocols & (1 << protocol))) {
> >  		pr_err("target does not support the requested protocol 0x%x\n",
> >  		       protocol);
> > -- 
> > 2.41.0
> > 
> > 

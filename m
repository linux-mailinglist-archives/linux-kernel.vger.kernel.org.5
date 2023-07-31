Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21144768B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjGaGCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGaGCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:02:04 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B59BF;
        Sun, 30 Jul 2023 23:02:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B18BA5C0108;
        Mon, 31 Jul 2023 02:02:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 31 Jul 2023 02:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1690783322; x=1690869722; bh=sh
        FjnfGoAytyshPf/JloNkqJqiuNTHMwi4VXx3Cfmkc=; b=TLKicy3o98eJU9lRlm
        6rh+0FbGi/sZG2SspygPj6L6OSNoik5Wj9k8vOQg9S4DY67vHQsQemuhOREzSCpB
        q6SHXmEye9XxA9ESyWVFJJUeMP0Of0e9tCsZgzeDGy890c0va1XB24Qtyf9NNEYI
        BWOHZKrADqhk7W89MZG1iElZBoxZX3YjmHS6Nssr/E0e2pHRyT/n0yVDeUGFZ9+y
        5rCYoBetKQkScCv75qQFja5ib7p0bQ1ZPTyNvcyubbF6YAngnM5W7R/ucogf6tF9
        l/UEjvcfOr/b8jVh5MfTUVRnvuBztvpTiKYqHwkmdmKTyUsoVUlSh0FlhRQ1HVMN
        GJ2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690783322; x=1690869722; bh=shFjnfGoAytys
        hPf/JloNkqJqiuNTHMwi4VXx3Cfmkc=; b=QBIYDec7e1TF0FA+X79c/dUryVYXw
        cK+f6cEJp3Zam7XidYavRlMg3f6/Smtnw0wqSCz2GzvuaEC5kjA6rvseTaptaphI
        d4OdN3kMCVbZfwxsW6L5tUtRWyAsBzI+U/9LWCguqlRWdKnfewWsHRsu5XsXeSK4
        GBqhqZ05Wx1TBGcOkZbhwaCyD/Z8bQvXj6X/WO9RdYv4UzO+ZIeUwwgjyJ5cOLi+
        HPHLpcjk4AAJvf7r5HThZbI2w80VOxC+KWNfxlu5nqwfCsDdLCBhmiccMKzPz9qT
        MqONOlZYwyX9nhM/tigewVotgGp/brmx4z0AZpPgw826apcpkYQMDZkdw==
X-ME-Sender: <xms:Wk7HZJ5-cJxAn29i5bFLwRuKDmUMhc84i5q99gdcJ5fTwompJrYYrg>
    <xme:Wk7HZG75RbM980csNmRu0_6g9KqwqxuNHdM5EeWbyoJSGbZmoUJG3yLAcSiaSPbz4
    9jxXAzCyZGpBA>
X-ME-Received: <xmr:Wk7HZAdgrH-3a6-Atx0UY0o-ymB9Q3TJPVc0Pv-ISJYp6dfc9LdOP29xqYl->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjedvgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:Wk7HZCKZAhhF7W4ZWWW-N6J-jKZ10kd2VYLk4CHeylhMUSM2w-4jqw>
    <xmx:Wk7HZNKDS3IHvIVG4wnKQQ_SmhfDrwqAjx9bIj_HbWg3-p63YyrKxA>
    <xmx:Wk7HZLxoFKUN6b9BcXGRKNoxbU3a6lfn1apU2B0DdaeF1EJ06ZWeSA>
    <xmx:Wk7HZFILGlc_JerTsYJQqiuSCzsc07ABGdoByGKfy1PM_NjK8f8oPg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Jul 2023 02:02:01 -0400 (EDT)
Date:   Mon, 31 Jul 2023 08:01:58 +0200
From:   Greg KH <greg@kroah.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Atul Raut <rauji.raut@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Ming <machel@vivo.com>, opensource.kernel@vivo.com,
        LKML <linux-kernel@vger.kernel.org>,
        Minjie Du <duminjie@vivo.com>
Subject: Re: [PATCH] ath6kl: Fix debugfs_create_dir error checking
Message-ID: <2023073148-blurt-pulmonary-bd3f@gregkh>
References: <20230731024542.27248-1-rauji.raut@gmail.com>
 <8b6229da-ca60-f352-f374-47f9b6d33862@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b6229da-ca60-f352-f374-47f9b6d33862@web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

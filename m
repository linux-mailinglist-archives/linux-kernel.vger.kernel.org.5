Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5637CD5C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjJRH4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjJRH4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:56:43 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51269BC;
        Wed, 18 Oct 2023 00:56:42 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id F050E5C0232;
        Wed, 18 Oct 2023 03:56:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 18 Oct 2023 03:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1697615796; x=1697702196; bh=sp
        dOIfIhSm3Az2FRldIMsRlyAcMKKG6PX8Ffi8zB5Zo=; b=mcaUC2S1LZZZRq5Afj
        3VhO3+9WNodtPFFDR18MPJPa9mb69s6cOCGKjGg38VdrlOncgomyVSIJM2AG69r5
        0u9+Dh36m30ln1f6k7NPMHX81oEJNtIUHFlMeVkuVjtNHj/rxhcKsn6sbEtK8NxK
        1YWT11exvIVX7WsmJRdHipO/yPf675qU2Dd8RHUrFzmXdZ03FI/Y59X6diO70Ote
        madMa36JkZLZGxi0/iWve5YM1tKNXnBMPF3R0DnGyBWF2Ovi+eFCqT7Y0h4JnHA8
        BO/HGH4JeYeVo3uizEXLLwka9qHMSfMohGpGYVjg3cPL/5nt8wA+XHYS/tSCIh/4
        rz/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697615796; x=1697702196; bh=spdOIfIhSm3Az
        2FRldIMsRlyAcMKKG6PX8Ffi8zB5Zo=; b=uxxc8xUDK5K9FAZ3Yh/yt4mGXT5RI
        fN4sUBenWpGebNAOng3ztE7xNUzmp6c1W/vuARa60D8L2FFQ6JmHBafXNdbD6dgz
        khDRyZbIVdTen6VD6YCZowl3D7iyUPLf97s1VyeUSLT4o2Pmw8zkktSZQtrfyXJj
        C700rFHAJQGndL0p3x2IXxb4iocG+/os8LpXqotjxF7zBUPdmKLLbzXHW8lw+C7r
        mJdSAnDd+IA/aN4tnXg/P+txqzXe5I1gKmG79+zd28eE1WzK9ddL63QvZnXVFF+v
        UtwSVQc5UZE3H5mU3645XnZwVujH2oXDCKiROPEt+U3NproGWheA6LHeA==
X-ME-Sender: <xms:tI8vZVeiUwJlBtOy0LwhuKABwbyIVoFslwiogmJ1c-FNpRiJx1joFA>
    <xme:tI8vZTNloIMVRYUpfVmpbf-Z3Rlwes2-JDfG6U_BcOgsMkTkc86x2HtYwNnLZCvSv
    pmuqPvAjywbog>
X-ME-Received: <xmr:tI8vZehAm6LfH27ZLhQN5JpnTFnxSqL64yIAqip-ME2nG80ZmvsgUE5ULgY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeefgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:tI8vZe9-LgOitlv6mXFUJSuBmxsDS5aWv2cI5Hms212JyLZJ4eA-iA>
    <xmx:tI8vZRuKbqP7Waqyd2XDV6rqOrsejhg6P1GHsmRM-3JRFzAkrGfIZA>
    <xmx:tI8vZdGr7yGlkHAyqW02Q1_tibo_aZ7ukmksboMxeVguL0Yc2nwvPA>
    <xmx:tI8vZXAzvCAmbEKdwGDSd0bmrWsZc5v-hyRKtMMGaXE7fNNdPL5t6g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 03:56:34 -0400 (EDT)
Date:   Wed, 18 Oct 2023 09:56:27 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Herring <robh@kernel.org>,
        Abdel Alkuor <abdelalkuor@geotab.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the devicetree tree
Message-ID: <2023101818-recant-goldfish-44b0@gregkh>
References: <20231018131334.5fb47992@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018131334.5fb47992@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:13:34PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> 
> between commit:
> 
>   47b8fb4aef95 ("dt-bindings: usb: ti,tps6598x: Disallow undefined properties")
> 
> from the devicetree tree and commit:
> 
>   6060d554e891 ("dt-bindings: usb: tps6598x: Add tps25750")
> 
> from the usb tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks good, thanks!

greg k-h

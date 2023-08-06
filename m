Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A648771415
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 10:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjHFIyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 04:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHFIyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 04:54:47 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50B519AB;
        Sun,  6 Aug 2023 01:54:46 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 88BA55C00A6;
        Sun,  6 Aug 2023 04:54:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 06 Aug 2023 04:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691312083; x=1691398483; bh=PU
        l/rN2mkbNT1ghDGerkeSZT7FB1mE6xTiSr+Cq7Jt4=; b=hHBSpgfqnSFNXBvL9/
        01f1Pc/cIjYCpch8jObzQZJaUZxf0WTfp6bGNaV4SqfxxkrZ+MAyQXfkO6b6NbFm
        wL2iy6UkD/o1sVmbeixeoWEpUPykjzlrlpzQhiRumwAweQiyNJgMIdkgMvzND2f1
        Hm2wZUiulnEvEcIXG1jiYyYs7lXSBj62UUP2TWgETZ5xPJs76UzHNf5VgMAEo79P
        +T/dx+gVqwMj4EYhISBTkEietoOQP8X7b8Hmq3thtnlhfNx7oBvC2Rz/JNex5wIH
        6lLrBK7/Brwj6bXj/S0HsC5wDr4OI9z3mNR6yDvWEa060T8+8mObd5z6V17I13Ju
        sMOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691312083; x=1691398483; bh=PUl/rN2mkbNT1
        ghDGerkeSZT7FB1mE6xTiSr+Cq7Jt4=; b=bZFMflRIHlgdTKvr1JrLjCBd28U6S
        HPKOnC7s8JlaFWK3ZriG/N61lZ/tolA9NmQpweDXM+MKyokZB0dFv1LMvgEFN8kc
        p/SGTMMuMA5ZCrgQQvGmGNKAOWSZa03kLi+I3E+TLJixLerX3khu4nDxm3IRVVwJ
        9cLaEJy592RVWJSh8H01jmf5xUfC4E/3sfYUj4eLNw96PCOv0olJDwh7lcLhWsh8
        tsdcG3bSRlvOlZammRF+rZ2jsG6zoRsJkBdb6WgkvrJtUZskEOxodlG0/1a4iG5I
        jK2w3XPrSzSnLvctM4EnGK9/Um6DASR//bUEbmaYAqacT01cOo8NkxywQ==
X-ME-Sender: <xms:01_PZOERp-5Mc995MkK3g6s4bOeDckRvIKFAVLs9XRRGP6CVPaBjtQ>
    <xme:01_PZPXelJiMe4LjSjEzUXO8WcRKOBOVqQy5rH2iM3h6HYLv_M-IfDHjtyeUDS_ma
    1gxHJenvNKPow>
X-ME-Received: <xmr:01_PZIJk766Bfa1Txxb_XDOlEaIJ2DKd9cz-BDeAKHttTJ4zib8PFs5nyK1GXy5A6crcGpiCh6sgFllwl8qDyDtM1_n2bmHFDOE3rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeekgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepkeeuiedugfeuleeitdffkeelleekvdekhfduveffffeuhf
    fhueeikeevheejtefgnecuffhomhgrihhnpehlihhnuhigfhhouhhnuggrthhiohhnrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:01_PZIED9jiMcJOiRqNaY-6mWY1ThWlh5djWnio76OYTPVE2G0d94w>
    <xmx:01_PZEUoFZ3kHWFhmqNmjPcpKp4Shc4eSB1_mHbWhrKjcDZj-Co82g>
    <xmx:01_PZLO_slpZuzxSx7ElJf-hXwn4dWkrY-SvHUdfOlDG5NIHCewVqw>
    <xmx:01_PZIpxKMwFulVV-CCBUaC96w2hbCpcXVkYBT2PzpsATAdFZ2YmSw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Aug 2023 04:54:42 -0400 (EDT)
Date:   Sun, 6 Aug 2023 10:54:40 +0200
From:   Greg KH <greg@kroah.com>
To:     coolrrsh@gmail.com
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] spi: spi-mpc512x-psc: Fix an unsigned comparison that
 can never be negative
Message-ID: <2023080629-vocalize-ducking-c8f2@gregkh>
References: <20230806083734.7685-1-coolrrsh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806083734.7685-1-coolrrsh@gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2023 at 02:07:33PM +0530, coolrrsh@gmail.com wrote:
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> In struct mpc512x_psc_spi, the variable 'irq' is declared as an unsigned int.
> The comparison of variable 'irq'  with signed int operand is incorrect. Also,
> the return value from the call to platform_get_irq(pdev,0) is int and it is 
> assigned to an unsigned int variable 'irq', thus redeclaring the type of 
> variable 'irq' to signed int.
> 
> This fixes warning such as:
> drivers/spi/spi-mpc512x-psc.c:493:5-13: 
> WARNING: Unsigned expression compared with zero: mps -> irq < 0
> 
> ---
>  drivers/spi/spi-mpc512x-psc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
> index 99aeef28a..5cecca1be 100644
> --- a/drivers/spi/spi-mpc512x-psc.c
> +++ b/drivers/spi/spi-mpc512x-psc.c
> @@ -53,7 +53,7 @@ struct mpc512x_psc_spi {
>  	int type;
>  	void __iomem *psc;
>  	struct mpc512x_psc_fifo __iomem *fifo;
> -	unsigned int irq;
> +	int irq;
>  	u8 bits_per_word;
>  	u32 mclk_rate;
>  
> -- 
> 2.25.1
> 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

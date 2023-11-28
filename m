Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED49B7FB3A2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343986AbjK1IIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjK1IIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:08:50 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D785698;
        Tue, 28 Nov 2023 00:08:56 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8153E3200AF6;
        Tue, 28 Nov 2023 03:08:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 28 Nov 2023 03:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1701158931; x=1701245331; bh=YA
        9oC0qFgkfWKMMXJTxA4XBL16CHD3TNlMQ1vpp0A2s=; b=cntqvFIeEjLq+UdIS9
        IqknGEWD6ZfM3FBjGUnhNezZVOTXPyVDzmqQldbyIfUIUYS9q29W7utoZYhEOoYy
        7PyA4LqIvzf5w+vG7+uAfilIZMEhxSxCnQ7ZH8Kv2kkplz2X8AvoWXjXFrvMSXpY
        10D8OnXqI5InTQOABOxUX+MJu3VSHMxDAyrjvTNL03I+Gs0Ic+kwnufQBPiH0FyY
        16ww+jgIMdjXaGiZNO1e/tWKyI2nKsTycohcu7TRKw/JPiSUxR6tMfOS43+VP732
        t0uAeMqcxgwh4goceslqHWzZdXnHvv6BydDEptR+8PhsU88D7lR+8elGoFhbZ7dg
        1U2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701158931; x=1701245331; bh=YA9oC0qFgkfWK
        MMXJTxA4XBL16CHD3TNlMQ1vpp0A2s=; b=iHi7/ZyjIJ94bnASo9mW9P/2Yi7LY
        9k8f9YyXBemrn+lA7T7S+LMou2p/LZWSYx6bxQkX5jPqg8dO1EpRZtJQt/Zpxum3
        3olELx2BzE1LTzNq88SvS51Hrj/4YUP12khzGq2vbyBAZdjdQis1KzHk6WTnth2J
        3PLj3wTdPyKnadFNnc2PeWjt9xXXWlf4nlix2pwIAs8JAgkontTuj0xMNrn9Ip/2
        F4c4JAV+5QLbqMza7CugH4NUCCmPfKOPG1jXSihh6/SFDyV2Ws4uu8O3wW96EoWF
        IM2m/IxGWF06z3mjrfkIbNG51sJ+IMP8mffbeB4Hh6wbWGp831k2NdZ0Q==
X-ME-Sender: <xms:E6BlZUQ60tR7G8Brar3yUbBdIYcwesk-yBSoXCWUx5ECaasE2pLnzA>
    <xme:E6BlZRwDgnRLq8-e1Gvun8d0oJl86ozQaCNo6Z6SiG4RTBmjLcaJ_zGvBrDIjhGfe
    KFGEbnVCNtx-g>
X-ME-Received: <xmr:E6BlZR3TVod4LV0CVKLKiHGcVSTrmfx-sji46G0iOznL-OBcGGGqIgj8_QeMhnsQpQd2UWHEr7r-f4pFYehDVHMtHob5l2MsEkPDEnWtdVdpGCoKoJTbk6M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeivddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:E6BlZYBdQ6spjtOY9hSIW9jN9rWpCIlJovQy2SDL3d5PvQp5iqapiw>
    <xmx:E6BlZdiT89-sLEiOlsRdT2c_aHc_II8tUqhDiE1ud_EHRMhnfxtDqA>
    <xmx:E6BlZUqfkE1LjsypWdeqMaOHBFBMHq3bUWk8BHl7l14mkScDcAAtDw>
    <xmx:E6BlZeW8hMuyoVUgwLQ4eut0lBKX_YLPVnprxcKOeEfe48spLjbVVA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 03:08:51 -0500 (EST)
Date:   Tue, 28 Nov 2023 08:08:48 +0000
From:   Greg KH <greg@kroah.com>
To:     Malcolm Hart <malcolm@5harts.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Sven Frotscher <sven.frotscher@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sound: soc: amd: yc: Fix non-functional mic on ASUS
 E1504FA
Message-ID: <2023112834-luckless-deport-2fce@gregkh>
References: <875y1nt1bx.fsf@5harts.com>
 <871qcbszh0.fsf@5harts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qcbszh0.fsf@5harts.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 08:36:00PM +0000, Malcolm Hart wrote:
> 
> 
> This patch adds ASUSTeK COMPUTER INC  "E1504FA" to the quirks file acp6x-mach.c
> to enable microphone array on ASUS Vivobook GO 15.
> I have this laptop and can confirm that the patch succeeds in enabling the
> microphone array.
> 
> Signed-off-by: Malcolm Hart <malcolm@5harts.com>
> Cc: stable@vger.kernel.org
> ---
>  sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
> index 15a864dcd7bd3a..3babb17a56bb55 100644
> --- a/sound/soc/amd/yc/acp6x-mach.c
> +++ b/sound/soc/amd/yc/acp6x-mach.c
> @@ -283,6 +283,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
>  		}
>  	},
> +	{
> +		.driver_data = &acp6x_card,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "E1504FA"),
> +		}
> +	},
>  	{
>  		.driver_data = &acp6x_card,
>  		.matches = {
> 
> 

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

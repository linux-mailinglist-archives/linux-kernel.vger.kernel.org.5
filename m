Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55D97F929F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 13:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjKZMlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 07:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZMlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 07:41:16 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69FCC4;
        Sun, 26 Nov 2023 04:41:20 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9881E5C0109;
        Sun, 26 Nov 2023 07:41:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 26 Nov 2023 07:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keeping.me.uk;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1701002478; x=
        1701088878; bh=S1b5+mAkwAi6TXjxtxbvUviQ6QcnSGD3Zyf3iG37d1M=; b=u
        F/fdLRTW+4HwSPx/b5jyLsLEOM58wxu8rNjvtNxGQiBWUC3B3qRzSYl4deGMWN8Y
        Fc0goSeabqJUI2uT1VJGj7B+70Uiv5YyU+dNLTwdAQS0L1P282vQBNbJCRkPgYUF
        1s8hJeFJy9jDJfARQLWCeCb6bOoCRHr95INxfd+qvRoKhtLqQZ077VTYknmD07Mj
        W9ZhliL6gY0M4bSIPvkZd2VLUjhKOGkgCzFB+12eglYxM8qjbF9zmTwx7D6v8mJT
        EdbXr/JKYnTTE6gYehXKSDWEH3aKAjWeb6CGNJmj/UARl8I7wNNICpRN5kcH5huU
        vb2cW89auJzPB3+6lrgng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701002478; x=1701088878; bh=S1b5+mAkwAi6T
        XjxtxbvUviQ6QcnSGD3Zyf3iG37d1M=; b=AUsm9mqsOyYRzKqPb5vaJZ+xekPy2
        j1tNNld6lEaqCjocNwmWBL4pkNFHfrprtRjIzJD7qofwNIOMErsbpqV0QR2ykoVS
        lACihb1VmZ0ulUXD/nZE8d5Yq/OFVx31NwX1PfKpA07g4XhtMApta8F1g5HAxzfl
        TMzuRgpd1Mxe7UhtILCaOGpvm0kpNYhCxyi9gaI97JSYDbU77+MLpJ/fwA+uzwi4
        AGxda7yNm/uZuXzmTuRJnOn4i52QaHiW4rBArF+YX9pPbOvx571khDde2hQZYeT7
        kLE5hJY/xUEKVL91a847Ps9fBCHM3dk59PMNegkSi3AprBAghURX1KxOg==
X-ME-Sender: <xms:7TxjZfnsy-fJjKi1ohn-c68jP7AZRlv5nGR7csIYQkfgZlJY_yaRPg>
    <xme:7TxjZS24PZTa9VhRB6P066L5Mt02Lo09bPl2mKALixds3M7ksSak1apeb7HR-mVtV
    HHBdlT8RqDDFSgm4bs>
X-ME-Received: <xmr:7TxjZVoxnFjsmrQ7JB_ydbR6dMUcnicA2gaqVOc7nwYhO6aIVXiRf70U2m6nxX84pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehledggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfhohhhn
    ucfmvggvphhinhhguceojhhohhhnsehkvggvphhinhhgrdhmvgdruhhkqeenucggtffrrg
    htthgvrhhnpeehvdehfeefleettedvvdffhfeihfdvvddtvdelteetffeitdeijeduieek
    tdetleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hjohhhnheskhgvvghpihhnghdrmhgvrdhukh
X-ME-Proxy: <xmx:7TxjZXlLs96VlfWMnOyqWT042eI5sxPJNBZ3Q3yqQHyut0Mxnelk0g>
    <xmx:7TxjZd2c9aXrpOga33bn08sEwhY8HHnIZ0ZGlkENRUcg3AIQpsgcQQ>
    <xmx:7TxjZWv0JBcyJEZInnbULZJxVcgXk8Ul0I2hkAdaV8ALNxsEic1srg>
    <xmx:7jxjZXqC4t7Qy3Y2QX1zqSxPblN1OQQxk72DazyQkSASDtcQNNCmHA>
Feedback-ID: ic4e149f5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Nov 2023 07:41:16 -0500 (EST)
Date:   Sun, 26 Nov 2023 12:41:15 +0000
From:   John Keeping <john@keeping.me.uk>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     gregkh@linuxfoundation.org, quic_ugoswami@quicinc.com,
        brauner@kernel.org, jlayton@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, erosca@de.adit-jv.com
Subject: Re: [PATCH] usb: gadget: f_fs: Add the missing get_alt callback
Message-ID: <ZWM864zH3M8W9B2f@keeping.me.uk>
References: <20231124164435.74727-1-hgajjar@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124164435.74727-1-hgajjar@de.adit-jv.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 05:44:35PM +0100, Hardik Gajjar wrote:
> Some USB OTG hubs have multiple alternate configurations to offer,
> such as one for Carplay and another for Carlife.
> 
> This patch implements and sets the get_alt callback to retrieve the
> currently used alternate setting. The new function allows dynamic
> retrieval of the current alternate setting for a specific interface. The
> current alternate setting values are stored in the 'cur_alt' array
> within the 'ffs_function' structure.

Doesn't the alt setting need to be forwarded to userspace?

What happens if the available endpoints change - doesn't that mean the
available endpoint files change?

It's not sufficient to just blindly accept any alt setting and assume it
will work, that may be the case in one specific constrained scenario,
but it's not true in general.  At the very least we must not accept an
alt setting that is not defined in the descriptors.

> Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> ---
>  drivers/usb/gadget/function/f_fs.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index efe3e3b85769..37c47c11f57a 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -75,6 +75,7 @@ struct ffs_function {
>  	short				*interfaces_nums;
>  
>  	struct usb_function		function;
> +	int				cur_alt[MAX_CONFIG_INTERFACES];
>  };
>  
>  
> @@ -98,6 +99,7 @@ static int __must_check ffs_func_eps_enable(struct ffs_function *func);
>  static int ffs_func_bind(struct usb_configuration *,
>  			 struct usb_function *);
>  static int ffs_func_set_alt(struct usb_function *, unsigned, unsigned);
> +static int ffs_func_get_alt(struct usb_function *f, unsigned int intf);
>  static void ffs_func_disable(struct usb_function *);
>  static int ffs_func_setup(struct usb_function *,
>  			  const struct usb_ctrlrequest *);
> @@ -3232,6 +3234,15 @@ static void ffs_reset_work(struct work_struct *work)
>  	ffs_data_reset(ffs);
>  }
>  
> +static int ffs_func_get_alt(struct usb_function *f,
> +			    unsigned int interface)
> +{
> +	struct ffs_function *func = ffs_func_from_usb(f);
> +	int intf = ffs_func_revmap_intf(func, interface);
> +
> +	return (intf < 0) ? intf : func->cur_alt[interface];
> +}
> +
>  static int ffs_func_set_alt(struct usb_function *f,
>  			    unsigned interface, unsigned alt)
>  {
> @@ -3266,8 +3277,10 @@ static int ffs_func_set_alt(struct usb_function *f,
>  
>  	ffs->func = func;
>  	ret = ffs_func_eps_enable(func);
> -	if (ret >= 0)
> +	if (ret >= 0) {
>  		ffs_event_add(ffs, FUNCTIONFS_ENABLE);
> +		func->cur_alt[interface] = alt;
> +	}
>  	return ret;
>  }
>  
> @@ -3574,6 +3587,7 @@ static struct usb_function *ffs_alloc(struct usb_function_instance *fi)
>  	func->function.bind    = ffs_func_bind;
>  	func->function.unbind  = ffs_func_unbind;
>  	func->function.set_alt = ffs_func_set_alt;
> +	func->function.get_alt = ffs_func_get_alt;
>  	func->function.disable = ffs_func_disable;
>  	func->function.setup   = ffs_func_setup;
>  	func->function.req_match = ffs_func_req_match;
> -- 
> 2.17.1
> 

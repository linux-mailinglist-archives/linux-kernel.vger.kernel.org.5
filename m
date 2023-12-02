Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957EC801D65
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 15:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjLBOvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 09:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjLBOvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 09:51:17 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A383AE6;
        Sat,  2 Dec 2023 06:51:21 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 233C45C0193;
        Sat,  2 Dec 2023 09:51:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 02 Dec 2023 09:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keeping.me.uk;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1701528679; x=
        1701615079; bh=YMgoHxjqqZ9F14ZU/o+RYJbU3jJCBdqlDOft1tYkRxE=; b=k
        DYOQ1c+kOQYJKQapQ784GkdEie4IcFQjGlaDPtuZZISuIdqQNQNMZ9WF8CMcBbML
        oEQXUx3ET0Mi+4NB3sYYzCLcTahL3yWxoPW4/tu2MFXV7p8ClaxUPP9uTOF+SzOj
        NtAWX0qcZXZnYAouayY0Qp7YSQ+jNwqgccevFApT3X/oSu2zyNWUcU8Rx2LyB4yS
        FGZsRjj+4tc024tW+iTznu/9u1/sH5HdFvut8FOAi301LqKNlNFYyNvVsnBfbaMe
        f48lkTKvZ4pMHeT9DoNUidWVpLSeanPh5dG3oIfSkkwdDhMnAwP3lFTTic8f+pTp
        fObM1pNYl2ttdC7t+m4zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701528679; x=1701615079; bh=YMgoHxjqqZ9F1
        4ZU/o+RYJbU3jJCBdqlDOft1tYkRxE=; b=2yDjmJsz7bdX/AaPUC2ziNcDVFwbR
        ZsV69gO7SfK9s14iNe8L7+1dCdJc74wiLGNjHUvBys/fH9lPL9/hC+GNwPqI/EVJ
        i2SzBLOqLFrBK2ryW+NFT01LrViKrfOiLqepumuOs9gABZaW2cZuzhQe40Ewb7Ht
        0aBciwEDYhZnvzoE0lDXOMMI97j8emxFPyAqQU49nF6XpN9XxQzO1OINkwZ7SSCZ
        MY8QFPYzyJ84RN1zf9I93xycmX/+2sLmMmZ4KCT2I1XRil6dSuZX5T5g7o5fp4CQ
        6rM5NXqBEGIdyjtcWEbA4Jh22PJ/lYaaEwpz+3QCFMOIiodPvoPeXsghQ==
X-ME-Sender: <xms:ZkRrZdI9wnbZa_JkcvbUUNlQ3fsa5R4kl-yDz0ZKvr92x_grfyFKeQ>
    <xme:ZkRrZZIazXXyC2nC9XuSn5maCiRewRTPepb7Edb3_xOqo2S7JqlgD_T2AlpBpSSxm
    uIkOUGURYqAV8dNPVw>
X-ME-Received: <xmr:ZkRrZVvUK4DNFgRYFcaE0pq9VYLlXLJ9J-QXm_IxpL_Epz7-8tPkCs9f7U9HLBbNJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejuddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfhohhhn
    ucfmvggvphhinhhguceojhhohhhnsehkvggvphhinhhgrdhmvgdruhhkqeenucggtffrrg
    htthgvrhhnpeefgefgffeuveejhfdvfeduhefghedthfetgfetueeihfeuvefffefftdek
    leehveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhohhhnsehkvggvphhinhhgrdhmvgdr
    uhhk
X-ME-Proxy: <xmx:ZkRrZeaYOubrzsX5HAFrVA_5HyOQ7Grls0-XLSSkCjg5AtGM2coDoQ>
    <xmx:ZkRrZUaCnVBab983Cl1GLdHGtB2hY3OzsrcT8xXtxA_ATlgDSfP1ZA>
    <xmx:ZkRrZSD4iSP6-eOVh2iv-TP_UZp3nlakrpxiCQUWtCLbfR85bWZhlQ>
    <xmx:Z0RrZZO7Yhp0LrBQ7p23yCxs8EFqZwtiBwTZgqg13rpQWZ5TUBu1tg>
Feedback-ID: ic4e149f5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Dec 2023 09:51:17 -0500 (EST)
Date:   Sat, 2 Dec 2023 14:51:15 +0000
From:   John Keeping <john@keeping.me.uk>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        erosca@de.adit-jv.com, jlayton@kernel.org, brauner@kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_fs: Add the missing get_alt callback
Message-ID: <ZWtEY0oKS-PcaJ0c@keeping.me.uk>
References: <20231201145234.97452-1-hgajjar@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201145234.97452-1-hgajjar@de.adit-jv.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 03:52:34PM +0100, Hardik Gajjar wrote:
> The Apple CarLife iAP gadget has a descriptor with two alternate
> settings. The host sends the set_alt request to configure alt_setting
> 0 or 1, and this is verified by the subsequent get_alt request.
> 
> This patch implements and sets the get_alt callback. Without the
> get_alt callback, composite.c abruptly concludes the
> USB_REQ_GET/SET_INTERFACE request, assuming only one alt setting
> for the endpoint.
> 
> Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> ---
> changes since version 1:
> 	- improve commit message to indicate why the get_alt callback
> 	  is necessary
> 	- Link to v1 - https://lore.kernel.org/all/20231124164435.74727-1-hgajjar@de.adit-jv.com/

This doesn't address my questions about v1 - I understand what the
get_alt callback does, but I don't see how this is sufficient to make it
work in all circumstances.

To use your example of having settings 0 and 1, what happens if the host
requests setting 2?

Without this patch, when .get_alt is not set, composite_setup() will
reject all settings except 0 so there is no need for ffs_func_set_alt()
to filter its input.  But if .get_alt is set, don't we need to filter
for valid input here?

I also do not see how it is acceptable to change alt setting without
notifying userspace in the general case.  If it works for your specific
use case, that is one thing, but nothing requires the endpoint setup to
be the same across alt settings and the userspace component likely needs
to know if the setup changes.

For examples, look at afunc_set_alt() or tcm_set_alt() in other gadget
functions.  If either of these were to be implemented in userspace then
simply accepting the alt setting is not enough - there are changes that
must be made to the functionality.

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

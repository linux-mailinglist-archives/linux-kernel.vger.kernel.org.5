Return-Path: <linux-kernel+bounces-16570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2881B824065
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417C71C21B17
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E43F210EF;
	Thu,  4 Jan 2024 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=keeping.me.uk header.i=@keeping.me.uk header.b="FfQmoZyl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="INFmLjkA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74090210F0;
	Thu,  4 Jan 2024 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=keeping.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=keeping.me.uk
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 5ABED5C01F5;
	Thu,  4 Jan 2024 06:16:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 04 Jan 2024 06:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keeping.me.uk;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1704367003; x=
	1704453403; bh=0/H8gDbjcd7i679pGuDpTSney0Ce5shRHqNmWl3yTjI=; b=F
	fQmoZylsgInIqnhSWStOaj6XKyhaW6vswUQ//HswEWRv8UH1ybab3YLjkPuQhtGW
	Xp3ikc7tdxwcc9YmV9G5sVsN90Clf3KAEuSrgWLxWL9z/Zxw1ZWL6HwiVb4nfXVa
	BtlWlyi5qYpIgsB7t3l9uoVJDfBvflmOPmwBM2W4VzrtSp4akny6FzXDqUs9WQOJ
	inVsDo51RZbJzrhanQtRnvKWoL68EfYqE1q6dblbKk5kGq1fgOregWepc1jUYx52
	jWEFnWZChrnuVJoWmm/bbYBZ8OFhvkqFkJ3QIpumibAsnSbpiDAwGjke1MtXxLb+
	9anUp3Yz3czji8qZMx2wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704367003; x=1704453403; bh=0/H8gDbjcd7i679pGuDpTSney0Ce
	5shRHqNmWl3yTjI=; b=INFmLjkAic5Ypza0HuOE6oEWszBxv3EMn73d4zORBoY6
	AA15Jav42j8N0baBkzMjQrTG61SxcjHKaDLIZNgAEMNueuoQMdQAuG/glBMNDqY7
	uPn94fhjpaoyIY3Mikuy/LRx2QKJc52k3n1b9oAAxviSAN10z6PU6MZDcQZceFAc
	T8rN9hpRDUFfeJmSd5oIpzjDkXaCR6j+jpmq7OeFI037qvblpBUyQJ5SUdw89q+i
	Hxoe4aG/MT1DQHJ0j9YfPKB9HknpY2/pupniBRbbW4QmrWIesEbZT+50NlDpw23b
	iDtSQl9cRq01r3IsIEWZaYllmDDqTbK7bZu3XG0yDQ==
X-ME-Sender: <xms:mpOWZXQlRZVcY8-dH-4ggnFsiEU61Syh-8B_guTCvxXdlHC2iqrxvQ>
    <xme:mpOWZYxG_RQ1i1BE_qvuqkJb1X9b24H6mcBn9-EQICZf_ycELczMSa8tUH5BR9iug
    EdurauMlpurnoyA7sQ>
X-ME-Received: <xmr:mpOWZc0pqeUCpwk1Bk6QccvpLaAUjsLb934JEKG9GD3Ry9eBCbMFz8dx7F2IFAVzSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfhohhhn
    ucfmvggvphhinhhguceojhhohhhnsehkvggvphhinhhgrdhmvgdruhhkqeenucggtffrrg
    htthgvrhhnpeefgefgffeuveejhfdvfeduhefghedthfetgfetueeihfeuvefffefftdek
    leehveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhohhhnsehkvggvphhinhhgrdhmvgdr
    uhhk
X-ME-Proxy: <xmx:mpOWZXBmdFhVoZdzBqPqgJ3TC5HU3dDmDXfgC8ww8WJXUj6EWsD0hw>
    <xmx:mpOWZQgCHAntL572WYLALBC6FNDHtV1nCUrmGS7cFCAlitbev1Jifg>
    <xmx:mpOWZbqpBlvjkICmMFn6jHZ8c9SbtSUrgB38e-b_oiZLdZry0elj-A>
    <xmx:m5OWZbXP1pTZ9DkDKgBzNmYqFbW4GUYHQK9C49lO_ql8kRJkwpz-fw>
Feedback-ID: ic4e149f5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 06:16:41 -0500 (EST)
Date: Thu, 4 Jan 2024 11:16:39 +0000
From: John Keeping <john@keeping.me.uk>
To: Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	erosca@de.adit-jv.com, jlayton@kernel.org, brauner@kernel.org
Subject: Re: [PATCH v3] usb: gadget: f_fs: Add the missing get_alt callback
Message-ID: <ZZaTl3mqeCY5xD_d@keeping.me.uk>
References: <20240102123419.13491-1-hgajjar@de.adit-jv.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102123419.13491-1-hgajjar@de.adit-jv.com>

On Tue, Jan 02, 2024 at 01:34:19PM +0100, Hardik Gajjar wrote:
> The Apple CarLife iAP gadget has a descriptor with two alternate
> settings. The host sends the set_alt request to configure alt_setting
> 0 or 1, and this is verified by the subsequent get_alt request.
> 
> This patch implements and sets the get_alt callback. Without the
> get_alt callback, composite.c abruptly concludes the
> USB_REQ_GET/SET_INTERFACE request, assuming only one alt setting
> for the endpoint.

I still do not understand what happens if different alternate settings
have different endpoints.

Changing the alternate calls ffs_func_eps_disable() /
ffs_func_eps_enable() but those functions affect _all_ the configured
endpoints.  If f_fs moves to support multiple alternate settings, then
isn't there a problem with that behaviour?  Don't we need
ffs_func_eps_enable() to enable only the endpoints used by the current
alternate setting?

The commit message does not explain why this patch can be as simple as
it is and why there is no need to address any wider issues that there
seem to be from supporting multiple alternate settings.

> Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> ---
> changes since version 1:
> 	- improve commit message to indicate why the get_alt callback
> 	  is necessary
> 	- Link to v1 - https://lore.kernel.org/all/20231124164435.74727-1-hgajjar@de.adit-jv.com/
> 
> changes since version 2:
> 	- Add the limit to allow set up to 2 alt settings.
> 	- Link to v2 - https://lore.kernel.org/all/20231201145234.97452-1-hgajjar@de.adit-jv.com/
> ---
>  drivers/usb/gadget/function/f_fs.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index efe3e3b85769..22200d618184 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -42,6 +42,7 @@
>  #include "configfs.h"
>  
>  #define FUNCTIONFS_MAGIC	0xa647361 /* Chosen by a honest dice roll ;) */
> +#define MAX_ALT_SETTINGS	2		  /* Allow up to 2 alt settings to be set. */
>  
>  /* Reference counter handling */
>  static void ffs_data_get(struct ffs_data *ffs);
> @@ -75,6 +76,7 @@ struct ffs_function {
>  	short				*interfaces_nums;
>  
>  	struct usb_function		function;
> +	int				cur_alt[MAX_CONFIG_INTERFACES];
>  };
>  
>  
> @@ -98,6 +100,7 @@ static int __must_check ffs_func_eps_enable(struct ffs_function *func);
>  static int ffs_func_bind(struct usb_configuration *,
>  			 struct usb_function *);
>  static int ffs_func_set_alt(struct usb_function *, unsigned, unsigned);
> +static int ffs_func_get_alt(struct usb_function *f, unsigned int intf);
>  static void ffs_func_disable(struct usb_function *);
>  static int ffs_func_setup(struct usb_function *,
>  			  const struct usb_ctrlrequest *);
> @@ -3232,6 +3235,15 @@ static void ffs_reset_work(struct work_struct *work)
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
> @@ -3239,6 +3251,9 @@ static int ffs_func_set_alt(struct usb_function *f,
>  	struct ffs_data *ffs = func->ffs;
>  	int ret = 0, intf;
>  
> +	if (alt > MAX_ALT_SETTINGS)
> +		return -EINVAL;
> +
>  	if (alt != (unsigned)-1) {
>  		intf = ffs_func_revmap_intf(func, interface);
>  		if (intf < 0)
> @@ -3266,8 +3281,10 @@ static int ffs_func_set_alt(struct usb_function *f,
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
> @@ -3574,6 +3591,7 @@ static struct usb_function *ffs_alloc(struct usb_function_instance *fi)
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


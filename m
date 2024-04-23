Return-Path: <linux-kernel+bounces-155486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEF98AEB42
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA481C21A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5218E13C9C7;
	Tue, 23 Apr 2024 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="ePgXwi/o";
	dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="T3+/EzQ/"
Received: from smtp.ivitera.com (smtp.ivitera.com [88.101.85.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A760C17BA8;
	Tue, 23 Apr 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.101.85.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886729; cv=none; b=YNeXDGc37VUq9fByXNVRf/Qk+0PA0WFhRE7Qs3SjZu5nAoKdEA/mdJTnc9NBisWgdomEFc3Mp34dGpT0R+q+O9lglRf2GYG9f20+vmw9FU2tnNsjY1IYDI0i0ZaJjR+knikzwFiuMFgGN1abyFS+SAyPd+lzf1Xo3zVSdJmmV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886729; c=relaxed/simple;
	bh=754LNpWY3p/VinRZDlx6gnvMkrj403nIYbqQ+FtzmKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nx4CU4gyPVRbjjdmEivR13poZUzb8WBuH5YUdANxTR4HnsguaLNtmepf2Y3s0afi0w/TkP4+aKZB+4vSp0/XJYW33ZRaIUfQWEA28HTsWBWjBU3l4rsHGfQ0NbPgvc0TZbH5PjkjJFSgbgxNHOxPLkpHmf53UnQOddKuZUc72UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ivitera.com; spf=pass smtp.mailfrom=ivitera.com; dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b=ePgXwi/o; dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b=T3+/EzQ/; arc=none smtp.client-ip=88.101.85.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ivitera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ivitera.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.ivitera.com (Postfix) with ESMTP id 6958616F320;
	Tue, 23 Apr 2024 17:38:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
	t=1713886717; bh=754LNpWY3p/VinRZDlx6gnvMkrj403nIYbqQ+FtzmKY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ePgXwi/oENFskoUGY99HYqyvZpqKwcZvJ1KN7Twmvd2XQHRzgstBwSgnmFqtD2TuE
	 vkpTtbKxR/yDN3ZQt96m8rZm4qUyzvpZhgTkhFj/UvqiKqtbNpPmKJlNGupU0yt835
	 sMVIZ96x7zQrhuZSk4s+ISbhMUnwoZk9wYXVWZB4=
Received: from smtp.ivitera.com ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kkTkIymvUJHu; Tue, 23 Apr 2024 17:38:36 +0200 (CEST)
Received: from [192.168.105.22] (dustin.pilsfree.net [81.201.58.138])
	(Authenticated sender: pavel)
	by smtp.ivitera.com (Postfix) with ESMTPSA id 931C016F701;
	Tue, 23 Apr 2024 17:38:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
	t=1713886716; bh=754LNpWY3p/VinRZDlx6gnvMkrj403nIYbqQ+FtzmKY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T3+/EzQ/AfNS3Vi4aq4AeU/DlFGZim9DICF9JPUmslM1XgGeBcpcilkjAJi52XY0J
	 xmTgElYLDhCDPPSTLIrkDBAMpOWqb17x4wavG5wxbDQGMTa9NWU8LFrdOIB2gco91m
	 uIga6jEGCoqWRDsp4q8xxwqr16X7VDcP+9cZBQCY=
Message-ID: <c9928edb-8b2d-1948-40b8-c16e34cea3e2@ivitera.com>
Date: Tue, 23 Apr 2024 17:38:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] usb: gadget: f_uac2: Expose all string descriptors
 through configfs.
Content-Language: en-US
To: Chris Wulff <Chris.Wulff@biamp.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Gruber <jimmyjgruber@gmail.com>, Lee Jones <lee@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
References: <CO1PR17MB54195BE778868AFDFE2DCB36E1112@CO1PR17MB5419.namprd17.prod.outlook.com>
From: Pavel Hofman <pavel.hofman@ivitera.com>
In-Reply-To: <CO1PR17MB54195BE778868AFDFE2DCB36E1112@CO1PR17MB5419.namprd17.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 23. 04. 24 16:09, Chris Wulff wrote:
> This makes all string descriptors configurable for the UAC2 gadget
> so the user can configure names of terminals/controls/alt modes.
> 
> Signed-off-by: Chris Wulff <chris.wulff@biamp.com>
> ---
> v2: Improved naming of parameters to be mode user friendly. Added documentation.
> v1: https://lore.kernel.org/linux-usb/CO1PR17MB5419B50F94A0014647542931E10D2@CO1PR17MB5419.namprd17.prod.outlook.com/
> 
>  .../ABI/testing/configfs-usb-gadget-uac2      | 13 +++
>  Documentation/usb/gadget-testing.rst          | 13 +++
>  drivers/usb/gadget/function/f_uac2.c          | 80 +++++++++++++++----
>  drivers/usb/gadget/function/u_uac2.h          | 17 +++-
>  4 files changed, 105 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac2 b/Documentation/ABI/testing/configfs-usb-gadget-uac2
> index a2bf4fd82a5b..250f8eeb8eab 100644
> --- a/Documentation/ABI/testing/configfs-usb-gadget-uac2
> +++ b/Documentation/ABI/testing/configfs-usb-gadget-uac2
> @@ -35,6 +35,19 @@ Description:
>  		req_number		the number of pre-allocated requests
>  					for both capture and playback
>  		function_name		name of the interface
> +		if_ctrl_name		topology control name
> +		clksrc_in_name		input clock name
> +		clksrc_out_name		output clock name
> +		p_it_name		playback input terminal name
> +		p_ot_name		playback output terminal name
> +		p_fu_name		playback function unit name
> +		p_alt0_name		playback alt mode 0 name
> +		p_alt1_name		playback alt mode 1 name

Nacked-by: Pavel Hofman <pavel.hofman@ivitera.com>

I am not sure adding a numbered parameter for every additional alt mode
is a way to go for the future. I am not that much concerned about UAC1,
but IMO (at least) in UAC2 the configuration method should be flexible
for more alt setttings. I can see use cases with many more altsettings.

My proposal for adding more alt settings
https://lore.kernel.org/linux-usb/35be4668-58d3-894a-72cf-de1afaacae45@ivitera.com/
suggested using lists to existing parameters where each item would
correspond to the alt setting of the same index (+1). That would allow
using more altsettings easily, without having to add parameters to the
source code and adding configfs params. I received no feedback. I do not
push the param list proposal, but I am convinced an acceptable solution
should be discussed thoroughly by the UAC2 gadget stakeholders.

I am afraid that once p_alt1_name/c_alt1_name params are accepted, there
will be no way back because subsequent removal of configfs params could
be viewed as a regression for users.

Thanks a lot for considering,

Pavel.

> +		c_it_name		capture input terminal name
> +		c_ot_name		capture output terminal name
> +		c_fu_name		capture functional unit name
> +		c_alt0_name		capture alt mode 0 name
> +		c_alt1_name		capture alt mode 1 name
>  		c_terminal_type		code of the capture terminal type
>  		p_terminal_type		code of the playback terminal type>  		=====================	=======================================
> diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
> index b086c7ab72f0..1a11d3b3bb88 100644
> --- a/Documentation/usb/gadget-testing.rst
> +++ b/Documentation/usb/gadget-testing.rst
> @@ -765,6 +765,19 @@ The uac2 function provides these attributes in its function directory:
>  	req_number       the number of pre-allocated request for both capture
>  	                 and playback
>  	function_name    name of the interface
> +	if_ctrl_name     topology control name
> +	clksrc_in_name   input clock name
> +	clksrc_out_name  output clock name
> +	p_it_name        playback input terminal name
> +	p_ot_name        playback output terminal name
> +	p_fu_name        playback function unit name
> +	p_alt0_name      playback alt mode 0 name
> +	p_alt1_name      playback alt mode 1 name
> +	c_it_name        capture input terminal name
> +	c_ot_name        capture output terminal name
> +	c_fu_name        capture functional unit name
> +	c_alt0_name      capture alt mode 0 name
> +	c_alt1_name      capture alt mode 1 name
>  	c_terminal_type  code of the capture terminal type
>  	p_terminal_type  code of the playback terminal type
>  	================ ====================================================
> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
> index 383f6854cfec..5ca7ecdb6e60 100644
> --- a/drivers/usb/gadget/function/f_uac2.c
> +++ b/drivers/usb/gadget/function/f_uac2.c
> @@ -104,25 +104,10 @@ enum {
>  	STR_AS_OUT_ALT1,
>  	STR_AS_IN_ALT0,
>  	STR_AS_IN_ALT1,
> +	NUM_STR_DESCRIPTORS,
>  };
>  
> -static struct usb_string strings_fn[] = {
> -	/* [STR_ASSOC].s = DYNAMIC, */
> -	[STR_IF_CTRL].s = "Topology Control",
> -	[STR_CLKSRC_IN].s = "Input Clock",
> -	[STR_CLKSRC_OUT].s = "Output Clock",
> -	[STR_USB_IT].s = "USBH Out",
> -	[STR_IO_IT].s = "USBD Out",
> -	[STR_USB_OT].s = "USBH In",
> -	[STR_IO_OT].s = "USBD In",
> -	[STR_FU_IN].s = "Capture Volume",
> -	[STR_FU_OUT].s = "Playback Volume",
> -	[STR_AS_OUT_ALT0].s = "Playback Inactive",
> -	[STR_AS_OUT_ALT1].s = "Playback Active",
> -	[STR_AS_IN_ALT0].s = "Capture Inactive",
> -	[STR_AS_IN_ALT1].s = "Capture Active",
> -	{ },
> -};
> +static struct usb_string strings_fn[NUM_STR_DESCRIPTORS + 1] = {};
>  
>  static const char *const speed_names[] = {
>  	[USB_SPEED_UNKNOWN] = "UNKNOWN",
> @@ -1049,6 +1034,21 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
>  		return ret;
>  
>  	strings_fn[STR_ASSOC].s = uac2_opts->function_name;
> +	strings_fn[STR_IF_CTRL].s = uac2_opts->if_ctrl_name;
> +	strings_fn[STR_CLKSRC_IN].s = uac2_opts->clksrc_in_name;
> +	strings_fn[STR_CLKSRC_OUT].s = uac2_opts->clksrc_out_name;
> +
> +	strings_fn[STR_USB_IT].s = uac2_opts->p_it_name;
> +	strings_fn[STR_IO_OT].s = uac2_opts->p_ot_name;
> +	strings_fn[STR_FU_OUT].s = uac2_opts->p_fu_name;
> +	strings_fn[STR_AS_OUT_ALT0].s = uac2_opts->p_alt0_name;
> +	strings_fn[STR_AS_OUT_ALT1].s = uac2_opts->p_alt1_name;
> +
> +	strings_fn[STR_IO_IT].s = uac2_opts->c_it_name;
> +	strings_fn[STR_USB_OT].s = uac2_opts->c_ot_name;
> +	strings_fn[STR_FU_IN].s = uac2_opts->c_fu_name;
> +	strings_fn[STR_AS_IN_ALT0].s = uac2_opts->c_alt0_name;
> +	strings_fn[STR_AS_IN_ALT1].s = uac2_opts->c_alt1_name;
>  
>  	us = usb_gstrings_attach(cdev, fn_strings, ARRAY_SIZE(strings_fn));
>  	if (IS_ERR(us))
> @@ -2097,10 +2097,26 @@ UAC2_ATTRIBUTE(s16, c_volume_max);
>  UAC2_ATTRIBUTE(s16, c_volume_res);
>  UAC2_ATTRIBUTE(u32, fb_max);
>  UAC2_ATTRIBUTE_STRING(function_name);
> +UAC2_ATTRIBUTE_STRING(if_ctrl_name);
> +UAC2_ATTRIBUTE_STRING(clksrc_in_name);
> +UAC2_ATTRIBUTE_STRING(clksrc_out_name);
> +
> +UAC2_ATTRIBUTE_STRING(p_it_name);
> +UAC2_ATTRIBUTE_STRING(p_ot_name);
> +UAC2_ATTRIBUTE_STRING(p_fu_name);
> +UAC2_ATTRIBUTE_STRING(p_alt0_name);
> +UAC2_ATTRIBUTE_STRING(p_alt1_name);
> +
> +UAC2_ATTRIBUTE_STRING(c_it_name);
> +UAC2_ATTRIBUTE_STRING(c_ot_name);
> +UAC2_ATTRIBUTE_STRING(c_fu_name);
> +UAC2_ATTRIBUTE_STRING(c_alt0_name);
> +UAC2_ATTRIBUTE_STRING(c_alt1_name);
>  
>  UAC2_ATTRIBUTE(s16, p_terminal_type);
>  UAC2_ATTRIBUTE(s16, c_terminal_type);
>  
> +
>  static struct configfs_attribute *f_uac2_attrs[] = {
>  	&f_uac2_opts_attr_p_chmask,
>  	&f_uac2_opts_attr_p_srate,
> @@ -2127,6 +2143,21 @@ static struct configfs_attribute *f_uac2_attrs[] = {
>  	&f_uac2_opts_attr_c_volume_res,
>  
>  	&f_uac2_opts_attr_function_name,
> +	&f_uac2_opts_attr_if_ctrl_name,
> +	&f_uac2_opts_attr_clksrc_in_name,
> +	&f_uac2_opts_attr_clksrc_out_name,
> +
> +	&f_uac2_opts_attr_p_it_name,
> +	&f_uac2_opts_attr_p_ot_name,
> +	&f_uac2_opts_attr_p_fu_name,
> +	&f_uac2_opts_attr_p_alt0_name,
> +	&f_uac2_opts_attr_p_alt1_name,
> +
> +	&f_uac2_opts_attr_c_it_name,
> +	&f_uac2_opts_attr_c_ot_name,
> +	&f_uac2_opts_attr_c_fu_name,
> +	&f_uac2_opts_attr_c_alt0_name,
> +	&f_uac2_opts_attr_c_alt1_name,
>  
>  	&f_uac2_opts_attr_p_terminal_type,
>  	&f_uac2_opts_attr_c_terminal_type,
> @@ -2188,6 +2219,21 @@ static struct usb_function_instance *afunc_alloc_inst(void)
>  	opts->fb_max = FBACK_FAST_MAX;
>  
>  	scnprintf(opts->function_name, sizeof(opts->function_name), "Source/Sink");
> +	scnprintf(opts->if_ctrl_name, sizeof(opts->if_ctrl_name), "Topology Control");
> +	scnprintf(opts->clksrc_in_name, sizeof(opts->clksrc_in_name), "Input Clock");
> +	scnprintf(opts->clksrc_out_name, sizeof(opts->clksrc_out_name), "Output Clock");
> +
> +	scnprintf(opts->p_it_name, sizeof(opts->p_it_name), "USBH Out");
> +	scnprintf(opts->p_ot_name, sizeof(opts->p_ot_name), "USBD In");
> +	scnprintf(opts->p_fu_name, sizeof(opts->p_fu_name), "Playback Volume");
> +	scnprintf(opts->p_alt0_name, sizeof(opts->p_alt0_name), "Playback Inactive");
> +	scnprintf(opts->p_alt1_name, sizeof(opts->p_alt1_name), "Playback Active");
> +
> +	scnprintf(opts->c_it_name, sizeof(opts->c_it_name), "USBD Out");
> +	scnprintf(opts->c_ot_name, sizeof(opts->c_ot_name), "USBH In");
> +	scnprintf(opts->c_fu_name, sizeof(opts->c_fu_name), "Capture Volume");
> +	scnprintf(opts->c_alt0_name, sizeof(opts->c_alt0_name), "Capture Inactive");
> +	scnprintf(opts->c_alt1_name, sizeof(opts->c_alt1_name), "Capture Active");
>  
>  	opts->p_terminal_type = UAC2_DEF_P_TERM_TYPE;
>  	opts->c_terminal_type = UAC2_DEF_C_TERM_TYPE;
> diff --git a/drivers/usb/gadget/function/u_uac2.h b/drivers/usb/gadget/function/u_uac2.h
> index 5e81bdd6c5fb..e697d35a1759 100644
> --- a/drivers/usb/gadget/function/u_uac2.h
> +++ b/drivers/usb/gadget/function/u_uac2.h
> @@ -68,7 +68,22 @@ struct f_uac2_opts {
>  	int				fb_max;
>  	bool			bound;
>  
> -	char			function_name[32];
> +	char			function_name[USB_MAX_STRING_LEN];
> +	char			if_ctrl_name[USB_MAX_STRING_LEN];
> +	char			clksrc_in_name[USB_MAX_STRING_LEN];
> +	char			clksrc_out_name[USB_MAX_STRING_LEN];
> +
> +	char			p_it_name[USB_MAX_STRING_LEN];
> +	char			p_ot_name[USB_MAX_STRING_LEN];
> +	char			p_fu_name[USB_MAX_STRING_LEN];
> +	char			p_alt0_name[USB_MAX_STRING_LEN];
> +	char			p_alt1_name[USB_MAX_STRING_LEN];
> +
> +	char			c_it_name[USB_MAX_STRING_LEN];
> +	char			c_ot_name[USB_MAX_STRING_LEN];
> +	char			c_fu_name[USB_MAX_STRING_LEN];
> +	char			c_alt0_name[USB_MAX_STRING_LEN];
> +	char			c_alt1_name[USB_MAX_STRING_LEN];
>  
>  	s16				p_terminal_type;
>  	s16				c_terminal_type;


Return-Path: <linux-kernel+bounces-165707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF628B9001
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 781D7B22043
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F85160887;
	Wed,  1 May 2024 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/bz9Sca"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685AC1C287;
	Wed,  1 May 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714591208; cv=none; b=MsObkkZLk+Ns53XnM4jaisY7lJpO3qTXsm5uU6MDz63S2T8mxtiDd14aGSu4vKt7vLGgftuEbdr7GvIifxljLOMEP5k+nVsj+rL7o+xwe3LnBFEAflXKD4wgoiJOR7/0FYMmtzgX3VR6RoSm9cHJUbIAuI1vabPW5bsnYa+0LfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714591208; c=relaxed/simple;
	bh=2icMSh1KJRQHkfMpRS4no2f8fdq6UTlQRe2OM5Yszuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e38QcdCVttAFL8uEgGfX1QJ/zymYbkkplSa0Heb+Gdoelt/4EyR3pydRa2Sp70jAZj5sAVtd8j8EmwKcmUhOJR3PB5Y4iJ60FV/Not4prqkH/OXNroZe/VdKupFTDEQ+naAEFGswEoect8nkYLY6sXpfLdToWosOJJIIofAFZuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/bz9Sca; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e50a04c317so39552685ad.1;
        Wed, 01 May 2024 12:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714591207; x=1715196007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NQMIHTv3D4/FbFaMQCgt0UeLIRCHiGP+9OlGQP/6AIQ=;
        b=d/bz9Scaa7BuPvz3nctbRQ8UuZ0zHTgFvD63K+KqLaScb6PGEk1x233HnxDN2gBZ/h
         8JQfqCsLksHbuHQhJf7HY2jesXbSZIH4O0iQY2LIUQHsvX3yV3uJ2n3DEgXpb5aZ9LNb
         HS9oaOGO46o7qxlAlh8G0++arBZLx6Lec57sygx9MkK4SxRvEgzL+sZSo1KEj+n3vHkv
         G8A5brAcRSQsmuAW7XO+EWi04+fdF57Ngey4MPvc0iW1UGTj/pIFW8ueLAWLfgOJUmbn
         F5gI/9tg+yPccKQcm3JB4w2UbDHAOTqW48h67b/K1pXeKFoHG3IiCO1t+F+Y0HBM//+y
         5ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714591207; x=1715196007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQMIHTv3D4/FbFaMQCgt0UeLIRCHiGP+9OlGQP/6AIQ=;
        b=AEBSMVOkxetFgvTLv4h+Qv0S4Sd5VNNtvF9Fpak3Ho5FxxZozoeqbKOvHx7XrMBH5c
         n3K9qWFoP98q7355NLTMtjS/Dx04nq+QRFDkr6vhGUDnQyG91IRyLoirfrdcp2X66Wpf
         FG0ObyD4u5Y7qKcf5Bj7ql2JYlNHhbf6tqDkQ3WJiueVgkVbmmoIjBPb2/9CqYbGnC2A
         6ehCih/At2P3w5Z7L+56vkb5r1HCpduxxDkCRfy67KLPTAVn3gVMXHLLOzl1s80Jngze
         kRJM0zOcBSnKmYz/EL0aktVr9XZwk/gXByklK1TPBrmnoR6tsdlJGyOvHJFZQVxziEHm
         hKAA==
X-Forwarded-Encrypted: i=1; AJvYcCU2MkLABgmVkWu1B6XWmbr0MLxH/XkOSUbg+KRKEgmV9tktMjMSuq+pyRM1u5EgVI3p5VJxZHCyHXwjqJyVHTPZfxTrlAsHS1qMoP4=
X-Gm-Message-State: AOJu0Yx+/mYO5XCBcM348ygRlC1PH+cTEW8VvDvCiPovlfPqLR6HRc2K
	XsrLIIJKfwh6SPjRRgyfV3XwhxtjQkop+CEO23N0lD5Y6+60tNFk
X-Google-Smtp-Source: AGHT+IGd58y/IOmwV5M13fhinNX4nSAJNZ+EFLovipF4lfrEQyQp9BGMZPZfm9gGlJJy8nVMxvg6Dg==
X-Received: by 2002:a17:903:1108:b0:1e2:307f:d283 with SMTP id n8-20020a170903110800b001e2307fd283mr3810879plh.1.1714591206533;
        Wed, 01 May 2024 12:20:06 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1cb4:dd50:d6f1:6308])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001e420abf8c1sm24596381plf.165.2024.05.01.12.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:20:06 -0700 (PDT)
Date: Wed, 1 May 2024 12:20:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Denose <jdenose@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeffery Miller <jefferymiller@google.com>,
	Phoenix Huang <phoenix@emc.com.tw>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: elantech - fix touchpad state on resume for
 Lenovo N24
Message-ID: <ZjKV44wZWH4MBCrF@google.com>
References: <20240501140231.1.Ifa0e25ebf968d8f307f58d678036944141ab17e6@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501140231.1.Ifa0e25ebf968d8f307f58d678036944141ab17e6@changeid>

On Wed, May 01, 2024 at 02:02:32PM +0000, Jonathan Denose wrote:
> The Lenovo N24 on resume becomes stuck in a state where it
> sends incorrect packets, causing elantech_packet_check_v4 to fail.
> The only way for the device to resume sending the correct packets is for
> it to be disabled and then re-enabled.
> 
> This change adds a dmi check to trigger this behavior on resume.
> Signed-off-by: Jonathan Denose <jdenose@google.com>

Adding a couple more folks to take a look at this...

> ---
> 
>  drivers/input/mouse/elantech.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 4e38229404b4b..e0f3095b4227e 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1476,6 +1476,23 @@ static void elantech_disconnect(struct psmouse *psmouse)
>  	psmouse->private = NULL;
>  }
>  
> +/*
> + * Some hw_version 4 models fail to properly activate absolute mode on
> + * resume without going through disable/enable cycle.
> + */
> +static const struct dmi_system_id elantech_needs_reenable[] = {
> +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
> +	{
> +		/* Lenovo N24 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "81AF"),
> +		},
> +	},
> +#endif
> +	{ }
> +};
> +
>  /*
>   * Put the touchpad back into absolute mode when reconnecting
>   */
> @@ -1486,6 +1503,22 @@ static int elantech_reconnect(struct psmouse *psmouse)
>  	if (elantech_detect(psmouse, 0))
>  		return -1;
>  
> +	if (dmi_check_system(elantech_needs_reenable)) {
> +		int err;
> +
> +		err = ps2_sendbyte(&psmouse->ps2dev, PSMOUSE_CMD_DISABLE, NULL);
> +
> +		if (err)
> +			psmouse_warn(psmouse, "Failed to deactivate mouse on %s: %d\n",
> +					psmouse->ps2dev.serio->phys, err);
> +
> +		err = ps2_sendbyte(&psmouse->ps2dev, PSMOUSE_CMD_ENABLE, NULL);
> +
> +		if (err)
> +			psmouse_warn(psmouse, "Failed to reactivate mouse on %s: %d\n",
> +					psmouse->ps2dev.serio->phys, err);
> +	}
> +
>  	if (elantech_set_absolute_mode(psmouse)) {
>  		psmouse_err(psmouse,
>  			    "failed to put touchpad back into absolute mode.\n");
> -- 
> 2.45.0.rc0.197.gbae5840b3b-goog
> 

-- 
Dmitry


Return-Path: <linux-kernel+bounces-167048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3388D8BA3DC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EAB1C22F61
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710DC1CD2F;
	Thu,  2 May 2024 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhUYLwQ+"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610B057C8D;
	Thu,  2 May 2024 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691608; cv=none; b=UY/UZV5uIkLH3yLl9kAe7k8ruZVnqmEM8ixfoNKDBN12sTdKD0tRevztvkaQKnLGxIeTJ/di6U43hm6viP72AxgPFdchsL3W/tGeDmPzbrua+XaZAFl0DDFq/TaFpAJ+k0VJ5uhkhdMlqa20xwEoPZQdVcs9Qd85QjXERTy17n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691608; c=relaxed/simple;
	bh=u+yd1qxTMtqyA0JN8HqFvSkRkn69QG4mf+5MR06MfZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unrR3lpUa0lhcNco1PwKV3eHBcDix/J0B+kOaTMvX4OAFL1RLVcvb1SzhGETq3WJBbyYnD1zKmMxDNnhhDHhYdCtUFne/DN0LXwTkTWXR5SM0eq+f66sezDjXBhw0fUevSduif0SeUOEGYG0H4phF08AExxb27E3e5dltao+2ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhUYLwQ+; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-23df05526a5so568055fac.3;
        Thu, 02 May 2024 16:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714691606; x=1715296406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZTQ8b08ADcpplkiE8GEsQC5kR1xohUpTi1jp5L+avM=;
        b=MhUYLwQ+r9V1T7culMTpfxTNmjmt62gx3klk4GK80g/kF2PKmcHaf3wAZq8JMmHmr1
         4dQiFNwPn4cqTschLbreu7TQKL8Hq8j5JtvJOfUvPPHFyBFLwiau5htiWWwzhex1nvAR
         0+y+2SAq9uSMJJHBcvIFpPM2eEWHZWZ7cBQzdiahiSBLbo1/ZSUnvJKYkzt1ql9Ml1hj
         29wWqK9gFa5OBmuWhqxvrVTjTMLQINj8hcFuWqFG+vxy4YMrS48KQQlAq7kAtYITZqwL
         Zwnw77iS+gsP1IHlYhkhj3zTeikpie7FxwooYdb0WNoaejDFQF0xKC8B0lFxKimUy7ZG
         Cc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714691606; x=1715296406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZTQ8b08ADcpplkiE8GEsQC5kR1xohUpTi1jp5L+avM=;
        b=GzYuzpjpTzjQpnofN8hB12d5Xy6XhHLnMXbn0zk0AHmKammqNw7A+RzBw83vMMQNoT
         Gzaeqx7V5IJ8aKHGZtFW3SQcCHD6WbfNZ1EqrKrVi+jCaL/yAU5t4vfZMxfiNK+wfJf8
         HBNu+3KeoJV2tzbTFZoMZingBCdn/afdRDbsEsgrJTGC9qJz2bSV68gmlg2AtMyr5gyf
         eSAQlyS6eugu6o1xTzbCvt75g17Bhpur1BAwfbUja3WetHDPSd1NmRGJoHg6hSnpfg68
         YIIW4q8ZSlqKbC6+2J+hT6eQjSDWaHZwgo428fHu1zFWcwbSiEs1A3ULEVjlReD+fsJa
         HrPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJsmvl4zX2xBHmR3YQlwMzIxq3lxhNgxDICdXVisx4OpXXp5jdE/7nJuavsquxfoptJLLqBzPQPJd20XxF1CCxcImBH8UxnEGER+4=
X-Gm-Message-State: AOJu0YwqsDZyOVL0HTneBnLvxLAZkSshfHfW+I70apvxBUrOC7trIzq8
	vNnZR+XvxsZATifFGlz5ROg0eH5xAKo4Qzvn8pYKWqZnepzh2gQbilVO1w==
X-Google-Smtp-Source: AGHT+IFPBPJQrhErzDfBkYnMLmaOKoyKcpLCyvu335M9CCXRZwkhQig1ifTf6ImNfUkQgjTpsiSaGg==
X-Received: by 2002:a05:6870:a790:b0:239:8e67:6f10 with SMTP id x16-20020a056870a79000b002398e676f10mr1518423oao.30.1714691606271;
        Thu, 02 May 2024 16:13:26 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:e24:7949:ee02:ebf8])
        by smtp.gmail.com with ESMTPSA id fi7-20020a056a00398700b006ed007b3596sm1820221pfb.69.2024.05.02.16.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 16:13:25 -0700 (PDT)
Date: Thu, 2 May 2024 16:13:23 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Denose <jdenose@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeffery Miller <jefferymiller@google.com>
Subject: Re: [PATCH] Input: elantech - fix touchpad state on resume for
 Lenovo N24
Message-ID: <ZjQeE643YAbK1hq5@google.com>
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

This and below should be ps2_command().

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

Thanks.

-- 
Dmitry


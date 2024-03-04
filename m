Return-Path: <linux-kernel+bounces-90294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AF986FD00
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04731F245FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0B2225CD;
	Mon,  4 Mar 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE1xC0pp"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A41B814;
	Mon,  4 Mar 2024 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543861; cv=none; b=LVRqFP31bIsitgYB0CC+fmKS6jO7BuQ1Ih93UFTrgfUVd+/PnsnoLlR1vy0KaD193b+2db7bJ/jvjomJMB3Ex37fAGqwNKaIUgiUKsTgyvPPJfoKQjiH7GYTaTuhcH8+OvqWFPQuXtoTWVabRHLdul3CFWZ8YkO0bOyrayrAtio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543861; c=relaxed/simple;
	bh=Qq1jg86NYicltpYfn1YXwPRMwEdiM2aWEnn4TNPiai8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h2ESVor/MYOrk/gjN2tFQAoZBZ+JWZzQRM566CvgYH5cMFqGtkWesOZEHNbPiFVnEz770hLQg7+uIFYr10NwS/UYrVv36YRRjQC/HrN/QtP+OfdYJn4v/PksehEPv0elGvMulP4INWCLD4SwVxxgqFTB+xqBeKPokv0Ie4mmvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WE1xC0pp; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d23114b19dso51792641fa.3;
        Mon, 04 Mar 2024 01:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709543858; x=1710148658; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wxb84sArYHWCge17RqY2dnfS8pZorGfPXvmpeXBM+UE=;
        b=WE1xC0pprrgUY/tpgdCHInmleFaKWpc+KYzPSszg5xsD6rH5aPrPeEh/jyK3IoL5g1
         UQWlmybUNS4F8kuKy1EF3rcZ/uSc1eLYbny6KwnkPP/RPfez8U5lHTU/h4Zbmm0IJEvp
         cU7GOeK6UL1jPkpP/6jGgV4Ljbd/hD/AB8cVvI1XOJ4b22u5qSqRQoNcEZwP2AEcb4Bp
         K+Cb0SE0rmwNzxAsthO4D/ok33M3ZjV6KOatAkqSc2Taar9FC3UHCYTgx5HA9X6gwSt9
         0fgDW7fejF/jX0sP0PhFfwKQL+v2NKLWggq4uH6E99x2wrhrcODc7hRhoE/gEm0AW4Wz
         IzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709543858; x=1710148658;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxb84sArYHWCge17RqY2dnfS8pZorGfPXvmpeXBM+UE=;
        b=UA4fMlG+j3qd2iFPFq8u7PJ7eYqxbvAH/9lGGBKcKJingTB69yg9B8fUrfcL0tbZs7
         rpWnT/9vi6qMJuqmpYLmmgcwYR4zlxXf0ZfuniMixaimRiim+I2TqZ0+w/rr8IN/ivod
         ibdpTPGY+EqkcN+NNXcaSMxU+QKVnurbOJ/gNQxLwvHbbg97qQ+h6/Z2Co1dTcfuFB6r
         8UHkm402pdG8xN0CY2ALIGDLXj0+j2jKanaLaADhJi1dtzVk1hMReqpd2JL1BGFvErgN
         KEFH4DwnvTUGig9bcf3VWIMSRsO6tjv/U77Olr5TwDAoX+Q1FHB0cubf2zfoIaAV9L/R
         rGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbB5U61zL0ZbcoPUrJZ30dga6H58Tk+Z/tw5LDxv41LBfY8qZQsDyuBNp6QB9KpSXXoj3m5tTVsdrKL8ackeT6N8Ms9Ns3wKqEh9aO2n0JbG0G+6MyIFrRjuV9/yNce655j/IwmyAfFxqnUGF+
X-Gm-Message-State: AOJu0Yz51Rw4goqaqEJT7syfYvlxNMGk4ObLu2krfH0i2xqn8axKVR3I
	izB1cJipE8aifjgC3Y9QbkowHsR6AJvi4wN11oCA0HPhxeZvkllT
X-Google-Smtp-Source: AGHT+IHoWbhv0G7/RF1N1tx36guIvvx6OukW50GAMYLBOZmWqoYnRwfEqdFQ9lwVbVqHZlcw8HR+hQ==
X-Received: by 2002:a2e:9cd3:0:b0:2d2:b068:6d2a with SMTP id g19-20020a2e9cd3000000b002d2b0686d2amr5802516ljj.16.1709543857438;
        Mon, 04 Mar 2024 01:17:37 -0800 (PST)
Received: from localhost (a109-49-32-45.cpe.netcabo.pt. [109.49.32.45])
        by smtp.gmail.com with ESMTPSA id a10-20020a05600c348a00b00412e5060995sm1679557wmq.34.2024.03.04.01.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:17:36 -0800 (PST)
From: Rui Miguel Silva <rmfrfs@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, greybus-dev@lists.linaro.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix get_channel_from_mode() failure path
In-Reply-To: <379c0cb4-39e0-4293-8a18-c7b1298e5420@moroto.mountain>
References: <379c0cb4-39e0-4293-8a18-c7b1298e5420@moroto.mountain>
Date: Mon, 04 Mar 2024 09:17:36 +0000
Message-ID: <m3sf16tky7.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Dan,
once again thanks for the patch.

Dan Carpenter <dan.carpenter@linaro.org> writes:

> The get_channel_from_mode() function is supposed to return the channel
> which matches the mode.  But it has a bug where if it doesn't find a
> matching channel then it returns the last channel.  It should return
> NULL instead.
>
> Also remove an unnecessary NULL check on "channel".
>
> Fixes: 2870b52bae4c ("greybus: lights: add lights implementation")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>

Cheers,
  Rui

> ---
>  drivers/staging/greybus/light.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
> index d62f97249aca..a5c2fe963866 100644
> --- a/drivers/staging/greybus/light.c
> +++ b/drivers/staging/greybus/light.c
> @@ -95,15 +95,15 @@ static struct led_classdev *get_channel_cdev(struct gb_channel *channel)
>  static struct gb_channel *get_channel_from_mode(struct gb_light *light,
>  						u32 mode)
>  {
> -	struct gb_channel *channel = NULL;
> +	struct gb_channel *channel;
>  	int i;
>  
>  	for (i = 0; i < light->channels_count; i++) {
>  		channel = &light->channels[i];
> -		if (channel && channel->mode == mode)
> -			break;
> +		if (channel->mode == mode)
> +			return channel;
>  	}
> -	return channel;
> +	return NULL;
>  }
>  
>  static int __gb_lights_flash_intensity_set(struct gb_channel *channel,
> -- 
> 2.43.0


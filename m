Return-Path: <linux-kernel+bounces-155143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09828AE5C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8EE1C232F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DA8126F32;
	Tue, 23 Apr 2024 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxbAZkrv"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846268593A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874473; cv=none; b=pmrOgO1Wu38k5yLX7jPjVJevyn/TK2ns4sJxT/whwShChO/i0QXtO83hXA9EPwKaUBlo7NAd8DEIv8XI9g9R38LOaKx049+5pAAFiNMzOvkVBerkqGPN+3SZTzdcDbQQ0TAGS5/oDSijaFH9lvrbw/RSWKiuC0h7MO6L96HQnEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874473; c=relaxed/simple;
	bh=xrHUWVD69zLmVJqvHlJV/3qRChQy9OGGrJQ9pXwOgrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRedgpZDyfp+G6jDYmSmKYRlyx39eqEQFVlYqQHpKC0dPWa5n71BW1lllouzVSz0NtOsTjenu3/NwmfatjYW5wzyhMighP/KIlbDvVQqPkN4zsdMPDDg1SdtmBu6C3p+MuwI57WZe1mvt4AGXoOI2tKrwRFhLdNRaCQEiQviakg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxbAZkrv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e411e339b8so42368445ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713874470; x=1714479270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfDxyfJfymP26h4+ddYPjyiq4HLFYyniMe8asgoNoqc=;
        b=JxbAZkrvmxie6jqA/95p8SwteOemIyu6UqYhpKRleIT59eQNfxAjw73xYrMoHAiWMr
         JHCW7pJ7qViONFl+MUCLvbhVCn/FxelI91qn2WmcOOaE4V0jdY6liSpKs3YHVd/E2SKE
         oeAF9Tq0HHjG5WXhXXXyW8x6rGzymWYyhGPctmsm1VKmAKTPzAPPRftdJ5gl5Nz6EvJE
         4txI4jhoi5J4Q8zI2BXFJ3BAnCN8utD441ZGbxO09wuXXT0dwQ2WJbsGrhvIakDkJRdC
         RB63qjjWivlo5gj2L24igh1OmSFPI7OWOS77F14t5pVrf03S8qqjfKJwQrMBSiNzd4BW
         R5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713874470; x=1714479270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfDxyfJfymP26h4+ddYPjyiq4HLFYyniMe8asgoNoqc=;
        b=Y4RFba3bEYFEEpVjgDhYNaSz9aarxHTkvlJ/UD7JCKGwkP3TXNqKOmr8MvlP6nyfS4
         VYXcb1zW5uKgKso6sT6G9R/0ZYxN07dqmZFR7A6FOvXlzlQ+ZALVYVKjkpfZaxzQdekh
         xQUpYf2KJF0glHY9AiMZu2uLXFxES1HrC9kMMHJYfQly6tkPcv9l6igBXkvrwy0hwiWy
         vqV+ULELbAB2bJcf9O1QA4rarqgSJIdqDWZ5isl4ch7qNHzjMzOdxS+I4RpGXOU8qxXl
         86WB+TsWHh3jr+jHup2ino7jP2qby0Fq6Lk4/7goxLGxdM/WqXFF1jiIgI+DnYZUnpV1
         broQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAjcS6hGwxN7lownR7VsKF/ZL5Xjm1MiC+QGwxmEqP7cPDMpSV+B9BnsXPtAsByVKuQq3XP8K+GwehygAUKOE2r7AM4LlBo/c15sFe
X-Gm-Message-State: AOJu0Yyan5JLmwYBFEoSWnP1yp17hiLdSQeo39aA79NQU7aG/rLylvpn
	tCU6GKfXRNnuolS3klcG56rVh81Ziz73XUANHLKAuZsdd/f/+s5u
X-Google-Smtp-Source: AGHT+IEzbK8aMcBmZP5EpRn8Vgf8xWgv3IYZW61JPKUlupX9wN9Eb/xTGjOObHYX33eTfb4Ri6vPBw==
X-Received: by 2002:a17:902:d344:b0:1e4:6232:367a with SMTP id l4-20020a170902d34400b001e46232367amr14090195plk.22.1713874470135;
        Tue, 23 Apr 2024 05:14:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001dd59b54f9fsm9902214plh.136.2024.04.23.05.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:14:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 23 Apr 2024 05:14:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	Aleksander Mazur <deweloper@wp.pl>
Subject: Re: [PATCH] regulator: change devm_regulator_get_enable_optional()
 stub to return Ok
Message-ID: <5309a7a9-e8d5-4168-9f4b-99011a3fc33c@roeck-us.net>
References: <ZiedtOE00Zozd3XO@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiedtOE00Zozd3XO@fedora>

On Tue, Apr 23, 2024 at 02:38:28PM +0300, Matti Vaittinen wrote:
> The devm_regulator_get_enable_optional() should be a 'call and forget'
> API, meaning, when it is used to enable the regulators, the API does not
> provide a handle to do any further control of the regulators. It gives
> no real benefit to return an error from the stub if CONFIG_REGULATOR is
> not set.
> 
> On the contrary, returning an error is causing problems to drivers when
> hardware is such it works out just fine with no regulator control.
> Returning an error forces drivers to specifically handle the case where
> CONFIG_REGULATOR is not set, making the mere existence of the stub
> questionalble.
> 
> Change the stub implementation for the
> devm_regulator_get_enable_optional() to return Ok so drivers do not
> separately handle the case where the CONFIG_REGULATOR is not set.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: da279e6965b3 ("regulator: Add devm helpers for get and enable")

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  include/linux/regulator/consumer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
> index 71232fb7dda3..ed180ca419da 100644
> --- a/include/linux/regulator/consumer.h
> +++ b/include/linux/regulator/consumer.h
> @@ -326,7 +326,7 @@ static inline int devm_regulator_get_enable(struct device *dev, const char *id)
>  static inline int devm_regulator_get_enable_optional(struct device *dev,
>  						     const char *id)
>  {
> -	return -ENODEV;
> +	return 0;
>  }
>  
>  static inline struct regulator *__must_check
> 
> base-commit: f7638784bd0cf2ca9daebd47477983811f832300
> -- 
> 2.43.2
> 
> 
> -- 
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
> 
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =] 




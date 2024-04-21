Return-Path: <linux-kernel+bounces-152658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DDA8AC22A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 01:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 822C7B20EF0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 23:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8EB46436;
	Sun, 21 Apr 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzrAbT9L"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361AC1BC58;
	Sun, 21 Apr 2024 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713743461; cv=none; b=eH+Zy3HCZeiAHPpRx3tVGM8JH00o355glAUpN9AC8yA00F3pSJRXvfRg8xylpXf9o6sjL2z24iwz1a/jKSaDeEf8ua56KZwX/WBUNv9Lvp/GDgGw9IbG1jvNDA7fpbIB7U0x5U0Z3xl/+B5GsHcnVtFwhSHjLiitubRbnLJJiS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713743461; c=relaxed/simple;
	bh=YdGlilwPoZmG9gKaaTLFfeBClo8PnMJTT3MPY8WJ+kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkjS8Rg8fkV4dbZ93hQ71aaBzsbdtROgPRXSR42kBbXaZ3eH1/G7aQIMzxRJa9N77X3gpEoUslhrxLq8Yf1NU/4AneR3Nht4Gof4+Zuqu96dj7RhhCzAjMAJ6RpK1a57uTJZ4CyON0k4d+v+3dnRNmjeX5OO8vw4Ab2rVejyA/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzrAbT9L; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ce2aada130so2600287a12.1;
        Sun, 21 Apr 2024 16:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713743459; x=1714348259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FV20n2eOOFz2ddqTNTvIrBb81EwLpU6B113A9MmWLvE=;
        b=lzrAbT9LZBu2zNAw6hYb3VmVbWD5AtXCVpEwyYM/gkv2TM1dJXRsvDWxAb0lYbpv76
         nskWAOH5EZlqtWv3puTW9c/oEB8PtVVzvKM56oP2lGb2o+9xTa5XczcNvGkRvLAX0Vra
         wNd7w+lA6SBbZ7+ze5oVSYo32xUXL5GjEeRj3yoNs/ZRmPsl8GRTusGMFZyNsBxUcuyW
         D7spR/lK+qoQuWpTU1bucF3BTiRvmvyQFB9rI00z5x1yj8GHTHcflTjeOIiHJT7Efmf/
         x+ojdN4iXojE7jENd/GvnVo6S1SkWHcgbK+8rtD1n7z72LYmh3ogcjz7ANeLwmrGJQhM
         8Y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713743459; x=1714348259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FV20n2eOOFz2ddqTNTvIrBb81EwLpU6B113A9MmWLvE=;
        b=bTe6hdiCA5Ly5ZPNWGOwgW6i18hJXZ941mmHmeMQ4uoV/8uQ65BDVGKHt/cM+T5t8C
         pHTpb8YUonKX2lUgV1Ye56ugFs1Gl/z7w7IEvU/HbO8bERgJiA84DFAvF/wgTFAic8Tu
         wt+dS194A7xjwipE700QdXwdTbtKMYmgkFs6OPEiJ6vVCny7psZVPPXi2fsG0l6A7Utd
         TTQ36TgwccdjpNel92kAaR5plHH5iRps2gG3vhmF8b6w6oActqcBwkoCX98TAWtX4Z+y
         DswrAi6yy8LKhjbXesEOM/uUFlxy2PsifenMAeWBIOWq793LawNTFG4+cooGP80N3qfF
         LE7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtwT7wTN+cPOWWfwxWGSDasCjcIbvov+gKkEw4rIyqeZPDCg5xMvcNniUjbOZRKmRN9bJET9Ydr2F6CYXcbN+/ZASYCdDM9j5Y7O1FKayZFyimZOfipriwAD3+RTN3brqT4V+lbNnyord1V+U=
X-Gm-Message-State: AOJu0YzkN2EG3SY+IfrrrcyoPUQZHwagpUnN6s4BVZOuTk0Bk2j07/qw
	1YYV6oY3CWdlHWjojcMoiq8UQLTQIDnEOQ0KDr7A8LsSsFH0KZjj
X-Google-Smtp-Source: AGHT+IHSUJDEAjxkLa5CYyX1ttCtJehdT/C3gsFsDVCWLxJ79iAuS+cM2jmWlJ0WoYMAOTnESGHXEg==
X-Received: by 2002:a05:6a20:7f8c:b0:1a7:8a02:3058 with SMTP id d12-20020a056a207f8c00b001a78a023058mr9127929pzj.12.1713743459271;
        Sun, 21 Apr 2024 16:50:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3-20020a631943000000b005df41b00ee9sm6359267pgz.68.2024.04.21.16.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 16:50:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 21 Apr 2024 16:50:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Tero Kristo <t-kristo@ti.com>,
	"Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Subject: Re: [RFC][PATCH] watchdog: rti-wdt: Provide set_timeout handler to
 make existing userspace happy
Message-ID: <e6e3f905-3de5-469c-a47e-179fe23c66df@roeck-us.net>
References: <4d82b8ce-bc34-e4b2-c5fe-9e883b0db59d@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d82b8ce-bc34-e4b2-c5fe-9e883b0db59d@siemens.com>

On Mon, Sep 13, 2021 at 01:41:43PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Prominent userspace - systemd - cannot handle watchdogs without
> WDIOF_SETTIMEOUT, even if it was configured to the same time as the
> driver selected or was used by firmware to start the watchdog. To avoid
> failing in this case, implement a handler that only fails if a deviating
> set_timeout is requested.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

NACK.

This will need to be fixed in systemd. set_timeout is and will remain
optional.

Guenter

> ---
> 
> See also https://github.com/systemd/systemd/issues/20683
> 
>  drivers/watchdog/rti_wdt.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index 359302f71f7e..365255b15a0d 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -173,13 +173,27 @@ static unsigned int rti_wdt_get_timeleft_ms(struct watchdog_device *wdd)
>  	return timer_counter;
>  }
>  
> +static int rti_wdt_set_timeout(struct watchdog_device *wdd,
> +			       unsigned int timeout)
> +{
> +	/*
> +	 * Updating the timeout after start is actually not supported, but
> +	 * let's ignore requests for the already configured value. Helps
> +	 * existing userspace such as systemd.
> +	 */
> +	if (timeout != heartbeat)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
>  static unsigned int rti_wdt_get_timeleft(struct watchdog_device *wdd)
>  {
>  	return rti_wdt_get_timeleft_ms(wdd) / 1000;
>  }
>  
>  static const struct watchdog_info rti_wdt_info = {
> -	.options = WDIOF_KEEPALIVEPING,
> +	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
>  	.identity = "K3 RTI Watchdog",
>  };
>  
> @@ -187,6 +201,7 @@ static const struct watchdog_ops rti_wdt_ops = {
>  	.owner		= THIS_MODULE,
>  	.start		= rti_wdt_start,
>  	.ping		= rti_wdt_ping,
> +	.set_timeout	= rti_wdt_set_timeout,
>  	.get_timeleft	= rti_wdt_get_timeleft,
>  };
>  
> -- 
> 2.31.1


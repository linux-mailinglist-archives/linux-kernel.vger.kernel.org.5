Return-Path: <linux-kernel+bounces-63871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7288535BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413121F2465C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6055F848;
	Tue, 13 Feb 2024 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7n8wCn3"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B485F564;
	Tue, 13 Feb 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840782; cv=none; b=glnDb1YNQTk6lITG7o1t7uSfMJTO1ADQ5FAcMCBsq+OHazCVoTwnL/Qm/8kd6w6+BdWLxxj2KCYEC+dtbXIhWOGrMVPmvntRdEcILy3V8Fx8P8SAI9d1C0oR+4IV9U/yg7FYY3osMBSRX5pOGnvnIexh2wIHMfobLyTjBce22B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840782; c=relaxed/simple;
	bh=N2yP66lwtVP62oiiX2anPJqTkl4LISR2GidqocTTxCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpMsDtFpdouVDhdDrGLZWxCBV0fyB73ovvjV6PzgCPGSjj6wHB3TeypFkD/ikq2UygT18/yGY0cJ4ns/JiEEDLs6HMuMGDC6ePA5piBZcyxj4hBRemyl8NCOi+V1KFZCp1QR3UqihPkUrllD5hbQZGu+48IxCQr6jqzNLsu4ltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7n8wCn3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e0dcf0a936so1171746b3a.0;
        Tue, 13 Feb 2024 08:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707840780; x=1708445580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8rkZbyPYFgVx8KHNAMihfBeoKM5d9jXNM0RcMpsSfI=;
        b=C7n8wCn3W0bNDWKQA/qHgIG3iJ3gMxIfU2y99zfcwyi19a513M4evQYUjABjmOr1sb
         WxCiDicTSubxhCuWktH54FuqL+6UKZuviPsgSZJWfh+S2D3wfG9YyeeeA/lV5NgzfljM
         W/DD+Xqma+QstZwdk6GPitygDrvpkaDH7luxesE6aRtSDV940YVAMhMMVN7LFN4lZAux
         LpmV+RcpgL+V7vUt1QsijZyCEbprE0FmnxT1QIp5mbQnj7OCN2aLU1XCIXivuOS4vDDt
         euZ8VrD0lGYO6wyFkFZlsmOY0kH3oqAYYioTnl8Ir2zIPVa7HcVoH8wJqYjG0rnD2N9S
         hqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707840780; x=1708445580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8rkZbyPYFgVx8KHNAMihfBeoKM5d9jXNM0RcMpsSfI=;
        b=jCch/O7lzITGAfLAox2H5CG0FU8jZOn+YzN5S7JumlqcU1DbHi4f7F8GAQa1uYl5xO
         BkdzxqLvgUrPmcd4oHhpoqEbIZ+rwHWTq8jr1b8FGt+BdMuniSXa+qrFckNnWQ85gwEO
         tDjUkJ0SJPtixS2f6LtCdCwXvwRC2Zl014O6mvbys3ww6e2eXsStJViFX08yD5vlOSbL
         fInaQQSTk+TPY3CMxWXv2/sDUgoQcfLVl0N2Mn8NMqbVmy+SnU3l7oda6MggxBmng6b7
         xhFdjOHF7zl0vA7+em/v7W9tjtDRaXoaZ8jsRgpTcoL1qMHddUiEQFXB+fAIsPutbx43
         uy7w==
X-Forwarded-Encrypted: i=1; AJvYcCWgUZjRVgJEYFNSRBWjcgKmKBwqH/vWAgf5r0i6ykGyovhCH/tl5YwywpKzZIC8DV0dNpv5q+S0opvTnWvZ6aDDY4Brp6n1bGgBX7mBJ9OveRKqWcSGYqLtx9niCO9D4AOz8flnsvu2NH98R2Y=
X-Gm-Message-State: AOJu0YxT7quRATtvDj+o2EPQnPKEyflSnaTWb9bdgMr7R1u8QvtcCSo9
	GzP6evKKYvJDXLPgqg3H0eAwhNwl9/SPIBtyjBLNcqJXVbboMhUR
X-Google-Smtp-Source: AGHT+IHMP26wViJ7ERRA42zcu46txodbm4V/VTyhCmMLAlvjMo6LWm+C4Kihu0MT1/wpeFNr4GOZjQ==
X-Received: by 2002:a62:cd45:0:b0:6e0:384e:c6ce with SMTP id o66-20020a62cd45000000b006e0384ec6cemr3409319pfg.7.1707840779793;
        Tue, 13 Feb 2024 08:12:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWldg6+ZQSDlHfSIR7hksr6KNW0RUzroLd4GaRLwWY/zargZ7lbGeYtlvI2fMzGboyYTOoVJz1OD5AhC0+PinjmTmIwNZ1+zpbhD5RzLEZvsPyBCD9TmFyWcTjO1mV6vZOxZxWePUquWbCs5v0=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id lm17-20020a056a003c9100b006e080d792acsm7486815pfb.184.2024.02.13.08.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 08:12:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 13 Feb 2024 08:12:57 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog/hpwdt: Support Suspend and Resume
Message-ID: <7b70a8e7-10ce-4835-891c-b854919fa3cb@roeck-us.net>
References: <20240213070203.489846-1-jerry.hoemann@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213070203.489846-1-jerry.hoemann@hpe.com>

On Tue, Feb 13, 2024 at 12:02:03AM -0700, Jerry Hoemann wrote:
> Add call backs to support suspend and resume.
> 

That makes me wonder if we should add something like
	watchdog_stop_on_suspend()
to the watchdog core. Almost every watchdog driver supporting
suspend/resume repeats the same sequence (except for the debug
message). That is a separate question, though.

> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  drivers/watchdog/hpwdt.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 138dc8d8ca3d..6565cfaa8e57 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -378,11 +378,38 @@ static void hpwdt_exit(struct pci_dev *dev)
>  	pci_disable_device(dev);
>  }
>  
> +static int hpwdt_suspend(struct device *dev)
> +{
> +	dev_dbg(dev, "Suspend watchdog\n");
> +

Doesn't the suspend / resume code already display such debug messages ?

> +	if (watchdog_active(&hpwdt_dev))
> +		hpwdt_stop();
> +
> +	return 0;
> +}
> +
> +static int hpwdt_resume(struct device *dev)
> +{
> +	dev_dbg(dev, "Resume watchdog\n");
> +
> +	if (watchdog_active(&hpwdt_dev))
> +		hpwdt_start(&hpwdt_dev);
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(hpwdt_pm_ops, hpwdt_suspend, hpwdt_resume);

That disables / enables the watchdog as part of regular suspend/resume
handling, meaning any hang during suspend/resume that happens later will
hang the system. Sure you don't want to use SET_LATE_SYSTEM_SLEEP_PM_OPS()
instead ?

Never mind, though. Your call, obviously.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter


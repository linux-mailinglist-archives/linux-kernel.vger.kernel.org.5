Return-Path: <linux-kernel+bounces-84735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101BB86AAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8C228278F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8CC37718;
	Wed, 28 Feb 2024 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cAMergyl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1E376EC;
	Wed, 28 Feb 2024 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111120; cv=none; b=Tc6gzje0JOzMZF6JKPaVil5ZAz3gmGlA69FtsCsho9DOtUuw/B01WHZ/zLppK7LbYdwdl2jJxrl1Y6BmT9TpNWT/NnMpmOCB6so3l8DX3wT0yfTKKuyDzbRQMNxqcnkUnENaCuJEuUvBp6s+f8RuPya7cUWdNykIr9ccLkZYZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111120; c=relaxed/simple;
	bh=DRRAqbVu648AzoKaJvd45TIW8tkPSWi4TlS0bdC6/Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7wC3G4ZDSnnrFaMYKangwYedbjQykuEx13h275U5hRKdujFTOECGG5K597youiCwBHSpTncmcCBCtYBXdVzsFd9kqWEb1CsF9K6W5oaHlMy3ouzI9RlBvFaZl/JCEKDphw1gRksVj8/2ZMtYtzCjcxi5Btw3eMmHln5jfMsQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cAMergyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC21C433F1;
	Wed, 28 Feb 2024 09:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709111119;
	bh=DRRAqbVu648AzoKaJvd45TIW8tkPSWi4TlS0bdC6/Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAMergylgSi8oPrzJBrgbWexoVVMHhvhFK2K42euEZw905NXPn6U9FcKUU3dhX6+o
	 z4VFGBMkGg9bokWfpHpQ/iEiUKNt5K/MSCYmuHW7L9Y217HHoNwcbsWAQHqBAs02T2
	 QZ5COuOp7MG/b01HVaiuEyeWiH4Rn6gKoYqEefX4=
Date: Wed, 28 Feb 2024 10:05:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: buckzhangwh@gmail.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers:usb:disable usb hub&port async suspend
Message-ID: <2024022815-coping-ultra-b3c3@gregkh>
References: <20240228085607.3275-1-buckzhangwh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228085607.3275-1-buckzhangwh@gmail.com>

On Wed, Feb 28, 2024 at 12:56:07AM -0800, buckzhangwh@gmail.com wrote:
> From: weihui zhang <buckzhangwh@gmail.com>
> 
> we prepare 30 mobile phones only for usb plugg in and out.
> testers plug USB in and out very frequently after phone in deep.
> Repeat the test again and again,some phones are crashed.
> our analysis：

Odd colon character...

Anyway, you sent a v2, and now this, why?  What changed from v2 to this
one?

Please properly version things otherwise we have no idea what to do with
this.

> We analyze ten kernel-dumps,we found something common kernel is blocked.
> pasre in crash,all the dump are directed to usb(device port/hub).
> here is a kdump,task 446 &365&4511 are UN.
> 446:
> .... ->|kobj_attr_store
>           |state_store
>             |pm_suspend
>               |enter_state
>                 |suspend_devices_and_enter
>                  |dpm_resume_end
>                    |dpm_resume
>                     |dpm_resume
>                      |async_synchronize_full
>                       |async_synchronize_cookie_domain
>                        |schedule
> 446 is waiting for 365&4511,no doubtful usb thread.
> here is some warning log:
> [83.958310] musb device disconnect detected from VBUS GPIO.
> ..........
> [84.908017] musb device connection detected from VBUS GPIO.
> [84.911946] typec port1-partner: parent port1 should not be sleeping
> task 365 & 4511:
> ... ->worker_thread
>        |process_one_work
>         |async_run_entry_fn
>           |async_resume
>             |device_resume
>               |dpm_wait_for_superior
>                 |wait_for_completion
>                   |wait_for_common
>                      |schedule_timeout
> I guess usb async resume/suspend are disordered,So I try to disable.
> After that,we tested the case for a month,the bug never happened again.
> the fn device_enable_async_suspend set the dev->power.async_suspend= 1.
> dev->power.async_suspend=1&pm_async_enabled=1,fork task like 365
>    ---> dpm_resume
>            |dpm_async_fn
>              |async_resume  
> dev->power.async_suspend=0,disable async
>      --->dpm_resume
>             |device_resume
>               |call device resume fn.
> here is a demo:
> Only few devices such as scsi/pci/usb call device_enable_async_suspend.
> but scsi call device_disable_async_suspend at drivers/scsi/hosts.c
> 
> Signed-off-by: weihui zhang <buckzhangwh@gmail.com>
> ---
>  drivers/usb/core/hub.c  | 2 +-
>  drivers/usb/core/port.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index e38a4124f..de74f70e5 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2602,7 +2602,7 @@ int usb_new_device(struct usb_device *udev)
>  		add_device_randomness(udev->manufacturer,
>  				      strlen(udev->manufacturer));
>  
> -	device_enable_async_suspend(&udev->dev);
> +	device_disable_async_suspend(&udev->dev);

Also, I do not think you addressed my previous comments about this type
of change, did you?  You can not just disable this for no real reason.
And what are you disabling, are you sure it was enabled in the first
place?

thanks,

greg k-h


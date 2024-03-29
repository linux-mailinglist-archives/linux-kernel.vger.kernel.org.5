Return-Path: <linux-kernel+bounces-125166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3C2892186
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED341F270F7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221B58594D;
	Fri, 29 Mar 2024 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZDwbE7I"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5B2576F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729274; cv=none; b=WyW/0LP0D3E3ERquHxaFBcijiR/MXrgTTHCquPPlsUbmln/vneG9LAPQYPhAcQpSlkYiMHRtGga1Xrgb+nDRHmdbvh6nKUSEvtFyzBykwARtO3MA+VM2C8P7RQyvqbYOB5MvelJeQ6naJiwLQ7BdPj6DBzetVhN2N7KYmrhxTEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729274; c=relaxed/simple;
	bh=dcSFld6UCTdTL/5vjYeiOxLyFOuvbsJONzbcmxgsYaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyZkvayJim9ZTplnFnuWUu60C7elRUlteYc1xYmdOh8IaLHAIuZL+8lC/euCstLdw9pYsYSY86y7MQOOKVR4tFQ39eycnS54e/cuqg5QM5kCUThYRQ/aZF2fzTz4dnFxOyhRv5gIxcZTf7paSCgMdBX/JjaekA6XFkAQVGLaWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UZDwbE7I; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5157af37806so2420448e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711729270; x=1712334070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9TdQntOQdC+RwwerKG1DtWz7PRsJo1psWkBJYy0GaAE=;
        b=UZDwbE7IKUwpGHw3U6rPNsQqmHtlWTUNVhqRUcwhfvaiDlwGT0wny7injIO+/yG7ik
         6uWUm5hv3giwQ1E4ivlYo+kYGF98vAuYLSVEi9J6jmlTz1FNnWpgm4fig3yu9NAQIYJU
         U6b3mXrrRqkGF1jaF68YNpmi21j5PdwDAkoTabD4r0mYIXH3WH6ICJvJ0MqYp+riq3OV
         PoNLx2ZeK8Z0zOKmO737xFQMPzoaY9eptTVo02YaiXQBwQXN0D8MxVSZAEctSt6R/qnk
         pBSYHy/wmyxBi7X3iZveMkVL9l8NhMQ4CbqQFoHDDJcOs9ERux48pIhbwXGJG2IUEtIh
         opTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711729270; x=1712334070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TdQntOQdC+RwwerKG1DtWz7PRsJo1psWkBJYy0GaAE=;
        b=Je1lbiFCqTLeuea5jIVjELXle9v2jzOFzdxMUSPSaUa0P1fHE9ZGLZKp9SGx3XRTZ7
         mQ5YOO/7G4mLPXr8iF5XXJWM6Q2sNtR0nYFVRmJ82xTo17d6fmWLoTc19i9cR9Oo8khD
         f1agxldL1072LV7MYo5EB2waIGib0fTpWuaNSRxw3N2uXxCCskSHMPnJhbCTFgnaTPUD
         lTKStlr3UkEu7EHeKS92MfSxFXMbqO/hLqHEGnOe4/Rb7nuj9RJuKiH+AwbiEeBU8qN1
         6C5Zq8JKKyFF3ZDWTd8PxeRcLbEUjt6iipr+EjIE7TTPCJOjalv9u2FjR7Xkm1dkjQRv
         P4QA==
X-Gm-Message-State: AOJu0YzW9JqLwkpEhoq7CSlf+Ii00KLYuFVOODvsSWbm2+jQtv9sOwGD
	DgzaaRh/Z8aCwGReEE4IsxcwLHC3PthU6xqhvSH1XI7mwstFLG/lFvVDWfPomDM=
X-Google-Smtp-Source: AGHT+IGYcvpSz7jI5yxeagCBVOiO2Xfh0dOk6NVOG3vgeY7eKDGqNcF+bUdJzGLSflCAfgeQkL2bjw==
X-Received: by 2002:a19:2d4c:0:b0:513:ed0f:36c9 with SMTP id t12-20020a192d4c000000b00513ed0f36c9mr2085718lft.45.1711729270454;
        Fri, 29 Mar 2024 09:21:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id z10-20020ac25dea000000b00515d4457ff9sm87172lfq.89.2024.03.29.09.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 09:21:10 -0700 (PDT)
Date: Fri, 29 Mar 2024 18:21:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-kernel@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Prashant Malani <pmalani@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-usb@vger.kernel.org, Kenneth Crudup <kenny@panix.com>
Subject: Re: [PATCH 2/5] usb: typec: ucsi: Check for notifications after init
Message-ID: <ZgbqdBd1OiWgDN-_@eriador.lumag.spb.ru>
References: <20240320073927.1641788-1-lk@c--e.de>
 <20240320073927.1641788-3-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320073927.1641788-3-lk@c--e.de>

On Wed, Mar 20, 2024 at 08:39:23AM +0100, Christian A. Ehrhardt wrote:
> The completion notification for the final SET_NOTIFICATION_ENABLE
> command during initialization can include a connector change
> notification.  However, at the time this completion notification is
> processed, the ucsi struct is not ready to handle this notification.
> As a result the notification is ignored and the controller
> never sends an interrupt again.
> 
> Re-check CCI for a pending connector state change after
> initialization is complete. Adjust the corresponding debug
> message accordingly.
> 
> Fixes: 71a1fa0df2a3 ("usb: typec: ucsi: Store the notification mask")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 8a6645ffd938..dceeed207569 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1237,7 +1237,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num)
>  	struct ucsi_connector *con = &ucsi->connector[num - 1];
>  
>  	if (!(ucsi->ntfy & UCSI_ENABLE_NTFY_CONNECTOR_CHANGE)) {
> -		dev_dbg(ucsi->dev, "Bogus connector change event\n");
> +		dev_dbg(ucsi->dev, "Early connector change event\n");
>  		return;
>  	}
>  
> @@ -1636,6 +1636,7 @@ static int ucsi_init(struct ucsi *ucsi)
>  {
>  	struct ucsi_connector *con, *connector;
>  	u64 command, ntfy;
> +	u32 cci;
>  	int ret;
>  	int i;
>  
> @@ -1688,6 +1689,13 @@ static int ucsi_init(struct ucsi *ucsi)
>  
>  	ucsi->connector = connector;
>  	ucsi->ntfy = ntfy;
> +
> +	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
> +	if (ret)
> +		return ret;
> +	if (UCSI_CCI_CONNECTOR(READ_ONCE(cci)))
> +		ucsi_connector_change(ucsi, cci);
> +

I think this leaves place for the race. With this patchset + "Ack
connector change early" in place Neil triggered the following backtrace
on sm8550 HDK while testing my UCSI-qcom-fixes patchset:
What happens:

[   10.421640] write: 00000000: 05 00 e7 db 00 00 00 00

SET_NOTIFICATION_ENABLE

[   10.432359] read: 00000000: 10 01 00 00 00 00 00 80 00 00 00 00 00 00 00 00
[   10.469553] read: 00000010: 04 58 29 20 00 00 00 00 00 00 00 00 00 03 30 01
[   10.476783] read: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   10.489552] notify: 00000000: 00 00 00 80

COMMAND_COMPLETE

[   10.494194] read: 00000000: 10 01 00 00 00 00 00 80 00 00 00 00 00 00 00 00
[   10.501370] read: 00000010: 04 58 29 20 00 00 00 00 00 00 00 00 00 03 30 01
[   10.508578] read: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   10.515757] write: 00000000: 04 00 02 00 00 00 00 00

ACK_CC_CI(command completed)

[   10.521100] read: 00000000: 10 01 00 00 00 00 00 20 00 00 00 00 00 00 00 00
[   10.528363] read: 00000010: 04 58 29 20 00 00 00 00 00 00 00 00 00 03 30 01
[   10.535603] read: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   10.549549] notify: 00000000: 00 00 00 20

ACK_COMPLETE

[Here ucsi->connector and ucsi->ntfy are being set by ucsi_init()

[   10.566654] read: 00000010: 04 58 29 20 00 00 00 00 00 00 00 00 00 03 30 01
[   10.593553] notify: 00000000: 02 00 00 20

Event with CONNECTION_CHANGE. It also schedules connector_change work,
because ucsi->ntfy is already set

[   10.595796] read: 00000000: 10 01 00 00 02 00 00 20 00 00 00 00 00 00 00 00
[   10.595798] read: 00000010: 04 58 29 20 00 00 00 00 00 00 00 00 00 03 30 01
[   10.595799] read: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

The CCI read coming from ucsi_init()

[   10.595807] ------------[ cut here ]------------
[   10.595808] WARNING: CPU: 6 PID: 101 at kernel/workqueue.c:2384 __queue_work+0x374/0x474

[skipped the register dump]

[   10.595953]  __queue_work+0x374/0x474
[   10.595956]  queue_work_on+0x68/0x84
[   10.595959]  ucsi_connector_change+0x54/0x88 [typec_ucsi]
[   10.595963]  ucsi_init_work+0x834/0x85c [typec_ucsi]
[   10.595968]  process_one_work+0x148/0x29c
[   10.595971]  worker_thread+0x2fc/0x40c
[   10.595974]  kthread+0x110/0x114
[   10.595978]  ret_from_fork+0x10/0x20
[   10.595985] ---[ end trace 0000000000000000 ]---

Warning, because the work is already scheduled.


>  	return 0;
>  
>  err_unregister:
> -- 
> 2.40.1
> 


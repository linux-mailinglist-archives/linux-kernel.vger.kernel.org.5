Return-Path: <linux-kernel+bounces-19771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AECA982731F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12621C226B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6BB51C31;
	Mon,  8 Jan 2024 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljoqMHdB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24250269;
	Mon,  8 Jan 2024 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d4a2526a7eso6436535ad.3;
        Mon, 08 Jan 2024 07:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704727745; x=1705332545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqRJScu1v/mtQv0Lb/QGN3Zy9dWTkVSIA3r/EgRg96k=;
        b=ljoqMHdB7h/m1UPvtbkVUmIjDJtb1CoGxpj6CeXPCrJdcF4V5Bnvkm37D/4TpV/pGi
         3FZa3XfB00JkkDRqsUc8VquaAepsPJRr4UEF2MdSQr/BJYBWUodff4L8ZwdzeWzEAygd
         Bx/3M+uqdQqYn4YXgZQmyZBIFv341vK8EJzP8NpmRTplD2RTiQartiarV/QxvLzdFB/q
         8xZ7z2zjB1pAYlFdrud3TqiTzYh0uemLA1SKlbYPPWRt8e99yweNT++jO5azfuXSVbfb
         O+t6nxHNmgV8Uy4ehEAjRaM3ulPWmef5Q0NTYQbWtHLyRHd5enwJoL/Hx3ZonQBhFfUO
         VGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704727745; x=1705332545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqRJScu1v/mtQv0Lb/QGN3Zy9dWTkVSIA3r/EgRg96k=;
        b=dqYbYq+eV0BGF/7PIeiQZ/c6DEDmy5Vnw4eK3CfCF0+T6VNGqLwLUZsJ5WZfbe9JlU
         AriYIDo4pNI/Av7myCOlbUzMc27UeT3kz8trHZpdjwMhrbNrQxd6ukshcFaGM0f2F0Z3
         rv+rQtpB7Vj2n0dhVPzLy9mnIYRBnEbcRcVOA7PTQF0rRhr47t46Q+ZQeFOlQOJEkWir
         hmb6cJJ+of8IAI8gBd78NyadYBatm3li/L3boXW9Vkr2jVpXALf3ozHVn9WbzcYK+dtN
         bPjX/aNF2DHgwDi7aBHFJK/Le4tkPq+2b1Y505P0BAZh+GJn0B+Cf3ybwa8g9m90ZVMx
         7aBw==
X-Gm-Message-State: AOJu0YwkyPoUWUwP+XRGjLdqSefKmkQZWGCix5Snd7pyJY4I50zLrUQW
	T3YMvWxX8rdXQGRuGIGTFPB9VZ9dxMs=
X-Google-Smtp-Source: AGHT+IF238K0PZUDhiOVmKQwNcTyXSi3rGmxGuSNcggMbz3gVHQwx9a0s2w/hl+GWhsqrP17fSCBbg==
X-Received: by 2002:a17:902:f545:b0:1d5:4b66:81c7 with SMTP id h5-20020a170902f54500b001d54b6681c7mr412777plf.65.1704727744938;
        Mon, 08 Jan 2024 07:29:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id je21-20020a170903265500b001cfc50e5afesm39437plb.23.2024.01.08.07.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 07:29:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 8 Jan 2024 07:29:03 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Aleksa Savic <savicaleksa83@gmail.com>
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (gigabyte_waterforce) Mark status report as
 received under a spinlock
Message-ID: <1eb8323b-6c5e-4646-8288-1e58ca7516e7@roeck-us.net>
References: <20231219143620.22179-1-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219143620.22179-1-savicaleksa83@gmail.com>

On Tue, Dec 19, 2023 at 03:36:19PM +0100, Aleksa Savic wrote:
> Through hidraw, userspace can cause a status report to be sent
> from the device. The parsing in waterforce_raw_event() may happen in
> parallel to a waterforce_get_status() call (which resets the completion
> for tracking the report) if it's running on a different CPU where
> bottom half interrupts are not disabled.
> 
> Add a spinlock around the complete_all() call in waterforce_raw_event()
> to prevent race issues.
> 
> Fixes: d5939a793693 ("hwmon: Add driver for Gigabyte AORUS Waterforce AIO coolers")
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
> Does the above make sense? The raw event parsing is a softirq AFAIK and
> presumably could run on a different CPU in parallel to a waterforce_get_status()
> call.
> 
> Appreciate thoughts on this.

I think it does. Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/gigabyte_waterforce.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/gigabyte_waterforce.c b/drivers/hwmon/gigabyte_waterforce.c
> index 1799377fc2f1..85e523775714 100644
> --- a/drivers/hwmon/gigabyte_waterforce.c
> +++ b/drivers/hwmon/gigabyte_waterforce.c
> @@ -276,8 +276,10 @@ static int waterforce_raw_event(struct hid_device *hdev, struct hid_report *repo
>  	priv->duty_input[0] = data[WATERFORCE_FAN_DUTY];
>  	priv->duty_input[1] = data[WATERFORCE_PUMP_DUTY];
>  
> +	spin_lock(&priv->status_report_request_lock);
>  	if (!completion_done(&priv->status_report_received))
>  		complete_all(&priv->status_report_received);
> +	spin_unlock(&priv->status_report_request_lock);
>  
>  	priv->updated = jiffies;
>  


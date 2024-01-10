Return-Path: <linux-kernel+bounces-21896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9428829638
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA35286A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224223EA73;
	Wed, 10 Jan 2024 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGYisLeb"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35ED3FB01;
	Wed, 10 Jan 2024 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e741123acso4269273e87.0;
        Wed, 10 Jan 2024 01:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704878557; x=1705483357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/cX7LhHOFu7/SWqzyr1HY0k2frn1F7ztP3n5/hwhKQ=;
        b=RGYisLebyQz3WOWIzUsYSkjmKkur4dmqoRpqhpTz1Ew/0STsC3czr0BYkSvgra12MK
         LBjtp8Z09Fa4lIhCqS4tY3cgCgxymoJmdatoiI37IbxMaERc88bG2X024v0yP6N1kbec
         n1dUODz+zabjqQxzpC3hmfKdMlD/3/DRN87ro7qLWD5lzIP50SXlCQsfzN6MPz2fmFL9
         qYPYx+7oQlDb6zSCPbVrlG9VUFdGqm56rWX1I5lyRB0wGn/A6/0iwawgczjFt7MTA+L2
         M6j0mgsh4C9jKwaXh/rjFDCUjLA3ol3/z8c7VL6NP+whWFdjY8Q25nictZaKFuDZmRlv
         VQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704878557; x=1705483357;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/cX7LhHOFu7/SWqzyr1HY0k2frn1F7ztP3n5/hwhKQ=;
        b=Cm7OYIw8jPxhAp9TAXybxPIQ5pdRKBy6S+k2yrxIl55oW5q2CMcXcKmJxDHsUkXJJs
         JpuAaZLEnDygfNF3E4INQbqN0mNZSSlxrSvDXgOs0KrIGIA2Pr0dhsA5dcSY62D08mwo
         P0+xht6/CBGWyY/Or3YLkOlT4Cy9wW5zGjNErPQz8eS1LwTpufh9vD4VpuK75jzS3d/b
         9ZpJAWCD8IUIP78zjEDfV7xyZLYai/wI47XiSFDmphsppR5qAtazUjpFYseB0LsCza24
         yrd2SUXHSRPe/xXM0hA69C/GlJI98wcT5Ti71MJ/CmyZPHn2+yi+8g3xmlkz706RTqai
         tWbA==
X-Gm-Message-State: AOJu0YxrLfkubGGDrsB5gf2gMOh6jhyk1dsXVV5SMn/lR7GAARTjDUm5
	CAAPtPf/BD01JAZmzcX3A/EtAkW/M2M=
X-Google-Smtp-Source: AGHT+IG705GfnTGOKqaWb7fp2idlD7S4ghIOQnyTKmhk73jZ37PWMTPM+ZVnwFEa/YppiutnkSquyw==
X-Received: by 2002:ac2:4e8d:0:b0:50e:ac2a:6b6d with SMTP id o13-20020ac24e8d000000b0050eac2a6b6dmr214375lfr.119.1704878557121;
        Wed, 10 Jan 2024 01:22:37 -0800 (PST)
Received: from [192.168.1.105] ([178.176.72.35])
        by smtp.gmail.com with ESMTPSA id n7-20020a05651203e700b0050e84a3d75bsm605855lfq.254.2024.01.10.01.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 01:22:36 -0800 (PST)
Subject: Re: [PATCH v4] usb: core: Prevent null pointer dereference in
 update_port_device_state
To: Udipto Goswami <quic_ugoswami@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240110091422.25347-1-quic_ugoswami@quicinc.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <4e272d5d-ec19-7621-1346-4363b0070b1c@gmail.com>
Date: Wed, 10 Jan 2024 12:22:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240110091422.25347-1-quic_ugoswami@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 1/10/24 12:14 PM, Udipto Goswami wrote:

> Currently,the function update_port_device_state gets the usb_hub from

   Need space between comma and "the"...

> udev->parent by calling usb_hub_to_struct_hub.
> However, in case the actconfig or the maxchild is 0, the usb_hub would
> be NULL and upon further accessing to get port_dev would result in null
> pointer dereference.
> 
> Fix this by introducing an if check after the usb_hub is populated.
> 
> Fixes: 83cb2604f641 ("usb: core: add sysfs entry for usb device state")
> Cc: stable@vger.kernel.org
> Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
[...]

> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index ffd7c99e24a3..5ba1875e6bf4 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2053,9 +2053,22 @@ static void update_port_device_state(struct usb_device *udev)
>  
>  	if (udev->parent) {
>  		hub = usb_hub_to_struct_hub(udev->parent);
> -		port_dev = hub->ports[udev->portnum - 1];
> -		WRITE_ONCE(port_dev->state, udev->state);
> -		sysfs_notify_dirent(port_dev->state_kn);
> +
> +		/*
> +		 * The Link Layer Validation System Driver (lvstest)
> +		 * has step to unbind the hub before running the rest
> +		 * of the procedure. This triggers hub_disconnect which
> +		 * will set the hub's maxchild to 0, further resulting

   Resulting in.

> +		 * usb_hub_to_struct_hub returning NULL.
> +		 *
> +		 * Add if check to avoid running into NULL pointer
> +		 * de-reference.

   This is obvious from the code below, I think...

> +		 */
> +		if (hub) {
> +			port_dev = hub->ports[udev->portnum - 1];
> +			WRITE_ONCE(port_dev->state, udev->state);
> +			sysfs_notify_dirent(port_dev->state_kn);
> +		}
>  	}
>  }
>  

MBR, Sergey


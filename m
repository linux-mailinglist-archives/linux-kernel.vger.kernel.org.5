Return-Path: <linux-kernel+bounces-95491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DED874E46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA611F26B29
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DA812C7EE;
	Thu,  7 Mar 2024 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHhltuhl"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A82412AAC8;
	Thu,  7 Mar 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812256; cv=none; b=Th4XkGVshkKTB3VmvcBnZ05SRq6apuNGDqCExADWn+l6j75ErUVnGiwHkWS3kVTznjY6+l0Q342iAd3Pi6bv19rQ74UPf/+78vkPMShlkZU8t90IC9uc9EQAP5Pwv/+d6egTn2lCwEmzH1DOgiJE+eUwNyDDDV3q0caY4WWVjPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812256; c=relaxed/simple;
	bh=GAfEjb2SPRCaXF6jGeW/oUlJyeqeOOyfbklHnoWeEdY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ddR3oYIGVj8nhJyYqxP9slDYkfvZoc3cEaRi8qwpNw4GuSpMM6/z+6fcosCGSHct1JyBbZ9Jb5ig52WgUDdgnmeMP7aFpcqrUhVeP1oPSmC2OJ2lGxRsR4rMCvWxPFCd3dE+z4SIc/Ho0PuWs9XEWgdhvsUJkBNyoBv2ZSmk6SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHhltuhl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-565d1656c12so1437253a12.1;
        Thu, 07 Mar 2024 03:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709812253; x=1710417053; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vtLsuUPmx2IluhdYnjBXoXR7vgR/v1KVphHws9j0Sg8=;
        b=gHhltuhlQFV8O41R7fNCnCrBKjt0Ch6BZbcSZ1gnaWFTBSxqFQXF7YMSomBcRHogKG
         6rIq4rrXS33cA4TuJahglI2paJOnqZiwidBmhB/Iv0Gc+6K6TCiPReVeq1oEb8lc6EAR
         2vEhC4od/9YSQCQzZ3UDsMOQQGcE7YItsJrHT4rWHumDSeA+IHjfgA0ROvEDP54FfP2w
         QrYZGO+i8UtZUzVfu3XGXrdPEl+roZ/LzNDbkWkMP7E0amHoPmXH2Mc7So99oN+tgAH6
         mXwGijqq/v9pyONFYTHazm3vzRJRz1H+UkddRdnJLEwuc7lZmVgifyxF5zQk8dWxWueU
         41BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709812253; x=1710417053;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vtLsuUPmx2IluhdYnjBXoXR7vgR/v1KVphHws9j0Sg8=;
        b=RB8RHwmLJaQcLxd+DpFKnQ/2s3nQbgqeht21g+bkyLXJjQhDvM34GzFE6ffP/H01A+
         3glkrx/t4ghbuQzsYlAZxfpUojRxJAwuYNy7TXVjvXoX4zyENE3IIzWIDCbQpLYItKLK
         iRd11JKsZ3kv7oiaLSj7FAGE8CVZI63/ickjPY+bxKZ8XcXPLYzou/yNbg/ix8Mj1yoT
         vzeUFe05NuGFkge6Emo6c3g/5lIQ02SpZlcalm37GMh0z+q/XZGiHy+32uWcZhgNPmRo
         rgKUUvfIq6+H5qaDfZELyneMIlKfDWgQm9q0r/1cdnNiX3Yst7WdODZM3kcMMibDSYJw
         OYLw==
X-Forwarded-Encrypted: i=1; AJvYcCWt79mgcykAMUfboz0UsuSziLQvHHl8HEAb447lHjLWnfavJpW5pp6zDjDxliXTEB7Jjo3Jz9+FZI9sxWoHb30ryme0Z1fVCtvF7RmXIeygntb2G1/1ZVnK2EXcby2WPf34/M806i8Nx4jsnsCanUBqqKDcIuG+PhYeX8yQaVsyxg==
X-Gm-Message-State: AOJu0YwJOM/j91eqT809cKXYDcIuJj/G1z4MeQIt6tLfBXJtZXhz4MXl
	TGDNdC4vJq+Ocb1NhMUknIx7Iir4irorBZbipm3sQG4DThPdPDl1DHvjoRdluzt/L8kI
X-Google-Smtp-Source: AGHT+IG4BuPOaEDO0OhzTYuW8xVEBGBnHgQgf9KSepkyWdhMbFEax2qipX/yzsTvIJ1bP18dXC4hXA==
X-Received: by 2002:a50:d797:0:b0:566:13f8:bcc with SMTP id w23-20020a50d797000000b0056613f80bccmr33881edi.0.1709812253290;
        Thu, 07 Mar 2024 03:50:53 -0800 (PST)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id ew5-20020a056402538500b005667a11b951sm7941605edb.86.2024.03.07.03.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:50:52 -0800 (PST)
Message-ID: <94997e8720bc0a68afa85be3ef521c8844d0f0a0.camel@gmail.com>
Subject: Re: [PATCH v5 1/2] driver core: Introduce device_link_wait_removal()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Saravana Kannan <saravanak@google.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
  Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  stable@vger.kernel.org
Date: Thu, 07 Mar 2024 12:50:52 +0100
In-Reply-To: <20240307111036.225007-2-herve.codina@bootlin.com>
References: <20240307111036.225007-1-herve.codina@bootlin.com>
	 <20240307111036.225007-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Herve,


On Thu, 2024-03-07 at 12:10 +0100, Herve Codina wrote:
> The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> introduces a workqueue to release the consumer and supplier devices used
> in the devlink.
> In the job queued, devices are release and in turn, when all the
> references to these devices are dropped, the release function of the
> device itself is called.
>=20
> Nothing is present to provide some synchronisation with this workqueue
> in order to ensure that all ongoing releasing operations are done and
> so, some other operations can be started safely.
>=20
> For instance, in the following sequence:
> =C2=A0 1) of_platform_depopulate()
> =C2=A0 2) of_overlay_remove()
>=20
> During the step 1, devices are released and related devlinks are removed
> (jobs pushed in the workqueue).
> During the step 2, OF nodes are destroyed but, without any
> synchronisation with devlink removal jobs, of_overlay_remove() can raise
> warnings related to missing of_node_put():
> =C2=A0 ERROR: memory leak, expected refcount 1 instead of 2
>=20
> Indeed, the missing of_node_put() call is going to be done, too late,
> from the workqueue job execution.
>=20
> Introduce device_link_wait_removal() to offer a way to synchronize
> operations waiting for the end of devlink removals (i.e. end of
> workqueue jobs).
> Also, as a flushing operation is done on the workqueue, the workqueue
> used is moved from a system-wide workqueue to a local one.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> ---
> =C2=A0drivers/base/core.c=C2=A0=C2=A0=C2=A0 | 26 +++++++++++++++++++++++-=
--
> =C2=A0include/linux/device.h |=C2=A0 1 +
> =C2=A02 files changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d5f4e4aac09b..48b28c59c592 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> =C2=A0static void __fw_devlink_link_to_consumers(struct device *dev);
> =C2=A0static bool fw_devlink_drv_reg_done;
> =C2=A0static bool fw_devlink_best_effort;
> +static struct workqueue_struct *device_link_wq;
> =C2=A0
> =C2=A0/**
> =C2=A0 * __fwnode_link_add - Create a link between two fwnode_handles.
> @@ -532,12 +533,26 @@ static void devlink_dev_release(struct device *dev)
> =C2=A0	/*
> =C2=A0	 * It may take a while to complete this work because of the SRCU
> =C2=A0	 * synchronization in device_link_release_fn() and if the consumer=
 or
> -	 * supplier devices get deleted when it runs, so put it into the "long"
> -	 * workqueue.
> +	 * supplier devices get deleted when it runs, so put it into the
> +	 * dedicated workqueue.
> =C2=A0	 */
> -	queue_work(system_long_wq, &link->rm_work);
> +	queue_work(device_link_wq, &link->rm_work);
> =C2=A0}
> =C2=A0
> +/**
> + * device_link_wait_removal - Wait for ongoing devlink removal jobs to t=
erminate
> + */
> +void device_link_wait_removal(void)
> +{
> +	/*
> +	 * devlink removal jobs are queued in the dedicated work queue.
> +	 * To be sure that all removal jobs are terminated, ensure that any
> +	 * scheduled work has run to completion.
> +	 */
> +	flush_workqueue(device_link_wq);
> +}
> +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> +
> =C2=A0static struct class devlink_class =3D {
> =C2=A0	.name =3D "devlink",
> =C2=A0	.dev_groups =3D devlink_groups,
> @@ -4099,9 +4114,14 @@ int __init devices_init(void)
> =C2=A0	sysfs_dev_char_kobj =3D kobject_create_and_add("char", dev_kobj);
> =C2=A0	if (!sysfs_dev_char_kobj)
> =C2=A0		goto char_kobj_err;
> +	device_link_wq =3D alloc_workqueue("device_link_wq", 0, 0);

My rb tag was with the assumption this is moved into devlink_class_init(). =
IIUC,
Saravana also agreed with that [1]. But it looks like he missed that we are
allocating the queue in devices_init() and not in devlink_class_init().

I'm also not sure if this is in line with what Rafael wanted for ccing stab=
le. How do
we know the next patch depends on this one?

[1]: https://lore.kernel.org/lkml/CAGETcx_gNWOTsSZMaZu+XU1-5Z60WEcMhw08t4Sn=
_-YgkCCUmA@mail.gmail.com/

- Nuno S=C3=A1




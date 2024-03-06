Return-Path: <linux-kernel+bounces-93609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 443C1873250
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8E928F0E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294605DF33;
	Wed,  6 Mar 2024 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRxGB1XN"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238195DF0D;
	Wed,  6 Mar 2024 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716624; cv=none; b=ub2KQYt45q7TbY8kNhGH+ZuYpCdtZqUVz3aHoM6qQAzvu3LsSnxuA3j3mPAvybV6PnW7DJYh3wvnjgCBt1NGEzQ9jiI86ahxgIHaA/Y/yaKht9MNj/AhF37mpBaULefQhde/N2bv8wtGyv1LHFaEYmkYldv1xigkaIX7dq6uKMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716624; c=relaxed/simple;
	bh=tbPgPGFVnt1vtTVYbvkg8PPZSeE+nmVPlPTE7uHHRe0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LqVD+qzLr9wyaxlwCgCfSdbrMmP4/iiVYmZciz/8s0rBNtLUG+rYg6oO+mlgiPqmk6B4/HfXNq1o8wHJ7EFa7eYWxOxie7BKYbwFw37etgzbVW7GQ8CjRmnEoDl/WsVLr3FCEJTxM+FU4Mt5ZHh3xP05IeSLcY+NtO4LVZMoIdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRxGB1XN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56454c695e6so1106114a12.0;
        Wed, 06 Mar 2024 01:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709716620; x=1710321420; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SCYMpYXG3st4bKv2ILr3sPpiHbuDCWZBcXzngQOpnDs=;
        b=CRxGB1XNAeWObzfpugCZPdsOK0XsJ4crV7GbXuZHhcpgoHjIvsHrotT7lXI+6TdpNU
         cHF/4dFAMj4FezVfYNpAwjbDsuHQlSLgK+oAGBvG7rm72AK1RKjonE89cgMAeesPLjtF
         B6Dg11hJtFsYd6dPuomHnkhHRj/u3T0bqldyUtY8u+IAR4nGpBU/i4EBUY0Kf3YJ82Qf
         UFA690Leob35aCSJKbSvRXmsg8zX8hQsSakWCwCb8JDTbyc7Y2MyAEUq+uMbucylydlY
         1NVhL+nJPwr7F8phqA3bDnempzKP2qYbH4eNO9Jw/9XMIMsIRsLqGdOFBn33uUNGyAz3
         kjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709716620; x=1710321420;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SCYMpYXG3st4bKv2ILr3sPpiHbuDCWZBcXzngQOpnDs=;
        b=KxkJSLFNkQJmtiA687nRg86VQPtqiiEo6U17CFowh1Fk7lzJe460QYEEtVCZongLF1
         H6bBPNFMKRLQvB+Rpko7b3L1qhcmVZMKRR3lS/TB62eGyvMqjUGQEtmC5xxK6rolkYUn
         JGdmYcu9zeBVDEbxEn7OL5Kz3rtvw018Slj547E118naMOX/gfrs799d6iWPXDivXseG
         SCkajmdbNZRoB89zlpdVrvqpMqtqBN4y+xNGeb7g4sb81Qol+rHXhtIZco0KZMmqW/LS
         eQ5mlMTdRL8J6ujd5mpovlz0rfqJSGmuJXnSJ9Tfq0Os3buhht1jBAb+NGQTQ5yAtriC
         28Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU8uofku1fxmEvb+61sF4TAzv8Tyn4XnZKQOilxlKJ7KLATHDvxMn3zrWJDYhjZw+NPw5f+BRlc5LwGQfVMT25SnAsWZ6DylMnMvkAMH+ml4MmA60lCCrW79Ypi1+1Mjwf+Ws7STuEDVdBrtbVbpIvrYeAcFql8KGRxtXVE4Kj3DQ==
X-Gm-Message-State: AOJu0YylTaUt5t/3eV7o1jl6UHbXXQ38RSVQJ1T3A0tCmFfeDy1DXLB9
	vt6u/H02iT3OU+LfsUi6YawlQttyibnpJPNQcW2a7TQ2Nr0rIhl1
X-Google-Smtp-Source: AGHT+IGUDiMb8ahdMX3evZg75AlskwZSyQPf90P6BuETFpKyHMiR6FtoQJFCCL0ZZx+eyNB6efJrgA==
X-Received: by 2002:a05:6402:12d6:b0:565:4b37:4578 with SMTP id k22-20020a05640212d600b005654b374578mr5432080edx.14.1709716620100;
        Wed, 06 Mar 2024 01:17:00 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id g3-20020a056402180300b00566ea8e9f38sm5239615edy.40.2024.03.06.01.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 01:16:59 -0800 (PST)
Message-ID: <1fff8742a13c28dd7e1dda47ad2d6fa8e21e421e.camel@gmail.com>
Subject: Re: [PATCH v4 1/2] driver core: Introduce device_link_wait_removal()
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
Date: Wed, 06 Mar 2024 10:20:24 +0100
In-Reply-To: <20240306085007.169771-2-herve.codina@bootlin.com>
References: <20240306085007.169771-1-herve.codina@bootlin.com>
	 <20240306085007.169771-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-06 at 09:50 +0100, Herve Codina wrote:
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
> Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---

With the below addressed:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

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
> -	 * supplier devices get deleted when it runs, so put it into the
> "long"
> -	 * workqueue.
> +	 * supplier devices get deleted when it runs, so put it into the
> +	 * dedicated workqueue.
> =C2=A0	 */
> -	queue_work(system_long_wq, &link->rm_work);
> +	queue_work(device_link_wq, &link->rm_work);
> =C2=A0}
> =C2=A0
> +/**
> + * device_link_wait_removal - Wait for ongoing devlink removal jobs to
> terminate
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
> +	if (!device_link_wq)
> +		goto wq_err;
> =C2=A0

I can't still agree with this. Why not doing it in devlink_class_init()? Th=
is is
devlink specific so it makes complete sense to me.

Note that this maybe the 3/4 time I'm arguing in here. If you don't agree p=
lease
tell me why and I may agree with you :).

(and sorry if you already said something about it and I missed)

- Nuno S=C3=A1
>=20



Return-Path: <linux-kernel+bounces-93187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A79BF872C07
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC541F244F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467006FBD;
	Wed,  6 Mar 2024 01:21:57 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1FDA50
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688116; cv=none; b=ah1ByqYtaohoZmvq7joJXbrvsRCe5GbWGyPTg5bpwujvNSqnTkPQwjrKQTUgwIxM1XXb+sjMgNFuJXZOfYRZt2OJ/rsYiCvC4tjcVgU9dRBX8DWyKsqbz9w4n/Bsg53TT/r65/PNCi8s0ZymkDx8utUTKoOnfghyUdVLHotTi6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688116; c=relaxed/simple;
	bh=Y0mXW4p+zCBSuWaP3zmYDPSxRg0kMzt8nr4tJ39mBk8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HN8DEe6lGkxN+KJRmpRiwOErMXbwDPiDClNoxV4U8U8+tL4PbwEBDfbK2OIkTOdPNmQT2+i8rEtp8TLri/iWIbkIy9ELnOKyCLx0fsKxXBzuyVq/Yx2YqJolPWUdMFe0pyr07DPNk7Q0vhsHKbU59d6LVcCXATGA9SAVWgAAFDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TqF3d4hMlzNlsR;
	Wed,  6 Mar 2024 09:20:13 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B7F4140114;
	Wed,  6 Mar 2024 09:21:51 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 09:21:50 +0800
Subject: Re: [PATCH] mtd: ubi: make ubi_class constant
To: "Ricardo B. Marliere" <ricardo@marliere.net>, Richard Weinberger
	<richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh
 Raghavendra <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240305-class_cleanup-mtd-v1-1-7861914e2218@marliere.net>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <0e612171-d3f0-f284-12b7-373f4da350d3@huawei.com>
Date: Wed, 6 Mar 2024 09:21:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305-class_cleanup-mtd-v1-1-7861914e2218@marliere.net>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/3/6 3:35, Ricardo B. Marliere Ð´µÀ:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the ubi_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>   drivers/mtd/ubi/build.c | 2 +-
>   drivers/mtd/ubi/ubi.h   | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index 7d4ff1193db6..1938b61e1b74 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -111,7 +111,7 @@ static struct attribute *ubi_class_attrs[] = {
>   ATTRIBUTE_GROUPS(ubi_class);
>   
>   /* Root UBI "class" object (corresponds to '/<sysfs>/class/ubi/') */
> -struct class ubi_class = {
> +const struct class ubi_class = {
>   	.name		= UBI_NAME_STR,
>   	.class_groups	= ubi_class_groups,
>   };
> diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
> index 0b42bb45dd84..21c3208a9210 100644
> --- a/drivers/mtd/ubi/ubi.h
> +++ b/drivers/mtd/ubi/ubi.h
> @@ -812,7 +812,7 @@ extern struct kmem_cache *ubi_wl_entry_slab;
>   extern const struct file_operations ubi_ctrl_cdev_operations;
>   extern const struct file_operations ubi_cdev_operations;
>   extern const struct file_operations ubi_vol_cdev_operations;
> -extern struct class ubi_class;
> +extern const struct class ubi_class;
>   extern struct mutex ubi_devices_mutex;
>   extern struct blocking_notifier_head ubi_notifiers;
>   
> 
> ---
> base-commit: 77bf032528393d2dc9430b3cea1fee8d0762a86f
> change-id: 20240305-class_cleanup-mtd-b7dfe2ea8c26
> 
> Best regards,
> 



Return-Path: <linux-kernel+bounces-92425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FFB871FFA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D57AB216C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8C485C4E;
	Tue,  5 Mar 2024 13:21:44 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D15381E;
	Tue,  5 Mar 2024 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644904; cv=none; b=Juawz18U8MYCeBaPx9iFw5q15+dVqrmkxuITPaKVR+nQAmzJRa64Ca71nNpLAuYhwfZHOSgqCCYcEdCOIUu4+/O2EYN+K2O0JpD9U1lTqNkYPii/8gmxZxI41/pkie1lGwm0tsl86EOHMbjPzJJqMLJT/OiAMOB0NxLjKAyeFJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644904; c=relaxed/simple;
	bh=Zsna3w0baJEu+CkVxCY9YDcgalMpnPzFpi6Ywn8rmb0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VSkh3i2Wda4dhBKpplNeBCifDrNWXZsztZl/2NeSO9KKXs1KLWYj82/uSFz39P/Ieo8yo2vZSR4AM3DDpIJ9Ym9FryC3NBvVsidnSbc42fKSzfmmY2Ghg2UXgBjLpAjCuhKEaKJb06Z4abGxZwlGBpB2LbDiAgcA6LCrAHoVtSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Tpx3n5c24z1Q9l3;
	Tue,  5 Mar 2024 21:19:17 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 783061A016E;
	Tue,  5 Mar 2024 21:21:38 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:21:38 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:21:37 +0800
Subject: Re: [PATCH 6/6] scsi: isci: Use LIBSAS_SHT_BASE
To: John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
	<jinpu.wang@cloud.ionos.com>, <artur.paszkiewicz@intel.com>,
	<dlemoal@kernel.org>, <ipylypiv@google.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240305122452.340471-1-john.g.garry@oracle.com>
 <20240305122452.340471-7-john.g.garry@oracle.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <e3fcc620-d803-c8e3-651b-9781ecd8e87a@huawei.com>
Date: Tue, 5 Mar 2024 21:21:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305122452.340471-7-john.g.garry@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/5 20:24, John Garry wrote:
> Use standard template for scsi_host_template structure to reduce
> duplication.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/isci/init.c | 22 +---------------------
>   1 file changed, 1 insertion(+), 21 deletions(-)
> 
> diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
> index d0a23ce4afba..49e64232def1 100644
> --- a/drivers/scsi/isci/init.c
> +++ b/drivers/scsi/isci/init.c
> @@ -155,31 +155,11 @@ static const struct attribute_group *isci_sdev_groups[] = {
>   };
>   
>   static const struct scsi_host_template isci_sht = {
> -
> -	.module				= THIS_MODULE,
> -	.name				= DRV_NAME,
> -	.proc_name			= DRV_NAME,
> -	.queuecommand			= sas_queuecommand,
> -	.dma_need_drain			= ata_scsi_dma_need_drain,
> -	.target_alloc			= sas_target_alloc,
> -	.slave_configure		= sas_slave_configure,
> +	LIBSAS_SHT_BASE
>   	.scan_finished			= isci_host_scan_finished,
>   	.scan_start			= isci_host_start,
> -	.change_queue_depth		= sas_change_queue_depth,
> -	.bios_param			= sas_bios_param,
>   	.can_queue			= ISCI_CAN_QUEUE_VAL,
> -	.this_id			= -1,
>   	.sg_tablesize			= SG_ALL,
> -	.max_sectors			= SCSI_DEFAULT_MAX_SECTORS,

max_sectors is not defined in LIBSAS_SHT_BASE.

Thanks,
Jaosn

> -	.eh_abort_handler		= sas_eh_abort_handler,
> -	.eh_device_reset_handler        = sas_eh_device_reset_handler,
> -	.eh_target_reset_handler        = sas_eh_target_reset_handler,
> -	.slave_alloc			= sas_slave_alloc,
> -	.target_destroy			= sas_target_destroy,
> -	.ioctl				= sas_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl			= sas_ioctl,
> -#endif
>   	.shost_groups			= isci_host_groups,
>   	.sdev_groups			= isci_sdev_groups,
>   	.track_queue_depth		= 1,
> 


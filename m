Return-Path: <linux-kernel+bounces-92423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC3E871FEF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5822877E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D8485947;
	Tue,  5 Mar 2024 13:19:27 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874335381E;
	Tue,  5 Mar 2024 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644767; cv=none; b=im8DK/PxE0KvBNNsmORGPqUWL3BUAlSB9i1VrYSTeQ2xoxHM2vfYbEn4k75cXiwZy5ej1rUu5de5XwgTF5zu/7auBuMzTVhIL5c0Ut9NUsldLELXdN5NdCY3o4q5yBrOedxp9lk8g/1rF9zJq6m7jY+Lzdk+w+ip0Qi50QwEx+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644767; c=relaxed/simple;
	bh=5dvzbaUABGmZglbR4UQH63OsA3I6euQSwrr+nKFycSw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=h8sJSvSI7/R6XGlMjInIgbbPngkQgEPiJbOc7J/+HYUG+WfxTQo5mSR7muwvWyAjJhuP1hbXKz2gLAiIZ0jQ2PR5Jtl3gLWmv9f3i8pQwG4OqRqRso2PQPmQSVWEPUZ7a5OV7xEXvEychyx5SGLY8FlYJ98FyOrIMQMwx0SLZz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Tpx1G5ChQzwPF8;
	Tue,  5 Mar 2024 21:17:06 +0800 (CST)
Received: from canpemm100001.china.huawei.com (unknown [7.192.105.122])
	by mail.maildlp.com (Postfix) with ESMTPS id 45E3D1400C8;
	Tue,  5 Mar 2024 21:19:23 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100001.china.huawei.com (7.192.105.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:19:23 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:19:22 +0800
Subject: Re: [PATCH 5/6] scsi: mvsas: Use LIBSAS_SHT_BASE
To: John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
	<jinpu.wang@cloud.ionos.com>, <artur.paszkiewicz@intel.com>,
	<dlemoal@kernel.org>, <ipylypiv@google.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240305122452.340471-1-john.g.garry@oracle.com>
 <20240305122452.340471-6-john.g.garry@oracle.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <8834df38-413d-855c-433c-653d7023dc8b@huawei.com>
Date: Tue, 5 Mar 2024 21:19:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305122452.340471-6-john.g.garry@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/5 20:24, John Garry wrote:
> Use standard template for scsi_host_template structure to reduce
> duplication.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/mvsas/mv_init.c | 19 +------------------
>   1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> index f1090bb5f2c9..c792e4486e54 100644
> --- a/drivers/scsi/mvsas/mv_init.c
> +++ b/drivers/scsi/mvsas/mv_init.c
> @@ -31,28 +31,11 @@ static const struct attribute_group *mvst_sdev_groups[];
>   #define SOC_SAS_NUM 2
>   
>   static const struct scsi_host_template mvs_sht = {
> -	.module			= THIS_MODULE,
> -	.name			= DRV_NAME,
> -	.queuecommand		= sas_queuecommand,
> -	.dma_need_drain		= ata_scsi_dma_need_drain,
> -	.target_alloc		= sas_target_alloc,
> -	.slave_configure	= sas_slave_configure,
> +	LIBSAS_SHT_BASE
>   	.scan_finished		= mvs_scan_finished,
>   	.scan_start		= mvs_scan_start,
> -	.change_queue_depth	= sas_change_queue_depth,
> -	.bios_param		= sas_bios_param,
>   	.can_queue		= 1,
> -	.this_id		= -1,
>   	.sg_tablesize		= SG_ALL,
> -	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
> -	.eh_device_reset_handler = sas_eh_device_reset_handler,
> -	.eh_target_reset_handler = sas_eh_target_reset_handler,
> -	.slave_alloc		= sas_slave_alloc,
> -	.target_destroy		= sas_target_destroy,
> -	.ioctl			= sas_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl		= sas_ioctl,
> -#endif
>   	.shost_groups		= mvst_host_groups,
>   	.sdev_groups		= mvst_sdev_groups,
>   	.track_queue_depth	= 1,
> 

Doesn't hvae ->eh_abort_handler too.

Thanks,
Jason


Return-Path: <linux-kernel+bounces-92421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00331871FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E6C287EDB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9360C85953;
	Tue,  5 Mar 2024 13:18:09 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499B85920;
	Tue,  5 Mar 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644689; cv=none; b=G1+4LdNlvDNa3O4otQa2H9Kh8vRZI/7z+WVB6wG6Fc/i5S/gWjCkFtCAzpzhbuH8vxmKMgrh++mrowQ37+FT7Iuz79pWmov7I7bL44Z6waMswCwbjXqCA45eUu6ssXOBYAaqj0lJI8DmOxNxL0lnTd9ra6gc5tMZqr0azAgXJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644689; c=relaxed/simple;
	bh=rTVx3vnuzXzSdWk3HXicjemCJcYYPy1I/GQBPyfPXLU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iEdPODPNNHFCPeA3caiFwFga7ZTuJAo/Z+UkNPEBLhDaY363ObF97NkA/bNj9Ll+4BRWG3zuHHzoOMYgQu61TbgmfbvmeqFrktY5qEJu20ZiRjumKGmbtK12zyKyodkoakgUv94J0uDd+Zc37ETK22ce54/JQ824bdpazP+Y7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Tpx073jDWz1Q9GW;
	Tue,  5 Mar 2024 21:16:07 +0800 (CST)
Received: from canpemm100003.china.huawei.com (unknown [7.192.104.85])
	by mail.maildlp.com (Postfix) with ESMTPS id 10D851400C8;
	Tue,  5 Mar 2024 21:18:04 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100003.china.huawei.com (7.192.104.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:18:03 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:18:03 +0800
Subject: Re: [PATCH 3/6] scsi: hisi_sas: Use LIBSAS_SHT_BASE_NO_SLAVE_INIT
To: John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
	<jinpu.wang@cloud.ionos.com>, <artur.paszkiewicz@intel.com>,
	<dlemoal@kernel.org>, <ipylypiv@google.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240305122452.340471-1-john.g.garry@oracle.com>
 <20240305122452.340471-4-john.g.garry@oracle.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <26ff4850-2ff8-1625-cf97-6fbf063e26c7@huawei.com>
Date: Tue, 5 Mar 2024 21:18:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305122452.340471-4-john.g.garry@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/5 20:24, John Garry wrote:
> Use standard template for scsi_host_template structure to reduce
> duplication.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 18 +-----------------
>   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 18 +-----------------
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 18 +-----------------
>   3 files changed, 3 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> index 3c555579f9a1..161feae3acab 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> @@ -1735,28 +1735,12 @@ static struct attribute *host_v1_hw_attrs[] = {
>   ATTRIBUTE_GROUPS(host_v1_hw);
>   
>   static const struct scsi_host_template sht_v1_hw = {
> -	.name			= DRV_NAME,
> -	.proc_name		= DRV_NAME,
> -	.module			= THIS_MODULE,
> -	.queuecommand		= sas_queuecommand,
> -	.dma_need_drain		= ata_scsi_dma_need_drain,
> -	.target_alloc		= sas_target_alloc,
> +	LIBSAS_SHT_BASE_NO_SLAVE_INIT
>   	.slave_configure	= hisi_sas_slave_configure,
>   	.scan_finished		= hisi_sas_scan_finished,
>   	.scan_start		= hisi_sas_scan_start,
> -	.change_queue_depth	= sas_change_queue_depth,
> -	.bios_param		= sas_bios_param,
> -	.this_id		= -1,
>   	.sg_tablesize		= HISI_SAS_SGE_PAGE_CNT,
> -	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
> -	.eh_device_reset_handler = sas_eh_device_reset_handler,
> -	.eh_target_reset_handler = sas_eh_target_reset_handler,
>   	.slave_alloc		= hisi_sas_slave_alloc,
> -	.target_destroy		= sas_target_destroy,
> -	.ioctl			= sas_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl		= sas_ioctl,
> -#endif
>   	.shost_groups		= host_v1_hw_groups,
>   	.host_reset             = hisi_sas_host_reset,
>   };
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> index b5d379ebe05d..d89e97e8f5c2 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> @@ -3567,28 +3567,12 @@ static void map_queues_v2_hw(struct Scsi_Host *shost)
>   }
>   
>   static const struct scsi_host_template sht_v2_hw = {
> -	.name			= DRV_NAME,
> -	.proc_name		= DRV_NAME,
> -	.module			= THIS_MODULE,
> -	.queuecommand		= sas_queuecommand,
> -	.dma_need_drain		= ata_scsi_dma_need_drain,
> -	.target_alloc		= sas_target_alloc,
> +	LIBSAS_SHT_BASE_NO_SLAVE_INIT
>   	.slave_configure	= hisi_sas_slave_configure,
>   	.scan_finished		= hisi_sas_scan_finished,
>   	.scan_start		= hisi_sas_scan_start,
> -	.change_queue_depth	= sas_change_queue_depth,
> -	.bios_param		= sas_bios_param,
> -	.this_id		= -1,
>   	.sg_tablesize		= HISI_SAS_SGE_PAGE_CNT,
> -	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
> -	.eh_device_reset_handler = sas_eh_device_reset_handler,
> -	.eh_target_reset_handler = sas_eh_target_reset_handler,
>   	.slave_alloc		= hisi_sas_slave_alloc,
> -	.target_destroy		= sas_target_destroy,
> -	.ioctl			= sas_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl		= sas_ioctl,
> -#endif
>   	.shost_groups		= host_v2_hw_groups,
>   	.sdev_groups		= sdev_groups_v2_hw,
>   	.host_reset		= hisi_sas_host_reset,
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> index ebdfb7e7c88d..756660588a1e 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -3320,30 +3320,14 @@ static void hisi_sas_map_queues(struct Scsi_Host *shost)
>   }
>   
>   static const struct scsi_host_template sht_v3_hw = {
> -	.name			= DRV_NAME,
> -	.proc_name		= DRV_NAME,
> -	.module			= THIS_MODULE,
> -	.queuecommand		= sas_queuecommand,
> -	.dma_need_drain		= ata_scsi_dma_need_drain,
> -	.target_alloc		= sas_target_alloc,
> +	LIBSAS_SHT_BASE_NO_SLAVE_INIT
>   	.slave_configure	= slave_configure_v3_hw,
>   	.scan_finished		= hisi_sas_scan_finished,
>   	.scan_start		= hisi_sas_scan_start,
>   	.map_queues		= hisi_sas_map_queues,
> -	.change_queue_depth	= sas_change_queue_depth,
> -	.bios_param		= sas_bios_param,
> -	.this_id		= -1,
>   	.sg_tablesize		= HISI_SAS_SGE_PAGE_CNT,
>   	.sg_prot_tablesize	= HISI_SAS_SGE_PAGE_CNT,
> -	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
> -	.eh_device_reset_handler = sas_eh_device_reset_handler,
> -	.eh_target_reset_handler = sas_eh_target_reset_handler,
>   	.slave_alloc		= hisi_sas_slave_alloc,
> -	.target_destroy		= sas_target_destroy,
> -	.ioctl			= sas_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl		= sas_ioctl,
> -#endif
>   	.shost_groups		= host_v3_hw_groups,
>   	.sdev_groups		= sdev_groups_v3_hw,
>   	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
> 

Doesn't hvae ->eh_abort_handler too.

Thanks,
Jason


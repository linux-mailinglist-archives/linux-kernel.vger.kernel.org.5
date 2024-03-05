Return-Path: <linux-kernel+bounces-92418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F79871FE3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01788B23A8A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8220F85C5D;
	Tue,  5 Mar 2024 13:16:35 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAC58564E;
	Tue,  5 Mar 2024 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644595; cv=none; b=NrwB9U4IB5cL9Ew9UtfDl9RoOxdV9IMl7692YYu8t0zWw/anIv6qrvsx6GBWzLC4ESp6nZteN4NOCDJWzNUCN2g3crE7rk4OHvqp/FufZEZ+USusl629E+HzXdkaG4X3Nv4ZKzIEW1fRXCaqXSWdqSoYx5HjfYZHo2YIkiClGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644595; c=relaxed/simple;
	bh=WKfEsfkaVKY4/amekUGI/5KerGBch2I6fzFVvUSiONA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QUFIlQDv+XDcBETBOJIMiZj5G5q9k140UriwMzuSfULE2wFYtQenhsW/9klFfzXAA//wZaQ4dwFbw5eNBLaCcFS0GTCrm6lRV6NiWxlhEn6QcrbFNjE4q0VTd5houmsa/xjomxqi7aYZPPOlcjfQLF5Mpb3qx1WXdQbsG0ejbH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tpwxr2HNJz2Bf8B;
	Tue,  5 Mar 2024 21:14:08 +0800 (CST)
Received: from canpemm100006.china.huawei.com (unknown [7.192.104.17])
	by mail.maildlp.com (Postfix) with ESMTPS id A8798140485;
	Tue,  5 Mar 2024 21:16:13 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100006.china.huawei.com (7.192.104.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:16:13 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:16:12 +0800
Subject: Re: [PATCH 2/6] scsi: pm8001: Use LIBSAS_SHT_BASE
To: John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
	<jinpu.wang@cloud.ionos.com>, <artur.paszkiewicz@intel.com>,
	<dlemoal@kernel.org>, <ipylypiv@google.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240305122452.340471-1-john.g.garry@oracle.com>
 <20240305122452.340471-3-john.g.garry@oracle.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <096ae376-18d3-4edb-7a56-077a4eb02968@huawei.com>
Date: Tue, 5 Mar 2024 21:16:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305122452.340471-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/5 20:24, John Garry wrote:
> Use standard template for scsi_host_template structure to reduce
> duplication.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/pm8001/pm8001_init.c | 20 +-------------------
>   1 file changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index e6b1108f6117..1e63cb6cd8e3 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -110,29 +110,11 @@ static void pm8001_map_queues(struct Scsi_Host *shost)
>    * The main structure which LLDD must register for scsi core.
>    */
>   static const struct scsi_host_template pm8001_sht = {
> -	.module			= THIS_MODULE,
> -	.name			= DRV_NAME,
> -	.proc_name		= DRV_NAME,
> -	.queuecommand		= sas_queuecommand,
> -	.dma_need_drain		= ata_scsi_dma_need_drain,
> -	.target_alloc		= sas_target_alloc,
> -	.slave_configure	= sas_slave_configure,
> +	LIBSAS_SHT_BASE
>   	.scan_finished		= pm8001_scan_finished,
>   	.scan_start		= pm8001_scan_start,
> -	.change_queue_depth	= sas_change_queue_depth,
> -	.bios_param		= sas_bios_param,
>   	.can_queue		= 1,
> -	.this_id		= -1,
>   	.sg_tablesize		= PM8001_MAX_DMA_SG,
> -	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
> -	.eh_device_reset_handler = sas_eh_device_reset_handler,
> -	.eh_target_reset_handler = sas_eh_target_reset_handler,
> -	.slave_alloc		= sas_slave_alloc,
> -	.target_destroy		= sas_target_destroy,
> -	.ioctl			= sas_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl		= sas_ioctl,
> -#endif
>   	.shost_groups		= pm8001_host_groups,
>   	.sdev_groups		= pm8001_sdev_groups,
>   	.track_queue_depth	= 1,
> 

Sorry, I missed that this driver doesn't have ->eh_abort_handler. Please 
fix it.

Thanks,
Jason


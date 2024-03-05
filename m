Return-Path: <linux-kernel+bounces-92393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FF1871F84
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0548B1F23FC4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E187785927;
	Tue,  5 Mar 2024 12:52:13 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E78564B;
	Tue,  5 Mar 2024 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709643133; cv=none; b=WnUzWi8SGbgUtffH0njE1/hnoinFE8mUYB4+w1O+4/ZDysjlN9IxPSAkbHL760pgRqVvSHT1SNxJNgCgr6aXyIYJc8JfVBLfC3rUeHYRej6IQdJPJ4JCJWFKCyM2cO7MNOPmiZCvrHaXFvCks2KyEHeyu0Zw3gotNKljzfnl0aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709643133; c=relaxed/simple;
	bh=Oq3Nr6v/cxfjjX3RkVP0nSSWDlfWusHiA14ySNyAqPE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kXSYMXzR7+VIQbPg6LWgjFeMUG1B7K8AgJ3YDb9i/ktQNXbJydRILKqfFmp1xgzlGK29F+0BI1G8Xp5ciVxSoWLIeeiv8GF8rrKpzvZvYvITuYr55TyhlbYNQqne6pigW9moLN6SW1H3vNHQy5id6OeMW7sSy3hjalw0KJZLQy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TpwQb01Ysz1xq13;
	Tue,  5 Mar 2024 20:50:30 +0800 (CST)
Received: from canpemm100003.china.huawei.com (unknown [7.192.104.85])
	by mail.maildlp.com (Postfix) with ESMTPS id B3CF81402CE;
	Tue,  5 Mar 2024 20:52:07 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100003.china.huawei.com (7.192.104.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 20:52:07 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 20:52:06 +0800
Subject: Re: [PATCH 1/6] scsi: libsas: Add LIBSAS_SHT_BASE
To: John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
	<jinpu.wang@cloud.ionos.com>, <artur.paszkiewicz@intel.com>,
	<dlemoal@kernel.org>, <ipylypiv@google.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240305122452.340471-1-john.g.garry@oracle.com>
 <20240305122452.340471-2-john.g.garry@oracle.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <06a675d5-57c0-a241-cbe9-77f83988cbbe@huawei.com>
Date: Tue, 5 Mar 2024 20:52:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305122452.340471-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/5 20:24, John Garry wrote:
> There is much duplication in the scsi_host_template structure for the
> drivers which use libsas.
> 
> Similar to how a standard template is used in libata with __ATA_BASE_SHT,
> create a standard template in LIBSAS_SHT_BASE.
> 
> Don't set a default for max_sectors at SCSI_DEFAULT_MAX_SECTORS, as
> scsi_host_alloc() will default to this value automatically.
> 
> Even though some drivers don't set proc_name, it won't make much difference
> to set as DRV_NAME.
> 
> Also add LIBSAS_SHT_BASE_NO_SLAVE_INIT for the hisi_sas drivers which have
> custom .slave_alloc and .slave_configure methods.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   include/scsi/libsas.h | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index f5257103fdb6..484cab72e711 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -726,4 +726,34 @@ void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
>   void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
>   			   gfp_t gfp_flags);
>   
> +#define __LIBSAS_SHT_BASE						\
> +	.module				= THIS_MODULE,			\
> +	.name				= DRV_NAME,			\
> +	.proc_name			= DRV_NAME,			\
> +	.queuecommand			= sas_queuecommand,		\
> +	.dma_need_drain			= ata_scsi_dma_need_drain,	\
> +	.target_alloc			= sas_target_alloc,		\
> +	.change_queue_depth		= sas_change_queue_depth,	\
> +	.bios_param			= sas_bios_param,		\
> +	.this_id			= -1,				\
> +	.eh_abort_handler		= sas_eh_abort_handler,		\
> +	.eh_device_reset_handler	= sas_eh_device_reset_handler, 	\
> +	.eh_target_reset_handler	= sas_eh_target_reset_handler,	\
> +	.target_destroy			= sas_target_destroy,		\
> +	.ioctl				= sas_ioctl,			\
> +
> +#ifdef CONFIG_COMPAT
> +#define  _LIBSAS_SHT_BASE		__LIBSAS_SHT_BASE		\

Why two blanks after "define"?

> +	.compat_ioctl			= sas_ioctl,
> +#else
> +#define  _LIBSAS_SHT_BASE		__LIBSAS_SHT_BASE

Same as above.

Otherwise looks good to me.

Reviewed-by: Jason Yan <yanaijie@huawei.com>


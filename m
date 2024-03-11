Return-Path: <linux-kernel+bounces-98402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCDD8779A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 02:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1AF1C21192
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 01:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294AD5235;
	Mon, 11 Mar 2024 01:46:47 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7192919;
	Mon, 11 Mar 2024 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121606; cv=none; b=IR/EBhjnw9SHKZ+FftelHlQbRnY8A565Zo8ORwSiuXTKSggr7ZbYAu4pYv3QyRCyABtXGR7ZOTOqIhmLJZehHaxd5S0pIoDSp3vp9qBwFeb8UpNV3ybkHJj4LQFlYeuiYHaV5ghQUbzKy5uMzNoyX9b0fzeyeh6xBBq4bjLk3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121606; c=relaxed/simple;
	bh=RIu7MRdePbJEjk8rWnbql5et/GijQFHwwo53gnn4EzU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rjFPD+YTHMq9ScS6hxe5iyZ8kwMQkQKeiX6BulMD9hEOJ1HSycnBNdw9gWyFVHmknj+PE1sA1xOZ/v8/DLyFJDYBUG1gEsKKqmB4eb5QVOFnaQra3ZDnc1DGjMmlM+fNfk25DheikWOiF9vP8OYs+/Be36QRcCYjmP/GQMFoyVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TtKMm2B4XzNlsN;
	Mon, 11 Mar 2024 09:44:52 +0800 (CST)
Received: from canpemm500003.china.huawei.com (unknown [7.192.105.39])
	by mail.maildlp.com (Postfix) with ESMTPS id 747CE1404DB;
	Mon, 11 Mar 2024 09:46:35 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm500003.china.huawei.com (7.192.105.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 09:46:35 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 09:46:34 +0800
Subject: Re: [PATCH v2 0/6] Add LIBSAS_SHT_BASE for libsas
To: John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
	<jinpu.wang@cloud.ionos.com>, <artur.paszkiewicz@intel.com>,
	<dlemoal@kernel.org>, <ipylypiv@google.com>, <cassel@kernel.org>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <cf0cfd01-43e3-141e-01ca-867a8eb9a982@huawei.com>
Date: Mon, 11 Mar 2024 09:46:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240308114339.1340549-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)

Hi John,

On 2024/3/8 19:43, John Garry wrote:
> There is much duplication in the scsi_host_template structure for the
> drivers which use libsas.
> 
> Similar to how a standard template is used in libata with __ATA_BASE_SHT,
> create a standard template in LIBSAS_SHT_BASE.
> 
> Based on following:
> b914227e4215 (tag: mkp-scsi-staging, mkp-scsi/staging, mkp-scsi/for-next, mkp-scsi/6.9/scsi-staging) Merge patch series "Pass data lifetime information to SCSI disk devices"
> 
> Differences to v1:
> - tidy libsas.h change (Jason)
> - Don't set eh_abort_handler in LIBSAS_SHT_BASE (Jason)
> - Remove sg_tablesize in LIBSAS_SHT_BASE, as W=1 build dislikes it

I cannot find sg_tablesize in LIBSAS_SHT_BASE in v1, did I misssed anything?

Thanks,
Jason

> - Add some RB tags (Thanks)
> 
> John Garry (6):
>    scsi: libsas: Add LIBSAS_SHT_BASE
>    scsi: pm8001: Use LIBSAS_SHT_BASE
>    scsi: hisi_sas: Use LIBSAS_SHT_BASE_NO_SLAVE_INIT
>    scsi: aic94xx: Use LIBSAS_SHT_BASE
>    scsi: mvsas: Use LIBSAS_SHT_BASE
>    scsi: isci: Use LIBSAS_SHT_BASE
> 
>   drivers/scsi/aic94xx/aic94xx_init.c    | 21 ++-----------------
>   drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 18 +---------------
>   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 18 +---------------
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 18 +---------------
>   drivers/scsi/isci/init.c               | 23 ++------------------
>   drivers/scsi/mvsas/mv_init.c           | 19 +----------------
>   drivers/scsi/pm8001/pm8001_init.c      | 20 +-----------------
>   include/scsi/libsas.h                  | 29 ++++++++++++++++++++++++++
>   8 files changed, 38 insertions(+), 128 deletions(-)
> 


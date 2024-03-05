Return-Path: <linux-kernel+bounces-92396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E72871F8C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2131F24868
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F9985924;
	Tue,  5 Mar 2024 12:54:48 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D019D58AB6;
	Tue,  5 Mar 2024 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709643287; cv=none; b=sgowFqWMsi8mgv0YyzaFTNl278k7UiPLFqYQ22Z9VtRjpE8uNUeYyZBon6Wu/JoiUk0dCuxHfb1Hv7P78tdt/OzlZYin3joQfx+vvf15sseFGiCPaSRUdOW9I3+8U4w8aqRXCsaS5J6yyPeEKsdyUHpZ/MKEoejXVQPzda9SPmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709643287; c=relaxed/simple;
	bh=LN/OxtZRBmZNVdyQIZlISNCHkHA63r7jo22ztprIk40=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=f3ojhr+rUASnqPoZYKgqYifPIMoIwVlIY9TxHDZkDV+MZv0lP3niweX9r2CA9NIZhk+uULTySAVv+fv4FR6K+CV+v4T4pDu5aDdgy0pG3ZtB5R26CkPGdOomvLzkWdAObD0UyijFeHxQ4WP01qu/mKj5UWFqZs+5yn1nbhfX9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TpwWG17Ytz1FLpM;
	Tue,  5 Mar 2024 20:54:34 +0800 (CST)
Received: from canpemm100009.china.huawei.com (unknown [7.192.105.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 13BCD1402CE;
	Tue,  5 Mar 2024 20:54:41 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100009.china.huawei.com (7.192.105.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 20:54:40 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 20:54:40 +0800
Subject: Re: [PATCH 3/6] scsi: hisi_sas: Use LIBSAS_SHT_BASE_NO_SLAVE_INIT
To: John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
	<jinpu.wang@cloud.ionos.com>, <artur.paszkiewicz@intel.com>,
	<dlemoal@kernel.org>, <ipylypiv@google.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240305122452.340471-1-john.g.garry@oracle.com>
 <20240305122452.340471-4-john.g.garry@oracle.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <a384d00d-99c8-d9fc-b137-2dac2377da89@huawei.com>
Date: Tue, 5 Mar 2024 20:54:39 +0800
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
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/5 20:24, John Garry wrote:
> Use standard template for scsi_host_template structure to reduce
> duplication.
> 
> Signed-off-by: John Garry<john.g.garry@oracle.com>
> ---
>   drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 18 +-----------------
>   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 18 +-----------------
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 18 +-----------------
>   3 files changed, 3 insertions(+), 51 deletions(-)

Reviewed-by: Jason Yan <yanaijie@huawei.com>


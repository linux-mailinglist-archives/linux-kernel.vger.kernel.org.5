Return-Path: <linux-kernel+bounces-92408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521E5871FCB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E614281E9E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BB98593E;
	Tue,  5 Mar 2024 13:09:39 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554BD5822E;
	Tue,  5 Mar 2024 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644178; cv=none; b=U+VQIovP6BfaqgG2UL+t40lZ+j0exzW1SFW5tBPBTfOCoQU7LWU1tPkZQL34MKDtlb2F56dfzW+JpKit5vYQrfGWUyPLkUknEckOnq7S/eydizkPCNzxXbZRD4nLaBo29pLl96YC7e2WqYIkvdQFjWM3/j1b5mEV57HMoLRrT6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644178; c=relaxed/simple;
	bh=/u/krEUCkuOTGRwvOdoUR0pRcnxkDAmQT4HDTq0PVhQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DS7XnjtkBvK2ycHVf8qMKWXjp0lvX0rkgdnVqAT9k27oh2p8ko+Jz7L5M1NnA7YotOMc3xgw6yDxzr/mNkSfe04SSYPkVJgFe1j0XVl7cjp2Vi05261QnTGPqhqqvNJ+NxutCqVHGpFrabz/wb+CuLZ4MVdfn21i/7D3QAr9Va0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Tpwnn6MqXz1Q9j8;
	Tue,  5 Mar 2024 21:07:09 +0800 (CST)
Received: from canpemm100003.china.huawei.com (unknown [7.192.104.85])
	by mail.maildlp.com (Postfix) with ESMTPS id 903D51402CE;
	Tue,  5 Mar 2024 21:09:30 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100003.china.huawei.com (7.192.104.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:09:30 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:09:29 +0800
Subject: Re: [PATCH 4/6] scsi: aic94xx: Use LIBSAS_SHT_BASE
To: John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
	<jinpu.wang@cloud.ionos.com>, <artur.paszkiewicz@intel.com>,
	<dlemoal@kernel.org>, <ipylypiv@google.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240305122452.340471-1-john.g.garry@oracle.com>
 <20240305122452.340471-5-john.g.garry@oracle.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <946f1a64-0a8e-d1af-e81c-a84ffe460e01@huawei.com>
Date: Tue, 5 Mar 2024 21:09:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305122452.340471-5-john.g.garry@oracle.com>
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
>   drivers/scsi/aic94xx/aic94xx_init.c | 21 ++-------------------
>   1 file changed, 2 insertions(+), 19 deletions(-)

Reviewed-by: Jason Yan <yanaijie@huawei.com>


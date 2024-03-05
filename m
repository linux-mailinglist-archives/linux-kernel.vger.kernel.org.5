Return-Path: <linux-kernel+bounces-92474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2258720E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C1D281A37
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E0B86141;
	Tue,  5 Mar 2024 13:54:32 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27175102B;
	Tue,  5 Mar 2024 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646872; cv=none; b=VsP6WDYRoU3BzM2IkZhW2Q51QjxwdT7L77KKdGdcsZOJ6AnujLLRrtdgwcDIsEO7ZE9dCckdUgUbUJ/Lb4PoY+CmaExGGlTrBZP1I86vp9PkwZOYkSvclsFEDNa7zkRTxFdRYJSPBZkUNlK+IVU8EByz/SpdjdmTDnJo36X54ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646872; c=relaxed/simple;
	bh=Xf/WkyLcOoDaBKyCJpBWytcGIZe+Me8rFxC8lKkr05I=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Zauh6TgxbD2ed8NhmWBFS4DlESKn6dBhaqBHJnOeUhJ83ups4q+tklDBXUB4rlBfcfOpcz6QIKGVYIACWucold6tpH2jEpSx3pV1hyjQQpNFWLCnTwsRUu5gAavdCsm7DmttatuEh30jTdZYDastfT3BkqKBHb0V7Vbp57L1ElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TpxrD35wHz1FLfp;
	Tue,  5 Mar 2024 21:54:20 +0800 (CST)
Received: from canpemm100008.china.huawei.com (unknown [7.192.104.152])
	by mail.maildlp.com (Postfix) with ESMTPS id 977651A016C;
	Tue,  5 Mar 2024 21:54:27 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100008.china.huawei.com (7.192.104.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:54:27 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:54:26 +0800
Subject: Re: [PATCH 6/6] scsi: isci: Use LIBSAS_SHT_BASE
To: John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
	<jinpu.wang@cloud.ionos.com>, <artur.paszkiewicz@intel.com>,
	<dlemoal@kernel.org>, <ipylypiv@google.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240305122452.340471-1-john.g.garry@oracle.com>
 <20240305122452.340471-7-john.g.garry@oracle.com>
 <e3fcc620-d803-c8e3-651b-9781ecd8e87a@huawei.com>
 <99e4e3aa-8b8c-44ff-8dae-320c90c471ee@oracle.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <4396ae3e-db08-ea35-6d27-6585c88befac@huawei.com>
Date: Tue, 5 Mar 2024 21:54:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <99e4e3aa-8b8c-44ff-8dae-320c90c471ee@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/5 21:27, John Garry wrote:
> On 05/03/2024 13:21, Jason Yan wrote:
>>>       .sg_tablesize            = SG_ALL,
>>> -    .max_sectors            = SCSI_DEFAULT_MAX_SECTORS,
>>
>> .max_sectors is not defined in LIBSAS_SHT_BASE.
> 
> Sure, but when not set, scsi_host_alloc() will default to 
> SCSI_DEFAULT_MAX_SECTORS automatically

OK, so it's fine to let it uninitialized.

Reviewed-by: Jason Yan <yanaijie@huawei.com>

> 
> Thanks,
> John
> .


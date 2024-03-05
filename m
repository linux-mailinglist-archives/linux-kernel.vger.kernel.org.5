Return-Path: <linux-kernel+bounces-92467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34208720BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51D31C22FB5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283998613F;
	Tue,  5 Mar 2024 13:48:03 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11AC85C65;
	Tue,  5 Mar 2024 13:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646482; cv=none; b=bYYB3A4l7iHIJXXwKzV6p1GLL2uRi/YqTCLZWuxfbHgelIpZA7y3QpFTnWTXqmLbROvse10Al2zimFrc38Lf61SbB76M3L18y+VAVUmlYU3fdIE9/RXJsN/83sYqYE6IlK/fR/T3i9LDOQFwNYgJY0Ce1UK77a659qnXulEfCu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646482; c=relaxed/simple;
	bh=fwsD95FdoAbsdyR2QUY9CpZGE8wzEFI62CxYIBvAC9U=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aOlL/8Na78m1EQCNCO4kKtTpxbLk7uvjwSnQC0ku/EpirRPzTGf7/wJGyLyrzglo+mCiIG34C1R1Qap0twdt15/TurT2ManULbhRx0TPP2voFSS5s1+OWKz7QVVbGMDfsnYJKyr1g9IODAHS1RYhgEf4NkYeBhfiC2b6vBio5MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tpxhk0swLz1FLnJ;
	Tue,  5 Mar 2024 21:47:50 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 46AFB18002F;
	Tue,  5 Mar 2024 21:47:57 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:47:57 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:47:56 +0800
Subject: Re: [PATCH 5/6] scsi: mvsas: Use LIBSAS_SHT_BASE
To: John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
	<jinpu.wang@cloud.ionos.com>, <artur.paszkiewicz@intel.com>,
	<dlemoal@kernel.org>, <ipylypiv@google.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240305122452.340471-1-john.g.garry@oracle.com>
 <20240305122452.340471-6-john.g.garry@oracle.com>
 <8834df38-413d-855c-433c-653d7023dc8b@huawei.com>
 <f54e9c30-b483-4dae-9b22-24feb4fc289e@oracle.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <deae273c-7789-e8da-1256-777d01a4ab9f@huawei.com>
Date: Tue, 5 Mar 2024 21:47:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f54e9c30-b483-4dae-9b22-24feb4fc289e@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/5 21:28, John Garry wrote:
> On 05/03/2024 13:19, Jason Yan wrote:
>>> -    .ioctl            = sas_ioctl,
>>> -#ifdef CONFIG_COMPAT
>>> -    .compat_ioctl        = sas_ioctl,
>>> -#endif
>>>       .shost_groups        = mvst_host_groups,
>>>       .sdev_groups        = mvst_sdev_groups,
>>>       .track_queue_depth    = 1,
>>>
>>
>> Doesn't hvae ->eh_abort_handler too.
> 
> Is setting eh_abort_handler actually really ever required for libsas 
> drivers? We have sas_eh_abort_handler, so I assume so..

For now among libsas drivers only isci has eh_abort_handler. But 
LIBSAS_SHT_BASE is setting it by default. I think it's better to keep 
the same as before for other four drivers.

Thanks,
Jason

> 
> Thanks,
> John
> .


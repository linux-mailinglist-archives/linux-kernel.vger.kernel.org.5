Return-Path: <linux-kernel+bounces-91575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAD68713D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2386E2815BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFF829438;
	Tue,  5 Mar 2024 02:47:00 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8BAFC09;
	Tue,  5 Mar 2024 02:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606820; cv=none; b=A02ftW238A4jQV9ko+KXSUU82iQykfwM4/4nK3AMxoYs3/r36pZFp3SUZZOZZibgJnhZmrMpcO76K+b041d9nY89Amre8t3A47m3zRlTyoshQYTS0CHFuNMLsLwc+J2ImeFway+b9gmmVfOEb44viCQSJvSgKMKIheo+gCHpAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606820; c=relaxed/simple;
	bh=IOKDEq3/2glV0HF9q/Eqe36JL1i/GAUVOvnm9LGveC4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MJmt1aCB2WECqblizKsac82akflobD0LvGFX4vbxEzZsKAU8RCdCfkQxVnlKXoLBSz62OsHF5CXuQnYDwc1Kacq2QrAERQEEOl1+zM7q1LS0KDU2FujUSyY18yAF5UZ6Jlh0RMmhdbdrNWYn18bCzhB7iHOAAVvidw0KzmKySow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tpg214WfNz1FLnr;
	Tue,  5 Mar 2024 10:46:49 +0800 (CST)
Received: from canpemm100007.china.huawei.com (unknown [7.192.105.181])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D9311A016C;
	Tue,  5 Mar 2024 10:46:56 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100007.china.huawei.com (7.192.105.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 10:46:56 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 10:46:55 +0800
Subject: Re: [PATCH v5 6/7] scsi: aic94xx: Add libsas SATA sysfs attributes
 group
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, John Garry <john.g.garry@oracle.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Jack Wang <jinpu.wang@cloud.ionos.com>, "Hannes
 Reinecke" <hare@suse.de>, Xiang Chen <chenxiang66@hisilicon.com>, "Artur
 Paszkiewicz" <artur.paszkiewicz@intel.com>, Bart Van Assche
	<bvanassche@acm.org>
CC: TJ Adams <tadamsjr@google.com>, <linux-ide@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240305005103.1849325-1-ipylypiv@google.com>
 <20240305005103.1849325-7-ipylypiv@google.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <3fc900ee-469f-5991-e763-c451236b1c7e@huawei.com>
Date: Tue, 5 Mar 2024 10:46:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305005103.1849325-7-ipylypiv@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/5 8:51, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Reviewed-by: John Garry<john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal<dlemoal@kernel.org>
> Signed-off-by: Igor Pylypiv<ipylypiv@google.com>
> ---
>   drivers/scsi/aic94xx/aic94xx_init.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Jason Yan <yanaijie@huawei.com>


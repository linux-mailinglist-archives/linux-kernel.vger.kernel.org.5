Return-Path: <linux-kernel+bounces-89314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0228A86EE32
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 03:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981791F220FB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C15479D0;
	Sat,  2 Mar 2024 02:54:27 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DEE1364;
	Sat,  2 Mar 2024 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709348066; cv=none; b=sZ3bwqgvQ16IRCAqFz/U6bKX+N5AWsFN99wr5QZTRRgGnf7K3f0Zxa4tXhvtjsl9VZAHv3nW0LWxqUfLth6MOy4+cLeU/nM6mi87JQ/OI0B1ht1HFNbeZoVnVBkUYfw0mhfLj95cMMtuOuhfTFSj/QXvIsQzsYnnDDqg93Ebu/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709348066; c=relaxed/simple;
	bh=7WNoEH9fayW9GXHYr9GoW6MPle3ANHC7zx9ampZ1Hdo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dsZs9c3b/XR8iI2WV1i6UCLx6qiAl+Bqi6Tkw3TA/1q9Olec6SAQe6oOWnDlScA/6EZZHltCamKCp8YKEG0Yc/mqxcbKEutgQCuurNZmSn7MXsQA4maGvkMjrT3fsw4BUndWv8J59qcjXvzenPck/PK0237BMpDbGPogw+8hiNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TmqKv6kQ2z1FLRM;
	Sat,  2 Mar 2024 10:54:11 +0800 (CST)
Received: from canpemm100003.china.huawei.com (unknown [7.192.104.85])
	by mail.maildlp.com (Postfix) with ESMTPS id 6117B1A016B;
	Sat,  2 Mar 2024 10:54:15 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100003.china.huawei.com (7.192.104.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 2 Mar 2024 10:54:15 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 2 Mar 2024 10:54:14 +0800
Subject: Re: [PATCH v2 5/5] scsi: hisi_sas: Add libsas SATA sysfs attributes
 group
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, John Garry <john.g.garry@oracle.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Jack Wang <jinpu.wang@cloud.ionos.com>, "Hannes
 Reinecke" <hare@suse.de>
CC: TJ Adams <tadamsjr@google.com>, <linux-ide@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240302001603.1012084-1-ipylypiv@google.com>
 <20240302001603.1012084-6-ipylypiv@google.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <e363a966-46a6-5c19-ea6c-77db43021149@huawei.com>
Date: Sat, 2 Mar 2024 10:54:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240302001603.1012084-6-ipylypiv@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/2 8:16, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Signed-off-by: Igor Pylypiv<ipylypiv@google.com>
> ---
>   drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 6 ++++++
>   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 ++++++
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 ++++++
>   3 files changed, 18 insertions(+)

As John pointed out, please check aic94xx and isci driver, they also use 
libsas.

Thanks,
Jason


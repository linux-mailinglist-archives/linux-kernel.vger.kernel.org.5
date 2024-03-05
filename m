Return-Path: <linux-kernel+bounces-91572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319308713C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22352828BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B830F29415;
	Tue,  5 Mar 2024 02:45:22 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116B828E23;
	Tue,  5 Mar 2024 02:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606722; cv=none; b=Q0R5otjqTml0rF6f6tr+uNgQb7zqJ52hUliPDT8j8nBN1A1+dCXAvFFsoRMUUo3zPi24jsB0olJYHTg2xq0RCUXR7iFBRP/s7FwTKu1ZWXxAVy96xetkUNtMnN6VKK39vRkZtYpkYaV+fd+ciahWEOuVMvgDgGM8IAzGiP7pkfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606722; c=relaxed/simple;
	bh=oQCaLLFaMbDhKkBf64kfEmR38TN/ZT38vYjRAtfRkHo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qfuXSDz7s+bNJ9shaQGxPp7IqikERQCnbu1QPkHquNpokSh10ra7y9uIHXCkcVwgLkvnxRFOH3BkTPgYvaCX49z6C2DRRo7cLgY51PTGgdqbzK2EcSAFr4KgZSU8KXuJayuzlbrGxzL9Nz0hOfby91FHUG6HxqP+/lilTXNedn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TpfzV0h0cz1vw3R;
	Tue,  5 Mar 2024 10:44:38 +0800 (CST)
Received: from canpemm500008.china.huawei.com (unknown [7.192.105.151])
	by mail.maildlp.com (Postfix) with ESMTPS id B4B6C1A0172;
	Tue,  5 Mar 2024 10:45:17 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 10:45:17 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 10:45:16 +0800
Subject: Re: [PATCH v5 3/7] scsi: pm80xx: Add libsas SATA sysfs attributes
 group
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, John Garry <john.g.garry@oracle.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Jack Wang <jinpu.wang@cloud.ionos.com>, "Hannes
 Reinecke" <hare@suse.de>, Xiang Chen <chenxiang66@hisilicon.com>, "Artur
 Paszkiewicz" <artur.paszkiewicz@intel.com>, Bart Van Assche
	<bvanassche@acm.org>
CC: TJ Adams <tadamsjr@google.com>, <linux-ide@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jack Wang
	<jinpu.wang@ionos.com>
References: <20240305005103.1849325-1-ipylypiv@google.com>
 <20240305005103.1849325-4-ipylypiv@google.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <0dd78b27-5364-e64f-f7ae-54f00e728986@huawei.com>
Date: Tue, 5 Mar 2024 10:45:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305005103.1849325-4-ipylypiv@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/5 8:50, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Acked-by: Jack Wang<jinpu.wang@ionos.com>
> Reviewed-by: John Garry<john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal<dlemoal@kernel.org>
> Signed-off-by: Igor Pylypiv<ipylypiv@google.com>
> ---
>   drivers/scsi/pm8001/pm8001_ctl.c  | 5 +++++
>   drivers/scsi/pm8001/pm8001_init.c | 1 +
>   drivers/scsi/pm8001/pm8001_sas.h  | 1 +
>   3 files changed, 7 insertions(+)

Reviewed-by: Jason Yan <yanaijie@huawei.com>


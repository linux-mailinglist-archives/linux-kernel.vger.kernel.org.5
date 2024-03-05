Return-Path: <linux-kernel+bounces-91573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DA98713CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9241E28249F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D6B2940D;
	Tue,  5 Mar 2024 02:45:47 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2933428E0D;
	Tue,  5 Mar 2024 02:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606747; cv=none; b=K24WKfFhi/mIXBlCdy/fravFmAwLmMmiqmd1xDNbrYvTCVHG8lRmCzlTeMcon60t2lTv0lBhdJyjUYSw7HklTYpYXghhrcowD9lwoAmlb63hddi4WoallKfpQ7VvjwgjVcjp1yBaDG1AszCwmu2n//NoR13ZjUdHoRXALs/jzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606747; c=relaxed/simple;
	bh=bGWB9DAGnp+r500WzF+SpVP9KpcL9htezk8cuKk1tqM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FQo5NPRKyhMa+dmEKHXeZG5P++jtNV1j1SaeZZXAk0J4pQgb7ed2Ig0jd9P7s7Uv9gn7iC6Y/UWHbCRXrHikGPs2Yy6tqPviE4dwVnA2rfHrMxnA/DmeiLxpbTo6XCwAYAN/t1eqNE6C6ooWaM3R1tdU2PsaAgalVglB2vzkbfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TpfyM6fN7z1Q9J9;
	Tue,  5 Mar 2024 10:43:39 +0800 (CST)
Received: from canpemm500007.china.huawei.com (unknown [7.192.104.62])
	by mail.maildlp.com (Postfix) with ESMTPS id DCBBE140257;
	Tue,  5 Mar 2024 10:45:35 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 10:45:35 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 10:45:34 +0800
Subject: Re: [PATCH v5 4/7] scsi: mvsas: Add libsas SATA sysfs attributes
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
 <20240305005103.1849325-5-ipylypiv@google.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <2be627aa-27f4-859c-6052-33568dee6cba@huawei.com>
Date: Tue, 5 Mar 2024 10:45:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305005103.1849325-5-ipylypiv@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/5 8:51, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Reviewed-by: John Garry<john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal<dlemoal@kernel.org>
> Signed-off-by: Igor Pylypiv<ipylypiv@google.com>
> ---
>   drivers/scsi/mvsas/mv_init.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Jason Yan <yanaijie@huawei.com>


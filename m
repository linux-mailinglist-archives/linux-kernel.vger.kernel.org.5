Return-Path: <linux-kernel+bounces-146083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0920F8A6016
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A37289B81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB82E5227;
	Tue, 16 Apr 2024 01:17:59 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957441C10
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713230279; cv=none; b=T6pb+6R4b7zwoCYPEbIQOuxifoKbZC0L9UZuj0/UX3WYU09dQtt40ISTWNhSAHNiybqv08u9IQSa2PbNlrvUwuPZrarxd4oESzUX9rf9omMT/y4ewfheV4+6W33p2WLt6PpG5rOE/PRQulRoRw5LqdO4ErZBCCVoCed/eJS2ors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713230279; c=relaxed/simple;
	bh=d8UHCKtQgMSEk0JPxU2mx4yp++pMeFU9iqcmCil4S4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yt7M/zGEMWEefgP7C2/aezx3ySwlX0FB83YgeM8werFtdniCBV0uoeXldIqg+NCw36JloSPEpfsRqd8WrRA75deOfDOrFE2R4dQJpwkqPCNC17QJw+iVeUZQjZuGT9K9EzQ6z/gQ0n1Krec2vRILbW+rFuDsCjBnJvnTgxboY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VJR0W45XHzwSNd;
	Tue, 16 Apr 2024 09:14:51 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 2983D140123;
	Tue, 16 Apr 2024 09:17:53 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 16 Apr
 2024 09:17:52 +0800
Message-ID: <09e235e4-bea5-27d7-6101-15b0a5105a2a@huawei.com>
Date: Tue, 16 Apr 2024 09:17:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] soc: hisilicon: kunpeng_hccs: Add the check for
 obtaining complete port attribute
To: Wei Xu <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <Jonathan.Cameron@Huawei.com>,
	<liuyonglong@huawei.com>
References: <20240403081935.24308-1-lihuisong@huawei.com>
 <20240403081935.24308-2-lihuisong@huawei.com>
 <661C8017.1070203@hisilicon.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <661C8017.1070203@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/4/15 9:17, Wei Xu 写道:
> Hi Huisong,
>
> On 2024/4/3 16:19, Huisong Li wrote:
>> The hccs_get_all_port_attr() is used to obtained the attribute of all
>> ports on a specified DIE from firmware. However, this interface doesn't
>> ensure whether firmware reports the complete attribute of all ports or not.
>> So this patch adds the check for this.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/soc/hisilicon/kunpeng_hccs.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
>> index 9ff70b38e5e9..bb69a95b5f2d 100644
>> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
>> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
>> @@ -556,6 +556,12 @@ static int hccs_get_all_port_attr(struct hccs_dev *hdev,
>>   		start_id = rsp_head.next_id;
>>   	}
>>   
>> +	if (left_buf_len != 0) {
>> +		dev_err(hdev->dev, "do not get the expected port number(%u) attribute.\n",
> How about changing to "failed to get the expected port number(%u) attribute.\n"?
ok, I will fix it in next version.
>
> Best Regards,
> Wei
>
>> +			size);
>> +		return -EINVAL;
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>>
> .


Return-Path: <linux-kernel+bounces-10932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA981DED5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C633E1C213B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3863B15C8;
	Mon, 25 Dec 2023 07:34:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ACE15A8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sz8mF60hpzsSkt;
	Mon, 25 Dec 2023 15:34:05 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E54E180078;
	Mon, 25 Dec 2023 15:34:29 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 25 Dec 2023 15:34:28 +0800
Message-ID: <2bbd0297-9a79-a27e-285e-d695cb46f34f@huawei.com>
Date: Mon, 25 Dec 2023 15:34:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 1/5] ubi: Use the fault injection framework to enhance
 the fault injection capability
To: Randy Dunlap <rdunlap@infradead.org>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20231225071055.1721000-1-wangzhaolong1@huawei.com>
 <20231225071055.1721000-2-wangzhaolong1@huawei.com>
 <3464b187-d280-4b7f-8187-123dc51ad0c3@infradead.org>
From: ZhaoLong Wang <wangzhaolong1@huawei.com>
In-Reply-To: <3464b187-d280-4b7f-8187-123dc51ad0c3@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd200001.china.huawei.com (7.185.36.224)


Thanks for the heads-up on the spelling errors. I'll make a
correction soon

Thanks
ZhaoLong Wang
> Hi--
> 
> On 12/24/23 23:10, ZhaoLong Wang wrote:
>> diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
>> index 2ed77b7b3fcb..138fae7e8f96 100644
>> --- a/drivers/mtd/ubi/Kconfig
>> +++ b/drivers/mtd/ubi/Kconfig
>> @@ -104,4 +104,13 @@ config MTD_UBI_BLOCK
>>   
>>   	   If in doubt, say "N".
>>   
>> +config MTD_UBI_FAULT_INJECTION
>> +	bool "Fault injection capability of UBI device"
>> +	default n
>> +	depends on FAULT_INJECTION_DEBUG_FS
>> +	help
>> +	   this option enable fault-injection support for UBI devices for
> 
> 	   This option enables
> 
>> +	   testing purposes.
>> +
>> +	   If in doubt, say "N".
> 



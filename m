Return-Path: <linux-kernel+bounces-6284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822A18196BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CC75B24BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3592D8813;
	Wed, 20 Dec 2023 02:15:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EEB846B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Svxws1B1Xz1Q6y4;
	Wed, 20 Dec 2023 10:15:25 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 90F5718001C;
	Wed, 20 Dec 2023 10:15:41 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Wed, 20 Dec 2023 10:15:41 +0800
Message-ID: <31c3da46-5373-f91d-6f35-051bc4735a29@huawei.com>
Date: Wed, 20 Dec 2023 10:15:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3] mtd: Fix gluebi NULL pointer dereference caused by ftl
 notifier
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
	<vigneshr@ti.com>, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>, dpervushin
	<dpervushin@embeddedalley.com>, linux-mtd <linux-mtd@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, chengzhihao1
	<chengzhihao1@huawei.com>, yi zhang <yi.zhang@huawei.com>, yangerkun
	<yangerkun@huawei.com>
References: <20231027012033.50280-1-wangzhaolong1@huawei.com>
 <20231027194026.1bc32dfe@xps-13>
 <174426702.13324.1698438610904.JavaMail.zimbra@nod.at>
 <20231029145033.0ad2682a@xps-13>
 <142222867.20038.1698593973984.JavaMail.zimbra@nod.at>
 <04b4c375-d890-9458-5d62-0a9ba74b8c68@huawei.com>
 <20231219154438.2bc1820e@xps-13>
From: ZhaoLong Wang <wangzhaolong1@huawei.com>
In-Reply-To: <20231219154438.2bc1820e@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd200001.china.huawei.com (7.185.36.224)

Oh, sorry, I had missed a crucial part of your previous message,
specifically the segment about the `flt ? notifier,This oversight
led to my misunderstanding of the situation, and for that, I am
truly sorry.

Thank you for your understanding and patience. I am committed to
maintaining clear and accurate communication going forward.

I'll send a v4 version of the log fixed patch soon.

Warmest thanks,
ZhaoLong Wang

> Hi ZhaoLong,
> 
> wangzhaolong1@huawei.com wrote on Tue, 19 Dec 2023 22:36:50 +0800:
> 
>> Friendly ping...
>>
>> I'd like to know what the current status of this patch is. Is there a need for further programme improvements?
> 
> Easy, see below.
> 
>>
>> Bast regards,
>> ZhaoLong Wang
>>
>>
>>> ----- Ursprüngliche Mail -----
>>>> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
>>>> Ack. I'll queue this once the log fixed and your official Ack-by
>>>> received for mtd/next after -rc1 is out.
> 
> Here I depict two conditions.
> 
>>> Acked-by: Richard Weinberger <richard@nod.at>
> 
> And here one of them is fulfilled, which means the other one is still
> not AFAIK :)
> 
> Thanks,
> Miquèl



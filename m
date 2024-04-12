Return-Path: <linux-kernel+bounces-142116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5F68A27BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760BA1C20B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E1A482FF;
	Fri, 12 Apr 2024 07:12:26 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9729633997;
	Fri, 12 Apr 2024 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905946; cv=none; b=QSZAb2ykXR6QE+IDFEM5ewKLrkwB1S3Q+65oup38//AgKNPL2wE4Lq+HwCcTbV00mzxHC+o4QEngfe01gXnsT9kFS8w0QMLNnTip6MsLgq7XCkRAXMCLwRxu4e/Vvn4jr6sX322iCs82ZUZc/F77Wn++inb9nIAghgN8/zrkX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905946; c=relaxed/simple;
	bh=mgfUy8S85yOwuUy3mNJ61fEIgLxYugY92FiHdSZiToA=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jrDlEWhb8o7Yf3oKfyKS0smSkQqo4MSGyTaO9sxAfRDRvFDPbRQyH6+v92apvbblMZ6hiRk10zLTAbycPockbQgNFtT+F0BfK66Z5Q3M6C76+AxnSOd1roBvZy5SeFERyecLrxlQPb0lPr7ixfpWeu8vcqP4kWdYABwV+WzxKe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VG7383z7xzTmPZ;
	Fri, 12 Apr 2024 15:09:08 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 92DD9180073;
	Fri, 12 Apr 2024 15:12:19 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 15:12:18 +0800
Message-ID: <5e9abc23-96c8-4a37-abae-f6c208aacda2@huawei.com>
Date: Fri, 12 Apr 2024 15:12:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<rkannoth@marvell.com>, <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V7 net-next 4/4] net: hns3: add support to query scc
 version by devlink info
To: Jiri Pirko <jiri@resnulli.us>
References: <20240410125354.2177067-1-shaojijie@huawei.com>
 <20240410125354.2177067-5-shaojijie@huawei.com> <ZhapUja4xXiJe4Q2@nanopsycho>
 <16347737-f0ac-4710-85ee-189abed59d6b@huawei.com>
 <ZheB58bjmkFzIEbG@nanopsycho>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <ZheB58bjmkFzIEbG@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/4/11 14:23, Jiri Pirko wrote:
> Thu, Apr 11, 2024 at 03:05:53AM CEST, shaojijie@huawei.com wrote:
>> on 2024/4/10 22:59, Jiri Pirko wrote:
>>> Wed, Apr 10, 2024 at 02:53:54PM CEST, shaojijie@huawei.com wrote:
>>>> From: Hao Chen <chenhao418@huawei.com>
>>>>
>>>> Add support to query scc version by devlink info for device V3.
>>>>
>>>> Signed-off-by: Hao Chen <chenhao418@huawei.com>
>>>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>>>> ---
>>>> Documentation/networking/devlink/hns3.rst     |  3 ++
>>>> drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  9 ++++
>>>> .../hns3/hns3_common/hclge_comm_cmd.h         |  8 ++++
>>>> .../hisilicon/hns3/hns3pf/hclge_devlink.c     | 44 +++++++++++++++++--
>>>> .../hisilicon/hns3/hns3pf/hclge_devlink.h     |  2 +
>>>> .../hisilicon/hns3/hns3pf/hclge_main.c        | 18 ++++++++
>>>> .../hisilicon/hns3/hns3pf/hclge_main.h        |  1 +
>>>> 7 files changed, 82 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/networking/devlink/hns3.rst b/Documentation/networking/devlink/hns3.rst
>>>> index 4562a6e4782f..e19dea8ef924 100644
>>>> --- a/Documentation/networking/devlink/hns3.rst
>>>> +++ b/Documentation/networking/devlink/hns3.rst
>>>> @@ -23,3 +23,6 @@ The ``hns3`` driver reports the following versions
>>>>      * - ``fw``
>>>>        - running
>>>>        - Used to represent the firmware version.
>>>> +   * - ``fw.scc``
>>> What's scc? I don't see it described anywhere.
>> diff --git a/Documentation/networking/devlink/hns3.rst b/Documentation/networking/devlink/hns3.rst
>> index 4562a6e4782f..e19dea8ef924 100644
>> --- a/Documentation/networking/devlink/hns3.rst
>> +++ b/Documentation/networking/devlink/hns3.rst
>> @@ -23,3 +23,6 @@ The ``hns3`` driver reports the following versions
>>     * - ``fw``
>>       - running
>>       - Used to represent the firmware version.
>> +   * - ``fw.scc``
>> +     - running
>> +     - Used to represent the soft congestion control firmware version.
>>
>> scc means "soft congestion control"
> I guess this is something specific to your device, isn't it? Can't you
> please extend the description a bit more?
>
> Thanks!
>
SCC is a firmware which provides multiple congestion control algorithms, including dcqcn.
Congestion control is a mechanism that controls the entry of rdma packets into the network,
enabling a better use of a shared network infrastructure and avoiding congestive collapse.


Jijie Shao



Return-Path: <linux-kernel+bounces-139609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9FE8A054F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193D72833B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790F8612D3;
	Thu, 11 Apr 2024 01:06:00 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC8460DCF;
	Thu, 11 Apr 2024 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797560; cv=none; b=UWHfVtO0a6w52IYKzqnZJpuJud710/B07cwWF0S6YRBkKKw8AZpoGLqV+qut3e284PFW7XwNSFQ2e85E3I65tbk4t1ID0R16OIOix3hX2rvQgOPGwr0uGmSqDB3C4bgzU5pXjNdeJhMUOcgxdVdOSx63yOea0DZsUqfkXOJ/LNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797560; c=relaxed/simple;
	bh=SKcWXd9G9NkbxA74hLki2oajbTrX9Hro54JIkBOU/Cg=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GQ70bsfzx2EoMmsqZeG1+zrwH8BdmUnUB4dRPCAV73ljRkB6ZhlwP3V5wGRl/m3IQUKw4QVt2mWygkry21ljqHaBceUGNixeDeP5qkxCvKjAxV6aGqWt4KuMy4CpZ0pkldWP9IZlh+XdHfbzlHoDZerounajuiipwtQsvlODg0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VFLzM003Yz1R5Sd;
	Thu, 11 Apr 2024 09:03:10 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B244140414;
	Thu, 11 Apr 2024 09:05:55 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 09:05:54 +0800
Message-ID: <16347737-f0ac-4710-85ee-189abed59d6b@huawei.com>
Date: Thu, 11 Apr 2024 09:05:53 +0800
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
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <ZhapUja4xXiJe4Q2@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/4/10 22:59, Jiri Pirko wrote:
> Wed, Apr 10, 2024 at 02:53:54PM CEST, shaojijie@huawei.com wrote:
>> From: Hao Chen <chenhao418@huawei.com>
>>
>> Add support to query scc version by devlink info for device V3.
>>
>> Signed-off-by: Hao Chen <chenhao418@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>> Documentation/networking/devlink/hns3.rst     |  3 ++
>> drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  9 ++++
>> .../hns3/hns3_common/hclge_comm_cmd.h         |  8 ++++
>> .../hisilicon/hns3/hns3pf/hclge_devlink.c     | 44 +++++++++++++++++--
>> .../hisilicon/hns3/hns3pf/hclge_devlink.h     |  2 +
>> .../hisilicon/hns3/hns3pf/hclge_main.c        | 18 ++++++++
>> .../hisilicon/hns3/hns3pf/hclge_main.h        |  1 +
>> 7 files changed, 82 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/networking/devlink/hns3.rst b/Documentation/networking/devlink/hns3.rst
>> index 4562a6e4782f..e19dea8ef924 100644
>> --- a/Documentation/networking/devlink/hns3.rst
>> +++ b/Documentation/networking/devlink/hns3.rst
>> @@ -23,3 +23,6 @@ The ``hns3`` driver reports the following versions
>>     * - ``fw``
>>       - running
>>       - Used to represent the firmware version.
>> +   * - ``fw.scc``
> What's scc? I don't see it described anywhere.

diff --git a/Documentation/networking/devlink/hns3.rst b/Documentation/networking/devlink/hns3.rst
index 4562a6e4782f..e19dea8ef924 100644
--- a/Documentation/networking/devlink/hns3.rst
+++ b/Documentation/networking/devlink/hns3.rst
@@ -23,3 +23,6 @@ The ``hns3`` driver reports the following versions
     * - ``fw``
       - running
       - Used to represent the firmware version.
+   * - ``fw.scc``
+     - running
+     - Used to represent the soft congestion control firmware version.

scc means "soft congestion control"



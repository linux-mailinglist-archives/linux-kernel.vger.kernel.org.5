Return-Path: <linux-kernel+bounces-161448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6F28B4C19
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D528B21242
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2486EB5D;
	Sun, 28 Apr 2024 14:15:08 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12956D1A9;
	Sun, 28 Apr 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714313708; cv=none; b=UXL9lQUJBgA2iUQEa0lEehnIEwvcwlk982tHM2wqhNx7L351QCehxaCO7N3COBIr6Myaiwq2k785afjRKSlm7G20ZCSUfWjCsm3EKW9ieD1hTt98+BuLURRm6T2Rn04YKJAG6F6Eqhp36tPihgEHsZV3ggXh9Q/dCgrX/aXiTQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714313708; c=relaxed/simple;
	bh=Cl2dD325d9ORqYU+x7D/k79xWrq1R8W+r9XE2r0dOsk=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NAM1J5FhAwCKlZwfSpwrb40/rBV5tGMvKvVc7lW13gbuYXpq04GRUGDnKiK6niiR4h7KnX2VvU5uT+VtabocGW7KFJ0Jt/8Pyi9SgU9z+3VOaM5wY+g+KFU22akBEiojlmGAZOTpgq9dPOyV9WkbXXiO7hCr88Q40IVUn6UVt+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VS7g04f0CzXn8W;
	Sun, 28 Apr 2024 22:11:24 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 653271401E9;
	Sun, 28 Apr 2024 22:15:00 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Apr 2024 22:14:59 +0800
Message-ID: <6b501b43-8baa-41f1-9688-5928e7ad9a77@huawei.com>
Date: Sun, 28 Apr 2024 22:14:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <jiri@resnulli.us>,
	<shenjian15@huawei.com>, <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net 5/7] net: hns3: using user configure after hardware
 reset
To: Simon Horman <horms@kernel.org>
References: <20240426100045.1631295-1-shaojijie@huawei.com>
 <20240426100045.1631295-6-shaojijie@huawei.com>
 <20240426142519.GA513047@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240426142519.GA513047@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/4/26 22:25, Simon Horman wrote:
> On Fri, Apr 26, 2024 at 06:00:43PM +0800, Jijie Shao wrote:
>> From: Peiyang Wang <wangpeiyang1@huawei.com>
>>
>> When a reset occurring, it's supposed to recover user's configuration.
>> Currently, the port info(speed, duplex and autoneg) is stored in hclge_mac
>> and will be scheduled updated. Consider the case that reset was happened
>> consecutively. During the first reset, the port info is configured with
>> a temporary value cause the PHY is reset and looking for best link config.
>> Second reset start and use pervious configuration which is not the user's.
>> The specific process is as follows:
>>
>> +------+               +----+                +----+
>> | USER |               | PF |                | HW |
>> +---+--+               +-+--+                +-+--+
>>      |  ethtool --reset   |                     |
>>      +------------------->|    reset command    |
>>      |  ethtool --reset   +-------------------->|
>>      +------------------->|                     +---+
>>      |                    +---+                 |   |
>>      |                    |   |reset currently  |   | HW RESET
>>      |                    |   |and wait to do   |   |
>>      |                    |<--+                 |   |
>>      |                    | send pervious cfg   |<--+
>>      |                    | (1000M FULL AN_ON)  |
>>      |                    +-------------------->|
>>      |                    | read cfg(time task) |
>>      |                    | (10M HALF AN_OFF)   +---+
>>      |                    |<--------------------+   | cfg take effect
>>      |                    |    reset command    |<--+
>>      |                    +-------------------->|
>>      |                    |                     +---+
>>      |                    | send pervious cfg   |   | HW RESET
>>      |                    | (10M HALF AN_OFF)   |<--+
>>      |                    +-------------------->|
>>      |                    | read cfg(time task) |
>>      |                    |  (10M HALF AN_OFF)  +---+
>>      |                    |<--------------------+   | cfg take effect
>>      |                    |                     |   |
>>      |                    | read cfg(time task) |<--+
>>      |                    |  (10M HALF AN_OFF)  |
>>      |                    |<--------------------+
>>      |                    |                     |
>>      v                    v                     v
>>
>> To avoid aboved situation, this patch introduced req_speed, req_duplex,
>> req_autoneg to store user's configuration and it only be used after
>> hardware reset and to recover user's configuration
> Hi Peiyang Wang and Jijie Shao,
>
> In reviewing this patch it would be helpful if the diagram above could be
> related to driver code.  I'm sure it is obvious enough, but I'm having a
> bit of trouble.  F.e., is it hclge_tp_port_init() where "port info is
> configured with a temporary value cause the PHY is reset and looking for
> best link config." ?

Sorry, the description here is a bit confusing.
driver periodically updates port info. If only one reset occurs, driver
updates the port info based on the actual port info of the HW after
the reset is complete. However, When two resets occur consecutively,
If the port info of the HW is not updated in time before the second reset,
The driver may query a temporary info instead of the actual port info.
As a result, the actual port info is overwritten, Therefore, the port info
restored by the driver after the second reset is incorrect.

>> Fixes: f5f2b3e4dcc0 ("net: hns3: add support for imp-controlled PHYs")
>> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 15 +++++++++------
>>   .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h   |  3 +++
>>   2 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> index 6eda73f1e6ad..5dc8593c97be 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> @@ -1537,6 +1537,9 @@ static int hclge_configure(struct hclge_dev *hdev)
>>   			cfg.default_speed, ret);
>>   		return ret;
>>   	}
>> +	hdev->hw.mac.req_speed = hdev->hw.mac.speed;
>> +	hdev->hw.mac.req_autoneg = AUTONEG_ENABLE;
>> +	hdev->hw.mac.req_duplex = DUPLEX_FULL;
> I am curious to know why the initialisation of req_autoneg and req_duplex
> is not:
>
> 	hdev->hw.mac.req_autoneg = hdev->hw.mac.autoneg;
> 	hdev->hw.mac.req_duplex = hdev->hw.mac.duplex
>
> As it seems to me the value .autoneg is 0 (AUTONEG_DISABLE)
> and the value of .duplex is 0 (DUPLEX_HALF).

Yes, the value .autoneg is 0 and the value of .duplex is 0 here.
We hope that the network port is initialized in AUTONEG_ENABLE
and DUPLEX_FULL, so req_autoneg and req_duplex are fixed.

>
>>   	hclge_parse_link_mode(hdev, cfg.speed_ability);
>>   
>> @@ -3344,9 +3347,9 @@ hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
>>   		return ret;
>>   	}
>>   
>> -	hdev->hw.mac.autoneg = cmd->base.autoneg;
>> -	hdev->hw.mac.speed = cmd->base.speed;
>> -	hdev->hw.mac.duplex = cmd->base.duplex;
>> +	hdev->hw.mac.req_autoneg = cmd->base.autoneg;
>> +	hdev->hw.mac.req_speed = cmd->base.speed;
>> +	hdev->hw.mac.req_duplex = cmd->base.duplex;
>>   	linkmode_copy(hdev->hw.mac.advertising, cmd->link_modes.advertising);
>>   
>>   	return 0;
>> @@ -3364,9 +3367,9 @@ static int hclge_update_tp_port_info(struct hclge_dev *hdev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	hdev->hw.mac.autoneg = cmd.base.autoneg;
>> -	hdev->hw.mac.speed = cmd.base.speed;
>> -	hdev->hw.mac.duplex = cmd.base.duplex;
>> +	cmd.base.autoneg = hdev->hw.mac.req_autoneg;
>> +	cmd.base.speed = hdev->hw.mac.req_speed;
>> +	cmd.base.duplex = hdev->hw.mac.req_duplex;
> It is unclear to me why fields of cmd are set here, cmd is a local variable
> and they don't seem to be used for the rest of the function.

I'm so sorry, the code here is wrong.
I will fix it in next version of this patch

Thank you very much for your review.



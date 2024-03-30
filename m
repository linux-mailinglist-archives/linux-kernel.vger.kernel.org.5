Return-Path: <linux-kernel+bounces-125572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CAA8928E9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3403FB222D8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 02:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7381FA5;
	Sat, 30 Mar 2024 02:35:58 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B7E17CD;
	Sat, 30 Mar 2024 02:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711766158; cv=none; b=OFalO2thJQuPlVYlGf+pYC6ntr9FDJOzrrsqG1q9Zx1tew5xfV1ea+Bl3v8fU5vissgyStq6PALfgeEw8Q9RBdsbHZb0OV5zecCpBZkOrZKVe/m301JF8XxLNNsi4a2A1p1fQrPcSynDl6LPIBhPF5wzAx9u5WC/p8qzPNtqRgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711766158; c=relaxed/simple;
	bh=Z8aquzYwrhiTPT1lynRcdUTIL4sI4DuQGZPhxVeaKGg=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UnbFOcMoqLrzUoRW1fZsG6hxaeAjRFunznG/p/o8bnP9yKUl+JiXH65e3OSiir0ixmdEEOqh+HLniHcqIuQyrhZm7Ln/+82lsbQnVEe2gRgseZuJJek8HChugf9fu7w93Izx2cZRuM+qU/su8tJB62YOOLn5Wiu6XjVKcgajcDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V61Xl57Vzz29dPH;
	Sat, 30 Mar 2024 10:33:11 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 919B61400D3;
	Sat, 30 Mar 2024 10:35:53 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 30 Mar 2024 10:35:52 +0800
Message-ID: <b679e900-22e3-47c6-b9bb-7aba56efcf31@huawei.com>
Date: Sat, 30 Mar 2024 10:35:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<rkannoth@marvell.com>, <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 net-next 3/4] net: hns3: dump more reg info based on
 ras mod
To: Jakub Kicinski <kuba@kernel.org>
References: <20240327114330.1826631-1-shaojijie@huawei.com>
 <20240327114330.1826631-4-shaojijie@huawei.com>
 <20240328191130.47242c8f@kernel.org>
 <d6c779a5-e4b1-4f21-b4f0-6b37b212890f@huawei.com>
 <20240329081501.4460ad4d@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240329081501.4460ad4d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/3/29 23:15, Jakub Kicinski wrote:
> On Fri, 29 Mar 2024 18:34:02 +0800 Jijie Shao wrote:
>>> These seem to be duplicating standard stats from rtnl_link_stats64,
>>> ethtool_pause_stats, ethtool_eth_mac_stats, etc.
>>>
>>> You can add device specific stats, but please don't duplicate
>>> stats for which we have standard APIs.
>> Yeah, but these are not duplicate stats for ethtool or debugfs.
> Can you say more? I mean there are APIs to expose MIB counters.
> Perhaps your driver doesn't implement those APIs today.
> But (1) it should, and (2) once it does it will be a duplicate.

Sorry for the wrong reply before, these stats are already included
in the ethtool -S stats.

According to the suggestions provided by the chip, the statistics help
analyze the cause of the MAC-related abnormal interrupt.

>> Generally, driver will reset to restore the normal state.
>> After the reset, many registers are cleared. Therefore,
>> it is difficult to analyze the reason of RAS.
> Perhaps I'm missing the significance of the reset when it comes
> to counters reported via standard APIs. Are rtnl_link_stats64
> going to behave differently across a reset than these debug entries?
>
1. These statistics are the same as rtnl_link_stats64. However, these are not updated in real time.
    They are updated only when users query them or driver updates them every 5 minutes.
    However, these are cleared after the reset, which makes debugging difficult.
2. Currently, only a few MIB statistics are required, not all.
3. Are you suggesting that we use rtnl_link_stats64 to provide MIB statistics?

>> We wang to add this information only when RAS is occurring, And
>> these information will help to analyze the reason of RAS.
>>
>> these information does not appear in any new API.
>>
>> Therefore, we hope that we can add this information to
>> reduce the difficulty of analyzing certain issues.


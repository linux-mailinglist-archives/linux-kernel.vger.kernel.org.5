Return-Path: <linux-kernel+bounces-124393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55CF8916E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5691F244D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BC9657C6;
	Fri, 29 Mar 2024 10:34:15 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C7227471;
	Fri, 29 Mar 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708455; cv=none; b=nmAFwJ9UlLoobmhNT/p74Jb5I29Qn3dxh4gmGa1/biKyRvZQzJlKFboybhA+ruiY6aobMVJ+YRyTmwChOMc4CqTixwMZQDs/ochGnevTnMpb/6FJ1N0pkbQ/mxRkiAqYYuJkPtUR2N9az/v82FxP/Mg3oU+eWQN95WAexolPwbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708455; c=relaxed/simple;
	bh=KG92pe3DBAHh2WhqPReKxHjjE5aM10J77GB1apHyhss=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NbWkYSB8A+6h00DlhUxoaVl0BB4oZ1L96qrGuqdW7phonrMSuNC3NF57+uMPYLYB2anhUBYlFu32XAe75V/U1ZfWmPbA15Q5AURC73e9fCGqZCURhLknkmmylLCXAlFmLBIeXILGURCRb8o/BRmL6Phyoz6JweNm3oUUqJA5Wqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4V5cCh4rz0zNmlF;
	Fri, 29 Mar 2024 18:32:00 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id B3863140259;
	Fri, 29 Mar 2024 18:34:03 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 18:34:02 +0800
Message-ID: <d6c779a5-e4b1-4f21-b4f0-6b37b212890f@huawei.com>
Date: Fri, 29 Mar 2024 18:34:02 +0800
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
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240328191130.47242c8f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/3/29 10:11, Jakub Kicinski wrote:
> On Wed, 27 Mar 2024 19:43:29 +0800 Jijie Shao wrote:
>> +	}, {
>> +		.reg_name = "MIB_TX/RX_BAD_PKTS",
>> +		.reg_offset_group = {19, 18, 29, 28},
>> +		.group_size = 4
>> +	}, {
>> +		.reg_name = "MIB_TX/RX_GOOD_PKTS",
>> +		.reg_offset_group = {21, 20, 31, 30},
>> +		.group_size = 4
>> +	}, {
>> +		.reg_name = "MIB_TX/RX_TOTAL_PKTS",
>> +		.reg_offset_group = {23, 22, 33, 32},
>> +		.group_size = 4
>> +	}, {
>> +		.reg_name = "MIB_TX/RX_PAUSE_PKTS",
>> +		.reg_offset_group = {25, 24, 35, 34},
>> +		.group_size = 4
>> +	}, {
>> +		.reg_name = "MIB_TX_ERR_ALL_PKTS",
>> +		.reg_offset_group = {27, 26},
>> +		.group_size = 2
>> +	}, {
>> +		.reg_name = "MIB_RX_FCS_ERR_PKTS",
>> +		.reg_offset_group = {37, 36},
>> +		.group_size = 2
> These seem to be duplicating standard stats from rtnl_link_stats64,
> ethtool_pause_stats, ethtool_eth_mac_stats, etc.
>
> You can add device specific stats, but please don't duplicate
> stats for which we have standard APIs.

Yeah, but these are not duplicate stats for ethtool or debugfs.

Generally, driver will reset to restore the normal state.
After the reset, many registers are cleared. Therefore,
it is difficult to analyze the reason of RAS.

We wang to add this information only when RAS is occurring, And
these information will help to analyze the reason of RAS.

these information does not appear in any new API.

Therefore, we hope that we can add this information to
reduce the difficulty of analyzing certain issues.

Jijie



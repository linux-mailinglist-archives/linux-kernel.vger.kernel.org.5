Return-Path: <linux-kernel+bounces-125571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C400A8928E7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4591C210CF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 02:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D013D72;
	Sat, 30 Mar 2024 02:30:30 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833BAA23;
	Sat, 30 Mar 2024 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711765830; cv=none; b=AdmiDJNaC62JiQIcpudeV+q1EldsV5wM56FNl2Z/wX4eL8Czph1EVCslK+misTHJkNgIwF0ahlBOoCB+1q6aIj4nlV7ubC1ihdUul1eHX8n0gROJUgQKIVxsdvMKP41VRYiMTAPM8v9SV2LJNj52bqIx+R2fCv5/qvWrFD8rqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711765830; c=relaxed/simple;
	bh=FzYM06Gn4eXcMiYv8TDsNHGK5q7z2Q2fcZcDEpqm1vQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A+SpIEHd+Q1nUvxNhuX9m0asdAAI8vN4Hny3ilHVWsW5ICHBjkDMIuav3N3MlLkXJi2O58JLIXkw312ghmF7lSdYmYIsXjvF5WZMOLYrF4Xa0ieYIxC7gvc9ngmvETtIZQoyF9ec7h2p1dk0xzmrOKyJst7dIUmUb5I55F7KkqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V61QH5V2nz29dPk;
	Sat, 30 Mar 2024 10:27:35 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id A44D8140113;
	Sat, 30 Mar 2024 10:30:17 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 30 Mar 2024 10:30:16 +0800
Message-ID: <dc74b6fc-1edd-4532-b08a-a55a49c56fd8@huawei.com>
Date: Sat, 30 Mar 2024 10:30:16 +0800
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
Subject: Re: [PATCH V6 net-next 4/4] net: hns3: add support to query scc
 version by devlink info
To: Jakub Kicinski <kuba@kernel.org>
References: <20240327114330.1826631-1-shaojijie@huawei.com>
 <20240327114330.1826631-5-shaojijie@huawei.com>
 <20240328190714.16e3f86a@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240328190714.16e3f86a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/3/29 10:07, Jakub Kicinski wrote:
> On Wed, 27 Mar 2024 19:43:30 +0800 Jijie Shao wrote:
>> From: Hao Chen <chenhao418@huawei.com>
>>
>> Add support to query scc version by devlink info for device V3.
> What's SCC? Does none of the generic versions fit the bill?
> https://docs.kernel.org/next/networking/devlink/devlink-info.html#generic-versions

SCC means "soft congestion control", which is similar to fw.roce, but not exactly the same.
It is a firmware dedicated to providing congestion control for roce,

> If not you still have to document the meaning of this component
> in Documentation/networking/devlink/hns3.rst

OK, I will describe this inDocumentation/networking/devlink/hns3.rst



Return-Path: <linux-kernel+bounces-1930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C01815604
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5945A1F2564B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B012D1365;
	Sat, 16 Dec 2023 01:37:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0105923C9;
	Sat, 16 Dec 2023 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SsTF82M7Wz29dPr;
	Sat, 16 Dec 2023 09:35:56 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F5A11402CB;
	Sat, 16 Dec 2023 09:37:06 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 16 Dec 2023 09:37:05 +0800
Message-ID: <9ac4a3aa-602a-4bc9-aa73-c6896effefe3@huawei.com>
Date: Sat, 16 Dec 2023 09:37:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <shenjian15@huawei.com>,
	<wangjie125@huawei.com>, <liuyonglong@huawei.com>, <lanhao@huawei.com>,
	<wangpeiyang1@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net-next 2/3] net: hns3: dump more reg info based on
 ras mod
To: Simon Horman <horms@kernel.org>
References: <20231214141135.613485-1-shaojijie@huawei.com>
 <20231214141135.613485-3-shaojijie@huawei.com>
 <20231215080104.GV5817@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20231215080104.GV5817@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2023/12/15 16:01, Simon Horman wrote:
> On Thu, Dec 14, 2023 at 10:11:34PM +0800, Jijie Shao wrote:
>>   #include "hclge_main.h"
>> +#include "hclge_debugfs.h"
> Hi Jijie Shao and Peiyang Wang,
>
> hclge_debugfs.h defines a number of constants, such as hclge_dbg_tqp_reg.
>
> With the above include added, these constants are now also defined
> in files that include hclge_err.h. Which leads to them
> being defined but unused in hclge_main.c.
>
> At a glance, it seems that these constants are only used in hclge_debugfs.c.
> Perhaps they could simply be moved there?
>
Yeah, I also plan to move them to hclge_debugfs.c.
So I'm going to add a patch to the v3 patchset to move them

Thanks,
Jijie



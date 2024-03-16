Return-Path: <linux-kernel+bounces-105165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D907987D9E8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 12:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785C11F21A2C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C2817543;
	Sat, 16 Mar 2024 11:18:01 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E51798C;
	Sat, 16 Mar 2024 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710587881; cv=none; b=AWeUFzNGiiyAUxBCzTUfz+MXwsYu8mkOJHHKw7j1sRkeRaPpQLFp+Bo7wwz5gZGliAHrxgPazyoKQeX/qzmlw9iC76fpdpr+TdcgoBRBbmPlymN231RFqrSEUZILoFIPkDSSR8qBWQ737I4b3JZEEZ+w5tAHgjw7Peq4UrvB6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710587881; c=relaxed/simple;
	bh=iZsF+Z/oasKLf5xwtQCPgUvMR4ytrQBTDLN0o2cO25g=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QeUOATdQqIVXXnXcSlaV2J0V1oSfefdbC3nC/ilqLotq9CBp7ebU9lY7h/loPPrrRuTOANjltJ0tNvKCApWkGsPHP5T4MciYRu8bwvz9Iy9MUwNCYRAxleuG5Fo+V5p22r2iT130sX7CV0UJREXm/CmYTVNU5rj5EUIJKXVU20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Txdnq2gQMz1h1v6;
	Sat, 16 Mar 2024 19:15:27 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 19BC41A0172;
	Sat, 16 Mar 2024 19:17:57 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 16 Mar 2024 19:17:56 +0800
Message-ID: <5178c9fa-711a-4a91-ba1c-4b10da7592b3@huawei.com>
Date: Sat, 16 Mar 2024 19:17:55 +0800
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
	<wangjie125@huawei.com>, <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 3/3] net: hns3: mark unexcuted loopback test result as
 UNEXECUTED
To: Michal Kubiak <michal.kubiak@intel.com>
References: <20240315100748.2913882-1-shaojijie@huawei.com>
 <20240315100748.2913882-4-shaojijie@huawei.com>
 <ZfSOZG5vHbIY3IFU@localhost.localdomain>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <ZfSOZG5vHbIY3IFU@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/3/16 2:07, Michal Kubiak wrote:
> On Fri, Mar 15, 2024 at 06:07:48PM +0800, Jijie Shao wrote:
>> From: Jian Shen <shenjian15@huawei.com>
>>
>> Currently, loopback test maybe skipped when resetting, but the test
> typo: maybe skipped -> may be skipped
>
>> result will still show as 'PASS', because the driver doesn't set
>> ETH_TEST_FL_FAILED flag. Fixes it by set the flag and initialize the
>> value to be UNEXECUTED.
> Fix it by setting the flag and initializating the value to UNEXECUTED.
>
>
>> Fixes: 4c8dab1c709c ("net: hns3: reconstruct function hns3_self_test")
>> Signed-off-by: Jian Shen <shenjian15@huawei.com>

Thanks，

I have sent V2 to fix them.

Jijie



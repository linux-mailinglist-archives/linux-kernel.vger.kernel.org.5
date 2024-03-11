Return-Path: <linux-kernel+bounces-98653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD62877D71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0B61F22063
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7C8224F2;
	Mon, 11 Mar 2024 09:55:43 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177214298;
	Mon, 11 Mar 2024 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150943; cv=none; b=Qe5MENJPU2cPEi7L2x6yh5IB2cohRRwKru2EbpZ2zuyLV1FU9zMh8k65or682PzVCK6oNxG1zk+dUnsSTRcXWimOIO/6LNz1sBf93kiT2dhtiPiXanZUKi3/diZ+mxGZzxpi3YW3WW3e/VRoZOlRyhDz3ax+JhlQG+bTCyv0LK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150943; c=relaxed/simple;
	bh=/G1pRxVpybCCgbzIYw/qaSFDYYkjvbz6HGEWdab+gl8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QSBjK9ny9drztieMgz/pTV5sF+HRkTGkkT8Yr+Vm9Z/iv40rvT+4MbRkjlOzJWu5ehGa0EQdBvvKZa+wtNebQCsWCDvzZS57QcEsbu+sY4HjFENE4M607uSMfU2iDwoXCEPdbAlOYOO+rJhhktV0pmP7Hz+62HiIsCdT/p1K/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TtXFl63Hvz24j5C;
	Mon, 11 Mar 2024 17:55:23 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 52B56140155;
	Mon, 11 Mar 2024 17:55:37 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 17:55:36 +0800
Message-ID: <d9d10da3-5b13-4a48-9236-d29fdf48220e@huawei.com>
Date: Mon, 11 Mar 2024 17:55:36 +0800
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
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 4/4] net: hns3: add support to query scc
 version by devlink info
To: Simon Horman <horms@kernel.org>
References: <20240309100044.2351166-1-shaojijie@huawei.com>
 <20240309100044.2351166-5-shaojijie@huawei.com>
 <20240311091904.GA24043@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240311091904.GA24043@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/3/11 17:19, Simon Horman wrote:
>> +#define HNAE3_SCC_VERSION_BYTE1_SHIFT	8
>> +#define HNAE3_SCC_VERSION_BYTE1_MASK	GENMASK(15, 8)
>> +#define HNAE3_SCC_VERSION_BYTE0_SHIFT	0
>> +#define HNAE3_SCC_VERSION_BYTE0_MASK	GENMASK(7, 0)
> Not strictly related to this patch, but FWIIW, I suspect that
> hnae3_set_field() and hnae3_get_field() could be reworked to use / replaced
> by use of FIELD_PREP and FIELD_GET.  In which case I suspect that the
> *_SHIFT #defines would no longer be needed.

Yes, using FIELD_PREP and FIELD_GET is a better option.
But I'm not going to modify this patch.
If it's necessary, I will send a cleanup patch later to
replace all hnae3_set_field/hnae3_get_field in driver.



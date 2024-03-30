Return-Path: <linux-kernel+bounces-126266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75A0893476
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A411C226A5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A7A14A083;
	Sun, 31 Mar 2024 16:43:35 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A714A088;
	Sun, 31 Mar 2024 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903414; cv=fail; b=qGtDuvXI4zNcqqAmdwivkkumcJ29CShXeCWHfXs5/Yy/MXUvn5jmRRW/k4WxTlxuVPwI/0SxFkcKo+1GnIpMvLukaYQSKfgxxXOdEbSPefuxwl/NFT/eE9bN7dRf1+aM4lmFnbGAP7iQKxyJsMfsRWnH3xPTmZKNmtHq5xZaZtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903414; c=relaxed/simple;
	bh=25r24h4BMPt9MTlXxcBSHi4xdWXFz6yasW76u6U80X0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CKJuBdhGlgHmZHbk+jbOHYqfu+xPWqtsFEFJigdGEcT25eHlVsOXrdBpWVw4CHu7smoDBSGt4DnB2rdvC2cZXEhfWRyW0lkAmcAn0CED88RbUlZToyK/l3UBbmWyuPlpciibnJX/5MNDEKyNYg0be8V8BM5tSoqc7hxVhEyHf3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=fail smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=huawei.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 7EF612058E;
	Sun, 31 Mar 2024 18:43:30 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0RffJ19mU6xw; Sun, 31 Mar 2024 18:43:29 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 79CD0207C6;
	Sun, 31 Mar 2024 18:43:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 79CD0207C6
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 6BFD0800060;
	Sun, 31 Mar 2024 18:43:29 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:29 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:51 +0000
X-sender: <netdev+bounces-83488-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAPE+mlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 8858
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83488-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 752C820868
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711766158; cv=none; b=OFalO2thJQuPlVYlGf+pYC6ntr9FDJOzrrsqG1q9Zx1tew5xfV1ea+Bl3v8fU5vissgyStq6PALfgeEw8Q9RBdsbHZb0OV5zecCpBZkOrZKVe/m301JF8XxLNNsi4a2A1p1fQrPcSynDl6LPIBhPF5wzAx9u5WC/p8qzPNtqRgA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711766158; c=relaxed/simple;
	bh=Z8aquzYwrhiTPT1lynRcdUTIL4sI4DuQGZPhxVeaKGg=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UnbFOcMoqLrzUoRW1fZsG6hxaeAjRFunznG/p/o8bnP9yKUl+JiXH65e3OSiir0ixmdEEOqh+HLniHcqIuQyrhZm7Ln/+82lsbQnVEe2gRgseZuJJek8HChugf9fu7w93Izx2cZRuM+qU/su8tJB62YOOLn5Wiu6XjVKcgajcDc=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Message-ID: <b679e900-22e3-47c6-b9bb-7aba56efcf31@huawei.com>
Date: Sat, 30 Mar 2024 10:35:51 +0800
Precedence: bulk
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
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10


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

X-sender: <linux-kernel+bounces-125572-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAPk+mlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 8876
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 03:36:21 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Sat, 30 Mar 2024 03:36:21 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 66BD720897
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 03:36:21 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -0.751
X-Spam-Level:
X-Spam-Status: No, score=-0.751 tagged_above=-999 required=2.1
	tests=[HEADER_FROM_DIFFERENT_DOMAINS=0.249, MAILING_LIST_MULTI=-1,
	RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001]
	autolearn=unavailable autolearn_force=no
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JxteRk3fK-sp for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 03:36:20 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125572-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 5E4BD20868
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 5E4BD20868
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 03:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C9B8B22401
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 02:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6126E5250;
	Sat, 30 Mar 2024 02:35:59 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B7E17CD;
	Sat, 30 Mar 2024 02:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711766158; cv=none; b=OFalO2thJQuPlVYlGf+pYC6ntr9FDJOzrrsqG1q9Zx1tew5xfV1ea+Bl3v8fU5vissgyStq6PALfgeEw8Q9RBdsbHZb0OV5zecCpBZkOrZKVe/m301JF8XxLNNsi4a2A1p1fQrPcSynDl6LPIBhPF5wzAx9u5WC/p8qzPNtqRgA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711766158; c=relaxed/simple;
	bh=Z8aquzYwrhiTPT1lynRcdUTIL4sI4DuQGZPhxVeaKGg=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UnbFOcMoqLrzUoRW1fZsG6hxaeAjRFunznG/p/o8bnP9yKUl+JiXH65e3OSiir0ixmdEEOqh+HLniHcqIuQyrhZm7Ln/+82lsbQnVEe2gRgseZuJJek8HChugf9fu7w93Izx2cZRuM+qU/su8tJB62YOOLn5Wiu6XjVKcgajcDc=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
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
Return-Path: linux-kernel+bounces-125572-steffen.klassert=secunet.com@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 02:36:21.4350
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 126887fe-1e3b-446e-089f-08dc50622f8a
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.secunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=cas-essen-01.secunet.de:TOTAL-FE=0.011|SMR=0.010(SMRPI=0.008(SMRPI-FrontendProxyAgent=0.008));2024-03-30T02:36:21.446Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 8330
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=Low
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy


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


